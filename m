Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37428312E
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398155; cv=none; b=b9W1QGUucoZQjS8RapIK8bxt4awj9degwyEzdDRH1o+vacFB/BrzJBqNqg4pDOhMFZ7Y+dYLt+T3mrDSE+LWGhlAhjP9MOADe94QLZAw+qhAr3Lhncp/w0SKIdsl7wNHemd3847KycV2gc5jHhjYMiX3UOm4iRl08Kx/ccSOnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398155; c=relaxed/simple;
	bh=Der6lHkCC98no1Vn4NQll5rTYBWXTKnaq2KSJ3XTARI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rR/6hvWXpwL4MskX8XtKFFRH1YwUlpZeSuhfz3uRTuXkqsCnUdVWlR0exFJRIQvlsbSwn+nl6oOKYetdcuOWDT9zLZhzF20fs3SdUTgvUbP8MUO06tmlSEIAxxi0n+YvP5s6ndH+5GKD3EqCDAmboB4uHxdF5mgl3PJquzVy5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN/qjXx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN/qjXx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjTFqfwrz80T+KU/Vvx3G5r4It+9k632M4DI6S0TxZ8=;
	b=LN/qjXx7ejcFaIcbG0dsKU5WcOT+LAR5IhXrbBBY9uGp3sQoV87IwdxgKvmx2bt5dqp14B
	NP5/1QtbcepJ/o3/boMm9HtQDX2a4I3fT9lAdamTZqBoOi8o5OwxngiXSxqad80TFdBsfO
	IMMy4pjaLz+0UUl2xAB8W/o5a8DlK5Y=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-D1HWCpfsMoGN02hh_BShlg-1; Tue, 01 Jul 2025 15:29:10 -0400
X-MC-Unique: D1HWCpfsMoGN02hh_BShlg-1
X-Mimecast-MFC-AGG-ID: D1HWCpfsMoGN02hh_BShlg_1751398149
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-736ecb2a37aso122372a34.3
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 12:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398149; x=1752002949;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjTFqfwrz80T+KU/Vvx3G5r4It+9k632M4DI6S0TxZ8=;
        b=KdArs87gZeGX8RICmPPJ5/UJUr24h5JGOLm6QCnRMDEdJtyLolLudUfzXYhTRSodId
         HRXGdnW+JR0fpnEsmQqT9bJWmDI6dF16wrMoUbjKMlKYRa6QCfFKMZSBnnuFwXDbQJ/P
         nSDbHOef+6PcllD+hGI2G+/mYv4g7ehXWUKi1Q+qYQ7p+8KVDzXnZ6NTrImWGvYlmCLf
         KnhN7ujCh1YaYGeH5zVNuEBSuDu2qeW0wQMmdb6etGWBpfrdbOcmIbsaUTJfc27E8HlS
         FG1hON43U8HF+vMnc9Hb/TwBUnma2CiLKIx41Tnu8AjFb/MjRzJz9vWqLR5kWw+6n9r4
         DPFw==
X-Forwarded-Encrypted: i=1; AJvYcCVhOOkXDkEb3qDlC+dQqejB8FrjkfuAL+hw+4vHefL9Dzt1/5N8bavhZ4lqvzLNU0QWiwKqgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFPU1eJfmOlrF50PhNgkyIPpkRs03bTj6tFM9a4OVZ0VH0nnWs
	yMI2m1ogDJHFjLbnNR/W2qIXY4Q48sdbGrCpjOw7SVEJ0LRFbMz5jeElCNXc4g6m6IYC1OpaGqY
	fLvMpWI462EBUbnD5hHElDKpNU20NQkptWVTsfXZ/tsxhG4J0FjRFwLZX
