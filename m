Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39475252
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686596108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wpS71uftXEcw6LVSYVQzmE2qED1310HLXMXjIr30L0=;
	b=QcSxAlgSoLAI4U4xXM9VAEugYuCK5YSgZBzf6CjsBZqZF+vQ3VZpF56aIDac6Kdl/vnQBr
	OKybZMIKrCcpK6nPL38VLo8gUcV/d87vTmwQ0QuYVDne7e9g3qdx70Gxta4mBq6dslcUp2
	djKUoa79qacJtSvf+wPqhXVckBRHxCc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-tcwBNux4OX6JjUOJG2dH3g-1; Mon, 12 Jun 2023 14:55:06 -0400
X-MC-Unique: tcwBNux4OX6JjUOJG2dH3g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75dfef90315so28245485a.1
        for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 11:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596105; x=1689188105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wpS71uftXEcw6LVSYVQzmE2qED1310HLXMXjIr30L0=;
        b=J6NT7Zjze0Fa+THLXG/xCTWNWcB3z5uNW0/wN1oNvcq0VDmcVa756JWL79dbROfgKy
         RsArUAAvLm7DWm/e9+e0SGGec1Kr9X4yd/qt3W0UetuZH7gpsgcugyzfrTamOi5QAd3h
         1uUs3hP5IK1//sYY+hSg8KRkFQYqHHLZN2xaXbP36T78ehoxIo1ZrRbIl9putYdP/tYs
         7nXFAv9wmviH/MJil984HHd5qfHKSM8vo+lNCSDRemf9n8e9U4UhabHunc4Au9A5AE1X
         5k5jJgCMuqZ8R9TKzUKaTVyNA5I7OR7giwK2vJMIo2zE5M0oMzu347OhJxrCOjQki9sd
         H0VA==
X-Gm-Message-State: AC+VfDyciA9A4Sar2/ySCTdTom0xB8MaJis/BDvhcp9ve896sM9YHyJt
	AWHct/8AmwKosXX+om+77KZfRLCq2hMpj7kGEVJCNtDmLVOlZ8eVAjFlR8w2dyF865hACscOMYm
	5H6ZvRh+LpRZM4Fo=
X-Received: by 2002:a05:620a:4608:b0:75d:50f8:fa82 with SMTP id br8-20020a05620a460800b0075d50f8fa82mr12815808qkb.30.1686596105474;
        Mon, 12 Jun 2023 11:55:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ypzDGStGD8NU2fW5WUZ7UkJXyk9iJ/mYea/f4yCQl37yReVlAaCOGXhTbuL0pUGU8bfe5vA==
X-Received: by 2002:a05:620a:4608:b0:75d:50f8:fa82 with SMTP id br8-20020a05620a460800b0075d50f8fa82mr12815790qkb.30.1686596105133;
        Mon, 12 Jun 2023 11:55:05 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q24-20020ae9e418000000b0075784a8f13csm3042331qkc.96.2023.06.12.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:55:04 -0700 (PDT)
