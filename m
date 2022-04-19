Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E384AC433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 10:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59F4D423AF;
	Tue, 19 Apr 2022 10:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpuggyUUxkJS; Tue, 19 Apr 2022 10:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B21F841E6B;
	Tue, 19 Apr 2022 10:14:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D35CC002F;
	Tue, 19 Apr 2022 10:14:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD63DC002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 10:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA236402E1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 10:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCVP_qq9CefY for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 10:14:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED4E140102
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 10:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650363244; x=1681899244;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ENgwK0TaP8bWiUTpn5/Tdl3xdevlrL5xweddQzvJWlE=;
 b=Bg2h1W/epGakiiWPh4XOQZbsrxC9CUbsXb5ImBmzFJoZVGsytrB8ZK2O
 eBefSZuMnfF0BOjAOqb8HemR5tTkPIePgd6v2+1mpFzJ535miPQFCjMxS
 eLVylGUiNBUolpSsItPz1+aM86eFyyMQ7t5eYBPxvdDH9Kk0aOqojEkBi
 z0ixvuKxm3D0elXL8BVP7h6h6XYIK3TjvhGF9uQVjcMp18EY8tmskhnfo
 uhT8mZljVNmioBdAHDG0I7p8ZqS8LFAfrU1U3wUaoTKMKfd9G/WCq/6xf
 YOIqyl+MO7dKVfFvgYOU+x+Qu+Sd8VJBDkargC86jVUqnanBaT0E1ARkg Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263489054"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; d="scan'208";a="263489054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2022 03:14:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; d="scan'208";a="576030940"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.77])
 ([10.254.212.77])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2022 03:13:59 -0700
Message-ID: <8175f6b1-5170-f950-f3ed-7f445410a2c6@linux.intel.com>
Date: Tue, 19 Apr 2022 18:13:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
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

