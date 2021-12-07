Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9203C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 04:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67DFA4039D;
	Tue,  7 Dec 2021 04:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7Fco6ZytdrN; Tue,  7 Dec 2021 04:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 065CA4051D;
	Tue,  7 Dec 2021 04:05:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADEB0C002F;
	Tue,  7 Dec 2021 04:05:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B92AC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05AF860E4A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGjRyOAWG10S for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:52:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5E0D60799
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:52:38 +0000 (UTC)
X-UUID: 104e544aab1f490e92bf1caecb5089d5-20211207
X-UUID: 104e544aab1f490e92bf1caecb5089d5-20211207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1479917465; Tue, 07 Dec 2021 10:52:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 7 Dec 2021 10:52:31 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 7 Dec 2021 10:52:30 +0800
From: <yf.wang@mediatek.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, open list
 <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Add error handle for page table
 allocation failure
Date: Tue, 7 Dec 2021 10:47:22 +0800
Message-ID: <20211207024723.25751-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 07 Dec 2021 04:05:01 +0000
Cc: Yunfei Wang <yf.wang@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
 wsd_upstream@mediatek.com, Guangming Cao <Guangming.Cao@mediatek.com>
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
Content-Type: multipart/mixed; boundary="===============3297426762876162488=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3297426762876162488==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_001_557018625.2012304799"

--__=_Part_Boundary_001_557018625.2012304799
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
YWdlIHRhYmxlIGFsbG9jYXRpb24gZmFpbHVyZS4NCg0KU2lnbmVkLW9mZi1ieTogWXVuZmVpIFdh
bmcgJmx0O3lmLndhbmdAbWVkaWF0ZWsuY29tJmd0Ow0KLS0tDQogZHJpdmVycy9pb21tdS9pby1w
Z3RhYmxlLWFybS12N3MuYyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyBi
L2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCmluZGV4IGJmYjZhY2I2NTFlNS4u
ZDg0MjQwMzA4ZjRiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12
N3MuYw0KKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KQEAgLTI0Niw2
ICsyNDYsMTIgQEAgc3RhdGljIHZvaWQgKl9fYXJtX3Y3c19hbGxvY190YWJsZShpbnQgbHZsLCBn
ZnBfdCBnZnAsDQogCQkJX19HRlBfWkVSTyB8IEFSTV9WN1NfVEFCTEVfR0ZQX0RNQSwgZ2V0X29y
ZGVyKHNpemUpKTsNCiAJZWxzZSBpZiAobHZsID09IDIpDQogCQl0YWJsZSA9IGttZW1fY2FjaGVf
emFsbG9jKGRhdGEtJmd0O2wyX3RhYmxlcywgZ2ZwKTsNCisNCisJaWYgKCF0YWJsZSkgew0KKwkJ
ZGV2X2VycihkZXYsICZxdW90O1BhZ2UgdGFibGUgYWxsb2NhdGlvbiBmYWlsdXJlIGx2bDolZFxu
JnF1b3Q7LCBsdmwpOw0KKwkJcmV0dXJuIE5VTEw7DQorCX0NCisNCiAJcGh5cyA9IHZpcnRfdG9f
cGh5cyh0YWJsZSk7DQogCWlmIChwaHlzICE9IChhcm1fdjdzX2lvcHRlKXBoeXMpIHsNCiAJCS8q
IERvZXNuJiMzOTt0IGZpdCBpbiBQVEUgKi8NCi0tIA0KMi4xOC4wDQoNCjwvcHJlPjwhLS10eXBl
OnRleHQtLT48IS0tey0tPjxwcmU+KioqKioqKioqKioqKiBNRURJQVRFSyBDb25maWRlbnRpYWxp
dHkgTm90aWNlDQogKioqKioqKioqKioqKioqKioqKioNClRoZSBpbmZvcm1hdGlvbiBjb250YWlu
ZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSANCmF0dGFjaG1lbnRzKSBt
YXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNl
DQpleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50
ZW5kZWQgdG8gYmUgDQpjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChz
KS4gQW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgDQpkaXN0cmlidXRpb24sIHByaW50aW5nLCByZXRh
aW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0cyANCmF0dGFjaG1l
bnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFu
ZCBtYXkgDQpiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50
IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxpZXZlDQogDQp0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRo
aXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgDQppbW1lZGlhdGVs
eSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVz
IG9mIA0KdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBz
eXN0ZW0sIGFuZCBkbyBub3QNCmRpc2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRv
IGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCjwvcHJlPjwhLS19LS0+

--__=_Part_Boundary_001_557018625.2012304799
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
b2NhdGlvbiBmYWlsdXJlLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgV2FuZyA8eWYud2FuZ0Bt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jIHwg
NiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jIGIvZHJpdmVycy9pb21tdS9pby1w
Z3RhYmxlLWFybS12N3MuYw0KaW5kZXggYmZiNmFjYjY1MWU1Li5kODQyNDAzMDhmNGIgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQorKysgYi9kcml2ZXJz
L2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQpAQCAtMjQ2LDYgKzI0NiwxMiBAQCBzdGF0aWMg
dm9pZCAqX19hcm1fdjdzX2FsbG9jX3RhYmxlKGludCBsdmwsIGdmcF90IGdmcCwNCiAJCQlfX0dG
UF9aRVJPIHwgQVJNX1Y3U19UQUJMRV9HRlBfRE1BLCBnZXRfb3JkZXIoc2l6ZSkpOw0KIAllbHNl
IGlmIChsdmwgPT0gMikNCiAJCXRhYmxlID0ga21lbV9jYWNoZV96YWxsb2MoZGF0YS0+bDJfdGFi
bGVzLCBnZnApOw0KKw0KKwlpZiAoIXRhYmxlKSB7DQorCQlkZXZfZXJyKGRldiwgIlBhZ2UgdGFi
bGUgYWxsb2NhdGlvbiBmYWlsdXJlIGx2bDolZFxuIiwgbHZsKTsNCisJCXJldHVybiBOVUxMOw0K
Kwl9DQorDQogCXBoeXMgPSB2aXJ0X3RvX3BoeXModGFibGUpOw0KIAlpZiAocGh5cyAhPSAoYXJt
X3Y3c19pb3B0ZSlwaHlzKSB7DQogCQkvKiBEb2Vzbid0IGZpdCBpbiBQVEUgKi8NCi0tIA0KMi4x
OC4wDQo=

--__=_Part_Boundary_001_557018625.2012304799--


--===============3297426762876162488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3297426762876162488==--

