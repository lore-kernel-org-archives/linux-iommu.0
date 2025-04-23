Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F4028D846
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432231; cv=none; b=XecW4GiGoaypnr0n8lOyKM0uc3xmHQ88m3Mq8jfxhJwab99pcPZE5kQYDIiFO+AXhKVjCPWx0b0e6mkc71mK+Y3BewJYv74J+Ipc9g8wLPx8umFNywg0b1UQY4nHv8APyXf0cRB+q6NnRANWl0XsJLldyxf5kAHUpYVo1Svqp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432231; c=relaxed/simple;
	bh=ZwDA7dKaeXsaxB3idhnk/64Z7wWQuL5MluTl3MVfp1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obcYWuYpIanxo89eisa5RQ23STfcF8x8lBVn7uDgxH11ipRNZsbBvFwaFZtvIS3JuL/A1WNx+jN1H4m8bPUOQXJJntUEsYe90ZTfE/tLJsNf8zSA5yqdRPwJfnEjhhl/rHCpS3O1s6cZLKZkpdDtTH3NQneAqIzPWqYNNCcCZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DG1U30KB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DG1U30KB"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766631a6a4so1565901cf.2
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745432227; x=1746037027; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=;
        b=DG1U30KBhoHCxTynwYo0gQUWOh7nKxAT6HDYyHgyVSvfuRyNrQVYKI4RHCq8K7cysY
         Z0amQiobW69Eozt2E/UKAoNWzWKNucLtkrk74xMGjywmlLIjcayz3wjy4DKTbyWc247r
         47OGg6wxmonMGhW8nJ86vMGLiRbHBrjbgg80Yf9Sy/EEiRRjrL7Q/d7bTh4rhjYFwgew
         Q+4SMXLOltE4PerLf1o4haSXNSOM/3hzecOZnTj1YFS33EYQMeeehr/j1oiiPQgImiti
         bfJeDOaRerGLPQ/G4FQ9zv9EjP9E7bKQoS3wK6ndAuiwRS+3y3kiA/AtvulLrhQZOzYw
         Ok4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432227; x=1746037027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=;
        b=lPR5caZCTGWtfYNP04cnkXX1wgoZllX8byrRXiZlFCRERT+Yt5RsMGkhOhPSiJmrxm
         4xrXSWQt4HY/PJxVwRIdC/Aoc3fJK+36C1VlcTREvasnz33mNPoTdiTsclRF9uMlJpZV
         QmGez8tuqmGrKwip6b+8pXB6oTSOKCLRP2iRi4F0IC33MlUGxzz2D0Xkw8wv2qIgHG4i
         TI3RZfPSfT0TOO8A7VtDcXtiLE8cxe3mXhr8o320mDroH7zGS7MN5MW8pnZvLd4LMHHi
         BkapPdtkalirN4mRvVie+lDSZLD573uVN3aA6JY/jJOkvU9idVcbzafpr6OCWMRAU06U
         TPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4Sc/mlA+2FFZStQ9HV18q9YzNH6CegYA7Y8zcwW2v4npXJeBzZMji6CJL41qfUvO8JnapQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/smEsHYPa6gI8zYwYfZo4MaTU1kcbYrkEsWSz24w7jRZZHOVV
	YnuzKcYU+xhqHRiTXTdMF+onq9s3jYEp6Wdf+SRcpy9hDVncpsCj7R/Xv/VXuDE=
X-Gm-Gg: ASbGncuqlYdi+77cJtZIBuJZFr4z5QWyKv91uBFOy7D0f64oW/AdZL6zrOHOUD7rq2f
	IXYfv7JclORMJgeisrtDmtjCgE2msXjPgMcVXQv3AMkC11KoM3e4zpzpM985WLCb5hEG2e3ONVL
	wtFQnwMBmXf7Kxki49Mrc2ElTw09VBFIpkAAM0xvGjO0yFb8Lb2S4qnaXEUi8gLBL6fqYgqJGh9
	M6d2j0XcXSXv5NYIH3cMM3Yt+vOp1WEQtaNkpNsDz3t/sRwAGLoACVrg8QsmqLCSlvb3HqgWsiT
	bdY01k0g1CU+Ns7sQq2cKfKcd80DAKpDfgzHMHcy8S1dG6ntboy5sNlgjggjrlfisQmrloo3iYb
	aCwb/LsWwkV8ZRSzKRhk=
X-Google-Smtp-Source: AGHT+IECPlcFTYHnkwAKKk3B5MzEp2J+Q23qmmOis8VDE/Xdu9ZIh9LzQbjBc0+xoVESECxntDW6lg==
X-Received: by 2002:a05:622a:d4:b0:476:95a2:64a1 with SMTP id d75a77b69052e-47e76175c16mr4073601cf.17.1745432227237;
        Wed, 23 Apr 2025 11:17:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c16dd2sm70921841cf.14.2025.04.23.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:17:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eeg-00000007Lzi-1CSb;
	Wed, 23 Apr 2025 15:17:06 -0300
Date: Wed, 23 Apr 2025 15:17:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423181706.GT1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>

On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
> > @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
> >  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> >  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> >  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> > +
> > +	/*
> > +	 * Sticky flags, carried from input to output,
> > +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> > +	 */
> > +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> > +
> 
> How is this playing together with the mapped order usage?

Order shift starts at bit 8, DMA_MAPPED is at bit 7

The pfn array is linear and simply indexed. The order is intended for
page table like HW to be able to build larger entries from the hmm
data without having to scan for contiguity.

Even if order is present the entry is still replicated across all the
pfns that are inside the order.

At least this series should replicate the dma_mapped flag as well as
it doesn't pay attention to order.

I suspect a page table implementation may need to make some small
changes. Indeed with guarenteed contiguous IOVA there may be a
significant optimization available to have the HW page table cover all
the contiguous present pages in the iommu, which would be a higher
order than the pages themselves. However this would require being able
to punch non-present holes into contiguous mappings...

Jason
