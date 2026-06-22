Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B442AD00
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105361; cv=none; b=D2EvDoJF0jfC31G6wd4nRpZdtZZFt0Qipa8zo54xK1/OHg+NILv3SGxmW+WdYWkzHnbTD+mDL5cakfM2zO4AUQcZfHKZMwm3H1Q9je2OdD6IELb6ju8ei54cqzcv8Ap3JlcKLVN13Zz6CX+1QW+Mz2HyO3ivPMdud9GqXhRexSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105361; c=relaxed/simple;
	bh=WOIRHBMJDB53+oALbBrWO9clz0p9ceSiZ24cgDAArr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qou/BdmldZLNh8mWq9Sd4G8QquvMRnDEebA/3m2ozDObt4cMt6hDTnSIcKFa2/OEp22TXz1/tJP80D7dPHZDGCVToIu151YLypG3rVqO4ckWFg/aTtHAZpig3gJpV/uUNGTV+YVP5PJ2Duu1b0pvCDyAErDQziv50M9Ge+zWcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIx4pjvp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIx4pjvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782105360; x=1813641360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOIRHBMJDB53+oALbBrWO9clz0p9ceSiZ24cgDAArr0=;
  b=BIx4pjvps+ZaR/a3PtlqeM+ZWINDyQhWr1L6cNMDUDWtWghARfCoFTM9
   z8lsm5jFzJ7i+zPyvmJavX8VTVdGLfKqgpUNNbPzus7S/+ENvNom4O+2h
   SAFN3L6Qnrxfy/lp1kd555OKcJRdoPiSBsOXfe4FD3cXsMeRkqB0W/gAL
   jkCGa/69UUABR8bAdqdT+1HIsEUovjSTx/slS3hsEkB9G7aFBdpXzaLSW
   TzYjekJi+aUCtwVZKueoT+QmZA4ccOSSYuW+QRWFlwo6z8MZ+6jL2LKLG
   unOYCVTHyL4aK9UXg91jFFrkddbNlSRkgz5voxKNadt92bjYufovHtxko
   Q==;
X-CSE-ConnectionGUID: HH9tsGQSSTqeJonftMYAIQ==
X-CSE-MsgGUID: DemX58lBQsuT17m3XOlFzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="81807700"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="81807700"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 22:15:59 -0700
X-CSE-ConnectionGUID: x5KhmIZvTnOoP2YS52uxRg==
X-CSE-MsgGUID: nzK0ViqmTj+AiLtYC6cFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="249234937"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 22:15:55 -0700
Message-ID: <23d4a3b9-41ac-4e05-ada6-01b6ae5e9f04@linux.intel.com>
Date: Mon, 22 Jun 2026 13:14:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-11-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260614233728.2212104-11-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 07:37, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>    devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      | 87 +++++++++++++++++++++++---------
>   drivers/iommu/intel/iommu.h      |  7 +++
>   drivers/iommu/intel/liveupdate.c | 60 ++++++++++++++++++++++
>   3 files changed, 130 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 26258861e3bf..cd40e274482b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -990,15 +990,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>   		iommu_disable_translation(iommu);
>   }
>   
> -static void free_dmar_iommu(struct intel_iommu *iommu)
> +static void free_dmar_iommu(struct intel_iommu *iommu, struct iommu_hw_ser *iommu_ser)
>   {
>   	if (iommu->copied_tables) {
>   		bitmap_free(iommu->copied_tables);
>   		iommu->copied_tables = NULL;
>   	}
>   
> -	/* free context mapping */
> -	free_context_table(iommu);
> +	/* free context mapping if there is no serialized state. */
> +	if (!iommu_ser)
> +		free_context_table(iommu);
>   
>   	if (ecap_prs(iommu->ecap))
>   		intel_iommu_finish_prq(iommu);

disable_dmar_iommu() and free_dmar_iommu() are always paired in the
code. How about merging them into a single helper that is aware of iommu
preservation? Something like the following?

static void release_dmar_iommu(struct intel_iommu *iommu)
{
         struct iommu_hw_ser *iommu_ser =
                         iommu_get_preserved_data(iommu->reg_phys, 
IOMMU_INTEL);

         /*
          * All iommu domains must have been detached from the devices,
          * hence there should be no domain IDs in use.
          */
         if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
                 return;

         if ((iommu->gcmd & DMA_GCMD_TE) && !iommu_ser)
                 iommu_disable_translation(iommu);

         if (iommu->copied_tables) {
                 bitmap_free(iommu->copied_tables);
                 iommu->copied_tables = NULL;
         }

         /* free context mapping if there is no serialized state. */
         if (!iommu_ser)
                 free_context_table(iommu);

         if (ecap_prs(iommu->ecap))
                 intel_iommu_finish_prq(iommu);
}

Thanks,
baolu
