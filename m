Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B7BC433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 08:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16FF76058B;
	Sat, 23 Apr 2022 08:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jb5tQXETOWvz; Sat, 23 Apr 2022 08:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA72060615;
	Sat, 23 Apr 2022 08:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4A4BC0039;
	Sat, 23 Apr 2022 08:02:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 823C9C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FA82832A9
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZgOI05HuJGQ0 for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 08:02:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4968483294
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650700925; x=1682236925;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oYSa9eG/ZLGjKfhpFORv9gMTTxmsCZoyxnq7RTpNwu0=;
 b=YwbPFJYI2FU8lWbYN26l2i0vYKw7dhzuOG8up5aDqKcwStJQ+deqJ3id
 eVfeFFHQv69DirekLq5N0FfuibT3EaPGqlWQACn7jYzXYfyBgYr1jeKHY
 7tBUmZxrrE0Piv21Z3XUV11ZAczgCv9juC50T7qEe5p0pbLMV30vfMgKy
 fG1zM23M1q/ydZ1Xj/2Z03L1vSDd96H3uLqIH/pQpsuXchqae+MGLzpA8
 qW5KahI6CONeXB8gWvbOeQkyTUJuCP2MZwncRV+Q48um8C2tSGxByk3Je
 kEDwMdEmzCWdCpb45RWigcF5+szr9TcyRQ02rJLGxcvajvpDK8XGfrd2b A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262459465"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="262459465"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 01:02:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="578312714"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 01:02:00 -0700
Message-ID: <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
Date: Sat, 23 Apr 2022 16:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
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

