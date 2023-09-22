Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5414F81
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 07:57:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1750097f8f.0
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695369434; x=1695974234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnFqnWCwcyqa0uxptZjUfiZurm7gKfTYACFMprkcSZc=;
        b=JF31mgvJQf6I7KxZwtJY5wfl77Mn4anN81jEbhtrkq2wRBBFgeKkLc83y7a+nnsdRQ
         R9nsqdvGX1h4mNPNN+NcM0/t6yKWNI6IKUeESZ0Fk6/z5nLxgub4iyyFh6VnRpvNf+Tq
         7bQlzMHDBUGDuvXLehuXqEj2J7i4mAG5u8ob8F9RUeJ8X0WET90KOs3KFEXi16wGG6ue
         ivxiygEUfWVmHwhw89YkwyTB2bSw2A7AvB9WV76ITmurqP3jyozU4/S4oQwLTReITJdU
         +poLD2iXslb0iQxD6mn/lEM/DfsPU7fWQHhQP5x8EAlJfoRSb3l+u3ypZsRMiGBmaYa6
         bKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369434; x=1695974234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnFqnWCwcyqa0uxptZjUfiZurm7gKfTYACFMprkcSZc=;
        b=I9HbkIHppvlKIHK5WgvpZ41ZLdWgr1jICM70FRKIvyGZa0YCQ+y2MqwgYW8Clwj9DA
         z55lNrxfRlPdNliNuSmIKn6w49mf3Kd+Adc/QeHx32Pqp7KepjukYxNN39BRxeS+27Ta
         cguB1+pUmMWX4YQQHC6iECNt9bl2RLG/jHTQmvi09ocwCkaBGIJ6fwz7qhWecRg1glNp
         weRrbWHG08TSg3Pibk/7fGMpyqS9vo8cfjMEJaw1h03o7N0hkZI5NOSrTVhozOW7w6f6
         UtffDLZgUYNE2ExC2qcWWoxDMjp3aNjf1dyXUfhfVac9oufveu4itdOD4IktORnvQtWB
         SbWg==
X-Gm-Message-State: AOJu0YxOhxa2hG+YhNG4VeZ/X1240r8jh48PWQ+ebI83CETWd7fziqbq
	aKvmqA7q5MRRdr7VxHsKu++kJA==
X-Google-Smtp-Source: AGHT+IHWcZglriBzW9X2jK5nxXTgqPGq0Rp8QA7W/Rk3EcPZ5Jyf8nkyUbyRRLcvr0oqOvJfnIoUVw==
X-Received: by 2002:adf:f008:0:b0:31f:fab1:c3c3 with SMTP id j8-20020adff008000000b0031ffab1c3c3mr7029007wro.35.1695369433661;
        Fri, 22 Sep 2023 00:57:13 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b0031f5f0d0be0sm3746610wrr.31.2023.09.22.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:57:13 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:57:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922075719.GB1361815@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919144649.GT13795@ziepe.ca>

On Tue, Sep 19, 2023 at 11:46:49AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 19, 2023 at 09:15:19AM +0100, Jean-Philippe Brucker wrote:
> > On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index 17dcd826f5c2..3649586f0e5c 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > > >   	int ret;
> > > >   	unsigned long flags;
> > > > +	/*
> > > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > > +	 */
> > > > +	if (!viommu)
> > > > +		return 0;
> > > 
> > > Minor nit: I'd be inclined to make that check explicitly in the places where
> > > it definitely is expected, rather than allowing *any* sync to silently do
> > > nothing if called incorrectly. Plus then they could use
> > > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > > with a NULL viommu without viommu_map_pages() blowing up first...)
> 
> This makes more sense to me
> 
> Ultimately this driver should reach a point where every iommu_domain
> always has a non-null domain->viommu because it will be set during
> alloc.
> 
> But it can still have nr_endpoints == 0, doesn't it make sense to
> avoid sync in this case?
> 
> (btw this driver is missing locking around vdomain->nr_endpoints)

Yes, that's on my list

> 
> > They're not strictly equivalent: this check works around a temporary issue
> > with the IOMMU core, which calls map/unmap before the domain is
> > finalized.
> 
> Where? The above points to iommu_create_device_direct_mappings() but
> it doesn't because the pgsize_bitmap == 0:

__iommu_domain_alloc() sets pgsize_bitmap in this case:

        /*
         * If not already set, assume all sizes by default; the driver
         * may override this later
         */
        if (!domain->pgsize_bitmap)
                domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;

Thanks,
Jean
