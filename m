Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6F22C321
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751727; cv=none; b=N5D0laBqY12vLzXTDkEZfHVzeY4Ce9J1NevCb1SqUbzLCGG7JNQ9L/FLV/qciatppMrJXSXKYDyVUan0xukQc9+AZheVHN7o9IRQyVBPEAfuwFhwVmDPNcjoBBuf2PqnSoEe6AeaBEUFZWh5dJSaDeLwkoux8nV27lcGd7qODl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751727; c=relaxed/simple;
	bh=vn6izPVigt1eZyBIGG4cwywA5Vovrsy0c2cTcp1QHEo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oDZlpbzHSNR5n98HQJcCLBggepbdDZeuTr9Bwb3W5bWyqA3vpQAx5tdNJTA6ROJWo8KNcqqBC/4J8iIRtJxuaSVN4v6Mcwb+7FGCwS9g3DYRgw/tf9Eoc5VVnkab1EVH+RoaK4i/R3ZVx/7i74FK7G/GBEXkWKo3j7aL4dgJoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffrUnU71; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffrUnU71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738751725; x=1770287725;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vn6izPVigt1eZyBIGG4cwywA5Vovrsy0c2cTcp1QHEo=;
  b=ffrUnU7138IiWMvTtjiWYvNO7e6Vyz1dax7CtFtowGIZKywrOZCNg7oj
   OcGQvuDME2EwuLuKHK3BC++0MEpWOoBiyAjr78afClORc+f1HG0bEIsLT
   gcF7b5tjhZUH4rAhsdJ8s4X04tzjV5g/+X2hHwWuw5b72juogwrGNCMtr
   aV6nZc+JTjhUVtyavUNOXLXCfLZvttd1k++Bm+t5SpBFEPq9VwdYPL7x/
   i+cPfYIFEYkIVdc4WyJSV20CH2nT/6v8yFwx3xtREQGj1fkkpfwwk3eFd
   tApD9oG484V+QAC6SD2KrtaFDNhQGVZLk6tvyolK+LPvGA9KX6sSEjRz/
   g==;
X-CSE-ConnectionGUID: jxePe5BkRKqGSHh+Ffo+uQ==
X-CSE-MsgGUID: je7U2q9xR8y7DzD3LniCwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39010816"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39010816"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:35:25 -0800
X-CSE-ConnectionGUID: 6LpxRD4USX2qxd6+LQ7zHw==
X-CSE-MsgGUID: frpej0GFRFSsV40otKHg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115836061"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.242.149]) ([10.124.242.149])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:35:24 -0800
Message-ID: <8b2e868e-2b0d-49dc-b703-4e33138a03b4@linux.intel.com>
Date: Wed, 5 Feb 2025 18:35:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: Make intel iommu disable swiotlb
To: "Adrian Mardare (amardare)" <amardare@cisco.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/1/26 13:09, Adrian Mardare (amardare) wrote:
> (resending as plain-text)
> Hi...
> I'd like to submit the below patch.
> While investigating a difference in memory consumption between the kernel in 5.4.x and in 6.6.x,
> I noticed there is around ~80M less reported in MemTotal in 6.6.x versus 5.4.x.
> This is because  in 6.6.x  the swiotlb is still enabled and consuming about 80M of kernel memory, even though
> the intel iommu has been fully initialized.
> This change will cause the swiotlb to be disabled /  memory to be released ( via swiotlb_exit ).
> Thanks,
> Adrian
> 
> 
>  From 27e63e727f23189e9c98d81fb445141f998c0808 Mon Sep 17 00:00:00 2001
> From: Adrian Mardare<amardare@cisco.com>
> Date: Sat, 25 Jan 2025 23:41:31 -0500
> Subject: [PATCH] Make intel iommu disable swiotlb
> 
> On boards where intel iommu has been successfully
> initialized, we need to disable the swiotlb as there
> is no reason for swiotlb to be active past that.
> 
> Signed-off-by: Adrian Mardare<amardare@cisco.com>
> ---
> drivers/iommu/intel/iommu.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cc46098f875b..971023d33a70 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3166,6 +3166,9 @@ int __init intel_iommu_init(void)
>                 pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
> 
>                  intel_iommu_enabled = 1;
> +#ifdef CONFIG_SWIOTLB
> +             x86_swiotlb_enable = false;
> +#endif

Why does an iommu driver need to care about swiotlb? The extra memory
consumption might be a problem, but I don't think it should be fixed in
the iommu driver.

Thanks,
baolu
