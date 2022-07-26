Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0986290D
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658849288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IwJu9zeDryP4BccrbhHg2EWDecf7ZatiCMfG/ucuCE=;
	b=cUPF2CIXzvRWSNUc0E1zwmu4UjBERNlef1HcvNiMg/gMO5lnrc55Be08qFWkN5aUEcgtgj
	m39YGkX5QUfFK592PrubytAYTeufnyaB9jitmOA8DRi2W/Pi3124H9KPSfPklhwIg1pOvd
	RybB9KvQ13K4fYLKRkdw+2+Cgk+Zun4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-4RtuDVi5NqGvttM32n9qqQ-1; Tue, 26 Jul 2022 11:28:07 -0400
X-MC-Unique: 4RtuDVi5NqGvttM32n9qqQ-1
Received: by mail-qk1-f197.google.com with SMTP id bi37-20020a05620a31a500b006b5ef0afedaso12481583qkb.22
        for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 08:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IwJu9zeDryP4BccrbhHg2EWDecf7ZatiCMfG/ucuCE=;
        b=OOafHptvpgh+I8PB2vjcExxqzN+48hTZuMmZ9/xWmdXbroaxzPVJmxfhhygbLPH5KF
         TLAEg9i9rWUSzD4yuIyycourBWjccZwiVVIWwNWGZHiE/b5oLSNx0Bf7r8P+ptO5/7bN
         Z/MGZj7MsXe8AkV2NDLzcfqo1eoafccbRgNSBUY1u1wo+eekjES7c0xJlM2Aln6gsO2I
         A45F3993xsE0cJQawzIUxePA4inddDE36F/ca+P7GSMGFguP52OmlB0/n/1tXA7JcJUd
         aD5D+1Z3EaxdLinUCUlrzNYQNA/raRKnCN8NmqxLwQtr2zpe5bYQM47ejdSleg0vZOMu
         0rEg==
X-Gm-Message-State: AJIora9TR1VFFC0grAKCyhf9M86WTCT7pVRvNsHMODir7bCMaDk2rZU5
	Av2tmGsZlVQxWaXeDkFZ901gUhlCd6z52VqjK4nBAGZ7V6cJOzjaBCBBcWaezV16vO0QvlnXW1M
	uRaAkIqzhlnEYJbg=
X-Received: by 2002:ae9:e90f:0:b0:6b5:f2a1:ab68 with SMTP id x15-20020ae9e90f000000b006b5f2a1ab68mr13100770qkf.571.1658849286609;
        Tue, 26 Jul 2022 08:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbXyzUz+jTMorGVwmY9bp3egaXhd5zRTOJh5sVM2Q/Qyt8yz2yl9RT+S9N4DeL59fS0K3XqA==
X-Received: by 2002:ae9:e90f:0:b0:6b5:f2a1:ab68 with SMTP id x15-20020ae9e90f000000b006b5f2a1ab68mr13100749qkf.571.1658849286316;
        Tue, 26 Jul 2022 08:28:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id l12-20020a05620a28cc00b006b655aebc9asm5363746qkp.125.2022.07.26.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:28:06 -0700 (PDT)
Date: Tue, 26 Jul 2022 08:28:04 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	will@kernel.org, vasant.hegde@amd.com, jon.grimm@amd.com,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/2] iommu/amd: Simplify and Consolidate Virtual APIC
 (AVIC) Enablement
Message-ID: <20220726152804.trkzhxhsw3zp45wl@cantor>
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
 <20220726134348.6438-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220726134348.6438-2-suravee.suthikulpanit@amd.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2022 at 08:43:47AM -0500, Suravee Suthikulpanit wrote:
