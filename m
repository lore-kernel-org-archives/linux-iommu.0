Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4919CC0A;
	Tue,  1 Jul 2025 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331264; cv=none; b=kOapyT5usna+ydEs6WdDYjm700G7WLXXbd58bQzO0rYHrQmV3Jm+dYojzevjYdzj/XM3srXFz7qWLk+ohAXCsPq69Iuc6j2C6YaTSzfMD2Ac4mN7P5yTPSRfBS2Sg8fzmgr2MBnUoCmg9MxwydLcZnUoRnjkivL0S+RNO/6PDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331264; c=relaxed/simple;
	bh=ToOw6uJVC9iS7TA1n50KV+hOesklTI3h/nf9C9Afkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6y41+nMt09J84XjMDZciYHBQctR96m+riTn/WEigYQFu4+bYxpb70agvbtgu0fZ2CGjWhmbsdEO0CwJR89jkRmZ6eT2gUwlqVk9Y1VcIg8mdfFISyda5BbSi6WM8q0Knl8fYAXCH2xIc9JBd/4hjdTk2ndkpYLeXboXntxVtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyK4qdqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyK4qdqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683EC4CEF1;
	Tue,  1 Jul 2025 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331263;
	bh=ToOw6uJVC9iS7TA1n50KV+hOesklTI3h/nf9C9Afkk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyK4qdqe7n2SY35w+0A2VIvZMp5I/DS91mgGqJg0VUJl9P+KTZz8W8cM6NauRPs0d
	 8Z4KahMYQfwakLpjFJGiBdtTnTTcsK2k3VLG0dsTY4g0X06c5R4UUaWbWKDxl5vlv5
	 QKlX/ooQaHil84zfPAo5lowvdjELNQnek6Lqsuipnltx14giYoclu/w16F9r88UuhR
	 MGKCx3M1BrRxxqIA2JZegKWGf7raug3DEawkejgjW6hmJ8unAsq08LDGwXHh6SeJJ8
	 lWGlDH3/Qi9Ehh4+R6CBJMvIPnbhgBAfR88RZCIviqrJI9L51AMHzweUJD/rTjBAsN
	 7P36XETuKdU8g==
Date: Mon, 30 Jun 2025 18:54:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGMxu6Yn514Xy55w@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLyswGYD6Zai_sI@kbusch-mbp>

On Mon, Jun 30, 2025 at 02:25:23PM -0600, Keith Busch wrote:
> On Mon, Jun 30, 2025 at 03:33:43PM +0200, Christoph Hellwig wrote:
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -701,7 +701,7 @@ static void nvme_free_prps(struct request *req)
>         prp_list = iod->descriptors[desc];
>         do {
>                 dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> -               if (i == NVME_CTRL_PAGE_SIZE >> 3) {
> +               if (i == NVME_CTRL_PAGE_SIZE >> 3 && length > NVME_CTRL_PAGE_SIZE) {
>                         prp_list = iod->descriptors[++desc];
>                         i = 0;
>                 }
> --
> 
> But even that, the PRP setup doesn't match the teardown. We're calling
> dma_map_page() on each PRP even if consecutive PRP's [...]

Err, I meant to say "dma_unmap_page()".
