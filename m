Return-Path: <SRS0=kikZ=TJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35876C04AB2
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 16:11:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53792173B
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 16:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53792173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B0E59D56;
	Thu,  9 May 2019 16:11:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 95565D49
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 16:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B8334875
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 16:11:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47635374;
	Thu,  9 May 2019 09:11:46 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC37C3F6C4;
	Thu,  9 May 2019 09:11:44 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
	type
To: Lu Baolu <baolu.lu@linux.intel.com>, Tom Murphy <tmurphy@arista.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
	<20190429020925.18136-2-baolu.lu@linux.intel.com>
	<CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
	<bba1f327-21b7-ed3c-8fd4-217ad97a6a7c@arm.com>
	<3e0da076-4916-1a02-615c-927c1b3528b8@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56205a21-c72f-a460-77a2-4bb4f46f6e08@arm.com>
Date: Thu, 9 May 2019 17:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3e0da076-4916-1a02-615c-927c1b3528b8@linux.intel.com>
Content-Language: en-GB
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMDkvMDUvMjAxOSAwMzozMCwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
NS83LzE5IDY6MjggUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMDYvMDUvMjAxOSAxNjoz
MiwgVG9tIE11cnBoeSB2aWEgaW9tbXUgd3JvdGU6Cj4+PiBUaGUgQU1EIGRyaXZlciBhbHJlYWR5
IHNvbHZlcyB0aGlzIHByb2JsZW0gYW5kIHVzZXMgdGhlIGdlbmVyaWMKPj4+IGlvbW11X3JlcXVl
c3RfZG1fZm9yX2RldiBmdW5jdGlvbi4gSXQgc2VlbXMgbGlrZSBib3RoIGRyaXZlcnMgaGF2ZSB0
aGUKPj4+IHNhbWUgcHJvYmxlbSBhbmQgY291bGQgdXNlIHRoZSBzYW1lIHNvbHV0aW9uLiBJcyB0
aGVyZSBhbnkgcmVhc29uIHdlCj4+PiBjYW4ndCBoYXZlIHVzZSB0aGUgc2FtZSBzb2x1dGlvbiBm
b3IgdGhlIGludGVsIGFuZCBhbWQgZHJpdmVyPwo+Pj4KPj4+IENvdWxkIHdlIGp1c3TCoCBjb3B5
IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgQU1EIGRyaXZlcj8gSXQgd291bGQgYmUKPj4+IG5p
Y2UgdG8gaGF2ZSB0aGUgc2FtZSBiZWhhdmlvciBhY3Jvc3MgYm90aCBkcml2ZXJzIGVzcGVjaWFs
bHkgYXMgd2UKPj4+IG1vdmUgdG8gbWFrZSBib3RoIGRyaXZlcnMgdXNlIG1vcmUgZ2VuZXJpYyBj
b2RlLgo+Pgo+PiBUQkggSSBkb24ndCB0aGluayB0aGUgQVBJIHJlYWxseSBuZWVkcyB0byBiZSBp
bnZvbHZlZCBhdCBhbGwgaGVyZS4gCj4+IERyaXZlcnMgY2FuIGFscmVhZHkgbm90IHByb3ZpZGUg
dGhlIHJlcXVlc3RlZCBkZWZhdWx0IGRvbWFpbiB0eXBlIGlmIAo+PiB0aGV5IGRvbid0IHN1cHBv
cnQgaXQsIHNvIGFzIGxvbmcgYXMgdGhlIGRyaXZlciBjYW4gZW5zdXJlIHRoYXQgdGhlIAo+PiBk
ZXZpY2UgZW5kcyB1cCB3aXRoIElPTU1VIG9yIGRpcmVjdCBETUEgb3BzIGFzIGFwcHJvcHJpYXRl
LCBJIGRvbid0IAo+PiBzZWUgYW55IGdyZWF0IHByb2JsZW0gd2l0aCBkcml2ZXJzIGp1c3QgcmV0
dXJuaW5nIGEgcGFzc3Rocm91Z2ggZG9tYWluIAo+PiB3aGVuIGEgRE1BIGRvbWFpbiB3YXMgcmVx
dWVzdGVkLCBvciB2aWNlIHZlcnNhIChhbmQgbG9nZ2luZyBhIG1lc3NhZ2UgCj4+IHRoYXQgdGhl
IHJlcXVlc3RlZCB0eXBlIHdhcyBvdmVycmlkZGVuKS4gVGhlIG9ubHkgdHlwZSB0aGF0IHdlIHJl
YWxseSAKPj4gZG8gaGF2ZSB0byBob25vdXIgc3RyaWN0bHkgaXMgbm9uLWRlZmF1bHQgKGkuZS4g
dW5tYW5hZ2VkKSBkb21haW5zLgo+IAo+IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCB3ZSBvbmx5IGhh
dmUgdG8gaG9ub3Igc3RyaWN0bHkgdGhlIG5vbi1kZWZhdWx0Cj4gZG9tYWlucy4gQnV0IGRvbWFp
biB0eXBlIHNhdmVkIGluIGlvbW11X2RvbWFpbiBpcyBjb25zdW1lZCBpbiBpb21tdS5jCj4gYW5k
IGV4cG9zZWQgdG8gdXNlciB0aHJvdWdoIHN5c2ZzLiBJdCdzIG5vdCBjbGVhbiBpZiB0aGUgaW9t
bXUgZHJpdmVyCj4gc2lsZW50bHkgcmVwbGFjZSB0aGUgZGVmYXVsdCBkb21haW4uCgpSaWdodCwg
SSBkaWQgZ2V0IGEgYml0IGFoZWFkIG9mIG15c2VsZiB0aGVyZSAtIHRoZSBpbXBsaWNpdCBzdGVw
IGJlZm9yZSAKdGhhdCBpcyB0byBmaXggZGVmYXVsdCBkb21haW4gYWxsb2NhdGlvbiBzbyB0aGF0
IHRoZSBjb3JlIGFjdHVhbGx5IApwYXNzZXMgdGhlIHJlbGV2YW50IGRldmljZSB3aGljaCBpdCBo
YXMgdG8gaGFuZCwgc3VjaCB0aGF0IHRoZSBJT01NVSAKZHJpdmVycyAqY2FuKiBtYWtlIHRoZSBy
aWdodCBkZWNpc2lvbiB1cC1mcm9udC4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
