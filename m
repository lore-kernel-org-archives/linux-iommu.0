Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA1BC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82317403FD;
	Tue,  1 Mar 2022 02:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3X_4o1lgiUX; Tue,  1 Mar 2022 02:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 11A2F40133;
	Tue,  1 Mar 2022 02:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9081C0077;
	Tue,  1 Mar 2022 02:05:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9BFFC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C483580C9C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jhzd4WWKonBc for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:05:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D80780C58
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:05:25 +0000 (UTC)
X-UUID: a86095ea6c7f416fbb5dcb9564fb2e7c-20220301
X-UUID: a86095ea6c7f416fbb5dcb9564fb2e7c-20220301
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 741999193; Tue, 01 Mar 2022 10:05:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 1 Mar 2022 10:05:19 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 1 Mar 2022 10:05:19 +0800
To: <yf.wang@mediatek.com>
Subject: [PATCH v2] iommu/iova: Reset max32_alloc_size after cleaning rcache
 in the fail path
Date: Tue, 1 Mar 2022 09:59:19 +0800
Message-ID: <20220301015919.5116-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220301014246.5011-1-yf.wang@mediatek.com>
References: <20220301014246.5011-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Ning.Li@mediatek.com, matthias.bgg@gmail.com, stable@vger.kernel.org,
 will@kernel.org
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
Content-Type: multipart/mixed; boundary="===============4254548693170390539=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4254548693170390539==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_004_1946722980.417018287"