X-Gm-Gg: ASbGncssvshpfNlnYGEASiITTv8JeNRwiBFGLDs99r5INUEMpbqVOw1Av52GW0+rr/a
	mQuC6YFglbFXbzTSDc0eI+vCBNKsm7u6x0woNdp49bXXpQhGOmqXjP15OTk0cE8PFCJiet1Y2RH
	DzlYqFLT+wvugpnEaAt59szdOSepkSlqmw1C+jb/0BhWMcIl7s4CuRbp9+4SWZeE7bATHOjLByu
	9zmSMt9+8d8QX2v2ymanAoprS559ysx5goRPNxhZlibADUS3XUbYARwpiCL7EbKUDGcuH3rBn71
	CR4rAt9jND1GQOw43y5qkgEVVg==
X-Received: by 2002:a05:6808:2217:b0:401:f524:a97d with SMTP id 5614622812f47-40b7b0a8707mr1196645b6e.4.1751398149417;
        Tue, 01 Jul 2025 12:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAidfeboIYE5QUTm/6yW8HPYX8OflJWQclvBEIzO4DlJkq5XCLurirKOmJEIcC02wo+DFNcg==
X-Received: by 2002:a05:6808:2217:b0:401:f524:a97d with SMTP id 5614622812f47-40b7b0a8707mr1196629b6e.4.1751398149030;
        Tue, 01 Jul 2025 12:29:09 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322c1e25sm2242252b6e.20.2025.07.01.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:29:07 -0700 (PDT)
Date: Tue, 1 Jul 2025 13:29:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250701132905.67d29191.alex.williamson@redhat.com>
In-Reply-To: <3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZ8KJsSxIEmJjWPtWiimSoIZnrnyn9Y-ikzjE24nq0U_1751398149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 19:28:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d265de874b14b6..f4584ffacbc03d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -65,8 +65,16 @@ struct iommu_group {
>  	struct list_head entry;
>  	unsigned int owner_cnt;
>  	void *owner;
> +
> +	/* Used by the device_group() callbacks */
> +	u32 bus_data;
>  };
>  
> +/*
> + * Everything downstream of this group should share it.
> + */
> +#define BUS_DATA_PCI_UNISOLATED BIT(0)

NON_ISOLATED for consistency w/ enum from the previous patch?

...
> +struct iommu_group *pci_device_group(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct iommu_group *group;
> +	struct pci_dev *real_pdev;
> +
> +	if (WARN_ON(!dev_is_pci(dev)))
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Arches can supply a completely different PCI device that actually
> +	 * does DMA.
> +	 */
> +	real_pdev = pci_real_dma_dev(pdev);
> +	if (real_pdev != pdev) {
> +		group = iommu_group_get(&real_pdev->dev);
> +		if (!group) {
> +			/*
> +			 * The real_pdev has not had an iommu probed to it. We
> +			 * can't create a new group here because there is no way
> +			 * for pci_device_group(real_pdev) to pick it up.
> +			 */
> +			dev_err(dev,
> +				"PCI device is probing out of order, real device of %s is not probed yet\n",
> +				pci_name(real_pdev));
> +			return ERR_PTR(-EPROBE_DEFER);
> +		}
> +		return group;
> +	}
> +
> +	if (pdev->dev_flags & PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT)
> +		return iommu_group_alloc();
> +
> +	/* Anything upstream of this enforcing non-isolated? */
> +	group = pci_hierarchy_group(pdev);
>  	if (group)
>  		return group;
>  
> -	/* No shared group found, allocate new */
> -	return iommu_group_alloc();
> +	switch (pci_bus_isolated(pdev->bus)) {
> +	case PCIE_ISOLATED:
> +		/* Check multi-function groups and same-bus devfn aliases */
> +		group = pci_get_alias_group(pdev);
> +		if (group)
> +			return group;
> +
> +		/* No shared group found, allocate new */
> +		return iommu_group_alloc();

I'm not following how we'd handle a multi-function root port w/o
consistent ACS isolation here.  How/where does the resulting group get
the UNISOLATED flag set?

I think that's necessary for the look-back in pci_hierarchy_group(),
right?  Thanks,

Alex

