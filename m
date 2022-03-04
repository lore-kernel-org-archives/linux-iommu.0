Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6847AC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 04:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E35EA83366;
	Fri,  4 Mar 2022 04:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JyLXCxVnKqJG; Fri,  4 Mar 2022 04:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A386C83313;
	Fri,  4 Mar 2022 04:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7796AC001D;
	Fri,  4 Mar 2022 04:52:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACA21C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92525415DC
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EstwMivc3CI9 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 04:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C5E4409A3
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 04:52:44 +0000 (UTC)
X-UUID: a9fa9b595d30426180269d85e18dfcb4-20220304
X-UUID: a9fa9b595d30426180269d85e18dfcb4-20220304
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 200241363; Fri, 04 Mar 2022 12:52:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Fri, 4 Mar 2022 12:52:37 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Fri, 4 Mar 2022 12:52:36 +0800
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Subject: [PATCH] iommu/iova: Free all CPU rcache for retry when iova alloc
 failure
Date: Fri, 4 Mar 2022 12:46:34 +0800
Message-ID: <20220304044635.4273-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Cc: wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
 Yunfei Wang <yf.wang@mediatek.com>, stable@vger.kernel.org,
 Ning Li <Ning.Li@mediatek.com>
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
From: "yf.wang--- via iommu" <iommu@lists.linux-foundation.org>
Reply-To: yf.wang@mediatek.com
Content-Type: multipart/mixed; boundary="===============4022180605654451877=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4022180605654451877==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_001_818319673.1538494052"

--__=_Part_Boundary_001_818319673.1538494052
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PHByZT4NCkZyb206IFl1bmZlaSBXYW5nICZsdDt5Zi53YW5nQG1lZGlhdGVrLmNvbSZndDsNCg0K
SW4gYWxsb2NfaW92YV9mYXN0IGZ1bmN0aW9uLCBpZiBhbiBpb3ZhIGFsbG9jIHJlcXVlc3QgZmFp
bCwNCml0IHdpbGwgZnJlZSB0aGUgaW92YSByYW5nZXMgcHJlc2VudCBpbiB0aGUgcGVyY3B1IGlv
dmENCnJjYWNoZXMgYW5kIGZyZWUgZ2xvYmFsIGlvdmEgcmNhY2hlIGFuZCB0aGVuIHJldHJ5LCBi
dXQNCmZsdXNoaW5nIENQVSBpb3ZhIHJjYWNoZXMgb25seSBmb3IgZWFjaCBvbmxpbmUgQ1BVLCB3
aGljaA0Kd2lsbCBjYXVzZSBpbmNvbXBsZXRlIHJjYWNoZSBjbGVhbmluZywgYW5kIGlvdmEgcmNh
Y2hlcyBvZg0Kbm90IG9ubGluZSBDUFUgY2Fubm90IGJlIGZsdXNoZWQsIGJlY2F1c2UgaW92YSBy
Y2FjaGVzIG1heQ0KYWxzbyBsZWFkIHRvIGZyYWdtZW50YXRpb24gb2YgaW92YSBzcGFjZSwgc28g
dGhlIG5leHQgcmV0cnkNCmFjdGlvbiBtYXkgc3RpbGwgYmUgZmFpbC4NCg0KQmFzZWQgb24gdGhl
IGFib3ZlLCBzbyBuZWVkIHRvIGZsdXNoaW5nIGFsbCBpb3ZhIHJjYWNoZXMNCmZvciBlYWNoIHBv
c3NpYmxlIENQVSwgdXNlIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSBpbnN0ZWFkIG9mDQpmb3JfZWFj
aF9vbmxpbmVfY3B1IGxpa2UgaW4gZnJlZV9pb3ZhX3JjYWNoZXMgZnVuY3Rpb24sDQpzbyB0aGF0
IGFsbCByY2FjaGVzIGNhbiBiZSBjb21wbGV0ZWx5IHJlbGVhc2VkIHRvIHRyeQ0KcmVwbGVuaXNo
aW5nIElPVkFzLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgV2FuZyAmbHQ7eWYud2FuZ0BtZWRp
YXRlay5jb20mZ3Q7DQpDYzogJmx0O3N0YWJsZUB2Z2VyLmtlcm5lbC5vcmcmZ3Q7ICMgNS40LioN
Ci0tLQ0KIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9p
b3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYw0KaW5kZXggYjI4Yzk0MzViODk4Li41YTA2Mzdj
ZDdiYzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L2lvdmEuYw0KKysrIGIvZHJpdmVycy9p
b21tdS9pb3ZhLmMNCkBAIC00NjAsNyArNDYwLDcgQEAgYWxsb2NfaW92YV9mYXN0KHN0cnVjdCBp
b3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCiANCiAJCS8qIFRyeSByZXBs
ZW5pc2hpbmcgSU9WQXMgYnkgZmx1c2hpbmcgcmNhY2hlLiAqLw0KIAkJZmx1c2hfcmNhY2hlID0g
ZmFsc2U7DQotCQlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkNCisJCWZvcl9lYWNoX3Bvc3NpYmxl
X2NwdShjcHUpDQogCQkJZnJlZV9jcHVfY2FjaGVkX2lvdmFzKGNwdSwgaW92YWQpOw0KIAkJZnJl
ZV9nbG9iYWxfY2FjaGVkX2lvdmFzKGlvdmFkKTsNCiAJCWdvdG8gcmV0cnk7DQotLSANCjIuMTgu
MA0KPC9wcmU+PCEtLXR5cGU6dGV4dC0tPjwhLS17LS0+PHByZT4qKioqKioqKioqKioqIE1FRElB
VEVLIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNClRoZSBpbmZv
cm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSAN
CmF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdl
ZCwgb3Igb3RoZXJ3aXNlDQpleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUg
bGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgDQpjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25h
dGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgDQpkaXN0cmlidXRpb24s
IHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5n
IGl0cyANCmF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkIGFuZCBtYXkgDQpiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50
ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxpZXZlIA0KdGhhdCB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IA0KaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBh
bmQgYWxsIGNvcGllcyBvZiANCnRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRz
KSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90DQpkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0
aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo8L3ByZT48IS0tfS0t
Pg==

