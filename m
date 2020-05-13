Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009EC2D0FA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 14:23:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9757204EA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 14:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pH1mj81L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9757204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADCA688299;
	Wed, 13 May 2020 14:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hdPus5s+DPq; Wed, 13 May 2020 14:23:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF43C85784;
	Wed, 13 May 2020 14:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1385C088B;
	Wed, 13 May 2020 14:23:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C6BC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D9BA088263
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Il6DFlxQ-qpl for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 14:23:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E398585784
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:23:11 +0000 (UTC)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi
 [81.175.216.236])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D87851F;
 Wed, 13 May 2020 16:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1589379788;
 bh=5O0na2DMiyEwLbl3btgk9akjCBMQkQ7SFKipuPV1wEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pH1mj81La2wuE/YKdMXdaFC6dPVPCdpdSi0cuzqw8PjTHID3iK73wYjzUCAE4HvrR
 zN4hlCqtr1aD6xyomzlUiZrk1MQX1W3Bf9lN5A5B5od6IilQufrh8/enV5IVqdJkjO
 bB3T1akcTlxGSYFdE9fzoJ30Xmff9mcari/gTrDc=
Date: Wed, 13 May 2020 17:23:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 29/38] drm: rcar-du: fix common struct sg_table
 related issues
Message-ID: <20200513142302.GK5945@pendragon.ideasonboard.com>
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133317eucas1p27aead4025db2da13e5b7c3e14a7cd79d@eucas1p2.samsung.com>
 <20200513133245.6408-29-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513133245.6408-29-m.szyprowski@samsung.com>
Cc: linux-renesas-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Marek,

Thank you for the patch.

On Wed, May 13, 2020 at 03:32:36PM +0200, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
> 
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
> 
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
> 
> dma_map_sgtable() function returns zero or an error code, so adjust the
> return value check for the vsp1_du_map_sg() function.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This is a very nice simplification, I've always foudn the dma_map_sg API
cumbersome to use.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I assume you will get the whole series merged in one go. If I need to
pick the patch up at any point, please let me know. Otherwise I'll wait
until I see it upstream, no reply needed :-)

> ---
> For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c  | 3 +--
>  drivers/media/platform/vsp1/vsp1_drm.c | 8 ++++----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> index 5e4faf2..2fc1816 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -197,9 +197,8 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
>  			goto fail;
>  
>  		ret = vsp1_du_map_sg(vsp->vsp, sgt);
> -		if (!ret) {
> +		if (ret) {
>  			sg_free_table(sgt);
> -			ret = -ENOMEM;
>  			goto fail;
>  		}
>  	}
> diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
> index a4a45d6..86d5e3f 100644
> --- a/drivers/media/platform/vsp1/vsp1_drm.c
> +++ b/drivers/media/platform/vsp1/vsp1_drm.c
> @@ -912,8 +912,8 @@ int vsp1_du_map_sg(struct device *dev, struct sg_table *sgt)
>  	 * skip cache sync. This will need to be revisited when support for
>  	 * non-coherent buffers will be added to the DU driver.
>  	 */
> -	return dma_map_sg_attrs(vsp1->bus_master, sgt->sgl, sgt->nents,
> -				DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +	return dma_map_sgtable(vsp1->bus_master, sgt, DMA_TO_DEVICE,
> +			       DMA_ATTR_SKIP_CPU_SYNC);
>  }
>  EXPORT_SYMBOL_GPL(vsp1_du_map_sg);
>  
> @@ -921,8 +921,8 @@ void vsp1_du_unmap_sg(struct device *dev, struct sg_table *sgt)
>  {
>  	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
>  
> -	dma_unmap_sg_attrs(vsp1->bus_master, sgt->sgl, sgt->nents,
> -			   DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +	dma_unmap_sgtable(vsp1->bus_master, sgt, DMA_TO_DEVICE,
> +			  DMA_ATTR_SKIP_CPU_SYNC);
>  }
>  EXPORT_SYMBOL_GPL(vsp1_du_unmap_sg);
>  

-- 
Regards,

Laurent Pinchart
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
