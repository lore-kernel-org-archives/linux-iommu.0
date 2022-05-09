Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC562C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 09:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C77E408B2;
	Mon,  9 May 2022 09:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3guSAjSmhdMe; Mon,  9 May 2022 09:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6F1F40898;
	Mon,  9 May 2022 09:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA909C0032;
	Mon,  9 May 2022 09:59:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EDDAC002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 09:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D32C81CA7
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 09:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QAeFWlERD31a for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 09:59:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD06A81CA3
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 09:59:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20441480;
 Mon,  9 May 2022 02:59:19 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10EF23F66F;
 Mon,  9 May 2022 02:59:17 -0700 (PDT)
Message-ID: <0f838b34-460c-ed83-7b98-6cda444b10c2@arm.com>
Date: Mon, 9 May 2022 10:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
 <20220506131053.GA522325@nvidia.com>
 <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
 <20220506135431.GC49344@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220506135431.GC49344@nvidia.com>
Cc: Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

T24gMjAyMi0wNS0wNiAxNDo1NCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IE9uIEZyaSwgTWF5
IDA2LCAyMDIyIGF0IDAyOjM1OjUwUE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPiAKPj4+
IFNvIHlvdSB3YW50IHRvIHNheSAiRE1BIGlzIGFsd2F5cyBtYW5hZ2VkIiB3aGVuIGF0dGFjaGlu
ZyBhIGRvbWFpbiBvZgo+Pj4gdHlwZSBJT01NVV9ET01BSU5fVU5NQU5BR0VEPyA6KQo+Pgo+PiBU
b3VjaMOpIDspIEp1c3QgZ29lcyB0byBjb25maXJtIHRoZSBwb2ludCBhYm92ZSB0aGF0IGNvbmZ1
c2lvbiBiZXR3ZWVuCj4+IGdlbmVyYWwgY29uY2VwdHMgYW5kIHNwZWNpZmljIEFQSSB0ZXJtcyBp
cyBhbGwgdG9vIGVhc3kuIEFuICJ1bm1hbmFnZWQiCj4+IGRvbWFpbiBmcm9tIHRoZSBQb1Ygb2Yg
dGhlIEFQSSBqdXN0IG1lYW5zIGl0J3MgbWFuYWdlZCBieSB0aGUgZXh0ZXJuYWwKPj4gY2FsbGVy
LCBidXQgeW91J3JlIHJpZ2h0IHRoYXQgdGhhdCdzIG5vdCBuZWNlc3NhcmlseSBzbyBvYnZpb3Vz
IGVpdGhlci4KPiAKPiBZZWFoLCBJJ20gbm90IHNvIGtlZW4gb24gdGhlIG5hbWluZyB1c2VkIGZv
ciBJT01NVV9ET01BSU5fKgo+IAo+IEkgbG9va2VkIGZvciBhIGJpdCBhbmQgY291bGQgbm90IGZp
Z3VyZSBvdXQgd2h5IHdlIG5lZWQgdG8gaGF2ZQo+IElPTU1VX0RPTUFJTl9ETUEgZWl0aGVyLi4g
SSBkaWRuJ3QgZmluZCBhbnRoaW5nIG9idmlvdXMgaW4gdGhlIGlvbW11Cj4gZHJpdmVycyB0aGF0
IGxvb2tlZCBsaWtlIGEgc3BlY2lhbCBjYXNlIGZvciB0aGlzPyBNb3N0IGRyaXZlcnMgdHJlYXQK
PiBpdCBpZGVudGljYWxseSB0byBVTk1BTkFHRUQgaW4gdGhlaXIgYWxsb2MgZnVuY3Rpb25zCj4g
Cj4gT25seSBtdGssIGFybS1zbW11IGFuZCBzb21lIG9kZCBzdHVmZiBpbiBJbnRlbCBzZWVtZWQg
dG8gYmUgc2Vuc2l0aXZlPwoKWWVzLCB0aGF0J3MgYSByZWxhdGl2ZWx5IHJlY2VudCBjaGFuZ2Vb
MV0gLSBwcmlvciB0byB0aGF0LCBkcml2ZXJzIGRpZCAKc3RpbGwgaGF2ZSB0byB0YWtlIChtaW5p
bWFsKSBhY3Rpb24gdG8gb3B0IGludG8gaW9tbXUtZG1hIHN1cHBvcnQuIApJT01NVV9ET01BSU5f
RE1BIHN0aWxsIG5lZWRzIHRvIGV4aXN0IGFzIGEgdHlwZSBmb3IgdGhlIGNvcmUgY29kZSB0byAK
ZGlmZmVyZW50aWF0ZSBpbnRlcm5hbGx5LCBzbyBkcml2ZXIgaW52b2x2ZW1lbnQgaXMgbW9zdGx5
IG5vdyBqdXN0IGEgCmNhc2Ugb2Ygc2F5aW5nICJ5ZWFoIE9LIGZpbmUiIGlmIHRoZXkgc2VlIGl0
LiBJT01NVV9ET01BSU5fRE1BX0ZRIG5vdyAKZWZmZWN0aXZlbHkgdGFrZXMgb3ZlciB0aGUgb3Jp
Z2luYWwgc2VtYW50aWNzIG9mIElPTU1VX0RPTUFJTl9ETUEgYXMgdGhlIApvbmUgdGhhdCBkZXBl
bmRzIG9uIGRyaXZlci1zcGVjaWZpYyBmdW5jdGlvbmFsaXR5LgoKRldJVywgbXRrLWlvbW11IGRv
ZXNuJ3QgcmVhbGx5IGhhdmUgYW55IG5lZWQgdG8gcmVqZWN0IApJT01NVV9ET01BSU5fVU5NQU5B
R0VELCB0aGV5IGp1c3QgZG9uJ3QgaGF2ZSBhbnkgcmVsZXZhbnQgY2xpZW50IGRyaXZlcnMgCnRo
YXQgd2FudCBpdDsgaG93ZXZlciBhcm0tc21tdSBkZWZpbml0ZWx5IGRvZXMgbmVlZCB0byBjb250
aW51ZSAKcmVqZWN0aW5nIElPTU1VX0RPTUFJTl9ETUEgd2hlbiBpdCBjYW4ndCByZWx5IG9uIHRo
ZSBEVCBjb2RlIGVuc3VyaW5nIAp0aGUgY29ycmVjdCBwcm9iZSBvcmRlcmluZyB3aXRoIHRoZSBv
bGQgRFQgYmluZGluZyAob3RoZXJ3aXNlIGNsaWVudCAKZHJpdmVycyBhcmUgbGlhYmxlIHRvIGdl
dCBicm9rZW4gRE1BIG9wcykuCgpUaGFua3MsClJvYmluLgoKWzFdIApodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1pb21tdS9jb3Zlci4xNjI4NjgyMDQ4LmdpdC5yb2Jpbi5tdXJwaHlAYXJt
LmNvbS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
