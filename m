From: Zhongmiao <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
	register
Date: Tue, 24 Jul 2018 04:44:50 +0000
Message-ID: <8CD08B4737CACA4ABE0228F45E441A91638205A2@DGGEMM501-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Zhangshaokun <zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

DQpIaSwNCg0KT24gMjQvMDcvMTggMTI6NDUsIFpob25nbWlhbyB3cm90ZToNCj4gWWVhaCwgICAg
SSBoYXZlbid0IHRlc3RlZCBzbW11ICBldmVudHEgIG92ZXJmbG93ICwgIHNvIGknbSBub3Qgc3Vy
ZSBpZiB0aGVyZSBpcyBhbnkgcHJvYmxlbSB3aXRoIHNtbXUgZXZlbnRxLiAgSG93ZXZlciwgdGhl
IGNvZGUgc2hvd3MgdGhhdCB0aGVyZSBpcyBhbHNvIGEgcHJvYmxlbSBhZnRlciB0aGUgc21tdSBl
dmVudHEgb3ZlcmZsb3dzLiBeX17igKbigKYuDQoNCj5UaGVyZSByZWFsbHkgc2hvdWxkbid0IGJl
IGFueSBwcm9ibGVtIHdpdGggdGhlIGV2ZW50cS4gSGFuZGxpbmcgdGhlIGV2ZW50IG92ZXJmbG93
IGluIG15IHBhdGNoIGlzIG1vc3RseSBjb3NtZXRpYyBhbmQgY2FuIGJlIHJlbW92ZWQuIFNlZSB0
aGUgRXZlbnQgcXVldWUgb3ZlcmZsb3cgc2VjdGlvbiBvZiB0aGUgU01NVXYzIHNwZWNpZmljYXRp
b24gKElISTAwNzBCKToNCg0KPiJOb3RlOiBJbiB0ZXJtcyBvZiBkZWxpdmVyaW5nIGV2ZW50cywg
YSBxdWV1ZSBpbiBhbiB1bmFja25vd2xlZGdlZCBvdmVyZmxvdyBzdGF0ZSBkb2VzIG5vdCBiZWhh
dmUgYW55IGRpZmZlcmVudGx5IHRvIG5vcm1hbCBxdWV1ZSBzdGF0ZS4gSWYgc29mdHdhcmUgd2Vy
ZSB0byBjb25zdW1lIGV2ZW50cyBhbmQgZnJlZSBzcGFjZSBidXQgbGVhdmUgb3ZlcmZsb3cgdW5h
Y2tub3dsZWRnZWQsIG5ldyBldmVudHMgY291bGQgYmUgcmVjb3JkZWQuIg0KDQpJbiB0aGUgc21t
dSB2MyBwcm90b2NvbCAsICBUaGUgcHJvY2Vzc2luZyBvZiBQcmlxIG92ZXJmbG93IGlzIGRpZmZl
cmVudCBmcm9tIHRoYXQgb2YgRXZlbnRxLiANCg0KVGhhbmtzLA0KTWlhbw0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
