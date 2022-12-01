Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2C7C
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 04:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867376; x=1701403376;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LkFVZ5y6iSsxWGJVWWeyV1KM60WDNR0NwUkCRUvE9y4=;
  b=mH9yHAHOZbGvXeMy2I6X0UQQyAMNFzypHcOFVY9gE14KWMjLNkpNIlwZ
   Z1Nq2CZkl1XKHF2HxThpsOdmye35TiZhv8lzgB563y089TYX+ivmtsA4L
   vYMENMJU7OkM0A/iUQukfLGKlKwvAND7qMfT5FdcjqMSdxMMGJvTcHkV2
   DWuBzjgVUb7PBBCLebe4Wr4dEZqWXDSJ/II8ftpECjmlxQY0CgHtfoKrk
   BKoL9ohlPKkzWoAHuaHWnFbIupTYqs8A83wORgiwSnmc0ziMAYyzQqvSD
   GY5paDTijXTQykJcJW2hEkO3ehi53ZX5lqv0ryjAre9bjvtS6q2LoGU7n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316733690"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="316733690"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:02:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="713068765"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="713068765"
Received: from xuhuiyan-mobl1.ccr.corp.intel.com (HELO [10.254.215.206]) ([10.254.215.206])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:02:52 -0800
Message-ID: <c58ff308-f53f-ce3e-aace-2aec2e6e72c1@linux.intel.com>
Date: Thu, 1 Dec 2022 12:02:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/30 14:24, Jacob Pan wrote:
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
> Tested-by: Yuzhang Luo<yuzhang.luo@intel.com>
> Reviewed-by: Ashok Raj<ashok.raj@intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Queued for Joerg. Thank you!

Best regards,
baolu
