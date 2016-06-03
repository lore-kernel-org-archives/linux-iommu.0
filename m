From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu: convert DT component matching to
 component_match_add_release()
Date: Fri, 3 Jun 2016 15:13:00 +0200
Message-ID: <5751825C.40703@gmail.com>
References: <E1b8jzj-00046r-Pd@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <E1b8jzj-00046r-Pd-eh5Bv4kxaXIk46pC+1QYvQNdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 03/06/16 09:58, Russell King wrote:
> Convert DT component matching to use component_match_add_release().
>
> Signed-off-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>   drivers/iommu/mtk_iommu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c3043d8754e3..c036df1c49ca 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -557,6 +557,11 @@ static int compare_of(struct device *dev, void *data)
>   	return dev->of_node == data;
>   }
>
> +static void release_of(struct device *dev, void *data)
> +{
> +	of_node_put(data);
> +}
> +
>   static int mtk_iommu_bind(struct device *dev)
>   {
>   	struct mtk_iommu_data *data = dev_get_drvdata(dev);
> @@ -630,17 +635,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			continue;
>
>   		plarbdev = of_find_device_by_node(larbnode);
> -		of_node_put(larbnode);
>   		if (!plarbdev) {
>   			plarbdev = of_platform_device_create(
>   						larbnode, NULL,
>   						platform_bus_type.dev_root);
> -			if (!plarbdev)
> +			if (!plarbdev) {
> +				of_node_put(larbnode);
>   				return -EPROBE_DEFER;
> +			}
>   		}
>   		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
>
> -		component_match_add(dev, &match, compare_of, larbnode);
> +		component_match_add_release(dev, &match, release_of,
> +					    compare_of, larbnode);
>   	}
>
>   	platform_set_drvdata(pdev, data);
>
