Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED5AC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 08:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 532DE4246E;
	Wed, 22 Jun 2022 08:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 532DE4246E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hvpUduzgGSd; Wed, 22 Jun 2022 08:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D5914244F;
	Wed, 22 Jun 2022 08:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D5914244F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B7D1C0039;
	Wed, 22 Jun 2022 08:36:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7D37C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBE3F409B0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBE3F409B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWIUm9r2eJ-B for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:36:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF590409A6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF590409A6
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:36:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6B313D5;
 Wed, 22 Jun 2022 01:36:02 -0700 (PDT)
Received: from [10.57.85.1] (unknown [10.57.85.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDC893F66F;
 Wed, 22 Jun 2022 01:36:00 -0700 (PDT)
Message-ID: <4ec10456-777c-f26a-cfb2-c968a9bb3a4b@arm.com>
Date: Wed, 22 Jun 2022 09:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/7] iommu/amd: Introduce function to check and enable
 SNP
Content-Language: en-GB
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux-foundation.org
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
 <20220616015541.11207-5-suravee.suthikulpanit@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220616015541.11207-5-suravee.suthikulpanit@amd.com>
Cc: thomas.lendacky@amd.com, Brijesh Singh <brijesh.singh@amd.com>,
 ashish.kalra@amd.com, vasant.hegde@amd.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-06-16 02:55, Suravee Suthikulpanit wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> To support SNP, IOMMU needs to be enabled, and prohibits IOMMU
> configurations where DTE[Mode]=0, which means it cannot be supported with
> IOMMU passthrough domain (a.k.a IOMMU_DOMAIN_IDENTITY),
> and when AMD IOMMU driver is configured to not use the IOMMU host (v1) page
> table. Otherwise, RMP table initialization could cause the system to crash.
> 
> The request to enable SNP support in IOMMU must be done before PCI
> initialization state of the IOMMU driver because enabling SNP affects
> how IOMMU driver sets up IOMMU data structures (i.e. DTE).
> 
> Unlike other IOMMU features, SNP feature does not have an enable bit in
> the IOMMU control register. Instead, the IOMMU driver introduces
> an amd_iommu_snp_en variable to track enabling state of SNP.
> 
> Introduce amd_iommu_snp_enable() for other drivers to request enabling
> the SNP support in IOMMU, which checks all prerequisites and determines
> if the feature can be safely enabled.
> 
> Please see the IOMMU spec section 2.12 for further details.
> 
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  5 ++++
>   drivers/iommu/amd/init.c            | 45 +++++++++++++++++++++++++++--
>   drivers/iommu/amd/iommu.c           |  4 +--
>   include/linux/amd-iommu.h           |  6 ++++
>   4 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 73b729be7410..ce4db2835b36 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -463,6 +463,9 @@ extern bool amd_iommu_irq_remap;
>   /* kmem_cache to get tables with 128 byte alignement */
>   extern struct kmem_cache *amd_iommu_irq_cache;
>   
> +/* SNP is enabled on the system? */
> +extern bool amd_iommu_snp_en;
> +
>   #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
>   #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
>   #define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
> @@ -1013,4 +1016,6 @@ extern struct amd_irte_ops irte_32_ops;
>   extern struct amd_irte_ops irte_128_ops;
>   #endif
>   
> +extern struct iommu_ops amd_iommu_ops;
> +
>   #endif /* _ASM_X86_AMD_IOMMU_TYPES_H */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 013c55e3c2f2..b5d3de327a5f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -95,8 +95,6 @@
>    * out of it.
>    */
>   
> -extern const struct iommu_ops amd_iommu_ops;
> -
>   /*
>    * structure describing one IOMMU in the ACPI table. Typically followed by one
>    * or more ivhd_entrys.
> @@ -168,6 +166,9 @@ static int amd_iommu_target_ivhd_type;
>   
>   static bool amd_iommu_snp_sup;
>   
> +bool amd_iommu_snp_en;
> +EXPORT_SYMBOL(amd_iommu_snp_en);
> +
>   LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
>   LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
>   					   system */
> @@ -3549,3 +3550,43 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
>   
>   	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
>   }
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +int amd_iommu_snp_enable(void)
> +{
> +	/*
> +	 * The SNP support requires that IOMMU must be enabled, and is
> +	 * not configured in the passthrough mode.
> +	 */
> +	if (no_iommu || iommu_default_passthrough()) {
> +		pr_err("SNP: IOMMU is either disabled or configured in passthrough mode.\n");

I agree that clarifying what the actual implication is would be a good idea.

> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
> +	 * affect how IOMMU driver sets up data structures and configures
> +	 * IOMMU hardware.
> +	 */
> +	if (init_state > IOMMU_ENABLED) {
> +		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
> +		return -EINVAL;
> +	}
> +
> +	amd_iommu_snp_en = amd_iommu_snp_sup;
> +	if (!amd_iommu_snp_en)
> +		return -EINVAL;
> +
> +	pr_info("SNP enabled\n");
> +
> +	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
> +	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
> +		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
> +		amd_iommu_pgtable = AMD_IOMMU_V1;
> +		amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_iommu_snp_enable);

Once again this export seems dubious - surely the IOMMU is going to be 
enabled well before there's even a chance to load any modules?

> +#endif
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 86045dc50a0f..0792cd618dba 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -71,7 +71,7 @@ LIST_HEAD(acpihid_map);
>    * Domain for untranslated devices - only allocated
>    * if iommu=pt passed on kernel cmd line.
>    */
> -const struct iommu_ops amd_iommu_ops;
> +struct iommu_ops amd_iommu_ops;
>   
>   static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
>   int amd_iommu_max_glx_val = -1;
> @@ -2412,7 +2412,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>   	return 0;
>   }
>   
> -const struct iommu_ops amd_iommu_ops = {
> +struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
>   	.probe_device = amd_iommu_probe_device,
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 58e6c3806c09..d7bee7f09f92 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -206,4 +206,10 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
>   		u64 *value);
>   struct amd_iommu *get_amd_iommu(unsigned int idx);
>   
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +int amd_iommu_snp_enable(void);
> +#else
> +static inline int amd_iommu_snp_enable(void) { return -ENODEV; }
> +#endif

If this is only supposed to be called by other SEV code, it probably 
shouldn't need a stub.

Overall though, this is way nicer than v1, and it's definitely the right 
name in the right place now, thanks! FWIW, with those nits picked one 
way or another:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> +
>   #endif /* _ASM_X86_AMD_IOMMU_H */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
