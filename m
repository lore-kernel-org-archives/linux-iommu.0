Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03275229
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 18:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686596332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOCUbTgd1O1P2JYYfNfmGmoWooOfnLdqCNAHGKQ0nWs=;
	b=DGiw+nx74Q+d4VwN7uBwcXz6q3HGhV5txxyFXyN0qdXeb4at8d/HnSelViTyAZigkCORDG
	o7dcnsvyMQb9YFmFuYG6eP0TbHoVpfcCGZsBec0ahxZt3+UjkOsdaxmTSyZPvhtFgDm8LP
	lsQme7E/w6tyGL6nHnaz2ZeZEm9aRxA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-4wTgcNxON4W3h5NuEwqDWw-1; Mon, 12 Jun 2023 14:58:50 -0400
X-MC-Unique: 4wTgcNxON4W3h5NuEwqDWw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6238c3bf768so2971496d6.0
        for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 11:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596330; x=1689188330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOCUbTgd1O1P2JYYfNfmGmoWooOfnLdqCNAHGKQ0nWs=;
        b=NEgE5CxwUakQeBuVoNA7BGqET4Q+wi30SSCleU8yFddC7RegO5+2UzID4Q3cltJro+
         U/0wa3fUejB1Mos+44kvDtDgYJNcePtkNGtvb1ahfbCVwIkMPDN9m8BLalrqmod0Vvwq
         FsRqkQZINI50oD47wVzq+oN346p95B3IyFMVuHLxlZV2/Y9JabLj8qSX/cKCoW7DUKIq
         QsTG4OR/7cUIoXTd9VexfWOvAvRqlJn9M74eMbo51BGyCsN5V5lyvE93Qxuv5DdgdGKL
         8kZLf8Aq/lPC/4N/JTW1RrWz2U5Ja9WutiShCWfVpAYbprCxVwN+wEOXVANKHjWgPen/
         b3nQ==
X-Gm-Message-State: AC+VfDzEGtEFKx/UHB/KZVYnAKlCaMnqY6/yfmq1uxGmablL4S1cBGEs
	m6RCagjYL0T87Y6sawmiadjcUma5bPnTZ8lmLhnhj+tzw1eHHDntJppEmRXeiqO3IaFvbUThOvN
	SAmKj1qP9WXQ4MjvHzCmKxXM=
X-Received: by 2002:a05:6214:27eb:b0:625:aa49:ceae with SMTP id jt11-20020a05621427eb00b00625aa49ceaemr11527733qvb.55.1686596329832;
        Mon, 12 Jun 2023 11:58:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70baSuTycpOGYH9FZC7pWcfXozF/5/hzvKMzzO92LMY1tSYFRug/rOkPWPtnFZI39d/ru4pQ==
X-Received: by 2002:a05:6214:27eb:b0:625:aa49:ceae with SMTP id jt11-20020a05621427eb00b00625aa49ceaemr11527726qvb.55.1686596329607;
        Mon, 12 Jun 2023 11:58:49 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g8-20020a0ce4c8000000b0062381fa97c5sm3401620qvm.92.2023.06.12.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:58:49 -0700 (PDT)
Date: Mon, 12 Jun 2023 11:58:47 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Remove extern from function prototypes
Message-ID: <76bjjzt2kivzmxz47s3c5yn2xqmifdhwcsozemqjf47ujceihb@coha6d47yfxo>
References: <20230609090631.6052-1-vasant.hegde@amd.com>
 <20230609090631.6052-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609090631.6052-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 09:06:31AM +0000, Vasant Hegde wrote:
