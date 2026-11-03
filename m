Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734376;
	b=ShNHerBoHDe4m6aTqJt3tjk5pbh/cRZx6Af17Hw8wzCvStppKaC2kEgQ77YplGEkf5Gi
	 XX9wAIPCBBb+ndyF3bmxsZNZ+w3yId0wt2QvE7auB349ICjPCppIMCdE5anxmgdXXesED
	 GLY91n5sME9QciTu0mCUmxy1u4Bao4CnYuXGT7X832GwbE+YAxCKAQYfLFDH6WTKYHYru
	 YZkBjTpLyzB6OgPt+ztMwU/hfsdtpMT+XyHRqjogPER4AHhomW04Mf7MPYHwpVmNp8eon
	 UT2XSKM7My5xLlGfQvyPNfElcKUVgFu/gV2V1X85sWpWR5rDKLIS0UsaGl17jjMN4EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fS2oe2B5dSHImTbALo6NjH0E4DZsMbovYECl1gVRP0I=;
	b=BpPUwo4eIlhbK46b2lkBw4IHTeEilwMoPj9eHJk/Lak4v4whGiETRFl31lNugG/bawUW
	 9TFfs6eb3P+7WqOKw4N7loaTQJlZjTtUJ8e08Sy1YRAr/YJWYYssU6T0ln4nH3MV+Ea7a
	 clI1Cg4besjANNqEHE1Fzs0iH7jXlXXWB2aLTk10OgDrm375IMzXxOD9hqld6CpWm+1pf
	 btibVt7lmFGgi1H5nQYtZ5tL376FrLvfjDY11WbByhQddYisw5TPzgtXyT8i3onhUAbEk
	 tcR88VSzz/0ynORdUW07I8UqTaQAwOxUKCB0TwIyMKVZlreDdDvOm78IaHaxtpGEJ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fP3obffr;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA0606A33F
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 19:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAA0606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fP3obffr
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c763de878so218686d6.0
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793734374; x=1794339174; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fS2oe2B5dSHImTbALo6NjH0E4DZsMbovYECl1gVRP0I=;
        b=fP3obffrB8PPIK+EnjEmzJI0EQ2WPTaVdS2h5BmaO3meEE+BAQfpwP1mBuO4pr7oqv
         Y43DMYKtth/u5nvM8whNaDdxpPJ5TYcKkYqgN4c5C/yKC8Fg5xfiS3GRnglI7DdNM+xD
         o6ZbbJ824hO2b4OZi7ZR4fmC25cDzosCQ/iFIxlc7JwswrncNpfj642axyM9M91mMYoS
         Kds8y1nvJGegtg8wKJlS4kyxECCcv/0jXdYGd++U+SxHCG/30cBSfatG5KOEAR+SYEdY
         NbXxvz4XwDxJ25q2XDrpG6HDaMY+2UZuw1iuMGEq7a71/GCUocfR1fQ9KFsjOP33ozCh
         RoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734374; x=1794339174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fS2oe2B5dSHImTbALo6NjH0E4DZsMbovYECl1gVRP0I=;
        b=Rzs2WPIMoWZIUhQEn3/g0l/xlJkWuca+Soe//bUe9+9kzU4sAqmXmdSIeKDfPjeHRp
         UNAN3KQ3EOt809RZy48hDQjsuBL4kIrFPwjSzU2wr+w/c5YS8kZVw/nWA4AHCz1hwqyZ
         kliTrbMZnlrbXaBupJiPkR1G0FtIJITZQdPouVH0qwUxS4Qz/0QfQHUVknpB40POB0/g
         ebu+LtHiSV332w5e5UScfzHw4uTaDGWchZsLaw214QhvrSsuVKvbx9GAsY4TSaZq3fzA
         pIoJ6tOfmwt4HKaf7TVj+SNeVxm0wqjASgQUgq10ZIDb0ipKj6M0GD3fftRge2piKy38
         1ZFg==
X-Forwarded-Encrypted: i=1; AKwUvBynYxBhPX9jok2gzr1nYx/BnpmRPZbMG/I1y8Nu7Chl+qJLiirZlQo2D8jZ0FOZAqwwTdo3oQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/CeKfPR9zAt+gb4mayeZ0q9SZflh14UVqRkuSBpdXiOe8pyGbG
	en8+WyzQoLnVMJ0QgJ+PWKE3qqOSkypynER5DSMTdrVKohjD2Qsh4sk0RDF2mVRE50U=
