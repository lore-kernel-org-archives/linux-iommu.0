From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 11/13] drm/amdgpu: add DRM_AMDGPU_ATC config option
Date: Wed, 31 Jan 2018 13:15:33 +0000
Message-ID: <13143246-5f7c-b873-c159-f27342362aaa@arm.com>
References: <20180126201326.8829-1-christian.koenig@amd.com>
	<20180126201326.8829-11-christian.koenig@amd.com>
	<6cf4bd37-fbf1-1fb4-496a-d62e403aea6f@amd.com>
	<7ebabb2b-1b18-8c7b-626f-d6874bdaac80@gmail.com>
	<c39b444b-49a1-771a-65ba-ae37ba643673@amd.com>
	<CAFCwf12ho2gXrBUHtaKRV-mX2kRk45xeu2o=F0-=Q+GFkAs=RA@mail.gmail.com>
	<6b19483a-79f3-e5e0-307f-ead73b4e2b7a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6b19483a-79f3-e5e0-307f-ead73b4e2b7a-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SGkgQ2hyaXN0aWFuLAoKT24gMzEvMDEvMTggMTM6MDQsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4gQWRkaW5nIEplYW4gYW5kIHRoZSBJT01NVSBsaXN0IGFzIHdlbGwuCj4gCj4gQW0gMzEuMDEu
MjAxOCB1bSAxMzo0MyBzY2hyaWViIE9kZWQgR2FiYmF5Ogo+PiBPbiBUdWUsIEphbiAzMCwgMjAx
OCBhdCA2OjUzIFBNLCBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4gd3Jv
dGU6Cj4+PiBbU05JUF0KPj4gVGhlcmUgd2FzIHNvbWUgZGlzY3Vzc2lvbiBsYXN0IHllYXIgYWJv
dXQgYSBnZW5lcmljIFBBU0lEIGFsbG9jYXRvciBpbgo+PiB0aGUgaW9tbXUgc3Vic3lzdGVtOgo+
PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvcGlwZXJtYWlsL2lvbW11LzIwMTct
SnVuZS8wMjIxNTkuaHRtbAo+Pgo+PiBVbmZvcnR1bmF0ZWx5LCBJIGRvbid0IHRoaW5rIGl0IGdv
dCBhbnkgZnVydGhlciB0aGVuIHRoYXQuCgpJIGFsc28gc2VudCBhbiBSRkN2MiBpbiBPY3RvYmVy
OgpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzYwOTc3MS5odG1s
Cgo+IFllYWgsIHRoYXQgc291bmRzIGV4YWN0bHkgbGlrZSB3aGF0IEkgaGFkIGluIG1pbmQgYXMg
d2VsbC4KPiAKPiBKZWFuIGFueSB1cGRhdGVzIG9uIHRoYXQgdG9waWM/IFdlIGFyZSByYXRoZXIg
aW50ZXJlc3RlZCBpbiBjb21tb24gUEFTSUQgCj4gaGFuZGxpbmcgYXMgd2VsbC4KCkdvb2QgdG8g
aGVhciwgSSBwbGFuIHRvIHNlbmQgYSBuZXcgdmVyc2lvbiBvZiB0aGF0IHNlcmllcyBhZnRlciB0
aGUgbWVyZ2UKd2luZG93LgoKVGhhbmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