--__=_Part_Boundary_001_818319673.1538494052
Content-Type: text/plain
Content-Transfer-Encoding: base64

RnJvbTogWXVuZmVpIFdhbmcgPHlmLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpJbiBhbGxvY19pb3Zh
X2Zhc3QgZnVuY3Rpb24sIGlmIGFuIGlvdmEgYWxsb2MgcmVxdWVzdCBmYWlsLA0KaXQgd2lsbCBm
cmVlIHRoZSBpb3ZhIHJhbmdlcyBwcmVzZW50IGluIHRoZSBwZXJjcHUgaW92YQ0KcmNhY2hlcyBh
bmQgZnJlZSBnbG9iYWwgaW92YSByY2FjaGUgYW5kIHRoZW4gcmV0cnksIGJ1dA0KZmx1c2hpbmcg
Q1BVIGlvdmEgcmNhY2hlcyBvbmx5IGZvciBlYWNoIG9ubGluZSBDUFUsIHdoaWNoDQp3aWxsIGNh
dXNlIGluY29tcGxldGUgcmNhY2hlIGNsZWFuaW5nLCBhbmQgaW92YSByY2FjaGVzIG9mDQpub3Qg
b25saW5lIENQVSBjYW5ub3QgYmUgZmx1c2hlZCwgYmVjYXVzZSBpb3ZhIHJjYWNoZXMgbWF5DQph
bHNvIGxlYWQgdG8gZnJhZ21lbnRhdGlvbiBvZiBpb3ZhIHNwYWNlLCBzbyB0aGUgbmV4dCByZXRy
eQ0KYWN0aW9uIG1heSBzdGlsbCBiZSBmYWlsLg0KDQpCYXNlZCBvbiB0aGUgYWJvdmUsIHNvIG5l
ZWQgdG8gZmx1c2hpbmcgYWxsIGlvdmEgcmNhY2hlcw0KZm9yIGVhY2ggcG9zc2libGUgQ1BVLCB1
c2UgZm9yX2VhY2hfcG9zc2libGVfY3B1IGluc3RlYWQgb2YNCmZvcl9lYWNoX29ubGluZV9jcHUg
bGlrZSBpbiBmcmVlX2lvdmFfcmNhY2hlcyBmdW5jdGlvbiwNCnNvIHRoYXQgYWxsIHJjYWNoZXMg
Y2FuIGJlIGNvbXBsZXRlbHkgcmVsZWFzZWQgdG8gdHJ5DQpyZXBsZW5pc2hpbmcgSU9WQXMuDQoN
ClNpZ25lZC1vZmYtYnk6IFl1bmZlaSBXYW5nIDx5Zi53YW5nQG1lZGlhdGVrLmNvbT4NCkNjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA1LjQuKg0KLS0tDQogZHJpdmVycy9pb21tdS9pb3Zh
LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92
YS5jDQppbmRleCBiMjhjOTQzNWI4OTguLjVhMDYzN2NkN2JjMiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvaW9tbXUvaW92YS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYw0KQEAgLTQ2MCw3ICs0
NjAsNyBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWdu
ZWQgbG9uZyBzaXplLA0KIA0KIAkJLyogVHJ5IHJlcGxlbmlzaGluZyBJT1ZBcyBieSBmbHVzaGlu
ZyByY2FjaGUuICovDQogCQlmbHVzaF9yY2FjaGUgPSBmYWxzZTsNCi0JCWZvcl9lYWNoX29ubGlu
ZV9jcHUoY3B1KQ0KKwkJZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkNCiAJCQlmcmVlX2NwdV9j
YWNoZWRfaW92YXMoY3B1LCBpb3ZhZCk7DQogCQlmcmVlX2dsb2JhbF9jYWNoZWRfaW92YXMoaW92
YWQpOw0KIAkJZ290byByZXRyeTsNCi0tIA0KMi4xOC4w

--__=_Part_Boundary_001_818319673.1538494052--


--===============4022180605654451877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4022180605654451877==--

