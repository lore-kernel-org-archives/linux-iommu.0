Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F271A08A6
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740562; cv=none; b=hQwnUl6tZYSrfomD2TsEYGtNzXBCEgMIA210GrV2WI40gmjbvOMYH7b1O/nnXe8EzZQhZ0EtI9hZy0ARtB1jzQ7i6toaJIOzzxTIkYttaDMAJJSu1AhqJLBXYz4V1KSJud5MALQ0QWtU/lFDQbObhfgQVawsSooHDtGGl4WZfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740562; c=relaxed/simple;
	bh=xaEoCHgxGFkkaE365hqIb2Uz8DfpXp/vyPGTl63S9F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFpfseNq6ix2WrWZoeKDlz7dcvrwBfmjnKGqZb49feHdnAmUjDq+OMfn2maCOEik3LMxP6s8YIqaRIj48hP4tHgOGepJd0unSwttuqFgLPSjgvyIZEoWGvRxFicNBHEw5hnvXtBHxaAXXiPJ9blJ3OD7WADORjx9WoTXe5xU81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fTROy4bG; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fTROy4bG"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so1365470276.2
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720740560; x=1721345360; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=;
        b=fTROy4bGfucBIYawdpknT/OwqSgmYZiCQq84DyLNY/GVdZZuRe6vzEqUfVyoU09cWT
         eyIBDmdF8ATYYOd/2kcR7+g+cyaoA0yp0cmuyVsygQ4m1JmT8C6iVqBtr4Rei/2eJj8h
         cTgUnICdvHzfUVSZv4wFAWoqNdd42HWE+vuRSiF7wlKknyI+vifSJy4hEHIqvr2lR+p1
         iYiZbU8Ctv3/9II0kC0LFGTsYlO4oAmSm/DIUkPab5tOaBjM137rVyO3I6luifeNMax3
         RodC7OTqO0UCXGnw3/XXYQ1kQYj0wbXBPCYzJdT6jshiET4ZkZJRLwEshWQUrHotcSTp
         F9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740560; x=1721345360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=;
        b=bngWyEIkm/icmI8eNNTcN22VOAEOvKAvSqmZVqHulFuJgLqcptHRubQc5v5E/6TTx4
         GQzrHkIYGXJVERC7jvyMK8TFafZ5KVwdUF6DAO2VF2I+lVWIzmxbCn3sqjR+GKpVzHK9
         WCa8Y79H9DfvVH+lybBWU74a7/DvlUOsszWwHk9pI8k/lo2H5sG57PfH43X5KwFHilH/
         3yImGUcumGTy68uyEQXvhuH1YsGfnrf6NpiR93y4k/6KNgqr7QVEM+9LBZe8M5WSSUpH
         ubx6UzlsHqjRTpTIddQ0pCIILTkPz+Yp497P2MqdEf02BDdvS/11aTzg3ytPTbZm1Cy+
         aUXA==
X-Forwarded-Encrypted: i=1; AJvYcCUo3a0mbtW04op5qwHT9TfS3ttV3nTHTVuyHihJ7e39pQEwVNSO/DKMcBJS6wwGwRfh4+AQOncAYsFFjz2JhZSxaRTxzMQ=
X-Gm-Message-State: AOJu0YynD9ypcJr4eex0WuwRoJeWpkE4Ab3XBAJG70Er/vmAFm2gaSbo
	QrK5iy5rGyRTwk8lnHV71K3Vxi9ci10oVIzhYydHNG1ysLx8ZAh+MfhRiLe9ycM=
X-Google-Smtp-Source: AGHT+IGo/R/9vr/JQ8/zyNR81M/Hy4HYANX0IxAKDGShf5hUDU3ZGhkQLcCJ3hGHl6ul2XGkV4cgvA==
X-Received: by 2002:a25:aa66:0:b0:e03:5fee:66a with SMTP id 3f1490d57ef6-e041b123aefmr11985783276.42.1720740560216;
        Thu, 11 Jul 2024 16:29:20 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190128d0sm341135085a.44.2024.07.11.16.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:29:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Dx-00FQzB-7b;
	Thu, 11 Jul 2024 20:29:17 -0300
Date: Thu, 11 Jul 2024 20:29:17 -0300
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
Message-ID: <20240711232917.GR14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710062212.GA25895@lst.de>

On Wed, Jul 10, 2024 at 08:22:12AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 09, 2024 at 04:03:20PM -0300, Jason Gunthorpe wrote:
> > > Except for the powerpc bypass IOMMU or not is a global decision,
> > > and the bypass is per I/O.  So I'm not sure what else you want there?
> > 
> > For P2P we know if the DMA will go through the IOMMU or not based on
> > the PCIe fabric path between the initiator (the one doing the DMA) and
> > the target (the one providing the MMIO memory).
> 
> Oh, yes.  So effectively you are asking if we can arbitrarily mix
> P2P sources in a single map request.  I think the only sane answer
> from the iommu/dma subsystem perspective is: hell no.

Well, today we can mix them and the dma_map_sg will sort it out. With
this new API we can't anymore.

So this little detail needs to be taken care of somehow as well, and I
didn't see it in this RFC.

> For the block layer just having one kind per BIO is fine right now,
> although I could see use cases where people would want to combine
> them.  We can probably defer that until it is needed, though.

Do you have an application in mind that would want multi-kind per BIO?

Jason
