Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F5111B0
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:43:52 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-40fda409ca7so38723511cf.3
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692110632; x=1692715432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+aZswFcQ74ATlRIL8WZw8IPJbkgBJh90TZMmZn1V0k=;
        b=gd/DtUzDbSByK9ZcKwzdBd/NKcq5BEMkPf14bU5Wq1m02198cYn/bPpQuN38lFXWZ2
         /i19pTcskvO5WTJsqYEgPN5smYiCYtZ1aoHy4wzfGHy1YvgZFDl04rtkcvy8w2368KAs
         x5OY8BKofbuOPkgF/VziMJjMd/Ds1cvIkEkdySemqh1rmIyVjBAC9TFgo++eUc1+5l0y
         1d4Twm3LO4YQuRMmd5LowJmYyyj1SXDAFcgh+YflLb9/VFQURDQKuEuvTlZx7Lx/SmlD
         y6pdrIHh6dUf2HTIuu/0eX7+lSA4rKuyMItWeqP5qV5gZtxehkfNFCTHhnJ/RD8hDXbj
         3kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110632; x=1692715432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+aZswFcQ74ATlRIL8WZw8IPJbkgBJh90TZMmZn1V0k=;
        b=UYIu+rbByZql4HMyLH0cwmBAogO5fYKD8pYOWc4YbsVL9d0J6Ga6dKCR12UbDj8I7D
         5yFr3nlA5vZHLNh7X8YwMK6pC3kMiFdyB600vYPkzjQVCGYQXT2VmSZLCSp4JxR7yU4z
         6IznCkz1qsGtUMi8T90nuK3cOBkNTxB87Iar/0NZsF8S5YWP0H8z1Jnh6edjpDe/f3pz
         LROzBNvi5kMEfmY+WIqJAvnan+3huOnxYiiRhy6Xts2rvj2DeIzLnsbQ6pkD7hE5Msao
         AGu2D9xOKeJ4uDjI1A6hFFGXp/hrA1Q41O5bb14huRUQR1/4efOlqmXtXrhWLfWDrmSN
         ETKQ==
X-Gm-Message-State: AOJu0YxNyIoMssfxBh+Gu9DxR7dPI6xw8QOaIP+VIxFPEnMLLoRrSjo9
	Ho5suW+22Qgmvp/0eLdoFaBCAg==
X-Google-Smtp-Source: AGHT+IEmlVAjxYFEbAGrDB5FdfiIyfWqVYXHc08Jx+21RQmAg1KZnSuJSFmsJh6ZCkiChd+2Z3ndAA==
X-Received: by 2002:a05:622a:252:b0:403:df34:9461 with SMTP id c18-20020a05622a025200b00403df349461mr16808106qtx.14.1692110631952;
        Tue, 15 Aug 2023 07:43:51 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84753000000b0041020e8e261sm3851174qtp.1.2023.08.15.07.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:43:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVvGw-007bxC-7P;
	Tue, 15 Aug 2023 11:43:50 -0300
Date: Tue, 15 Aug 2023 11:43:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	Alex Deucher <alexander.deucher@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 1/4] iommu/amd: Remove iommu_v2 module
Message-ID: <ZNuPJmi9sdRPVVVL@ziepe.ca>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
 <20230815103255.565295-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815103255.565295-2-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:32:52AM +0000, Vasant Hegde wrote:

> -int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
> -{
> -	struct device_state *dev_state;
> -	struct iommu_group *group;
> -	unsigned long flags;
> -	int ret, tmp;
> -	u32 sbdf;
> -
> -	might_sleep();
> -
> -	/*
> -	 * When memory encryption is active the device is likely not in a
> -	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
> -	 */
> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -		return -ENODEV;
> -
> -	if (!amd_iommu_v2_supported())
> -		return -ENODEV;
> -
> -	if (pasids <= 0 || pasids > (PASID_MASK + 1))
> -		return -EINVAL;
> -
> -	sbdf = get_pci_sbdf_id(pdev);
> -
> -	dev_state = kzalloc(sizeof(*dev_state), GFP_KERNEL);
> -	if (dev_state == NULL)
> -		return -ENOMEM;
> -
> -	spin_lock_init(&dev_state->lock);
> -	init_waitqueue_head(&dev_state->wq);
> -	dev_state->pdev  = pdev;
> -	dev_state->sbdf = sbdf;
> -
> -	tmp = pasids;
> -	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
> -		dev_state->pasid_levels += 1;
> -
> -	atomic_set(&dev_state->count, 1);
> -	dev_state->max_pasids = pasids;
> -
> -	ret = -ENOMEM;
> -	dev_state->states = (void *)get_zeroed_page(GFP_KERNEL);
> -	if (dev_state->states == NULL)
> -		goto out_free_dev_state;
> -
> -	dev_state->domain = iommu_domain_alloc(&pci_bus_type);
> -	if (dev_state->domain == NULL)
> -		goto out_free_states;
> -
> -	/* See iommu_is_default_domain() */
> -	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
> -	amd_iommu_domain_direct_map(dev_state->domain);

Since this code has been removed please also add a revert for the core
bodge that was supporting it:

commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri Sep 9 16:46:31 2022 -0300

    iommu: Fix false ownership failure on AMD systems with PASID activated
    
    The AMD IOMMU driver cannot activate PASID mode on a RID without the RID's
    translation being set to IDENTITY. Further it requires changing the RID's
    page table layout from the normal v1 IOMMU_DOMAIN_IDENTITY layout to a
    different v2 layout.
    
    It does this by creating a new iommu_domain, configuring that domain for
    v2 identity operation and then attaching it to the group, from within the
    driver. This logic assumes the group is already set to the IDENTITY domain
    and is being used by the DMA API.
    
    However, since the ownership logic is based on the group's domain pointer
    equaling the default domain to detect DMA API ownership, this causes it to
    look like the group is not attached to the DMA API any more. This blocks
    attaching drivers to any other devices in the group.
    
    In a real system this manifests itself as the HD-audio devices on some AMD
    platforms losing their device drivers.
    
    Work around this unique behavior of the AMD driver by checking for
    equality of IDENTITY domains based on their type, not their pointer
    value. This allows the AMD driver to have two IDENTITY domains for
    internal purposes without breaking the check.
    
    Have the AMD driver properly declare that the special domain it created is
    actually an IDENTITY domain.

Jason
