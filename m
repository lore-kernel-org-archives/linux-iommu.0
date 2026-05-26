Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865942DB7A3
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760669; cv=none; b=HlHP/+pZ7mN6jQBpWpnqeR1cf/GPUwHTNpndny97aASB2nXqjyXlqCUDKidPXfOqZ9Kecg1g3Ox5qXuOOnkhe+uFHjPo6uhlQ1EkE2zl3UXnfiyh3jL1qanC3cPkmZE+iQSQP3xOCoS8oL2HcTHHrgrOHlsiB+O24YLLSOREY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760669; c=relaxed/simple;
	bh=6voWcVQOIRPhoBhfyFQcqtM27tGP8Gr/05fxW4OeGyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlX+GiR2tDS9MYn0UyqXNuPlkgfCCZ9OFVMJBcw8UIzc1rq55RPR8hYhd9Cdjaa7vZZnMwAdSG0IDu3bG3BxfKUNPAtVxKK3XyY2gu753sIQWcs7sBU8HP5bEdlY1tgocbJGguoEeb93YKVCg3StjvVd3iXFfgubHNboQIV2ESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFVGBIyo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFVGBIyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779760669; x=1811296669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6voWcVQOIRPhoBhfyFQcqtM27tGP8Gr/05fxW4OeGyc=;
  b=kFVGBIyofypcfl3QsRfpNkI5RAgcZzm2eroypfANbS+IooIlicuGar2d
   VU02aHxchMENbs3ngSuASPW/1g85bhxZpz8UD+4S/ze/6wXpfD8rCWqLF
   5f0dkyGakXHEMRMUlvVmJO8x1dod20YHE3uNbuZtnYP7kyljaQeP3Kg0p
   egmp4uaJ+Fb18jn8ULnmgWssasOJIL7CPJcVXMOrD71+3o9cdWTQ3V7DC
   3+XJ29dPy9ActOua1AeajxnN657UVxRiJ7ZeIDr73W7ZWNo9dlwj/898U
   XVg/yDikQ9jx/kF24BXPVKOW4nuDZHpXV6bfYI7I0+2Blr0/QEZUQWCMh
   w==;
X-CSE-ConnectionGUID: 5wfmb4iLR02ESYlsy8QHPQ==
X-CSE-MsgGUID: p2+gDCMtSy2Aj4t4RFUcWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="68093139"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="68093139"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 18:57:48 -0700
X-CSE-ConnectionGUID: s4e8w+dxSGOa1G1xtoPpYQ==
X-CSE-MsgGUID: c/qT8pg1RAeQLY66y+7n/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="245778839"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 18:57:45 -0700
Message-ID: <f7c018b4-01e0-4693-99aa-de8d370c8a42@linux.intel.com>
Date: Tue, 26 May 2026 09:57:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: improve IOMMU fault information
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260525034755.3645658-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260525034755.3645658-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/26 11:47, Guanghui Feng wrote:
> In some environments, multiple PCIe segments exist, and PCIe device
> information needs to be differentiated and identified based on the
> segment. When an IOMMU fault event occurs, the IOMMU and device segment
> information should be output in detail in dmar_fault_do_one.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>   drivers/iommu/intel/dmar.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d33c119a935e..ca9afbb55e76 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1894,7 +1894,8 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>   	reason = dmar_get_fault_reason(fault_reason, &fault_type);
>   
>   	if (fault_type == INTR_REMAP) {
> -		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[DMAR:%s] [INTR-REMAP] Request device [%04x:%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
> +		       iommu->name, iommu->segment,
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr >> 48,
>   		       fault_reason, reason);
> @@ -1903,14 +1904,18 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>   	}
>   
>   	if (pasid == IOMMU_PASID_INVALID)
> -		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[DMAR:%s] [%s NO_PASID] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		       iommu->name,

Do you really need to dump "iommu->name"? It is purely assigned by the
IOMMU driver software. Do you mind explaining what kind of information
you want to get from it?

>   		       type ? "DMA Read" : "DMA Write",
> +		       iommu->segment,
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr,
>   		       fault_reason, reason);
>   	else
> -		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[DMAR:%s] [%s PASID 0x%x] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		       iommu->name,
>   		       type ? "DMA Read" : "DMA Write", pasid,
> +		       iommu->segment,
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr,
>   		       fault_reason, reason);

Thanks,
baolu
