Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403A2E36F8
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506980; cv=none; b=R/zudZM1J3KZ4uZaz0tz+aR4nTtSpuy9Qt9CUz8iQI3FckiwLH66eEdENI2CA2V45R44PbPPmdiqTw/X3AR2hhT/lKOx0Osh1IIzjVcP6u8ccvZtCdkhAK96cFVhlI/G9cshi8yb7oq0+gbT8EeAhpcJLkpOpEoRUoqaVEhClDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506980; c=relaxed/simple;
	bh=scFNZX9ag0i6pgwb7zn5W5v2rOxL4+aniwaNGa7QpTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KADKcV6pP3s9DecWPI9W3Ufgs4OvI9+W89s+LcbGqjh4UEugEmVfoMfkTwpF8UI1BDgu06LcG00YDVv2A/BRgyVPToCNXcHCl3BBE0qJKM/cqxhDvfoXKQmByzSU5jA9Hha8wNM83k6Q1KYV3l0SMabJcWO4UhDDQ/pz7QTe5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ny0mbUF8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ny0mbUF8"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2dcdde698so502966185a.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 15:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763506975; x=1764111775; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9774m00qC+l22EqhxH404c/5WuwECoHlv+7tMAloKg=;
        b=ny0mbUF8wagyaQUF4F1Y8hRcjOF85hRO+MjASpAzgK6g7RzSqlV/crJ3SIkwqmyDqi
         GKcsvWySpjojL7exHFumCcChOBcnsIWdzNpNefCdXoc1z+De6MkuR83pFGqeOAz8Ygf6
         Y9nx1c0Abn5rJS7QrdPEN5VAabsN0hmCBAOJ9QG+wPHlTY3cAG61oR3nsF+hctIHOM1p
         /bGYcXB/iHGbIu3VC+VtFckhkMZ12qgTpD1mjsVUCGfZQKnB4t3CbVBLUIsnJE+ALwT3
         Wk3OlpNurvgcvLH3JOjN7kZY19agRWAmgN3X+kLlH0mhCcLixvfyndO9oeA8LavT67oZ
         EZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763506975; x=1764111775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9774m00qC+l22EqhxH404c/5WuwECoHlv+7tMAloKg=;
        b=wmJrhfpABCV5gkOgGXkBlqyTjX0as3PGGlGPe2w2MWxVbG1lEPB7Coox8ztdbgtoSA
         qgd+qQRNtGGejLl9Hs87r50262ptMTg2xpA12TNyzSSepQdliXLLHGGnwHxWUYR+LT7p
         kw7ZtCvoWRc22JRvz1K+iPknBCKEj+20iceErEm2mKavPdCVWq4JPzt1Z5QOMf6ZJDY+
         VNnkbNI/nAjhBQI+2GgXAMATh/tN29W673cvugc+ndlbNBbfRV+PvJGyzb1mgFzMqdkx
         MP5ini4N66o9ia7B/BKp8ldZaDX2RIiXMFuKuAYhxqynxcyUTkqrKsfydZAR7Oefvd4o
         j9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVfS0FaAGmX+IrRd2jSEpu6UpCikFsnJDw9c6DWxjaLEhAKuTlqr/qnXV/BMW2iBCWQxs6WAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZy7VoK63t/AM8LsNY7FkiphQAndfcCXGiV+Toe2Q8W6amyAq+
	OtBeNwFhM1LF9H7O/qMmIqdjniYSAh6D5obPrLvx5866Ovgfgmg1+kSjgCMAO6Ptu4k=
