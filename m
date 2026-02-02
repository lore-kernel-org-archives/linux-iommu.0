Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF702580E1;
	Mon,  2 Feb 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048269; cv=none; b=un7I5xkQ4+hQxFvUl63UIRSgq9vZRvzJ0GaDu3lzWlqR+ASHrmH+JUuz7i8zFzTBTAzQZ4gmmq4t2fxCgHBLJ4yHyI4+Jak8L09EfXnDvYGhpoM2opPfT5+rThgccwqd2qkGPdsILxKj0SvedQqccU0DSdVwPZne3zHHT8Hs6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048269; c=relaxed/simple;
	bh=i9C4x2L6jLrWK55vr+wvHQqCEdNNkxwb2ocUf8llZi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njwZUqVHktoOzNyc7kv0fnVUjQDRoxkOaIPnTGlZHB82XDiVQnMZUYc36xdQSwVRJPDiBt4FoV0hIaaldw3+NWKXAeowErbLxChWqQkgCKSglLyf9PxvI3634MI4xKVohbq0PKA2Jfe4cUb7PUznhcZAE53osL/eQfBRkdumn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oveCre4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oveCre4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFA7C116C6;
	Mon,  2 Feb 2026 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770048268;
	bh=i9C4x2L6jLrWK55vr+wvHQqCEdNNkxwb2ocUf8llZi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oveCre4dLd+PAyAP86LxStRh0GyZ4GupsC7r9LgN8M+YbpuHGARne83Di/WLjBoPj
	 sliBZcMcVd95bhSMJiIB1Eu0HssWYbvbEz06Se65JZ5onDcrktxIL/yKbgFtC8J9FS
	 dxOff70nKtfyn2F+wTYigEblungU6+wAYtI5jn44QmjOz3YmpO9Gb3KqoKufMUbjpr
	 nZ0U78yMmpO+3Bfs7+iXPXS2wUAs52StbzXodSeYw/YmObV2vTeSXc9wW0MoJzmdxO
	 n3M9kQ9aCixABgcsdvJgfm0dZhrCYORNJ4iJtNg7ImavkOFgcHYTk0MoEROVvGlZE4
	 oE7QnSz5b8h3A==
Date: Mon, 2 Feb 2026 17:58:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202155804.GN34749@unreal>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>

On Mon, Feb 02, 2026 at 03:16:50PM +0000, Robin Murphy wrote:
> On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
> > On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> > > Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> > > when SWIOTLB bounce buffering becomes active during runtime.
> > > 
> > > The issue occurs when SWIOTLB activation changes the device's DMA
> > > mapping requirements at runtime,
> > > 
> > > creating a mismatch between
> > > iod->dma_vecs allocation and access logic.
> > > 
> > > The problem manifests when:
> > > 1. Device initially operates with dma_skip_sync=true
> > >     (coherent DMA assumed)
> > > 2. First SWIOTLB mapping occurs due to DMA address limitations,
> > >     memory encryption, or IOMMU bounce buffering requirements
> > > 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
> > >     dma_skip_sync=false
> > > 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
> > >     iod->dma_vecs
> > 
> > I think this patch just papers over the bug.  If dma_need_unmap
> > can't be trusted before the dma_map_* call, we've not saved
> > the unmap information and the unmap won't work properly.
> 
> The dma_need_unmap() kerneldoc says:
> 
> "This function must be called after all mappings that might
>  need to be unmapped have been performed."
> 
> Trying to infer anything from it beforehand is definitely a bug in the
> caller.

At least for HMM, dma_need_unmap() works as expected. HMM doesn't work
with SWIOTLB.

Thanks
