Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB943C433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 07:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B126819BC;
	Tue, 19 Apr 2022 07:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 746RpoPW6MOU; Tue, 19 Apr 2022 07:20:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 09A4A8148E;
	Tue, 19 Apr 2022 07:20:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D09FAC0033;
	Tue, 19 Apr 2022 07:20:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4C98C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 07:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C5DD41DC8
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 07:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2ohWdb4CJkn for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 07:20:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6541341D75
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 07:20:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759641042;
 Tue, 19 Apr 2022 00:20:30 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE363F766;
 Tue, 19 Apr 2022 00:20:27 -0700 (PDT)
Message-ID: <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
Date: Tue, 19 Apr 2022 08:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

T24gMjAyMi0wNC0xOSAwMDozNywgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMjAyMi80LzE5IDY6MDks
IFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMi0wNC0xNiAwMTowNCwgTHUgQmFvbHUgd3Jv
dGU6Cj4+PiBPbiAyMDIyLzQvMTQgMjA6NDIsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+PiBAQCAt
MTg4MywyNyArMTkwMCwxMiBAQCBzdGF0aWMgaW50IGlvbW11X2J1c19pbml0KHN0cnVjdCBidXNf
dHlwZSAqYnVzKQo+Pj4+IMKgwqAgKi8KPj4+PiDCoCBpbnQgYnVzX3NldF9pb21tdShzdHJ1Y3Qg
YnVzX3R5cGUgKmJ1cywgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzKQo+Pj4+IMKgIHsKPj4+
PiAtwqDCoMKgIGludCBlcnI7Cj4+Pj4gLQo+Pj4+IC3CoMKgwqAgaWYgKG9wcyA9PSBOVUxMKSB7
Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3BzID0gTlVMTDsKPj4+PiAtwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4gLcKgwqDCoCB9Cj4+Pj4gLQo+Pj4+IC3CoMKgwqAgaWYg
KGJ1cy0+aW9tbXVfb3BzICE9IE5VTEwpCj4+Pj4gK8KgwqDCoCBpZiAoYnVzLT5pb21tdV9vcHMg
JiYgb3BzICYmIGJ1cy0+aW9tbXVfb3BzICE9IG9wcykKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FQlVTWTsKPj4+PiDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3BzID0gb3BzOwo+Pj4K
Pj4+IERvIHdlIHN0aWxsIG5lZWQgdG8ga2VlcCBhYm92ZSBsaW5lcyBpbiBidXNfc2V0X2lvbW11
KCk/Cj4+Cj4+IEl0IHByZXNlcnZlcyB0aGUgZXhpc3RpbmcgYmVoYXZpb3VyIHVudGlsIGVhY2gg
Y2FsbHNpdGUgYW5kIGl0cyAKPj4gYXNzb2NpYXRlZCBlcnJvciBoYW5kbGluZyBhcmUgcmVtb3Zl
ZCBsYXRlciBvbiwgd2hpY2ggc2VlbXMgbGlrZSBhcyAKPj4gZ29vZCBhIHRoaW5nIHRvIGRvIGFz
IGFueS4gU2luY2UgSSdtIGFscmVhZHkgcmVsYXhpbmcgCj4+IGlvbW11X2RldmljZV9yZWdpc3Rl
cigpIHRvIGEgd2Fybi1idXQtY29udGludWUgYmVoYXZpb3VyIHdoaWxlIGl0IAo+PiBrZWVwcyB0
aGUgYnVzIG9wcyBvbiBsaWZlLXN1cHBvcnQgaW50ZXJuYWxseSwgSSBmaWd1cmVkIG5vdCBjaGFu
Z2luZyAKPj4gdG9vIG11Y2ggYXQgb25jZSB3b3VsZCBtYWtlIGl0IGVhc2llciB0byBiaXNlY3Qg
YW55IHBvdGVudGlhbCBpc3N1ZXMgCj4+IGFyaXNpbmcgZnJvbSB0aGlzIGZpcnN0IHN0ZXAuCj4g
Cj4gRmFpciBlbm91Z2guIFRoYW5rIHlvdSBmb3IgdGhlIGV4cGxhbmF0aW9uLgo+IAo+IERvIHlv
dSBoYXZlIGEgcHVibGljIHRyZWUgdGhhdCBJIGNvdWxkIHB1bGwgdGhlc2UgcGF0Y2hlcyBhbmQg
dHJ5IHRoZW0KPiBvbiBhbiBJbnRlbCBoYXJkd2FyZT8gT3IgcGVyaGFwcyB5b3UgaGF2ZSBkb25l
IHRoaXM/IEkgbGlrZSB0aGUgd2hvbGUKPiBpZGVhIG9mIHRoaXMgc2VyaWVzLCBidXQgaXQncyBi
ZXR0ZXIgdG8gdHJ5IGl0IHdpdGggYSByZWFsIGhhcmR3YXJlLgoKSSBoYXZlbid0IGJvdGhlcmVk
IHdpdGggc2VwYXJhdGUgYnJhbmNoZXMgc2luY2UgdGhlcmUncyBzbyBtYW55IApkaWZmZXJlbnQg
cGllY2VzIGluLWZsaWdodCwgYnV0IG15IGNvbXBsZXRlICh1bnN0YWJsZSkgZGV2ZWxvcG1lbnQg
CmJyYW5jaCBjYW4gYmUgZm91bmQgaGVyZToKCmh0dHBzOi8vZ2l0bGFiLmFybS5jb20vbGludXgt
YXJtL2xpbnV4LXJtLy0vY29tbWl0cy9pb21tdS9idXMKCkZvciBub3cgSSdkIHJlY29tbWVuZCB3
aW5kaW5nIHRoZSBoZWFkIGJhY2sgdG8gImlvbW11OiBDbGVhbiB1cCAKYnVzX3NldF9pb21tdSgp
IiBmb3IgdGVzdGluZyAtIHNvbWUgb2YgdGhlIHBhdGNoZXMgYWJvdmUgdGhhdCBoYXZlIAphbHJl
YWR5IGJlZW4gcG9zdGVkIGFuZCBwaWNrZWQgdXAgYnkgdGhlaXIgcmVzcGVjdGl2ZSBzdWJzeXN0
ZW1zLCBidXQgCm90aGVycyBhcmUgaW5jb21wbGV0ZSBhbmQgYmFyZWx5IGNvbXBpbGUtdGVzdGVk
LiBJJ2xsIHByb2JhYmx5IHJlYXJyYW5nZSAKaXQgbGF0ZXIgdGhpcyB3ZWVrIHRvIGJldHRlciBy
ZWZsZWN0IHdoYXQncyBoYXBwZW5lZCBzbyBmYXIuCgpDaGVlcnMsClJvYmluLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
