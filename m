Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317025B08E;
	Sun, 24 May 2026 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593081; cv=none; b=Ox1aNzSZksoVTn5xFssWl+cb/4WByXb/gljw2tmiKo5qkFvLwqoc3UYif2E/PiiUODjwq6Qmkm+rtag2L1z757AK0aavWWkb7NsZYUBoYTM7E9Q1eWDDVZU7yu8tDuHNx5Ex2ZjC41SbWg4JjAfeyikehScrKJU17IUdJWibjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593081; c=relaxed/simple;
	bh=+4CGH23ZgNaVjn9kOrGwgSXDnmnj2A8VkQuHJ7OErqg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lMKytqTiSUrVNxV/MFZ8iKsODm2lMrT4NCvssz0HAr3mk5noHl5DdM65s9wCRsg25fbzlwv6utiUmnjo7oAX/Gt2mizS7q3zHKFM2gEhdfaqFgZZsp/x/FPn2DSptAIw3YxCO8rOPqDRBAHzolPEkxAZR2qpYmUUZJ1mmerv1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzD4MTKs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzD4MTKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779593079; x=1811129079;
  h=message-id:date:mime-version:cc:subject:from:to:
   references:in-reply-to:content-transfer-encoding;
  bh=+4CGH23ZgNaVjn9kOrGwgSXDnmnj2A8VkQuHJ7OErqg=;
  b=LzD4MTKsLUWYKlN76hjLlrNenoJRH9pJ4zUOzzbz/wf1xUQHAAp7QmJz
   +RDBV4tcR1FqBwlTHusKHYKdOM8fYJ30UqVfpWHMULaicRaf8eBnlX9bP
   qsRLiYleb7I003Dsx27548AJCho7gCX24LDP6+c52E4IFZzGx4yXfZ4Bb
   ZmXAXZVYtgPtzhMg5aPTrgwmJbMlWekV4AIKBPZ3SfJu0i6E/6LaZNDim
   MJP1YOw1i/FNSbAwMI4HZQyua6byiKM3Htyct4wkGcHTo2gE3qiiNm1BR
   cSPxyevYdQDMDxVGptCJ81qW3Rjv2bm2qiRElynvhHGUSHOKdEuwlaQCa
   g==;
X-CSE-ConnectionGUID: b9GAGqYLSEuUkW32GhlqmA==
X-CSE-MsgGUID: FgAfRtBlQpCGx3aQmducnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="80370537"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="80370537"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 20:24:39 -0700
X-CSE-ConnectionGUID: 7JXrK1i9Ssm42lNqm1K9ig==
X-CSE-MsgGUID: 7Hm4CGcGQL20AsE/UJd7KA==
X-ExtLoop1: 1
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 20:24:37 -0700
Message-ID: <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com>
Date: Sun, 24 May 2026 11:24:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or
 a98db518dde2
From: Baolu Lu <baolu.lu@linux.intel.com>
To: 70sp <70sp@protonmail.com>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
 <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com>
 <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
 <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
Content-Language: en-US
In-Reply-To: <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/27/2026 3:15 PM, Baolu Lu wrote:
> On 4/14/26 17:22, 70sp wrote:
>> I can confirm, that the "domain is not compatible with device" message 
>> is nowhere to be seen.
>>
>> I have double checked by also adding an else statement with a 
>> different message and that one showed up several times. (by pci (iGPU) 
>> 0000:00:02.0, pcieport 0000:00:01.0 and vfio-pci (GTX 970) 
>> 0000:01:00.0, 0000:01:00.1). ret = 0.
>>
> 
> Hmm, it seems the domain is compatible with the device hardware and was
> attached successfully. Perhaps you can try to check the differences
> between these two domain attachments by dumping the root, context, and
> PASID table entries and comparing the configurations of the success and
> failure cases.
> 
> To do this, simply apply the change below with CONFIG_DMAR_DEBUG
> enabled:
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..bf303cfcf2ee 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1345,6 +1345,9 @@ static int dmar_domain_attach_device(struct 
> dmar_domain *domain,
>          if (ret)
>                  goto out_block_translation;
> 
> +       dmar_fault_dump_ptes(iommu, PCI_DEVID(info->bus, info->devfn),
> +                            0, IOMMU_NO_PASID);
> +
>          return 0;
> 
>   out_block_translation:

Have you tried this patch? It dumps the context and PASID table entries
after a domain is attached to the device. Hopefully, you can find some
clues by comparing the good and bad kernels.

Thanks,
baolu
