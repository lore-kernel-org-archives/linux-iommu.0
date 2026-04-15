Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A66384256
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284763; cv=none; b=WS5KyEpkumyJKN30LXLVRP0/x4UcKrluTqDb8B0ey0f2ZkTPFyGJXBH4seFLMZWlrLUe6sEB9YcBxcRi4jHcb2M9MYzwVYOzVz6fIrhazIj6EkhPzV6ehMC9zbRcdxfYpPf3P8kuTwprth/tGAeK6FKV6vVApCk+VD1M+EOouhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284763; c=relaxed/simple;
	bh=D1SqgEwszCSlMw2AO/UNhnFUs69EEmK/QjpAWkmWeio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY0YsnSBBcQv83zi/8CqLsR5CEAXEz+GluAWn1rDWHzWwp396xBgwZyIoGtujHmru3EX9lGHDFasrLGuZJTbcWDnhJ/eCIUoOQCDo4W4fO96gGLb8M7maBcloBioTS9HEwScr5RyiZ8jMa23gY8PrMR0zQXs1pO6/drVd6yDXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrrQpFwq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrrQpFwq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488879dcbc3so54445e9.0
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776284760; x=1776889560; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0AjMVKAHSpj8KfkpLbd1zkxWe8CEnOGcRvItgWy4AaQ=;
        b=DrrQpFwqc2AoZBjYKFY83eckeC5mK+u8eDGhytPlstPGUSffbvm0cceCeR0XIPRGWG
         Vz83iuZ33o+clzVfQfPg2iJn4BZhRVuLy+3zhXtvX8p0Y/BFA3bwh99NDsNouMnr/56y
         hsPFHwaoAB9dpiZsy/R3h1YSK4u67MqRz0zbj/98R+NN2NqPs1VJbaPH+CeehXYj+6qC
         O8JqvDM+ea9SLjAlV8d84e4R82zDbqaX1tpBEDXcuwMurmVJ6hVPm8SxH36ZxX/g2fCm
         DO1Kes48ngn/TMhWGMcX5dtk68sx03zO8BSa7Du2uFTfvaT937I4/Bw6Je2lC/lLKy2H
         vnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284760; x=1776889560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AjMVKAHSpj8KfkpLbd1zkxWe8CEnOGcRvItgWy4AaQ=;
        b=eHht2ReCvmqxnfXHtbAlTBMNrruITpqkCJ1JOyfSYoNffTtrNM6BSWsMPxCsSpgtMj
         V6RvaD+tSdNFJHC/qbmj11jw31jUzktERETVSZLP8G3cEnGJd0d6yzDORmh5g3+d7/d3
         YcD7gJWldxPz27vgSvF7i3HSryTssUxQ7UpgRJjPWJJXSPr4BDohDJlsnYVVJ6/9Erda
         ZysMnMUHSqt2pEeHNV31ZpQnMWHWKMIunQ6Ofm70DCOQDMQwoPgXl+Rytn1CUSwpTftr
         YB+fwCRJztxLW0l3J6JjDH7Wzf2/IiwbsfjW+cbk0AWJ8W8asTy2A/R/Nc/0Km7Zctc1
         DUMg==
X-Gm-Message-State: AOJu0YzTwRrcP9o1IrDpKuhIpd5dN+58ACnWxuYWr2Mn46ZYPtRYOkqO
	l8qB8gp2BUEfwV1QK0oT7T/souHWWtaWqqOV3thh15hg8SBfmD1e6qNDq5TgoU3DqJoNCMVkEL9
	lcSPE0Q==
X-Gm-Gg: AeBDieuMw6lblx75SZwkk/IsaquTEFiqBun0i4oTh23qAXtRCWhJ+xkCZhrY+uYF1qt
	OZjLW/N/rlHQBrhuG0VJHsNnG5IlCC6u3aYEtGGcNFaiZIzWX1tJJxF7i6cnR3i2rgaGKR5E0kx
	2Q9C0M6SgzbJTaYZDG+8/D3UexJg629MFD4gLPq/MVX0G3VfNTXnQBvgvwwbJLQB92zpVGbrESC
	LftRBwMpzwclqvHBdMYi9WrC65iDlPSOMBFv79CzQesj5xSaxodl7aPo6CM6nT8Tzj06Z6K90Ov
	1025e1efSyunSfZD2htc5R6xJSrOAZbgqLHfLUDPb5BVevlLHf6ex79l001367KbtneUrHLnrQx
	TiOJTaHxhcJjxzO1RXCCHCGJqTQKiems2A0w+s8NDk2+Jr9vRQDM5YpaBfJU6FeQt59EA64uVCz
	euA2dqrqRoJvwUI2wwaK8ty4ZsgfOJFKiPXHhXjPrnD96XjD5pr8Pm7H0o6vQ/UAIwzP0LmNSjX
	Y7pgQ==
X-Received: by 2002:a05:600d:8445:20b0:485:32b7:5b87 with SMTP id 5b1f17b1804b1-488f4aaae31mr150215e9.14.1776284759504;
        Wed, 15 Apr 2026 13:25:59 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f208572bsm73115645e9.15.2026.04.15.13.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:25:58 -0700 (PDT)
Date: Wed, 15 Apr 2026 20:25:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 0/5] dma-mapping: Fixes for memory encryption
Message-ID: <ad_0UmWwxLSPvRAy@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260410174338.GC2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410174338.GC2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 02:43:38PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 08, 2026 at 07:47:37PM +0000, Mostafa Saleh wrote:
> > Introduction
> > ============
> > This is the third version of the fixes for direct-dma dealing with
> > memory encryption and restricted-dma.
> > 
> > Changes in v3:
> > - Instead of extending the logic by using is_swiotlb_for_alloc(),
> >   follow Jason’s suggestion and propagate the state of the memory
> >   allocated.
> > - Remove checks out of dma_set_*() based on Jason suggestion
> > - Remove documentation for now until we are close to the final
> >   proposal and add it later if needed.
> 
> There are a number of Sashiko remarks that look plausible that should
> be investigated:
> https://sashiko.dev/#/patchset/20260408194750.2280873-1-smostafa%40google.com

I think the remap and NULL points are valid, I will address them.

The case of dma_coherent_ok() is more tricky, it is not a regression,
but I think it’s still a theoretical problem for some CCA solutions
where encrypted/decrypted memory have different DMA aliases. It’s not
easy to fix it without having some helper to check the memory state as
force_dma_unencrypted and swiotlb_is_decrypted() which kind of defeat
the purpose of returning the memory state from swiotlb_alloc() ://

> 
> > Design
> > ======
> > This series focuses mainly on dma-direct interaction with memory
> > encryption which is the complicated case.
> > At the moment memory encryption and dma-direct interacts in 2 ways:
> > 1) force_dma_direct(): if true, memory will be decrypted by default
> >    on allocation.
> > 2) Restricted DMA: where memory is pre-decrypted and managed by
> >    SWIOTLB.
> > 
> > With a third possible usage on the way [1] where the DMA-API allows
> > an attr for decrypted memory.
> 
> This [1] was merged now

I see, I will rebase on top of it and send v4.

Thanks,
Mostafa

> 
> Jason
