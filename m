Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D9357D0C
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971585; cv=none; b=WaC0L5wcPW/d5CihP6H6LvBRRTHXbWGtzQPgcxw4DAcKzZYtegZvcpMZbqO1JvxY2F3rmZSaDMtR+yA8+Q0FD1m0fxEdZRL/05ajX6H2U4GKwFCuEdoolpDSRIZxs+XLwi28iqJYzhVKq2XQpnoVv184wxbOU93WAmiD5MrPTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971585; c=relaxed/simple;
	bh=6ObL/bIb2BF9Fm+HEWevziQ1Coe0QkELhGyBpHyDwZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unVGthz7ADvPlclYw4xIaJAxC5pZ9ULA8mR1kYH2nAMcm2yTfiC2R9R0m4omUXx2qabGkkwLeZvvJhDXlToU4xWfQfpIl6cWAtuzLhaznE34mzuHCPj6Ya10pbtfG+NCI47boZVZe26tzX+AypNYxKD587WPu+DIMxn6C8Jxzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NO/3ybPv; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NO/3ybPv"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efcef23d21so31547646d6.2
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971583; x=1784576383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
        b=NO/3ybPvNWMbEG/xIVeSH5OgAl3LgFBHDsGdtqAkRHnA0w2hmMlWerbtTmYxwjD24x
         sjABuM3YonyAYJljybB63/Ohf40quEQlGJGQOYdu8WGclBSC7zQRmyiAl2keH19NoBY5
         yplsbamXo021O8Zpz1l31qGTKDtzfl+Q23YIqORiJfGNDmsrRbEmoSD9kGOqgEOjg9v1
         chdemy4EnB3CHTjFWiMhspwqC1U/u7siwCig0d4hAqkzJ9ZFxHGlhnBlfhzk5B2sut1s
         nMtH/JSZBU9e8B9On1LDRMhPaf0+Fh9STBt7SahH1yPq6bC1Ux6G6h8je2nB8oul5IWL
         svFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971583; x=1784576383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
        b=Xiv5AV6IPkUQMF99MH9FVJDCBqPt63II2huAlryDDFh/KJeTnP92C579ZciJNOoPWV
         9YgWXdfDceJSbXPUm2FV38YUEcJZ9FLYsI0koCzwDIxYbnSvQcvEUkGrxjtRxaEzJqG7
         debCWk/FWxB+8lEcWogiKVymOJTrjB5fLOwIRccb1B2yopvmIeLLPPAHwEX2RiomOyvn
         JwhHPXAAoDlQ7yQDMZ4hBZEDppwzmxkt43/49wXecArPqijFo7KaKFU4PzVWsbbZSlhL
         gtDta5EgF9KYx2cXJiBjNEVjxrEX2o7UKGvUJyIc86kzOYmuU5anlJAZOxIpkmnvXtZI
         IQYg==
X-Gm-Message-State: AOJu0YzQMeXZM0Ry5GOwlMHTTEWcHGolTkD2V0a+MHGVG3DVxBFvlLXy
	pufjq+a2f/tmt4p07P4/VP+KxXZidxEh+MA45TfiNkn6lQis28PL6mHMbqxsgkZE/VY=
X-Gm-Gg: AfdE7cnwXH7J8T7f3Bribgky5wzLGNawclygnUs9KnuuM1bvss01KWKZwWh9GbaS8eU
	DtPYy/vZexp4+zdlUWQ8YeQPSabe5oYn52NtRWGL8jroqsztpk5aAuJ1GQaKfRJ0ibASuw4l8ua
	nB/wo3ZOCCsrNByfzIufcfSM0lcQnK617PEAUJtkTwI7+SLv++BDWlFCBaGFuVSsW11PDMTlbq6
	oEGbC8MejLkqLSE2PFzkwnSpnsLGjpWnZeF6K6LyOzSKpGaY0shGWwITV3XhdpEti9n0CQfz9FY
	HPxHrrWjsUQsj7rwRlX6+opiWXldF/9GE2W92kfhjbvBtg0/xuZhHXBTwORZ8V5/y8R/XcturCJ
	DaVeXOK590P3n5/IzPQYRF92dAaF0kxpI0gQuXPI27KbsBwjm6s9jwwlPLsQc
X-Received: by 2002:a05:6214:4c8a:b0:8f1:3533:7a83 with SMTP id 6a1803df08f44-90402c68b4dmr105755746d6.33.1783971582552;
        Mon, 13 Jul 2026 12:39:42 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90725bc050esm20419156d6.28.2026.07.13.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:39:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMVB-0000000E6bn-2D9o;
	Mon, 13 Jul 2026 16:39:41 -0300
Date: Mon, 13 Jul 2026 16:39:41 -0300
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 18/22] dma-direct: select DMA address encoding from
 __DMA_ATTR_ALLOC_CC_SHARED
Message-ID: <20260713193941.GX3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-19-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-19-aneesh.kumar@kernel.org>

> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));

The !! isn't needed when going through bool, the compiler does it
automatically.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
