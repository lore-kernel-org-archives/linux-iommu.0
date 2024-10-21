Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5B192B79
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491214; cv=none; b=kfbZCAmU5vrJnzai1Zf4jCqH89G4cNS6b2rXVJTaUMKXHtvQd/l2Ydk0K7lSMDZ+buJfShfLCwf3AHq4vHphbM9l3Z/VV8dFqq15EzgCo63/x+RgSYPzTIYJRm52en59FrH9zTfp5VrK5UB15SqDul7GhCe+2kCWeztLMHv73kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491214; c=relaxed/simple;
	bh=kE4s4ia/ePvu7tqGe6brV3A8wvm6kR6MH1H5dOa2Fvc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VBJqSdPMRK9envFHvJpq/KumB+cRyfG11fcWfdsCdkXNYBMMf+6VD/b1wA0P2wyjvXK4OxRGqQ+XPQCyMxYlflf8lOpCTWOynXd4Hi+FIbpctg6v7ID3F+2b3ou8RGsmbbkDAuIu8kWfmLBSPapG/nY3G5NQ8SL2xRW+gxSYrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JICetIet; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JICetIet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729491212; x=1761027212;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kE4s4ia/ePvu7tqGe6brV3A8wvm6kR6MH1H5dOa2Fvc=;
  b=JICetIetbdXVNN5LgYjQPayj+QWjDH39SUNP2PxYSE793adrR910o1dM
   QANMKHmmF1mSNwApUClihdJ/ggiRckaZURd9JXBEKnd85c/06ryzN66wP
   NSu1f37kxFcM8IqoxEjN8+vPST3ibzUOfOBhDYfJz3xi74QbdK1m0HhyI
   4hXrmz61OwUW3OG1fV8S/Sjx59HSsxO72L1g4lvdsh4eulXh8oLXMmSBd
   ZYRUYYbcLDUz/qVYx+MdFPGw4CBGeCIGxUEj970uqEFDJ3+G36LFXeVlc
   5q8nSBH0ZIGPTBvbvSC64A1OCEn7KMaA5Ph58bOxIlzNtswgT9dImX9+5
   w==;
X-CSE-ConnectionGUID: hNEssANkSRGkbVol/GU3Vw==
X-CSE-MsgGUID: z8dvviljQ6OOHMT47V4a9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29129872"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29129872"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:13:31 -0700
X-CSE-ConnectionGUID: o1gXP6s7Ta6XWnvjYbw7sA==
X-CSE-MsgGUID: MFmqKEB2SYy8DPW4iKpkbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84018999"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:13:27 -0700
Message-ID: <e5cd1de4-37f7-4d55-aa28-f37d49d46ac6@linux.intel.com>
Date: Mon, 21 Oct 2024 14:13:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/9] iommu/vt-d: Let intel_pasid_tear_down_entry()
 return pasid entry
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com, will@kernel.org
References: <20241018055402.23277-1-yi.l.liu@intel.com>
 <20241018055402.23277-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241018055402.23277-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/18 13:53, Yi Liu wrote:
> intel_pasid_tear_down_entry() finds the pasid entry and tears it down.
> There are paths that need to get the pasid entry, tear it down and
> re-configure it. Letting intel_pasid_tear_down_entry() return the pasid
> entry can avoid duplicate codes to get the pasid entry. No functional
> change is intended.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 11 ++++++++---
>   drivers/iommu/intel/pasid.h |  5 +++--
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 2898e7af2cf4..336f9425214c 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -239,9 +239,12 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   /*
>    * Caller can request to drain PRQ in this helper if it hasn't done so,
>    * e.g. in a path which doesn't follow remove_dev_pasid().
> + * Return the pasid entry pointer if the entry is found or NULL if no
> + * entry found.
>    */
> -void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> -				 u32 pasid, u32 flags)
> +struct pasid_entry *
> +intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> +			    u32 pasid, u32 flags)
>   {
>   	struct pasid_entry *pte;
>   	u16 did, pgtt;
> @@ -250,7 +253,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>   	pte = intel_pasid_get_entry(dev, pasid);
>   	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
>   		spin_unlock(&iommu->lock);
> -		return;
> +		goto out;

The pasid table entry is protected by iommu->lock. It's  not reasonable
to return the pte pointer which is beyond the lock protected range.

Thanks,
baolu
