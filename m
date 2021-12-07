Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772EAC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 11:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0654980B56;
	Tue,  7 Dec 2021 11:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIA1BV3vEx0h; Tue,  7 Dec 2021 11:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB72680B3F;
	Tue,  7 Dec 2021 11:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38A1AC001E;
	Tue,  7 Dec 2021 11:38:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88328C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 686C460E5F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sps_KcP1Ps1D for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5322560594
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:38:30 +0000 (UTC)
X-UUID: c1d2d3faf55548ef827f6e6e2d90f71d-20211207
X-UUID: c1d2d3faf55548ef827f6e6e2d90f71d-20211207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 686929266; Tue, 07 Dec 2021 19:38:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 7 Dec 2021 19:38:22 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 7 Dec 2021 19:38:21 +0800
From: <yf.wang@mediatek.com>
To: <will@kernel.org>
Subject: [PATCH v3] iommu/io-pgtable-arm-v7s: Add error handle for page table
 allocation failure
Date: Tue, 7 Dec 2021 19:33:15 +0800
Message-ID: <20211207113315.29109-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211207094817.GA31382@willie-the-truck>
References: <20211207094817.GA31382@willie-the-truck>
MIME-Version: 1.0
Cc: Guangming.Cao@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, matthias.bgg@gmail.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============6961436977798354991=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6961436977798354991==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_006_493484030.152006670"

--__=_Part_Boundary_006_493484030.152006670
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
cm5lbC5vcmcmZ3Q7ICMgNS4xMC4qDQotLS0NCnYzOiBVcGRhdGUgcGF0Y2gNCiAgICAxLiBSZW1v
dmUgdW5uZWNlc3NhcnkgbG9nIHByaW50IGFzIHN1Z2dlc3RlZCBieSBXaWxsLg0KICAgIDIuIFJl
bW92ZSB1bm5lY2Vzc2FyeSBjb25kaXRpb24gY2hlY2suDQp2MjogQ2Mgc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KICAgIDEuIFRoaXMgcGF0Y2ggbmVlZHMgdG8gYmUgbWVyZ2VkIHN0YWJsZSBicmFu
Y2gsIGFkZCBzdGFibGVAdmdlci5rZXJuZWwub3JnDQogICAgICAgaW4gbWFpbCBsaXN0Lg0KICAg
IDIuIFRoZXJlIGlzIE5vIG5ldyBjb2RlIGNoYW5nZSBpbiB2Mi4NCg0KLS0tDQogZHJpdmVycy9p
b21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyB8IDYgKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pby1wZ3RhYmxlLWFybS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdz
LmMNCmluZGV4IGJmYjZhY2I2NTFlNS4uYmUwNjZjMTUwM2QzIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3Rh
YmxlLWFybS12N3MuYw0KQEAgLTI0NiwxMyArMjQ2LDE3IEBAIHN0YXRpYyB2b2lkICpfX2FybV92
N3NfYWxsb2NfdGFibGUoaW50IGx2bCwgZ2ZwX3QgZ2ZwLA0KIAkJCV9fR0ZQX1pFUk8gfCBBUk1f
VjdTX1RBQkxFX0dGUF9ETUEsIGdldF9vcmRlcihzaXplKSk7DQogCWVsc2UgaWYgKGx2bCA9PSAy
KQ0KIAkJdGFibGUgPSBrbWVtX2NhY2hlX3phbGxvYyhkYXRhLSZndDtsMl90YWJsZXMsIGdmcCk7
DQorDQorCWlmICghdGFibGUpDQorCQlyZXR1cm4gTlVMTDsNCisNCiAJcGh5cyA9IHZpcnRfdG9f
cGh5cyh0YWJsZSk7DQogCWlmIChwaHlzICE9IChhcm1fdjdzX2lvcHRlKXBoeXMpIHsNCiAJCS8q
IERvZXNuJiMzOTt0IGZpdCBpbiBQVEUgKi8NCiAJCWRldl9lcnIoZGV2LCAmcXVvdDtQYWdlIHRh
YmxlIGRvZXMgbm90IGZpdCBpbiBQVEU6ICVwYSZxdW90OywgJmFtcDtwaHlzKTsNCiAJCWdvdG8g
b3V0X2ZyZWU7DQogCX0NCi0JaWYgKHRhYmxlICZhbXA7JmFtcDsgIWNmZy0mZ3Q7Y29oZXJlbnRf
d2Fsaykgew0KKwlpZiAoIWNmZy0mZ3Q7Y29oZXJlbnRfd2Fsaykgew0KIAkJZG1hID0gZG1hX21h
cF9zaW5nbGUoZGV2LCB0YWJsZSwgc2l6ZSwgRE1BX1RPX0RFVklDRSk7DQogCQlpZiAoZG1hX21h
cHBpbmdfZXJyb3IoZGV2LCBkbWEpKQ0KIAkJCWdvdG8gb3V0X2ZyZWU7DQotLSANCjIuMTguMA0K
DQo8L3ByZT48IS0tdHlwZTp0ZXh0LS0+PCEtLXstLT48cHJlPioqKioqKioqKioqKiogTUVESUFU
RUsgQ29uZmlkZW50aWFsaXR5IE5vdGljZQ0KICoqKioqKioqKioqKioqKioqKioqDQpUaGUgaW5m
b3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkg
DQphdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVn
ZWQsIG9yIG90aGVyd2lzZQ0KZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxl
IGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIA0KY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWdu
YXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIA0KZGlzdHJpYnV0aW9u
LCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGlu
ZyBpdHMgDQphdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0
bHkgcHJvaGliaXRlZCBhbmQgbWF5IA0KYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGlu
dGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZQ0KIA0KdGhhdCB5b3Ug
aGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIA0KaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFu
eSBhbmQgYWxsIGNvcGllcyBvZiANCnRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1l
bnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90DQpkaXNjbG9zZSB0aGUgY29udGVudCBv
ZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo8L3ByZT48IS0t
fS0tPg==

