From: Hiroshi DOyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 10/10] mmc: sdhci-tegra: Add IOMMU support
Date: Fri, 27 Jun 2014 12:46:02 +0300
Message-ID: <20140627124602.53d046dae5d7e269815e56a0@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-11-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403815790-8548-11-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Allen Martin <AMartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Attach to the device's master interface of the IOMMU at .probe() time.
> IOMMU support becomes available via the DMA mapping API interoperation
> code, but this explicit attachment is necessary to ensure proper probe
> order.
>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 33100d10d176..b884614fa4e6 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/iommu.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> @@ -237,6 +238,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
>  	if (!match)
>  		return -EINVAL;
> +
> +	rc = iommu_attach(&pdev->dev);
> +	if (rc < 0)
> +		return rc;
> +

I thought that, if we consider that ->probe() should include minimal H/W
probing so that DMA API call in ->probe() could be deferred after
->probe() and till it's in use actually, like opening a device node. For
me this decision(minimal h/w probe) seemed logical but it would add a
new restriction. One advantage is that we could still keep all drivers
wihtout any IOMMU code if it doesn't call DMA API in ->probe().

>  	soc_data = match->data;
>  
>  	host = sdhci_pltfm_init(pdev, soc_data->pdata, 0);
> @@ -310,6 +316,8 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_put(pltfm_host->clk);
>  
> +	iommu_detach(&pdev->dev);
> +
>  	sdhci_pltfm_free(pdev);
>  
>  	return 0;
