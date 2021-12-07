Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFDBC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 04:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF86384BAF;
	Tue,  7 Dec 2021 04:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mzvo2P7tXBla; Tue,  7 Dec 2021 04:36:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7036B84B74;
	Tue,  7 Dec 2021 04:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F488C001E;
	Tue,  7 Dec 2021 04:36:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A5EC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 04:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E40C941C27
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 04:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvkOq5DUsPWF for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 04:36:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BEF5A41C24
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 04:36:34 +0000 (UTC)
X-UUID: d6245042be1e404a95d23e2807e35f31-20211207
X-UUID: d6245042be1e404a95d23e2807e35f31-20211207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1939152083; Tue, 07 Dec 2021 12:36:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 7 Dec 2021 12:36:25 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 7 Dec 2021 12:36:24 +0800
From: <yf.wang@mediatek.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "moderated list:ARM SMMU
 DRIVERS" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] iommu/io-pgtable-arm-v7s: Add error handle for page table
 allocation failure
Date: Tue, 7 Dec 2021 12:31:14 +0800
Message-ID: <20211207043116.27319-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Cc: Guangming Cao <Guangming.Cao@mediatek.com>, wsd_upstream@mediatek.com,
 Yunfei Wang <yf.wang@mediatek.com>, stable@vger.kernel.org,
 Libo Kang <Libo.Kang@mediatek.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7879234649017424534=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7879234649017424534==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_002_284424910.478323264"

--__=_Part_Boundary_002_284424910.478323264
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PHByZT4NCkZyb206IFl1bmZlaSBXYW5nICZsdDt5Zi53YW5nQG1lZGlhdGVrLmNvbSZndDsNCg0K
SW4gX19hcm1fdjdzX2FsbG9jX3RhYmxlIGZ1bmN0aW9uOg0KaW9tbXUgY2FsbCBrbWVtX2NhY2hl
X2FsbG9jIHRvIGFsbG9jYXRlIHBhZ2UgdGFibGUsIHRoaXMgZnVuY3Rpb24NCmFsbG9jYXRlIG1l
bW9yeSBtYXkgZmFpbCwgd2hlbiBrbWVtX2NhY2hlX2FsbG9jIGZhaWxzIHRvIGFsbG9jYXRlDQp0
YWJsZSwgY2FsbCB2aXJ0X3RvX3BoeXMgd2lsbCBiZSBhYm5vbWFsIGFuZCByZXR1cm4gdW5leHBl
Y3RlZCBwaHlzDQphbmQgZ290byBvdXRfZnJlZSwgdGhlbiBjYWxsIGttZW1fY2FjaGVfZnJlZSB0
byByZWxlYXNlIHRhYmxlIHdpbGwNCnRyaWdnZXIgS0UsIF9fZ2V0X2ZyZWVfcGFnZXMgYW5kIGZy
ZWVfcGFnZXMgaGF2ZSBzaW1pbGFyIHByb2JsZW0sDQpzbyBhZGQgZXJyb3IgaGFuZGxlIGZvciBw
YWdlIHRhYmxlIGFsbG9jYXRpb24gZmFpbHVyZS4NCg0KRml4ZXM6IDI5ODU5YWViOGE2ZWEgKCZx
dW90O2lvbW11L2lvLXBndGFibGUtYXJtLXY3czogQWJvcnQgYWxsb2NhdGlvbiB3aGVuIHRhYmxl
IGFkZHJlc3Mgb3ZlcmZsb3dzIHRoZSBQVEUmcXVvdDspDQpTaWduZWQtb2ZmLWJ5OiBZdW5mZWkg
V2FuZyAmbHQ7eWYud2FuZ0BtZWRpYXRlay5jb20mZ3Q7DQpDYzogJmx0O3N0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcmZ3Q7ICMgNS4xMC4qDQotLS0NClYyOiBDYyBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQogICAgMS4gVGhpcyBwYXRjaCBuZWVkcyB0byBiZSBtZXJnZWQgc3RhYmxlIGJyYW5jaCwgYWRk
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCiAgICAgICBpbiBtYWlsIGxpc3QuDQogICAgMi4gVGhl
cmUgaXMgTm8gbmV3IGNvZGUgY2hhbmdlIGluIFYyLg0KDQotLS0NCiBkcml2ZXJzL2lvbW11L2lv
LXBndGFibGUtYXJtLXY3cy5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5j
IGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KaW5kZXggYmZiNmFjYjY1MWU1
Li5kODQyNDAzMDhmNGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJt
LXY3cy5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQpAQCAtMjQ2
LDYgKzI0NiwxMiBAQCBzdGF0aWMgdm9pZCAqX19hcm1fdjdzX2FsbG9jX3RhYmxlKGludCBsdmws
IGdmcF90IGdmcCwNCiAJCQlfX0dGUF9aRVJPIHwgQVJNX1Y3U19UQUJMRV9HRlBfRE1BLCBnZXRf
b3JkZXIoc2l6ZSkpOw0KIAllbHNlIGlmIChsdmwgPT0gMikNCiAJCXRhYmxlID0ga21lbV9jYWNo
ZV96YWxsb2MoZGF0YS0mZ3Q7bDJfdGFibGVzLCBnZnApOw0KKw0KKwlpZiAoIXRhYmxlKSB7DQor
CQlkZXZfZXJyKGRldiwgJnF1b3Q7UGFnZSB0YWJsZSBhbGxvY2F0aW9uIGZhaWx1cmUgbHZsOiVk
XG4mcXVvdDssIGx2bCk7DQorCQlyZXR1cm4gTlVMTDsNCisJfQ0KKw0KIAlwaHlzID0gdmlydF90
b19waHlzKHRhYmxlKTsNCiAJaWYgKHBoeXMgIT0gKGFybV92N3NfaW9wdGUpcGh5cykgew0KIAkJ
LyogRG9lc24mIzM5O3QgZml0IGluIFBURSAqLw0KLS0gDQoyLjE4LjANCg0KPC9wcmU+PCEtLXR5
cGU6dGV4dC0tPjwhLS17LS0+PHByZT4qKioqKioqKioqKioqIE1FRElBVEVLIENvbmZpZGVudGlh
bGl0eSBOb3RpY2UNCiAqKioqKioqKioqKioqKioqKioqKg0KVGhlIGluZm9ybWF0aW9uIGNvbnRh
aW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IA0KYXR0YWNobWVudHMp
IG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBvciBvdGhlcndp
c2UNCmV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBp
bnRlbmRlZCB0byBiZSANCmNvbnZleWVkIG9ubHkgdG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50
KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCANCmRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJl
dGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIA0KYXR0YWNo
bWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQg
YW5kIG1heSANCmJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGll
bnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUNCiANCnRoYXQgeW91IGhhdmUgcmVjZWl2ZWQg
dGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciANCmltbWVkaWF0
ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3Bp
ZXMgb2YgDQp0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3Vy
IHN5c3RlbSwgYW5kIGRvIG5vdA0KZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwg
dG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KPC9wcmU+PCEtLX0tLT4=

