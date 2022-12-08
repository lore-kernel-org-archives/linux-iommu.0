Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D02F3D
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670509136;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKuNJteKlwtjmhbsedIitXPHYtFxQuEHEQW4IfW2zLI=;
	b=cjboZrQpHbmC9gHydUSZY1g4s0ZmSGp6EoxmjtdWYdOQX5a+k2aU+HLHj39sOWjY9nnUjQ
	sd5Df9BnzE4HFHEbJiw8T5cWX73E+nShLKB/zP/7U9F/W/X9ccf7W6ctXjkXgjVANIxTCy
	kPv7uTX0TNGJima8DL2l03F75WYfcFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-_UBGzuEIPj-LiisigXQ5-A-1; Thu, 08 Dec 2022 09:18:53 -0500
X-MC-Unique: _UBGzuEIPj-LiisigXQ5-A-1
Received: by mail-wm1-f71.google.com with SMTP id m38-20020a05600c3b2600b003d1fc5f1f80so1845858wms.1
        for <iommu@lists.linux.dev>; Thu, 08 Dec 2022 06:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKuNJteKlwtjmhbsedIitXPHYtFxQuEHEQW4IfW2zLI=;
        b=zzqGbz1ZJ5iPdmoKt/h3yQN5FJq1/IXbnar8mg8adwbg3bpBse2piGyC7tjT2I2Lyu
         OXDsQ7Mlk1WmcZuRn3zohv6JWd7uoXL/GgJx9ZtlutquxKIK3GnYNboDEZjio162A4lL
         l4prch5pFDWV00TIfNnNrTDYeibDS+UD7kWqivWNp1PKi0O+/Hb4SwRilVjxi/DuEd8L
         aJboAhg4iLFoejZPCM+5a/2SkXXkpPZPZQy7rdn5m/UP/Hi9pVJ+wbOX+GYVgcZgLfUQ
         ELgc3Ga/yx54Iu931latUZ4axX129dTsHJXe7vBrsnRQYIvXLbA10h1nFQDVavgt/v+T
         0GxA==
X-Gm-Message-State: ANoB5pn8pekRoseIcftEzyOGhlTnSnXjaDZg98bYHG4DMX2waUe9gpYZ
	0Vd9Zsp2f2xy4JH/PWSltVKMXz23zrwjrrp6jKvyd9lac8M8hCAlt9MHc9b1alXvNLk3XhDAR5c
	xOPb825vbv3YUxKU=
X-Received: by 2002:a05:6000:910:b0:22e:6227:56fc with SMTP id bz16-20020a056000091000b0022e622756fcmr1764075wrb.0.1670509132176;
        Thu, 08 Dec 2022 06:18:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6A+2A2mF4OMs32f/78FyQNMmtOg8o0f0vrVP60btDitsKTxchdsNAlIlLOT68wUE3gO2yuAg==
X-Received: by 2002:a05:6000:910:b0:22e:6227:56fc with SMTP id bz16-20020a056000091000b0022e622756fcmr1764057wrb.0.1670509131877;
        Thu, 08 Dec 2022 06:18:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b00241e8d00b79sm27359202wrw.54.2022.12.08.06.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:18:51 -0800 (PST)
Message-ID: <148ee0ee-769e-201f-f918-5c3705225aeb@redhat.com>
Date: Thu, 8 Dec 2022 15:18:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 3/3] iommufd: Change the order of MSI setup
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

