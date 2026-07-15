Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB732E128
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144520; cv=none; b=ShQ+HdPyfM+wcae77VRoPovbbTOKxZdff1Fb3A2cxSFQ+cSToF5HzxpTRqwpddHD97jJpHQX34mHYz1KKsGe4+KNqw7QhWbzqVfLvsL2lurkpiArleobsrV0UKLgHhImz4Ozj2Q2GwdlTMzma9ho94y9eTvIXTd1diLetUwjkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144520; c=relaxed/simple;
	bh=bEfCiQbpt51RPGirUKTm56gtczkGqZWvAAvtcHUoXhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEwyRN3wbPp5bMDz8pG+X3IzBC5hWoKq7kkFvn7ghZcYrgJpDz4eKsMzdnVCyDEDZZK57AFRHjqYaZpW0iV5tuNiHEbSy9lh05mRBqw/J6MAUfzLn4xMdCykMaRNUQ+fCN8j+gzMpl/9cw8jtQ5kp53FJ+uRTkuGSQAvyItkJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdd1boUw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdd1boUw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab97c86bdso65ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784144519; x=1784749319; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xs5wjiLWp1Vv9wwN6tQ6J5wJNudL5o7nEKHihQ5S7JU=;
        b=cdd1boUwWHXENNrglHYAkXU2aJg3qGkqnFE7Y+d0/fHI3Q6rwNFFdxJHLfveea0o7p
         DSMYBKwR2pxabQ6xSUGjXg8NX+UNQXR3PLA2+5Erdy2sXkz+kqUHbQ8z7dYzusitsMp8
         1hEv+8XyR8cgHaOOFmdR2jvkLuDPRisOJhVhoCEsf8Ehhn4UbGRuhydWFimwTtQa1YnU
         snb68WYRx1GlEdIA526T0S8kqjFU7ikRpvyAz7p+fSu46gHkj3jkEhwJSlty/JkuYvMw
         xiggEK9ajR2yplDkZ1wmtWt1Rb+eiA1Mv3Tm/QFm8i3tqt05hEQ0SdNlYIKaxbbO1cDl
         uHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784144519; x=1784749319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xs5wjiLWp1Vv9wwN6tQ6J5wJNudL5o7nEKHihQ5S7JU=;
        b=rGtgV/AY+yz205G5iROFzirQLcM87jeElGxWgZbCkz+Tr8O0wIuLjs/o3R/Ug3hh/X
         r9o4ntOqPjPZkjvIYP3SH631d3RGZzRQPX8Ph8oOp5S/IcEWP5MnS2oRyLzmNBj3xS1k
         4GNDFursfES2bSQ+gmReRSatRgihs1bidfWgvz/tDdkm6f4Y7SCTIr1VCPuczLj5Aj+Y
         zSoP0gc7GBZvB/B/WJpvFySMScTEsK5SXqCKJbVH+nRb/uP+rUHvh7fx2p3BHnSAvGe3
         oawmHE6tfY8iITLxythAxalSVBJK65Kr9zk2crK+gZFrX1D5LqYGiqGG6Uj3eCrBv3HI
         Utww==
X-Forwarded-Encrypted: i=1; AHgh+Ro1OMwWoift75ll69It/yBlgOv5cwj0+lvYhNPxT9A6QqWgVQDcJE4Zfe8NsYAZ+AXJda243A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0x6vqADWsYCyBVzD6j1kL8IECYdt8AdKmYZ187ezQaoA+Q5bS
	t9ggFcX/yVEAJRfE45YXmORVj3QJQvUkEZ+HaItaN33SY/pYUQvMTUJoimTudHhl+Q==
X-Gm-Gg: AfdE7ckJ6lMP9JRf/iVhNmX/wmIBCbo/54qgxFxW4TJHMBY4NBNmGA+47kxKIDFJMIF
	xIuGIzFdr1l3/U5wcdPoIDqPtAVlL61vlIDsa040h10L7OPjPutjRL67AVsrPwOfN+JkZx+2A9b
	kWynnH9M2Z3wk5wM1aDYrnt5Rhky0pTPbGAldgGvtjA9i03zCoNUr62cHyg+mjRXh6acEabI+E3
	3Xm8+w1xZN3l2HTBsPwASCSUT92qa6sxxXgvwY00OtTEcqGqOFx+8JXTyjEGmVSo48zc/yTC35G
	rRTje0vB/ZpGZcpwy/Cf3LK5X/9kX0ixUad0l1ZR3q62yDu6YBCRs+X2KdpSN3T6T0aCEZZXA/P
	A+mSDhATE8tqwTSSCTsOeJaJ4LXz9712N3A5nvM0JK148gtiBfXPzqPYkkaQ91XPV8hNRWR1LBI
	3TJJ3oiK22jHtaQSKncsz0h4BFhVHTWNwz2w5bGgSjjeKOIIWf7TojZdOCAg==
