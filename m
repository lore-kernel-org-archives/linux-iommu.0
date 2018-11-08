From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
	descriptor support
Date: Thu, 8 Nov 2018 05:48:37 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D60599@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
	<20181105053151.7173-5-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
	<a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
	<915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

PiBGcm9tOiBMaXUsIFlpIEwNCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDgsIDIwMTggMTo0
NSBQTQ0KPiA+ID4+Pj4gKwkJCW1lbWNweShkZXNjLCBxaS0+ZGVzYyArICh3YWl0X2luZGV4IDw8
IHNoaWZ0KSwNCj4gPiA+Pj4NCj4gPiA+Pj4gV291bGQgIm1lbWNweShkZXNjLCAodW5zaWduZWQg
bG9uZyBsb25nKSAocWktPmRlc2MgKyAgKHdhaXRfaW5kZXgNCj4gPiA+Pj4gPDwgc2hpZnQpLCIg
YmUgbW9yZSBzYWZlPw0KPiA+ID4+DQo+ID4gPj4gQ2FuIHRoYXQgYmUgY29tcGlsZWQ/IG1lbWNw
eSgpIHJlcXVpcmVzIGEgImNvbnN0IHZvaWQgKiIgZm9yIHRoZQ0KPiA+ID4+IHNlY29uZA0KPiA+
IHBhcmFtZXRlci4NCj4gPiA+PiBCeSB0aGUgd2F5LCB3aHkgaXQncyBzYWZlciB3aXRoIHRoaXMg
Y2FzdGluZz8NCj4gPiA+DQo+ID4gPiBUaGlzIGlzIGp1c3QgYW4gZXhhbXBsZS4gTXkgcG9pbnQg
aXMgdGhlIHBvc3NpYmlsaXR5IHRoYXQgInFpLT5kZXNjDQo+ID4gPiArICh3YWl0X2luZGV4IDw8
DQo+ID4gc2hpZnQpIg0KPiA+ID4gd291bGQgYmUgdHJlYXRlZCBhcyAicWktPmRlc2MgcGx1cyAo
d2FpdF9pbmRleCA8PA0KPiA+ID4gc2hpZnQpKnNpemVvZigqcWktPmRlc2MpIi4gSXMgaXQgcG9z
c2libGUgZm9yIGtlcm5lbCBidWlsZD8NCj4gPg0KPiA+IHFpLT5kZXNjIGlzIG9mIHR5cGUgb2Yg
InZvaWQgKiIuDQo+IA0KPiBubywgSSBkb27igJl0IHRoaW5rIHNvLi4uIFJlZmVyIHRvIHRoZSBj
b2RlIGJlbG93LiBFdmVuIGl0IGhhcyBubyBjb3JyZWN0bmVzcyBpc3N1ZSBoZXIsDQo+IEl0J3Mg
bm90IGR1ZSB0byBxaS0+ZGVzYyBpcyAidm9pZCAqIiB0eXBlLi4uDQo+IA0KPiBzdHJ1Y3QgcWlf
ZGVzYyB7DQo+IC0JdTY0IGxvdywgaGlnaDsNCj4gKwl1NjQgcXcwOw0KPiArCXU2NCBxdzE7DQo+
ICsJdTY0IHF3MjsNCj4gKwl1NjQgcXczOw0KPiB9Ow0KDQpPb3BzLCBqdXN0IHNlZSB5b3UgbW9k
aWZpZWQgaXQgdG8gYmUgInZvaWQgKiIgaW4gdGhpcyBwYXRjaC4gT2ssIHRoZW4gdGhpcyBpcyBm
YWlyIGVub3VnaC4NCg0KVGhhbmtzLA0KWWkgTGl1DQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
