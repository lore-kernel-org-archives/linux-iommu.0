Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302A20D51F
	for <iommu@lists.linux.dev>; Tue,  1 Apr 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523904; cv=none; b=MTjFsEf41r7XVLz32cx8TQumDi7nXsHtvR3543ghMtrGUENel1NgOmMjBTHSKWK1cBTza+QFffCj2DQzjtVbjtrhvsfELfaHWde8jpTRaI5LaejgrC56BBqDqwKUhVjR9NgveHhQguiQn72Clx+uHIkp1m3bslkzK0YpUuuKvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523904; c=relaxed/simple;
	bh=0bfnfRwxd83qT6YHXSQ35/Sc5Ii17MOf/lTvNc4Gkxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB6a8/YcwArcAfJtSsDQr557kVD8qEogHvQKgnqWcY0f0rQ0wnY5UiRSGqTwd49mWs9QSOu0x0pWdHSTttzXOxGDE5TO4vQkjVoi9V/T0qD3zlZAp0wLnAicep0+7wC6/vs1B6Z7VOUWKcyrZ/3wAuXZ7N4JzBGY/veCrxc2FjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EdXrH1R2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EdXrH1R2"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476ac73c76fso62271541cf.0
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743523900; x=1744128700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ht+/cjgqGqzgXcB/qQp4vlm60uUPBRIV+JZ12u7d0fU=;
        b=EdXrH1R2DqFTeDyh/WU28Yf068oet7IrNL21sL7zztQSoaW/ETUkH5cjgujPBwVqW6
         s7Jn+Rk5aMEHc2q8xdMJyGTCuJFLgRW9DnbULNZAcWrH8K1SGHReD9gV0QtCxevor3f0
         rpxaC5SphWFQHwrm9B9PjmofiPo5T47AqfvK08r2sijkwaMGVBqrYmppNVirrWBZHB/s
         5GNm3V8spnWP+cQ1+gbmXfdmKYCALmvsPMUxIvvuIF0/KDBHa5ovbEhxd0mufNA/wqgl
         +pNKu7u11VyRC2Vr4tlRUOvYLriBb01wyrlX3ZIL01NnNo3FOpUHvStxI+iP4a3Tg2h0
         Ww5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523900; x=1744128700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht+/cjgqGqzgXcB/qQp4vlm60uUPBRIV+JZ12u7d0fU=;
        b=jmjdwR9LPLZoHwBlDYQTB9OpTWbmaIqmhDEW9uyXHz00H6VHc9p4KfuGEooWcs1T00
         ZIGPCDbBVFRpUO0dF83PFXnOUFTegUfVyUHuTUSGLi/Gz4WeJLnWjl8BGFTd8ukxqk/T
         Y1AmyGD8K4J4qKymPCsGhxyUuJa7aeFFf+1q80sW92cIp6LD/ECAwPrPSE+Mfh+5axaR
         vAgHGQx1V5+dnvWoWp2TU02mTkR5aaPoh9bFe8cXNzXAkogccIjtraVR7lLebL622TT3
         wriiVZUwLF33lwZNEh05leL3QRLpt/PyROV1H3xRTsuQt6/gTX4rgdHNlh4vQKLquorX
         NAYw==
X-Forwarded-Encrypted: i=1; AJvYcCXXHk7ZYaa7xCki65UV1ijzVDnftyMCdZeCtTHo9w3weWPIMgYY03qFrYjufEWCT/xNRf0Rpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjYA0ry4xyTQlA12LjIEU+WJgD7gzk/5RsIEeVIDSmNcrtiDP/
	dzFNGB551X2RoepjG3DpCm0HcW3M9OKYjhKlvCVRrWaOk45nEK0x+9HgTR1Dyj0=