On 12/7/22 21:44, Jason Gunthorpe wrote:
> Eric points out this is wrong for the rare case of someone using
> allow_unsafe_interrupts on ARM. We always have to setup the MSI window in
> the domain if the iommu driver asks for it.
>
> Move the iommu_get_msi_cookie() setup to the top of the function and
> always do it, regardless of the security mode. Add checks to
> iommufd_device_setup_msi() to ensure the driver is not doing something
> incomprehensible. No current driver will set both a HW and SW MSI window.
>
> Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c       | 54 ++++++++++++----------------
>  drivers/iommu/iommufd/io_pagetable.c | 24 +++++++------
>  2 files changed, 37 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index dd2a415b603e3b..29ff97f756bc42 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -139,19 +139,11 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
>  	int rc;
>  
>  	/*
> -	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
> -	 * creates the MSI window by default in the iommu domain. Nothing
> -	 * further to do.
> -	 */
> -	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
> -		return 0;
> -
> -	/*
> -	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
> -	 * allocated iommu_domain will block interrupts by default and this
> -	 * special flow is needed to turn them back on. iommu_dma_prepare_msi()
> -	 * will install pages into our domain after request_irq() to make this
> -	 * work.
> +	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
> +	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
> +	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
> +	 * domain after request_irq(). If it is not done interrupts will not
> +	 * work on this domain.
>  	 *
>  	 * FIXME: This is conceptually broken for iommufd since we want to allow
>  	 * userspace to change the domains, eg switch from an identity IOAS to a
> @@ -159,33 +151,33 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
>  	 * matches what the IRQ layer actually expects in a newly created
>  	 * domain.
>  	 */
> -	if (irq_domain_check_msi_remap()) {
> -		if (WARN_ON(!sw_msi_start))
> -			return -EPERM;
> +	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
> +		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> +		if (rc)
> +			return rc;
> +
>  		/*
>  		 * iommu_get_msi_cookie() can only be called once per domain,
>  		 * it returns -EBUSY on later calls.
>  		 */
> -		if (hwpt->msi_cookie)
> -			return 0;
> -		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> -		if (rc)
> -			return rc;
>  		hwpt->msi_cookie = true;
> -		return 0;
>  	}
>  
>  	/*
> -	 * Otherwise the platform has a MSI window that is not isolated. For
> -	 * historical compat with VFIO allow a module parameter to ignore the
> -	 * insecurity.
> +	 * For historical compat with VFIO the insecure interrupt path is
> +	 * allowed if the module parameter is set. Insecure means that a MemWr
> +	 * operation from the device (eg a simple DMA) cannot trigger an
s/cannot/can
> +	 * interrupt outside this iommufd context.
>  	 */
> -	if (!allow_unsafe_interrupts)
> -		return -EPERM;
> +	if (!device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP) &&
> +	    !irq_domain_check_msi_remap()) {
> +		if (!allow_unsafe_interrupts)
> +			return -EPERM;
>  
> -	dev_warn(
> -		idev->dev,
> -		"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
> +		dev_warn(
> +			idev->dev,
> +			"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
I really prefer the legacy VFIO warning message: "No interrupt remapping
support.  Use ...". IRQ remapping is the feature that is actually
checked. MSI interrupt window sounds confusing: is it the MSI doorbell
or the range of addresses that correspond to MSI addresses.

Forgot to mention there is a minor typo in commit msg 2/3 "sicne"

Thanks

Eric
> +	}
>  	return 0;
>  }
>  
> @@ -203,7 +195,7 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
>  static int iommufd_device_do_attach(struct iommufd_device *idev,
>  				    struct iommufd_hw_pagetable *hwpt)
>  {
> -	phys_addr_t sw_msi_start = 0;
> +	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
>  	int rc;
>  
>  	mutex_lock(&hwpt->devices_lock);
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 3467cea795684c..e0ae72b9e67f86 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -1170,6 +1170,8 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
>  	struct iommu_resv_region *resv;
>  	struct iommu_resv_region *tmp;
>  	LIST_HEAD(group_resv_regions);
> +	unsigned int num_hw_msi = 0;
> +	unsigned int num_sw_msi = 0;
>  	int rc;
>  
>  	down_write(&iopt->iova_rwsem);
> @@ -1181,23 +1183,25 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
>  		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
>  			continue;
>  
> -		/*
> -		 * The presence of any 'real' MSI regions should take precedence
> -		 * over the software-managed one if the IOMMU driver happens to
> -		 * advertise both types.
> -		 */
> -		if (sw_msi_start && resv->type == IOMMU_RESV_MSI) {
> -			*sw_msi_start = 0;
> -			sw_msi_start = NULL;
> -		}
> -		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI)
> +		if (sw_msi_start && resv->type == IOMMU_RESV_MSI)
> +			num_hw_msi++;
> +		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI) {
>  			*sw_msi_start = resv->start;
> +			num_sw_msi++;
> +		}
>  
>  		rc = iopt_reserve_iova(iopt, resv->start,
>  				       resv->length - 1 + resv->start, device);
>  		if (rc)
>  			goto out_reserved;
>  	}
> +
> +	/* Drivers must offer sane combinations of regions */
> +	if (WARN_ON(num_sw_msi && num_hw_msi) || WARN_ON(num_sw_msi > 1)) {
> +		rc = -EINVAL;
> +		goto out_reserved;
> +	}
> +
>  	rc = 0;
>  	goto out_free_resv;
>  

