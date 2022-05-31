Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2A5C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9E6640A0F;
	Tue, 31 May 2022 18:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HH9m6fM6XBsU; Tue, 31 May 2022 18:07:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34CEB40104;
	Tue, 31 May 2022 18:07:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC945C0032;
	Tue, 31 May 2022 18:07:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA7DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 372814094D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eo7tZlJBZKcL for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:07:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 830A540943
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:07:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77CB023A;
 Tue, 31 May 2022 11:07:40 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA0B3F766;
 Tue, 31 May 2022 11:07:38 -0700 (PDT)
Message-ID: <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
Date: Tue, 31 May 2022 19:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531162152.GH1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-05-31 17:21, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 05:01:46PM +0100, Robin Murphy wrote:
> 
>> The DMA API doesn't need locking, partly since it can trust itself not to do
>> stupid things, and mostly because it's DMA API performance that's
>> fundamentally incompatible with serialisation anyway. Why do you think we
>> have a complicated per-CPU IOVA caching mechanism, if not to support big
>> multi-queue devices with multiple CPU threads mapping/unmapping in different
>> parts of the same DMA domain concurrently?
> 
> Well, per-CPU is a form of locking.

Right, but that only applies for alloc_iova_fast() itself - once the 
CPUs have each got their distinct IOVA region, they can then pile into 
iommu_map() completely unhindered (and the inverse for the unmap path).

> So what are the actual locking rules here? We can call map/unmap
> concurrently but not if ... ?
> 
> IOVA overlaps?

Well, I think the de-facto rule is that you technically *can* make 
overlapping requests, but one or both may fail, and the final outcome in 
terms of what ends up mapped in the domain is undefined (especially if 
they both succeed). The only real benefit of enforcing serialisation 
would be better failure behaviour in such cases, but it remains 
fundamentally nonsensical for callers to make contradictory requests 
anyway, whether concurrently or sequentially, so there doesn't seem much 
point in spending effort on improving support for nonsense.

> And we expect the iommu driver to be unable to free page table levels
> that have IOVA boundaries in them?

I'm not entirely sure what you mean there, but in general an unmap 
request is expected to match some previous map request - there isn't a 
defined API-level behaviour for partial unmaps. They might either unmap 
the entire region originally mapped, or just the requested part, or 
might fail entirely (IIRC there was some nasty code in VFIO for 
detecting a particular behaviour). Similarly for unmapping anything 
that's already not mapped, some drivers treat that as a no-op, others as 
an error. But again, this is even further unrelated to concurrency.

>> The simpler drivers already serialise on a per-domain lock internally, while
>> the more performance-focused ones implement lock-free atomic pagetable
>> management in a similar style to CPU arch code; either way it should work
>> fine as-is.
> 
> The mm has page table locks at every level and generally expects them
> to be held for a lot of manipulations. There are some lockless cases,
> but it is not as aggressive as this sounds.

Oh, I've spent the last couple of weeks hacking up horrible things 
manipulating entries in init_mm, and never realised that that was 
actually the special case. Oh well, live and learn.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
