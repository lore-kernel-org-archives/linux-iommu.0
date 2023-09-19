Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759538F8B
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 08:15:15 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-307d20548adso5190891f8f.0
        for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695111314; x=1695716114; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9DuA2m46Djcdz3icf/RXjOs6wp73S2oIUkhIKRMWaU=;
        b=hk4p9OX6klQCoTP6Ge9qMf3vZcoikJjbvnTzBCN4IWIXqEe5RSpu98Wc1yE0aL3K+f
         EPMnSmUNnXWHneFUw3fkzwh697tdqlxQv2/8TR8hB387dnBQLU//D9k1CNUIsFDlSRrF
         wxi/j7XFbSIKTjrh/btiUOioKN3XhkRJnKyTL4m+62o6y2S3Kzo1cD9TubR3Zs7z7Yva
         +kvn5bmcM1dYCp2fNSBAXWh7Ry09vNe1ClH/D7zEEEYDAWFogQKvzqZKKO/z5qs6QoLg
         nR0nxa1M1qQA1frVkGQ4N2+3jDv/djuSPs5E+ZIFgmblekT90asy6FlF9UcW1GSx9PBJ
         AOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111314; x=1695716114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9DuA2m46Djcdz3icf/RXjOs6wp73S2oIUkhIKRMWaU=;
        b=bApPg3JbuBxdz67d5vzZoVSuuUhXtKNXB1N1o8aHNwhTKo1wzhVMWXXDddIuqUGR2z
         wQC0FNiLermtM+wvDkMzifvH52B52m93VYQhH8YuN5zk/Br3c464v8LEjYLzouwzO+6O
         4XJThJn5VV8aaeb7z/b2Q0BiWHKnYONQHXehbQNq69aIDIxGC7NGH5u+MbFPKDxDt+0a
         qjC/Ox32h/dNgP6x3cPL8QK16thIAWYe2uSN0pk++hkipq1xYcf7kgM5mgue6r2I6TdP
         T323bNgaoCaUjKEvRmjl67GD6d1aCvA+jUUcWxdgC/g5mlSKRJV6QZGnS3HiEKI3lkqP
         9H5Q==
X-Gm-Message-State: AOJu0Yz6nrafsdbsDDPYM8CSG8PSiBlKwICKLJ+D4BfgZ1Rg/A8pzMhb
	gOHC9x0niSzp++wYppxusGmNtA==
X-Google-Smtp-Source: AGHT+IFGBTaGE4GEoHpdTwySnKUr0nW2LPy/soxU/asQgYmN8W5lJXq9nrjAyrswMLLRTbyUplW17Q==
X-Received: by 2002:a05:6000:1865:b0:31f:f8c1:f43c with SMTP id d5-20020a056000186500b0031ff8c1f43cmr11762566wri.41.1695111313622;
        Tue, 19 Sep 2023 01:15:13 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0031ffb51f6f9sm10302003wrq.30.2023.09.19.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:15:13 -0700 (PDT)
Date: Tue, 19 Sep 2023 09:15:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230919081519.GA3860249@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>

On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 17dcd826f5c2..3649586f0e5c 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> >   	int ret;
> >   	unsigned long flags;
> > +	/*
> > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > +	 */
> > +	if (!viommu)
> > +		return 0;
> 
> Minor nit: I'd be inclined to make that check explicitly in the places where
> it definitely is expected, rather than allowing *any* sync to silently do
> nothing if called incorrectly. Plus then they could use
> vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> (it did take me a moment to figure out how we could get to .iotlb_sync_map
> with a NULL viommu without viommu_map_pages() blowing up first...)

They're not strictly equivalent: this check works around a temporary issue
with the IOMMU core, which calls map/unmap before the domain is finalized.
Once we merge domain_alloc() and finalize(), then this check disappears,
but we still need to test nr_endpoints in map/unmap to handle detached
domains (and we still need to fix the synchronization of nr_endpoints
against attach/detach). That's why I preferred doing this on viommu and
keeping it in one place.

Thanks,
Jean