> The kernel coding style does not require 'extern' in function prototypes.
> Hence remove them from header file.
> 
> No functional change intended.
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu.h       | 88 ++++++++++++++---------------
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  2 files changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 9beeceb9d825..317d5c26c614 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -11,12 +11,12 @@
>  
>  #include "amd_iommu_types.h"
>  
> -extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
> -extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
> -extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
> -extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
> -extern void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
> -extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
> +irqreturn_t amd_iommu_int_thread(int irq, void *data);
> +irqreturn_t amd_iommu_int_handler(int irq, void *data);
> +void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
> +void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
> +void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
> +void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
> @@ -25,11 +25,11 @@ static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
>  #endif
>  
>  /* Needed for interrupt remapping */
> -extern int amd_iommu_prepare(void);
> -extern int amd_iommu_enable(void);
> -extern void amd_iommu_disable(void);
> -extern int amd_iommu_reenable(int);
> -extern int amd_iommu_enable_faulting(void);
> +int amd_iommu_prepare(void);
> +int amd_iommu_enable(void);
> +void amd_iommu_disable(void);
> +int amd_iommu_reenable(int mode);
> +int amd_iommu_enable_faulting(void);
>  extern int amd_iommu_guest_ir;
>  extern enum io_pgtable_fmt amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
> @@ -37,33 +37,32 @@ extern int amd_iommu_gpt_level;
>  /* IOMMUv2 specific functions */
>  struct iommu_domain;
>  
> -extern bool amd_iommu_v2_supported(void);
> -extern struct amd_iommu *get_amd_iommu(unsigned int idx);
> -extern u8 amd_iommu_pc_get_max_banks(unsigned int idx);
> -extern bool amd_iommu_pc_supported(void);
> -extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
> -extern int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value);
> -extern int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value);
> -
> -extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
> -extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
> -extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
> -extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
> -extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
> -				u64 address);
> -extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
> -extern void amd_iommu_domain_update(struct protection_domain *domain);
> -extern void amd_iommu_domain_flush_complete(struct protection_domain *domain);
> -extern void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
> -extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
> -extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
> -				     unsigned long cr3);
> -extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
> +bool amd_iommu_v2_supported(void);
> +struct amd_iommu *get_amd_iommu(unsigned int idx);
> +u8 amd_iommu_pc_get_max_banks(unsigned int idx);
> +bool amd_iommu_pc_supported(void);
> +u8 amd_iommu_pc_get_max_counters(unsigned int idx);
> +int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +			 u8 fxn, u64 *value);
> +int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +			 u8 fxn, u64 *value);
> +
> +int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
> +int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
> +void amd_iommu_domain_direct_map(struct iommu_domain *dom);
> +int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
> +int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
> +void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
> +void amd_iommu_domain_update(struct protection_domain *domain);
> +void amd_iommu_domain_flush_complete(struct protection_domain *domain);
> +void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
> +int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
> +int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
> +			      unsigned long cr3);
> +int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
>  
>  #ifdef CONFIG_IRQ_REMAP
> -extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
> +int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
>  #else
>  static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  {
> @@ -75,8 +74,8 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  #define PPR_INVALID			0x1
>  #define PPR_FAILURE			0xf
>  
> -extern int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
> -				  int status, int tag);
> +int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
> +			   int status, int tag);
>  
>  static inline bool is_rd890_iommu(struct pci_dev *pdev)
>  {
> @@ -129,10 +128,9 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
>  	return page ? page_address(page) : NULL;
>  }
>  
> -extern bool translation_pre_enabled(struct amd_iommu *iommu);
> -extern bool amd_iommu_is_attach_deferred(struct device *dev);
> -extern int __init add_special_device(u8 type, u8 id, u32 *devid,
> -				     bool cmd_line);
> +bool translation_pre_enabled(struct amd_iommu *iommu);
> +bool amd_iommu_is_attach_deferred(struct device *dev);
> +int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
>  
>  #ifdef CONFIG_DMI
>  void amd_iommu_apply_ivrs_quirks(void);
> @@ -140,9 +138,9 @@ void amd_iommu_apply_ivrs_quirks(void);
>  static inline void amd_iommu_apply_ivrs_quirks(void) { }
>  #endif
>  
> -extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
> -					 u64 *root, int mode);
> -extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
> +void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
> +				  u64 *root, int mode);
> +struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
>  
>  extern u64 amd_iommu_efr;
>  extern u64 amd_iommu_efr2;
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a49cc2258a76..364fdaa52e74 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -882,7 +882,7 @@ extern int amd_iommu_max_glx_val;
>   * This function flushes all internal caches of
>   * the IOMMU used by this driver.
>   */
> -extern void iommu_flush_all_caches(struct amd_iommu *iommu);
> +void iommu_flush_all_caches(struct amd_iommu *iommu);
>  
>  static inline int get_ioapic_devid(int id)
>  {
> -- 
> 2.31.1
> 

