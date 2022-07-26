Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2208290D
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658849553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3OZWp+Xqi4z0H2oNSiwUoH1tGXNHUeblQL65iP9Ri4=;
	b=Iijc+PLvc8/yatrrCHL9rFD6O731+h7nOwcCjyBXjM+vX/dSvRWWGjYrUHpQEAsGGqJGTb
	FWmPZbt5YU4waNejRkS0DveTx39TTx00Fbj67VzXh2NEBT7Hx2M6RJyvKq5HZV8xwY5HOf
	oxC2AFeoLtQosARTTL3O0wHmnbSchwk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-CnHMwCOROB-qX2BveER5Gg-1; Tue, 26 Jul 2022 11:32:30 -0400
X-MC-Unique: CnHMwCOROB-qX2BveER5Gg-1
Received: by mail-qk1-f199.google.com with SMTP id y17-20020a05620a25d100b006b66293d75aso3749640qko.17
        for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 08:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3OZWp+Xqi4z0H2oNSiwUoH1tGXNHUeblQL65iP9Ri4=;
        b=0ZWzyuFOTn/S4LlI7nihuiFFS0iJy+zBCTLGiWB4DDWJ+ArbxsD1yj2jKLS1YuNMeF
         e/XA+GghGP+MJ41zV3JX1k7dA+6GXxSwUib8pL8rg+3Lul57EFeElOOeV1HVYuZF3K40
         c0w4bja6SxUt2nnQgBOYwwxJ4NRCoZSR9lrzMiWm/HhjTPULFUGC18XS+AZ+TPB6Y4NM
         NqPkXeMRpD7lE2S9fSXrBdEQyx25gnHUQhMyUnpe9E0JT4BxaTh5xFLcHnP1k+m7C+Qn
         ndllajOg32vQ8sYPUqBvg6s1j4tY154oxYv43vYoUSITYPln9sQuqT9dYWcJL6MOYJRD
         +w3A==
X-Gm-Message-State: AJIora/kcJTfLtirdfwP03Ucr+kI9Sb64tCZWT6KHv1t3XH6KPUc4EQu
	oROesYFZ05mhtPhHttlxBn56rZfen5v7KKFPEWzKF0wDc+HxiIIKdhFS4kGOsEhG4Y14SqcKe5M
	9TDponzcOUyZke0w=
X-Received: by 2002:ad4:5fcb:0:b0:474:1b28:b30a with SMTP id jq11-20020ad45fcb000000b004741b28b30amr14943892qvb.55.1658849549388;
        Tue, 26 Jul 2022 08:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQEi/c32h/TJaYnrFTO5628e9fk6qo37ezvNTiISSjPrm/nohsOryfPOBTYbG8Yb3pHTr1pw==
X-Received: by 2002:ad4:5fcb:0:b0:474:1b28:b30a with SMTP id jq11-20020ad45fcb000000b004741b28b30amr14943851qvb.55.1658849549015;
        Tue, 26 Jul 2022 08:32:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t2-20020ac85882000000b0031eb02307a9sm9267411qta.80.2022.07.26.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:32:28 -0700 (PDT)
Date: Tue, 26 Jul 2022 08:32:27 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	will@kernel.org, vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 2/2] iommu/amd: Add support for AVIC when SNP is enabled
Message-ID: <20220726153227.caqf6hagmwu727ls@cantor>
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
 <20220726134348.6438-3-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220726134348.6438-3-suravee.suthikulpanit@amd.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2022 at 08:43:48AM -0500, Suravee Suthikulpanit wrote:
> In order to support AVIC on SNP-enabled system, The IOMMU driver needs to
> check EFR2[SNPAVICSup] and enables the support by setting SNPAVICEn bit
> in the IOMMU control register (MMIO offset 18h).
> 
> For detail, please see section "SEV-SNP Guest Virtual APIC Support" of the
> AMD I/O Virtualization Technology (IOMMU) Specification.
> (https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf)
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Is this a typo in the 3.06 spec for SNPAVIC_EN?

"001b-111b = Reserved."

Or I guess maybe there is a newer revision that isn't available yet
that describes 001b?

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/init.c            | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3c1205ba636a..5b1019dab328 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -103,6 +103,12 @@
>  #define FEATURE_GLXVAL_SHIFT	14
>  #define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
>  
> +/* Extended Feature 2 Bits */
> +#define FEATURE_SNPAVICSUP_SHIFT	5
> +#define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
> +#define FEATURE_SNPAVICSUP_GAM(x) \
> +	((x & FEATURE_SNPAVICSUP_MASK) >> FEATURE_SNPAVICSUP_SHIFT == 0x1)
> +
>  /* Note:
>   * The current driver only support 16-bit PASID.
>   * Currently, hardware only implement upto 16-bit PASID
> @@ -165,6 +171,7 @@
>  #define CONTROL_GAINT_EN	29
>  #define CONTROL_XT_EN		50
>  #define CONTROL_INTCAPXT_EN	51
> +#define CONTROL_SNPAVIC_EN	61
>  
>  #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
>  #define CTRL_INV_TO_NONE	0
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 4cd94d716122..6bbaf6b971e8 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2794,13 +2794,22 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
>  
> -	/* Enabling GAM support */
> +	if (amd_iommu_snp_en &&
> +	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> +		pr_warn("Force to disable Virtual APIC due to SNP\n");
> +		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> +		return;
> +	}
> +
> +	/* Enabling GAM and SNPAVIC support */
>  	for_each_iommu(iommu) {
>  		if (iommu_init_ga_log(iommu) ||
>  		    iommu_ga_log_enable(iommu))
>  			return;
>  
>  		iommu_feature_enable(iommu, CONTROL_GAM_EN);
> +		if (amd_iommu_snp_en)
> +			iommu_feature_enable(iommu, CONTROL_SNPAVIC_EN);
>  	}
>  
>  	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
> -- 
> 2.34.1
> 

