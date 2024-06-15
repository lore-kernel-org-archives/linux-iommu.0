Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961010F7
	for <iommu@lists.linux.dev>; Sat, 15 Jun 2024 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718421433; cv=none; b=bjfDqNThzyuIvk8ps07Eia/9r71mtVh+3iCfO42/dsFX0BedVd5V9mCAJ72SvRCqJ7Cl9ogLtpzVLH0GB12W1ri3XMV0vkjY6ANAwF1ZvRVb0fMKONJMXeq8fOBwQ/+BbFmDjVg4BXJ7ipse95F5Pw9fZrFnJtBCl21ZoLzKruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718421433; c=relaxed/simple;
	bh=1Flck8NrpQ7n+FaQzcFFuAz7EFwUT5kfNeULG+ypZ3Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BLGOWGhYhxGWs4ahuR8qbhrozMJps3yQJ29Ui6fPV1dzKOFITdf6IELgKQ9oWyU8sY7FFa+E/qV3tGzGToQsmrxV0Ithq1MpXTmn2rygnRUlY5yZEaBEs2cf6UrZcFS0+GGq5mKYACDeP1VmgSetOM0NjAOsfi+rzZWzSVvC88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjE7c8n6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjE7c8n6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718421432; x=1749957432;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Flck8NrpQ7n+FaQzcFFuAz7EFwUT5kfNeULG+ypZ3Q=;
  b=bjE7c8n6KBIMpk2qaiIra8FG13OzPah4pO1v7GES1kW1w5Uw+QIeGI+o
   HzuudxoUmtQkxxJl9iOilmBDpWsRAubriHUHh11w6idtQhNcks3NJiYOa
   XZkHAiuNJ5WYZ9u0J6iw7aSd6DW+0jVlHAAEH/gl20XWOUTKWOGSPBWDB
   QDcDA1I8LztM2ZVQgW45ECnFo8TPTEgG3Pt34L/zKvGPN0bjt7qhZuBnS
   4CBlwfT7rxA2K3U2Y5G7pQQjotJS6U9Zc/+oPcNQH8YORnQ+U0xWmQx6y
   R8kTQJ3LvSHStMJ9QmDUwHjowN5JYXygGuSLk3veKnnPM0xKacN5wNwVO
   A==;
X-CSE-ConnectionGUID: n2obBwsGRKu4mAHZz3mbKg==
X-CSE-MsgGUID: DgftH77yTDa6pd8qnLUMqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32871813"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="32871813"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:17:11 -0700
X-CSE-ConnectionGUID: 3NvPnBnSSeS2Y9eDPh/UsQ==
X-CSE-MsgGUID: oBTkWiKDRfOWvep4qSxjYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="40557009"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 20:17:08 -0700
Message-ID: <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
Date: Sat, 15 Jun 2024 11:14:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation
 support
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jgg@ziepe.ca,
 kevin.tian@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-5-zong.li@sifive.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240614142156.29420-5-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 10:21 PM, Zong Li wrote:
> Add iotlb_sync_map operation for flush IOTLB. Software must
> flush the IOTLB after each page table.
> 
> Signed-off-by: Zong Li<zong.li@sifive.com>
> ---
>   drivers/iommu/riscv/Makefile |  1 +
>   drivers/iommu/riscv/iommu.c  | 11 +++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> index d36625a1fd08..f02ce6ebfbd0 100644
> --- a/drivers/iommu/riscv/Makefile
> +++ b/drivers/iommu/riscv/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o iommu-pmu.o
>   obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
> +obj-$(CONFIG_SIFIVE_IOMMU) += iommu-sifive.o
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 9aeb4b20c145..df7aeb2571ae 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1115,6 +1115,16 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
>   	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
>   }
>   
> +static int riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain,
> +				      unsigned long iova, size_t size)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +
> +	riscv_iommu_iotlb_inval(domain, iova, iova + size - 1);

Does the RISC-V IOMMU architecture always cache the non-present or
erroneous translation entries? If so, can you please provide more
context in the commit message?

If not, why do you want to flush the cache when building a new
translation?

Best regards,
baolu
