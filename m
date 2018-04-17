From: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Tue, 17 Apr 2018 00:52:29 +0000
Message-ID: <1523926423.2747.19.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152302067362.47565.628887796165116844.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
Content-Language: en-US
Content-ID: <B5DC3B183190CD4097E64C96E61F3ED1-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "gary.hook-5C7GfCeVMHo@public.gmane.org" <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gRnJpLCAyMDE4LTA0LTA2IGF0IDA4OjE3IC0wNTAwLCBHYXJ5IFIgSG9vayB3cm90ZToNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L01ha2VmaWxlIGIvZHJpdmVycy9pb21tdS9N
YWtlZmlsZQ0KPiBpbmRleCA1ZWIxMTIxZDU0YjkuLjBjYTI1MGY2MjZkOSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pb21tdS9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2lvbW11L01ha2VmaWxl
DQo+IEBAIC0xMSw2ICsxMSw3IEBAIG9iai0kKENPTkZJR19JT01NVV9JT1ZBKSArPSBpb3ZhLm8N
Cj4gwqBvYmotJChDT05GSUdfT0ZfSU9NTVUpwqArPSBvZl9pb21tdS5vDQo+IMKgb2JqLSQoQ09O
RklHX01TTV9JT01NVSkgKz0gbXNtX2lvbW11Lm8NCj4gwqBvYmotJChDT05GSUdfQU1EX0lPTU1V
KSArPSBhbWRfaW9tbXUubyBhbWRfaW9tbXVfaW5pdC5vDQo+ICtvYmotJChDT05GSUdfSU9NTVVf
REVCVUcpICs9IGFtZF9pb21tdV9kZWJ1Z2ZzLm8NCg0KQ29tcGlsaW5nIGFtZF9pb21tdV9kZWJ1
Z2ZzLmMgc2VlbXMgdG8gZGVwZW5kIG9ubHkNCm9uwqBDT05GSUdfSU9NTVVfREVCVUcuIENhbiB3
ZSBwcmV2ZW50IHRoZSBjb2RlIHdpdGhpbg0KYW1kX2lvbW11X2RlYnVnZnMuYyBmcm9tIGdldHRp
bmcgY29tcGlsZWQgd2hlbiBlaXRoZXIgQ09ORklHX0FNRF9JT01NVQ0Kb3IgQ09ORklHX0lPTU1V
X0RFQlVHIGlzIGRpc2FibGVkPw0KDQo+IMKgb2JqLSQoQ09ORklHX0FNRF9JT01NVV9WMikgKz0g
YW1kX2lvbW11X3YyLm8NCj4gwqBvYmotJChDT05GSUdfQVJNX1NNTVUpICs9IGFybS1zbW11Lm8N
Cj4gwqBvYmotJChDT05GSUdfQVJNX1NNTVVfVjMpICs9IGFybS1zbW11LXYzLm8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
