From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/rockchip: make clock handling optional
Date: Tue, 10 Apr 2018 12:24:15 +0100
Message-ID: <0f17363b-408d-9da4-a930-074c705953bd@arm.com>
References: <20180410092612.2653-1-heiko@sntech.de>
	<20180410092612.2653-3-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180410092612.2653-3-heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
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
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/04/18 10:26, Heiko Stuebner wrote:
> iommu clocks are optional, so the driver should not fail if they are not
> present. Instead just set the number of clocks to 0, which the clk-blk APIs
> can handle just fine.
> 
> Fixes: f2e3a5f557ad ("iommu/rockchip: Control clocks needed to access the IOMMU")
> Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> ---
>   drivers/iommu/rockchip-iommu.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5fc8656c60f9..7215c683cb8f 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1176,8 +1176,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   		iommu->clocks[i].id = rk_iommu_clocks[i];
>   
>   	err = devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
> -	if (err)
> -		return err;
> +	if (err) {
> +		if (err == -ENOENT)
> +			iommu->num_clocks = 0;
> +		else
> +			return err;
> +	}

Nit: this might be a bit nicer as:

	if (err == -ENOENT)
		iommu->num_clocks = 0;
	else if (err)
		return err;

Either way,

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thanks,
Robin.
