Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2371B86E9
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551805; cv=none; b=ctmncXzZG664NzF4qmu37BLM6cAgrbzW3N07jdfZBmoFL7jX6FjfUWkGMZTGf00+8twLKtH/cqq2X1LfQM2IEaSt4Xel1qFvDMhj1N3lGG9Tohp89a4ZiX7z8P5meXWyVcI17lyzyIhQ7r9E89vad+pxK695QiKJ8U6M5Q4rXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551805; c=relaxed/simple;
	bh=sMyzaJ+W703AH//DDEwdvJyCCtm/s3ttll6zL+v1YV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFgZsJ470l8w9e+c5VK6/PF9nbvtqr7izQ4bGjm04zLh3sU/iBSgO5yohCqW3ov1mzz5GG0aU7a/+SVemGj8itVf44uJpw43IgM2eYL4q8kpyQ0VbyVR8R/XV6Fa3AYPeYdQjVDxMEqBXHGfjy0bRZbzbR8NjGcxGbZaSNIF2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E8769azX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E8769azX"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b5e4466931so25078406d6.0
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720551803; x=1721156603; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=;
        b=E8769azXKwyMYkPEoqRhGmeAh0ilMGW3nF0VrrKZNAFdahXkcJniBhNaigEfizeEHy
         vHWh5LoMlJV0IpMoN2KyBzES0VLznKiiCqzMau/L8qnexwNvqFc3oopE7n+ynn22H3rg
         BFFKy3AYE8Ixnn9C0w4w7Fd79fYSmKaEP3akBpW2T2Fu4DUKUQBtHL8Px6AWwfVJ6SsH
         5D6s7VRkuQy57uE3f7CemcBXdZmEumU+LalM0mXNL2KqT8jEo2iPM+iysCabv9nxiHfL
         mq7XBLRz07sTO+zk485BjRMlCCKNCPMez+lcdZZnsfQ+O5Q+KFRnhZhsh4uDWSpvaF6b
         Z+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551803; x=1721156603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=;
        b=qPws7PppVX8qvlQihfSB4dYHa2J3fa4+9qBeHgnNrCL/Hw+husYupvjsS06ZuVKMx7
         kH22YzeiXwDsQ6f9UATWu8bFrX7qPr+Dg3lhYhyf+qb2M/71GEEmxajAe+CP4cvLvPo8
         F9cK5gg3c+RYInh1gieaYPzkKy7YV11jLQL3t6XIHaPcaoBaA12LjW7sPxiIUjt00Nez
         KOv6HZcatHOWrMfinhfQQ6wgQYfz8tpYSLXA956DQmtrALynvMCWoMB3FT1+gkjane8Y
         IJMLPaiipVUyK24fnETqqcoZTDEFGj344e/qSHS00tpyv6l0o9ayuK7QPVGaF9+KBoyl
         SnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4exIko5b8mXCG80KLllmbj8hRETjXf+SgbWedGST0il0a62l+XES/0DuHwclJCE4gYhBZVZGPykmhakgEk3Lba8vYxk8=
X-Gm-Message-State: AOJu0Yz3+vS5Eo2ZXwdWfTvDBruuqUH3Gb0yQWT53O86wwEr22ND39+l
	PZR36qpeSTuTtza+6S0DNQm9SXuxpPN8QenAQXdc+5XpM1Fqv/x3LzerL3iWqEc=
X-Google-Smtp-Source: AGHT+IE9wk6d6lAYU4tvyeORxb5NkdX/FMtkoFI0Rc5O+LsyZzi6JOQvD31sQUESKmTir4qJcqoy3Q==
X-Received: by 2002:a05:6214:250d:b0:6b4:4470:81a5 with SMTP id 6a1803df08f44-6b61bc7f74bmr43617486d6.2.1720551802811;
        Tue, 09 Jul 2024 12:03:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4a1fsm11278546d6.12.2024.07.09.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:03:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRG7U-002tXL-BB;
	Tue, 09 Jul 2024 16:03:20 -0300
Date: Tue, 9 Jul 2024 16:03:20 -0300
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
Message-ID: <20240709190320.GN14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709062015.GB16180@lst.de>

On Tue, Jul 09, 2024 at 08:20:15AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 08:57:21PM -0300, Jason Gunthorpe wrote:
> > I understand the block stack already does this using P2P and !P2P, but
> > that isn't quite enough here as we want to split principally based on
> > IOMMU or !IOMMU.
> 
> Except for the powerpc bypass IOMMU or not is a global decision,
> and the bypass is per I/O.  So I'm not sure what else you want there?

For P2P we know if the DMA will go through the IOMMU or not based on
the PCIe fabric path between the initiator (the one doing the DMA) and
the target (the one providing the MMIO memory).

Depending on PCIe topology and ACS flags this path may use the IOMMU
or may skip the IOMMU.

To put it in code, the 'enum pci_p2pdma_map_type' can only be
determined once we know the initator and target struct device.

PCI_P2PDMA_MAP_BUS_ADDR means we don't use the iommu.

PCI_P2PDMA_MAP_THRU_HOST_BRIDGE means we do.

With this API it is important that a single request always has the
same PCI_P2PDMA_MAP_* outcome, and the simplest way to do that is to
split requests if the MMIO memory changes target struct devices.

Jason
