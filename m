Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81D1D61BC
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777208735; cv=none; b=tmOzACLalBCLL3s3wDb9Ein1quLGrJA5NbV6TUljbtoCYGAtrkLYvIH5jR6rYwTeV9VeTYxyp/amjWcixqSgCp//xBao5I6SIkfgQ1KsW97IrB+YwudGYGGNgxaOcct2NBgU6irj7BZ3FkyxHovdHG+o4KE4bf7bg94QL2UjTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777208735; c=relaxed/simple;
	bh=p372NUN8mpdPi0B1Wv7deQ9himnMrrfonWh6E7CqgbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkWRLUEu+JXUXjN6riVkuvylzLUfXr340H6CXPNMUbC4xPfos3GvNQLxltciE0x62EGUnQp/gIlkqqhjVKYp1WmjvO3LxAtGvHl+XEUN5Dhyo4qXJgmZiSsnFAPpXqtAnUwdNIo85dpOk1MEXDi70mvzF8BQKEqOVzaICK+PNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TIe5eIvG; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TIe5eIvG"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6221c7251d1so957400137.2
        for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777208732; x=1777813532; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZgLj8cyLE1pTCqai3ecepNuqq+WdEKm5C7L8MuPHFc=;
        b=TIe5eIvG4A/C00wWfFxYKnk9q1afjlNem9itLYxjx7QdMXHdmyzmfqRIzaE9v3JvB2
         E7XwzbsB/IoISgD1f51siuNH45MdtPFWfJjfCc/4sM8j8BP3/ppMAUa/A5uMuRRF1yUe
         ixTluRyVjv9thcuTItAeIOGlaDhr4sVQ2Mzw4FnAAj6XqimGm0N5HxD5aD1y2BVhBtNM
         Iju9MNhrFDuhCzu2VJDnvJqwDpZt88hnkL9o6TzE2isM3yGskCM4tGTRyj0HmJ7Ydtz5
         h2WQjWaR0e+m5zdIMQS2YGoVEYWiipn6gXGakszjyaBoido1T3aVe7hWymnO7GMmNTsC
         pAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777208732; x=1777813532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZgLj8cyLE1pTCqai3ecepNuqq+WdEKm5C7L8MuPHFc=;
        b=S8Y1wnPaUowOtzifdkY6WReAOg2hupCjalluD9Qj01/KRnn2ZkBd0mHbD0xiW0fpMe
         FtY+yc6HwQ+ZCbamzHZIl7n/jNqzK2du4QIJjdbq9u1xUtCP3PAlc2Ka8wR6nbnDC2YH
         l/8Ttdb94yIsiXRNA5GxuXEboWWHr29GsOFnm506ilHi/g3IC9EiTErkptXl/QR7Mwsm
         QmiHinju4iFsLenq3ZLF5Za6+gcMRxTHAnBzxEUgQU93hM2waeLkwlqVrr3RutWCllvW
         Z6IRBO2YPsWW6Zf1l0vWWDUNpvGBqGU1gFg/zjNYuRqNrcI+qdUVHhF5sycmRG0InIy2
         ahBg==
X-Forwarded-Encrypted: i=1; AFNElJ+vTjCczTp6TWLeNqtJH4mKRJCQS6Dj5df0BGr1ExXC1OGu1CfzXJ+l2j+K6/RwErLyLivAww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRpCxSMrYKPdyzOt4lcsK2FN+/5BfNVwjlx1lqoNQfmvFcJr7e
	o7BFTTONAG/nHdXaYkHf4U1t/AGL+X+lTOse+dmpYDv2ijFRq+upFI4+HFBjMsv0nl8=
X-Gm-Gg: AeBDietXSxoj6GXln3AZUSv4JkODJQsAyu9lWNqiUjsr+GnHi/qi7VhXFcXwd1Kb3bL
	VrSCWRl6L3XoLGeih9+CiHbgWFM6u3V67CnmfEkUsMTT1PqPIeFFDq6UI+A8s0jOJuMWDBq7/bA
	Jvmv9HPfYqcyYLHSmS3EhFIRu8VLovb48mNRrL4ClO5t9DMIbNxKlmfz49V1apuN9+x/gXOgMr7
	ogujgFbgOiPuKLf4qvwaACnRTXNCvKZduVqY5rSWP4PmngNj4EM5hmFMIIIKPUZPwI1Ot0mMZC/
	L7jJUXJM/4oFx4wV+4yr0TktwAG5YMR0JapUkgoWZW+rz/nOBoOrmdR2QAlUu/WCo5YstgLteah
	EQ8cGUHvB6LXudn378hiVXzF8wfvqpDa4R85zH4wSRjf0qHeo/kJt84giMsz7ERvJ9QHDkH1LRm
	xzLaVeqF5TDSSx4QUZiIEmWGpdjFJi5xrDPnIUx9J/bt2W00g2xtpeH/LX8lIOy6QAYUTcFQLmF
	eXMsYJlo+z1Y3cfc8f7KOSvy7M=
X-Received: by 2002:a05:6102:5e94:b0:610:1239:f6d7 with SMTP id ada2fe7eead31-616f772efecmr18253527137.18.1777208732488;
        Sun, 26 Apr 2026 06:05:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7df88sm249063966d6.35.2026.04.26.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:05:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGzAx-0000000Egs5-0CBA;
	Sun, 26 Apr 2026 10:05:31 -0300
Date: Sun, 26 Apr 2026 10:05:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260426130531.GF804026@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca>
 <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424225514.GE804026@ziepe.ca>

> > static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> > 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> > 		unsigned long attrs, bool flush)
> > {
> > 	dma_addr_t dma_addr;
> > 
> > 	if (is_swiotlb_force_bounce(dev)) {
> > 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> > 			return DMA_MAPPING_ERROR;
> > 
> > 		return swiotlb_map(dev, phys, size, dir, attrs);
> > 	}
> > 
> > 	if (attrs & DMA_ATTR_MMIO) {
> > 		dma_addr = phys;
> > 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> > 			goto err_overflow;
> > 		goto dma_mapped;
> 
> I suspect P2P is probably broken on CC because this doesn't make
> sense..

Actually, I suppose it is fully broken because it will jump to swiotlb
and then should fail.

> This should flow into the
> phys_to_dma_unencrypted/phys_to_dma_encrypted block as well AFAICT, it
> shouldn't just assign phys. Assigning phys to dma on a CC system is
> always wrong, right?
> 
> It is is more like
> 
>         /* To be updated, callers should specify MMIO | CC_SHARED instead of
> 	   * implying it. */
>         if (attrs & DMA_ATTR_MMIO)
> 	   attrs |= DMA_ATTR_CC_SHARED;

So no need for this if, we can go directly to marking the MMIO callers
with DMA_ATTR_CC_SHARED once this is fixed for mmio:

>         if (attrs & DMA_ATTR_CC_SHARED) {
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
>  	} else {
>  		dma_addr = phys_to_dma_encrypted(dev, phys);
>  	}

Jasn
