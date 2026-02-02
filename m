Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3D36B07F;
	Mon,  2 Feb 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045780; cv=none; b=B1Tg7Y6fVGIQytCSuNuB92JAcCfFYjRqyguBO652PbGPALm1jQApkCVQePOlqUxwQYSA1fjKp/cC4NTejl7eWb5KP2D4vCr+h2Pn0Bq+V2EnpvINAWlbc7HFUGjP3ojXTzmphfZrGEvXtLvj50VxiVuPteDrN0xJG+NAnim0wSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045780; c=relaxed/simple;
	bh=u+CLsD0rgOYsL+CWqPMaVWL60KF39XcQLR9wrErM380=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi0SnQIxYdt48hquzeN8W4ba2qzsVta0vJf7mOjHcLucbskaP85ke1ahHXfNzDwm4qcHu/2IeWRbLpTrXwisMyJQDb4UUIkl0uBYxEzEH7zPParAYB/7jlVrCTYrvIc/3hNXn/IBNfNwiKYqbre3jkLwd2+FSUey/DAR2riPZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSbYulO+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSbYulO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AEDC116C6;
	Mon,  2 Feb 2026 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770045779;
	bh=u+CLsD0rgOYsL+CWqPMaVWL60KF39XcQLR9wrErM380=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSbYulO+ptjtMm19DXpcqA42WKIP4RBZMfJb0YHm/C0IgRR555ndrF4+qo89es1wR
	 E3TgiqL3IRzbX8sfT5vm/F5yqT/j9LIgrc4A6kdEymbRyGo6lM5PprWFeaR/ajfBvj
	 atqnKRmUiVtDuOlupvNzLok53uuNvb08HY3gPOYgmXUGFN15sl+MaDLCvUnEpLBGo+
	 fsczM8KNj0igKYm8lg+fT238EdFDx0SBG1V9ZdJ49aJer48r/etTewh5qhuUTTwiGq
	 KbdoexYd8w5x3iIw6HdzCLkvudnM8VKGzbnnH2pB5h0rRxYY24BN3hpnsfR3FLMgD2
	 bL9+WOtyAxBmA==
Date: Mon, 2 Feb 2026 17:22:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202152252.GM34749@unreal>
References: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
 <20260202143548.GA19313@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202143548.GA19313@lst.de>

On Mon, Feb 02, 2026 at 03:35:48PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> > Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> > when SWIOTLB bounce buffering becomes active during runtime.
> > 
> > The issue occurs when SWIOTLB activation changes the device's DMA
> > mapping requirements at runtime,
> >
> > creating a mismatch between
> > iod->dma_vecs allocation and access logic.
> > 
> > The problem manifests when:
> > 1. Device initially operates with dma_skip_sync=true
> >    (coherent DMA assumed)
> > 2. First SWIOTLB mapping occurs due to DMA address limitations,
> >    memory encryption, or IOMMU bounce buffering requirements
> > 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
> >    dma_skip_sync=false
> > 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
> >    iod->dma_vecs
> 
> I think this patch just papers over the bug.  

Agree

> If dma_need_unmap can't be trusted before the dma_map_* call, we've not saved
> the unmap information and the unmap won't work properly.
> 
> So we'll need to extend the core code to tell if a mapping
> will set dma_skip_sync=false before doing the mapping.

There are two paths that lead to SWIOTLB in dma_direct_map_phys().  
The first is is_swiotlb_force_bounce(dev), which dma_need_unmap() can  
easily evaluate. The second is more problematic, as it depends on  
dma_addr and size, neither of which is available in dma_need_unmap():

  102                 if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
  103                     dma_kmalloc_needs_bounce(dev, size, dir)) {
  104                         if (is_swiotlb_active(dev))

What about the following change?

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 37163eb49f9f..1510b93a8791 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -461,6 +461,8 @@ bool dma_need_unmap(struct device *dev)
 {
        if (!dma_map_direct(dev, get_dma_ops(dev)))
                return true;
+       if (is_swiotlb_force_bounce(dev) || is_swiotlb_active(dev))
+               return true;
        if (!dev->dma_skip_sync)
                return true;
        return IS_ENABLED(CONFIG_DMA_API_DEBUG);

