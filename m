From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 3/3] iommu/dma: Handle IOMMU API reserved regions
Date: Fri, 10 Mar 2017 09:03:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8174CC2D5@lhreml504-mbs>
References: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy@arm.com>
	<ccb0f5ef6822c760c253038e27e55752210b754b.1489088954.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ccb0f5ef6822c760c253038e27e55752210b754b.1489088954.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, March 09, 2017 7:51 PM
> To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> marc.zyngier-5wv7dgnIgG8@public.gmane.org; Gabriele Paoloni; John Garry; Shameerali Kolothum
> Thodi
> Subject: [PATCH 3/3] iommu/dma: Handle IOMMU API reserved regions
> 
> Now that it's simple to discover the necessary reservations for a given
> device/IOMMU combination, let's wire up the appropriate handling. Basic
> reserved regions and direct-mapped regions are obvious enough to
> handle; hardware MSI regions we can handle by pre-populating the
> appropriate msi_pages in the cookie. That way, irqchip drivers which
> normally assume MSIs to require mapping at the IOMMU can keep working
> without having to special-case their iommu_dma_map_msi_msg() hook, or
> indeed be aware at all of integration quirks preventing the IOMMU
> translating certain addresses.

Many thanks for this. This will help us to avoid the ugly ITS quirk to
support the D03/D05. I will go through this.

Cheers,
Thanks.

> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c | 65
> +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1e0983488a8d..1082ebf8a415 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -167,6 +167,69 @@ void iommu_put_dma_cookie(struct iommu_domain
> *domain)  }  EXPORT_SYMBOL(iommu_put_dma_cookie);
[...]
