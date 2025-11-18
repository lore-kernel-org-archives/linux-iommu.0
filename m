Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2D35F8D9
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477980; cv=none; b=KE+FYqaZSpH5skPX/yP/p+1XNTl9FvXNFOhfekRpuc5OipdLMjHJgmOgIeo+wa1F7h7kmYZcDgfmZo5qzsu3e6eSaWDPzKfemgVUiA8X4qPe98cm/Bcj9Uvz6z7VuTga/FHycXc7cDjvLb/YUNX/sjwWqX13y6JSCegcTrJMuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477980; c=relaxed/simple;
	bh=yCZWg4HDLfx+KlOFPmT2qV/mW2ZLzgnFX5/2HTcppS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r14ro7gb3MJ/6mjTOaXzu9xP0A9QRheOnxyrmU6oKxFOcnvsGR2hkWoqPC0lTkSVlZnapVamjWNLlIjlzsmP9wLBWW8pWxfG4sYCp2OA8GEOnIVtYIaTJZtFGRZcCdOS54ER18Ubpcr3T666oam8kBTlntusjiYHk+EaMLy+XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JGlnaVs7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JGlnaVs7"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4eddceccb89so61621911cf.0
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763477977; x=1764082777; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6zUAnqwUQ7mMEKfAAq0Pm8CCEggD/qceLgK2oNv/WhY=;
        b=JGlnaVs7a23fSZG6lwbggdllfn1tN5ZqogUl2UNCTUvJ605k8BJ+c0a5jRACTLC+Ki
         /n42clLzoKyqRbO1uKACdNZ9KbPDHmVhg5pJMhCRyax/M37O4A8NVAMoNFWy16dZwJbY
         rSs9FfeZNLhA+p7yQP6YGnQ1O4XLOq6bWEIjIz1RJg5zPg7+zH2GQW17bkFUdgV6TJyv
         A68vSLl85jNQueXb7cRH5EMJWYoMrHvskeN8+TwTR34pXuoh1mF83m1QoeVdQZT7dITl
         BYYC1bv9HiD1i7hzPM9P7/mLYQ5zQ/Pym+zZ+o6I5C04tHw4QZIeLWn3dRDIA8VfmK2S
         t7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477977; x=1764082777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zUAnqwUQ7mMEKfAAq0Pm8CCEggD/qceLgK2oNv/WhY=;
        b=CIgRkvDypNI40YEmQKwxD+/rfEPEhl80irc//v8chmicllU87OVLvVHeOhrdHs00H9
         mejJ415QMGNjqd4bGhN191WbgnS+hPWkRGwE3Z8zTido7PBg4lhnNwh8alNmmElIsqub
         dwn44tIsMhyG+ZKR5WNMYSCPjiE8t6Tlrw0UdZvtzMugBNVx5JjDoOxS+DpA6qg0qbUn
         sw08u0Z2ggUKHYdcr0mqCaKcuxLdlecXDe5WtI2myTSq2eFcW9HaQIiGbfD9j0fCwXnt
         q3tlcGJaqQSi0/Dav1BOdzJNTCftWA+CbhnpqDt2opHGAcUe7vJ7wgpon9Yb4VUW/txW
         cfvA==
X-Forwarded-Encrypted: i=1; AJvYcCUihEjgxu8wVS62NNLikNtKHJlQ3fpe8FpeMdme/OUBSm1vwovU+Mq6uMk6l3gOTL74f5fN3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDSFd85tczuye1nEaNJ2XqXm/TZzixffG4hT6soCjWJP0CIIS4
	zoy5wi+zjSMQ/faOKbrX1H/WPlLFrmfdrA65zDV7t7w0J0fwwRlr1ac6TDD4nV1m2B8=
