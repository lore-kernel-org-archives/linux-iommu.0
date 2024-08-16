Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61A7DA90
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833474; cv=none; b=caGmczq6NMGxQGbS3mhNLKf4CztdpF1lru6xwKwxffNKoSw42cbj3SFb0e/U4fPUDNVipVaRC2RPmK/S13lfNvbGG5VUCnaBnv0hc0GcB7XM2nARgZVVr+F7512yr4UOwcm5o27QYAfiB1CQcq7tpCP1cyGsPh8ZR2AzTheYbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833474; c=relaxed/simple;
	bh=erJmaBAuttfAO5mbD7t9V6H18foWxf0xl3UBpOgHXpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA3oiDX4d9fQ4KiF20BPXrNJKYVJXotYKsO6AGImpYO+AZaa4EdXW/mNtEYaiXr4ntFAHyZD5LzjmjcrzBLtmn5r2QZqVHaVQlem1BGh96F0tEQag7tAWajFjE1oFZG2will+vWQHoROQrDD/3SYLrUvGgDrMu2WGiHcJjpykSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WGfMw5x0; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WGfMw5x0"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5eec95a74so1391719eaf.1
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723833471; x=1724438271; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sebjMBM5W+rfgwddJvX9QH9EPhF3Ehwi61e3I/e2S4Y=;
        b=WGfMw5x0Oiwh2vHZjP9nQviosuHGMCF++CqqSDbVD84elTaor+QNABoaRbnIZipn14
         6OlZHBLVj5JXOjRSlGDJ0zuYn/2wPNlbHqrEBZ2TvFc6KhGt8xR6fphHTMEbkw/JmXwW
         9JRwzFBuVGGdgZG18lM3bNCAyURO4AbQpvGBSt0/vs+hDE168shxDD/p/jS5HouUbUoY
         Veekr3AQ1t+Cej1WWY+zOjER/wZfxZf3yd0N/Lqlv33ATOp97t/5Fe5WZdL+jQlo4yMz
         mgFi6jyvLbM6OLjUHbnthMbP0PwnOZhF+Cc412Ck4dfCZNd+o+Gydyo/WNR8ECN0vZaK
         qgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833471; x=1724438271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sebjMBM5W+rfgwddJvX9QH9EPhF3Ehwi61e3I/e2S4Y=;
        b=Rkl5kEX9KMT1WO5pRUF5xDxbp9WlZis+L42gX8vqXukelSShOXigFL13OEiXB7P+Mc
         IpSIeZcYtRvC+LwWoVEBdlhQwn2HrEIWGYnmHUfvh/PUd+Onea+KfFMd+aproPJW+f2w
         vNrcj8BVlGjp0/3Hw42uO70X7GxRMatwGqsdovPpEoGB6cFZ7EyReAOIGAFA/7oRFEDb
         ZZ+xx95NB47AvwiYHBm55b7YlGD45YqkNZBRduU/EMtKuogJQ86cktR1ZJCZawMbMIP7
         xDkl3vb9oB69etxoeIbIQZiXQuJZ3VJCDOIWVxsu/UAbS3IE5AH2DBfKzK9GAHEjWWIb
         mOdw==
X-Forwarded-Encrypted: i=1; AJvYcCVedrz+tjDOo9YM4dUmBBrKU9/s2mVRVK0eZFYEtpT42DmLOrVNy4hzxZ1QDfFHzXrvhgEpwUp9A09rH5RX8fieSokXPOI=
X-Gm-Message-State: AOJu0Yx91aEqVbg3/02EwqreqbanaFticrfIkEjrkx5Q7LTLlDP9G0/s
	Go+r9XoMloqmeDtXPnzbKqZZrcqNhg59NExCQg1QJoCjcuztFZ4ovQfPu8x/itA=
X-Google-Smtp-Source: AGHT+IELq6FskbhXt6sP3FNTIusKOtNdKX+rkJz4d+aZYrtMCVwxBnS9xmMcULN9RyVu+YdO7XMzdw==
X-Received: by 2002:a05:6358:938f:b0:1ac:f346:735a with SMTP id e5c5f4694b2df-1b393315b20mr485126655d.28.1723833471308;
        Fri, 16 Aug 2024 11:37:51 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02aefbsm203117485a.6.2024.08.16.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:37:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sf1oq-00BmHT-2B;
	Fri, 16 Aug 2024 15:37:00 -0300
Date: Fri, 16 Aug 2024 15:37:00 -0300
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
Message-ID: <20240816183700.GR3468552@ziepe.ca>
References: <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
 <20240815134737.GK3468552@ziepe.ca>
 <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>

On Fri, Aug 16, 2024 at 01:47:52PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/15/2024 7:17 PM, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
> >> I suppose that this also includes converting paging domain to user
> >> domain allocation in VFIO (ideally vhost-vdpa as well), right?
> > 
> > Another thought is to add a flag to iommu_paging_domain_alloc()..
> > 
> > Maybe like the below. The small duplication with
> > __iommu_domain_alloc() would go away when iommu_domain_alloc() finally
> > goes, then we'd be able to directly call iommu_paging_domain_alloc().
> 
> This will work. But we have to define NO_PASID flag and pass it from vfio.

flags = 0 means NO_PASID

I didn't show it but the dma api domain's allocation path would have
to specify IOMMU_HWPT_ALLOC_PASID to make it work.

Jason
