Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D68C0F
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE642C433D2;
	Thu, 20 Apr 2023 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682004573;
	bh=MAxNLEi9Laz6Rtk0cSTWmnXgzP9ZBF70aoAIMpyib2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEnFQ1MT4Bx7GdsJ7zJ7/xMQNfCHn/ZPrWdbglAtfT1j1zhh2WMvDSpbOyvPrtuXY
	 ra87ivs+pxFFPdqDoSJQAFfnXMSquQwd0jG+fxOxGfSeORKfZM4b3iziBYtM3CXM1/
	 PaexFbMbnsusfE/Qc7F6ipQ0FiG6gSujQG96PfKIp4R3Jd5LY3H1hr4zPCZ0E0hV6S
	 cdsyDBxsuBipFp8D5YQWqogrphq1bEkUJlDDkpbjug5JzObRjj/+J6N7SeugNjyTZR
	 ZK2SRmLJ8VMxOn/zDy+08TYoGW5ttZ4TtKsaovwGYnUZUdLtJQm67GZpXijRdZgCRR
	 6Yd1kqMJySmcw==
Date: Thu, 20 Apr 2023 09:29:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH] nvme: clamp max_hw_sectors based on DMA optimized
 limitation
Message-ID: <ZEFaWnF+b87i91o/@kbusch-mbp.dhcp.thefacebook.com>
References: <20230420130155.19281-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420130155.19281-1-adrianhuang0701@gmail.com>

On Thu, Apr 20, 2023 at 09:01:55PM +0800, Adrian Huang wrote:
> To fix the lock contention issue, clamp max_hw_sectors based on
> DMA optimized limitation in order to leverage scalable IOVA mechanism.
> 
> Note: The issue does not happen with another NVME disk (mdts = 5
> and max_hw_sectors_kb = 128)

Thanks for the patch. I think this makes sense.
 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c6..c0d1ea889b4d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1819,11 +1819,16 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>  	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
>  
>  	if (ctrl->max_hw_sectors) {
> -		u32 max_segments =
> -			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
> +		u32 opt_sectors, max_sectors; /* optimized/max sectors */
> +		u32 max_segments;
> +
> +		opt_sectors = dma_opt_mapping_size(ctrl->dev) >> SECTOR_SHIFT;
> +		max_sectors = min_not_zero(ctrl->max_hw_sectors, opt_sectors);
> +
> +		max_segments = (max_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
>  
>  		max_segments = min_not_zero(max_segments, ctrl->max_segments);
> -		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> +		blk_queue_max_hw_sectors(q, max_sectors);
>  		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
>  	}
>  	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);

Taking into account what Linus mentioned on a similiar patch[1], I think it may
make more sense for the lower level driver code to have already capped
ctrl->max_hw_sectors prior to calling this function. Something like the patch
below.

[1] https://lore.kernel.org/all/CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com/

Side note, I think he's incorrect about using the max_segment_size limit since
the dma code will collapse physically contiguous segments, so splitting bvecs
for that limit won't really help.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5b..8505fbeaa2d2f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2914,6 +2914,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	size_t max_bytes = NVME_MAX_KB_SZ;
+
 	if (node == NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, first_memory_node);
 
@@ -2955,12 +2961,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
-	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
+	max_bytes = min(max_bytes, dma_max_mapping_size(&pdev->dev));
+	max_bytes = min_not_zero(max_bytes, dma_opt_mapping_size(&pdev->dev));
+	dev->ctrl.max_hw_sectors = max_bytes >> 9;
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
--
