Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814704;
	b=2rblAusEDiBhSMEhM/LNjazfGN8oHghXunuai64lLzJqF9YmG1tVoKIPy2IGzMWkZpaV
	 bAgZQC0u6/yDcbHZPlLhfxRZirU8kwWd5kZbHbwzyAm3PicLiIkUy/60Sw4EHev45ZDnP
	 hjbCzoy78pIkIYK1EzOPG3/Lhjea0c3KlT+6/26m4TUdFP9pAn6asnXZywWRsDb12/DG7
	 bClpj7LLs4h7DqulADEcxXRq8j34z0tRD4/pMv+Sr8SuTlyXBzvC9oHIymRGFni/0qQkl
	 +mUdkG4SLDpm1AxZTHMpziJfvukRxRmmIBQgezjnv7LroqpHEdjDnvBe7pfahuxHfQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814704;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pI+qB/jORBsA8c6hsUYOeeDt5LaDuCmT+exW9sgyzwo=;
	b=VjvFJr5nouxzk7VaNP/oRAYMbK2AA3DJstP9JD254xzj1u2cvih0x9yZdwLlolMlvB2H
	 HOY1nffL74uGt1qxVURQIQ0Tb0N4TGJxaxnnYWCY2kl8iIoKGJBfiDOscZpxyialWvckg
	 yzP3tEjgWGV82A8H6rCBM1Frk3Y+l2jx70kPO74/0l0K5DUlmJuXzq8CMOcrBZgwKtJJd
	 3+ruH5ptC+58AraMpWRQATmUiO91f7qEnyvEE9CnJqlZNHPW0b4oxp8ryOZcjdsF8U1Oe
	 wQkail9XX7RvlMWaZOhtowud1gEVZHvY3kTvqqORcaTymoTLujkKilr17zxLWbhQlvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="VjP92/Gl";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4053606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 07:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4053606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VjP92/Gl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794814703; x=1826350703;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VCBdU3HmJwCtXAadN2uCRp5YZw+Cf4Kdztj+N3BY2z4=;
  b=VjP92/GljPoN8MOjryJBcKXQLhDwucxDUhnGJpDQdVxRwwwljIMoHmbx
   +bwGkow9H4wRxCnQAg2SIeutQO+VPVZKkIp4N6ljk9nvjn6h7HvrSwpls
   8qfX5WaHFiqL/Ba9YKPgMC8CCD8CJBOxZJYjYaTOGzYdnOA+kwSRjekOI
   s2dgwbBq+yB1J21B/rGcNmpotYdmLtEpQIfNmTPZcukyIR/jppQkAnM4o
   z9UXfMVhPaPkzl8KY2xol+Ztq82wTD/QHIB/+aBtgE1NupQqxarU3i9nq
   hxAE50Yj3M8JpQjo62fYbpavuOUzlsZecVVe8Z010f02fIGHI4NBRxc06
   g==;
X-CSE-ConnectionGUID: wrR3UB5dR8qRZ2Cfa4d3uQ==
X-CSE-MsgGUID: +/ms3EPZRiyQmjLapl5RDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3582036"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3582036"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 23:38:22 -0800
X-CSE-ConnectionGUID: zin4g8rdTdGww90ZxyGBNg==
X-CSE-MsgGUID: ckScDyXfR6eMSDFDs7pkTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9798707"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 23:38:17 -0800
Message-ID: <7ef6d626-4920-434f-bbd9-eda46e7ab780@linux.intel.com>
Date: Mon, 16 Nov 2026 15:38:14 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 13/18] iommu/vt-d: Handle reattach of the restored
 domain
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-14-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261110040828.1774343-14-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
> Reattach the restored domain to the preserved device using restored
> domain ID. While reattaching do not setup the context and PASID entries
> as those are preserved during liveupdate.
> 
> Note that in this phase nothing clears IOMMU_SER_FLAG_INCOMING of the
> restored domain or the restored state of the device, so the restored
> domain cannot be replaced yet. Replacing it is left to a later phase.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  28 ++++--
>   drivers/iommu/intel/iommu.h      |  14 +++
>   drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>   3 files changed, 175 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b3402fd9fe75..95ec37554360 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3296,6 +3296,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   {
>   	int ret;
>   
> +	if (dev_iommu_restored_state(dev))
> +		return intel_iommu_attach_restored_device(domain, dev);

How is the restored domain's type and page table format selected? I
don't see the allocation path using the preserved state to choose
between different domain type and page table format. Could this result
in a mismatch with the hardware configuration?

> +
>   	device_block_translation(dev);
>   
>   	ret = paging_domain_compatible(domain, dev);
> @@ -3426,7 +3429,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	info->iommu = iommu;
>   	RB_CLEAR_NODE(&info->node);
>   	if (dev_is_pci(dev)) {
> -		if (ecap_dev_iotlb_support(iommu->ecap) &&
> +		if (!dev_iommu_restored_state(dev) &&
> +		    ecap_dev_iotlb_support(iommu->ecap) &&
>   		    pci_ats_supported(pdev) &&
>   		    dmar_ats_supported(pdev, iommu)) {
>   			info->ats_supported = 1;
> @@ -3531,12 +3535,16 @@ static void intel_iommu_release_device(struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   
> -	iommu_disable_pci_pri(info);
> -	iommu_disable_pci_ats(info);
> +	if (!dev_iommu_restored_state(dev)) {
> +		iommu_disable_pci_pri(info);
> +		iommu_disable_pci_ats(info);

Above changes are not needed for domain reattachment, right? My
understanding is that ATS and PRI are not supported for preserved
devices in this phase. If so, could they be split into a separate patch?

>   
> -	if (info->pasid_enabled) {
> -		pci_disable_pasid(to_pci_dev(dev));
> -		info->pasid_enabled = 0;
> +		if (info->pasid_enabled) {
> +			pci_disable_pasid(to_pci_dev(dev));
> +			info->pasid_enabled = 0;
> +		}
> +	} else {
> +		intel_iommu_detach_restored_device(dev);
>   	}
>   
>   	mutex_lock(&iommu->iopf_lock);
> @@ -3544,11 +3552,15 @@ static void intel_iommu_release_device(struct device *dev)
>   		device_rbtree_remove(info);
>   	mutex_unlock(&iommu->iopf_lock);
>   
> -	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
> +	if (!dev_iommu_restored_state(dev) && sm_supported(iommu) &&
> +	    !dev_is_real_dma_subdevice(dev) &&
>   	    !context_copied(iommu, info->bus, info->devfn))
>   		intel_pasid_teardown_sm_context(dev);
>   
> -	intel_pasid_free_table(dev);
> +	if (!dev_iommu_restored_state(dev))
> +		intel_pasid_free_table(dev);
> +	else
> +		kfree(info->pasid_table);
>   	intel_iommu_debugfs_remove_dev(info);
>   	kfree(info);
>   }

Thanks,
baolu
