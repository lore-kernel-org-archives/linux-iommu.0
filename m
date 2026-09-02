Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011793793CB
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371168; cv=none; b=ge2WBcTUl5Jt4EoijtJP48L2tVWK90Ae+p8p2czzaGq8MRv+mM3s6CNQ0OZGJ5UeaifAtPG9T65sdBWvqfcSlsn8HhJfftsqiAqcSmVT9lK5o9SspoD8e2rlXqgqYRQQA/ok1Slx5QmqNPZObWH7RHPg0XeA7L81oUQBlCehROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371168; c=relaxed/simple;
	bh=ukYqhyi0RGuOSajWaOkTQRPODSNPDMI/uvdyQNdZhaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW7uLA6hV4gm9XULcwOaHltkiqjEKD7GG/AzEIY3lQbAmW9mSbzzwVN77FvSCm36xsoDNEpxiA3vaVPAILYHUXQ1br3Sdl1pnJi0j9103GRdveap+fc0IdyQp7hsvsFED+vbtvPLp+QO3g9ntGSBAQ9k4bVvDZ5lRUvIWYD/Sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GmYXSRcV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GmYXSRcV"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90f9f8553e0so9870016d6.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788371165; x=1788975965; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezr6Kp9rH9+35ejy6kYQ0m2wIG/3JEQzG3offk+MEvQ=;
        b=GmYXSRcVUwQTkjQA4O+PqHuBPowf+beus0GXQwfUoJWKx1qo7+76GPDVv7WSoZfQ2t
         Ea0f/nZU4VASI0cC+4v6z4CD21OKMb0PeodejUUpkA6Ei8MIUZ1EuC6Jit7ixBOi/BvX
         bH9nF0GTnsCTbFgN+U49j+mQUTUKGJSwBl8XBczL9L37UsEzHnUSXBwVmFFivk02fjNr
         nX6Lu5JOti5eAlJTpDO0QyEa3VS+KcttrJXE34mgGg2raluHIl/x5yQBA2wXu7zQs4UM
         wiYkm1YuSrI1zz8P8M/Kyhla5JU8qY2KLLPtUr70gWteBxFf3CV2zUvgcU6d/vQhgZ/B
         PGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371165; x=1788975965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ezr6Kp9rH9+35ejy6kYQ0m2wIG/3JEQzG3offk+MEvQ=;
        b=UTnel74EI26U6h7+N9LZjVvHrm11L1FSwBACHLdHYVOWaATPM9L/gI5qWeJRKEbr8N
         530dwf5et7nVzucXtdCd/ky4CDX+v8pHqBpfuvC7bFDVknb40FUSzwsxsclKjh4jFUHA
         CwNnOAbOTKWAY20Wv4BQOzyotcCtObyaL1xSs5Rh5DGd8m5Czs2yWCvJyf+gsFMKOfeD
         VgohhV+1Vhlm6inMika+17Y+kSAgvdzvwL3aPhiv1BCufYu8V8eZMNpDM/WAgWXJ3B0+
         7J5UB8VLvnmj3WJF9RaoAgOEvWNw/YSkNx2XtntSQadB5oLKHZeNglSIZ651aGNIJhYY
         Parg==
X-Forwarded-Encrypted: i=1; AKwUvBx35cR0cKfmOXA0vFmCYpF/lnOy/rARFTtnLZFhy9YjF6T1mwKyB1nTKjH0chXTMHGWVDtrHg==@lists.linux.dev
X-Gm-Message-State: AFuF++mvM15LfCE3N2NGFpvxAZwUyFqVlgWpXfr7k7G2a0JxLwhCGIo1
	VWrqasMC96sHRpOVJiqt+UHcifQ+0pbxngj4GhUCZJCu5jkWVB8XPbSiMc3DSElQJr4=
X-Gm-Gg: AYBFou0RrckP52B93TgJIaj1zEN54DGVSB/cGzqiBs54aM92jSVh7K2NnADKqCD+9yr
	x1mAig4XweiFVVEWv36r1PzWQpF4bkik/ebIF/ngWbObS9IxtFZ+nPpdgH7sEDkET/7EYduAJNi
	ed0HUfy2lGVLSDNDBfosFkXWHiY4d0/hwkSa6SJxZkW0V1tJX9ZwPkV/Px5ZKeUk6o+lKtGUoio
	2TncVFOTvfk2tzfufKCnpbe911criGLhk4F/cPB8kqVaZ23UXh5g+7yA66/tFYHw0X+p5Tmcw+V
	pQW0ZKOJqIQeo14ggnk7oywmHL0L7HPi/hq3K33B82nLXanNm2sVAfZh0JFdNydzKBIQeT9KjzB
	+k3NUACMsRmkD9re5szoaK2CYx7cfNF4ONHUThnKEAUSIMMthwZ+ovtXnKv+zefGz/lbJJBgCgD
	sLLl0Xow0uViRbwUn2IhfbyiLg71zzw4znPVY37G1LrZSZMyXP4omEMbRiC+naienbv+iEMDcsB
	hmd3pG/FKzjUxLqR8FiYFD4Ssvr2jEnLzVyrNSS8U/4lAsvIzDEJyPO
X-Received: by 2002:a05:6214:2a84:b0:910:3453:7d8a with SMTP id 6a1803df08f44-91034538000mr9552376d6.31.1788371164336;
        Wed, 02 Sep 2026 10:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee41b5dsm23518966d6.21.2026.09.02.10.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1p2B-0000000Emsa-0EzE;
	Wed, 02 Sep 2026 14:46:03 -0300
Date: Wed, 2 Sep 2026 14:46:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Hu <dhu@x6u.co>,
	sumit.semwal@linaro.org, alex@shazbot.org, ankita@nvidia.com,
	chriscli@google.com, david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <20260902174603.GE2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
 <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
 <20260902105919.GV24140@unreal>
 <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>

On Wed, Sep 02, 2026 at 03:34:18PM +0200, Christian König wrote:
> On 9/2/26 12:59, Leon Romanovsky wrote:
> ...
> >> The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as
> >> far as I can see is a complete dead end.
> > 
> > Maybe you mean DRM, but VFIO works perfectly with
> > PCI_P2PDMA_MAP_BUS_ADDR flow in DMA-buf.  What am I missing?
> 
> Well not quite.
> 
> The approach PCI_P2PDMA_MAP_BUS_ADDR takes is fundamentally tied to
> only map a physical CPU address into a PCI address and doesn't take
> into account that in a lot of configurations the CPU can't access
> all resources.

It is called PCI P2P. If the flow only uses PCI devices it should
always work because it relies on PCI spec things that happen outside
the CPU.

It does not try to solve the general embedded problem of arbitary
communication between blocks inside a SOC, scale up networks, and so
on.

So, yes, it does not solve every problem DMA buf faces, but no it is
not a "Dead end" as it 100% solves PCI to PCI communication which is
still a very common use case.

DMA buf users that are exporting from a PCI device, over PCI MMIO
should be using this API. It is the only way to do PCI to PCI
communication correctly in the kernel.

Jason