Date: Mon, 12 Jun 2023 11:55:03 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 1/2] iommu/amd: Use BIT/BIT_ULL macro to define bit fields
Message-ID: <otpf4apjgppcdkm7k7jfq36k7l72l4gqm45lrrimza2d46t45e@6wm5d3jmfxu3>
References: <20230609090631.6052-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609090631.6052-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 09:06:30AM +0000, Vasant Hegde wrote:
> Make use of BIT macro when defining bitfields which makes it easy to read.
> 
> No functional change intended.
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 76 ++++++++++++++---------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index ae0edeb379d4..a49cc2258a76 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -84,21 +84,21 @@
>  
>  
>  /* Extended Feature Bits */
> -#define FEATURE_PREFETCH	(1ULL<<0)
> -#define FEATURE_PPR		(1ULL<<1)
> -#define FEATURE_X2APIC		(1ULL<<2)
> -#define FEATURE_NX		(1ULL<<3)
> -#define FEATURE_GT		(1ULL<<4)
> -#define FEATURE_IA		(1ULL<<6)
> -#define FEATURE_GA		(1ULL<<7)
> -#define FEATURE_HE		(1ULL<<8)
> -#define FEATURE_PC		(1ULL<<9)
> +#define FEATURE_PREFETCH	BIT_ULL(0)
> +#define FEATURE_PPR		BIT_ULL(1)
> +#define FEATURE_X2APIC		BIT_ULL(2)
> +#define FEATURE_NX		BIT_ULL(3)
> +#define FEATURE_GT		BIT_ULL(4)
> +#define FEATURE_IA		BIT_ULL(6)
> +#define FEATURE_GA		BIT_ULL(7)
> +#define FEATURE_HE		BIT_ULL(8)
> +#define FEATURE_PC		BIT_ULL(9)
>  #define FEATURE_GATS_SHIFT	(12)
>  #define FEATURE_GATS_MASK	(3ULL)
> -#define FEATURE_GAM_VAPIC	(1ULL<<21)
> -#define FEATURE_GIOSUP		(1ULL<<48)
> -#define FEATURE_EPHSUP		(1ULL<<50)
> -#define FEATURE_SNP		(1ULL<<63)
> +#define FEATURE_GAM_VAPIC	BIT_ULL(21)
> +#define FEATURE_GIOSUP		BIT_ULL(48)
> +#define FEATURE_EPHSUP		BIT_ULL(50)
> +#define FEATURE_SNP		BIT_ULL(63)
>  
>  #define FEATURE_PASID_SHIFT	32
>  #define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
> @@ -120,13 +120,13 @@
>  #define PASID_MASK		0x0000ffff
>  
>  /* MMIO status bits */
> -#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	(1 << 0)
> -#define MMIO_STATUS_EVT_INT_MASK	(1 << 1)
> -#define MMIO_STATUS_COM_WAIT_INT_MASK	(1 << 2)
> -#define MMIO_STATUS_PPR_INT_MASK	(1 << 6)
> -#define MMIO_STATUS_GALOG_RUN_MASK	(1 << 8)
> -#define MMIO_STATUS_GALOG_OVERFLOW_MASK	(1 << 9)
> -#define MMIO_STATUS_GALOG_INT_MASK	(1 << 10)
> +#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	BIT(0)
> +#define MMIO_STATUS_EVT_INT_MASK		BIT(1)
> +#define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
> +#define MMIO_STATUS_PPR_INT_MASK		BIT(6)
> +#define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
> +#define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
> +#define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
>  
>  /* event logging constants */
>  #define EVENT_ENTRY_SIZE	0x10
> @@ -369,23 +369,23 @@
>  /*
>   * Bit value definition for I/O PTE fields
>   */
> -#define IOMMU_PTE_PR (1ULL << 0)
> -#define IOMMU_PTE_U  (1ULL << 59)
> -#define IOMMU_PTE_FC (1ULL << 60)
> -#define IOMMU_PTE_IR (1ULL << 61)
> -#define IOMMU_PTE_IW (1ULL << 62)
> +#define IOMMU_PTE_PR	BIT_ULL(0)
> +#define IOMMU_PTE_U	BIT_ULL(59)
> +#define IOMMU_PTE_FC	BIT_ULL(60)
> +#define IOMMU_PTE_IR	BIT_ULL(61)
> +#define IOMMU_PTE_IW	BIT_ULL(62)
>  
>  /*
>   * Bit value definition for DTE fields
>   */
> -#define DTE_FLAG_V  (1ULL << 0)
> -#define DTE_FLAG_TV (1ULL << 1)
> -#define DTE_FLAG_IR (1ULL << 61)
> -#define DTE_FLAG_IW (1ULL << 62)
> -
> -#define DTE_FLAG_IOTLB	(1ULL << 32)
> -#define DTE_FLAG_GIOV	(1ULL << 54)
> -#define DTE_FLAG_GV	(1ULL << 55)
> +#define DTE_FLAG_V	BIT_ULL(0)
> +#define DTE_FLAG_TV	BIT_ULL(1)
> +#define DTE_FLAG_IR	BIT_ULL(61)
> +#define DTE_FLAG_IW	BIT_ULL(62)
> +
> +#define DTE_FLAG_IOTLB	BIT_ULL(32)
> +#define DTE_FLAG_GIOV	BIT_ULL(54)
> +#define DTE_FLAG_GV	BIT_ULL(55)

Minor thing, but would it make sense to group these according
to which 64-bit word they are in? DTE_FLAG_IOTLB is in the
second 64-bit word of the DTE, and the rest are in the first.

Regards,
Jerry

>  #define DTE_FLAG_MASK	(0x3ffULL << 32)
>  #define DTE_GLX_SHIFT	(56)
>  #define DTE_GLX_MASK	(3)
> @@ -439,13 +439,13 @@
>  #define MAX_DOMAIN_ID 65536
>  
>  /* Protection domain flags */
> -#define PD_DMA_OPS_MASK		(1UL << 0) /* domain used for dma_ops */
> -#define PD_DEFAULT_MASK		(1UL << 1) /* domain is a default dma_ops
> +#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
> +#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
>  					      domain for an IOMMU */
> -#define PD_PASSTHROUGH_MASK	(1UL << 2) /* domain has no page
> +#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
>  					      translation */
> -#define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
> -#define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
> +#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
> +#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
>  
>  extern bool amd_iommu_dump;
>  #define DUMP_printk(format, arg...)				\
> -- 
> 2.31.1
> 

