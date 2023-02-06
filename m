Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C483C30
	for <iommu@lists.linux.dev>; Mon,  6 Feb 2023 12:13:10 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id u10so5454345wmj.3
        for <iommu@lists.linux.dev>; Mon, 06 Feb 2023 04:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1IvvUpDIzzYw9+SRNx7DbUaJMMIkgO4bGezDC/TRRk=;
        b=b9OkVp+ugc2CmhJ15afKzlOpT+3SRO44IWMEshIv0enrSHBX0zZM02taZhrrTXBGD0
         C1WNzpxCvqbJ3meK0TWN/TM8jVlXSEppAnVjaOdVUh416Gxb+VBZAotdedGmMl0azU8e
         eJIJmOD+cITKYv0FIDRebS6EkjlSaeuK5xERVgL+DFPU6Qx0nR35Il/f5GZHRTm+nmcl
         jMy/xdavGAJ5rkH2d12gXatxrkYw/oYJyxi0RCrOS7dQ0qeO0xOV+h1QECREqbkpgWM7
         yoVM2P/6cfgVrXOK7RzASli2s5+RZs76TtGne3z96on2dhbN2ydXomwz6fU1668+OZEP
         8Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1IvvUpDIzzYw9+SRNx7DbUaJMMIkgO4bGezDC/TRRk=;
        b=hAQ/zfC/LKZ1m5WvHlyYgdVms1+7ymcM2ozRfxLNEszBzLRPjD8WM7cSiDO8QPvDRp
         WhUqhCp4wiYF4WeCVC9xnSWDXPWBk4PfRNYSQ7qSUMJzKeyLW0XGKyjKBt3L7cYuL5IV
         4viJIlG2WGTtJXmJM5i9b49NdsXPfMw38RCZZYB3fJsr+c2YxOyJpYJvnlo8MZ8qzh/2
         I8Li/+0XHxsEP/sY9FOfEsmmwN1bCCgOiofdrb99SXVHU+U73CtdLNcqLxWeKolIBz72
         yNe6DOf4w8TE/q58eQSXtBQbrmnozfK91eTioKEYGvpwXrBX6Nor030fi+SpgICAx7ZX
         Xi2A==
X-Gm-Message-State: AO0yUKUYpJ2RQ2cvA+l3S6yUWYwOQeai+Z2CZXEawbYEFR/slMss7Ute
	ip8JTgP5LypVC4N1S1Ivz41tuw==
X-Google-Smtp-Source: AK7set/X5OiGOGu17xeNlsq0wM6jY6K95NiKkD8/6IxChYVhakslSCvpz9hv/BN5iLVW9r32RGXpYg==
X-Received: by 2002:a05:600c:3849:b0:3d5:365b:773e with SMTP id s9-20020a05600c384900b003d5365b773emr20472104wmr.39.1675685589158;
        Mon, 06 Feb 2023 04:13:09 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003dc41a9836esm10542456wmp.43.2023.02.06.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:13:08 -0800 (PST)
Date: Mon, 6 Feb 2023 12:13:05 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "tina.zhang" <tina.zhang@intel.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, smostafa@google.com, dbrazdil@google.com,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 15/45] KVM: arm64: pkvm: Add
 __pkvm_host_share/unshare_dma()
Message-ID: <Y+Du0fZetGVdPVW2@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-16-jean-philippe@linaro.org>
 <dec54922-37cf-89df-477e-eed1e9461db3@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec54922-37cf-89df-477e-eed1e9461db3@intel.com>

Hi Tina,

On Sat, Feb 04, 2023 at 08:51:38PM +0800, tina.zhang wrote:
> > +int __pkvm_host_share_dma(phys_addr_t phys_addr, size_t size, bool is_ram)
> > +{
> > +	int i;
> > +	int ret;
> > +	size_t nr_pages = size >> PAGE_SHIFT;
> > +
> > +	if (WARN_ON(!PAGE_ALIGNED(phys_addr | size)))
> > +		return -EINVAL;
> > +
> > +	host_lock_component();
> > +	hyp_lock_component();
> > +
> > +	for (i = 0; i < nr_pages; i++) {
> > +		ret = __pkvm_host_share_dma_page(phys_addr + i * PAGE_SIZE,
> > +						 is_ram);
> Hi Jean,
> 
> I'm not familiar with ARM arch. Just out of curiosity. If pKVM-ARM populates
> the host stage-2 page table lazily, would there be a case that device driver
> in host triggers DMA with pages which have not been mapped to the host
> stage-2 page table yet? How do we handle this situation?

It's possible that the host asks the hypervisor to map on the IOMMU side
a page that is not yet mapped on the CPU side. In general before calling
map_pages() the host zero-initializes the page, triggering a page fault
which creates the mapping, so this case is rare. But if it happens,
__pkvm_host_share_dma() will create the CPU stage-2 mapping:

 __pkvm_host_share_dma()
  do_share()
   host_initiate_share()
    host_stage2_idmap_locked()

which creates a valid identity mapping, along with the ownership
information PVKM_PAGE_SHARED_OWNED. That ownership info is really all we
need here, to prevent future donations to guests or hyp. Since the SMMU
side uses separate stage-2 page tables, we don't actually need to create a
valid mapping on the CPU side yet, that's just how pKVM's mem_protect
currently works. But I don't think it hurts to create the mapping right
away instead of waiting for the CPU page fault, because the host will
likely access the page soon to read what the device wrote there.

Thanks,
Jean
