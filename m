Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C0CC433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 01:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E92E140325;
	Tue,  1 Mar 2022 01:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kdAPCOUlg1hC; Tue,  1 Mar 2022 01:49:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 921394033C;
	Tue,  1 Mar 2022 01:49:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D2E4C0077;
	Tue,  1 Mar 2022 01:49:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C646C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 01:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B59A813F5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 01:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVc4FSobV3Nl for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 01:48:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEF4E812EC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 01:48:58 +0000 (UTC)
X-UUID: 71c0d92509264925bc3dadf911b7d004-20220301
X-UUID: 71c0d92509264925bc3dadf911b7d004-20220301
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1344401544; Tue, 01 Mar 2022 09:48:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 1 Mar 2022 09:48:47 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 1 Mar 2022 09:48:46 +0800
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Subject: [PATCH] iommu/iova: Reset max32_alloc_size after cleaning rcache in
 the fail path
Date: Tue, 1 Mar 2022 09:42:43 +0800
Message-ID: <20220301014246.5011-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Cc: Ning Li <Ning.Li@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
 wsd_upstream@mediatek.com, Yunfei Wang <yf.wang@mediatek.com>
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
Content-Type: multipart/mixed; boundary="===============1945790483111658195=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1945790483111658195==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_007_1500197204.1449527252"

--__=_Part_Boundary_007_1500197204.1449527252
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
Zi53YW5nQG1lZGlhdGVrLmNvbSZndDsNCi0tLQ0KIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgNyAr
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYw0KaW5kZXggYjI4Yzk0
MzViODk4Li4wYzA4NWFlODI5M2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L2lvdmEuYw0K
KysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMNCkBAIC00NTMsNiArNDUzLDcgQEAgYWxsb2NfaW92
YV9mYXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCiBy
ZXRyeToNCiAJbmV3X2lvdmEgPSBhbGxvY19pb3ZhKGlvdmFkLCBzaXplLCBsaW1pdF9wZm4sIHRy
dWUpOw0KIAlpZiAoIW5ld19pb3ZhKSB7DQorCQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIAkJdW5z
aWduZWQgaW50IGNwdTsNCiANCiAJCWlmICghZmx1c2hfcmNhY2hlKQ0KQEAgLTQ2Myw2ICs0NjQs
MTIgQEAgYWxsb2NfaW92YV9mYXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVk
IGxvbmcgc2l6ZSwNCiAJCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KQ0KIAkJCWZyZWVfY3B1X2Nh
Y2hlZF9pb3ZhcyhjcHUsIGlvdmFkKTsNCiAJCWZyZWVfZ2xvYmFsX2NhY2hlZF9pb3Zhcyhpb3Zh
ZCk7DQorDQorCQkvKiBSZXNldCBtYXgzMl9hbGxvY19zaXplIGFmdGVyIGZsdXNoaW5nIHJjYWNo
ZSBmb3IgcmV0cnkgKi8NCisJCXNwaW5fbG9ja19pcnFzYXZlKCZhbXA7aW92YWQtJmd0O2lvdmFf
cmJ0cmVlX2xvY2ssIGZsYWdzKTsNCisJCWlvdmFkLSZndDttYXgzMl9hbGxvY19zaXplID0gaW92
YWQtJmd0O2RtYV8zMmJpdF9wZm47DQorCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhbXA7aW92
YWQtJmd0O2lvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsNCisNCiAJCWdvdG8gcmV0cnk7DQogCX0N
CiANCi0tIA0KMi4xOC4wDQoNCjwvcHJlPjwhLS10eXBlOnRleHQtLT48IS0tey0tPjxwcmU+Kioq
KioqKioqKioqKiBNRURJQVRFSyBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioq
KioqKioqDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2Ug
KGluY2x1ZGluZyBhbnkgDQphdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJp
ZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lzZQ0KZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1
bmRlciBhcHBsaWNhYmxlIGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIA0KY29udmV5ZWQgb25s
eSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24s
IA0KZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBl
LW1haWwgKGluY2x1ZGluZyBpdHMgDQphdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGll
bnQocykgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IA0KYmUgdW5sYXdmdWwuIElmIHlv
dSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2
ZSANCnRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciANCmltbWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFp
bCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3BpZXMgb2YgDQp0aGlzIGUtbWFpbCAoaW5jbHVkaW5n
IGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRvIG5vdA0KZGlzY2xvc2Ug
dGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91
IQ0KPC9wcmU+PCEtLX0tLT4=

--__=_Part_Boundary_007_1500197204.1449527252
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
Cg0KU2lnbmVkLW9mZi1ieTogWXVuZmVpIFdhbmcgPHlmLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0t
DQogZHJpdmVycy9pb21tdS9pb3ZhLmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZl
cnMvaW9tbXUvaW92YS5jDQppbmRleCBiMjhjOTQzNWI4OTguLjBjMDg1YWU4MjkzZiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYw0K
QEAgLTQ1Myw2ICs0NTMsNyBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3RydWN0IGlvdmFfZG9tYWluICpp
b3ZhZCwgdW5zaWduZWQgbG9uZyBzaXplLA0KIHJldHJ5Og0KIAluZXdfaW92YSA9IGFsbG9jX2lv
dmEoaW92YWQsIHNpemUsIGxpbWl0X3BmbiwgdHJ1ZSk7DQogCWlmICghbmV3X2lvdmEpIHsNCisJ
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCQl1bnNpZ25lZCBpbnQgY3B1Ow0KIA0KIAkJaWYgKCFm
bHVzaF9yY2FjaGUpDQpAQCAtNDYzLDYgKzQ2NCwxMiBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3RydWN0
IGlvdmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQgbG9uZyBzaXplLA0KIAkJZm9yX2VhY2hfb25s
aW5lX2NwdShjcHUpDQogCQkJZnJlZV9jcHVfY2FjaGVkX2lvdmFzKGNwdSwgaW92YWQpOw0KIAkJ
ZnJlZV9nbG9iYWxfY2FjaGVkX2lvdmFzKGlvdmFkKTsNCisNCisJCS8qIFJlc2V0IG1heDMyX2Fs
bG9jX3NpemUgYWZ0ZXIgZmx1c2hpbmcgcmNhY2hlIGZvciByZXRyeSAqLw0KKwkJc3Bpbl9sb2Nr
X2lycXNhdmUoJmlvdmFkLT5pb3ZhX3JidHJlZV9sb2NrLCBmbGFncyk7DQorCQlpb3ZhZC0+bWF4
MzJfYWxsb2Nfc2l6ZSA9IGlvdmFkLT5kbWFfMzJiaXRfcGZuOw0KKwkJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsNCisNCiAJCWdvdG8gcmV0
cnk7DQogCX0NCiANCi0tIA0KMi4xOC4wDQo=

--__=_Part_Boundary_007_1500197204.1449527252--


--===============1945790483111658195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1945790483111658195==--

