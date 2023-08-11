Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03511734
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 17:14:04 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68783b2e40bso1695596b3a.3
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691774043; x=1692378843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bcJM0SLMxv8I13dY5TRlyJefXEA95JxGEoIyQSKlH3s=;
        b=KqNPrZIieuMXW+UgXUuHECVuGzp6DFkx3AYbo8xgXyKIzl+6R4MqT+E2phfEgUxYDS
         u5SrIMTZ0xlYbMTsBexIJMQZteqMFhQzd0kIP4j6LTJ39kgodtEXIHVUEdOTzOdLiGTR
         xK6w/uG8iTasuLVNR2msFgo+/IZ7iuBY9p5YcWmer1bGTNSDxjxGA4KJQkimxuT92uqG
         Flb9reLYIfU600rv825vz9iAh0HxtDZTfkxjheEdJQo7F6LIs0+SmJbwEKgB1muTIkK3
         cySVwh4wWzmS3xD5X3QT2UER5Gl5IJ6LK0LaEa2s143Agjg1Qajxg8c4L0IvaVujlT5u
         /Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691774043; x=1692378843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcJM0SLMxv8I13dY5TRlyJefXEA95JxGEoIyQSKlH3s=;
        b=BNDobEX++nXVnFONHj+IJ/XOxgzz/o1MKOqpL8yEllk4UOjszVKNRak2k7uwINw/aN
         Ttt9Dyk5pT2o9IA3LeJHf8g2HdOUto4r94TqsKs/JlSMn2N9w7P+icnQnYKu5boQA4KR
         4XjDfYPUUBOcTvQcgZ64JHW/wN2Ykn3Uch0L3qUCE5qmV7bhfa3T37TlAEI+XUeUtTzX
         uE93XOH98JeCCUFIVEdfhzQYV/BharF2gwfbmKsqpOiIHwmqImY26UUmVYX/0Bi/bDRH
         qkyaIEnhP5F2Bj6Bf6MAcVx/tjkIBdcaHxsIiNXauZn+zVh59vh90jk1oTQM0OGC89gK
         Q9zw==
X-Gm-Message-State: AOJu0YzI4K6W2utnyN1CrvokvapC9/uYGxf3R+zbhhv3E4bmM3cyplhn
	7GzeH27fcWyyJQF3LhMGdLvcyQ==
X-Google-Smtp-Source: AGHT+IGFh5YVV7fdqBpdV4FUhL2nsK7RQeaIPdvgZucjdKYKzxMNBjvOBrHSHNO3kBEv7zfbIObFlQ==
X-Received: by 2002:a05:6a20:5497:b0:135:8a04:9045 with SMTP id i23-20020a056a20549700b001358a049045mr3266427pzk.1.1691774043466;
        Fri, 11 Aug 2023 10:14:03 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r30-20020a63441e000000b0056001f43726sm3571605pga.92.2023.08.11.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:14:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUVi5-005Sth-As;
	Fri, 11 Aug 2023 14:14:01 -0300
Date: Fri, 11 Aug 2023 14:14:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] iommu: Add helper to set iopf handler for domain
Message-ID: <ZNZsWcV5asNwyOq8@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-13-baolu.lu@linux.intel.com>
 <ZNU4Hio8oAHH8RLn@ziepe.ca>
 <b154c6d4-45db-0f4c-d704-fe1ab8e4d6a5@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b154c6d4-45db-0f4c-d704-fe1ab8e4d6a5@linux.intel.com>

On Fri, Aug 11, 2023 at 10:40:15AM +0800, Baolu Lu wrote:
> On 2023/8/11 3:18, Jason Gunthorpe wrote:
> > On Thu, Jul 27, 2023 at 01:48:37PM +0800, Lu Baolu wrote:
> > > To avoid open code everywhere.
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   include/linux/iommu.h | 11 ++++++++++-
> > >   drivers/iommu/iommu.c | 20 ++++++++++++++++++--
> > >   2 files changed, 28 insertions(+), 3 deletions(-)
> > 
> > Seems like overkill at this point..
> > 
> > Also, I think this is probably upside down.
> > 
> > We want to create the domains as fault enabled in the first place.
> > 
> > A fault enabled domain should never be attached to something that
> > cannot support faults. It should also not support changing the fault
> > handler while it exists.
> > 
> > Thus at the creation point would be the time to supply the fault handler
> > as part of requesting faulting.
> > 
> > Taking an existing domain and making it faulting enabled is going to
> > be really messy in all the corner cases.
> 
> Yes. Agreed.
> 
> > 
> > My advice (and Robin will probably hate me), is to define a new op:
> > 
> > struct domain_alloc_paging_args {
> >         struct fault_handler *fault_handler;
> >         void *fault_data
> > };
> > 
> > struct iommu_domain *domain_alloc_paging2(struct device *dev, struct
> >         domain_alloc_paging_args *args)
> > 
> > The point would be to leave the majority of drivers using the
> > simplified, core assisted, domain_alloc_paging() interface and they
> > just don't have to touch any of this stuff at all.
> > 
> > Obviously if handler is given then the domain will be initialized as
> > faulting.
> 
> Perhaps we also need an internal helper for iommu drivers to check the
> iopf capability of the domain.

Yeah, maybe.

I've been mulling over this for a a bit here

Robin suggested to wrap everything in a arg to domain_alloc and build
a giant super multiplexor

I don't really like that because it makes it quite complicated for the
driver and multiplexor APIs are rarely good.

So for simple drivers I like the 'domain_alloc_paging' as the only op
they implement and it is obviously simple and hard to implement
wrong. Most drivers would do this.

We also need a:

struct iommu_domain *domain_alloc_sva(struct device *dev, struct mm_struct *mm)

So SVA can be fully setup at allocation time. SVA doesn't have any
legal permutations so it can be kept simple.

Then we need something to bundle:
 - Dirty tracking yes/no
 - The iommufd user space blob
 - Fault handling yes/no

For complex drivers.

So maybe we should just have a 3rd option

// I'm a complex driver and many people checked that I implemented
// this right:
struct domain_alloc_args {
       struct device *dev;
       unsigned int flags; // For requesting dirty tracking

       // alloc_domain_user interface
       struct iommu_domain *parent;
       void *user_data;
       size_t user_len;

       // Faulting
       struct fault_handler *fault_handler;
       void *fault_data;	
};
struct iommu_domain *domain_alloc(struct domain_alloc_args *args);

?

IDK, multiplexor APIs are rarely good, but maybe this is the right
direction?

Jason