X-Gm-Gg: ASbGncufgfmBuEPanayenFcP1myjUbCNpdXd495E8jmq9BeszvUqoft8I1T08slKRkk
	nfiGG3g5Pa2e3ArSWAX7JrPJMl0gSudYGFUMfQi1Gg9QZRhuwue5wj8zOU6pfdMsC8bWenfTK3J
	KbMrKukllQPzdaXSorEhaQFPhvi/exW4FGxFRxu8Aj6yClZnS3vo8lyUIThwsU1FxVg5+n/wYUA
	CrwDgu/3ozFPjSuiTFY+E1ORL5UUFeah+fN4/I9C1y0K2G4PiEh6hTqyr1O3QUMTXhiB9id7g9u
	sn4PZ9dhkvKBdA5W3vHQ+xLAIn+xoz0IJOwQUXBwl4OEUQ140Y8h9ObK2hbYagK914t5d++WFhG
	Y8JfJggcPbq1ZqRFfLZJ0F7LE/3ZEDLbvSrXGP5/Yqiv6QbESavhZgSRoXPlPHp7+0mltu9Jwh6
	rtTfeC2n7ryPvLzl5dTImXayi7/WOGoYv83uqB0e9TJQ3UeX0kDUR8gjiF3OJ8wFi9A9A=
X-Google-Smtp-Source: AGHT+IFmOGfhY23WsMGsPUUjQKfSR05e4XRcukJGt61kp9ViFdOBWiVKVUUuzQ+TB82GrGuUAmTsrw==
X-Received: by 2002:a05:622a:1a08:b0:4ee:1563:2829 with SMTP id d75a77b69052e-4ee15632a6bmr144570871cf.72.1763477977218;
        Tue, 18 Nov 2025 06:59:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee275abad5sm34184941cf.14.2025.11.18.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:59:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLNB9-00000000NQI-239J;
	Tue, 18 Nov 2025 10:59:35 -0400
Date: Tue, 18 Nov 2025 10:59:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v7 00/11] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20251118145935.GI17968@ziepe.ca>
References: <20251106-dmabuf-vfio-v7-0-2503bf390699@nvidia.com>
 <20251110134218.5e399b0f.alex@shazbot.org>
 <da399efa-ad5b-4bdc-964d-b6cc4a4fc55d@amd.com>
 <20251117083620.4660081a.alex@shazbot.org>
 <20251117171619.GB17968@ziepe.ca>
 <3599880e-5b50-4bad-949b-0d3b1fb25f3f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3599880e-5b50-4bad-949b-0d3b1fb25f3f@amd.com>

On Tue, Nov 18, 2025 at 03:37:41PM +0100, Christian König wrote:

> Skimming over it my only concern is patch #6 which adds the helper
> to the common DMA-buf code and that in turn would need an in-deep
> review which I currently don't have time for.

I think you should trust Leon on the implementation. He knows what he
is doing here when it comes to the DMA API, since he made all the
patches so far to use it.

Please consider just reviewing the exported function signature:

+struct sg_table *dma_buf_map(struct dma_buf_attachment *attach,
+			     struct p2pdma_provider *provider,
+			     struct dma_buf_phys_vec *phys_vec,
+			     size_t nr_ranges, size_t size,
+			     enum dma_data_direction dir)

If issues are discovered inside the implementation later on then Leon
will be available to fix them.

The code is intended to implement that basic function signature which
can be thought of as dma_map_resource() done correctly for PCI
devices.

> So if we could keep those inside the VFIO driver for now I think
> that should be good to go.

That was several versions ago. Christoph is very strongly against
this, he wants to see the new DMA API used by wrapper functions in
subsytems related to how the subsystem's data structures work rather
than proliferate into drivers. I agree with this, so we need to go in
this direction.

Other options, like put the code in the DMA API area, are also not
going to be agreed because we really don't want this weird DMABUF use
of no-struct page scatterlist to leak out beyond DMABUF.

So, this is the start of a DMA mapping helper API for DMABUF related
data structures, it introduces a simplified mapping entry point for
drivers that only use MMIO.

As I said I expect this API surface to progress as other DRM drivers
are updated (hopefully DRM community will take on this), but there is
nothing wrong with starting by having a basic entry point for a narrow
use case.

Thanks,
Jason
