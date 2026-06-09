Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1A33F5B0
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014545; cv=none; b=EOxyeozS+b59HqbjBo+0fPXSzz1wK0xXX+9O4BxeEvB2EviYGiQBiKtOAWzTlxBRyJ8XItaUa2XY8MtOFOT2hvCdgKMN8goLcZT0+b5b4OB1T9lG2GZ0h1bPJ7ZuSH9KK3OSd4AHWBr15DzEas4zm8rpLUgrChVJe2/gw+iLXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014545; c=relaxed/simple;
	bh=MmkUJTtuyXY3s/7sXM+BP/PzWFzsXVq+eKe6PElRRWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGiCjIyJkFO9JhOW0WcRfISdZ5XF9NFdBwTvT092fDR78IecDAQIiTfT/3AGD1oQHtxDWxy32p40T6yYVFGCCx2ydKdXqYgD5hfbfudc3CIcZ34IRr6yv8is/8jwht8ozhdWN/CypYTvE5qhquiHz4aCayszrZsVnjOwSPg/kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XDPG2o+M; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XDPG2o+M"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cebfb15413so58954226d6.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781014543; x=1781619343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=XDPG2o+MXvXlYseDx4Wgvgzv6GxEgoHw26UhGJXGVVZ+xy3nsm1FXvr1z6gl7ihlf5
         OV9XhYZuJ8SmS06nxyZ7xUnMRHTF3+OaSkSWJT0YyoJccYZdot86W4QcBUsmqb/+2nyu
         aHbXtBSYgadTD91EqITjB5kCTiIoqwMrrJ/+IbSRgISRJJVCIeWtdaoitu5t6K8AfaWo
         cojJCaHdq5X5yQZDsS2uEXfCUuZ2CZ0JGlXm3FnQsaPcwtAOeoxYB+9zYbiuBhW7XSOz
         4EBAAQ6Mq+1kDR0wkj7CLbikKpS0XA9dI4p+GZ5EpM6RHjz6wv7NJM9+Hir3XNVthiv6
         jliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014543; x=1781619343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=FuWVtjWbRT43Kj08fKBnwX2BDf/4sS1oreu0tVxVf5DAf114IEeWE4d8NANRofV5mm
         doocRqC+IxJ69DI1oZ35bNJ6kngeUYLU/EgxM1Wpu8UfVeDKT3tkcFjx4uQw0CoIwYCw
         Ds9s6CNd3S7sirfbXXoAFVkO6E221Lm+KB9ROzq4jSD+2B40PhQBB9PVPGNOX3ne8xNl
         cm4eHNkx5BApqdegQmblBhMohBKc/qcJoCGR2tO17I5SfuecI24R+CafCz2jFMPCN53G
         Dhfgvc5mbB0XHi6mRl7lp/qHpLWqVgJuy7GJZ2hmh8F1eej8Q8YEG4fM1ydrEDWxkmL+
         GoKQ==
X-Gm-Message-State: AOJu0YyFss++HKqjYM3viwqIIfA3S4COkKJ6K7mwOuyiKmctI8FessMc
	H4DQL8L957+Zss0ZZRyJaKOFQlbZo/9okgdQQvg73u/KK5Z6YG4ltUcx7WlXDPS1h34=
X-Gm-Gg: Acq92OFngZ0br95vGm1nVxDSHplFHbwzQNfiiZSi0C3fODiIpiJdT3CRQ4Sf7rq9zNS
	vmbZoLYzku6DXVYUs37ZJ/Trwt3qUw41sJbsKrrzJQYU1pRfpkprQsT7smvrwAXxXo+6RBkelEG
	ke3fCSWdaZ2CFSqfdcN8KlyTSfCmjbl2KP27V1OMFm0nPF3sHyYijW5ohjuMkrRbW3u0Q0KBwM+
	xTV/4YTReLcZYf9q5xinPR30IAqcrVFDVjiU1UwWiUxmeoj0Fo8VzxvfaoAVX3hTzUZdcToYZgn
	AMw70G9bCjl7dKkn03cKIMHYkkE+TjRNA5yQ/7zCK3MdD8BZ6OahbUl3i6QFuvcp/SZt5y+/mT5
	QcSMt2wBQ/xaUUIKlsA2CD7Y0zFq2EEgZ1xMrVrQrqbO4WLgKzyMp9MplRGgj+ggLI2fpFGiYGK
	lc19awdLKyLgIYYq/V1MMF7Kiii9wgdDUV6L6smh5K7vdb9nfJ2pejaRbdlvcOMfrIThe9g1oOb
	E3EB3HbbnthENdl
X-Received: by 2002:a05:6214:626:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8cee626f0eamr293032506d6.38.1781014535341;
        Tue, 09 Jun 2026 07:15:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm204702746d6.40.2026.06.09.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxEs-000000021xL-0mOX;
	Tue, 09 Jun 2026 11:15:34 -0300
Date: Tue, 9 Jun 2026 11:15:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609141534.GJ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-15-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:53PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}

You should probably put this at the start of the series so it can be
backported

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

To Petr's question I think this just shows nobody is really stressing
the PCI dma paths on CC VMs today.

	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

For instance the places even calling dma_alloc_pages() don't look like
things people would use in a CC VM.

Jason
