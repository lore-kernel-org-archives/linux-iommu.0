Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7731D5ABA;
	Tue,  3 Feb 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140519; cv=none; b=sBl1sJ7pFyq22NDyv/6ilfr6h5MUdZfSY21/ZhutZrzKzyJDgDqpqsZkEh9YTq2/EE6GixjBBKIseKmPZNezmneHC/+9vgp+4UKHgx17xvYsHitFAIgqc8LDWt6aOUthj1Pg1wWDnwFJExUdGfaZR5Typ++sC0wErWdm+y+pc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140519; c=relaxed/simple;
	bh=mYLo//Hf0CdyWj2A1kskOpG25ECJq6tKQxdW6rNvCCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ2iGPaum4i96VjiwoHwA5eWwkMoslU/qT927zpyS5CzqhZoLMqVbQMx50I7C/AuN4e9P7G+evt5Zf2SOTXYgjcQpf7qZhxb2daPUxzidSKTBcWYWiyoC04RvGnHrRBKToJZXOa7In4rt8gqSZChHFIhx4ryNnCEN9Pse9iXA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D23R1mDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D23R1mDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19419C116D0;
	Tue,  3 Feb 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770140518;
	bh=mYLo//Hf0CdyWj2A1kskOpG25ECJq6tKQxdW6rNvCCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D23R1mDa/GjuoXb6uTeAAz2a0WvE8SWNBDNO7798zfXfJN7iyTkvb3YApqHUZKxDc
	 IH/fcovTehSI1QgjlrY4WHcYfe5eglEWxtfftwluwDDjp9coRh04dogFpvpi8m9O6X
	 4roQZ250pq8x7lIjCYrdFC3IpGIrCJV+izSpnkUeEF0xdcbF2oHW9D1jfpCHiyX5Sf
	 fn/E1of84rjdocSGN+Ulj4i8y+8iqj8T8W8x3XpZkBrgF4onv8w27LvJc6dQcrSo1v
	 K3knVTr2+m/2+88CtqS9YwuL1rTPS/iIgeq1V7pP62Yj7/ubpCZ97Uet6gBR94Vmtw
	 JUFHJActlZBKA==
Date: Tue, 3 Feb 2026 10:41:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYIzZNdjWOlJ_Oao@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203094247.GP34749@unreal>
 <4e375e54-e141-473c-ae71-fc013268d057@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e375e54-e141-473c-ae71-fc013268d057@arm.com>

On Tue, Feb 03, 2026 at 01:50:12PM +0000, Robin Murphy wrote:
> > Can dev->dma_skip_sync be modified in parallel with this check?
> > If so, dma_need_unmap() may return different results depending on the
> > time at which it is invoked.
> 
> It can if another thread is making mappings in parallel, however as things
> currently stand that would only lead to the current thread thinking it must
> save the unmap state for the mappings it's already made even if it
> technically didn't need to.
> 
> In principle it could also change back the other way if another thread reset
> the device's DMA mask, but doing that with active mappings would
> fundamentally break things in regard to the dma_skip_sync mechanism anyway.

We can handle a change in dma_needs_unmap() from false -> true. Worst
case scenario is we save off a descriptor when we didn't really need to,
but it's just a small memory use for the lifetime of the IO.

We don't correctly handle a transition from true -> false, though. We'd
currently leak memory if that happened. It sounds like that transition
is broken for other reasons too, so I won't bother trying to handle it.
