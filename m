Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816D36EA9E
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046642; cv=none; b=kf+y6HGOABU5iVjygBvJGvUPiVeyxnljwdIACSKDRGIbGPqyW1Cx1exrg68cMpjySgTgOobfUCTUwhv188nI3ZCuwkCmMNfbcZ+oz8bBZXsECiV/6SyAAGY1Oa+mI48kZ9Q5DdFjBtuZYOFlf6uiFICZOcqrxp+R2ZXkhs7U4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046642; c=relaxed/simple;
	bh=Bsp3xDyhNd/OtxX1x//qg/lW3UkI2Sz7MvDdxTNpXX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev+DzkEFzZ1WXnad3VypV7PsJBV2FvzTwlCI3+KmBkYG4AnkDUd/07yAE/clmRhLZD2GYRlhzMnBbnveR4Zlcu6NIkhx2++2s/hYAtbyJY5Gzq9VCsxfNZ7Hxx6DoYqQFdeC/rlU5HWXEwTrWkO2JbRgQhTZC3UYnWQ3ztWai3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yyt8eNlW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yyt8eNlW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48540355459so836125e9.3
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773046634; x=1773651434; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhSAyhARBfFioIzUhuKz22/Ga41Sv7/6kPpVPO+u0Ts=;
        b=yyt8eNlWWrjZ52sjvRTG+i0MJDWfzFaxJ4TSM3JOvdNfnYctt+/nyMj+IW9oCXw9Ai
         UsLTjk+9dLLYsZQnUiGZOLLWmQSS2rdyCC0jEHSZrGVdoxoyypYl655b4o4NGirldfMq
         HyJJod8t0xPY4yq7tbLUW3AfeOGDqh/SxGn6u1HBJwy3+Mfk7wVb6UCHiSvYXB/qxg9u
         0lhEjWHI1PDT4GQVZ/qlsvTpNJ0kyWM2MWMrKK+FCf2R8cWaI/vTQnzFbx1HdJ0pxhuP
         OLssB/NoD93TFrwn4qOV0u96sbCGBBPsYwtLCNFObDjsSrlInYKlv6Vns1GvPuK1nBdr
         JcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773046634; x=1773651434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhSAyhARBfFioIzUhuKz22/Ga41Sv7/6kPpVPO+u0Ts=;
        b=tBaDSG2leSbvg4Oe2nWOpRey+t1+F0iYwK4IXTjCBSa9xWrdizraUZtkcTX4iuu8s4
         /yYIOFTbObx4+aDPrWb6hGebNniRVsodVrsLAxbU3dpq1Q96iAcWZ/UzOAPhDO2YIUoo
         n8xRSykBP6PWDQjqbwmXeZexsJ8c1g26/9bv3DDdVrZo4EQHlFOTlU6LWhz6Ij4/AdHe
         nOG1k0qvEE0AN9ziFt+SiZzNqlChjs+iCEfXyl2MFBPkTao0BbLjBI0qRACn4DmBfz4X
         mVu44FR9DFU3ZVjF6QWU1ecgGlHVjKC1u0kc1qYb+dP3EfogVimfAWMwmGjFKByINv7w
         aPEw==
X-Forwarded-Encrypted: i=1; AJvYcCVH4G6cywZgZ2MRRqZQwrsJZRHvoPkNthtPvBm6QQjp9fUZpUHUVOVAVjRzuXpGO8iP2dE7zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu9xVbuoLvchBaeovZ1HMCuomZYSy6ozoDF6AlzG2tH7w7zfF2
	54cQW8V0/HdY6z8QPBOtyhTvAud/0SYRHVS/3D2gxcI+AXFvAhzkbQtdUCNaSlt5I1k=
X-Gm-Gg: ATEYQzxMLTh/mYgvl4wFXBHra1ULnF353WAMCFuyY/63Z/l+IUtNFn0SSTvISR2QW7h
	hkLBAfgcrGQwCkUVfxSvgGYBjkEUsc485PWQBxikzR3YGNz0Lv0BzMh3ELyrs1TJommWrMOc3Jb
	yGgFjpIsU4wfM8PYW4N9PNWfDUXoHk+SkjBeHcoow88I87nLUb+6xRJtTjYPyqBNKO3QAlWfmkK
	/FXk92j4mahSlS3dtLp6AA0+c4HwdPA3Dg/telXLDOYMLBJc1NE4nQkRwtw29hNWWoS6Sc67+GI
	uaMX5mx9qS10qiod9D/niXQ8bfyVLWmVucw6DOKxB2iSBQqIZ6jWAFQlHUMtQtWlTToEqnzgtD8
	72nIQBnNMqJ7cn3e7a3FYBIeGrQx2vc4CQJva/7jUYOSfKMp6L8DGgfYa48L6erZkWDv2UZwmB2
	A+ktXv0LYehqzvRp2XaVbDWej9UGcf52o=
X-Received: by 2002:a05:600c:8714:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-48526957d50mr167626995e9.22.1773046634085;
        Mon, 09 Mar 2026 01:57:14 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b7547sm260786625e9.12.2026.03.09.01.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:57:13 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:57:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com, 
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <dnb4khhvpmwzxkp3vuihukfaztjvy5oxsjunbgixyebwonfeyi@goxt6ahopcwi>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308101948.GO12611@unreal>

Sun, Mar 08, 2026 at 11:19:48AM +0100, leon@kernel.org wrote:
>On Thu, Mar 05, 2026 at 01:36:40PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Current CC designs don't place a vIOMMU in front of untrusted devices.
>> Instead, the DMA API forces all untrusted device DMA through swiotlb
>> bounce buffers (is_swiotlb_force_bounce()) which copies data into
>> decrypted memory on behalf of the device.
>> 
>> When a caller has already arranged for the memory to be decrypted
>> via set_memory_decrypted(), the DMA API needs to know so it can map
>> directly using the unencrypted physical address rather than bounce
>> buffering. Following the pattern of DMA_ATTR_MMIO, add
>> DMA_ATTR_CC_DECRYPTED for this purpose. Like the MMIO case, only the
>> caller knows what kind of memory it has and must inform the DMA API
>> for it to work correctly.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - rebased on top of recent dma-mapping-fixes
>> ---
>>  include/linux/dma-mapping.h |  6 ++++++
>>  include/trace/events/dma.h  |  3 ++-
>>  kernel/dma/direct.h         | 14 +++++++++++---
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 29973baa0581..ae3d85e494ec 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -85,6 +85,12 @@
>>   * a cacheline must have this attribute for this to be considered safe.
>>   */
>>  #define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
>> +/*
>> + * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
>> + * (shared) for confidential computing guests. The caller must have
>> + * called set_memory_decrypted(). A struct page is required.
>> + */
>> +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
>
>While adding the new attribute is fine, I would expect additional checks in
>dma_map_phys() to ensure the attribute cannot be misused. For example,
>WARN_ON(attrs & (DMA_ATTR_CC_DECRYPTED | DMA_ATTR_MMIO)), along with a check
>that we are taking the direct path only.

Okay, I will add the check.
