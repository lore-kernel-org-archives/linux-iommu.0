From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 5/8] iommu/mediatek: Disable iommu clock when system
 suspend
Date: Sat, 12 Aug 2017 17:34:32 +0800
Message-ID: <1502530472.11148.54.camel@mhfsdcap03>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
         <1502445377-26936-6-git-send-email-yong.wu@mediatek.com>
         <b451cb47-505e-c300-42fd-9cb73c09ef0b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b451cb47-505e-c300-42fd-9cb73c09ef0b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2017-08-11 at 16:39 +0530, Arvind Yadav wrote:
> Hi Youn,
> 
> 
> On Friday 11 August 2017 03:26 PM, Yong Wu wrote:
> > When system suspend, infra power domain may be off, and the iommu's
> > clock must be disabled when system off, or the iommu's bclk clock maybe
> > disabled after system resume.
> >
> > Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/iommu/mtk_iommu.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index e81ed9a..b7c8e52 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -675,6 +675,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> >   	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
> >   	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
> >   	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
> > +	clk_disable_unprepare(data->bclk);
> >   	return 0;
> >   }
> >   
> > @@ -684,6 +685,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >   	struct mtk_iommu_suspend_reg *reg = &data->reg;
> >   	void __iomem *base = data->base;
> >   
> > +	clk_prepare_enable(data->bclk);
> Please handle return value of clk_prepare_enable. It can fail

Thanks for the reminding. I will add it in next version.

> >   	writel_relaxed(reg->standard_axi_mode,
> >   		       base + REG_MMU_STANDARD_AXI_MODE);
> >   	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> > @@ -699,7 +701,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >   }
> >   
> >   static const struct dev_pm_ops mtk_iommu_pm_ops = {
> > -	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
> >   };
> >   
> >   static const struct of_device_id mtk_iommu_of_ids[] = {
> ~arvind


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
