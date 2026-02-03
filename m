Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D336CDF4;
	Tue,  3 Feb 2026 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099266; cv=none; b=FHptglZ7UGVjIbCgODQjuLjZTZ2M7tNACoZnuymYsKfL8u4SB8pdXhQUvyED93YHEiOBggm/qkpCAglo4zavQt5XQGeeyGz2qOttwcgE1aSwlZQqRQzBz0ruiZBLS4hZqgcBILfsSm7Wqa2Fo5LPlYLTDVZ0RAz7yZRKmhaDQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099266; c=relaxed/simple;
	bh=ZRLmHQ6WbGoWDl85DpVVViz2f0mnbKfHUjBEQxspXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekrmp5AKA8p5iLRuCG7ILq9DO6/YhVy69cw6X1cEzKxHLIbC8drnFUS5k216N804Wu2277Md+wHjoMedceSy+tW6EZW6SZkjgpqzESxm6havP46M1Jp54ISk4R1QAQ1lAe/iW/LynKkgvLRbk0KT1x/3Np0ldr5OEKCK/g8Hpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a25gm59z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a25gm59z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C0AC116D0;
	Tue,  3 Feb 2026 06:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770099266;
	bh=ZRLmHQ6WbGoWDl85DpVVViz2f0mnbKfHUjBEQxspXaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a25gm59zkLTTTg5ib78zaGpSNSL4Z6hzL/0K/yF7DtEms6jmUt9YfklXea7FgMouW
	 WDUl/EBex3Y5zOJhH81rog+QdTvd7+K1XjlNyHrUotRdJNX8eHJzCS2cCyjcRmEd0E
	 6gdAcQhw3MvR7RaSAry3teiFQB6EBjViY/I6eWu1HSdCFDsPpdsNtDaeLYMpotPxi4
	 IHi1qDDgLqLWJiwZa2WGNEhXV4O7Hour/RMl/NUaHh84RBjg526pxDZPy/Up7cDE/Y
	 sKJCd5dlwXerhQwVj/Cy/Bdn81SaDz0AmRIuGOPSfh8UYBbM/LWIwzdqXe/FQQa7Es
	 g/f1M/xzuCzQA==
Date: Mon, 2 Feb 2026 23:14:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYGSP4luf1nOFhS2@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203052756.GA15839@lst.de>

On Tue, Feb 03, 2026 at 06:27:56AM +0100, Christoph Hellwig wrote:
> >  	iod->nr_descriptors = 0;
> >  	iod->total_len = 0;
> >  	iod->meta_total_len = 0;
> > +	iod->nr_dma_vecs = 0;
> > +	iod->dma_vecs = NULL;
> 
> I don't think we need the dma_vecs initialization here, as everything
> is keyed off nr_dma_vecs.

Yes, we should definitely use nr_dma_vecs and skip the NULL setting. I'm
a big fan removing unnecessary initialisations. Just a caution, my
suggested patch has this check:

	if (!iod->dma_vecs)

So we just need to update it to use 'iod->nr_dma_vecs' instead, which
would have been correct, too.