--__=_Part_Boundary_002_284424910.478323264
Content-Type: text/plain
Content-Transfer-Encoding: base64

RnJvbTogWXVuZmVpIFdhbmcgPHlmLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpJbiBfX2FybV92N3Nf
YWxsb2NfdGFibGUgZnVuY3Rpb246DQppb21tdSBjYWxsIGttZW1fY2FjaGVfYWxsb2MgdG8gYWxs
b2NhdGUgcGFnZSB0YWJsZSwgdGhpcyBmdW5jdGlvbg0KYWxsb2NhdGUgbWVtb3J5IG1heSBmYWls
LCB3aGVuIGttZW1fY2FjaGVfYWxsb2MgZmFpbHMgdG8gYWxsb2NhdGUNCnRhYmxlLCBjYWxsIHZp
cnRfdG9fcGh5cyB3aWxsIGJlIGFibm9tYWwgYW5kIHJldHVybiB1bmV4cGVjdGVkIHBoeXMNCmFu
ZCBnb3RvIG91dF9mcmVlLCB0aGVuIGNhbGwga21lbV9jYWNoZV9mcmVlIHRvIHJlbGVhc2UgdGFi
bGUgd2lsbA0KdHJpZ2dlciBLRSwgX19nZXRfZnJlZV9wYWdlcyBhbmQgZnJlZV9wYWdlcyBoYXZl
IHNpbWlsYXIgcHJvYmxlbSwNCnNvIGFkZCBlcnJvciBoYW5kbGUgZm9yIHBhZ2UgdGFibGUgYWxs
b2NhdGlvbiBmYWlsdXJlLg0KDQpGaXhlczogMjk4NTlhZWI4YTZlYSAoImlvbW11L2lvLXBndGFi
bGUtYXJtLXY3czogQWJvcnQgYWxsb2NhdGlvbiB3aGVuIHRhYmxlIGFkZHJlc3Mgb3ZlcmZsb3dz
IHRoZSBQVEUiKQ0KU2lnbmVkLW9mZi1ieTogWXVuZmVpIFdhbmcgPHlmLndhbmdAbWVkaWF0ZWsu
Y29tPg0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUuMTAuKg0KLS0tDQpWMjogQ2Mg
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KICAgIDEuIFRoaXMgcGF0Y2ggbmVlZHMgdG8gYmUgbWVy
Z2VkIHN0YWJsZSBicmFuY2gsIGFkZCBzdGFibGVAdmdlci5rZXJuZWwub3JnDQogICAgICAgaW4g
bWFpbCBsaXN0Lg0KICAgIDIuIFRoZXJlIGlzIE5vIG5ldyBjb2RlIGNoYW5nZSBpbiBWMi4NCg0K
LS0tDQogZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyB8IDYgKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pby1wZ3RhYmxlLWFybS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdz
LmMNCmluZGV4IGJmYjZhY2I2NTFlNS4uZDg0MjQwMzA4ZjRiIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3Rh
YmxlLWFybS12N3MuYw0KQEAgLTI0Niw2ICsyNDYsMTIgQEAgc3RhdGljIHZvaWQgKl9fYXJtX3Y3
c19hbGxvY190YWJsZShpbnQgbHZsLCBnZnBfdCBnZnAsDQogCQkJX19HRlBfWkVSTyB8IEFSTV9W
N1NfVEFCTEVfR0ZQX0RNQSwgZ2V0X29yZGVyKHNpemUpKTsNCiAJZWxzZSBpZiAobHZsID09IDIp
DQogCQl0YWJsZSA9IGttZW1fY2FjaGVfemFsbG9jKGRhdGEtPmwyX3RhYmxlcywgZ2ZwKTsNCisN
CisJaWYgKCF0YWJsZSkgew0KKwkJZGV2X2VycihkZXYsICJQYWdlIHRhYmxlIGFsbG9jYXRpb24g
ZmFpbHVyZSBsdmw6JWRcbiIsIGx2bCk7DQorCQlyZXR1cm4gTlVMTDsNCisJfQ0KKw0KIAlwaHlz
ID0gdmlydF90b19waHlzKHRhYmxlKTsNCiAJaWYgKHBoeXMgIT0gKGFybV92N3NfaW9wdGUpcGh5
cykgew0KIAkJLyogRG9lc24ndCBmaXQgaW4gUFRFICovDQotLSANCjIuMTguMA0K

--__=_Part_Boundary_002_284424910.478323264--


--===============7879234649017424534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7879234649017424534==--

