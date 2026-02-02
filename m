Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42C1FF1AE
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042955; cv=none; b=B27FMcV7pgnwn+86R/esIhYhPiGVHGr2K/BXuTE8DJ7dtrbXRlQpjiVXg0U8LphbVdnosOge8bZRGFIMGhF2f7227+c4mZWLTXYPBqfY42RiXDdY0lnGZCcu72q5tb6YHNuWpnfmyFX/Le8zQcrIK0fMJa7r4uJaPshWcK0sF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042955; c=relaxed/simple;
	bh=6luQC6VFJfXvrb/lbdtpUVNRb3TKpLiGOEg91b7l+Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=og7TEG0bnY7FEcRq/7f0s77j5DnEWNsilEGQcFwKu7B0V6iW7OLmn9BtTlZNwJEbcTLjha0wBMknMcQv/QEkcvJTH8TCz1JFQuBuTo0ZSki72ETTmJU+irLAsrKymS5H6q1QOvuAwULC7WIC6OqSeWYKlAvDI6mlpG2SY6vxLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4DAE68B05; Mon,  2 Feb 2026 15:35:48 +0100 (CET)
Date: Mon, 2 Feb 2026 15:35:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202143548.GA19313@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> when SWIOTLB bounce buffering becomes active during runtime.
> 
> The issue occurs when SWIOTLB activation changes the device's DMA
> mapping requirements at runtime,
>
> creating a mismatch between
> iod->dma_vecs allocation and access logic.
> 
> The problem manifests when:
> 1. Device initially operates with dma_skip_sync=true
>    (coherent DMA assumed)
> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>    memory encryption, or IOMMU bounce buffering requirements
> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>    dma_skip_sync=false
> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>    iod->dma_vecs

I think this patch just papers over the bug.  If dma_need_unmap
can't be trusted before the dma_map_* call, we've not saved
the unmap information and the unmap won't work properly.

So we'll need to extend the core code to tell if a mapping
will set dma_skip_sync=false before doing the mapping.