X-Gm-Gg: AYBFou1YxuPW1RxwH0knt/q6KF2D9+w6lvZ5IJyO5DaZ9J75TOHCUliboFIA0wxcHMi
	8R2ztUYLUvcMQP6ccs9r8EB9RSTchO2s9v2ZinbkIG5i9fxjT9F4VuS/7LiLwRUADzDnNvuvyOQ
	nIMUYksByPPtC5eGh9WdvXcSeI6nSN5idQpTyPjiu12sp0W5dR+J4LthiK+DJ8P0wVFUVv+Jfch
	uKrDpWqB7uAzqtl4zNyZHMu+DP+N0rBo4TSTz+mjriBZF+XobhOuwAt30LcMYbBN+gka8W+hiIR
	rVVM1qunawgdVVvcH2z+kzYhMnFsCZpFOk/zO8jT2iDJocqrPDviypCymPr1rLKqG60c6AQzrLL
	7TP+eMA1eANI4qHTPHuKKQnuHARSPtAnGuCXOqtmpNN4xWdgLiWFODNuIqfWBo2XRg/hrQQyQJ4
	muOhiymKPH/bAVD+EJFj36V50Dy0l0/PTQUCrcue8O5TkAVFPff7LzQtuZB/bsMOUV4Jcj8rSD7
	Vby4OFQNUYHcUnK263uL1wmM7Fy+jW7wNTMKNJnjoGidBFWXqY7YAso5mfPvqc8hAzi6sxBxkgq
	blk7k4YFAeZ7q5mo83VPIzdGl8JNRzDPBcnkIVh2qdqRF3R5QpxDGOMhvOwUfgrGAKf/2t4JfpG
	NPKD6yng+LRu9aQfB8dRtmWIy7HUPOSw=
X-Received: by 2002:a05:6214:5906:b0:91c:79f4:1eac with SMTP id 6a1803df08f44-91ca4b74df6mr227056866d6.34.1793734374301;
        Tue, 03 Nov 2026 11:32:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c575600sm1135846d6.7.2026.11.03.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:32:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOKFZ-0000000DmXF-09NL;
	Tue, 03 Nov 2026 15:32:53 -0400
Date: Tue, 3 Nov 2026 15:32:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tal Zussman <tz2294@columbia.edu>, Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean-Philippe Brucker <jpb@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: free dev->iommu when iommu_fwspec_init()
 cannot allocate the fwspec
Message-ID: <20261103193253.GN3889730@ziepe.ca>
References: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
 <20261031-iommufd-folio-dirty-v1-1-2cef66d2d6d1@columbia.edu>
 <7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com>

On Mon, Nov 02, 2026 at 04:51:05PM +0000, Robin Murphy wrote:
> On 31/10/2026 8:33 pm, Tal Zussman wrote:
> > iommu_fwspec_init() allocates dev->iommu with dev_iommu_get() and then
> > the fwspec. If the fwspec allocation fails it returns -ENOMEM but leaves
> > dev->iommu allocated, and it leaks.
> > 
> > kmemleak reports it when iommufd_fail_nth injects the allocation
> > failure:
> > 
> >    unreferenced object 0xffff88811c138b00 (size 192):
> >      comm "iommufd_fail_nt", pid 783
> >      backtrace:
> >        __kmalloc_cache_noprof
> >        dev_iommu_get
> >        iommu_fwspec_init
> >        iommu_mock_device_add
> >        iommufd_test
> >        iommufd_fops_ioctl
> > 
> > Free dev->iommu on failure if this call allocated it. iommu_init_device()
> > allocates it before calling into the driver and frees it on its own
> > error path, so leave it alone in that case.
> > 
> > Fixes: 72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu")
> 
> No, the bug is clearly the early return in 2a918911ed3d ("iommufd: Register
> iommufd mock devices with fwspec"), so fix it there please.
> iommu_fwspec_init() has always been designed to be called in conjunction
> with iommu_probe_device() which handles cleanup appropriately.

Asking AI to audit this found the other case I remember...

Yes: ACPI DMA configuration during driver binding can leave dev->iommu
allocated after failure:

 really_probe()
  -> dev->bus->dma_configure()
    -> acpi_dma_configure_id()
      -> acpi_iommu_configure_id()
        -> IORT / RIMT / VIOT
          -> acpi_iommu_fwspec_init()
            -> iommu_fwspec_init()

 If dev_iommu_get() allocates successfully and the subsequent fwspec
 allocation fails, acpi_iommu_configure_id() (line 1614) does no
 cleanup. acpi_dma_configure_id() (line 1670) ignores errors other than
 -EPROBE_DEFER. This invocation has no enclosing iommu_init_device() to
 unwind it.

The OF path has its own manual free fix already, it doesn't rely on
iommu_probe_device() to clean it. The other driver users are the only
things actually protected by ops->probe_device().

> > @@ -3074,6 +3074,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
> >   {
> >   	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
> >   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	bool new_iommu = !dev->iommu;
> >   	if (!iommu)
> >   		return driver_deferred_probe_check_state(dev);
> > @@ -3088,8 +3089,11 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
> >   	/* Preallocate for the overwhelmingly common case of 1 ID */
> >   	fwspec = kzalloc_flex(*fwspec, ids, 1);
> > -	if (!fwspec)
> > +	if (!fwspec) {
> > +		if (new_iommu)
> > +			dev_iommu_free(dev);
> >   		return -ENOMEM;
> > +	}

Just move this allocation before the dev_iommu_get() and free it if
the get fails. Then the function has a more sensible calling
convention that error means it doesn't need any unwinding. The
new_iommu is a little too weird.

Jason
