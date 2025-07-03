Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7129B789;
	Thu,  3 Jul 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552966; cv=none; b=kqUpIg+/l3W3oODU4B6PwloteIpzcmDmXBN+H6WtycAXUxbNK25so83m5YZebmD/2su21enerE0uoIaMGpNn7h+4pd+yUsm25T86IhQbf/HB8a8Q2PghpQJxoHu4NPhAfoBnzl/bTiMcYESENjUYlwPXU4ZufxPRZRWWc1Bz7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552966; c=relaxed/simple;
	bh=Wv4Ly+yjA1eTB3WL/QTAtPsGKoiMbeZftZxmfxTOncY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX6ttebqhkiQSNkVITDubLEL96lKePgSO7ZRJz//cCY+cz5pm15lnAbuvG53vhOnYOXVwf8esi6AslS8Chj4HMHZaZlHf7pT9mGLc1IUfg8HcS8ESlnD0zOVrthXViltdxprsjsqIimE8MDjI2MIq0flzXkOVzZsuPfLnReA6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr8QqkVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr8QqkVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D681C4CEE3;
	Thu,  3 Jul 2025 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552966;
	bh=Wv4Ly+yjA1eTB3WL/QTAtPsGKoiMbeZftZxmfxTOncY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dr8QqkVZ30M5Svn3VRIByKw3xnPUVjD4k/DreYk1fbBropfMV+ue/tVWidivH6KNS
	 SbjEx2ZLMMz8bYYlLkRk/MbPVBVfaOuU2tZVTwDmmshaIrXqqxdKw4Y4c0Nro6iBs+
	 yhtpnK1gAGhu5UVrAbJTlwZF1z6RQvv80NvUevWaQZw6UOC1M+qQir+Rcbfuzq7rTq
	 PlPhcX/HcOCVjyCfmxI2MSaLESxuwgwcZ64XaDzizTtdEFluCCzTj9/MmHHyvggJqA
	 WOp9cxE0gWgybiJR45S7PeBuJVqcZYmonAVbgg+/BtRREILd8nKnwP2iR46vPS5X8Q
	 ajTdOfn/xryMg==
Date: Thu, 3 Jul 2025 08:29:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGaTw7SzermpfiD7@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
 <20250701132936.GA18807@lst.de>
 <aGRMilWhgF4z0WOf@kbusch-mbp>
 <20250703093042.GA7387@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703093042.GA7387@lst.de>

On Thu, Jul 03, 2025 at 11:30:42AM +0200, Christoph Hellwig wrote:
> I think the idea to reconstruct the dma addresses from PRPs should
> be considered a failure by now.  It works fine for SGLs, but for
> PRPs we're better off just stashing them away.  Bob, can you try

s/Bob/Ben

> something like the patch below?  To be fully safe it needs a mempool,
> and it could use some cleanups, but it does pass testing on my setup
> here, so I'd love to see if if fixes your issue.

Thanks for confirming.

While this is starting to look a bit messy, I believe it's still an
overall win: you've cut down the vector walking in the setup path from 3
to 1, which reduces a non-trivial amount of overhead for even moderately
sized IO.
