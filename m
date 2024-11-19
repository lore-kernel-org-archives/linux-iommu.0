Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46B1D2239
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037409; cv=none; b=TajfHLbSpLaUmQu58E1BdE9GwYFM+MRy367eSG76MtjzKDbDSwPagmBIRDYIcAMGBVYozOvVJ8+lqwadD5RoFQ+Uq+ChzyMYVZZEvII2y9dH4BN3FIwvKOfH5dcrsEoQKj7cw4nSGWST0lHjluYVLCjVYcz4/p6pTFqMMdLJlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037409; c=relaxed/simple;
	bh=iJAspBGFRcgVzY4bKp3lb6zrw26/GFw5AyKc0Z0Pg6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP93c4aTrYNf3WoVNQfk704fTF1Hn9zGPPU9Eisfwo7bzBGMprp0XYPa46YqsCFRZHk5kie0sM3kNYKSn1AbL88dh5Y7RnD62R4EQc67qDdW4gQ/i6WOxHuhk32OvhGcJqZvypI7X6qVt1EDB68K+rH8p2Rahwxu9NpkvA7Hym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kgpbakJ5; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kgpbakJ5"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b14443a71eso302474585a.1
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732037406; x=1732642206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=;
        b=kgpbakJ5JxizGErrFM+sGtT93y+pVw9LB6GVX2UNhcwBxUMhQnskvqihbK/lzckLeS
         MNwaev3FvUTeY90lZjyTah3x7i180BKiqcDqawSZEbFbpzekGUTpKohSw/Ydkf0BVGFF
         K05Itdv1IQ8doisaB8Y2eU9ngVPDiMyz9tCDZ2XvO8UNWTIBQdh0v9K+l75PJBZ50ZHu
         KgxTZiYEv+xRR9niJ4UTaDSOspNQvuqIsm0uV440+Kry7sQ9VII99GfCRHQz19NlUR73
         cyHYJaMmXg2YilFZdXYAklCmwEz6dxWeMuVcL3TmsS1IEnjGMUwCClsOyizkEcoZE7XD
         7WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037406; x=1732642206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=;
        b=ttG4DVJYR+rpMqpntHAQab1olIQ9Zwd4GAQzLohTOCrsuQx4mBM2UegeHg15e2RwyW
         I9dJUVpok7I2fj1nBoty4xOaBlJCyAPbykFk0FlJWi6411IVah92RgJ0SNB/H1BKIsaD
         LcmTJXenNZNWr8recHto9Wdv9TGaxUAjqSvS2VmUjsS1+s4MpfGZurRx1GpJlYAtb25H
         NzL8aM62zJTQhUFf9yx4rAwRrkJ6ml481Z5u8s6RD7EkhyaRbXok1xql/F4DMGLlt+Yu
         GGRl0+C0IyyeLowf3f+JUuIgWZ8WuI5cuBZ4NKtKJCaspS/svZn7d/SjczesAi0arz5q
         3JuA==
X-Forwarded-Encrypted: i=1; AJvYcCUGuQM52SakipJ1ocMhFl1bPr/3L8SVzhZsehnKZwPCAKK6Ezp6D2Lcav6idcAHrbpGZvUU4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjsMzZu9UbUUaFghaoBZgqqcXWSRsdkG2quUZUWEpNByuVGeI3
	ahXXdu0iOrdwslJASyIY8/1ed+9NCgGE2sNt+PrG5VOtkaqHdk82binKKncRE9M=
X-Google-Smtp-Source: AGHT+IEw2hhta4tF97+ZTqDEn97k4/qPKPWIxcDYewixCIGPDLkcCaqZGpK5GII/9x88g1PJnE+WXg==
X-Received: by 2002:a05:620a:1992:b0:7b1:4330:634f with SMTP id af79cd13be357-7b362384ee1mr2344165985a.61.1732037405973;
        Tue, 19 Nov 2024 09:30:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a866319sm113013385a.69.2024.11.19.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:30:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tDS3A-00000003GSP-14at;
	Tue, 19 Nov 2024 13:30:04 -0400
Date: Tue, 19 Nov 2024 13:30:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241119173004.GA773835@ziepe.ca>
References: <cover.1731244445.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1731244445.git.leon@kernel.org>
 <20241118145929.GB27795@willie-the-truck>
 <20241118185533.GA24154@unreal>
 <20241119090507.GB28466@willie-the-truck>
 <20241119135743.GB26101@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119135743.GB26101@unreal>

On Tue, Nov 19, 2024 at 03:57:43PM +0200, Leon Romanovsky wrote:

> > > dma_iova_link/dma_iova_unlink() don't have any assumptions in addition
> > > to already existing for dma_map_sg/dma_unmap_sg(). In reality, it means
> > > that all calls to unlink will have same size as for link.
> > 
> > Ok, great. Any chance you could call that out in the documentation patch,
> > please?
> 
> Can you suggest what should I add there, as it is not specific to new
> API, but general note applicable to all __iommu_unmap() callers?

This is what I wrote:

+/**
+ * iommu_unmap() - Remove mappings from a range of IOVA
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the range starting from @iova
+ *
+ * iommu_unmap() will remove a translation created by iommu_map(). It cannot
+ * subdivide a mapping created by iommu_map(), so it should be called with IOVA
+ * ranges that match what was passed to iommu_map(). The range can aggregate
+ * contiguous iommu_map() calls so long as no individual range is split.
+ *
+ * Returns: Number of bytes of IOVA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */

Jason
