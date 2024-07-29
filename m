Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF4548F7;
	Mon, 29 Jul 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262061; cv=none; b=aMYtqln8OirpwYPn3wHHLmJ7F3qMD356suPn4ssONMURw/IGbl0rv42XrZC137JkT1aawZ0/IglMkVD7CD14IC6N/kJjfH0tgoQ0VnGYk95dQNS+Q+SdpclCOKaGa8nxbZ+9tGK1aLDHKUsBYuNc7M6xP0GvSDT1atPFNhL1UFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262061; c=relaxed/simple;
	bh=kXviRuKSqni0oHqZdGwFlfHuW6TUVx6nqymgVOMCiA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwvXvaWp0xtvV/Xw52KMoiiIBxVFfdhkHsGP/3L9WPxV6MhKvHpRglacwnnr0KnBmOAEd6XjF+9jnTvA6+giccQEA5/fDwMdlsuEuJM2Ztt4NlP7QwSDt6Qjch7NXBdHw/hMMqx8bZdSJcH1xFKNyYfiw85dyS19cUnrpjuLAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZBfRKx8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZBfRKx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518E7C32786;
	Mon, 29 Jul 2024 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722262060;
	bh=kXviRuKSqni0oHqZdGwFlfHuW6TUVx6nqymgVOMCiA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZBfRKx8nSrWM3SJdYaEJ8gjpQ31d+xcuwONlxCLJRCk0hx8PP2/LYCPwYDTVtMeA
	 DUPsUloBPQWvCqh1NvV5S+HpxKaPv+qS0TULbtm8ZXJjCvBRwwKDr7DmwxIDtLFvqk
	 jcZvaY4xsd1sbCJYAS4oIveoUSuTQBHpq6m1d3UVb6o/E6aX7GTiGsTQPX3sBVtyj0
	 00h5Tf6WceLoce1jYEr5+bnsYMCxxgQedcqfgzXI6IDkrchlfFz5/O9IvAZj01+2Ly
	 GAR3ET1QQtj5KEYO9TGwB08h/ja7gnjGinGGJ4iF/9V3VNLI3VRizne+dNxGALs3IT
	 9porIYFk2X3Aw==
Date: Mon, 29 Jul 2024 17:07:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240729140736.GC5669@unreal>
References: <cover.1721219730.git.leon@kernel.org>
 <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
 <ZqeN6MP4o2JNLcUz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeN6MP4o2JNLcUz@google.com>

On Mon, Jul 29, 2024 at 12:41:12PM +0000, Mostafa Saleh wrote:
> Hi Leon,
> 
> On Wed, Jul 17, 2024 at 03:37:11PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Most of the arch DMA ops (which often, but not  always, involve
> > some sort of IOMMU) are using the same DMA operations. These DMA
> > operations are default ones implemented in drivers/iomem/dma-iommu.c.
> > 
> > So let's make sure to call them directly without need to perform function
> > pointers dereference.
> 
> Just out of curiosity, is there any observed improvement from that?
> As from my experience the DMA-IOMMU path is quite dense so it won't
> be senstive to such micro-optimizations.

DMA-IOMMU no, but NVMe driver which uses DMA-API in datapath will
potentially benefit from this change.

I personally used this change to simplify my "DMA split ... " series [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split-v2

Thanks
