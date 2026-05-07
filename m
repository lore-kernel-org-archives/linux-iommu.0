Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8246AEFA
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181708; cv=none; b=ZXL/BSVXoozgZIT9rC00ZfDpaarxERLM2Fbd7VtqtLC0yypgb/tvhMbMlSMMRDVlRPtodRUMMO/TQNY9pQmaZ4kKzeNq/XCfwPO8rFGE+RIYEsE4NlZwy41Xj8BvdzmIKboKvw9Jno5s/EkPC+rvDkc9Xcb7txArWNtTH6ibUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181708; c=relaxed/simple;
	bh=bV79z0tqnwrOM2+SY76sjwiQQcenUZEz3fZIwF06ZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3g5uBwVVeaKazyZB/hPEBkxTPCEllulK+bEdIjvwkZBWXPfWNdEbINEhFCl636vpPKrUzdW638WGueMnLPoHm/vcKKHsGl06GHF9RAP7IQBp8MpKHH1IQ6Ec8U/rwqn79zWAcxgfJgZcEy8tryc/Dii8xha1CE128GQB9NEPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVfl2ZOG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVfl2ZOG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso129845ad.1
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778181706; x=1778786506; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=urgZfwF4+fq0Bvx57GpO772zcrt3WJsYUh542YPK0gU=;
        b=UVfl2ZOG3++K7SIQPIKASYBLMSveHsADFZkgEZ5z1RWx9pMecg5i9MeQ3gw8oRRoUz
         Ri432WP0MnnYzPQIjJAcJXytMvt+BQYDY+NnE2VXmryezvGcBkSxA72APxmBOYoCCiSM
         umK7PrVTAbei4QjNSjoQO8Kley41bggYl1i8tzZMMaGj5iSOlKTd/g/1OPqvdmeboMvd
         JrWq74klQnFwsYUVvkOw+8fhPdJa7y4rlvvb5sJjnWvK8qVSt0jkwXGhTPV/v0fyVm4c
         dCo3XZ6pyv7/QF2YdpELsfrpFsBXKT1rwxj4z4WZf511BeFeCwbLCL08SOSljinIxviO
         Oq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181706; x=1778786506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urgZfwF4+fq0Bvx57GpO772zcrt3WJsYUh542YPK0gU=;
        b=U6f6ukyRJnZ58KdQbFoHPCDpGV8xr7znXbfOk0UKLm2T++SmB3M9CP2NOa9l2K61go
         2nk+xxAgH1xFt6L/02zWA/VIuLrIlUV2azeCB4rRALtLGxfwYHI5FZSLVY9PNLQs4Kkz
         qU25QmfbnNgNITOIzmrzRD3TF7ikt5zn8kf0ZtBr/c4QXSEyy/htwz7kmBVevCA3u1I/
         f148mijmJQnsqSH2kXXHqvyB3Iop2m9a5aP9nDc0KQ7cY5djKfiKXWuQFLgBtmDlP/Xa
         TYHQIoUwMf1jHYwAxikaPOTyIaaxh99bQzcV87hkvHEbf5vHAvf1wDLVYxrBTDBOQCv2
         Nn+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8F7tg+YB9XJ5431r2w/Hl7z1blkKd88Iu/ALCc0PwnqBOZhpVZUbLPmqyDIONcpR61rtO2nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn5wcWW9J3i9GwKgds8MKw1FVxH2/xuJ5Oe8ugnadLNVS2YWIK
	32b3faR3UWd7nJZAB3oaPrOlszKfmekFkRUalFvzAjkiYzZ/pP9Y/5sayNLleQCQ+A==
X-Gm-Gg: Acq92OHiVZGLRCIg5kXdHp+z3fwbqdnKApNzCYzTzvja573gNDbWcvDiTSE0IvAAMrM
	Yg8kF3boXsUWMNZaq8m3gl29M1z5jTu2dcz6Ez8owqBCf/kYXT+WSfOTiegBV3pwOBKZKOYWw4D
	PYXqVqgrGo7hMYx6/7SP5yn/GktMjxx6jNSnjBZG1CMSz6XPAMpNkZtqtrgN3MLOpB/jy58b7ch
	9jjA4fDziQo/qU8QRJvT1JdpWs2nt2ILMDMipCkIQlc2ZBw9QvBniovX7+4fQ2L7ZpJUiFXTH+I
	cpOpQNjJywwDsWFN+LQgjPDfEExBstTSzLzU4EaQ6162FujteGq+Ra9p6yeXSNqluiwKvQOo8uA
	EGyGCyCjXyaBdYn/7MpnyLLeyU5xJA4rFgDmwn1KnrIFOFWhgeL7+AhaSzR2qft+hG/A5M7TPtI
	o5gqYY4e6tlfxhoLVLtyCxZa5J0yhROsX2bdLrzAlP9rkE7L2MK9idV2XNvjafcHb4Y6+0
