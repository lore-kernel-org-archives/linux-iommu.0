From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/3] cross-tree: phase out dma_zalloc_coherent() on
 headers
Date: Tue, 8 Jan 2019 15:30:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1901081530070.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de> <20190108130701.14161-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108130701.14161-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On Tue, 8 Jan 2019, Christoph Hellwig wrote:

> From: Luis Chamberlain <mcgrof@kernel.org>
>
> The last few stragglers coccinelle doesn't pick up are on driver
> specific header files. Phase those out as well as dma_alloc_coherent()
> zeroes out the memory as well now too.

You can use the --include-headers option to also process the header files
(just an information, no need to change).

julia

>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        | 2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    | 2 +-
>  drivers/net/ethernet/marvell/octeontx2/af/common.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
> index 5cd3135dfe30..03d131f777bc 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
> @@ -2081,7 +2081,7 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
>  			    bool is_pf);
>
>  #define BNX2X_ILT_ZALLOC(x, y, size)					\
> -	x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
> +	x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
>
>  #define BNX2X_ILT_FREE(x, y, size) \
>  	do { \
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> index 142bc11b9fbb..2462e7aa0c5d 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> @@ -52,7 +52,7 @@ extern int bnx2x_num_queues;
>
>  #define BNX2X_PCI_ALLOC(y, size)					\
>  ({									\
> -	void *x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
> +	void *x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
>  	if (x)								\
>  		DP(NETIF_MSG_HW,					\
>  		   "BNX2X_PCI_ALLOC: Physical %Lx Virtual %p\n",	\
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index ec50a21c5aaf..e332e82fc066 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -64,7 +64,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
> -	qmem->base = dma_zalloc_coherent(dev, qmem->alloc_sz,
> +	qmem->base = dma_alloc_coherent(dev, qmem->alloc_sz,
>  					 &qmem->iova, GFP_KERNEL);
>  	if (!qmem->base)
>  		return -ENOMEM;
> --
> 2.20.1
>
>
