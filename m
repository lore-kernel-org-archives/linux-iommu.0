Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA2A940
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 13:14:55 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7659cb9c42aso162456485a.3
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691154894; x=1691759694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RT+Sr6a/1l5Euyg5CbRauXZRb2HkKTFXhVii/k294wU=;
        b=XvpFuuN7iWuwbhgGfa8ZonGOLfjkLaZQaaHtix7rdcG0zMDKfahK4ZiuAn03JQuUJ6
         KysfwYa42AZsat0Tb0wQsTYf27p/Q2Lgf89LX7lgbhhnKBWiL8O0IYAeSH6B3qHI8/tZ
         pXQtyoqqsvVDlxYL4sPRI8qNoBYg+nJtzM7mzs2PeLsEsunvoK/pbIG3Tp+pdLMnxbca
         ptASkE91OGxSrtkvN+eJG3ePcZYGizQWLyjbnuskayV7Ds52bQftOvxNBjhkKbxmEoxh
         jmqa4YjmiMROjpwiisHiwUiVFRiViFyvHDaUO0YsvByLdoHmzL1wfl1p0ttJbXe72VHe
         FT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154894; x=1691759694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT+Sr6a/1l5Euyg5CbRauXZRb2HkKTFXhVii/k294wU=;
        b=LXhSpmmuc+b5xyAQnLouv8ioQ2cTF9tyxUCJt1KurAEclnZ6SdgsLHxhRmetpp2J1a
         vHEHgs+W1x9G1USJy/TizWvbjIPdPhYaTOEITHEoHJeifiVVh43DhWzAWl39tPUH/qYY
         pjR08lVNF+ZTokun3iyssv02AryP555OzIttnSclbvhbYsl0gHiLNCZFRqBaA8TF1SwA
         bSfaQjPNFwphZJVjR+3esEpOmbctF7ZsVTHGVpgtLBzXB16aKsYdl/4HbZLu6rnJ/wTc
         T0NR5Gi91ti0W6KLmoYTxCDZnwYH/FPlVyvlLP4Y65yL0H0JFwCEAQZStRnWuybPVOr+
         PTzA==
X-Gm-Message-State: AOJu0Yzqu3hKm+Slwdx+2cGlFW+3H8rr8Jo5Ti5FbtAQ7F/IayPytgG8
	UM6ALieqTGx2+HaYUnvk1jY5Ag==
X-Google-Smtp-Source: AGHT+IFE+snyU9foeOBpTxVd8H9BoT+CP9LyhiS+p4yq1iL0Z2vu6vAQ1MgUK2uHvhn0adCDVn0Ung==
X-Received: by 2002:a0c:fe07:0:b0:635:f4e3:8842 with SMTP id x7-20020a0cfe07000000b00635f4e38842mr1334803qvr.48.1691154894581;
        Fri, 04 Aug 2023 06:14:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x13-20020a0ce24d000000b0063d31b493e1sm647972qvl.99.2023.08.04.06.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:14:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRudp-003icY-IQ;
	Fri, 04 Aug 2023 10:14:53 -0300
Date: Fri, 4 Aug 2023 10:14:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 15/16] iommu/amd: Initialize iommu_device->max_pasids
Message-ID: <ZMz5zVbcEVX6Rrj2@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-16-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804064216.835544-16-vasant.hegde@amd.com>

On Fri, Aug 04, 2023 at 06:42:15AM +0000, Vasant Hegde wrote:
> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
> introduced a variable struct iommu_device.max_pasids to track max
> PASIDS supported by each IOMMU.
> 
> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
> to set max PASIDs per device (see __iommu_probe_device()).
> 
> Also remove unused global 'amd_iommu_max_pasid' variable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>  drivers/iommu/amd/init.c            | 9 ++-------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index e114e4af0f05..0d339e022572 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -895,9 +895,6 @@ extern unsigned amd_iommu_aperture_order;
>  /* allocation bitmap for domain ids */
>  extern unsigned long *amd_iommu_pd_alloc_bitmap;
>  
> -/* Smallest max PASID supported by any IOMMU in the system */
> -extern u32 amd_iommu_max_pasid;
> -
>  extern bool amd_iommu_force_isolation;
>  
>  /* Max levels of glxval supported */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1f56478ae74e..e0b0e48d3d38 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -185,8 +185,6 @@ static int amd_iommus_present;
>  bool amd_iommu_np_cache __read_mostly;
>  bool amd_iommu_iotlb_sup __read_mostly = true;
>  
> -u32 amd_iommu_max_pasid __read_mostly = ~0;
> -
>  static bool amd_iommu_pc_present __read_mostly;
>  bool amdr_ivrs_remap_support __read_mostly;
>  
> @@ -2086,16 +2084,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  
>  	if (iommu_feature(iommu, FEATURE_GT)) {
>  		int glxval;
> -		u32 max_pasid;
>  		u64 pasmax;
>  
>  		pasmax = iommu->features & FEATURE_PASID_MASK;
>  		pasmax >>= FEATURE_PASID_SHIFT;
> -		max_pasid  = (1 << (pasmax + 1)) - 1;
> -
> -		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
> +		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
>  
> -		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
> +		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);

You said you'd fix this to remove the BUG_ON.

Jason
