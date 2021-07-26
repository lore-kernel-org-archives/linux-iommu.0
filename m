Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB30C432BE
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:30:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD1C60FBF
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CD1C60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D1C582AAA;
	Mon, 26 Jul 2021 08:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r3coUg2GyRmE; Mon, 26 Jul 2021 08:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45CB2829DB;
	Mon, 26 Jul 2021 08:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F299C0010;
	Mon, 26 Jul 2021 08:30:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2084AC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B4CE402B5
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EenFvqaqgkDz for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 08:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FB7F40271
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:30:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D75A106F;
 Mon, 26 Jul 2021 01:30:17 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4AEE3F66F;
 Mon, 26 Jul 2021 01:30:15 -0700 (PDT)
Subject: Re: [PATCH 17/23] iommu/vt-d: Prepare for multiple DMA domain types
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <11efdfa4ee223d12769d17459fcf789c626d7b82.1626888445.git.robin.murphy@arm.com>
 <7599b48f-169d-283f-782b-e54c667346e8@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fdf09426-d329-a212-6c5a-ddc9aadd77ec@arm.com>
Date: Mon, 26 Jul 2021 09:30:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7599b48f-169d-283f-782b-e54c667346e8@linux.intel.com>
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

T24gMjAyMS0wNy0yNCAwNjoyMywgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
MjAyMS83LzIyIDI6MjAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gSW4gcHJlcGFyYXRpb24gZm9y
IHRoZSBzdHJpY3QgdnMuIG5vbi1zdHJpY3QgZGVjaXNpb24gZm9yIERNQSBkb21haW5zIHRvCj4+
IGJlIGV4cHJlc3NlZCBpbiB0aGUgZG9tYWluIHR5cGUsIG1ha2Ugc3VyZSB3ZSBleHBvc2Ugb3Vy
IGZsdXNoIHF1ZXVlCj4+IGF3YXJlbmVzcyBieSBhY2NlcHRpbmcgdGhlIG5ldyBkb21haW4gdHlw
ZSwgYW5kIHRlc3QgdGhlIHNwZWNpZmljCj4+IGZlYXR1cmUgZmxhZyB3aGVyZSB3ZSB3YW50IHRv
IGlkZW50aWZ5IERNQSBkb21haW5zIGluIGdlbmVyYWwuIFRoZSBETUEKPj4gb3BzIHNldHVwIGNh
biBzaW1wbHkgYmUgbWFkZSB1bmNvbmRpdGlvbmFsLCBzaW5jZSBpb21tdS1kbWEgYWxyZWFkeQo+
PiBrbm93cyBub3QgdG8gdG91Y2ggaWRlbnRpdHkgZG9tYWlucy4KPj4KPj4gU2lnbmVkLW9mZi1i
eTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDE1ICsrKysrKy0tLS0tLS0tLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jCj4+IGluZGV4IGUyYWRkNWEwY2FlZi4uNzdkMzIyMjcyNzQzIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jCj4+IEBAIC02MDEsNyArNjAxLDcgQEAgc3RydWN0IGludGVsX2lvbW11ICpkb21haW5f
Z2V0X2lvbW11KHN0cnVjdCAKPj4gZG1hcl9kb21haW4gKmRvbWFpbikKPj4gwqDCoMKgwqDCoCBp
bnQgaW9tbXVfaWQ7Cj4+IMKgwqDCoMKgwqAgLyogc2lfZG9tYWluIGFuZCB2bSBkb21haW4gc2hv
dWxkIG5vdCBnZXQgaGVyZS4gKi8KPj4gLcKgwqDCoCBpZiAoV0FSTl9PTihkb21haW4tPmRvbWFp
bi50eXBlICE9IElPTU1VX0RPTUFJTl9ETUEpKQo+PiArwqDCoMKgIGlmIChXQVJOX09OKCEoZG9t
YWluLT5kb21haW4udHlwZSAmIF9fSU9NTVVfRE9NQUlOX0RNQSkpKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIE5VTEw7Cj4+IMKgwqDCoMKgwqAgZm9yX2VhY2hfZG9tYWluX2lvbW11KGlv
bW11X2lkLCBkb21haW4pCj4+IEBAIC0xMDM1LDcgKzEwMzUsNyBAQCBzdGF0aWMgc3RydWN0IGRt
YV9wdGUgKnBmbl90b19kbWFfcHRlKHN0cnVjdCAKPj4gZG1hcl9kb21haW4gKmRvbWFpbiwKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRldmFsID0gKCh1aW50NjRfdCl2aXJ0X3RvX2Rt
YV9wZm4odG1wX3BhZ2UpIDw8IAo+PiBWVERfUEFHRV9TSElGVCkgfCBETUFfUFRFX1JFQUQgfCBE
TUFfUFRFX1dSSVRFOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZG9tYWluX3Vz
ZV9maXJzdF9sZXZlbChkb21haW4pKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHRldmFsIHw9IERNQV9GTF9QVEVfWEQgfCBETUFfRkxfUFRFX1VTOwo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkb21haW4tPmRvbWFpbi50eXBlID09IElPTU1V
X0RPTUFJTl9ETUEpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRvbWFp
bi0+ZG9tYWluLnR5cGUgJiBfX0lPTU1VX0RPTUFJTl9ETUFfQVBJKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRldmFsIHw9IERNQV9GTF9QVEVfQUNDRVNT
Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChjbXB4Y2hnNjQoJnB0ZS0+dmFsLCAwVUxMLCBwdGV2YWwpKQo+PiBAQCAtMjM0
Niw3ICsyMzQ2LDcgQEAgX19kb21haW5fbWFwcGluZyhzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFp
biwgCj4+IHVuc2lnbmVkIGxvbmcgaW92X3BmbiwKPj4gwqDCoMKgwqDCoCBpZiAoZG9tYWluX3Vz
ZV9maXJzdF9sZXZlbChkb21haW4pKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhdHRyIHw9IERN
QV9GTF9QVEVfWEQgfCBETUFfRkxfUFRFX1VTOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGRvbWFp
bi0+ZG9tYWluLnR5cGUgPT0gSU9NTVVfRE9NQUlOX0RNQSkgewo+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKGRvbWFpbi0+ZG9tYWluLnR5cGUgJiBfX0lPTU1VX0RPTUFJTl9ETUFfQVBJKSB7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0dHIgfD0gRE1BX0ZMX1BURV9BQ0NFU1M7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwcm90ICYgRE1BX1BURV9XUklURSkKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdHRyIHw9IERNQV9GTF9QVEVfRElSVFk7
Cj4+IEBAIC00NTI4LDYgKzQ1MjgsNyBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RvbWFpbiAKPj4g
KmludGVsX2lvbW11X2RvbWFpbl9hbGxvYyh1bnNpZ25lZCB0eXBlKQo+PiDCoMKgwqDCoMKgIHN3
aXRjaCAodHlwZSkgewo+PiDCoMKgwqDCoMKgIGNhc2UgSU9NTVVfRE9NQUlOX0RNQToKPj4gK8Kg
wqDCoCBjYXNlIElPTU1VX0RPTUFJTl9ETUFfRlE6Cj4+IMKgwqDCoMKgwqAgY2FzZSBJT01NVV9E
T01BSU5fVU5NQU5BR0VEOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hcl9kb21haW4gPSBhbGxv
Y19kb21haW4oMCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWRtYXJfZG9tYWluKSB7Cj4+
IEBAIC01MTY0LDEyICs1MTY1LDggQEAgc3RhdGljIHZvaWQgaW50ZWxfaW9tbXVfcmVsZWFzZV9k
ZXZpY2Uoc3RydWN0IAo+PiBkZXZpY2UgKmRldikKPj4gwqAgc3RhdGljIHZvaWQgaW50ZWxfaW9t
bXVfcHJvYmVfZmluYWxpemUoc3RydWN0IGRldmljZSAqZGV2KQo+PiDCoCB7Cj4+IC3CoMKgwqAg
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KGRl
dik7Cj4+IC0KPj4gLcKgwqDCoCBpZiAoZG9tYWluICYmIGRvbWFpbi0+dHlwZSA9PSBJT01NVV9E
T01BSU5fRE1BKQo+PiAtwqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0dXBfZG1hX29wcyhkZXYsIDAs
IFU2NF9NQVgpOwo+PiAtwqDCoMKgIGVsc2UKPj4gLcKgwqDCoMKgwqDCoMKgIHNldF9kbWFfb3Bz
KGRldiwgTlVMTCk7Cj4+ICvCoMKgwqAgc2V0X2RtYV9vcHMoZGV2LCBOVUxMKTsKPiAKPiBJcyBp
dCByZWFzb25hYmxlIHRvIHJlbW92ZSBhYm92ZSBsaW5lPyBUaGUgaWRlYSBpcyB0aGF0IHZlbmRv
ciBpb21tdQo+IGRyaXZlciBzaG91bGQgbm90IG92ZXJyaWRlIHRoZSBkbWFfb3BzIGlmIGRldmlj
ZSBkb2Vzbid0IGhhdmUgYSBETUEKPiBkb21haW4uCgpBcyB0aGUgY29tbWl0IG1lc3NhZ2UgaW1w
bGllcywgdGhhdCdzIGV4YWN0bHkgaG93IGlvbW11X3NldHVwX2RtYV9vcHMoKSAKaGFzIGFsd2F5
cyBiZWhhdmVkIGFueXdheS4gVGhlcmUgc2hvdWxkIGJlIG5vIGZ1bmN0aW9uYWwgY2hhbmdlIGhl
cmUuCgpSb2Jpbi4KCj4+ICvCoMKgwqAgaW9tbXVfc2V0dXBfZG1hX29wcyhkZXYsIDAsIFU2NF9N
QVgpOwo+PiDCoCB9Cj4+IMKgIHN0YXRpYyB2b2lkIGludGVsX2lvbW11X2dldF9yZXN2X3JlZ2lv
bnMoc3RydWN0IGRldmljZSAqZGV2aWNlLAo+Pgo+IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