X-Received: by 2002:a17:903:468e:b0:2c6:99be:9dd with SMTP id d9443c01a7336-2cf1a3f3c26mr584525ad.12.1784144518335;
        Wed, 15 Jul 2026 12:41:58 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055f193sm7744695ad.46.2026.07.15.12.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:41:57 -0700 (PDT)
Date: Wed, 15 Jul 2026 19:41:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iommu/arm-smmu-v3: Support IDR5.DS and widen the
 TLBI SCALE field
Message-ID: <alfifgOM_YwTAP0y@google.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <3f0c3e7b7e9177586d7e545d8089ead4ef7890f0.1784054606.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0c3e7b7e9177586d7e545d8089ead4ef7890f0.1784054606.git.nicolinc@nvidia.com>

On Tue, Jul 14, 2026 at 11:48:47AM -0700, Nicolin Chen wrote:
> An SMMU implementing SMMU_IDR5.DS extends the range invalidation commands:
> the SCALE field grows a 6th bit, raising its maximum value from 31 to 39,
> and TTL == 0b01 becomes a valid level hint for a 16KB translation granule.
> 
> Add a new ARM_SMMU_FEAT_DS feature detecting the DS bit, and widen the
> CMDQ_TLBI_0_SCALE field to its architectural 6 bits. Mask the scale value
> explicitly in arm_smmu_cmdq_batch_add_range(), so the range invalidation
> path emits the same commands as before, keeping the pre-existing 5-bit
> truncation of a scale above 31.
> 
> Also list DS as a valid IDR5 field in the iommu_hw_info_arm_smmuv3 kdoc:
> iommufd has always reported the raw IDR5 register, so a VMM may conclude
> from that bit alone that it can expose DS to its guest.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Cc: stable@vger.kernel.org # needed by the subsequent fix
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 4 +++-
>  include/uapi/linux/iommufd.h                | 4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index c909c9a88538b..3c59e62978a13 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -64,6 +64,7 @@ struct arm_vsmmu;
>  
>  #define ARM_SMMU_IDR5			0x14
>  #define IDR5_STALL_MAX			GENMASK(31, 16)
> +#define IDR5_DS				(1 << 7)
>  #define IDR5_GRAN64K			(1 << 6)
>  #define IDR5_GRAN16K			(1 << 5)
>  #define IDR5_GRAN4K			(1 << 4)
> @@ -415,7 +416,7 @@ struct arm_smmu_cmd {
>  
>  #define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
>  #define CMDQ_TLBI_RANGE_NUM_MAX		31
> -#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
> +#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(25, 20)
>  #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
>  #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
>  #define CMDQ_TLBI_1_LEAF		(1UL << 0)
> @@ -921,6 +922,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_HD		(1 << 22)
>  #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
>  #define ARM_SMMU_FEAT_BBML2		(1 << 24)
> +#define ARM_SMMU_FEAT_DS		(1 << 25)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 0425d452d41ed..72bb0e47dc272 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -594,7 +594,7 @@ struct iommu_hw_info_vtd {
>   * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
>   * idr[1]: SIDSIZE, SSIDSIZE
>   * idr[3]: BBML, RIL
> - * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
> + * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K, DS
>   *
>   * - S1P should be assumed to be true if a NESTED HWPT can be created
>   * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
> @@ -602,7 +602,7 @@ struct iommu_hw_info_vtd {
>   * - ATS is a per-device property. If the VMM describes any devices as ATS
>   *   capable in ACPI/DT it should set the corresponding idr.
>   *
> - * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
> + * This list may expand in future (eg E0PD, AIE, PBHA, D128 etc). It is
>   * important that VMMs do not read bits outside the list to allow for
>   * compatibility with future kernels. Several features in the SMMUv3
>   * architecture are not currently supported by the kernel for nesting: HTTU,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a10affb483a4f..9f121f9f404ea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2446,9 +2446,10 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  			/* Determine how many chunks of 2^scale size we have */
>  			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>  
> +			/* Keep the pre-DS 5-bit truncation when scale > 31 */
>  			cmd->data[0] = orig_data0 |
>  				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
> -				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
> +				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);

Nit: Not sure what the convention is for these things, but this cap for
host is temporary as Jason's iommupt series expands the scale when DS=1.
I'm not sure if we should note a TODO here or just leave it be for now?

This is where Jason adds DS support for Host: 
https://lore.kernel.org/all/8-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com/

>  
>  			/* range is num * 2^scale * pgsize */
>  			inv_range = num << (scale + tg);
> @@ -5098,6 +5099,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	/* Maximum number of outstanding stalls */
>  	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
>  
> +	if (reg & IDR5_DS)
> +		smmu->features |= ARM_SMMU_FEAT_DS;
> +
>  	/* Page sizes */

Apart from that, 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
