Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104E145B11
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970894; cv=none; b=dTSfrIi8IVFy41lzvDJFM2dMULqYAY9RdqtXIf9GnLi+q9KZQGe2kHSzqn30RfjAVXXiksbSExlbJkTpHYBke51Z4ET1MpWTBtwz89rM59Jf7aVLsf4GIH5J2jXWHsD4ptDsK2FzUYV+SMfBL6jkSrUZ9bdyUVqyZvKeTluIWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970894; c=relaxed/simple;
	bh=ASIpMrAC+mByzdrQ5Zb07sCc54XQ+GfbRmFG4npeTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc5njmi3y5v/op6DJZjNxQTHCFpVro6A94RG0FxYHw1citdm+dW6Gidjbbvg7e05OjWj6iK+v2w3Xqbw7q5yAxbl/hHmONAslEVYklZblle+MZcKjOXLo13sdEds9bkDQVRZy/JwcUCx6zd+qGXLtd1+VIvHRWvqaD32Avo2g1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oL4pJKgI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oL4pJKgI"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-920f33347f5so226430285a.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970892; x=1784575692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
        b=oL4pJKgIYISyvEOUNFcsuwfuyD4Ral6m0gx8X61BT7+0eJzfb8U2ooDE1ZywIPKBAu
         BlDmsJnjtw326YEtJRvlfA3k8WzBUMeeVxo82sNQwcHIAIKzmboQfOR11CtLJ17vhHJs
         Cjrrk+cEKdfjbQnS7Fd1M7aHKEx0bRvw6cwaFgg/bx//Q1H1gwBeZITJ3uecXaw3qtxP
         EbhshjpTh8RKbO1c2D3UaSnbKwP7gaBsIVtGL3PRH5j+NChwFILEh0rTPfyLqZlAMOmE
         ezk9lkIekScvNXLFKR71wk7TZGwIHmQPdjWArzgQH7f7y9Bzh+0LNs499xO0IjMRNAcL
         IQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970892; x=1784575692;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
        b=FKnsPx0A2chSEdGMxguiZEmoHIKSIcDRIgW8LgV/V2kUYAOby8avw5tt/npPyu3fXc
         JSoX0zYCTPLzwrd3XefNPWL/IkuY72gHQZDMCe6DsuS93zTJxE+jXSx77gSWYNSpuOgs
         UnI/rcSp7Uba+X8bR0SM8ULOzyqOlNmBJCSg8S/7V7pjzqjTFEBH94DS4s9K8licHjYw
         2Zoez8bmG9xon72Un+1Q+87wR7qzQq9jLDljFL9QUzcmXQyvbKzRQ8ph1noGW+txW5Ze
         zK4C2Qi1zSKJfFBzyQyelzvmB/O9N9AEozCIZMGWufSU7qI+C1GwZWrEfz+e318x2kvU
         cZsw==
X-Gm-Message-State: AOJu0Yw044zWD7LOv0OSuMry71g6Q40w078EBiDBQlCn+3m69D63Bokf
	RAJbD3wPqMay6oXP6djkUbkRmXNQNea8DIa7mMnP2eaZb6piDQ1boou1f5Kyau/9wAT2H9mCVax
	ZfW/E
X-Gm-Gg: AfdE7clvI2MpEzLkWmEh8XQAAfvoVz5dTtjd6F4SMRgaSA/grv48mvLgeex9ShZGQXQ
	Ggi73kNWPMHskLVkKeIUNRyl6B+j+vY6KMugjfwIGsqKpV/uB5CWpCdB+knWStWgCcdN+If9uw0
	Rs8T305q5pHXzalJS+VYQLoGX/T1pPHytp/0qEilXnom4gVULb3HKnaGtKPLBVhble4Lkq6v8Ph
	ZWqZXoNdcVk8cdXLyN3LOLUCFc5cJWuGIsV+r11wGt4F0sDum9MBGFAfYAkmtDhWqmOMPptAlH2
	od1a0yDJTT8QYHpUzmkHrw3tqwuwCNrBODnst8zsJJz1QyN73yiToF4/Ja80M666YQLHfwzyheI
	t9Gb2j3Z3YYAO8dvKJZw/dlwXqYGMGxaKDEyjwVg5HTwNEj59nlsE6EJ8Eur+vPYp0AXDF94=
X-Received: by 2002:a05:620a:2616:b0:92e:4a4a:4478 with SMTP id af79cd13be357-92ef2b55ebbmr1041396385a.31.1783970891864;
        Mon, 13 Jul 2026 12:28:11 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm137804776d6.21.2026.07.13.12.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:28:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMK0-0000000E5Zr-4AHb;
	Mon, 13 Jul 2026 16:28:09 -0300
Date: Mon, 13 Jul 2026 16:28:08 -0300
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
Subject: Re: [PATCH v7 15/22] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
Message-ID: <20260713192808.GU3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-16-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-16-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:19AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_capable() about DMA_ATTR_CC_SHARED so the capability
> check can reject encrypted DMA addresses for devices that require
> unencrypted/shared DMA.
> 
> Also propagate DMA_ATTR_CC_SHARED in swiotlb_map() when the selected
> SWIOTLB pool is decrypted so the capability check sees the correct DMA
> address attribute.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/kernel/amd_gart_64.c | 30 ++++++++++++++++--------------
>  drivers/xen/swiotlb-xen.c     |  6 +++---
>  include/linux/dma-direct.h    | 10 +++++++++-
>  kernel/dma/direct.h           |  6 +++---
>  kernel/dma/swiotlb.c          |  2 +-
>  5 files changed, 32 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