X-Received: by 2002:a17:903:3c6d:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2bae9a8bf41mr779895ad.8.1778181705676;
        Thu, 07 May 2026 12:21:45 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664735c942sm213564a91.1.2026.05.07.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:21:45 -0700 (PDT)
Date: Thu, 7 May 2026 19:21:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Yigit Oguz <yigitogu@amazon.de>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Lilit Janpoladyan <lilitj@amazon.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Add PCI segment and vendor:device ID to
 DMAR fault logs
Message-ID: <afzmQ6FieJ2YIt9Y@google.com>
References: <20260506150541.60467-1-yigitogu@amazon.de>
 <20260506150541.60467-3-yigitogu@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506150541.60467-3-yigitogu@amazon.de>

On Wed, May 06, 2026 at 03:05:38PM +0000, Yigit Oguz wrote:
> Include the full SSSS:BB:DD.F address with PCI segment and
> vendor:device ID (VVVV:DDDD) in DMAR fault messages. Uses
> iommu->segment for the PCI domain and pci_get_domain_bus_and_slot
> to look up the pci_dev. Falls back to segment:BDF without
> vendor:device if the device is not found.
> 
> This brings Intel IOMMU fault logging in line with the ARM SMMUv3
> event decoding, making it easier to identify faulting devices
> (e.g. after FLR) without cross-referencing lspci.
> 
> Before:
>   DMAR: [DMA Write NO_PASID] Request device [86:00.0] fault addr 0xe0000000
> 	[fault reason 0x05] PTE Write access is not set
> 
> After:
>   DMAR: [DMA Write NO_PASID] Request device [0000:86:00.0 8086:1533] fault addr 0xe0000000
>   	[fault reason 0x05] PTE Write access is not set
> 
> Signed-off-by: Yigit Oguz <yigitogu@amazon.de>
> Signed-off-by: Lilit Janpoladyan <lilitj@amazon.com>
> Assisted-by: Claude:claude-4.6-opus
> ---
>  drivers/iommu/intel/dmar.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d33c119a935e..225fa498d714 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1890,30 +1890,39 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>  {
>  	const char *reason;
>  	int fault_type;
> +	u8 bus = source_id >> 8;
> +	u8 devfn = source_id & 0xFF;
> +	struct pci_dev *pdev;
> +	char devid[48];

Why not have a #define for this like you have for AMD and Arm?

>  
>  	reason = dmar_get_fault_reason(fault_reason, &fault_type);
>  
> +	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);

Not an Intel iommu expert, but I have concerns about using 
pci_get_domain_bus_and_slot() in this path.

AFAICT, dmar_fault_do_one() is running in a IRQ context & the pci_get_* 
family of functions iterates the global PCI klist. It eventually calls
bus_to_subsys(), which takes a plain spin_lock(&bus_kset->list_lock) [1]
which isn't IRQ-safe. Same thing with klist_put [2] called in klist_iter_exit

> +	if (pdev) {
> +		snprintf(devid, sizeof(devid), "%04x:%02x:%02x.%d %04x:%04x",
> +			 iommu->segment, bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
> +			 pdev->vendor, pdev->device);
> +		pci_dev_put(pdev);

Same here, pci_dev_put call put_device which might sleep [3] and hence
shouldn't be called in hard IRQ context.

> +	} else {
> +		snprintf(devid, sizeof(devid), "%04x:%02x:%02x.%d",
> +			 iommu->segment, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	}
> +
>  	if (fault_type == INTR_REMAP) {
> -		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
> -		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
> -		       PCI_FUNC(source_id & 0xFF), addr >> 48,
> -		       fault_reason, reason);
> +		pr_err("[INTR-REMAP] Request device [%s] fault index 0x%llx [fault reason 0x%02x] %s\n",
> +		       devid, addr >> 48, fault_reason, reason);
>  
>  		return 0;
>  	}
>  

[-------------- >8 -------------------]

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/base/bus.c#L60
[2] https://elixir.bootlin.com/linux/v7.0.1/source/lib/klist.c#L209
[3] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/base/core.c#L3794

