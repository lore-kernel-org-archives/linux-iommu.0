Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A327317C
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ea6qAtyD"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-425e58bd4c8so2299051cf.3
        for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702390330; x=1702995130; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ2TiLoD9Gaq6xkoyUSluJ0KHWLQt9mZyTQyaXIVvpI=;
        b=Ea6qAtyDS0GUn7WlV6RgIjMA8w4ZSvCa0Mlv11yWceEjlL6ht7SRFXfYHDawzb8QCT
         YXH/OMVjdVJBezkpt3WZ9G+eDQ8yiyT4d995XymdjnnA6RzAxuP3JImLuHrGjQ1jv9yh
         lsxI9ywLewsevs7rvkc1ca+IWLQOv2HN/kdC52/kGG6WxqpDhYIkLB2yAY8p4QyiL3Ax
         UbHQYWdTKjO4r1YqU6vGR3A8/u1ciL7cDZ1gALpRyvgARt0kljzsMO2XasBy8dX0U+WH
         34N868Y7S/PaqGGhjQzj28cSgV71DEwqXt+/bScEYAU2ip1H5DfxNvS0pOX8D6n9egOp
         ktQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390330; x=1702995130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ2TiLoD9Gaq6xkoyUSluJ0KHWLQt9mZyTQyaXIVvpI=;
        b=IVgsS8aJwXkUP+lw66Bpgz7ogVNnSSN+3r4SpXST9HMtdjrEen1rx7VPCVj0Bve/4v
         AcRY5GkQwBnU8tR/7f8WQldn+71v0GImK/m6Kch3l8nhm9wXorW4/DvMjsqaQQZNhBS3
         WA/8TvtDMpA6wlVrLdWzSVzrGZLVWCzq/L3nVK1QPTUl7pG2nsufDo9WR9eyn9ehMJL0
         JaLteAy8SzSH6vas7YuWFAJt7Pj6/JHbbepN4xCFPI1d4hVvAtaesTuqir+TvnkJ07gM
         v7cmAbG2xV4t6UvYTu1KbOqO4oFdtX1M5WgV6IEQ6tHt/26OCnsyewS/l6dPXxxYCtNH
         711w==
X-Gm-Message-State: AOJu0Yy8skDlisKpQsilEZwhLROBP97iFvieAvwQTvsMPpAM0lTaY6FH
	u3SRDa3hEV3dlGe9h6Xcz7GFyA==
X-Google-Smtp-Source: AGHT+IGRkRQVaTR68B5qveU70mgfrGlXmlTMF+z308FUs0i5H1yAdurOHwLdhvMF64yVQEAU8ICGfg==
X-Received: by 2002:ac8:7dc6:0:b0:425:4043:29ff with SMTP id c6-20020ac87dc6000000b00425404329ffmr7750741qte.122.1702390330535;
        Tue, 12 Dec 2023 06:12:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id t22-20020ac85316000000b0041cb787ff41sm4082934qtn.67.2023.12.12.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:12:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rD3UW-00CjJP-VZ;
	Tue, 12 Dec 2023 10:12:08 -0400
Date: Tue, 12 Dec 2023 10:12:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Message-ID: <20231212141208.GA3013885@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212131008.k6s5xwjgolp6geps@localhost>

On Tue, Dec 12, 2023 at 02:10:08PM +0100, Joel Granados wrote:

> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 645ab5d290fe..0a8e03d5e7c5 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -456,6 +456,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  	if (rc)
> >  		goto err_unlock;
> >  
> > +	if (hwpt->fault) {
> > +		void *curr;
> > +
> > +		curr = iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
> I'm hitting an error here when I try to attach to a hwpt that I created
> previously with the `IOMMU_HWPT_ALLOC_IOPF_CAPABLE` flag.
> 
> I get an -ENODEV from iopf_pasid_cookie_set which is triggered by
> dev->iommu->fault_param being 0x0.
> 
> I looked around and I see that the fault param gets set in
> iopf_queue_add_device which is called from iommu_dev_enable_feature
> only. Furthermore iommu_dev_enable_feature is only called in idxd and
> uacce drivers.
> 
> Questions:
> 1. Should iopf_queue_add_device get called from the
>    IOMMU_HWPT_ALLOC_IOPF_CAPABLE ioctl call? This make sense to me as
>    this is where the device and the IOPF are related from user space.

It probably needs to call the set feature thing in the short term.

In the medium term I would like the drivers to manage the iopf based
on domain attachment not explicit feature asks

> 2. This is not intended to work only with idxd and uacce. right?

It should work everywhere, I suspect Intel Team didn't hit this
because they are testing IDXD SIOV? Can you guys also test it as a PF
assignment?

Jason
