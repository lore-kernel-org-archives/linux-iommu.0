From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/rockchip: make clock handling optional
Date: Tue, 17 Apr 2018 16:27:36 +0200
Message-ID: <CAFqH_531GBbpKtQQyU827Wn+Lf4uHbLJJtp=hZHkkiZUYX+g4w@mail.gmail.com>
References: <20180417120915.31535-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180417120915.31535-1-heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, vicencb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

2018-04-17 14:09 GMT+02:00 Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>:
> iommu clocks are optional, so the driver should not fail if they are not
> present. Instead just set the number of clocks to 0, which the clk-blk APIs
> can handle just fine.
>
> Fixes: f2e3a5f557ad ("iommu/rockchip: Control clocks needed to access the IOMMU")
> Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> changes in v2:
> - keep it required in the binding for future variants
>   but optional in the code for backwards compatiblity
> - follow Robin Murphy's beautification suggestion
>
> As the original changes breaks a lot of display support in 4.17-rc1,
> this should abviously go in as fix into 4.17.
>
>  drivers/iommu/rockchip-iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5fc8656c60f9..422d22990289 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1175,8 +1175,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         for (i = 0; i < iommu->num_clocks; ++i)
>                 iommu->clocks[i].id = rk_iommu_clocks[i];
>
> +       /*
> +        * iommu clocks should be present for all new devices and devicetrees
> +        * but there are older devicetrees without clocks out in the wild.
> +        * So clocks as optional for the time being.
> +        */
>         err = devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
> -       if (err)
> +       if (err == -ENOENT)
> +               iommu->num_clocks = 0;
> +       else if (err)
>                 return err;
>
>         err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
> --
> 2.16.2
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Thanks to this patch my display is back :)

Tested-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
