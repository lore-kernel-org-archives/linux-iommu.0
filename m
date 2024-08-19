Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542016132E
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089951; cv=none; b=gHz/angoK1peNMMB9KRi20fDWBimL6suJGxNt6Jlm/3ll8UHDmPcFTJIFXfCSAbk4GEx2Ppop/Q8IPKh9YHUsAWqZ6Pnt5awyAF4oWTxmvp6tTcSGNduVoRmZ0vjTBYgrHeWFRQw+RSbygahDn6lmytC2N/CAlqECLrFYcgG8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089951; c=relaxed/simple;
	bh=vJcQPSVFW0TULAZASVPa0TbWpKIWBtNtag+HoFgikBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv07XB2aSHnfWcjdZUpnZLwCrGQMNNep3cFIMUW57UfwkFkleVuwpAt0H9iqUBkK0hgjWDSB4lGjAJJtRefZLeM71GuuhQ+70mzCc5irSknH2MUAW3a+J42NQnRNw6WLUjtW09Id+zx8PYnQ5fJSkCRbs6dgwPiFKDc1uA96GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=awHIsztK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="awHIsztK"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dea79e1aso282150485a.1
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724089948; x=1724694748; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsTSvrdF5NzWySDt6s5QWqvzZ1yInTI0o+17ghvVQvc=;
        b=awHIsztKcBmOlVuHBLxreJvGC9N8uBHGijYxZjYS+X/m2RaaGVybN4cWbjzD1jMs/b
         3xan6LOmhCmyuc1g+rd9GxO0FU30sgiIpzm7CBBN7Ofck18a6L+J6vv2PpBYmKRlEQBJ
         h3KqabTzV5NYnBrwi0WO60zASb48soVt2kWW5ykLpDADGPXc9/E4gkZ2Vs6MMFFRmQMG
         Yx+cETzwxov0tGt86ZkcQJAuS6W4F5ERpGPat0gwNCVnDwhnEIRoaBEhbJqbUDbvUz+b
         dFuJfVnDqz+um0K6BxWMDebRI6oJFO5JpRPZAyfUtXoXYIGaQ9hnjOV0Xaf9UyP7yNdm
         Tifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089948; x=1724694748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsTSvrdF5NzWySDt6s5QWqvzZ1yInTI0o+17ghvVQvc=;
        b=Ounmv8w2Nej54SMnJNOrxjLjjEhTvvFGmWV6itI/Ykublh902ByWQ8VLKvRN0M3ixA
         OEmrX8bM8tnFlY1iSHe+pcHoXW1nAa2QurLfJs5LFHn4edCxg/yXY0u+gE+ATIozHFVq
         HNXfF+R5/VYCXMJQp/LCSgVfcJgS/5Y3IdwM0F7PioY5aWGUdNI/aK5J3O00w+kbl52/
         cBVF/kkxepSQ/5dJMjx3aGS8die/mYZLqOlLAScF036lz4yL7FT0nb8gsqi+tSYpBU2M
         k3nfNbony/1jnfHayRwTYaPHekCsjQD48bgpQaPJO3GDEsE4wpwX5G5OJ+zf3dHMqk4s
         Lo2A==
X-Forwarded-Encrypted: i=1; AJvYcCXUeynCdIr2/BxX3tdV9I8yvyB1aiht0SJiFHFBQdeerQRuCFnyx7Uv25B2P1R5BYFsn1bEpMWto2pvR11mBgyZiWTWBKk=
X-Gm-Message-State: AOJu0YxHUzu2Acp+yjsiuKN2HCrvR9CEVCUYU1XWLZQRYJm19m60/lNB
	6eIx8XbZpcM0UfbcKaRYhfEGZlgfEnC+51TG+Ge1dF+By9ObY8nAm2ur2FejXoA=
X-Google-Smtp-Source: AGHT+IFRS5s7FcPS+wYZqZRtnqytzBUqc1vFzIQ0dMrJuF/c8zYD9cwEeXEF3fSn8FOhmVG56E97uQ==
X-Received: by 2002:a05:620a:27cf:b0:7a6:6453:359 with SMTP id af79cd13be357-7a664530393mr192289285a.53.1724089948236;
        Mon, 19 Aug 2024 10:52:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0523a6sm453663885a.46.2024.08.19.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sg6YM-00EKpd-Ff;
	Mon, 19 Aug 2024 14:52:26 -0300
Date: Mon, 19 Aug 2024 14:52:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240819175226.GV3468552@ziepe.ca>
References: <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
 <20240815134737.GK3468552@ziepe.ca>
 <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
 <20240816183700.GR3468552@ziepe.ca>
 <de10a9ac-be2c-4db2-8870-86aca57fb48e@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de10a9ac-be2c-4db2-8870-86aca57fb48e@amd.com>

On Mon, Aug 19, 2024 at 01:57:11PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/17/2024 12:07 AM, Jason Gunthorpe wrote:
> > On Fri, Aug 16, 2024 at 01:47:52PM +0530, Vasant Hegde wrote:
> >> Jason,
> >>
> >>
> >> On 8/15/2024 7:17 PM, Jason Gunthorpe wrote:
> >>> On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
> >>>> I suppose that this also includes converting paging domain to user
> >>>> domain allocation in VFIO (ideally vhost-vdpa as well), right?
> >>>
> >>> Another thought is to add a flag to iommu_paging_domain_alloc()..
> >>>
> >>> Maybe like the below. The small duplication with
> >>> __iommu_domain_alloc() would go away when iommu_domain_alloc() finally
> >>> goes, then we'd be able to directly call iommu_paging_domain_alloc().
> >>
> >> This will work. But we have to define NO_PASID flag and pass it from vfio.
> > 
> > flags = 0 means NO_PASID
> > 
> > I didn't show it but the dma api domain's allocation path would have
> > to specify IOMMU_HWPT_ALLOC_PASID to make it work.
> 
> 
> That's fine. Then in your patch we have to prioritize domain_alloc_user() over
> domain_alloc_paging. Change will look something like below (paste the code path
> that's changing).
> 
> 
> 2037 struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> 2038                                                      unsigned int flags)
> 2039 {
> 2040         const struct iommu_ops *ops = dev_iommu_ops(dev);
> 2041         struct iommu_domain *domain;
> 2042
> 2043         if (!dev_has_iommu(dev))
> 2044                 return ERR_PTR(-ENODEV);
> 2045
> 2046         if (ops->domain_alloc_user)
> 2047                 domain = ops->domain_alloc_user(dev, flags, NULL, NULL);

I mean to make it explicit that the DMA API is requesting PASID:

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1589,8 +1589,18 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 static struct iommu_domain *
 __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
+       struct device *dev = iommu_group_first_dev(group);
+
        if (group->default_domain && group->default_domain->type == req_type)
                return group->default_domain;
+
+       /*
+        * When allocating the DMA API domain assume that the driver is going to
+        * use PASID and make sure the RID's domain is PASID compatible.
+        */
+       if (req_type & __IOMMU_DOMAIN_PAGING)
+               return iommu_paging_domain_alloc_flags(
+                       dev, dev->iommu->max_pasids ? IOMMUFD_HWPT_PASID : 0);
        return __iommu_group_domain_alloc(group, req_type);
 }

Jason
