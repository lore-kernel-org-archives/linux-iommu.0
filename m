Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924961514E0
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075443; cv=none; b=HzKt56ZknTgRWoX5ToxVgopYShXkiW7eSL4+qFBxM9R0Z4g/1gHN+o1ryBVXWB7UCR0tVJ7PRRwKFqp9S2rJmlGEoQz38JGrDspDkowH87ERwRPQ7T61SzGF9LZHyZTJBAUzmwyZqgg9ojYoYqyqq5VversytJvLgtexgZ5xGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075443; c=relaxed/simple;
	bh=ADtabK3K92lvMOfY/6PsZesyU6XRH5vXTw5RjUA0w8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2HK3zGQBAqseUaKet+b2wCVqJnbGHAFWZPNPDMSeGfpUl3eminVilAaDoJgdmpt0MmyoatW3xgwhfImoYHq2pJP4L0L30rG4SZK360BUfeXj93dWZwDzf0wb+jFfuEFYgVV+jsEkbv0QZ4Su5RqYQCvoj/5ChkYb76MKwNblRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdMEqh7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdMEqh7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E6DC2BBFC;
	Tue,  7 May 2024 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715075443;
	bh=ADtabK3K92lvMOfY/6PsZesyU6XRH5vXTw5RjUA0w8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdMEqh7N6iSsQVVstvipmlrjE0kU9ZUcaFD4+jzgxFpZi9dZrMjFZL7Ta0hD+nNOg
	 GhNrq02SA0eLOECeOk5W/L7NUx34e/dfpC6DGoQrvJJfgW+4CNknMlDplpYqLGY/sQ
	 HkUgz5jZ2yMKwTcvB+vLWT1cTmlpBdavMoIjWnujn5HmxN/goe1L8FjC3ij3jSjq37
	 N4ImkzCVLMmhg1WkyW7rq62cDz4edsk7iV0n9+KxdZT4VeyXBzKG71E9QduEeFWdeL
	 3Uf4eNBfSy9uqlafKSLNsrZf0YKKjmor26Q5lpoU3Yw92MIAF75C9pjWU0fjTyA8ee
	 N76wmGPoG+LGA==
Date: Tue, 7 May 2024 10:50:38 +0100
From: Will Deacon <will@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, joro@8bytes.org
Cc: Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
Message-ID: <20240507095037.GA22185@willie-the-truck>
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
 <CAA8EJpqcCpiuqeU9Bktev9vSa6Gdw1jTn+VAk+xbu9kKPTrjEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqcCpiuqeU9Bktev9vSa6Gdw1jTn+VAk+xbu9kKPTrjEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, May 04, 2024 at 05:21:12PM +0300, Dmitry Baryshkov wrote:
> On Tue, 30 Apr 2024 at 13:23, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Thanks to the somewhat asymmetrical nature, while removing
> > iommu_setup_dma_ops() from the arch_setup_dma_ops() flow, I managed to
> > forget that arm64's teardown path was also specific to iommu-dma. Clean
> > that up to match, otherwise probe deferral will lead to the arch code
> > erroneously removing DMA ops set elsewhere.
> >
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Link: https://lore.kernel.org/linux-iommu/Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru/
> > Fixes: b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()")
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  arch/arm64/Kconfig          | 1 -
> >  arch/arm64/mm/dma-mapping.c | 8 --------
> >  2 files changed, 9 deletions(-)
> 
> 
> Just wanted to ping regarding the patch. It's still not a part of
> linux-next, Is it going to be picked up for 6.10?

Oops, thanks Dmitry!

Joerg -- please can you pick this one up for iommu next? It fixes a
commit you already have there, so I think it's best to keep everything
together.

FWIW:

Acked-by: Will Deacon <will@kernel.org>

Will
