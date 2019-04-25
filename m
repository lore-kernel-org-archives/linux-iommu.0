From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Date: Thu, 25 Apr 2019 07:12:02 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
 <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

SGkgRXJpYywNCg0KPiBGcm9tOiBBdWdlciBFcmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQu
Y29tXQ0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjUsIDIwMTkgMToyOCBBTQ0KPiBUbzogSmFj
b2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT47IGlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnOw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA5LzE5XSBpb21tdS92
dC1kOiBFbmxpZ2h0ZW5lZCBQQVNJRCBhbGxvY2F0aW9uDQo+IA0KPiBIaSBKYWNvYiwNCj4gDQo+
IE9uIDQvMjQvMTkgMTozMSBBTSwgSmFjb2IgUGFuIHdyb3RlOg0KPiA+IEZyb206IEx1IEJhb2x1
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4NCj4gPiBJZiBJbnRlbCBJT01NVSBydW5z
IGluIGNhY2hpbmcgbW9kZSwgYS5rLmEuIHZpcnR1YWwgSU9NTVUsIHRoZSBJT01NVQ0KPiA+IGRy
aXZlciBzaG91bGQgcmVseSBvbiB0aGUgZW11bGF0aW9uIHNvZnR3YXJlIHRvIGFsbG9jYXRlIGFu
ZCBmcmVlDQo+ID4gUEFTSUQgSURzLg0KPiBEbyB3ZSBtYWtlIHRoZSBkZWNpc2lvbiBkZXBlbmRp
bmcgb24gdGhlIENNIG9yIGRlcGVuZGluZyBvbiB0aGUgVkNDQVBfUkVHPw0KPiANCj4gVkNDQVBf
UkVHIGRlc2NyaXB0aW9uIHNheXM6DQo+IA0KPiBJZiBTZXQsIHNvZnR3YXJlIG11c3QgdXNlIFZp
cnR1YWwgQ29tbWFuZCBSZWdpc3RlciBpbnRlcmZhY2UgdG8gYWxsb2NhdGUgYW5kIGZyZWUNCj4g
UEFTSURzLg0KDQpUaGUgYW5zd2VyIGlzIGl0IGRlcGVuZHMgb24gdGhlIEVDQVAuVkNTIGFuZCB0
aGVuIHRoZSBQQVNJRCBhbGxvY2F0aW9uIGJpdCBpbg0KVkNDQVBfUkVHLiBCdXQgVkNTIGJpdCBp
bXBsaWVzIHRoZSBpb21tdSBpcyBhIHNvZnR3YXJlIGltcGxlbWVudGF0aW9uDQoodklPTU1VKSBv
ZiB2dC1kIGFyY2hpdGVjdHVyZS4gUGxzIHJlZmVyIHRvIHRoZSBkZXNjcmlwdGlvbnMgb2YgIlZp
cnR1YWwNCkNvbW1hbmQgU3VwcG9ydCIgaW4gdnQtZCAzLjAgc3BlYy4NCg0KIkhhcmR3YXJlIGlt
cGxlbWVudGF0aW9ucyBvZiB0aGlzIGFyY2hpdGVjdHVyZSByZXBvcnQgYSB2YWx1ZSBvZiAwDQpp
biB0aGlzIGZpZWxkLiBTb2Z0d2FyZSBpbXBsZW1lbnRhdGlvbnMgKGVtdWxhdGlvbikgb2YgdGhp
cw0KYXJjaGl0ZWN0dXJlIG1heSByZXBvcnQgVkNTPTEuIg0KDQpUaGFua3MsDQpZaSBMaXUNCg0K
