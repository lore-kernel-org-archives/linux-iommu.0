Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF73B7A0
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 14:48:10 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-65643a83758so19132486d6.0
        for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695134890; x=1695739690; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EquMz/cfki7kEYJ0MaznRKfaKZ1PqbzvZHpIvKnZUnM=;
        b=G1FATabgr7BgHY6f0NnVYIPt/st/GvCDMsID4uUPq3KfZVnz/qsu4gd/qsIzK6hgTu
         0/nDdEOI0pr05Kh085ur3rnjmvVKnasOKR/oTnoZ/BxgpWz4v6WcJa84MKA/ayAi/qr/
         WmeIVCdqKaqA6AcsnddPaGEebrwWTiNgSLfh6JkeT5ZeTKblcE4fDoO2pS5Gw+WCRybi
         lv0MmXGQLAsM/RV2OOjldNYqWVvVTRuo8nsIFZiaqx1cVweWCtoQkE8Wj/TJIGAGcpCl
         GeC5Mkn2PrKyQx/pk71zRHxJ+iKDVTp83k4Sfbz7sm6R9IwC4rsY7hEkkBiRWrbbXS2W
         dFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134890; x=1695739690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EquMz/cfki7kEYJ0MaznRKfaKZ1PqbzvZHpIvKnZUnM=;
        b=CoJLIH6QSRZ09igD5F5Zf6aDLFAangmPTPMxsU//hHmtA16UwD7bfhFOW/7g4otc1o
         uDiSN8HbXahBnwyiukEap9PjiYGsOm54oayPiDGE24Pjweux2jjahW3qY5dMKeZEDWsR
         q302EtbJ9M88H451vsk8I/qwWPtA4Gwd9Cl+6aXPbvm8BGfz2esEkwm+DJLet4M1y7h0
         SB2ef03J6J7k4WYn/sEPRB+xVelsQzLc6cxtej1UgZePtnuLbgOwKWZoLz3IO08ewYn+
         bfsWkOI6mwGRnXtLORGZwl/kXYrezMpXPTl2OE8ERDTCygfddGPDTVeW78CMa9TmOPUX
         2+qA==
X-Gm-Message-State: AOJu0YymvWzS03X1Lb5YFdcQo1+EqpZk1FHbUi/N0mUbzvw7cJsdQZFh
	JOHRZSdZnu1XV9/FrV0EFeKtkA==
X-Google-Smtp-Source: AGHT+IFhbKsrLcKnFuicZOuiJBoQGo+a4wPHjLFimyP3XIPppsptAboML0WRwQZ8AGOCizTCF1f9dQ==
X-Received: by 2002:a05:6214:1192:b0:64f:60e9:9285 with SMTP id t18-20020a056214119200b0064f60e99285mr12393879qvv.30.1695134889866;
        Tue, 19 Sep 2023 07:48:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0064f72988fecsm4437544qvd.127.2023.09.19.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:47:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qic01-000ExN-0m;
	Tue, 19 Sep 2023 11:46:49 -0300
Date: Tue, 19 Sep 2023 11:46:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230919144649.GT13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919081519.GA3860249@myrica>

On Tue, Sep 19, 2023 at 09:15:19AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > index 17dcd826f5c2..3649586f0e5c 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > >   	int ret;
> > >   	unsigned long flags;
> > > +	/*
> > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > +	 */
> > > +	if (!viommu)
> > > +		return 0;
> > 
> > Minor nit: I'd be inclined to make that check explicitly in the places where
> > it definitely is expected, rather than allowing *any* sync to silently do
> > nothing if called incorrectly. Plus then they could use
> > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > with a NULL viommu without viommu_map_pages() blowing up first...)

This makes more sense to me

Ultimately this driver should reach a point where every iommu_domain
always has a non-null domain->viommu because it will be set during
alloc.

But it can still have nr_endpoints == 0, doesn't it make sense to
avoid sync in this case?

(btw this driver is missing locking around vdomain->nr_endpoints)

> They're not strictly equivalent: this check works around a temporary issue
> with the IOMMU core, which calls map/unmap before the domain is
> finalized.

Where? The above points to iommu_create_device_direct_mappings() but
it doesn't because the pgsize_bitmap == 0:

static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
					       struct device *dev)
{
	struct iommu_resv_region *entry;
	struct list_head mappings;
	unsigned long pg_size;
	int ret = 0;

	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
	INIT_LIST_HEAD(&mappings);

	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))

Indeed, the driver should be failing all map's until the domain is
finalized because it has no way to check the IOVA matches the eventual
aperture.

Jason