X-Gm-Gg: ASbGncs7j5tM8uQhazlro3pGXfC8Qnycu1dmROeLZPnkRRqwdoIr8dmEeeAvG5OZsat
	nxBF3Vc2vrnBUBhGpzOiaGiMv/Vaz3CKdRYvr4A3EdjqRflJX33iP2tw17NfNrA1kKeRfljDeko
	UQkhOraPCrh/2t3jpFwuOd0nCTd4Z1teB1Y/ZRH0Rlko5Wj8Ekn2WCttmosNHOBtmp76C7rIrrg
	PEduoGvcu0j0C4i+UNvTmgu0SmQS70mDbL116Ti64uIKcbUIUKAkc6qqDtBgulVYaW/j8PUd7rn
	pbue3DhLa93IOIwkOtNTckcrjpCc/kHG/PKuGbIbnthZ8bZVyXCuZAeST5Mp9cZwkrkSr/phDqb
	hTsMLU5eOrmzBkFl/jdIL4KjiDlxM8x5i8RlFwWFshYMYVoudobx1vQRhg/OozDvCMNC4Vl7wCI
	3xBLXNTWbwwvX2RZ5VFFsOYVUDgKtiFyWkgacCWS+gVf/VMOhCgBmWNY7f
X-Google-Smtp-Source: AGHT+IE7qxNdGTB3O4Cyd9l/l5kqP+7hVSaobWOJQOGThUG/TNMz01RlkEIy242KlmPT6y0A+36Y2Q==
X-Received: by 2002:a05:620a:4454:b0:8b2:eab0:629a with SMTP id af79cd13be357-8b2eab06506mr1265910785a.70.1763506975311;
        Tue, 18 Nov 2025 15:02:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2da3e4cf4sm883665285a.10.2025.11.18.15.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:02:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLUiq-00000000W6g-43N6;
	Tue, 18 Nov 2025 19:02:52 -0400
Date: Tue, 18 Nov 2025 19:02:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <20251118230252.GJ17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>

On Tue, Nov 11, 2025 at 11:57:48AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add dma_buf_map() and dma_buf_unmap() helpers to convert an array of
> MMIO physical address ranges into scatter-gather tables with proper
> DMA mapping.
> 
> These common functions are a starting point and support any PCI
> drivers creating mappings from their BAR's MMIO addresses. VFIO is one
> case, as shortly will be RDMA. We can review existing DRM drivers to
> refactor them separately. We hope this will evolve into routines to
> help common DRM that include mixed CPU and MMIO mappings.
> 
> Compared to the dma_map_resource() abuse this implementation handles
> the complicated PCI P2P scenarios properly, especially when an IOMMU
> is enabled:
> 
>  - Direct bus address mapping without IOVA allocation for
>    PCI_P2PDMA_MAP_BUS_ADDR, using pci_p2pdma_bus_addr_map(). This
>    happens if the IOMMU is enabled but the PCIe switch ACS flags allow
>    transactions to avoid the host bridge.
> 
>    Further, this handles the slightly obscure, case of MMIO with a
>    phys_addr_t that is different from the physical BAR programming
>    (bus offset). The phys_addr_t is converted to a dma_addr_t and
>    accommodates this effect. This enables certain real systems to
>    work, especially on ARM platforms.
> 
>  - Mapping through host bridge with IOVA allocation and DMA_ATTR_MMIO
>    attribute for MMIO memory regions (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE).
>    This happens when the IOMMU is enabled and the ACS flags are forcing
>    all traffic to the IOMMU - ie for virtualization systems.
> 
>  - Cases where P2P is not supported through the host bridge/CPU. The
>    P2P subsystem is the proper place to detect this and block it.
> 
> Helper functions fill_sg_entry() and calc_sg_nents() handle the
> scatter-gather table construction, splitting large regions into
> UINT_MAX-sized chunks to fit within sg->length field limits.
> 
> Since the physical address based DMA API forbids use of the CPU list
> of the scatterlist this will produce a mangled scatterlist that has
> a fully zero-length and NULL'd CPU list. The list is 0 length,
> all the struct page pointers are NULL and zero sized. This is stronger
> and more robust than the existing mangle_sg_table() technique. It is
> a future project to migrate DMABUF as a subsystem away from using
> scatterlist for this data structure.
> 
> Tested-by: Alex Mastro <amastro@fb.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/dma-buf/dma-buf.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   |  18 ++++
>  2 files changed, 253 insertions(+)

I've looked at this enough times now, the logic for DMA mapping and
the construction of the scatterlist is good:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
