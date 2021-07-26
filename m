Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A602DC4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 12:30:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598FE60F4F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 12:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 598FE60F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2506A605EB;
	Mon, 26 Jul 2021 12:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jzOC3hS78eAz; Mon, 26 Jul 2021 12:30:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BCB65605D0;
	Mon, 26 Jul 2021 12:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78450C0010;
	Mon, 26 Jul 2021 12:30:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64880C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 12:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C8DE605EB
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 12:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6e-NL8joA6E for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 12:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B486605D0
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 12:30:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="234076645"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; d="scan'208";a="234076645"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 05:30:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; d="scan'208";a="504880031"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.209])
 ([10.254.214.209])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 05:30:00 -0700
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
 <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
 <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 18/23] iommu: Express DMA strictness via the domain type
Message-ID: <29443387-c088-480c-3d91-17b6d1cc8188@linux.intel.com>
Date: Mon, 26 Jul 2021 20:29:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS83LzI2IDE2OjI3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNy0yNCAw
NjoyOSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBPbiAyMDIxLzcvMjIgMjoy
MCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gRWxpbWluYXRlIHRoZSBpb21tdV9nZXRfZG1hX3N0
cmljdCgpIGluZGlyZWN0aW9uIGFuZCBwaXBlIHRoZQo+Pj4gaW5mb3JtYXRpb24gdGhyb3VnaCB0
aGUgZG9tYWluIHR5cGUgZnJvbSB0aGUgYmVnaW5uaW5nLiBCZXNpZGVzCj4+PiB0aGUgZmxvdyBz
aW1wbGlmaWNhdGlvbiB0aGlzIGFsc28gaGFzIHNldmVyYWwgbmljZSBzaWRlLWVmZmVjdHM6Cj4+
Pgo+Pj4gwqAgLSBBdXRvbWF0aWNhbGx5IGltcGxpZXMgc3RyaWN0IG1vZGUgZm9yIHVudHJ1c3Rl
ZCBkZXZpY2VzIGJ5Cj4+PiDCoMKgwqAgdmlydHVlIG9mIHRoZWlyIElPTU1VX0RPTUFJTl9ETUEg
b3ZlcnJpZGUuCj4+PiDCoCAtIEVuc3VyZXMgdGhhdCB3ZSBvbmx5IGVuZHMgdXAgdXNpbmcgZmx1
c2ggcXVldWVzIGZvciBkcml2ZXJzCj4+PiDCoMKgwqAgd2hpY2ggYXJlIGF3YXJlIG9mIHRoZW0g
YW5kIGNhbiBhY3R1YWxseSBiZW5lZml0Lgo+Pgo+PiBJcyB0aGlzIGV4cHJlc3NlZCBieSB2ZW5k
b3IgaW9tbXUgZHJpdmVyIGhhcyBvcHMtPmZsdXNoX2lvdGxiX2FsbD8KPiAKPiBObywgaXQncyBs
aXRlcmFsbHkgd2hldGhlciAtPmRvbWFpbl9hbGxvYyBhY2NlcHRzIHRoZSBETUFfRE9NQUlOX0ZR
IHR5cGUgCj4gb3Igbm90Lgo+IAo+Pj4gwqAgLSBBbGxvd3MgdXMgdG8gaGFuZGxlIGZsdXNoIHF1
ZXVlIGluaXQgZmFpbHVyZSBieSBmYWxsaW5nIGJhY2sKPj4+IMKgwqDCoCB0byBzdHJpY3QgbW9k
ZSBpbnN0ZWFkIG9mIGxlYXZpbmcgaXQgdG8gcG9zc2libHkgYmxvdyB1cCBsYXRlci4KPj4+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+Pj4g
LS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHzC
oCAyICstCj4+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jwqDCoMKg
wqDCoMKgIHzCoCAyICstCj4+PiDCoCBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKysrLS0tLQo+Pj4gwqAgZHJpdmVy
cy9pb21tdS9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxNCArKysrLS0tLS0tLS0tLQo+Pj4gwqAgaW5jbHVkZS9saW51eC9pb21tdS5owqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgLQo+Pj4gwqAgNSBm
aWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyAK
Pj4+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+Pj4gaW5k
ZXggZmE0MTAyNmQyNzJlLi4yNjBiNTYwZDAwNzUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+PiBAQCAtMjE3NSw3ICsyMTc1LDcgQEAg
c3RhdGljIGludCBhcm1fc21tdV9kb21haW5fZmluYWxpc2Uoc3RydWN0IAo+Pj4gaW9tbXVfZG9t
YWluICpkb21haW4sCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmlvbW11X2RldsKgwqDCoCA9IHNt
bXUtPmRldiwKPj4+IMKgwqDCoMKgwqAgfTsKPj4+IC3CoMKgwqAgaWYgKCFpb21tdV9nZXRfZG1h
X3N0cmljdChkb21haW4pKQo+Pj4gK8KgwqDCoCBpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RP
TUFJTl9ETUFfRlEpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGd0YmxfY2ZnLnF1aXJrcyB8PSBJ
T19QR1RBQkxFX1FVSVJLX05PTl9TVFJJQ1Q7Cj4+PiDCoMKgwqDCoMKgIHBndGJsX29wcyA9IGFs
bG9jX2lvX3BndGFibGVfb3BzKGZtdCwgJnBndGJsX2NmZywgc21tdV9kb21haW4pOwo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgCj4+PiBiL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMKPj4+IGluZGV4IGRiYzE0YzI2NWIx
NS4uMmM3MTdmM2JlMDU2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUvYXJtLXNtbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUuYwo+Pj4gQEAgLTc2NSw3ICs3NjUsNyBAQCBzdGF0aWMgaW50IGFybV9zbW11X2luaXRfZG9t
YWluX2NvbnRleHQoc3RydWN0IAo+Pj4gaW9tbXVfZG9tYWluICpkb21haW4sCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgLmlvbW11X2RldsKgwqDCoCA9IHNtbXUtPmRldiwKPj4+IMKgwqDCoMKgwqAg
fTsKPj4+IC3CoMKgwqAgaWYgKCFpb21tdV9nZXRfZG1hX3N0cmljdChkb21haW4pKQo+Pj4gK8Kg
wqDCoCBpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9ETUFfRlEpCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcGd0YmxfY2ZnLnF1aXJrcyB8PSBJT19QR1RBQkxFX1FVSVJLX05PTl9TVFJJ
Q1Q7Cj4+PiDCoMKgwqDCoMKgIGlmIChzbW11LT5pbXBsICYmIHNtbXUtPmltcGwtPmluaXRfY29u
dGV4dCkgewo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2
ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+PiBpbmRleCBiMWFmMWZmMzI0YzUuLmExMTRhN2FkODhl
YyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+IEBAIC0zNjMsMTMgKzM2MywxNSBAQCBzdGF0aWMg
aW50IGlvbW11X2RtYV9pbml0X2RvbWFpbihzdHJ1Y3QgCj4+PiBpb21tdV9kb21haW4gKmRvbWFp
biwgZG1hX2FkZHJfdCBiYXNlLAo+Pj4gwqDCoMKgwqDCoCBpbml0X2lvdmFfZG9tYWluKGlvdmFk
LCAxVUwgPDwgb3JkZXIsIGJhc2VfcGZuKTsKPj4+IC3CoMKgwqAgaWYgKCFjb29raWUtPmZxX2Rv
bWFpbiAmJiAhZGV2X2lzX3VudHJ1c3RlZChkZXYpICYmCj4+PiAtwqDCoMKgwqDCoMKgwqAgZG9t
YWluLT5vcHMtPmZsdXNoX2lvdGxiX2FsbCAmJiAKPj4+ICFpb21tdV9nZXRfZG1hX3N0cmljdChk
b21haW4pKSB7Cj4+PiArwqDCoMKgIGlmIChkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0RN
QV9GUSAmJiAhY29va2llLT5mcV9kb21haW4gJiYKPj4+ICvCoMKgwqDCoMKgwqDCoCBkb21haW4t
Pm9wcy0+Zmx1c2hfaW90bGJfYWxsKSB7CgpQZXJoYXBzIHdlIGNhbiByZW1vdmUgdGhlIG9wcy0+
Zmx1c2hfaW90bGJfYWxsIGNoZWNrIHdpdGggdGhlCmFzc3VtcHRpb24gdGhhdCBhbnkgdmVuZG9y
IGlvbW11IGRyaXZlciB3aXRoIERNQV9GUSBkb21haW4gc3VwcG9ydApzaG91bGQgYWx3YXlzIHBy
b3ZpZGVzIHRoaXMgY2FsbGJhY2s/CgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cgo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChpbml0X2lvdmFfZmx1c2hfcXVldWUoaW92YWQsIGlvbW11X2RtYV9mbHVz
aF9pb3RsYl9hbGwsCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlvbW11X2RtYV9lbnRyeV9kdG9yKSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX2VudHJ5X2R0b3IpKSB7Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJpb3ZhIGZsdXNoIHF1ZXVlIGluaXRpYWxpemF0aW9u
IGZhaWxlZFxuIik7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgZWxzZQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZG9tYWluLT50eXBlID0gSU9NTVVfRE9NQUlOX0RNQTsKPj4+ICvCoMKgwqDCoMKg
wqDCoCB9IGVsc2Ugewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29va2llLT5mcV9k
b21haW4gPSBkb21haW47Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoCB9Cj4+
PiDCoMKgwqDCoMKgIHJldHVybiBpb3ZhX3Jlc2VydmVfaW9tbXVfcmVnaW9ucyhkZXYsIGRvbWFp
bik7Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9pb21tdS5jCj4+PiBpbmRleCA4MzMzYzMzNDg5MWUuLmQ3ZWFhY2FlMDk0NCAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21t
dS5jCj4+PiBAQCAtMTM1LDYgKzEzNSw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X3N1YnN5
c19pbml0KHZvaWQpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoCB9Cj4+
PiArwqDCoMKgIGlmICghaW9tbXVfZGVmYXVsdF9wYXNzdGhyb3VnaCgpICYmICFpb21tdV9kbWFf
c3RyaWN0KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1V
X0RPTUFJTl9ETUFfRlE7Cj4+PiArCj4+PiDCoMKgwqDCoMKgIHByX2luZm8oIkRlZmF1bHQgZG9t
YWluIHR5cGU6ICVzICVzXG4iLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2RvbWFpbl90
eXBlX3N0cihpb21tdV9kZWZfZG9tYWluX3R5cGUpLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIChp
b21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5FX0RNQV9BUEkpID8KPj4+IEBAIC0zNTIsMTUg
KzM1NSw2IEBAIHZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3QoYm9vbCBzdHJpY3QpCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHN0cmljdDsKPj4+IMKgIH0KPj4+IC1i
b29sIGlvbW11X2dldF9kbWFfc3RyaWN0KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbikKPj4+
IC17Cj4+PiAtwqDCoMKgIC8qIG9ubHkgYWxsb3cgbGF6eSBmbHVzaGluZyBmb3IgRE1BIGRvbWFp
bnMgKi8KPj4+IC3CoMKgwqAgaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fRE1BKQo+
Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBpb21tdV9kbWFfc3RyaWN0Owo+Pj4gLcKgwqDCoCBy
ZXR1cm4gdHJ1ZTsKPj4+IC19Cj4+PiAtRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZ2V0X2RtYV9z
dHJpY3QpOwo+Pj4gLQo+Pj4gwqAgc3RhdGljIHNzaXplX3QgaW9tbXVfZ3JvdXBfYXR0cl9zaG93
KHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGF0dHJpYnV0ZSAqX19hdHRyLCBjaGFyICpidWYpCj4+PiDC
oCB7Cj4+PiBAQCAtNzY0LDcgKzc1OCw3IEBAIHN0YXRpYyBpbnQgCj4+PiBpb21tdV9jcmVhdGVf
ZGV2aWNlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLAo+Pj4gwqDC
oMKgwqDCoCB1bnNpZ25lZCBsb25nIHBnX3NpemU7Cj4+PiDCoMKgwqDCoMKgIGludCByZXQgPSAw
Owo+Pj4gLcKgwqDCoCBpZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5cGUgIT0gSU9NTVVfRE9NQUlO
X0RNQSkKPj4+ICvCoMKgwqAgaWYgKCFkb21haW4gfHwgIShkb21haW4tPnR5cGUgJiBfX0lPTU1V
X0RPTUFJTl9ETUFfQVBJKSkKPj4KPj4gTml0OiBwcm9iYWJseSBtb3ZlIGFib3ZlIGNoYW5nZSB0
byBwYXRjaCAxND8KPiAKPiBJbmRlZWQgSSdtIG5vdCBzdXJlIHdoeSB0aGlzIG9uZSBlbmRlZCB1
cCBoZXJlLCBnb29kIGNhdGNoIQo+IAo+IFRoYW5rcywKPiBSb2Jpbi4KPiAKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+IMKgwqDCoMKgwqAgQlVHX09OKCFkb21haW4tPnBnc2l6
ZV9iaXRtYXApOwo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1
ZGUvbGludXgvaW9tbXUuaAo+Pj4gaW5kZXggNTY1MTkxMTBkNDNmLi41NTdjNGMxMmUyY2YgMTAw
NjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPj4+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvaW9tbXUuaAo+Pj4gQEAgLTQ4NCw3ICs0ODQsNiBAQCBpbnQgaW9tbXVfc2V0X3BndGFibGVf
cXVpcmtzKHN0cnVjdCBpb21tdV9kb21haW4gCj4+PiAqZG9tYWluLAo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGxvbmcgcXVpcmtzKTsKPj4+IMKgIHZvaWQgaW9tbXVfc2V0X2RtYV9z
dHJpY3QoYm9vbCB2YWwpOwo+Pj4gLWJvb2wgaW9tbXVfZ2V0X2RtYV9zdHJpY3Qoc3RydWN0IGlv
bW11X2RvbWFpbiAqZG9tYWluKTsKPj4+IMKgIGV4dGVybiBpbnQgcmVwb3J0X2lvbW11X2ZhdWx0
KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3RydWN0IAo+Pj4gZGV2aWNlICpkZXYsCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGlv
dmEsIGludCBmbGFncyk7Cj4+Pgo+Pgo+PiBCZXN0IHJlZ2FyZHMsCj4+IGJhb2x1Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