> Currently, enabling AVIC requires individually detect and enable GAM and
> GALOG features on each IOMMU, which is difficult to keep track on
> multi-IOMMU system, where the features needs to be enabled system-wide.
> 
> In addition, these features do not need to be enabled in early stage. 
> It can be delayed until after amd_iommu_init_pci().
> 
> Therefore, consolidate logic for detecting and enabling IOMMU GAM and
> GALOG features into a helper function, enable_iommus_vapic(), which uses
> the check_feature_on_all_iommus() helper function to ensure system-wide
> support of the features before enabling them, and postpone until after
> amd_iommu_init_pci().
> 
> The new function also check and clean up feature enablement residue from
> previous boot (e.g. in case of booting into kdump kernel), which triggers
> a WARN_ON (shown below) introduced by the commit a8d4a37d1bb9 ("iommu/amd:
> Restore GA log/tail pointer on host resume") in iommu_ga_log_enable().
> 
> [    7.731955] ------------[ cut here ]------------
> [    7.736575] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd/init.c:829 iommu_ga_log_enable.isra.0+0x16f/0x190
> [    7.746135] Modules linked in:
> [    7.749193] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc7.53.eln120.x86_64 #1
> [    7.759706] Hardware name: Dell Inc. PowerEdge R7525/04D5GJ, BIOS 2.1.6 03/09/2021
> [    7.767274] RIP: 0010:iommu_ga_log_enable.isra.0+0x16f/0x190
> [    7.772931] Code: 20 20 00 00 8b 00 f6 c4 01 74 da 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 75 13 48 83 c4 10 5b 5d e9 f5 00 72 00 0f 0b eb e1 <0f> 0b eb dd e8 f8 66 42 00 48 8b 15 f1 85 53 01 e9 29 ff ff ff 48
> [    7.791679] RSP: 0018:ffffc90000107d20 EFLAGS: 00010206
> [    7.796905] RAX: ffffc90000780000 RBX: 0000000000000100 RCX: ffffc90000780000
> [    7.804038] RDX: 0000000000000001 RSI: ffffc90000780000 RDI: ffff8880451f9800
> [    7.811170] RBP: ffff8880451f9800 R08: ffffffffffffffff R09: 0000000000000000
> [    7.818303] R10: 0000000000000000 R11: 0000000000000000 R12: 0008000000000000
> [    7.825435] R13: ffff8880462ea900 R14: 0000000000000021 R15: 0000000000000000
> [    7.832572] FS:  0000000000000000(0000) GS:ffff888054a00000(0000) knlGS:0000000000000000
> [    7.840657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.846400] CR2: ffff888054dff000 CR3: 0000000053210000 CR4: 0000000000350eb0
> [    7.853533] Call Trace:
> [    7.855979]  <TASK>
> [    7.858085]  amd_iommu_enable_interrupts+0x180/0x270
> [    7.863051]  ? iommu_setup+0x271/0x271
> [    7.866803]  state_next+0x197/0x2c0
> [    7.870295]  ? iommu_setup+0x271/0x271
> [    7.874049]  iommu_go_to_state+0x24/0x2c
> [    7.877976]  amd_iommu_init+0xf/0x29
> [    7.881554]  pci_iommu_init+0xe/0x36
> [    7.885133]  do_one_initcall+0x44/0x200
> [    7.888975]  do_initcalls+0xc8/0xe1
> [    7.892466]  kernel_init_freeable+0x14c/0x199
> [    7.896826]  ? rest_init+0xd0/0xd0
> [    7.900231]  kernel_init+0x16/0x130
> [    7.903723]  ret_from_fork+0x22/0x30
> [    7.907306]  </TASK>
> [    7.909497] ---[ end trace 0000000000000000 ]---
> 
> Fixes: commit a8d4a37d1bb9 ("iommu/amd: Restore GA log/tail pointer on host resume")
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Will Deacon <will@kernel.org> (maintainer:IOMMU DRIVERS)
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/init.c | 85 ++++++++++++++++++++++++++--------------
>  1 file changed, 55 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index d86496114ca5..4cd94d716122 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -908,11 +908,6 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  	if (!iommu->ga_log)
>  		return -EINVAL;
>  
> -	/* Check if already running */
> -	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> -	if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
> -		return 0;
> -
>  	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
>  	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
>  		    &entry, sizeof(entry));
> @@ -2068,10 +2063,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
>  		return -ENOMEM;
>  
> -	ret = iommu_init_ga_log(iommu);
> -	if (ret)
> -		return ret;
> -
>  	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
>  		pr_info("Using strict mode due to virtualization\n");
>  		iommu_set_dma_strict();
> @@ -2155,8 +2146,6 @@ static void print_iommu_info(void)
>  	}
>  	if (irq_remapping_enabled) {
>  		pr_info("Interrupt remapping enabled\n");
> -		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> -			pr_info("Virtual APIC enabled\n");
>  		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
>  			pr_info("X2APIC enabled\n");
>  	}
> @@ -2446,9 +2435,6 @@ static int iommu_init_irq(struct amd_iommu *iommu)
>  
>  	if (iommu->ppr_log != NULL)
>  		iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
> -
> -	iommu_ga_log_enable(iommu);
> -
>  	return 0;
>  }
>  
> @@ -2678,8 +2664,6 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
>  #ifdef CONFIG_IRQ_REMAP
>  	switch (amd_iommu_guest_ir) {
>  	case AMD_IOMMU_GUEST_IR_VAPIC:
> -		iommu_feature_enable(iommu, CONTROL_GAM_EN);
> -		fallthrough;
>  	case AMD_IOMMU_GUEST_IR_LEGACY_GA:
>  		iommu_feature_enable(iommu, CONTROL_GA_EN);
>  		iommu->irte_ops = &irte_128_ops;
> @@ -2759,19 +2743,6 @@ static void early_enable_iommus(void)
>  			iommu_flush_all_caches(iommu);
>  		}
>  	}
> -
> -#ifdef CONFIG_IRQ_REMAP
> -	/*
> -	 * Note: We have already checked GASup from IVRS table.
> -	 *       Now, we need to make sure that GAMSup is set.
> -	 */
> -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> -	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC))
> -		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> -
> -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> -		amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
> -#endif
>  }
>  
>  static void enable_iommus_v2(void)
> @@ -2784,10 +2755,63 @@ static void enable_iommus_v2(void)
>  	}
>  }
>  
> +static void enable_iommus_vapic(void)
> +{
> +#ifdef CONFIG_IRQ_REMAP
> +	u32 status, i;
> +	struct amd_iommu *iommu;
> +
> +	for_each_iommu(iommu) {
> +		/*
> +		 * Disable GALog if already running. It could have been enabled
> +		 * in the previous boot before kdump.
> +		 */
> +		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> +		if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
> +			continue;
> +
> +		iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> +		iommu_feature_disable(iommu, CONTROL_GAINT_EN);
> +
> +		/*
> +		 * Need to set and poll check the GALOGRun bit to zero before
> +		 * we can set/ modify GA Log registers safely.
> +		 */
> +		for (i = 0; i < LOOP_TIMEOUT; ++i) {
> +			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> +			if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
> +				break;
> +			udelay(10);
> +		}
> +
> +		if (WARN_ON(i >= LOOP_TIMEOUT))
> +			return;
> +	}
> +
> +	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> +	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC)) {
> +		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> +		return;
> +	}
> +
> +	/* Enabling GAM support */
> +	for_each_iommu(iommu) {
> +		if (iommu_init_ga_log(iommu) ||
> +		    iommu_ga_log_enable(iommu))
> +			return;
> +
> +		iommu_feature_enable(iommu, CONTROL_GAM_EN);
> +	}
> +
> +	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
> +	pr_info("Virtual APIC enabled\n");
> +#endif
> +}
> +
>  static void enable_iommus(void)
>  {
>  	early_enable_iommus();
> -
> +	enable_iommus_vapic();
>  	enable_iommus_v2();
>  }
>  
> @@ -3126,6 +3150,7 @@ static int __init state_next(void)
>  		register_syscore_ops(&amd_iommu_syscore_ops);
>  		ret = amd_iommu_init_pci();
>  		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
> +		enable_iommus_vapic();
>  		enable_iommus_v2();
>  		break;
>  	case IOMMU_PCI_INIT:
> -- 
> 2.34.1
> 

