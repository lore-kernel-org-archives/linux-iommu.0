Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0781AC4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:27:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8A4604DC
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB8A4604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 806558381F;
	Mon, 26 Jul 2021 08:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtwfFZKtcZQ6; Mon, 26 Jul 2021 08:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 437EB8380E;
	Mon, 26 Jul 2021 08:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16F01C0010;
	Mon, 26 Jul 2021 08:27:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF491C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEF324033A
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxMaWM9tzPKE for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 08:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A79BF4032D
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:27:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 787E3106F;
 Mon, 26 Jul 2021 01:27:09 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 615CD3F66F;
 Mon, 26 Jul 2021 01:27:07 -0700 (PDT)
Subject: Re: [PATCH 18/23] iommu: Express DMA strictness via the domain type
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
 <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
Date: Mon, 26 Jul 2021 09:27:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
Content-Language: en-GB
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

T24gMjAyMS0wNy0yNCAwNjoyOSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
MjAyMS83LzIyIDI6MjAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gRWxpbWluYXRlIHRoZSBpb21t
dV9nZXRfZG1hX3N0cmljdCgpIGluZGlyZWN0aW9uIGFuZCBwaXBlIHRoZQo+PiBpbmZvcm1hdGlv
biB0aHJvdWdoIHRoZSBkb21haW4gdHlwZSBmcm9tIHRoZSBiZWdpbm5pbmcuIEJlc2lkZXMKPj4g
dGhlIGZsb3cgc2ltcGxpZmljYXRpb24gdGhpcyBhbHNvIGhhcyBzZXZlcmFsIG5pY2Ugc2lkZS1l
ZmZlY3RzOgo+Pgo+PiDCoCAtIEF1dG9tYXRpY2FsbHkgaW1wbGllcyBzdHJpY3QgbW9kZSBmb3Ig
dW50cnVzdGVkIGRldmljZXMgYnkKPj4gwqDCoMKgIHZpcnR1ZSBvZiB0aGVpciBJT01NVV9ET01B
SU5fRE1BIG92ZXJyaWRlLgo+PiDCoCAtIEVuc3VyZXMgdGhhdCB3ZSBvbmx5IGVuZHMgdXAgdXNp
bmcgZmx1c2ggcXVldWVzIGZvciBkcml2ZXJzCj4+IMKgwqDCoCB3aGljaCBhcmUgYXdhcmUgb2Yg
dGhlbSBhbmQgY2FuIGFjdHVhbGx5IGJlbmVmaXQuCj4gCj4gSXMgdGhpcyBleHByZXNzZWQgYnkg
dmVuZG9yIGlvbW11IGRyaXZlciBoYXMgb3BzLT5mbHVzaF9pb3RsYl9hbGw/CgpObywgaXQncyBs
aXRlcmFsbHkgd2hldGhlciAtPmRvbWFpbl9hbGxvYyBhY2NlcHRzIHRoZSBETUFfRE9NQUlOX0ZR
IHR5cGUgCm9yIG5vdC4KCj4+IMKgIC0gQWxsb3dzIHVzIHRvIGhhbmRsZSBmbHVzaCBxdWV1ZSBp
bml0IGZhaWx1cmUgYnkgZmFsbGluZyBiYWNrCj4+IMKgwqDCoCB0byBzdHJpY3QgbW9kZSBpbnN0
ZWFkIG9mIGxlYXZpbmcgaXQgdG8gcG9zc2libHkgYmxvdyB1cCBsYXRlci4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4gLS0tCj4+IMKg
IGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfMKgIDIgKy0KPj4g
wqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuY8KgwqDCoMKgwqDCoCB8wqAg
MiArLQo+PiDCoCBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKysrLS0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lvbW11
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsrKyst
LS0tLS0tLS0tCj4+IMKgIGluY2x1ZGUvbGludXgvaW9tbXUuaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxIC0KPj4gwqAgNSBmaWxlcyBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgCj4+IGIvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+PiBpbmRleCBmYTQxMDI2ZDI3MmUuLjI2
MGI1NjBkMDA3NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMv
YXJtLXNtbXUtdjMuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My5jCj4+IEBAIC0yMTc1LDcgKzIxNzUsNyBAQCBzdGF0aWMgaW50IGFybV9zbW11X2Rv
bWFpbl9maW5hbGlzZShzdHJ1Y3QgCj4+IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgLmlvbW11X2RldsKgwqDCoCA9IHNtbXUtPmRldiwKPj4gwqDCoMKgwqDCoCB9
Owo+PiAtwqDCoMKgIGlmICghaW9tbXVfZ2V0X2RtYV9zdHJpY3QoZG9tYWluKSkKPj4gK8KgwqDC
oCBpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9ETUFfRlEpCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBwZ3RibF9jZmcucXVpcmtzIHw9IElPX1BHVEFCTEVfUVVJUktfTk9OX1NUUklDVDsK
Pj4gwqDCoMKgwqDCoCBwZ3RibF9vcHMgPSBhbGxvY19pb19wZ3RhYmxlX29wcyhmbXQsICZwZ3Ri
bF9jZmcsIHNtbXVfZG9tYWluKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11L2FybS1zbW11LmMgCj4+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUuYwo+PiBpbmRleCBkYmMxNGMyNjViMTUuLjJjNzE3ZjNiZTA1NiAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+PiArKysgYi9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+IEBAIC03NjUsNyArNzY1LDcgQEAgc3RhdGlj
IGludCBhcm1fc21tdV9pbml0X2RvbWFpbl9jb250ZXh0KHN0cnVjdCAKPj4gaW9tbXVfZG9tYWlu
ICpkb21haW4sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuaW9tbXVfZGV2wqDCoMKgID0gc21tdS0+
ZGV2LAo+PiDCoMKgwqDCoMKgIH07Cj4+IC3CoMKgwqAgaWYgKCFpb21tdV9nZXRfZG1hX3N0cmlj
dChkb21haW4pKQo+PiArwqDCoMKgIGlmIChkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0RN
QV9GUSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBndGJsX2NmZy5xdWlya3MgfD0gSU9fUEdUQUJM
RV9RVUlSS19OT05fU1RSSUNUOwo+PiDCoMKgwqDCoMKgIGlmIChzbW11LT5pbXBsICYmIHNtbXUt
PmltcGwtPmluaXRfY29udGV4dCkgewo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9kbWEt
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4gaW5kZXggYjFhZjFmZjMyNGM1
Li5hMTE0YTdhZDg4ZWMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMK
Pj4gKysrIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+PiBAQCAtMzYzLDEzICszNjMsMTUg
QEAgc3RhdGljIGludCBpb21tdV9kbWFfaW5pdF9kb21haW4oc3RydWN0IAo+PiBpb21tdV9kb21h
aW4gKmRvbWFpbiwgZG1hX2FkZHJfdCBiYXNlLAo+PiDCoMKgwqDCoMKgIGluaXRfaW92YV9kb21h
aW4oaW92YWQsIDFVTCA8PCBvcmRlciwgYmFzZV9wZm4pOwo+PiAtwqDCoMKgIGlmICghY29va2ll
LT5mcV9kb21haW4gJiYgIWRldl9pc191bnRydXN0ZWQoZGV2KSAmJgo+PiAtwqDCoMKgwqDCoMKg
wqAgZG9tYWluLT5vcHMtPmZsdXNoX2lvdGxiX2FsbCAmJiAhaW9tbXVfZ2V0X2RtYV9zdHJpY3Qo
ZG9tYWluKSkgewo+PiArwqDCoMKgIGlmIChkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0RN
QV9GUSAmJiAhY29va2llLT5mcV9kb21haW4gJiYKPj4gK8KgwqDCoMKgwqDCoMKgIGRvbWFpbi0+
b3BzLT5mbHVzaF9pb3RsYl9hbGwpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbml0X2lv
dmFfZmx1c2hfcXVldWUoaW92YWQsIGlvbW11X2RtYV9mbHVzaF9pb3RsYl9hbGwsCj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX2VudHJ5X2R0
b3IpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11
X2RtYV9lbnRyeV9kdG9yKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJu
KCJpb3ZhIGZsdXNoIHF1ZXVlIGluaXRpYWxpemF0aW9uIGZhaWxlZFxuIik7Cj4+IC3CoMKgwqDC
oMKgwqDCoCBlbHNlCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+dHlwZSA9IElP
TU1VX0RPTUFJTl9ETUE7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb29raWUtPmZxX2RvbWFpbiA9IGRvbWFpbjsKPj4gK8KgwqDCoMKg
wqDCoMKgIH0KPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIGlvdmFfcmVzZXJ2
ZV9pb21tdV9yZWdpb25zKGRldiwgZG9tYWluKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBpbmRleCA4MzMzYzMzNDg5MWUu
LmQ3ZWFhY2FlMDk0NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBAQCAtMTM1LDYgKzEzNSw5IEBAIHN0YXRpYyBp
bnQgX19pbml0IGlvbW11X3N1YnN5c19pbml0KHZvaWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4+IMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgIGlmICghaW9tbXVfZGVmYXVsdF9wYXNzdGhyb3Vn
aCgpICYmICFpb21tdV9kbWFfc3RyaWN0KQo+PiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfZGVmX2Rv
bWFpbl90eXBlID0gSU9NTVVfRE9NQUlOX0RNQV9GUTsKPj4gKwo+PiDCoMKgwqDCoMKgIHByX2lu
Zm8oIkRlZmF1bHQgZG9tYWluIHR5cGU6ICVzICVzXG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
aW9tbXVfZG9tYWluX3R5cGVfc3RyKGlvbW11X2RlZl9kb21haW5fdHlwZSksCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9ETUFfQVBJKSA/Cj4+
IEBAIC0zNTIsMTUgKzM1NSw2IEBAIHZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3QoYm9vbCBzdHJp
Y3QpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gc3RyaWN0Owo+PiDC
oCB9Cj4+IC1ib29sIGlvbW11X2dldF9kbWFfc3RyaWN0KHN0cnVjdCBpb21tdV9kb21haW4gKmRv
bWFpbikKPj4gLXsKPj4gLcKgwqDCoCAvKiBvbmx5IGFsbG93IGxhenkgZmx1c2hpbmcgZm9yIERN
QSBkb21haW5zICovCj4+IC3CoMKgwqAgaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5f
RE1BKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGlvbW11X2RtYV9zdHJpY3Q7Cj4+IC3CoMKg
wqAgcmV0dXJuIHRydWU7Cj4+IC19Cj4+IC1FWFBPUlRfU1lNQk9MX0dQTChpb21tdV9nZXRfZG1h
X3N0cmljdCk7Cj4+IC0KPj4gwqAgc3RhdGljIHNzaXplX3QgaW9tbXVfZ3JvdXBfYXR0cl9zaG93
KHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYXR0cmlidXRlICpfX2F0dHIsIGNoYXIgKmJ1ZikKPj4gwqAg
ewo+PiBAQCAtNzY0LDcgKzc1OCw3IEBAIHN0YXRpYyBpbnQgCj4+IGlvbW11X2NyZWF0ZV9kZXZp
Y2VfZGlyZWN0X21hcHBpbmdzKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsCj4+IMKgwqDCoMKg
wqAgdW5zaWduZWQgbG9uZyBwZ19zaXplOwo+PiDCoMKgwqDCoMKgIGludCByZXQgPSAwOwo+PiAt
wqDCoMKgIGlmICghZG9tYWluIHx8IGRvbWFpbi0+dHlwZSAhPSBJT01NVV9ET01BSU5fRE1BKQo+
PiArwqDCoMKgIGlmICghZG9tYWluIHx8ICEoZG9tYWluLT50eXBlICYgX19JT01NVV9ET01BSU5f
RE1BX0FQSSkpCj4gCj4gTml0OiBwcm9iYWJseSBtb3ZlIGFib3ZlIGNoYW5nZSB0byBwYXRjaCAx
ND8KCkluZGVlZCBJJ20gbm90IHN1cmUgd2h5IHRoaXMgb25lIGVuZGVkIHVwIGhlcmUsIGdvb2Qg
Y2F0Y2ghCgpUaGFua3MsClJvYmluLgoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+
PiDCoMKgwqDCoMKgIEJVR19PTighZG9tYWluLT5wZ3NpemVfYml0bWFwKTsKPj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+PiBpbmRl
eCA1NjUxOTExMGQ0M2YuLjU1N2M0YzEyZTJjZiAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51
eC9pb21tdS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+PiBAQCAtNDg0LDcgKzQ4
NCw2IEBAIGludCBpb21tdV9zZXRfcGd0YWJsZV9xdWlya3Moc3RydWN0IGlvbW11X2RvbWFpbiAK
Pj4gKmRvbWFpbiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcXVpcmtzKTsK
Pj4gwqAgdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdChib29sIHZhbCk7Cj4+IC1ib29sIGlvbW11
X2dldF9kbWFfc3RyaWN0KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbik7Cj4+IMKgIGV4dGVy
biBpbnQgcmVwb3J0X2lvbW11X2ZhdWx0KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3Ry
dWN0IAo+PiBkZXZpY2UgKmRldiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdW5zaWduZWQgbG9uZyBpb3ZhLCBpbnQgZmxhZ3MpOwo+Pgo+IAo+IEJlc3QgcmVnYXJk
cywKPiBiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