SGkgUm9iaW4sCgpPbiAyMDIyLzQvMTkgMTU6MjAsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIyLTA0LTE5IDAwOjM3LCBMdSBCYW9sdSB3cm90ZToKPj4gT24gMjAyMi80LzE5IDY6MDksIFJv
YmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjItMDQtMTYgMDE6MDQsIEx1IEJhb2x1IHdyb3Rl
Ogo+Pj4+IE9uIDIwMjIvNC8xNCAyMDo0MiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+PiBAQCAt
MTg4MywyNyArMTkwMCwxMiBAQCBzdGF0aWMgaW50IGlvbW11X2J1c19pbml0KHN0cnVjdCBidXNf
dHlwZSAKPj4+Pj4gKmJ1cykKPj4+Pj4gwqDCoCAqLwo+Pj4+PiDCoCBpbnQgYnVzX3NldF9pb21t
dShzdHJ1Y3QgYnVzX3R5cGUgKmJ1cywgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzKQo+Pj4+
PiDCoCB7Cj4+Pj4+IC3CoMKgwqAgaW50IGVycjsKPj4+Pj4gLQo+Pj4+PiAtwqDCoMKgIGlmIChv
cHMgPT0gTlVMTCkgewo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgYnVzLT5pb21tdV9vcHMgPSBOVUxM
Owo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+IC3CoMKgwqAgfQo+Pj4+PiAt
Cj4+Pj4+IC3CoMKgwqAgaWYgKGJ1cy0+aW9tbXVfb3BzICE9IE5VTEwpCj4+Pj4+ICvCoMKgwqAg
aWYgKGJ1cy0+aW9tbXVfb3BzICYmIG9wcyAmJiBidXMtPmlvbW11X29wcyAhPSBvcHMpCj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOwo+Pj4+PiDCoMKgwqDCoMKgIGJ1cy0+
aW9tbXVfb3BzID0gb3BzOwo+Pj4+Cj4+Pj4gRG8gd2Ugc3RpbGwgbmVlZCB0byBrZWVwIGFib3Zl
IGxpbmVzIGluIGJ1c19zZXRfaW9tbXUoKT8KPj4+Cj4+PiBJdCBwcmVzZXJ2ZXMgdGhlIGV4aXN0
aW5nIGJlaGF2aW91ciB1bnRpbCBlYWNoIGNhbGxzaXRlIGFuZCBpdHMgCj4+PiBhc3NvY2lhdGVk
IGVycm9yIGhhbmRsaW5nIGFyZSByZW1vdmVkIGxhdGVyIG9uLCB3aGljaCBzZWVtcyBsaWtlIGFz
IAo+Pj4gZ29vZCBhIHRoaW5nIHRvIGRvIGFzIGFueS4gU2luY2UgSSdtIGFscmVhZHkgcmVsYXhp
bmcgCj4+PiBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKSB0byBhIHdhcm4tYnV0LWNvbnRpbnVlIGJl
aGF2aW91ciB3aGlsZSBpdCAKPj4+IGtlZXBzIHRoZSBidXMgb3BzIG9uIGxpZmUtc3VwcG9ydCBp
bnRlcm5hbGx5LCBJIGZpZ3VyZWQgbm90IGNoYW5naW5nIAo+Pj4gdG9vIG11Y2ggYXQgb25jZSB3
b3VsZCBtYWtlIGl0IGVhc2llciB0byBiaXNlY3QgYW55IHBvdGVudGlhbCBpc3N1ZXMgCj4+PiBh
cmlzaW5nIGZyb20gdGhpcyBmaXJzdCBzdGVwLgo+Pgo+PiBGYWlyIGVub3VnaC4gVGhhbmsgeW91
IGZvciB0aGUgZXhwbGFuYXRpb24uCj4+Cj4+IERvIHlvdSBoYXZlIGEgcHVibGljIHRyZWUgdGhh
dCBJIGNvdWxkIHB1bGwgdGhlc2UgcGF0Y2hlcyBhbmQgdHJ5IHRoZW0KPj4gb24gYW4gSW50ZWwg
aGFyZHdhcmU/IE9yIHBlcmhhcHMgeW91IGhhdmUgZG9uZSB0aGlzPyBJIGxpa2UgdGhlIHdob2xl
Cj4+IGlkZWEgb2YgdGhpcyBzZXJpZXMsIGJ1dCBpdCdzIGJldHRlciB0byB0cnkgaXQgd2l0aCBh
IHJlYWwgaGFyZHdhcmUuCj4gCj4gSSBoYXZlbid0IGJvdGhlcmVkIHdpdGggc2VwYXJhdGUgYnJh
bmNoZXMgc2luY2UgdGhlcmUncyBzbyBtYW55IAo+IGRpZmZlcmVudCBwaWVjZXMgaW4tZmxpZ2h0
LCBidXQgbXkgY29tcGxldGUgKHVuc3RhYmxlKSBkZXZlbG9wbWVudCAKPiBicmFuY2ggY2FuIGJl
IGZvdW5kIGhlcmU6Cj4gCj4gaHR0cHM6Ly9naXRsYWIuYXJtLmNvbS9saW51eC1hcm0vbGludXgt
cm0vLS9jb21taXRzL2lvbW11L2J1cwo+IAo+IEZvciBub3cgSSdkIHJlY29tbWVuZCB3aW5kaW5n
IHRoZSBoZWFkIGJhY2sgdG8gImlvbW11OiBDbGVhbiB1cCAKPiBidXNfc2V0X2lvbW11KCkiIGZv
ciB0ZXN0aW5nIC0gc29tZSBvZiB0aGUgcGF0Y2hlcyBhYm92ZSB0aGF0IGhhdmUgCj4gYWxyZWFk
eSBiZWVuIHBvc3RlZCBhbmQgcGlja2VkIHVwIGJ5IHRoZWlyIHJlc3BlY3RpdmUgc3Vic3lzdGVt
cywgYnV0IAo+IG90aGVycyBhcmUgaW5jb21wbGV0ZSBhbmQgYmFyZWx5IGNvbXBpbGUtdGVzdGVk
LiBJJ2xsIHByb2JhYmx5IHJlYXJyYW5nZSAKPiBpdCBsYXRlciB0aGlzIHdlZWsgdG8gYmV0dGVy
IHJlZmxlY3Qgd2hhdCdzIGhhcHBlbmVkIHNvIGZhci4KCkkgd291bmQgdGhlIGhlYWQgYmFjayB0
byAiaW9tbXU6IENsZWFuIHVwIGJ1c19zZXRfaW9tbXUiIGFuZCB0ZXN0ZWQgaXQKb24gYW4gSW50
ZWwgbWFjaGluZS4gSXQgZ290IHN0dWNrIGR1cmluZyBib290LiBUaGlzIHRlc3Qgd2FzIG9uIGEg
cmVtb3RlCm1hY2hpbmUgYW5kIEkgaGF2ZSBubyBtZWFucyB0byBhY2Nlc3MgaXQgcGh5c2ljYWxs
eS4gU28gSSBjYW4ndCBnZXQgYW55Cmtlcm5lbCBkZWJ1Z2dpbmcgbWVzc2FnZXMuIChJIGhhdmUg
dG8gd29yayBmcm9tIGhvbWUgdGhlc2UgZGF5cy4gOi0oKQoKSSBndWVzcyBpdCdzIGR1ZSB0byB0
aGUgZmFjdCB0aGF0IGludGVsX2lvbW11X3Byb2JlX2RldmljZSgpIGNhbGxiYWNrCm9ubHkgd29y
a3MgZm9yIHRoZSBwY2kgZGV2aWNlcy4gVGhlIGlzc3VlIG9jY3VycyB3aGVuIHByb2JpbmcgYSBk
ZXZpY2UKb3RoZXIgdGhhbiBhIFBDSSBvbmUuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