--__=_Part_Boundary_004_1946722980.417018287
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PHByZT4NCkZyb206IFl1bmZlaSBXYW5nICZsdDt5Zi53YW5nQG1lZGlhdGVrLmNvbSZndDsNCg0K
SW4gYWxsb2NfaW92YV9mYXN0IGZ1bmN0aW9uLCBpZiBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9y
YW5nZSBmYWlsLA0KYWxsb2NfaW92YV9mYXN0IHdpbGwgdHJ5IGZsdXNoaW5nIHJjYWNoZSBhbmQg
cmV0cnkgYWxsb2MgaW92YSwgYnV0DQp0aGlzIGhhcyBhbiBpc3N1ZToNCg0KU2luY2UgX19hbGxv
Y19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2UgZmFpbCB3aWxsIHNldCB0aGUgY3VycmVudCBhbGxvYw0K
aW92YSBzaXplIHRvIG1heDMyX2FsbG9jX3NpemUgKGlvdmFkLSZndDttYXgzMl9hbGxvY19zaXpl
ID0gc2l6ZSksDQp3aGVuIHRoZSByZXRyeSBpcyBleGVjdXRlZCBpbnRvIHRoZSBfX2FsbG9jX2Fu
ZF9pbnNlcnRfaW92YV9yYW5nZQ0KZnVuY3Rpb24sIHRoZSByZXRyeSBhY3Rpb24gd2lsbCBiZSBi
bG9ja2VkIGJ5IHRoZSBjaGVjayBjb25kaXRpb24NCihzaXplICZndDs9IGlvdmFkLSZndDttYXgz
Ml9hbGxvY19zaXplKSBhbmQgZ290byBpb3ZhMzJfZnVsbCBkaXJlY3RseSwNCmNhdXNlcyB0aGUg
YWN0aW9uIG9mIHJldHJ5IHJlZ3VsYXIgYWxsb2MgaW92YSBpbg0KX19hbGxvY19hbmRfaW5zZXJ0
X2lvdmFfcmFuZ2UgdG8gbm90IGFjdHVhbGx5IGJlIGV4ZWN1dGVkLg0KDQpCYXNlZCBvbiB0aGUg
YWJvdmUsIHNvIG5lZWQgcmVzZXQgbWF4MzJfYWxsb2Nfc2l6ZSBiZWZvcmUgcmV0cnkgYWxsb2MN
CmlvdmEgd2hlbiBhbGxvYyBpb3ZhIGZhaWwsIHRoYXQgaXMgc2V0IHRoZSBpbml0aWFsIGRtYV8z
MmJpdF9wZm4gdmFsdWUNCm9mIGlvdmFkIHRvIG1heDMyX2FsbG9jX3NpemUsIHNvIHRoYXQgdGhl
IGFjdGlvbiBvZiByZXRyeSBhbGxvYyBpb3ZhDQppbiBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9y
YW5nZSBjYW4gYmUgZXhlY3V0ZWQuDQoNClNpZ25lZC1vZmYtYnk6IFl1bmZlaSBXYW5nICZsdDt5
Zi53YW5nQG1lZGlhdGVrLmNvbSZndDsNCkNjOiAmbHQ7c3RhYmxlQHZnZXIua2VybmVsLm9yZyZn
dDsgIyA1LjEwLioNCi0tLQ0KdjI6IENjIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCiAgICAxLiBU
aGlzIHBhdGNoIG5lZWRzIHRvIGJlIG1lcmdlZCBzdGFibGUgYnJhbmNoLCBhZGQgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KICAgICAgIGluIG1haWwgbGlzdC4NCg0KLS0tDQogZHJpdmVycy9pb21t
dS9pb3ZhLmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5j
DQppbmRleCBiMjhjOTQzNWI4OTguLjBjMDg1YWU4MjkzZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
aW9tbXUvaW92YS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYw0KQEAgLTQ1Myw2ICs0NTMs
NyBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQg
bG9uZyBzaXplLA0KIHJldHJ5Og0KIAluZXdfaW92YSA9IGFsbG9jX2lvdmEoaW92YWQsIHNpemUs
IGxpbWl0X3BmbiwgdHJ1ZSk7DQogCWlmICghbmV3X2lvdmEpIHsNCisJCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQogCQl1bnNpZ25lZCBpbnQgY3B1Ow0KIA0KIAkJaWYgKCFmbHVzaF9yY2FjaGUpDQpA
QCAtNDYzLDYgKzQ2NCwxMiBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICpp
b3ZhZCwgdW5zaWduZWQgbG9uZyBzaXplLA0KIAkJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpDQog
CQkJZnJlZV9jcHVfY2FjaGVkX2lvdmFzKGNwdSwgaW92YWQpOw0KIAkJZnJlZV9nbG9iYWxfY2Fj
aGVkX2lvdmFzKGlvdmFkKTsNCisNCisJCS8qIFJlc2V0IG1heDMyX2FsbG9jX3NpemUgYWZ0ZXIg
Zmx1c2hpbmcgcmNhY2hlIGZvciByZXRyeSAqLw0KKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmFtcDtp
b3ZhZC0mZ3Q7aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOw0KKwkJaW92YWQtJmd0O21heDMyX2Fs
bG9jX3NpemUgPSBpb3ZhZC0mZ3Q7ZG1hXzMyYml0X3BmbjsNCisJCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmFtcDtpb3ZhZC0mZ3Q7aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOw0KKw0KIAkJZ290
byByZXRyeTsNCiAJfQ0KIA0KLS0gDQoyLjE4LjANCg0KPC9wcmU+PCEtLXR5cGU6dGV4dC0tPjwh
LS17LS0+PHByZT4qKioqKioqKioqKioqIE1FRElBVEVLIENvbmZpZGVudGlhbGl0eSBOb3RpY2Ug
KioqKioqKioqKioqKioqKioqKioNClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBl
LW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSANCmF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlk
ZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlDQpleGVtcHQgZnJv
bSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUg
DQpjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwg
ZGlzc2VtaW5hdGlvbiwgDQpkaXN0cmlidXRpb24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29w
eWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0cyANCmF0dGFjaG1lbnRzKSBieSB1bmlu
dGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgDQpiZSB1
bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1t
YWlsLCBvciBiZWxpZXZlIA0KdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBl
cnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5n
IHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiANCnRoaXMgZS1t
YWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8g
bm90DQpkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVy
c29uLiBUaGFuayB5b3UhDQo8L3ByZT48IS0tfS0tPg==

--__=_Part_Boundary_004_1946722980.417018287
Content-Type: text/plain
Content-Transfer-Encoding: base64

