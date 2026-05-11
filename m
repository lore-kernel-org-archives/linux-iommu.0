Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374B366060
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498032; cv=none; b=Q4m92xVkQYZIQYAQRPtSoTDetAycaCfNQP/xC4m/HWVSbp3854ace6ykdC49X0AKuG/0oxO0TstG8b368G+mWVMceMJcn9AT4X6kstgxDuTiSkc2gHY51o2pQLeTf8OJHeVY5X0ghn4uvCyq7idp+/XKcszZCOrZXzl2zYolgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498032; c=relaxed/simple;
	bh=XxgqOVAvsBiqccnVAD240XyEMuriRVfTF0T3UfzRmEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq8jGkLGzmg5ew+1plwLhq2GlflxavSP5LJYAgajrHYrVejUCUWJjo5sTCC/IrDQgQPZmCghNe8U+cgrjwo0DbRXiKNbDwP0OXb4buevzFMVTGNwD+J3rIitfOoopHECtje7CEPhd09XK0bGzR3Af8tOekAsndY2ScFWbwO6jA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yh60y8Ko; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yh60y8Ko"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so935e9.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778498029; x=1779102829; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdpkiWeL2t8R+EHDk3fbd7ThTtXnMvXGE12dkE0RMC4=;
        b=Yh60y8KomVoazjSWwpMiy45Gvu4M+DNJKTjfwyy9e+Dwzhr+yEXkBLvAirEfQcx1Xe
         2DXrj2UpvGiXa4+Ql7H+Fh8iDRORaKBvygJE4dtRekmkZ0mETBuD4mkIPZhuqkuMem/D
         RKyLTGK4lO6VIQI0TTjsZwXhkQ/3QPk9+zMtLR2ptTiXUJzB9OHxcvYaJvIBUpC+wFrx
         XYa7xSIqri/EJ0h0Q+qCtnZooKDkKhAzaXsLq9tER3TYc5Ec6V3MDhacuV8HhAdtlqYx
         UZm4IQRhmKB1OG+TFr+PfVJeRnDT0o9dcjq2KqkddrhMQiz3S+t9RM2k9ejrsYhXctZF
         zTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498029; x=1779102829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdpkiWeL2t8R+EHDk3fbd7ThTtXnMvXGE12dkE0RMC4=;
        b=QvMaEb+sukltIdO6dneF3dUpiXJSib5fIsMI5GBC/hn/BrpW2ql7IBv9IiK3PAW1uZ
         dxTgID3ntqDJwjWm6AVel4U9IkR2IsBb54Tq7ZgQqC2yW1T191L4QiwAIG9GDH8P5y8H
         QmIdlnUn/fvTB2FXnVSsYW7ArY0XrakXtaawP3vmpT1DgopIAHX5WOoYMX8h9F8beGqB
         7e3VCAVyiCUhu98rmjX3EqZ0I4G1Y55rh6U3W8rYAMuNqdRYq5i9Jf8vjHP+krgOPxdG
         nb4DrSGAM2623W1lf1PbVOG9c3nv9Euw2CSJ+0pGkeXUndu0tyWPBj01sayv0/W5ngua
         2K2A==
X-Forwarded-Encrypted: i=1; AFNElJ+A0jswqdy+g/SCdbFgG5zcPRuDwcgXYmCY4GpaYUPInOkuy9kA75yuRunZIBjNUsKAUvsoCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8f02YJX4+2YIVkHMkDOZ1Zj2CDl2uaoU7ZTeeDHz6jUmESbqm
	cMo221kqazXFPMo7+5d739/QROsVf663pBooZh6xdXRHyBjShtc/zhhLE3kJB0lklA==
X-Gm-Gg: Acq92OH5zkR0kPxlmBBpZyCu4sbd2+hl8rZk2atuBcuO1j2bF5nObP4WR264yx9jeEf
	L3E1pEicOUAW9W3oQ6889g44v0GEHOtF/VSCOnam/JeNskNN/3i9fSY55ZmMnkrWZtZ9sUjXOHo
	pBZ2vvYqEch4G2dIbRgab9xwlAbKW+CZTKGKWZKmkWhp9R6VICuxPYazEVHp8hsY5OsIy6XAK/r
	iMD+DR8zv9htzpcrRgGmEDPjnu00pflHTn4Fkpav50HohW9O2a1RH/hU+uyakIkhxsJFmThkaA5
	KGl9po6KbRtlZPU8WHEIt5Ql+8C8Bi+qL9V/jO1aCKCvjpGiFgukocU0v1WIAjZq+yM3b50mQh0
	fPoddYGLbUOVjK/OKIe77Bbc/+/ah3lmzvmzjjL4laFwjUsGg0fjt7zK0WEgVSbUF3OqySxk5dc
	5UXXdkprzdZQalGi+8ei4PBEKRCTDcGLieiRsW5kFoXTUxreVi8xb7GmZnfjWV4w8lAsw=
X-Received: by 2002:a05:600c:a11c:b0:47d:1e65:e841 with SMTP id 5b1f17b1804b1-48e6f504706mr1661475e9.9.1778498028611;
        Mon, 11 May 2026 04:13:48 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm61259705e9.29.2026.05.11.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:13:47 -0700 (PDT)
Date: Mon, 11 May 2026 11:13:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 0/9] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <agG557zSEmAqp1mn@google.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <af4dK-0HEsKdPAvM@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4dK-0HEsKdPAvM@arm.com>

On Fri, May 08, 2026 at 06:28:11PM +0100, Catalin Marinas wrote:
> On Mon, Apr 27, 2026 at 11:25:00AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> > dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> > are handled consistently.
> 
> I think this series makes sense, using DMA_ATTR_CC_SHARED throughout the
> DMA API, either for alloc or for streaming to decide/check what bouncing
> does. Sashiko has a few interesting reports, it probably breaks s390 as
> well (it might be similar to the pKVM case).

I have this series on my review list, I believe there is an overlap with
my series, I can rebase mine on top of this if that makes sense, I will
probably wait for a new version to address the current comments and
Sashiko notes.

Thanks,
Mostafa

> 
> I don't think it addresses earlier Mostafa's issues with pKVM, although
> I'd rather base additional pKVM related fixes on top of this series.
> With pKVM, cc_platform_has(CC_ATTR_MEM_ENCRYPT) returns false, as does
> force_dma_unencrypted(). I think we should update protected guests to
> return true for these if they need shared buffers (the whole
> decrypted/shared terminology is messy but in most places it just means
> buffer not private to the protected guest, whether encryption is
> available or not).
> 
> That said, does CC_ATTR_GUEST_MEM_ENCRYPT actually make more sense than
> CC_ATTR_MEM_ENCRYPT throughout this series? We'd need to change arm64
> realms as well to use this one.
> 
> -- 
> Catalin
