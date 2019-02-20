From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 2/3] iommu: Document iommu_ops.iotlb_sync_map()
Date: Wed, 20 Feb 2019 16:39:14 +0300
Message-ID: <2fff24cd-5591-8ac9-3665-6d9a6e1689c1@gmail.com>
References: <20190220130053.784-1-geert+renesas@glider.be>
 <20190220130053.784-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220130053.784-3-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>
Cc: Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

20.02.2019 16:00, Geert Uytterhoeven пишет:
> Add missing kerneldoc for iommu_ops.iotlb_sync_map().
> 
> Fixes: 1d7ae53b152dbc5b ("iommu: Introduce iotlb_sync_map callback")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 848fb07026b67169..3ed5d372b090af54 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -169,6 +169,7 @@ struct iommu_resv_region {
>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>   * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
>   * @iotlb_range_add: Add a given iova range to the flush queue for this domain
> + * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>   *            queue
>   * @iova_to_phys: translate iova to physical address
> 

Pretty sure there was a kerneldoc in some version of the original patch that introduced the iotlb_sync_map(), but probably it got lost after a rebase. The kerneldoc comment is correct, thank you! BTW, for some reason gmail marked this series as a spam, maybe you need to check the email headers and whatnot.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
