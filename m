Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE03537F7
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107119; cv=none; b=ZIKfzmZ0SaJBDW6iAWaTstnCNAJiR7twEM9PdjO/3fa7AWzP/hW/hzzbLpm+rDGsmQfVnrj9p3VyFcffU0P67JGAC66YfLEdjZtXoYoNzaSBM3vq2KSa5a3yw/eWC0VLm77w295s1PmxiljfNISda2QhhfQzjLm+R8yO8oe0dHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107119; c=relaxed/simple;
	bh=N+lFIHJPf3+onkTPIvz4GBp+yRlIZgnPqfru8gIw/38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfVeDZkfwKdCgTJ0nFNY18Aqpcp6orvLBpe4dt3zdzan//YwTSkm1AHYcUkXagJDf6ALzB47SL/vzlDv2Gv/A/zAPG/C7GHwyprfjjLCBzUgfKbBPYpIbWSfZGpF18+p2UMRM+Y3cHousqqYV+C8s2dmUaGRduGj/6lQ/Q4dMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxzhVHXh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxzhVHXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782107117; x=1813643117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N+lFIHJPf3+onkTPIvz4GBp+yRlIZgnPqfru8gIw/38=;
  b=nxzhVHXhoENJfWMPe8sitXJW/5ilGeNXRijpiG9zGHGsnQ2ItTGIYlfQ
   XNRvAQAgtmNbBC2z1Syv3LLiJrXC0qilXGN463jAYN0Wq7AhjvaG/e+IH
   543vsakl1BFcPYeH/qHBiELrMOB5olPQsZ/hoIyzK+yfnvIeBViIow/wC
   Zhm8q9PcKjenozGbCXBy6SVPO7r0O1Ep5stm8TrRQztWaLSGzy4vQ/juT
   G8c2fGHqHbO5TruQEKQVIdZq+TmDFwHIDcCZJzKkDH1/2T26T8X3xrrvX
   pe2SOs6qsXnQ+edWGcLWOe7RnXFGN9ltnTN0ndoBoZEX6l43tiZ76pLxX
   A==;
X-CSE-ConnectionGUID: D7HrnUQuSeqcccpTbuUFOQ==
X-CSE-MsgGUID: 89l7+aBcQ8OwE/JSBxwshg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82941452"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82941452"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 22:45:16 -0700
X-CSE-ConnectionGUID: ia7aULeZRzyzABaZmlug2A==
X-CSE-MsgGUID: MTdYdcCBRMmIzT5dtV4jVw==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 22:45:12 -0700
Message-ID: <01f53c50-f585-49a0-b7a2-fdf002049aea@linux.intel.com>
Date: Mon, 22 Jun 2026 13:44:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] iommu/vt-d: Handle reattach of the restored
 domain
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
 <20260614233728.2212104-13-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260614233728.2212104-13-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 07:37, Samiullah Khawaja wrote:
> Reattach the restored domain to the preserved device using restored
> domain ID. While reattaching do not setup the context and PASID entries
> as those are preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  46 ++++++++++---
>   drivers/iommu/intel/iommu.h      |  17 +++++
>   drivers/iommu/intel/liveupdate.c | 111 +++++++++++++++++++++++++++++++
>   3 files changed, 163 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cd40e274482b..91b67ccba011 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1311,10 +1311,16 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
> +	struct iommu_device_ser *device_ser;
>   	unsigned long flags;
>   	int ret;
>   
> -	ret = domain_attach_iommu(domain, iommu);
> +	device_ser = dev_iommu_restored_state(dev);
> +	if (!device_ser)
> +		ret = domain_attach_iommu(domain, iommu);
> +	else
> +		ret = intel_iommu_domain_reattach_iommu(domain,
> +							iommu, device_ser);
>   	if (ret)
>   		return ret;
>   
> @@ -1327,16 +1333,20 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   	if (dev_is_real_dma_subdevice(dev))
>   		return 0;
>   
> -	if (!sm_supported(iommu))
> -		ret = domain_context_mapping(domain, dev);
> -	else if (intel_domain_is_fs_paging(domain))
> -		ret = domain_setup_first_level(iommu, domain, dev,
> -					       IOMMU_NO_PASID, NULL);
> -	else if (intel_domain_is_ss_paging(domain))
> -		ret = domain_setup_second_level(iommu, domain, dev,
> -						IOMMU_NO_PASID, NULL);
> -	else if (WARN_ON(true))
> -		ret = -EINVAL;
> +	if (!device_ser) {
> +		if (!sm_supported(iommu))
> +			ret = domain_context_mapping(domain, dev);
> +		else if (intel_domain_is_fs_paging(domain))
> +			ret = domain_setup_first_level(iommu, domain, dev,
> +						       IOMMU_NO_PASID, NULL);
> +		else if (intel_domain_is_ss_paging(domain))
> +			ret = domain_setup_second_level(iommu, domain, dev,
> +							IOMMU_NO_PASID, NULL);
> +		else if (WARN_ON(true))
> +			ret = -EINVAL;
> +	} else if (!sm_supported(iommu)) {
> +		iommu_enable_pci_ats(info);
> +	}

Instead of merging domain restoration into the attach_dev path, how
about adding a new callback to restore a preserved domain for a device?
Something like:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b2f614367074..e61409f2d9fc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -748,6 +748,8 @@ struct iommu_ops {
   * * <others>  - treated as ENODEV by the caller. Use is discouraged
   * @set_dev_pasid: set or replace an iommu domain to a pasid of 
device. The pasid of
   *                 the device should be left in the old config in 
error case.
+ * @restore_dev: Set a domain that is restored from the previous 
live-updated
+ *               kernel to a device.
   * @map_pages: map a physically contiguous set of pages of the same 
size to
   *             an iommu domain.
   * @unmap_pages: unmap a number of pages of the same size from an 
iommu domain
@@ -772,6 +774,9 @@ struct iommu_ops {
  struct iommu_domain_ops {
         int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
                           struct iommu_domain *old);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+       int (*restore_dev)(struct iommu_domain *domain, struct device *dev);
+#endif
         int (*set_dev_pasid)(struct iommu_domain *domain, struct device 
*dev,
                              ioasid_t pasid, struct iommu_domain *old);

Thanks,
baolu
