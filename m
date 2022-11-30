Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B909367
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 00:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669767062; x=1701303062;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B5h41uyGgikqzhqo86Wn4bWgSPj4zLK0qe0xzVnTtCA=;
  b=ffBKUE844HJxo4gV2Mh167ZsOZvm3sJI0S6jrHovnAL8Few7n/tImWz3
   Tvb968hgoqC8wzYumET9KUefmlbZWIx6BO7zljhIHn2dFCAL2YNvYLo7d
   QhILf55IjYeDlAoiArYXygVmmga+vghAhckOCOs/piVd4XL8V4cjcNs8c
   dg+jgI3np4DHgVqUutRcqBZ6ts0yrljNipmOPx4zN3HUavtBUb8XMs9DD
   W1c6WJv2fIQ9Lk1mK1jtZG//neFh6A5H/NLsnxECYovLFSexNJiQiX8x2
   kNn3Lpqb+KVF2Czh1ZVWh58vVwsAf1dIldnXie5I+NVbfoFd1hJil3wha
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295626201"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="295626201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:11:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="637793416"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="637793416"
Received: from cwang11-mobl.ccr.corp.intel.com (HELO [10.254.210.199]) ([10.254.210.199])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:10:57 -0800
Message-ID: <9fd4bf6c-5525-c209-28b6-492558c1dd35@linux.intel.com>
Date: Wed, 30 Nov 2022 08:10:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
References: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jacob,

On 2022/11/29 1:04, Jacob Pan wrote:
> QAT devices on Intel Sapphire Rapids and Emerald Rapids have a defect in
> address translation service (ATS). These devices may inadvertently issue
> ATS invalidation completion before posted writes initiated with
> translated address that utilized translations matching the invalidation
> address range, violating the invalidation completion ordering.
> 
> This patch adds an extra device TLB invalidation for the affected devices,
> it is needed to ensure no more posted writes with translated address
> following the invalidation completion. Therefore, the ordering is
> preserved and data-corruption is prevented.
> 
> Device TLBs are invalidated under the following six conditions:
> 1. Device driver does DMA API unmap IOVA
> 2. Device driver unbind a PASID from a process, sva_unbind_device()
> 3. PASID is torn down, after PASID cache is flushed. e.g. process
> exit_mmap() due to crash
> 4. Under SVA usage, called by mmu_notifier.invalidate_range() where
> VM has to free pages that were unmapped
> 5. userspace driver unmaps a DMA buffer
> 6. Cache invalidation in vSVA usage (upcoming)
> 
> For #1 and #2, device drivers are responsible for stopping DMA traffic
> before unmap/unbind. For #3, iommu driver gets mmu_notifier to
> invalidate TLB the same way as normal user unmap which will do an extra
> invalidation. The dTLB invalidation after PASID cache flush does not
> need an extra invalidation.
> 
> Therefore, we only need to deal with #4 and #5 in this patch. #1 is also
> covered by this patch due to common code path with #5.
> 
> Tested-by: Yuzhang Luo <yuzhang.luo@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
> v2
> - removed risky_device() check based on the review by Robin, added comments
>    to explain the exemption.
> - reworked commit message based on the review from Ashok
> ---
>   drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++++++++++++--
>   drivers/iommu/intel/iommu.h |  3 ++
>   drivers/iommu/intel/svm.c   |  4 ++-
>   3 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 996a8b5ee5ee..a97e9247037f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1396,6 +1396,23 @@ static void domain_update_iotlb(struct dmar_domain *domain)
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   }
>   
> +/*
> + * Impacted QAT device IDs ranging from 0x4940 to 0x4943.
> + * This quirk is exempted from risky_device() check because it applies only
> + * to the built-in QAT devices.
> + */

How about adding:

"This quirk is exempted from risky_device() check because it doesn't
effectively grant additional privileges."

?

--
Best regards,
baolu