X-Gm-Gg: ASbGnctYZzusRo4TjHZKoAq6G8Uezt5ODTMmi+1L+yGutiQ/0WkNuxKkjI7jfU5zye1
	2wq81SGW6h/2XnvuxMYjfus6qRpfrdWfzAQ2hIwsiXrSA8hx/KTIF86qe8smbhUHNgj6v4WD55W
	90skE9w9bQ8ImaxeVFTZD7dhSFF+lVzAxKSJ34soEoudEudfrVfLv6pmoK6CWim3+JyQSXZbb1l
	ZQBZ3kiCiwElh64egyg0n5ufsGeoM5ARjVD4Rj/ocT7r7WFnkDQY0LSEVyhXP+lpdXZ8vxEZoLB
	Lxn3Bg0VyqqcVoS9t7JAp74Jd83MPlf06AVzOBl2CbUybOdsqs/iWwa0XMBuAGXuWnRiAFiCLVV
	XORsGo7QTGCzCwyVvyzWXE9k=
X-Google-Smtp-Source: AGHT+IGqQTmKBPGxEDnar5cvqd0kVzoGqHi3v/f2hQrPfOnvCsqaEdb1Xw9stjow0mGeS+auqOd8Yw==
X-Received: by 2002:a05:622a:13d4:b0:476:ae71:eabe with SMTP id d75a77b69052e-477ed779bf5mr236227621cf.50.1743523900002;
        Tue, 01 Apr 2025 09:11:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47790ef0976sm57062041cf.59.2025.04.01.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:11:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzeDC-00000001ML9-3rkm;
	Tue, 01 Apr 2025 13:11:38 -0300
Date: Tue, 1 Apr 2025 13:11:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Message-ID: <20250401161138.GL186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-14-aik@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-14-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:00PM +1100, Alexey Kardashevskiy wrote:
> @@ -939,6 +939,7 @@ struct iommu_fault_alloc {
>  enum iommu_viommu_type {
>  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> +	IOMMU_VIOMMU_TYPE_TSM = 2,

This should probably be some kind of AMD_TSM and the driver data blob
should carry any additional data needed to create the vIOMMU that is
visible to the guest.

> @@ -2068,7 +2069,18 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  		new.data[1] |= DTE_FLAG_IOTLB;
>  
>  	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
> -	new.data[1] |= domid;
> +
> +	if (domain->aviommu) {

AMD should be implementing viommu natively without CC as well, try to
structure things so it fits together better. This should only trigger
for the CC viommu type..

> +		/*
> +		 * This runs when VFIO is bound to a device but TDI is not yet.
> +		 * Ideally TSM should change DTE only when TDI is bound.
> +		 */
> +		dev_info(dev_data->dev, "Skip DomainID=%x and set bit96\n", domid);
> +		new.data[1] |= 1ULL << (96 - 64);
> +	} else {
> +		dev_info(dev_data->dev, "Not skip DomainID=%x and not set bit96\n", domid);
> +		new.data[1] |= domid;
> +	}
>  
>  	/*
>  	 * Restore cached persistent DTE bits, which can be set by information
> @@ -2549,12 +2561,15 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  {
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>  	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +						IOMMU_HWPT_ALLOC_PASID |
> +						IOMMU_HWPT_ALLOC_NEST_PARENT;
> +	const u32 supported_flags2 = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>  						IOMMU_HWPT_ALLOC_PASID;

Just ignore NEST_PARENT? That seems wrong, it should force a V1 page
table??

> +static struct iommufd_viommu *amd_viommu_alloc(struct device *dev,
> +					       struct iommu_domain *parent,
> +					       struct iommufd_ctx *ictx,
> +					       unsigned int viommu_type)
> +{
> +	struct amd_viommu *aviommu;
> +	struct protection_domain *domain = to_pdomain(parent);
> +
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_TSM)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	aviommu = iommufd_viommu_alloc(ictx, struct amd_viommu, core, &amd_viommu_ops);
> +	if (IS_ERR(aviommu))
> +		return ERR_CAST(aviommu);
> +
> +	aviommu->domain = domain;

This is not OK, the parent domain of the viommu can be used with
multiple viommu objects, it can't just have a naked back reference
like this.

You can get 1:1 domain objects linked to the viommu by creating the
'S1' type domains, maybe that is what you want here. A special domain
type that is TSM that has a special DTE.

Though I'd really rather see the domain attach logic and DTE formation
in the AMD driver be fixed up before we made it more complex :\

It would be nice to see normal nesting and viommu support first too :\

Jason
