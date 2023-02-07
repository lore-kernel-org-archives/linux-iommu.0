Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60FBD2B
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675753854; x=1707289854;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3QNV1VfOaBLnQHC8TJ/Ap8oam3W/AnPXIGugPixqf7Q=;
  b=YIzi1qb4DTtN8xYCJhMeI5RTzidhyCuJydc9KGOtk/Tf+gVoqJlf6z68
   4mtx6se23d6FYYF/0PmANAzaVtzYOSt9CLdCKfLfLlxTX1ceyuoJueZyL
   9Dul4q7mFlDhD0lGKbrmNFATi5WleKS8U5X6MBck26mL5VMdM3eZ0imEY
   Hf4WBPCXBCP5B7PpuiZnsF7cYwqCuoNl2xX6WJNeNpz8JdYt0CvHIzJRU
   XVsL3JpNENQ6bOInZKUY9G3+6/5bDabB5FUM3Fm2tw3CmKvGMj4BeAoEg
   HajQVR0QygFjaQ8ssYzWN4H96etdBwKCPTj/P4onqlS7UFMmREVSlYJlP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391821416"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="391821416"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 23:10:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790692258"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="790692258"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.26]) ([10.254.209.26])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 23:10:50 -0800
Message-ID: <4a22577b-2bbc-d731-95e1-aee95d4a8c8e@linux.intel.com>
Date: Tue, 7 Feb 2023 15:10:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 stable@vger.kernel.org, Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix PASID directory pointer coherency
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230203220714.1283383-1-jacob.jun.pan@linux.intel.com>
 <de4d0617-ceef-efca-69f1-a095ce91588e@linux.intel.com>
 <20230206092527.670f7ef7@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230206092527.670f7ef7@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/7 1:25, Jacob Pan wrote:
>>> ---
>>>    drivers/iommu/intel/iommu.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 59df7e42fd53..b4878c7ac008 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1976,6 +1976,12 @@ static int domain_context_mapping_one(struct
>>> dmar_domain *domain, pds = context_get_sm_pds(table);
>>>    		context->lo = (u64)virt_to_phys(table->table) |
>>>    				context_pdts(pds);
>>> +		/*
>>> +		 * Scalable-mode PASID directory pointer is not
>>> snooped if the
>>> +		 * coherent bit is not set.
>>> +		 */
>>> +		if (!ecap_coherent(iommu->ecap))
>>> +			clflush_cache_range(table->table, sizeof(void
>>> *));
>> This isn't comprehensive. The clflush should be called whenever the
>> pasid directory table is allocated or updated.
>>
> allocate a pasid table does not mean it gets used by iommu hw, not until it
> is programmed into context entry.

Hi Jacob,

This page is used by the device, and the device's access to this memory
is not coherent. So after the page is allocated, any changes made by the
CPU to this page must be written back to the real memory.

This patch only flushes the first 8 bytes of the table. That's not
enough.

Be aware that page allocation also requires a clflush, because at least
__GFP_ ZERO implies modification to page.

Best regards,
baolu