--__=_Part_Boundary_006_493484030.152006670
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
Y29tPg0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUuMTAuKg0KLS0tDQp2MzogVXBk
YXRlIHBhdGNoDQogICAgMS4gUmVtb3ZlIHVubmVjZXNzYXJ5IGxvZyBwcmludCBhcyBzdWdnZXN0
ZWQgYnkgV2lsbC4NCiAgICAyLiBSZW1vdmUgdW5uZWNlc3NhcnkgY29uZGl0aW9uIGNoZWNrLg0K
djI6IENjIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCiAgICAxLiBUaGlzIHBhdGNoIG5lZWRzIHRv
IGJlIG1lcmdlZCBzdGFibGUgYnJhbmNoLCBhZGQgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KICAg
ICAgIGluIG1haWwgbGlzdC4NCiAgICAyLiBUaGVyZSBpcyBObyBuZXcgY29kZSBjaGFuZ2UgaW4g
djIuDQoNCi0tLQ0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgfCA2ICsrKysr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lv
bW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQppbmRleCBiZmI2YWNiNjUxZTUuLmJlMDY2YzE1MDNk
MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCisrKyBi
L2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCkBAIC0yNDYsMTMgKzI0NiwxNyBA
QCBzdGF0aWMgdm9pZCAqX19hcm1fdjdzX2FsbG9jX3RhYmxlKGludCBsdmwsIGdmcF90IGdmcCwN
CiAJCQlfX0dGUF9aRVJPIHwgQVJNX1Y3U19UQUJMRV9HRlBfRE1BLCBnZXRfb3JkZXIoc2l6ZSkp
Ow0KIAllbHNlIGlmIChsdmwgPT0gMikNCiAJCXRhYmxlID0ga21lbV9jYWNoZV96YWxsb2MoZGF0
YS0+bDJfdGFibGVzLCBnZnApOw0KKw0KKwlpZiAoIXRhYmxlKQ0KKwkJcmV0dXJuIE5VTEw7DQor
DQogCXBoeXMgPSB2aXJ0X3RvX3BoeXModGFibGUpOw0KIAlpZiAocGh5cyAhPSAoYXJtX3Y3c19p
b3B0ZSlwaHlzKSB7DQogCQkvKiBEb2Vzbid0IGZpdCBpbiBQVEUgKi8NCiAJCWRldl9lcnIoZGV2
LCAiUGFnZSB0YWJsZSBkb2VzIG5vdCBmaXQgaW4gUFRFOiAlcGEiLCAmcGh5cyk7DQogCQlnb3Rv
IG91dF9mcmVlOw0KIAl9DQotCWlmICh0YWJsZSAmJiAhY2ZnLT5jb2hlcmVudF93YWxrKSB7DQor
CWlmICghY2ZnLT5jb2hlcmVudF93YWxrKSB7DQogCQlkbWEgPSBkbWFfbWFwX3NpbmdsZShkZXYs
IHRhYmxlLCBzaXplLCBETUFfVE9fREVWSUNFKTsNCiAJCWlmIChkbWFfbWFwcGluZ19lcnJvcihk
ZXYsIGRtYSkpDQogCQkJZ290byBvdXRfZnJlZTsNCi0tIA0KMi4xOC4wDQo=

--__=_Part_Boundary_006_493484030.152006670--


--===============6961436977798354991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6961436977798354991==--

