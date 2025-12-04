Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FA30F953
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764829980; cv=none; b=o10ieitMawq0XkcKkXXsZOAMJUykZPEGdRyZmCd7++iAvtZlgjeNvxW3YeD60xvW5abnLZwtMPWh7jijUbzcbKvUU/jc4ObSXTqBNFvPRTPFv/yUE2I6BWpaJL+yl9KFScjmg9Pvy1NJT1ZjY39wqsERdIVwqsjXC+vj0UvVOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764829980; c=relaxed/simple;
	bh=1p+/fz7COk6YR2U8Td8TsknOTEwoVT0zwYKmV2R53cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcXtfZFeCnnxD8V0cbjI5Y3ndKASV9+JZkxMBjOt87RRxzl5E1i0rjSd92f+E5YxPoPCFJjRpgxU6SEc140wzYfBSlGb6USwXzdgRaSQXwzYqyK6jx4Ety7y7TUqwxWsvYi0yp7+xFJubPXhoIT7PHJ6q0XHlZ3BE6uRRwe8S7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gH9VBGcd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gH9VBGcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764829979; x=1796365979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1p+/fz7COk6YR2U8Td8TsknOTEwoVT0zwYKmV2R53cM=;
  b=gH9VBGcdj2hNHIGYviIluCX9wvBiL9ouCEcjtkOeZGJKTkkURXDZ9h9M
   tPzSlGGiBXsPFsWm3gmoFj+LDelSe21RnQ4NNhwNLd5FnXR0qXnkhBYPd
   IVqHLIrAVicPCdnla3+2fA4coATx5KpG1oJ4idsy4AWAT35J6vB2skdZl
   Yj10N4FT9aBIt7Scj3p3G4x/FOVAfCgY7dX8f0KfsE5JRwzTxADhcZnS7
   a2i6jUijGaQ32lNArcW6nMSrqr7TMvMxqwIRnAWply4UFMs3YvotXGE8M
   PVrLCk4SOermSPYGr/OTGcJ+7+Ss8oVN4SLFmQTz4kjK3j9sQfHVp2jjT
   w==;
X-CSE-ConnectionGUID: X2eb1sHHRl2zsQDUticM5A==
X-CSE-MsgGUID: UZxu3SHuQhq5FsZaFoOk/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77163616"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="77163616"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:32:58 -0800
X-CSE-ConnectionGUID: 5jxM0go4TS2xaL3yq2dK/w==
X-CSE-MsgGUID: 7o92s46JQ9qE536O7ZAfiw==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:32:54 -0800
Message-ID: <52bed033-fa16-4429-a1c6-d8f24961b5ef@linux.intel.com>
Date: Thu, 4 Dec 2025 14:28:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 21/32] iommu/vt-d: Clean the context entries of
 unpreserved devices
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav
 <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Vipin Sharma <vipinsh@google.com>,
 dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>,
 Chris Li <chrisl@kernel.org>, praan@google.com
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20251202230303.1017519-22-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251202230303.1017519-22-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:02, Samiullah Khawaja wrote:
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices need to be cleared.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      | 33 ++++++++++++++++++++++++++++++--
>   drivers/iommu/intel/iommu.h      |  1 +
>   drivers/iommu/intel/liveupdate.c |  1 +
>   3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 3f69a073b2d8..84fef81ecf4d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -16,6 +16,7 @@
>   #include <linux/crash_dump.h>
>   #include <linux/dma-direct.h>
>   #include <linux/dmi.h>
> +#include <linux/iommu-lu.h>
>   #include <linux/memory.h>
>   #include <linux/pci.h>
>   #include <linux/pci-ats.h>
> @@ -52,6 +53,10 @@ static int rwbf_quirk;
>   
>   #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
>   
> +#ifdef CONFIG_LIVEUPDATE
> +static void __clean_unpreserved_context_entries(struct intel_iommu *iommu);
> +#endif
> +
>   /*
>    * set to 1 to panic kernel if can't successfully enable VT-d
>    * (used when kernel is launched w/ TXT)
> @@ -2376,8 +2381,12 @@ void intel_iommu_shutdown(void)
>   		/* Disable PMRs explicitly here. */
>   		iommu_disable_protect_mem_regions(iommu);
>   
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		if (iommu->iommu.outgoing_preserved_state) {
> +			__clean_unpreserved_context_entries(iommu);
> +		} else {
> +			/* Make sure the IOMMUs are switched off */
> +			iommu_disable_translation(iommu);
> +		}
>   	}
>   }
>   
> @@ -2884,6 +2893,26 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
>   	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>   };
>   
> +static void __clean_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev = NULL;
> +
> +	for_each_pci_dev(pdev) {
> +		info = dev_iommu_priv_get(&pdev->dev);
> +		if (!info)
> +			continue;

I assume the per-device iommu private data is freed in the
release_device path, which runs before intel_iommu_shutdown(). If that
is the case, "info" would always be NULL here, resulting the subsequent
code dead code. Or not?

> +
> +		if (info->iommu != iommu)
> +			continue;
> +
> +		if (dev_iommu_preserved_state(&pdev->dev))
> +			continue;
> +
> +		domain_context_clear(info);
> +	}
> +}

Thanks,
baolu
