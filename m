Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDA6129
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:38:43 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-686bc261111so1657672b3a.3
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690555123; x=1691159923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79MYDAYU1xW74c6XyAkLFRftj3S1UHAvJ2QRURytDXw=;
        b=DsP+xGApxDliNtNMN2kDQ0uXjayVKniwjxISNhekhrs9T/sox02C663U0Lh9A+T8l8
         eA5npKhnCGs0rfg2ufVPljrM0l2HP/cEYnNaqmtAyQPII4nn2YRlmdsRVEE7dFk0ln/C
         8QhdrAO2QFCAfK84/8K6RNGF4VWUx0AGJ/9YxEu0kYcOn7jV426CRqYyzcgACCyIZbIK
         djMe3dvbidB99hB9KEtG3mLybkcIZnf6vDP4a/xw7jqwm4QiU8CIsRbJ/2fYWDhH593V
         ZeTiQq8z1mlNwei9IJMJRq367I3NWzjA3rWR1p3qHq/8dTKMoaiZrl8nreRq6I/ezhE8
         Z8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555123; x=1691159923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79MYDAYU1xW74c6XyAkLFRftj3S1UHAvJ2QRURytDXw=;
        b=jthDQ/wFHxfBLnmmlfOHRCrcXRcNBgZPXUhrJUWqA+qY4z4LrWEswXa1V4MCYD5Nv/
         2gVfJDelbSdFl9MHd+HTOSLbTqIy0xThYk+05+jUe5r+R6vJ+k2YTboQGGfImr93Wrc/
         r49pJDPzc+Z2a58vgPPjniO1gmu+im2mBjl154bS/JOaXi1D1eEkDsEgvsKeDPuBvw+0
         J0BAAjsGCamwOnc1MUjjyHvo27NZXwIISau9JfE4CQEFwtsU0++IXSrpuqc1bxIg1HLE
         dOICm5CacyhF81QVAUn3llcpgUBwn3MZtD3Q7i3o6LEQITEHN/+9W6KA/V0NfPR+tBBN
         BYNg==
X-Gm-Message-State: ABy/qLZeYsVqtPbUezawB+hbnwaFgnjz2UADpWCl79A1biFMS43wI1ww
	IJkbjPXngYYvy1lPJbTewcQpdQ==
X-Google-Smtp-Source: APBJJlHziBi68VdANW5yP7PcIBYd226J84DjXcCf9tUkWnuUqVQsMfhFHtxYz5krvaBmDo51CVA+2w==
X-Received: by 2002:a05:6a00:1955:b0:686:bc23:e20a with SMTP id s21-20020a056a00195500b00686bc23e20amr2136859pfk.21.1690555122704;
        Fri, 28 Jul 2023 07:38:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79255000000b00686bb3acfc2sm3282203pfp.181.2023.07.28.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:38:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOc4-001btE-Ok;
	Fri, 28 Jul 2023 11:38:40 -0300
Date: Fri, 28 Jul 2023 11:38:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 13/16] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Message-ID: <ZMPS8IGzwSWdnNWv@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-14-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:06AM +0000, Vasant Hegde wrote:
> Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
> ATS, PRI, and PASID capabilities. But these capabilities can be enabled
> independently (except PRI requires ATS support). Hence, replace
> the iommu_v2 variable with a flags variable, which keep track of the device
> capabilities.
>
> Device PRI/PASID is shared between PF and any associated VFs (See commit
> 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with
> all VFs")). Hence use pci_pri_supported() and pci_pasid_features()
> instead of pci_find_ext_capability() to check device PRI/PASID support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/iommu.c           | 39 +++++++++++++++--------------
>  2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 321d361dfb60..57c74870b17f 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -821,7 +821,7 @@ struct iommu_dev_data {
>  	struct protection_domain *domain; /* Domain the device is bound to */
>  	struct device *dev;
>  	u16 devid;			  /* PCI Device ID */
> -	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
> +	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
>  	int  ats_qdep;
>  	bool ats_enabled;		  /* ATS state */
>  	bool pri_tlp;			  /* PASID TLB required for
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e67c6fae452c..7f67e8991949 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -314,24 +314,25 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
>  	return entry->group;
>  }
>  
> -static bool pci_iommuv2_capable(struct pci_dev *pdev)
> +static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
>  {
> -	static const int caps[] = {
> -		PCI_EXT_CAP_ID_PRI,
> -		PCI_EXT_CAP_ID_PASID,
> -	};
> -	int i, pos;
> +	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
> +}
>  
> -	if (!pci_ats_supported(pdev))
> -		return false;
> +static u32 pdev_get_caps(struct pci_dev *pdev)
> +{
> +	u32 flags = 0;
>  
> -	for (i = 0; i < 2; ++i) {
> -		pos = pci_find_ext_capability(pdev, caps[i]);
> -		if (pos == 0)
> -			return false;
> -	}
> +	if (pci_ats_supported(pdev))
> +		flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
>  
> -	return true;
> +	if (pci_pri_supported(pdev))
> +		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
> +
> +	if (pci_pasid_features(pdev) >= 0)
> +		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
> +
> +	return flags;
>  }
>  
>  /*
> @@ -391,8 +392,8 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
>  	 * it'll be forced to go into translation mode.
>  	 */
>  	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
> -	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
> -		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
> +	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
> +		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
>  	}

This is even more confusing now. Why would the flags rely on policy knobs??

> @@ -1843,7 +1844,7 @@ static int attach_device(struct device *dev,
>  			goto out;
>  		}
>  
> -		if (dev_data->iommu_v2) {
> +		if (pdev_pasid_supported(dev_data)) {
>  			if (pdev_pri_ats_enable(pdev) != 0)
>  				goto out;

ATS should be usuable without PASID support. ATS on a RID is perfectly
valid and is being used in the real world.
  
> @@ -1909,7 +1910,7 @@ static void detach_device(struct device *dev)
>  	if (!dev_is_pci(dev))
>  		goto out;
>  
> -	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
> +	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
>  		pdev_iommuv2_disable(to_pci_dev(dev));
>  	else if (dev_data->ats_enabled)
>  		pci_disable_ats(to_pci_dev(dev));
> @@ -2464,7 +2465,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	 *    and require remapping.
>  	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
>  	 */
> -	if (dev_data->iommu_v2 &&
> +	if (pdev_pasid_supported(dev_data) &&
>  	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>  	    !amd_iommu_snp_en) {
>  		return IOMMU_DOMAIN_IDENTITY;

This looks like a mess that needs fixing. PASID support should never
be a trigger for an IDENTITY default domain.

If GPUs are broken then match their PCI ID's and do the workaround
only for them.

Jason