RnJvbTogWXVuZmVpIFdhbmcgPHlmLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpJbiBhbGxvY19pb3Zh
X2Zhc3QgZnVuY3Rpb24sIGlmIF9fYWxsb2NfYW5kX2luc2VydF9pb3ZhX3JhbmdlIGZhaWwsDQph
bGxvY19pb3ZhX2Zhc3Qgd2lsbCB0cnkgZmx1c2hpbmcgcmNhY2hlIGFuZCByZXRyeSBhbGxvYyBp
b3ZhLCBidXQNCnRoaXMgaGFzIGFuIGlzc3VlOg0KDQpTaW5jZSBfX2FsbG9jX2FuZF9pbnNlcnRf
aW92YV9yYW5nZSBmYWlsIHdpbGwgc2V0IHRoZSBjdXJyZW50IGFsbG9jDQppb3ZhIHNpemUgdG8g
bWF4MzJfYWxsb2Nfc2l6ZSAoaW92YWQtPm1heDMyX2FsbG9jX3NpemUgPSBzaXplKSwNCndoZW4g
dGhlIHJldHJ5IGlzIGV4ZWN1dGVkIGludG8gdGhlIF9fYWxsb2NfYW5kX2luc2VydF9pb3ZhX3Jh
bmdlDQpmdW5jdGlvbiwgdGhlIHJldHJ5IGFjdGlvbiB3aWxsIGJlIGJsb2NrZWQgYnkgdGhlIGNo
ZWNrIGNvbmRpdGlvbg0KKHNpemUgPj0gaW92YWQtPm1heDMyX2FsbG9jX3NpemUpIGFuZCBnb3Rv
IGlvdmEzMl9mdWxsIGRpcmVjdGx5LA0KY2F1c2VzIHRoZSBhY3Rpb24gb2YgcmV0cnkgcmVndWxh
ciBhbGxvYyBpb3ZhIGluDQpfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZSB0byBub3QgYWN0
dWFsbHkgYmUgZXhlY3V0ZWQuDQoNCkJhc2VkIG9uIHRoZSBhYm92ZSwgc28gbmVlZCByZXNldCBt
YXgzMl9hbGxvY19zaXplIGJlZm9yZSByZXRyeSBhbGxvYw0KaW92YSB3aGVuIGFsbG9jIGlvdmEg
ZmFpbCwgdGhhdCBpcyBzZXQgdGhlIGluaXRpYWwgZG1hXzMyYml0X3BmbiB2YWx1ZQ0Kb2YgaW92
YWQgdG8gbWF4MzJfYWxsb2Nfc2l6ZSwgc28gdGhhdCB0aGUgYWN0aW9uIG9mIHJldHJ5IGFsbG9j
IGlvdmENCmluIF9fYWxsb2NfYW5kX2luc2VydF9pb3ZhX3JhbmdlIGNhbiBiZSBleGVjdXRlZC4N
Cg0KU2lnbmVkLW9mZi1ieTogWXVuZmVpIFdhbmcgPHlmLndhbmdAbWVkaWF0ZWsuY29tPg0KQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUuMTAuKg0KLS0tDQp2MjogQ2Mgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KICAgIDEuIFRoaXMgcGF0Y2ggbmVlZHMgdG8gYmUgbWVyZ2VkIHN0YWJs
ZSBicmFuY2gsIGFkZCBzdGFibGVAdmdlci5rZXJuZWwub3JnDQogICAgICAgaW4gbWFpbCBsaXN0
Lg0KDQotLS0NCiBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDcgKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW92YS5j
IGIvZHJpdmVycy9pb21tdS9pb3ZhLmMNCmluZGV4IGIyOGM5NDM1Yjg5OC4uMGMwODVhZTgyOTNm
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMNCisrKyBiL2RyaXZlcnMvaW9tbXUv
aW92YS5jDQpAQCAtNDUzLDYgKzQ1Myw3IEBAIGFsbG9jX2lvdmFfZmFzdChzdHJ1Y3QgaW92YV9k
b21haW4gKmlvdmFkLCB1bnNpZ25lZCBsb25nIHNpemUsDQogcmV0cnk6DQogCW5ld19pb3ZhID0g
YWxsb2NfaW92YShpb3ZhZCwgc2l6ZSwgbGltaXRfcGZuLCB0cnVlKTsNCiAJaWYgKCFuZXdfaW92
YSkgew0KKwkJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJCXVuc2lnbmVkIGludCBjcHU7DQogDQog
CQlpZiAoIWZsdXNoX3JjYWNoZSkNCkBAIC00NjMsNiArNDY0LDEyIEBAIGFsbG9jX2lvdmFfZmFz
dChzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLCB1bnNpZ25lZCBsb25nIHNpemUsDQogCQlmb3Jf
ZWFjaF9vbmxpbmVfY3B1KGNwdSkNCiAJCQlmcmVlX2NwdV9jYWNoZWRfaW92YXMoY3B1LCBpb3Zh
ZCk7DQogCQlmcmVlX2dsb2JhbF9jYWNoZWRfaW92YXMoaW92YWQpOw0KKw0KKwkJLyogUmVzZXQg
bWF4MzJfYWxsb2Nfc2l6ZSBhZnRlciBmbHVzaGluZyByY2FjaGUgZm9yIHJldHJ5ICovDQorCQlz
cGluX2xvY2tfaXJxc2F2ZSgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsNCisJCWlv
dmFkLT5tYXgzMl9hbGxvY19zaXplID0gaW92YWQtPmRtYV8zMmJpdF9wZm47DQorCQlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOw0KKw0KIAkJ
Z290byByZXRyeTsNCiAJfQ0KIA0KLS0gDQoyLjE4LjANCg==

--__=_Part_Boundary_004_1946722980.417018287--


--===============4254548693170390539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4254548693170390539==--

