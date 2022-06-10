const request = require('supertest');
const assert = require('assert');
const { app, server } = require('./index.js')

afterAll(() => {
    return server.close();
  });

it("Put's the lotion on the skin", async () => {
    await request(app)
    .get('/')
    .expect(200)
})