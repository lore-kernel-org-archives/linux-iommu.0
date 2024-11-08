Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E4206E79
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079541; cv=none; b=FU4l/gBMU4qxY2tihdoviB3PnWzPcjiOmKNk14u3pA2uDE7OOVhsWa+eTgo68SuKmA2trensa08ferlMNRsaW+NWnMs72SybCdawX9CA4EFJ3FXc6ErFOlONPa5EpdwrHvKSZuheYBlMzDImTh4RV7t2Xy2tgwO4sHUMIEWGfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079541; c=relaxed/simple;
	bh=2feMVd+moXqEWqG7qu0YrJc0Jboh9RPoNC48SzdPbeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAAXTnS73/fctH1a9sYVX1bOZskptu6qDlUsPbpHxj0+qO66Z22iBfb7BzWnDMmPGYAQIixAF4qQ0bwYqGAC/aao1Jd4RBbyl2HhOPLWxUJXIBhoWYuLOT6xgeYd7CQ631LMnU5xe3ewPXkNRRv9bEMcS0RvTgpOAlsC6sgC5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HmqvZXOK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HmqvZXOK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1507c42faso257346385a.0
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731079538; x=1731684338; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbYXv3yCM9yQzCKa6ScUYgOxj5i+yJ5Ve18Z6DNxO2Y=;
        b=HmqvZXOKWFlscoJZ8nulzuooW7OqHAMRONuEQOKMIOA8PyDp7nvNx8DAXYOtfuhuZ7
         +ckX/EqVL97sOErdU+UIfQTpoRl73TAZI9VOA1OQk1+nU39WdqJz6esnVkPDiYC2vrWQ
         Y8IyRjRCmGg5PpP4ragfjpRlyfVnnh0MGJxAmp4kqsHRpQlNeJUOK8Qzxc0cuO3CsJKt
         ZyyorgWi/r8w405QVQOYtIqnhTZHmKg/6/ozcOe3EAVdQRzMJUS+OufX2l77Vt4WN7t5
         Wa/2bWVBxip2adjzYDjqRTgYb9Zr+4g4Qc6+oq5C4PK9WLHoJP/fMA+DipHfRzYAD+s4
         ml/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079538; x=1731684338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbYXv3yCM9yQzCKa6ScUYgOxj5i+yJ5Ve18Z6DNxO2Y=;
        b=CAiWjOHLZC+sKUnlRLVT3kVO/dDb+bj68XYubEjsnejfcA6u8xhffle3/BZadSUph/
         mLviIDi61ecoThhh2NNnSR+zCE53ou89og12wo9CK/4Qjfr3edjuMeFCLLPSBfv2DOYW
         jzl3JrXyogSG0n1mqsPa3ZGtARuwrJ696rWI+W5py0/htqRlSlZC97w/8TXm0obcCwLu
         f2Uz8ITbwglYIKh4y+1bQOGs80Vlo6Sp6AnC/pGRqPzLwBrQ3hiesxbRe9nWNXd8DtmS
         5W1saXyA1REiLw+xFh9DCZiverbsofSnJ1ifNu8wxMspHTNWroT1T26TPIR0nWapjDEg
         0XgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNyQee8z9Dasn+cSzqUgvFkPrx7N7GArZEYZ1mOYDyArSKDOvwk6u2jJGcWXhsnQ+3OPbSaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFzPDfy1zqHN41FtixLUh3dvLKjboGcXohrH86oze2wuWE/UnQ
	LKiH5RhE07qxrQuoJwvzv2eTjEurnB0xQGlQKPq9SvC9aVpxBJ/U/xkOU16JyGw=
X-Google-Smtp-Source: AGHT+IH4eRArrUDZm2rUOb5KR+8EAvAFtyYH0Fr2uIHFPXrPpQnSMiiNxtBbq8LowDrIix/biyMB3w==
X-Received: by 2002:a05:620a:4049:b0:7b1:4cc0:5e32 with SMTP id af79cd13be357-7b3328aeb7dmr490547585a.9.1731079538361;
        Fri, 08 Nov 2024 07:25:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac51659sm170158385a.42.2024.11.08.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:25:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9Qrh-00000002Zza-1RVx;
	Fri, 08 Nov 2024 11:25:37 -0400
Date: Fri, 8 Nov 2024 11:25:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241108152537.GN35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
 <20241108150226.GM35848@ziepe.ca>
 <20241108150500.GA10102@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108150500.GA10102@lst.de>

On Fri, Nov 08, 2024 at 04:05:00PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 11:02:26AM -0400, Jason Gunthorpe wrote:
> > It is fully OK? Can't dma_map_page() trigger swiotlb? It must not do
> > that for P2P. How does it know the difference if it just gets a phys?
> 
> dma_direct_map_page checks for p2p pages in the swiotlb bounce
> path already in the current kernel, and dma_map_sg relies on exactly
> that check to prevent bouncing for p2p.

I'm asking how it will work if you change the struct page argument to
physical, because today dma_direct_map_page() has:

		if (is_pci_p2pdma_page(page))
			return DMA_MAPPING_ERROR;

Which is exactly the sorts of things I'm looking at when when I say to
get rid of struct page.

What I'm thinking about is replacing code like the above with something like:

		if (p2p_provider)
			return DMA_MAPPING_ERROR;

And the caller is the one that would have done is_pci_p2pdma_page()
and either passes p2p_provider=NULL or page->pgmap->p2p_provider.

Anyhow, I hope Leon will attempt this once this is settled and it will
make more sense in patches. I'm just brainstorming how I've been
thinking of it.

Another option would be some 'is_pci_p2pdma_page_phys(phys)', but I
think that is going to be worse performance than managing a
p2p_provider pointer in the mapping call chain explicitly.

Jason
