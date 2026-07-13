Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A8346A07
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970557; cv=none; b=s4TeoZHPNSnUawdIJUuw0pSApjp+sEiIJlgSnAEMCaE5ijEw2peuGBmKFPyqqoG4VgUe75ihocBF4ZQgnyr9DM9nFE94STBfP3uuYSGhxacneekKWBVz1v0FLnmMzY6CPsuy7gtN5QgJvxHJ9LL3yRVfGtHKu1XX3xbW/PkrhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970557; c=relaxed/simple;
	bh=KcyjZz0/U3mbq57knc0VdAahTqdco+ieDuECz56azZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKMB33/1FTwY/nTgHU4QlIbY7NwFLliRDd1Hplk4Cl0TM5wvaJfd9WQIBKZzeRTwuMmzvNtBBqMCk3slzudxhFpwP7uGWgdUA/giu/upLUbXQEn+XDh17IJcD+CameIo5A4qgRxR81q8UI0gnPyqy4Om/jNj32S1qruzdAk1hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TVL9VKDI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TVL9VKDI"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee88fce572so2383326d6.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970555; x=1784575355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
        b=TVL9VKDILFXliP2PaafX+9FpAYmyH1rr1Ab0wzTcR1RN2fLPcPg3JAQqVwwyGafAID
         NanEm2avl5YYFVeVpe35XaixKgI5eQZ0r/hO620ve8P81RrCravauHsKcSkjOXqvLqb6
         f35MMvFvKQCGUKx/iUt/GD/BOVKA21jFixkpgXUBxqST2qpZO27BgkRIMP2dmMKXcZWe
         IlNYDXxfXAKTF6nl9WPz5m4536x1I91rA7uUIkPOkGd77CAQWrcxx4DjMgYoqCG1bpT8
         5tU+BlAjfPHdvVxeoRf0eJ+KDHsXR54Qjj5xNl90E6RjCzN3tgB/p+c5d9PXsdSX16Kz
         wj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970555; x=1784575355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
        b=ZSsksTdkxhjh2YJMnGnNAPw7fC5F2q+9vXD2Q/ywbMuriNvEd3kS5WrzVtWaLJpy4/
         25ooypYH93Gky6T3yuvb+uHM5sj7+CSYgL82SOJ7rb5BqPddhcn3wkDIsh4OhGcppL/9
         ZNzcCmCy+l2PPHt6DBV2mWTWq6YOQViKt5jPu0vxFpRUV12S/iH1Dof52i475EOUSy5C
         VEvp+UD0Zc9zPb2WDBPS+CJnmkCVYbI5WbBv9qpHEDaK/rtp4Ip95SMRCuCe1yV3QcUZ
         PXvxte5iPXAyAF6tbSv/k79PpjPH6UwlADyQ+GFSUTU6PDvgJ3HQr1uRpH5rwyCA6rn0
         OXtg==
X-Gm-Message-State: AOJu0Ywn62hnyryo7U+zFCKHiYjf3W0pJ4yEvFfjiJG2XNAa6IK3PtPc
	ulyz3mlIoAcXUMMm7lX+lS4UEcatIGchAFRhlSxGpn8Hndnnh/mZayFzUe0CeitSSNQ=
X-Gm-Gg: AfdE7ck/VHLaLTwtxeKbctkVqH9uuzyW/zjHcHBqtZnst+nhH5r9e4pWP6X8RKfTNBn
	igtTlat7UmnsZEtxMkHpjda6xUAJ+wWZ1FdDkAd/ICyMKjZ/elOXP/Q3suO5o8pXO1udNHs6MU/
	mA6XK05nKk0q2+18TqAcfgEHk4WMmOiWyD5HLMN27GFiIHQ1DLQh8cdBDB03Vv/R7sRhwauQOYQ
	Kdl4qROs+MSD8Oz9d8wgeb48OShCJ8fBLpdUfU3vhpKp55wS1UPTjFEn2Iv5jxaUofZJ2xDdwwt
	xMy74aTl3ILxjZGCNBi6UviYiLr+BzM5LsSF617dHmPZAGdH+Vann1RYx7HsSutLaA0W9P0WdzA
	wFC6KdqSXhHcY65374fC5fzH5UAEla5MC9GyHdrYGdGMG31/qVN/AaSPKCnA47/WSQ7Hwt2c=
X-Received: by 2002:ad4:5caf:0:b0:8f1:2607:ad86 with SMTP id 6a1803df08f44-90400b8b562mr134619656d6.4.1783970554874;
        Mon, 13 Jul 2026 12:22:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm138736336d6.4.2026.07.13.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:22:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMEb-0000000E54I-3Zkq;
	Mon, 13 Jul 2026 16:22:33 -0300
Date: Mon, 13 Jul 2026 16:22:33 -0300
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 12/22] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260713192233.GR3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-13-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-13-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:16AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 
> No functional change in this patch.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
