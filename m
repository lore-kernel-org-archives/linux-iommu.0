Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E8147C85
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457562; cv=none; b=DfeiBojEpUye12+9GEPlTIBX2SKyGqI0Tpkfr8gAzvWrelAzDVqN+Rs2y39RKG6pIKzz9/2lZx27cmVWF2b92IksYVmwUrWl53aBjexsGzTl5mbe7bxBObG2uu6Ze1PkSWHXv8C2XwWCSO5FOmzSHckx4oAECwa2xOAA1baNoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457562; c=relaxed/simple;
	bh=1B5tJgkSM04kGIIt7Bd4CwyiBDyOxIVq095mpakxwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9M1G4J4tWDPpVc+cvbRLLG8GjOKEjrvEDyczIIfkV+eEuVcXK+UmWTznHxoOiEZdUoTNHlW0hyp0PD84IQESZ7QqeMPSVgRDETIAX4eJJkhORiWMNHmPH3ad/7FcTtJbjDrUeTa5aaNFKacI3kzi2p7ETOg09bIQuPOkBfeWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PdFz8G8D; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PdFz8G8D"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447f05bfdcfso7505281cf.2
        for <iommu@lists.linux.dev>; Mon, 08 Jul 2024 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720457559; x=1721062359; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44iLSgmAA8Jj5OzeQp5q3uGTMuRJb4ek81IJRNbfP50=;
        b=PdFz8G8D/YTRKs1yzqGP2RXdcY9Otfswtsby+PmZvGnRT24zanW6H1O2XdXlzb26vX
         vqFVfFN2DSgH/XklA2g1bDczrHuVMf0C3j3+44HNETcxCo2ekDEADuCKaNl4i4yMX+QL
         +O9bO0GIDDevEu7zr7q1G2ic4iLa6hSGEFUSwv/hPC4lb475cB1gMGuCvgcJWnBurl4v
         1VJsDDtnRHW15dHsvwYYqW92dS/33GYi5updXDOG0PoEA2mBMihCEyAddi3b39FvUB/c
         o75YtEtzk9dmwOfA7Y85rvfDCgmVcuJc0EHuY8/RzM4CSscgJeA4W0CCxtnR5poJQ50g
         ecDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457559; x=1721062359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44iLSgmAA8Jj5OzeQp5q3uGTMuRJb4ek81IJRNbfP50=;
        b=lmP43dBDqKXCMjk3TWfjt3mPyaadwMzmqM13FBIX14eIiNRlaBftYHERqsYK+KPzn2
         il9+OZnwcn3jV6Lb6Xrwhbxd7Ark/fJigBwjhDZE3GcKzttINePJKpzX1oq8h5psVD7l
         bSsl/rfY9J5iUt9Bs4wWIk8jn/RGSD9tLpSaVqA6MxCjqZWrNU+bHBb8hvy9TimEQELY
         45F7BZdPmB+dOnVLw5+2O/zSzYyjm0jSQhMUjcegowkGHu0/RHh8oFT9Mdv2tK/C+GY8
         UL/8mPA1rseJAm0L8n0hA/vr3Bj4j5/BHsIVEKcdRLVgN1hAVmj7C7w58iSXN9YQHrGg
         MU9g==
X-Forwarded-Encrypted: i=1; AJvYcCUkiY8X7kEYQgBhAmVjpjUKFO5wlTGpfbpdgDtLWS26g7hVjDsEkO5nvEzxSAlaBT+aeG/FlzO6125CwuslJwC8WW2PcQc=
X-Gm-Message-State: AOJu0YwyMxSOdiWvcpEqPN5pr/bledSXiCCokVrg7TH4jxLVDGeaafxa
	Axk6kjEB2XvVxKbngvlHQXKRbbLfRPrU0H2zd+2a/WxEZC07vh+IZBo3EQz1f15PehyzJBM7Bhu
	I
X-Google-Smtp-Source: AGHT+IHmTDKEE4X7UqSrEePQ2yW2AFHAIlc2Xn5bxdXHYF1pSNmcIuJQ4brop8xp0q/dd20hJkGD6Q==
X-Received: by 2002:ac8:58c6:0:b0:447:e532:b370 with SMTP id d75a77b69052e-447fa8aefa5mr156831cf.10.1720457559408;
        Mon, 08 Jul 2024 09:52:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b40389sm1202611cf.36.2024.07.08.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:52:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQrbS-000Uky-FO;
	Mon, 08 Jul 2024 13:52:38 -0300
Date: Mon, 8 Jul 2024 13:52:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240708165238.GE14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704074855.GA26913@lst.de>

On Thu, Jul 04, 2024 at 09:48:56AM +0200, Christoph Hellwig wrote:

> 1) The amount of code needed in nvme worries me a bit.  Now NVMe a messy
> driver due to the stupid PRPs vs just using SGLs, but needing a fair
> amount of extra boilerplate code in drivers is a bit of a warning sign.
> I plan to look into this to see if I can help on improving it, but for
> that I need a working version first.

It would be nice to have less.  So much now depends on the caller to
provide both the input and output data structure.

Ideally we'd have some template code that consolidates these loops to
common code with driver provided hooks - there are a few ways to get
that efficiently in C.

I think it will be clearer when we get to RDMA and there we have the
same SGL/PRP kind of split up and we can see what is sharable.

> Not quite as concerning, but doing an indirect call for each map
> through dma_map_ops in addition to the iommu ops is not every
> efficient.

Yeah, there is no reason to support anything other than dma-iommu.c
for the iommu path, so the dma_map_op indirection for this could just
be removed.

I'm also cooking something that should let us build a way to iommu map
a bio_vec very efficiently, which should transform this into a single
indirect call into the iommu driver per bio_vec, and a single radix
walk/etc.

> We've through for a while to allow direct calls to dma-iommu similar
> how we do direct calls to dma-direct from the core mapping.c code.
> This might be a good time to do that as a prep step for this work.

I think there is room to benchmark and further improve these
paths. Even the fast direct map path is not compiling down to a single
load/store instruction per bio_vec entry as would be ideal.

Jason
