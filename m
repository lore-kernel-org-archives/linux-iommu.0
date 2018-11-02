From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: fix return type of dma_set_max_seg_size()
Date: Fri, 2 Nov 2018 11:22:54 +0100
Message-ID: <20181102102254.GF22306@bigcity.dyn.berto.se>
References: <20180829212921.10665-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180829212921.10665-1-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

A gentle ping on this patch.

On 2018-08-29 23:29:21 +0200, Niklas S=F6derlund wrote:
> The function dma_set_max_seg_size() can return either 0 on success or
> -EIO on error. Change its return type from unsigned int to int to
> capture this.
> =

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
> ---
>  include/linux/dma-mapping.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> =

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1db6a6b46d0d3dbd..669cde2fa8723ac5 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -674,8 +674,7 @@ static inline unsigned int dma_get_max_seg_size(struc=
t device *dev)
>  	return SZ_64K;
>  }
>  =

> -static inline unsigned int dma_set_max_seg_size(struct device *dev,
> -						unsigned int size)
> +static inline int dma_set_max_seg_size(struct device *dev, unsigned int =
size)
>  {
>  	if (dev->dma_parms) {
>  		dev->dma_parms->max_segment_size =3D size;
> -- =

> 2.18.0
> =


-- =

Regards,
Niklas S=F6derlund
