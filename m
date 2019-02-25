From: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
Date: Mon, 25 Feb 2019 15:56:29 -0800
Message-ID: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
	<1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1546318276-18993-12-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>
> MediaTek IOMMU should wait for smi larb which need wait for the
> power domain(mtk-scpsys.c) and the multimedia ccf who both are
> module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> Switch to builtin_platform_driver.
>
> Meanwhile, the ".remove" can be removed. Move its content to
> ".shutdown".
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
>  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
>  2 files changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 735ae8d..2798b12 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
>  }
>
> -static int mtk_iommu_remove(struct platform_device *pdev)
> +static void mtk_iommu_shutdown(struct platform_device *pdev)
>  {
>         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
>
> @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>         clk_disable_unprepare(data->bclk);
>         devm_free_irq(&pdev->dev, data->irq, data);
>         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> -       return 0;
> -}
> -
> -static void mtk_iommu_shutdown(struct platform_device *pdev)
> -{
> -       mtk_iommu_remove(pdev);

Is there a reason all these things are happening in shutdown()? Don't
we normally just not clean things up and let the machine turn off?
Normally I'm a big advocate of proper symmetric teardown, so it hurts
a little to ask.