T24gMjAyMi80LzE5IDE1OjIwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNC0xOSAw
MDozNywgTHUgQmFvbHUgd3JvdGU6Cj4+IE9uIDIwMjIvNC8xOSA2OjA5LCBSb2JpbiBNdXJwaHkg
d3JvdGU6Cj4+PiBPbiAyMDIyLTA0LTE2IDAxOjA0LCBMdSBCYW9sdSB3cm90ZToKPj4+PiBPbiAy
MDIyLzQvMTQgMjA6NDIsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+Pj4gQEAgLTE4ODMsMjcgKzE5
MDAsMTIgQEAgc3RhdGljIGludCBpb21tdV9idXNfaW5pdChzdHJ1Y3QgYnVzX3R5cGUgCj4+Pj4+
ICpidXMpCj4+Pj4+IMKgwqAgKi8KPj4+Pj4gwqAgaW50IGJ1c19zZXRfaW9tbXUoc3RydWN0IGJ1
c190eXBlICpidXMsIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcykKPj4+Pj4gwqAgewo+Pj4+
PiAtwqDCoMKgIGludCBlcnI7Cj4+Pj4+IC0KPj4+Pj4gLcKgwqDCoCBpZiAob3BzID09IE5VTEwp
IHsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3BzID0gTlVMTDsKPj4+Pj4gLcKg
wqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+PiAtwqDCoMKgIH0KPj4+Pj4gLQo+Pj4+PiAtwqDC
oMKgIGlmIChidXMtPmlvbW11X29wcyAhPSBOVUxMKQo+Pj4+PiArwqDCoMKgIGlmIChidXMtPmlv
bW11X29wcyAmJiBvcHMgJiYgYnVzLT5pb21tdV9vcHMgIT0gb3BzKQo+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FQlVTWTsKPj4+Pj4gwqDCoMKgwqDCoCBidXMtPmlvbW11X29wcyA9
IG9wczsKPj4+Pgo+Pj4+IERvIHdlIHN0aWxsIG5lZWQgdG8ga2VlcCBhYm92ZSBsaW5lcyBpbiBi
dXNfc2V0X2lvbW11KCk/Cj4+Pgo+Pj4gSXQgcHJlc2VydmVzIHRoZSBleGlzdGluZyBiZWhhdmlv
dXIgdW50aWwgZWFjaCBjYWxsc2l0ZSBhbmQgaXRzIAo+Pj4gYXNzb2NpYXRlZCBlcnJvciBoYW5k
bGluZyBhcmUgcmVtb3ZlZCBsYXRlciBvbiwgd2hpY2ggc2VlbXMgbGlrZSBhcyAKPj4+IGdvb2Qg
YSB0aGluZyB0byBkbyBhcyBhbnkuIFNpbmNlIEknbSBhbHJlYWR5IHJlbGF4aW5nIAo+Pj4gaW9t
bXVfZGV2aWNlX3JlZ2lzdGVyKCkgdG8gYSB3YXJuLWJ1dC1jb250aW51ZSBiZWhhdmlvdXIgd2hp
bGUgaXQgCj4+PiBrZWVwcyB0aGUgYnVzIG9wcyBvbiBsaWZlLXN1cHBvcnQgaW50ZXJuYWxseSwg
SSBmaWd1cmVkIG5vdCBjaGFuZ2luZyAKPj4+IHRvbyBtdWNoIGF0IG9uY2Ugd291bGQgbWFrZSBp
dCBlYXNpZXIgdG8gYmlzZWN0IGFueSBwb3RlbnRpYWwgaXNzdWVzIAo+Pj4gYXJpc2luZyBmcm9t
IHRoaXMgZmlyc3Qgc3RlcC4KPj4KPj4gRmFpciBlbm91Z2guIFRoYW5rIHlvdSBmb3IgdGhlIGV4
cGxhbmF0aW9uLgo+Pgo+PiBEbyB5b3UgaGF2ZSBhIHB1YmxpYyB0cmVlIHRoYXQgSSBjb3VsZCBw
dWxsIHRoZXNlIHBhdGNoZXMgYW5kIHRyeSB0aGVtCj4+IG9uIGFuIEludGVsIGhhcmR3YXJlPyBP
ciBwZXJoYXBzIHlvdSBoYXZlIGRvbmUgdGhpcz8gSSBsaWtlIHRoZSB3aG9sZQo+PiBpZGVhIG9m
IHRoaXMgc2VyaWVzLCBidXQgaXQncyBiZXR0ZXIgdG8gdHJ5IGl0IHdpdGggYSByZWFsIGhhcmR3
YXJlLgo+IAo+IEkgaGF2ZW4ndCBib3RoZXJlZCB3aXRoIHNlcGFyYXRlIGJyYW5jaGVzIHNpbmNl
IHRoZXJlJ3Mgc28gbWFueSAKPiBkaWZmZXJlbnQgcGllY2VzIGluLWZsaWdodCwgYnV0IG15IGNv
bXBsZXRlICh1bnN0YWJsZSkgZGV2ZWxvcG1lbnQgCj4gYnJhbmNoIGNhbiBiZSBmb3VuZCBoZXJl
Ogo+IAo+IGh0dHBzOi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJtL2xpbnV4LXJtLy0vY29tbWl0
cy9pb21tdS9idXMKPiAKPiBGb3Igbm93IEknZCByZWNvbW1lbmQgd2luZGluZyB0aGUgaGVhZCBi
YWNrIHRvICJpb21tdTogQ2xlYW4gdXAgCj4gYnVzX3NldF9pb21tdSgpIiBmb3IgdGVzdGluZyAt
IHNvbWUgb2YgdGhlIHBhdGNoZXMgYWJvdmUgdGhhdCBoYXZlIAo+IGFscmVhZHkgYmVlbiBwb3N0
ZWQgYW5kIHBpY2tlZCB1cCBieSB0aGVpciByZXNwZWN0aXZlIHN1YnN5c3RlbXMsIGJ1dCAKPiBv
dGhlcnMgYXJlIGluY29tcGxldGUgYW5kIGJhcmVseSBjb21waWxlLXRlc3RlZC4gSSdsbCBwcm9i
YWJseSByZWFycmFuZ2UgCj4gaXQgbGF0ZXIgdGhpcyB3ZWVrIHRvIGJldHRlciByZWZsZWN0IHdo
YXQncyBoYXBwZW5lZCBzbyBmYXIuCgpPa2F5LCB0aGFua3MgZm9yIHNoYXJpbmcuCgpCZXN0IHJl
Z2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
