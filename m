Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F7C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 11:06:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9784E613AE
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 11:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9784E613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C8F3401D8;
	Tue, 22 Jun 2021 11:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcbAAPgKxcHx; Tue, 22 Jun 2021 11:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8D2E4029E;
	Tue, 22 Jun 2021 11:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AFADC0010;
	Tue, 22 Jun 2021 11:06:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6E1EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0A4B402B1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYtg4T4Y4_0U for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 11:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 999FE401D8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:06:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 779A231B;
 Tue, 22 Jun 2021 04:06:48 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880143F694;
 Tue, 22 Jun 2021 04:06:46 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8376f5ec-f228-0e82-a032-401f91b6aa3b@arm.com>
Date: Tue, 22 Jun 2021 12:06:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
Content-Language: en-GB
Cc: dpsmith@apertussolutions.com, luto@amacapital.net, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
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

T24gMjAyMS0wNi0yMSAxODo1MSwgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4gT24gNi8xOC8yMSAy
OjMyIFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEtMDYtMTggMTc6MTIsIFJvc3Mg
UGhpbGlwc29uIHdyb3RlOgo+Pj4gVGhlIElPTU1VIHNob3VsZCBhbHdheXMgYmUgc2V0IHRvIGRl
ZmF1bHQgdHJhbnNsYXRlZCB0eXBlIGFmdGVyCj4+PiB0aGUgUE1ScyBhcmUgZGlzYWJsZWQgdG8g
cHJvdGVjdCB0aGUgTUxFIGZyb20gRE1BLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFJvc3MgUGhp
bGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNSArKysrKwo+Pj4gIMKgIGRyaXZlcnMvaW9tbXUvaW9t
bXUuY8KgwqDCoMKgwqDCoCB8IDYgKysrKystCj4+PiAgwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4gaW5k
ZXggYmUzNTI4NC4uNGYwMjU2ZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+PiBAQCAtNDEs
NiArNDEsNyBAQAo+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0Lmg+Cj4+PiAgwqAg
I2luY2x1ZGUgPGxpbnV4L2NyYXNoX2R1bXAuaD4KPj4+ICDCoCAjaW5jbHVkZSA8bGludXgvbnVt
YS5oPgo+Pj4gKyNpbmNsdWRlIDxsaW51eC9zbGF1bmNoLmg+Cj4+PiAgwqAgI2luY2x1ZGUgPGFz
bS9pcnFfcmVtYXBwaW5nLmg+Cj4+PiAgwqAgI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+Cj4+
PiAgwqAgI2luY2x1ZGUgPGFzbS9pb21tdS5oPgo+Pj4gQEAgLTI4NzcsNiArMjg3OCwxMCBAQCBz
dGF0aWMgYm9vbCBkZXZpY2VfaXNfcm1ycl9sb2NrZWQoc3RydWN0IGRldmljZQo+Pj4gKmRldikK
Pj4+ICDCoMKgICovCj4+PiAgwqAgc3RhdGljIGludCBkZXZpY2VfZGVmX2RvbWFpbl90eXBlKHN0
cnVjdCBkZXZpY2UgKmRldikKPj4+ICDCoCB7Cj4+PiArwqDCoMKgIC8qIERvIG5vdCBhbGxvdyBp
ZGVudGl0eSBkb21haW4gd2hlbiBTZWN1cmUgTGF1bmNoIGlzIGNvbmZpZ3VyZWQgKi8KPj4+ICvC
oMKgwqAgaWYgKHNsYXVuY2hfZ2V0X2ZsYWdzKCkgJiBTTF9GTEFHX0FDVElWRSkKPj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gSU9NTVVfRE9NQUlOX0RNQTsKPj4KPj4gSXMgdGhpcyBzcGVjaWZp
YyB0byBJbnRlbD8gSXQgc2VlbXMgbGlrZSBpdCBjb3VsZCBlYXNpbHkgYmUgZG9uZQo+PiBjb21t
b25seSBsaWtlIHRoZSBjaGVjayBmb3IgdW50cnVzdGVkIGV4dGVybmFsIGRldmljZXMuCj4gCj4g
SXQgaXMgY3VycmVudGx5IEludGVsIG9ubHkgYnV0IHRoYXQgd2lsbCBjaGFuZ2UuIEkgd2lsbCBs
b29rIGludG8gd2hhdAo+IHlvdSBzdWdnZXN0LgoKWWVhaCwgaXQncyBzaW1wbGUgYW5kIHVub2J0
cnVzaXZlIGVub3VnaCB0aGF0IEkgcmVja29uIGl0J3Mgd29ydGggZ29pbmcgCnN0cmFpZ2h0IHRv
IHRoZSBjb21tb24gdmVyc2lvbiBpZiBpdCdzIHdvcnRoIGRvaW5nIGF0IGFsbC4KCj4+PiArCj4+
PiAgwqDCoMKgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYpKSB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOwo+Pj4gIMKgIGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+
IGluZGV4IDgwOGFiNzBkLi5kNDliN2RkIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9p
b21tdS5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+IEBAIC0yMyw2ICsyMyw3
IEBACj4+PiAgwqAgI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+Cj4+PiAgwqAgI2luY2x1ZGUg
PGxpbnV4L2ZzbC9tYy5oPgo+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPj4+ICsj
aW5jbHVkZSA8bGludXgvc2xhdW5jaC5oPgo+Pj4gIMKgICNpbmNsdWRlIDx0cmFjZS9ldmVudHMv
aW9tbXUuaD4KPj4+ICDCoCDCoCBzdGF0aWMgc3RydWN0IGtzZXQgKmlvbW11X2dyb3VwX2tzZXQ7
Cj4+PiBAQCAtMjc2MSw3ICsyNzYyLDEwIEBAIHZvaWQgaW9tbXVfc2V0X2RlZmF1bHRfcGFzc3Ro
cm91Z2goYm9vbCBjbWRfbGluZSkKPj4+ICDCoCB7Cj4+PiAgwqDCoMKgwqDCoCBpZiAoY21kX2xp
bmUpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2NtZF9saW5lIHw9IElPTU1VX0NNRF9M
SU5FX0RNQV9BUEk7Cj4+PiAtwqDCoMKgIGlvbW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1VX0RP
TUFJTl9JREVOVElUWTsKPj4+ICsKPj4+ICvCoMKgwqAgLyogRG8gbm90IGFsbG93IGlkZW50aXR5
IGRvbWFpbiB3aGVuIFNlY3VyZSBMYXVuY2ggaXMgY29uZmlndXJlZCAqLwo+Pj4gK8KgwqDCoCBp
ZiAoIShzbGF1bmNoX2dldF9mbGFncygpICYgU0xfRkxBR19BQ1RJVkUpKQo+Pj4gK8KgwqDCoMKg
wqDCoMKgIGlvbW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1VX0RPTUFJTl9JREVOVElUWTsKPj4K
Pj4gUXVpZXRseSBpZ25vcmluZyB0aGUgc2V0dGluZyBhbmQgcG9zc2libHkgbGVhdmluZyBpb21t
dV9kZWZfZG9tYWluX3R5cGUKPj4gdW5pbml0aWFsaXNlZCAobm90ZSB0aGF0IDAgaXMgbm90IGFj
dHVhbGx5IGEgdXNhYmxlIHR5cGUpIGRvZXNuJ3Qgc2VlbQo+PiBncmVhdC4gQUZBSUNTIHRoaXMg
cHJvYmFibHkgd2FycmFudHMgc2ltaWxhciB0cmVhdG1lbnQgdG8gdGhlCj4gCj4gT2sgc28gSSBn
dWVzcyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2V0IGl0IHRvIElPTU1VX0RPTUFJTl9ETUEgZXZl
bnQKPiB0aG91Z2ggcGFzc3Rocm91Z2ggd2FzIHJlcXVlc3RlZC4gT3IgcGVyaGFwcyBzb21ldGhp
bmcgbW9yZSBpcyBuZWVkZWQgaGVyZT8KPiAKPj4gbWVtX2VuY3J5cHRfYWN0aXZlKCkgY2FzZSAt
IHRoZXJlIGRvZXNuJ3Qgc2VlbSBhIGdyZWF0IGRlYWwgb2YgdmFsdWUgaW4KPj4gdHJ5aW5nIHRv
IHNhdmUgdXNlcnMgZnJvbSB0aGVtc2VsdmVzIGlmIHRoZXkgY2FyZSBhYm91dCBtZWFzdXJlZCBi
b290Cj4+IHlldCBleHBsaWNpdGx5IHBhc3Mgb3B0aW9ucyB3aGljaCBtYXkgY29tcHJvbWlzZSBt
ZWFzdXJlZCBib290LiBJZiB5b3UKPj4gcmVhbGx5IHdhbnQgdG8gZ28gZG93biB0aGF0IHJvdXRl
IHRoZXJlJ3MgYXQgbGVhc3QgdGhlIHN5c2ZzIGludGVyZmFjZQo+PiB5b3UnZCBuZWVkIHRvIG5v
YmJsZSBhcyB3ZWxsLCBub3QgdG8gbWVudGlvbiB0aGUgdmFyaW91cyB3YXlzIG9mCj4+IGNvbXBs
ZXRlbHkgZGlzYWJsaW5nIElPTU1Vcy4uLgo+IAo+IERvaW5nIGEgc2VjdXJlIGxhdW5jaCB3aXRo
IHRoZSBrZXJuZWwgaXMgbm90IGEgZ2VuZXJhbCBwdXJwb3NlIHVzZXIgdXNlCj4gY2FzZS4gQSBs
b3Qgb2Ygd29yayBpcyBkb25lIHRvIHNlY3VyZSB0aGUgZW52aXJvbm1lbnQuIEFsbG93aW5nCj4g
cGFzc3Rocm91Z2ggbW9kZSB3b3VsZCBsZWF2ZSB0aGUgc2VjdXJlIGxhdW5jaCBrZXJuZWwgZXhw
b3NlZCB0byBETUEuIEkKPiB0aGluayB3aGF0IHdlIGFyZSB0cnlpbmcgdG8gZG8gaGVyZSBpcyB3
aGF0IHdlIGludGVuZCB0aG91Z2ggdGhlcmUgbWF5Cj4gYmUgYSBiZXR0ZXIgd2F5IG9yIHBlcmhh
cHMgaXQgaXMgaW5jb21wbGV0ZSBhcyB5b3Ugc3VnZ2VzdC4KCk9uIHNlY29uZCB0aG91Z2h0cyB0
aGlzIGlzIG92ZXJraWxsIGFueXdheSAtIGlmIHlvdSBkbyBob29rIAppb21tdV9nZXRfZGVmX2Rv
bWFpbl90eXBlKCksIHlvdSdyZSBkb25lIChpbiB0ZXJtcyBvZiB0aGUga2VybmVsLW1hbmFnZWQg
CnNldHRpbmcsIGF0IGxlYXN0KTsgaXQgZG9lc24ndCBtYXR0ZXIgd2hhdCBpb21tdV9kZWZfZG9t
YWluX3R5cGUgZ2V0cyAKc2V0IHRvIGlmIHdpbGwgbmV2ZXIgZ2V0IHVzZWQuIEhvd2V2ZXIsIHNp
bmNlIHRoaXMgaXNuJ3QgcmVhbGx5IGEgCnBlci1kZXZpY2UgdGhpbmcsIGl0IG1pZ2h0IGJlIG1v
cmUgc2VtYW50aWNhbGx5IGFwcHJvcHJpYXRlIHRvIGxlYXZlIAp0aGF0IGFsb25lIGFuZCBpbnN0
ZWFkIG9ubHkgbWFzc2FnZSB0aGUgZGVmYXVsdCB0eXBlIGluIAppb21tdV9zdWJzeXNfaW5pdCgp
LCBhcyBmb3IgbWVtb3J5IGVuY3J5cHRpb24uCgpXaGVuIHlvdSBzYXkgInNlY3VyZSB0aGUgZW52
aXJvbm1lbnQiLCB3aGF0J3MgdGhlIGFjdHVhbCB0aHJlYXQgbW9kZWwgCmhlcmUsIGkuZS4gd2hv
J3Mgc2VjdXJpbmcgd2hhdCBhZ2FpbnN0IHdob20/IElmIGl0J3MgYSBkZXZpY2UgbG9ja2Rvd24g
CnR5cGUgdGhpbmcgd2hlcmUgdGhlIHN5c3RlbSBvd25lciB3YW50cyB0byBkZWZlbmQgYWdhaW5z
dCB0aGUgZW5kIHVzZXIgCnRyeWluZyB0byBtZXNzIHdpdGggdGhlIHNvZnR3YXJlIHN0YWNrIG9y
IGdhaW4gYWNjZXNzIHRvIHBhcnRzIHRoZXkgCnNob3VsZG4ndCwgdGhlbiBwb3NzaWJseSB5b3Ug
Y2FuIHRydXN0IHRoZSBjb21tYW5kIGxpbmUsIGJ1dCB0aGVyZSBhcmUgCmRlZmluaXRlbHkgb3Ro
ZXIgcGxhY2VzIHdoaWNoIG5lZWQgY29uc2lkZXJhdGlvbi4gSWYgb24gdGhlIG90aGVyIGhhbmQg
Cml0J3MgbW9yZSBhYm91dCBnaXZpbmcgdGhlIGVuZCB1c2VyIGNvbmZpZGVuY2UgdGhhdCB0aGVp
ciBjaG9pY2Ugb2YgCnNvZnR3YXJlIHN0YWNrIGlzbid0IGJlaW5nIGludGVyZmVyZWQgd2l0aCBi
eSBhIG1hbGljaW91cyBob3N0IG9yIApleHRlcm5hbCB0aGlyZCBwYXJ0aWVzLCB0aGVuIGl0IHBy
b2JhYmx5IGxlYW5zIHRvd2FyZHMgdGhlIG9wcG9zaXRlIApiZWluZyB0cnVlLi4uCgpJZiB0aGUg
Y29tbWFuZCBsaW5lICppcyogd2l0aGluIHRoZSB0aHJlYXQgbW9kZWwsIGNvbnNpZGVyICJpb21t
dT1vZmYiIAphbmQvb3IgImludGVsX2lvbW11PW9mZiIgZm9yIGV4YW1wbGU6IEkgZG9uJ3Qga25v
dyBob3cgUE1ScyB3b3JrLCBidXQgSSAKY2FuIG9ubHkgaW1hZ2luZSB0aGF0IHRoYXQncyBsaWFi
bGUgdG8gbGVhdmUgdGhpbmdzIGVpdGhlciB3aWRlIG9wZW4sIG9yIApibG9ja2VkIHRvIHRoZSBw
b2ludCBvZiBubyBETUEgd29ya2luZyBhdCBhbGwsIG5laXRoZXIgb2Ygd2hpY2ggc2VlbXMgdG8g
CmJlIHdoYXQgeW91IHdhbnQuIEknbSBndWVzc2luZyAiaW50ZWxfaW9tbXU9dGJvb3Rfbm9mb3Jj
ZSIgbWlnaHQgaGF2ZSAKc29tZSByZWxldmFudCBpbXBsaWNhdGlvbnMgdG9vLgoKPj4gSXQgbWln
aHQgYmUgcmVhc29uYWJsZSB0byBtYWtlIElPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0ggZGVwZW5k
IG9uCj4+ICFTRUNVUkVfTEFVTkNIIGZvciBjbGFyaXR5IHRob3VnaC4KPiAKPiBUaGlzIGNhbWUg
ZnJvbSBhIHNwZWNpZmljIHJlcXVlc3QgdG8gbm90IG1ha2UgZGlzYWJsaW5nIElPTU1VIG1vZGVz
Cj4gYnVpbGQgdGltZSBkZXBlbmRlbnQuIFRoaXMgaXMgYmVjYXVzZSBhIHNlY3VyZSBsYXVuY2gg
ZW5hYmxlZCBrZXJuZWwgY2FuCj4gYWxzbyBiZSBib290ZWQgYXMgYSBnZW5lcmFsIHB1cnBvc2Ug
a2VybmVsIGluIGNhc2VzIHdoZXJlIHRoaXMgaXMgZGVzaXJlZC4KCkFoLCB0aGFua3MgZm9yIGNs
YXJpZnlpbmcgLSBJIHdhcyB3b25kZXJpbmcgYWJvdXQgdGhhdCBhc3BlY3QuIEZXSVcsIApub3Rl
IHRoYXQgdGhhdCB3b3VsZG4ndCBhY3R1YWxseSBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkgLSBp
dCdzIGEgCm5vbi1kZWZhdWx0IGNvbmZpZyBvcHRpb24gYW55d2F5LCBhbmQgdXNlcnMgY291bGQg
c3RpbGwgb3ZlcnJpZGUgaXQgCmVpdGhlciB3YXkgaW4gYSBub24tc2VjdXJlLWxhdW5jaCBzZXR1
cCAtIGJ1dCBpdCBzb3VuZHMgbGlrZSBpdCBtaWdodCBiZSAKZWZmZWN0aXZlbHkgc3VwZXJmbHVv
dXMgaWYgeW91IGRvIG5lZWQgdG8gbWFrZSBhIG1vcmUgYWN0aXZlIHJ1bnRpbWUgCmRlY2lzaW9u
IGFueXdheS4KCkNoZWVycywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
