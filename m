Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9F26F46F
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162772; cv=none; b=bX7lBlZUmE4eKx/qq9TiZK/+132JemWNLB+uvsSX5eQMFR6jOsDTrRReaQkl5i/Ul2uIz3CAV6pNAl1SFG8C/pv3yGO513yqfF2zMzmHeRRnGLGqCRWqtrHKsAcRTy0dnJFHcZfTiAzaEg7i8ZNI5/10z1SvyUe0OpgNytQS1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162772; c=relaxed/simple;
	bh=Jo1hwBQ1OAKjPw3AJMr/P9Kbq4e9sCgCina51O06nNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg+QTk91a6b5MaXxnaen8QIDt+ivl5j4Y8zoTedlxsaeT0dgcOvCwSBYwrNzNeBUzjxcJ5h0HZTY/DU5FTUIdC6Q6gOsqwayyv0wuhuAajBRsmU7L9P7I3/iTAg8CbRW8Q2m+lhnmNWXHcoLEBHWtBy303UiHaPxNM7UKby/Olk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQOjYQ5S; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQOjYQ5S"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295c64cb951so202925ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 05:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764162770; x=1764767570; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=eQOjYQ5SnHY+NpWMY9AcQP0OhVeRjSLjEk6bWPJhsc4IIeudLP/0m6HmJrr6IePdQ9
         +TfvUP+piSnThTW7zdEJ+pkanOHrucqoRlH9cqUYipwZmdtYrkQlByhuHJ8CiywWqNIl
         iA65STOE4Ss76Ify/CHs+5otIKlVzODK+hSQ+C47fVQf0yQxvGBkHSTzVGQTRSvsIBfz
         XWz4axgKTVS4XE2Jo2vrcW88mtbnQH2EAdr+qWxsd/5B2OVTEplJHzzT+VNmiJ/sh2Bn
         +QbKeevWAr36LeLATS3Y8EQ+pzWm3B7DCLvz064s3JsFFXpn7hl74zWFef3ivlmiCSqw
         tZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162770; x=1764767570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=anS/4Fk+udsuvt4agSagfzMMQN989vEcHVGnGCfX97vOdszetv7pQRpHTX3tqMpy3l
         19/s2U9AQqnomhTslyrugHW3xnurD2D86ZFsqJc8rzuZ9sOhACdLffIizvAf0gAProj9
         a+CgBpG544yhVcQ1euR7T8UdQ1Cyhk+lGgAGcorU10lAkdvkrR4Q3eauT7PdArOA1in7
         UgziDt/8tePPAYDDoQrMvMq1UYaJGK5gfdftEpEwR3J2CqqRvX/SfHbNe6ytUmSSWR7R
         j/j4b2R8DYvdaC3oPZemByYSmxFHREGCOx7RiIK8a6oZMTR7aE8of2GYrb3oTMN6hN0p
         gVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVavl7aBB7v2hR1InOuHjdKhsZ9e/t55ttd8xyiav+WGBa5709QeIuCXzGdw+Cafo0aLWxxbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSsAoU8jNiqMKjT0fVGxqIupBkJsoiAqZDbwCIHLFfo/OOo7oW
	FPDmhNAqQd18axcfdm0np8aWR69qSvxe68LEHEebYKILWvPNvz2NdlbW24WXlCTLbw==
X-Gm-Gg: ASbGnctymN0RqsxqLnZ0pCcDmjO8JFRvc1bNWVwhygIUokoac01td5ViKFITEru9bCC
	u3s6IYVQH3xnnOVxMdi8Hp4sFA38YnFriyckGLMCOU7Rtm1KPQwJ6hRmwk/t88Hz0zK7MVAd/nt
	aLJB8GW51EcbkDFRiD3Ib/IHPxQJfEExsvbzD/rtE3acwXwU+O0WLneNyciz/cDcJ9Kuu5MXCWc
	7T3IrOgthd/spqr05JKh/syRiMUeil28GVmhj2pCE43L+ntpbXCjqregPi3ZGyuWGwv+Y/ECQB4
	459IHeSFOJm1NpAyp/lisFtvl+ASSmKhIC4iNRVx4J804hT4TPuLdk+kihvEm2RZn+LGHPlJXOi
	/I64F9ApCQdgQPf9XYAwOBt/i8tmksKeO8rcMLLnMbrDFj0G5JYpabYkLKzLrilb/FbFYF+Ff/8
	QXFCCAg9e81PySjNxXDhRCYRJ3A3fve5RM0sJ/+yOTDakNuKYt
X-Google-Smtp-Source: AGHT+IHJIOBgKlL+CS0ZpKtYX5Djx07PEo4PrDI8k+TVBWbcqpi0p7MakMMReKQUlItaKRJKERuBaA==
X-Received: by 2002:a17:902:cf07:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-29bba9e8a00mr1709325ad.13.1764162769984;
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105e4csm194769895ad.2.2025.11.26.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Date: Wed, 26 Nov 2025 13:12:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <aSb8yH6fSlwk1oZZ@google.com>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-6-d7f71607f371@nvidia.com>
 <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>

On Tue, Nov 25, 2025 at 04:18:03PM -0800, Alex Mastro wrote:
> On Thu, Nov 20, 2025 at 11:28:25AM +0200, Leon Romanovsky wrote:
> > +static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
> > +					 dma_addr_t addr)
> > +{
> > +	unsigned int len, nents;
> > +	int i;
> > +
> > +	nents = DIV_ROUND_UP(length, UINT_MAX);
> > +	for (i = 0; i < nents; i++) {
> > +		len = min_t(size_t, length, UINT_MAX);
> > +		length -= len;
> > +		/*
> > +		 * DMABUF abuses scatterlist to create a scatterlist
> > +		 * that does not have any CPU list, only the DMA list.
> > +		 * Always set the page related values to NULL to ensure
> > +		 * importers can't use it. The phys_addr based DMA API
> > +		 * does not require the CPU list for mapping or unmapping.
> > +		 */
> > +		sg_set_page(sgl, NULL, 0, 0);
> > +		sg_dma_address(sgl) = addr + i * UINT_MAX;
> 
> (i * UINT_MAX) happens in 32-bit before being promoted to dma_addr_t for
> addition with addr. Overflows for i >=2 when length >= 8 GiB. Needs a cast:
> 
> 		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> 
> Discovered this while debugging why dma-buf import was failing for
> an 8 GiB dma-buf using my earlier toy program [1]. It was surfaced by
> ib_umem_find_best_pgsz() returning 0 due to malformed scatterlist, which bubbles
> up as an EINVAL.
>

Thanks a lot for testing & reporting this!

However, I believe the casting approach is a little fragile (and
potentially prone to issues depending on how dma_addr_t is sized on
different platforms). Thus, approaching this with accumulation seems
better as it avoids the multiplication logic entirely, maybe something
like the following (untested) diff ?

--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -252,14 +252,14 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
 		len = min_t(size_t, length, UINT_MAX);
-		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
 		 * that does not have any CPU list, only the DMA list.
 		 * Always set the page related values to NULL to ensure
 		 * importers can't use it. The phys_addr based DMA API
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+
+		addr += len;
+		length -= len;
 		sgl = sg_next(sgl);
 	}

Thanks,
Praan
