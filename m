From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 15/20] memory: mtk-smi: Invoke pm runtime_callback to
 enable clocks
Date: Wed, 30 Jan 2019 11:05:03 -0800
Message-ID: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch only move the clk_prepare_enable and config_port into the
> runtime suspend/resume callback. It doesn't change the code content
> and sequence.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> (SMI_BUS_SEL need to be restored after smi-common resume every time.)
> Also it gives a chance to get rid of mtk_smi_larb_get/put which could
> be a next topic.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I believe this refactoring is a no-op as described, because the order is still:
1) mtk_smi_clk_enable(common)
2) mtk_smi_clk_enable(larb)
3) larb_gen->config_port()

And teardown still happens in the opposite order, except for
config_port, which they seem not to do in suspend.
So, looks good to me.

Reviewed-by: Evan Green <evgreen@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index a430721..9790801 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
>         u32                             *mmu;
>  };
>
> -static int mtk_smi_enable(const struct mtk_smi *smi)
> +static int mtk_smi_clk_enable(const struct mtk_smi *smi)
>  {
>         int ret;
>
> -       ret = pm_runtime_get_sync(smi->dev);
> -       if (ret < 0)
> -               return ret;
> -
>         ret = clk_prepare_enable(smi->clk_apb);
>         if (ret)
> -               goto err_put_pm;
> +               return ret;
>
>         ret = clk_prepare_enable(smi->clk_smi);
>         if (ret)
> @@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>         clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>         clk_disable_unprepare(smi->clk_apb);
> -err_put_pm:
> -       pm_runtime_put_sync(smi->dev);
>         return ret;
>  }
>
> -static void mtk_smi_disable(const struct mtk_smi *smi)
> +static void mtk_smi_clk_disable(const struct mtk_smi *smi)
>  {
>         clk_disable_unprepare(smi->clk_gals1);
>         clk_disable_unprepare(smi->clk_gals0);
>         clk_disable_unprepare(smi->clk_smi);
>         clk_disable_unprepare(smi->clk_apb);
> -       pm_runtime_put_sync(smi->dev);
>  }
>
>  int mtk_smi_larb_get(struct device *larbdev)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> -       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> -       int ret;
> +       int ret = pm_runtime_get_sync(larbdev);
>
> -       /* Enable the smi-common's power and clocks */
> -       ret = mtk_smi_enable(common);
> -       if (ret)
> -               return ret;
> -
> -       /* Enable the larb's power and clocks */
> -       ret = mtk_smi_enable(&larb->smi);
> -       if (ret) {
> -               mtk_smi_disable(common);
> -               return ret;
> -       }
> -
> -       /* Configure the iommu info for this larb */
> -       larb_gen->config_port(larbdev);
> -
> -       return 0;
> +       return (ret < 0) ? ret : 0;
>  }
>  EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
>
>  void mtk_smi_larb_put(struct device *larbdev)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> -
> -       /*
> -        * Don't de-configure the iommu info for this larb since there may be
> -        * several modules in this larb.
> -        * The iommu info will be reset after power off.
> -        */
> -
> -       mtk_smi_disable(&larb->smi);
> -       mtk_smi_disable(common);
> +       pm_runtime_put_sync(larbdev);
>  }
>  EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
>
> @@ -385,12 +350,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> +       int ret;
> +
> +       /* Power on smi-common. */
> +       ret = pm_runtime_get_sync(larb->smi_common_dev);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
> +               return ret;
> +       }
> +
> +       ret = mtk_smi_clk_enable(&larb->smi);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to enable clock(%d).\n", ret);
> +               pm_runtime_put_sync(larb->smi_common_dev);
> +               return ret;
> +       }
> +
> +       /* Configure the basic setting for this larb */
> +       larb_gen->config_port(dev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +
> +       mtk_smi_clk_disable(&larb->smi);
> +       pm_runtime_put_sync(larb->smi_common_dev);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops smi_larb_pm_ops = {
> +       SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
> +};
> +
>  static struct platform_driver mtk_smi_larb_driver = {
>         .probe  = mtk_smi_larb_probe,
>         .remove = mtk_smi_larb_remove,
>         .driver = {
>                 .name = "mtk-smi-larb",
>                 .of_match_table = mtk_smi_larb_of_ids,
> +               .pm             = &smi_larb_pm_ops,
>         }
>  };
>
> @@ -489,12 +494,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> +{
> +       struct mtk_smi *common = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = mtk_smi_clk_enable(common);
> +       if (ret) {
> +               dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
> +{
> +       struct mtk_smi *common = dev_get_drvdata(dev);
> +
> +       mtk_smi_clk_disable(common);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops smi_common_pm_ops = {
> +       SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
> +};
> +
>  static struct platform_driver mtk_smi_common_driver = {
>         .probe  = mtk_smi_common_probe,
>         .remove = mtk_smi_common_remove,
>         .driver = {
>                 .name = "mtk-smi-common",
>                 .of_match_table = mtk_smi_common_of_ids,
> +               .pm             = &smi_common_pm_ops,
>         }
>  };
>
> --
> 1.9.1
>
