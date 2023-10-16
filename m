Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45C17EA
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQ62yAxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697422262; x=1728958262;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wPsnnrZpLtCpjRrtyf6lW/jTyCZ+BEZgbzpRy35IyMc=;
  b=LQ62yAxwWi2FIlG2QRqENhtW9YKZAudjkASsB6X4AbfEba5uuV08frK9
   Tfgty6UzzJS3ScSfphaQ6Y3G7hA5B44ZiVgy6Ij5S0UCU1fGK2IgHX0fP
   dcgy6r+gWd6wiVZ4rwIJtdiAik7P9inK6VNB7HUOHWhLR49XHEZ3sFHyz
   GJaycpjy7Rl8VaJfrQ+6+9qLbrLRCLRV3smTmYKZ+VIk3vX6MU9gnSB7Y
   BHxp8a/fI5FrSMa9z0FM20rcRURDxsjXagkBpgl6z0xVF9+XAK8rB5Wb5
   iFaTfps8L6mVY62JBEgXAje9L2N6bPyRCd/aqkycfrVHcWOUolwPqyqBN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384306977"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="384306977"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 19:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790651418"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="790651418"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 15 Oct 2023 19:10:57 -0700
Message-ID: <d8553024-b880-42db-9f1f-8d2d3591469c@linux.intel.com>
Date: Mon, 16 Oct 2023 10:07:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230923012511.10379-20-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/23 9:25 AM, Joao Martins wrote:
[...]
> +static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
> +					    unsigned long iova, size_t size,
> +					    unsigned long flags,
> +					    struct iommu_dirty_bitmap *dirty)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	unsigned long end = iova + size - 1;
> +	unsigned long pgsize;
> +	bool ad_enabled;
> +
> +	spin_lock(&dmar_domain->lock);
> +	ad_enabled = dmar_domain->dirty_tracking;
> +	spin_unlock(&dmar_domain->lock);

The spin lock is to protect the RID and PASID device tracking list. No
need to use it here.

> +
> +	if (!ad_enabled && dirty->bitmap)
> +		return -EINVAL;

I don't understand above check of "dirty->bitmap". Isn't it always
invalid to call this if dirty tracking is not enabled on the domain?

The iommu_dirty_bitmap is defined in iommu core. The iommu driver has no
need to understand it and check its member anyway.

Or, I overlooked anything?

> +
> +	rcu_read_lock();

Do we really need a rcu lock here? This operation is protected by
iopt->iova_rwsem. Is it reasonable to remove it? If not, how about put
some comments around it?

> +	do {
> +		struct dma_pte *pte;
> +		int lvl = 0;
> +
> +		pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &lvl,
> +				     GFP_ATOMIC);
> +		pgsize = level_size(lvl) << VTD_PAGE_SHIFT;
> +		if (!pte || !dma_pte_present(pte)) {
> +			iova += pgsize;
> +			continue;
> +		}
> +
> +		/* It is writable, set the bitmap */
> +		if (((flags & IOMMU_DIRTY_NO_CLEAR) &&
> +				dma_sl_pte_dirty(pte)) ||
> +		    dma_sl_pte_test_and_clear_dirty(pte))
> +			iommu_dirty_bitmap_record(dirty, iova, pgsize);
> +		iova += pgsize;
> +	} while (iova < end);
> +	rcu_read_unlock();
> +
> +	return 0;
> +}

Best regards,
baolu
