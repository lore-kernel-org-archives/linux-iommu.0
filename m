From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Don't register as BUS IOMMU if machine doesn't have IPMMU-VMSA
Date: Fri, 27 Jul 2018 12:10:15 +0300
Message-ID: <2725801.tsBI9ZhLPt@avalon>
References: <20180726211916.10264-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726211916.10264-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Marc Dietrich <marvin24@gmx.de>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Hi Dmitry,

(CC'ing Geert and Magnus)

Thank you for the patch.

On Friday, 27 July 2018 00:19:16 EEST Dmitry Osipenko wrote:
> This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
> a multiplatform configuration and IPMMU-VMSA driver is enabled.
> 
> Cc: <stable@vger.kernel.org> # v3.20+
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9e8495762bc8..78c50db9cd71 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1109,12 +1109,19 @@ static struct platform_driver ipmmu_driver = {
> 
>  static int __init ipmmu_init(void)
>  {
> +	struct device_node *np;
>  	static bool setup_done;
>  	int ret;
> 
>  	if (setup_done)
>  		return 0;
> 
> +	np = of_find_matching_node(NULL, ipmmu_of_ids);
> +	if (!np)
> +		return 0;
> +
> +	of_node_put(np);
> +

While functionally correct, this will add some unnecessary overhead when 
iommu_init() is called from IOMMU_OF_DECLARE(). I'm OK with this fix as a 
temporary measure to solve your problem, but we need to address the underlying 
issue properly.

Geert, Magnus, the ipmmu-vmsa driver is a bit of a mess. We should brush it up 
and start using IOMMU_OF_DECLARE() on all platforms (and eventually get rid of 
bus_set_iommu() completely...). Do you have plans to address this ? If not, 
could you please add it to your to-do list ?

>  	ret = platform_driver_register(&ipmmu_driver);
>  	if (ret < 0)
>  		return ret;

-- 
Regards,

Laurent Pinchart
