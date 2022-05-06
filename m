Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26BEC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 13:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F0FD8408A;
	Fri,  6 May 2022 13:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IbOs9mRg4EOn; Fri,  6 May 2022 13:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 41BF881882;
	Fri,  6 May 2022 13:36:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15E05C0039;
	Fri,  6 May 2022 13:36:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4043C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4FF340325
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFH0pl_uI8WA for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:35:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC5E340300
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:35:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076DE14BF;
 Fri,  6 May 2022 06:35:59 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77F563F800;
 Fri,  6 May 2022 06:35:56 -0700 (PDT)
Message-ID: <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
Date: Fri, 6 May 2022 14:35:50 +0100
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220506131053.GA522325@nvidia.com>
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

T24gMjAyMi0wNS0wNiAxNDoxMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IE9uIEZyaSwgTWF5
IDA2LCAyMDIyIGF0IDEwOjMyOjUwQU0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPiAKPj4+
PiBJdCBpcyBhcyBkaXNjdXNzZWQgd2l0aCBSb2JpbiwgTlVMTCBtZWFucyB0byByZXR1cm4gdGhl
IGdyb3VwIGJhY2sgdG8KPj4+PiBzb21lIHBsYXRmb3JtIGRlZmluZWQgdHJhbnNsYXRpb24sIGFu
ZCBpbiBzb21lIGNhc2VzIHRoaXMgbWVhbnMKPj4+PiByZXR1cm5pbmcgYmFjayB0byB3b3JrIHdp
dGggdGhlIHBsYXRmb3JtJ3MgRE1BIG9wcyAtIHByZXN1bWFibHkgaWYgaXQKPj4+PiBpc24ndCB1
c2luZyB0aGUgZG1hIGFwaS4KPj4+Cj4+PiBUaGlzIGlzIGNsZWFyZXIgdGhhbiB0aGUgb3JpZ2lu
YWwgdGV4dC4KPj4KPj4gUGVyaGFwcyB3ZSBjb3VsZCBqdXN0IGxlYXZlIHRoYXQgc2VudGVuY2Ug
YXMgIk90aGVyd2lzZSB0aGUgTlVMTCBkb21haW4KPj4gcmVwcmVzZW50cyBwbGF0Zm9ybS1zcGVj
aWZpYyBiZWhhdmlvdXIuIgo+IAo+IFN1cmUsIHRoZXJlIGFyZSBvbmx5IHRocmVlIGRyaXZlcnMg
dGhhdCB1c2UgdGhpcyBjYWxsIHBhdGggYW5kIHdobwo+IGtub3dzIHdoYXQgdGhleSBkbyBJIGd1
ZXNzLi4KPiAKPj4+PiBTb2VtdGltZXMuIFRoaXMgaXMgYSBzdGF0ZW1lbnQgYWJvdXQgdGhlIHJl
cXVpcmVkCj4+Pj4gYXRvbWljaXR5LiBOZXcvb2xkL2Jsb2NrIGFyZSBhbGwgdmFsaWQgdHJhbnNs
YXRpb25zIGR1cmluZyB0aGUKPj4+PiBvcGVyYXRpb24uIElkZW50aXR5IGlzIG5vdC4KPj4+Cj4+
PiBidXQgbmV3L29sZC9ibG9jayBhcmUgbm90IHRoZSBzYW1lIHR5cGUgb2YgY2xhc3NpZmljYXRp
b25zLiBBIGdyb3VwCj4+PiBoYXMgYW4gb2xkIGRvbWFpbiBhbmQgYSBuZXcgZG9tYWluIGF0IHRo
aXMgdHJhbnNpdGlvbiBwb2ludCwgYW5kCj4+PiBib3RoIG9sZC9uZXcgZG9tYWlucyBoYXZlIGEg
ZG9tYWluIHR5cGUgKGRtYSwgdW5tYW5nZWQsIGJsb2NrLAo+Pj4gaWRlbnRpdHksIGV0Yy4pLiBN
aXhpbmcgdGhlbSB0b2dldGhlciBvbmx5IGluY3JlYXNlcyBjb25mdXNpb24gaGVyZS4KPiAKPiBC
bG9jayByZWZlcnMgdG8gdGhlIGdsb2JhbCBjb25jZXB0IG9mIGJsb2NraW5nIC0gbm90IHRvIGEg
dHlwZS4KPiAKPj4gR29vZCBwb2ludCAtIGluIHBhcnRpY3VsYXIgSSB0aGluayB0aGUgIkRNQSBp
cyBhbHdheXMgdHJhbnNsYXRlZCIgcGFydCB3b3VsZAo+PiBiZSBtb3JlIGFjY3VyYXRlbHkgc2Fp
ZCBhcyAiRE1BIGlzIGFsd2F5cyBtYW5hZ2VkIi4KPiAKPiBTbyB5b3Ugd2FudCB0byBzYXkgIkRN
QSBpcyBhbHdheXMgbWFuYWdlZCIgd2hlbiBhdHRhY2hpbmcgYSBkb21haW4gb2YKPiB0eXBlIElP
TU1VX0RPTUFJTl9VTk1BTkFHRUQ/IDopCgpUb3VjaMOpIDspIEp1c3QgZ29lcyB0byBjb25maXJt
IHRoZSBwb2ludCBhYm92ZSB0aGF0IGNvbmZ1c2lvbiBiZXR3ZWVuIApnZW5lcmFsIGNvbmNlcHRz
IGFuZCBzcGVjaWZpYyBBUEkgdGVybXMgaXMgYWxsIHRvbyBlYXN5LiBBbiAidW5tYW5hZ2VkIiAK
ZG9tYWluIGZyb20gdGhlIFBvViBvZiB0aGUgQVBJIGp1c3QgbWVhbnMgaXQncyBtYW5hZ2VkIGJ5
IHRoZSBleHRlcm5hbCAKY2FsbGVyLCBidXQgeW91J3JlIHJpZ2h0IHRoYXQgdGhhdCdzIG5vdCBu
ZWNlc3NhcmlseSBzbyBvYnZpb3VzIGVpdGhlci4KCj4gTGV0cyBqdXN0IGNsYXJpZnkgYSBiaXQg
dGhhdCBibG9ja2luZyBpc24ndCB0YWxraW5nIGFib3V0IGEgZG9tYWluCj4gdHlwZToKPiAKPiAJ
LyoKPiAJICogQ2hhbmdpbmcgdGhlIGRvbWFpbiBpcyBkb25lIGJ5IGNhbGxpbmcgYXR0YWNoX2Rl
digpIG9uIHRoZSBuZXcKPiAJICogZG9tYWluLiBUaGlzIHN3aXRjaCBkb2VzIG5vdCBoYXZlIHRv
IGJlIGF0b21pYyBhbmQgRE1BIGNhbiBiZQo+IAkgKiBkaXNjYXJkZWQgZHVyaW5nIHRoZSB0cmFu
c2l0aW9uLiBETUEgbXVzdCBhbHdheXMgYmUgdHJhbnNsYXRlZCBieQoKcy9hbHdheXMgYmUgdHJh
bnNsYXRlZCBieS9vbmx5IGJlIGFibGUgdG8gYWNjZXNzLyBhbmQgd2UgaGF2ZSBhIGRlYWwgOikK
CkNoZWVycywKUm9iaW4uCgo+IAkgKiBlaXRoZXIgbmV3X2RvbWFpbiBvciBncm91cC0+ZG9tYWlu
LCBuZXZlciBzb21ldGhpbmcgZWxzZS4KPiAJICoKPiAJICogTm90ZSB0aGF0IHRoaXMgaXMgY2Fs
bGVkIGluIGVycm9yIHVud2luZCBwYXRocywgYXR0YWNoaW5nIHRvIGEKPiAJICogZG9tYWluIHRo
YXQgaGFzIGFscmVhZHkgYmVlbiBhdHRhY2hlZCBjYW5ub3QgZmFpbC4KPiAJICovCj4gCj4gKGFz
aWRlLCBJIGV4cGVjdCBkb3duIHRoZSByb2FkIHdlIHdpbGwgaGF2ZSBzb21lIGRvbWFpbiBjYXBh
YmlsaXR5Cj4gJ2F0dGFjaCBpcyBhdG9taWMnIG1lYW5pbmcgaWYgbmV3IGFuZCBvbGQgaGF2ZSB0
aGUgc2FtZSB0cmFuc2xhdGlvbgo+IHRoZW4gdGhlcmUgaXMgbm8gZGlzcnVwdGlvbiB0byBETUEp
Cj4gCj4gVGhhbmtzLAo+IEphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
