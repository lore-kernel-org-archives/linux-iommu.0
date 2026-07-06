Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2A396B98
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367532; cv=none; b=Azy1x7FSDHRB3BCGlnrIjqHiBacZyl0ofkpQiaxQWBV3TVmBiu09VIDEG3geCLD38OhoVPLbU4Ts5mA5zloYhJgUrLaHN54lcCnvO9LU442uygogLVtO7N1wm305AVNAQHwuRIW/5d5IBaS58Zm1jfq6gbg/8Rye04up8HD0gYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367532; c=relaxed/simple;
	bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e569PPRgR1nmP25RNI7poddrFSGuXN+9zvNOxo7QrpWHi2F9DhVFNrvcazhJiD1LXTmK6MRatns9zWFPRDKAXZBO+E+2pBcjaRuK3FuLsaOZ6M0ZH3vPgS9udIpcQH4Lq+uX4TvevZrxwrZqmgxDMjTEcNncBB8udPArbORMeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gaq7WZT4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gaq7WZT4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e4fd65b2bso173603185a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783367529; x=1783972329; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
        b=Gaq7WZT4lcZ2NyQ9DQCuP98fTk9aYKluCweY/nWI7H1vPKvCLPQRD0gfYrsI5qt7QK
         ThN8gWRsHJrZbgQPagNtKun/Dc78w8ezyURoewtRbFJr0tyfUvrO5SrD4yExD5qkeMeA
         hqXgsgdBO+B3Mth//on47mpyIanGAHnPVvjtWmFuH1Z6WW6kius/kI6uyGqjt3UyWby6
         ukf8VLo2BkQVeVlJzxKkIXG9eVKYPShFMIRODPebarwfmTH2Xc2PcuOpePY2oLgIvf0r
         D0t5zXxCGtOQ/aI1f+fIGMIFJv1NzvjqhIsEcHWsecV02EbVouDlLi2f2TeGgJ02c1n4
         TKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367529; x=1783972329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
        b=NJN4VmlLmklvn1qACiLqL1xPt9arSlFc6/mB6YJgVgmbSZQk9KC2xoOGBwhdbu/Q/+
         6X4L8v5GpSz+hNtLngOksoqs+CSyXj2zdB6+BLoaslOl/HyY5UEtbwyeTDcA19HtDL9g
         bC8MAPPcoHyW0VEnrjsP1nHg0sIwAqkpwO+ntre8eiEfc43tZlaz9hlHHyLDQyiVNdZq
         b+v07NLHdUVCnQ7EvuzSV89gzW6XE4F/lN01JqYrGTkqitoKeG4PQsDlg2Nr3DlGdRe5
         nftwpmMM0MeHqcOlBlh+dMduF/IPTM7cRiKIPOgXQyR6M01wcZj5z7d65d1WHtC3OFpT
         yj6w==
X-Forwarded-Encrypted: i=1; AHgh+RqJ4RLdHaTvTUjtun3l1O1R7Ggulhci7ivowA+lAI54ZMQ7MhnK6i+TsdTNSRyD6nccPhNqLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGaSLiJLk178xy9XEHmJX/t/UhUYTokGd0Phr7bMqV12KxWb2L
	otzYND9iXG4IG5g+sFtDuOX/Nr6tdKVjm/aiezRzh5zhzWCqWAVif/ljat8YCfVfhvA=
X-Gm-Gg: AfdE7cmDmr2O6FkNp3pjfTmS+QuW/Ms49xLnchDJs2clSygwDA5bxdN0Lp2ASXkzSES
	48/McZ75PsRGeW8RpgLIREyQtINTYyk3DpTmJz9mhKBdWVu09sMS/2bQwiHrfx02cVpBYpNhnSP
	Pkvjxa8DRXdxHBi+/KlpEiwNQ6zxV9EhakJ4QzDMzUzzpiCEXm8ac9lE1uGRMmbgBDHx8NkZhub
	84WDKfxlYKGtEfR7Wj0+y0sRQCoMtXodZdObwR5Jwte6b6bWcc4iMjJtVTCkpjgu8hpZt+1i/0/
	VcQy3+XNJsrUr3SrrgR5KX6CJjyXWsI83c3HvU26ihy6HwiMpKptNgEecpIXhVzUi8weESO/KI4
	MW0qPDG7KjndO670w9tYGchTn3OD3Zq9gvo3z6Sqa44i1eK2DXSUbcn3NwDOd
X-Received: by 2002:a05:620a:2911:b0:92e:70e9:6865 with SMTP id af79cd13be357-92ebb585521mr281465085a.59.1783367529434;
        Mon, 06 Jul 2026 12:52:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm972606685a.4.2026.07.06.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:52:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgpMO-00000000etJ-0DJM;
	Mon, 06 Jul 2026 16:52:08 -0300
Date: Mon, 6 Jul 2026 16:52:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260706195208.GD118978@ziepe.ca>
References: <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <fd135adc-a8a4-48e5-b649-2a29789b22d8@amd.com>
 <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>

On Mon, Jul 06, 2026 at 01:45:33PM -0500, Tom Lendacky wrote:

> In that situation, with SME enabled on the host, the SWIOTLB must be
> mapped by the kernel without the encryption bit set and DMA addresses
> must be provided to devices without the encryption bit set. This is
> because if SWIOTLB is mapped encrypted, requiring the encryption bit be
> part of the DMA address, any device that cannot perform DMA at the
> address width where the encryption bit exists will fail to DMA properly.

Ideally there would be two SWIOTLBs and "decrypted" aka low address,
one is only used if the device requires it.

Alternatively we don't support this questionable security choice and
using swiotlb with an incapable device just fails. Use the iommu, or
don't force swiotlb.

Jason
