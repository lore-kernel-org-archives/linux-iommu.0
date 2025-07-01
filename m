Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDE1DACA7
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398150; cv=none; b=by2AxRCyAY4jDf3V5kvRLv6t6TcC7miVF2UsNNiztNlfdlNILxjFEab9aevIlcNrgANJ2Ui3Der5JK6euBRFH/SHA0P6KhdmMgzQkxZ7rWuisdxXDKZBqWSUE99nbtN+qNmltLpVWv/xKJMRgQeYRv0A+XFxOJpscEKiQLwZQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398150; c=relaxed/simple;
	bh=qi5MFGChAXKFUZDjtd1nmNXpvDA6MtQYTfDI2UZXy1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VY5tI9CsVvdvpwZzKyntazKWplzBLCsUbZSpIIH2fiG6MpzeZ3nzdVAcwmvK7Mddwn5Pa1sn/Ol1r6an1KS2KcKLvychf3FxLEuGrXkvZg+X+IQr31jx1AqijUdYzdHdRlbh3CzBpMGfPaagyiajfA5MgaUPhstd2e3pQcAR9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FI0poBBL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FI0poBBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gDtWunL173OL9YHHTWlvkL7hyhpmJ6KyKj/K99C8D4=;
	b=FI0poBBLD3EbrOUaez7Eptc4dGQKPTw8kG654pUZuyGLg0lqsokJQHlE/A9JBgLtit+sp0
	93wH2ZL9w6h1WDlz0WYGzhy5TMXVCcAheiRYr8vnZntsMDrggzjZuWPmV+71Dm5P6kxLtT
	M3P/YeFkjDfiTo9oXssG9VXyBOgMMCE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-MCTf85O0OTGmp6EVYUw7Jw-1; Tue, 01 Jul 2025 15:29:05 -0400
X-MC-Unique: MCTf85O0OTGmp6EVYUw7Jw-1
X-Mimecast-MFC-AGG-ID: MCTf85O0OTGmp6EVYUw7Jw_1751398145
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2e91f81c036so1787011fac.0
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 12:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398145; x=1752002945;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gDtWunL173OL9YHHTWlvkL7hyhpmJ6KyKj/K99C8D4=;
        b=PwzNI8bFM6dQMAh76sHhSfbEZXo9TXU+e1rGW4WTPIdIwCiojDp7CkpR5q2n6ALvS0
         Ew+FDDOpIiXTweA2OnTPHKC9pYSg77tcchbxKT2IW96Wnwi3Ok7UKNd5WQ6kjALDgCD8
         5zeMbZw14rSUn9qrmchiVIxcQNr1g774mHjVj2rAybtLkk+FdnFR3wa6/M86XVuM5OIa
         lYzBxRKxGM8dGpY/kNnhGTBMS1tBZnNbDRGJZeK0+H7LI9CnrN6Q9ZX8FVNe5wM9svGW
         Y8etKFBWapyvpEXl/2+dJ/9bU1lLsCMujm8DWxQpB+LMQwpvfRItxIIjdSD18FkBR8H/
         J80A==
X-Forwarded-Encrypted: i=1; AJvYcCUVZTMucrBuxXXDKnC7+k5oz0AT3J6Gvw0KoxXfTvPc2CHtABb4lAddTQJA8iYTdQXURMuV+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6xC8UEPMbd2e8f4oveTHRbPKfZOCVcCK9fmG1j6PnKi1sCFoJ
	ZSEoZMnQCDTbde/sj3FEA8BYDuZSjCcH+W16Te0mfYtsqxY/A4g7BdbtkR2QHQirG3S2jwSsNJi
	M2IY+yFs/7bTWnYjojT4FTpPZoNHqaRDxah/tzDBvs8wkIhLI8MO5jA3r
X-Gm-Gg: ASbGncubBCxHdxRE4q6DsXYEexgMGBdeEN42Tu9ASCGZpOP3R6WLbuokvYQwaHFtT4v
	IiOb6WZG0KZMjN8aiLsnugo5IyFt9qdXqzt84om2NvfQjjzOkqwrXFF47omFkGyY2NDptRNk06z
	CCqh/MdJ9S8DURl4tcliFLCfN4Va3kvz//Z9XSUXNOVJhMDehqQohUi/EESQz5XIVXCpYpjJKnc
	nJ3QwEIPRwxW2+wxxOR5Gf56gMfcbkjLCSMRf1JlBTC9RqvBP80J4jWvZqcCH4iyZGI/IMUpvZn
	xgNef0Mx+gb4c4kzxY76KAfisQ==
