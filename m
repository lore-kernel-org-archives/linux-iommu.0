From: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs
Date: Tue, 8 Jan 2019 10:55:16 +0000
Message-ID: <91c7f07e5a8e7ad98e259c430934d92a58a558b6.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
	<20190105080108.14837-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190105080108.14837-3-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <E57E7F98A7364A49A8EFB3DF1A760E2A-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux-graphics-maintainer <Linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,


On Sat, 2019-01-05 at 09:01 +0100, Christoph Hellwig wrote:
...

> intel_iommu_enabled is defined as always false for
> !CONFIG_INTEL_IOMMU,
> so remove the ifdefs around it.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
> 
> -#if !defined(CONFIG_SWIOTLB) && !defined(CONFIG_INTEL_IOMMU)
> -	/*
> -	 * No coherent page pool
> -	 */
> -	if (dev_priv->map_mode == vmw_dma_alloc_coherent)
> -		return -EINVAL;
> -#endif
> 

Actually this hunk is incorrect, it tries to determine whether the TTM
subsystem maintains a coherent page pool or not. If not, we can't use
vmw_dma_alloc_coherent.

/Thomas
