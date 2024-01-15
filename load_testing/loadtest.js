// Import necessary modules
import encoding from "k6/encoding";
import { Trend } from "k6/metrics";
import { check, group, sleep } from "k6";
import http from "k6/http";

//define configuration
export const options = {
  //define thresholds
  thresholds: {
    // http_req_failed: [{ threshold: 'rate<0.01', abortOnFail: true, delayAbortEval: '10s' }], // http errors should be less than 1%, otherwise abort the test
    // http_req_duration: ['p(90)<1000'], // 90% of requests should be below 1s
    // http_reqs: ['rate>=100'] // 100 req/s min throughput
  },
  scenarios: {
    // constant_vus_20: {
    //   executor: 'constant-vus',
    //   vus: 20,
    //   duration: '30s',
    // }
    average_load: {
      executor: "ramping-vus",
      stages: [{ duration: __ENV.RAMP_UP_TIME, target: __ENV.VUSERS }],
    },
  },
};

const formTrendCheck = new Trend("endpoint_get_form");
const resultsTrendCheck = new Trend("endpoint_post_results");

// set baseURL
const baseUrl = __ENV.BASE_URL;

// basic auth
const username = __ENV.HTTP_USERNAME;
const password = __ENV.HTTP_PASSWORD;
const credentials = `${username}:${password}`;
const encodedCredentials = encoding.b64encode(credentials);

// test params
const params = {
  headers: {
    Authorization: `Basic ${encodedCredentials}`,
    "Content-Type": "application/json",
    "Accept-Encoding": "gzip, deflate, br",
  },
};

// test payload
const payload = JSON.stringify({
  calculation_form: {
    area_id: "inner_london",
    pay_band_id: "unq1",
  },
});

export default function () {
  // Calculation flow
  group("Calculation flow", function () {
    // form page
    let response = http.get(`${baseUrl}/`, params);
    formTrendCheck.add(response.timings.duration);
    runChecks(response);
    // sleep(5);

    // results page
    response = http.post(`${baseUrl}/results`, payload, params);
    resultsTrendCheck.add(response.timings.duration);
    runChecks(response);
    // sleep(1);
  });
}

function runChecks(res) {
  check(res, {
    "has status 200": (r) => r.status === 200,
  });
  check(res, {
    "uses gzip encoding": (r) => r.headers["Content-Encoding"] === "gzip",
  });
}