X-Received: by 2002:a05:6871:3a14:b0:2d6:1e7:f583 with SMTP id 586e51a60fabf-2f5a8c8e573mr2993fac.3.1751398144978;
        Tue, 01 Jul 2025 12:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzxKBtIcEO/jlL/s7uq955z0t1nlv/4m/A44xpr3gujAXNCGCC9EjB5EeKqcMmTn3VuTuxcA==
X-Received: by 2002:a05:6871:3a14:b0:2d6:1e7:f583 with SMTP id 586e51a60fabf-2f5a8c8e573mr2981fac.3.1751398144405;
        Tue, 01 Jul 2025 12:29:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ef71e3sm3405314fac.19.2025.07.01.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:29:03 -0700 (PDT)
Date: Tue, 1 Jul 2025 13:28:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH 02/11] PCI: Add pci_bus_isolation()
Message-ID: <20250701132859.2a6661a7.alex.williamson@redhat.com>
In-Reply-To: <2-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<2-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NUDhmY3yWHlBdawLnVMsBrJSdNIj4VOpBZp7lb0yccw_1751398145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 19:28:32 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 53840634fbfc2b..540a503b499e3f 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -113,6 +113,156 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	return ret;
>  }
>  
> +static enum pci_bus_isolation pcie_switch_isolated(struct pci_bus *bus)
> +{
> +	struct pci_dev *pdev;
> +
> +	/*
> +	 * Within a PCIe switch we have an interior bus that has the Upstream
> +	 * port as the bridge and a set of Downstream port bridging to the
> +	 * egress ports.
> +	 *
> +	 * Each DSP has an ACS setting which controls where its traffic is
> +	 * permitted to go. Any DSP with a permissive ACS setting can send
> +	 * traffic flowing upstream back downstream through another DSP.
> +	 *
> +	 * Thus any non-permissive DSP spoils the whole bus.
> +	 */
> +	guard(rwsem_read)(&pci_bus_sem);
> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> +		/* Don't understand what this is, be conservative */
> +		if (!pci_is_pcie(pdev) ||
> +		    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
> +		    pdev->dma_alias_mask)
> +			return PCIE_NON_ISOLATED;
> +
> +		if (!pci_acs_enabled(pdev, PCI_ACS_ISOLATED))
> +			return PCIE_SWITCH_DSP_NON_ISOLATED;
> +	}
> +	return PCIE_ISOLATED;
> +}
> +
> +static bool pci_has_mmio(struct pci_dev *pdev)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> +		struct resource *res = pci_resource_n(pdev, i);
> +
> +		if (resource_size(res) && resource_type(res) == IORESOURCE_MEM)
> +			return true;
> +	}
> +	return false;
> +}

Maybe the intent is to make this as generic as possible, but it seems
to only be used for bridge devices, so technically it could get
away with testing only the first two resources, right?

> +
> +/**
> + * pci_bus_isolated - Determine how isolated connected devices are
> + * @bus: The bus to check
> + *
> + * Isolation is the ability of devices to talk to each other. Full isolation
> + * means that a device can only communicate with the IOMMU and can not do peer
> + * to peer within the fabric.
> + *
> + * We consider isolation on a bus by bus basis. If the bus will permit a
> + * transaction originated downstream to complete on anything other than the
> + * IOMMU then the bus is not isolated.
> + *
> + * Non-isolation includes all the downstream devices on this bus, and it may
> + * include the upstream bridge or port that is creating this bus.
> + *
> + * The various cases are returned in an enum.
> + *
> + * Broadly speaking this function evaluates the ACS settings in a PCI switch to
> + * determine if a PCI switch is configured to have full isolation.
> + *
> + * Old PCI/PCI-X busses cannot have isolation due to their physical properties,
> + * but they do have some aliasing properties that effect group creation.
> + *
> + * pci_bus_isolated() does not consider loopback internal to devices, like
> + * multi-function devices performing a self-loopback. The caller must check
> + * this separately. It does not considering alasing within the bus.
> + *
> + * It does not currently support the ACS P2P Egress Control Vector, Linux does
> + * not yet have any way to enable this feature. EC will create subsets of the
> + * bus that are isolated from other subsets.
> + */
> +enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus)
> +{
> +	struct pci_dev *bridge = bus->self;
> +	int type;
> +
> +	/* Consider virtual busses isolated */
> +	if (!bridge)
> +		return PCIE_ISOLATED;
> +	if (pci_is_root_bus(bus))
> +		return PCIE_ISOLATED;

How do we know the root bus isn't conventional?  I suppose this is only
called by IOMMU code, but QEMU can make some pretty weird
configurations.  Thanks,

Alex

