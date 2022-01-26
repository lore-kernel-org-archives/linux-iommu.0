Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB40C3525A
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 01:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BABCB40168;
	Wed, 26 Jan 2022 01:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8kw_brkxtvF; Wed, 26 Jan 2022 01:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5F17940448;
	Wed, 26 Jan 2022 01:52:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178B9C0039;
	Wed, 26 Jan 2022 01:52:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFC35C002F
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 01:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97C7A82CCB
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 01:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plLXJVZb9EDb for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 01:52:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE2B282CC7
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643161962; x=1674697962;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=oI90OnN0LBZgNPGK9oSIcHjxmu/Ye7JY6xZhvKkRU+o=;
 b=c3mUedJQ+fdXVkrJ2MHwEQ8abVgbs77uHR+l5YutHAODnnWjQgjgqCCI
 PIACwi+0+glYznlrjA4pWckiV5hdNegJce3evYBef121DCU8T1C5UUgVU
 o8a9MyMdFt12SkFbioHm7eqrRJW2OIiUpOIpXa/29Q6WXSxkRKPR3qTG4
 oZvjzUmuk4GQU45bIkbqNDQMgDUawLsdnz/UmcNvrFlvxA6TzXpVm8NWw
 6CkwoNo2ho8jivgJ5ctXXrPugSe+XvSJZoFu0+L68KMEtIbEBuMUyWu0e
 3x8A8TC9seDKWIJydE35QLRtVEf2TEWx0RwvcH38ChLi1y1RiCxzYeSjJ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230035242"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; d="scan'208";a="230035242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 17:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; d="scan'208";a="534988737"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 25 Jan 2022 17:52:37 -0800
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
 <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
 <20220125151602.GL84788@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a43279ba-8a18-a4a7-f317-a5e2091a0c74@linux.intel.com>
Date: Wed, 26 Jan 2022 09:51:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125151602.GL84788@nvidia.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
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

On 1/25/22 11:16 PM, Jason Gunthorpe wrote:
> On Tue, Jan 25, 2022 at 02:48:02PM +0000, Robin Murphy wrote:
>   
>> Agreed, certainly an IOMMU_DOMAIN_SVA type that can both encapsulate the mm
>> and effectively replace iommu_sva seems like a logical and fairly small next
>> step. We already have the paradigm of different domain types supporting
>> different ops, so initially an SVA domain would simply allow bind/unbind
>> rather than attach/detach/map/unmap.
> 
> I hope we can quickly get to a PASID enabled generic attach/detach
> scheme - we really need this to do the uAPI part of this interface.

Agreed. Jacob is working on kernel DMA with PASID. He needs such
interfaces as well. I have worked out an implementation for vt-d driver.
It could be post for review inside Jacob's series for kernel DMA with
PASID.

> 
>> they are fundamentally different things in their own right, and the ideal
>> API should give us the orthogonality to also bind a device to an SVA domain
>> without PASID (e.g. for KVM stage 2, or userspace assignment of simpler
>> fault/stall-tolerant devices), or attach PASIDs to regular iommu_domains.
> 
> Yes, these are orthogonal things. A iommu driver that supports PASID
> ideally should support PASID enabled attach/detatch for every
> iommu_domain type it supports.
> 
> SVA should not be entangled with PASID beyond that SVA is often used
> with PASID - a SVA iommu_domain should be fully usable with a RID too.

The prototype of PASID enabled attach/detach ops could look like:

        int (*attach_dev_pasid)(struct iommu_domain *domain,
                                struct device *dev, ioasid_t id);
        void (*detach_dev_pasid)(struct iommu_domain *domain,
                                 struct device *dev, ioasid_t id);

But the iommu driver should implement different callbacks for

1) attaching an IOMMU DMA domain to a PASID on device;
    - kernel DMA with PASID
    - mdev-like device passthrough
    - etc.
2) attaching a CPU-shared domain to a PASID on device;
    - SVA
    - guest PASID
    - etc.

> 
> I'm hoping to see the core iommu code provide some simplified "SVA"
> API that under the covers creates a SVA domain and then does a normal
> PASID attach using the global PASID in the mm_struct - the
> driver should not care what, or even if, PASID is used for a SVA
> domain.
> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
