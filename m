From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 3/5] memory: mediatek: Add SMI driver
Date: Tue, 15 Dec 2015 13:45:26 +0800
Message-ID: <CAGS+omDTt646fH3p7kA+EHkR93xGX0APu1sOEjY7MCzQfpO8DA@mail.gmail.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
	<1449568153-15643-4-git-send-email-yong.wu@mediatek.com>
	<24171857.0SPpBlzoZl@linux-gy6r.site>
	<1450147103.22854.23.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450147103.22854.23.camel@mhfsdcap03>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yong,

On Tue, Dec 15, 2015 at 10:38 AM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> On Mon, 2015-12-14 at 19:18 +0100, Matthias Brugger wrote:
>> On Tuesday 08 Dec 2015 17:49:11 Yong Wu wrote:
>> > This patch add SMI(Smart Multimedia Interface) driver. This driver
>> > is responsible to enable/disable iommu and control the power domain
>> > and clocks of each local arbiter.
>> >
>> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> > ---
>> >   Currently SMI offer mtk_smi_larb_get/put to enable the power-domain
>> > ,clocks and initialize the iommu configuration register for each a local
>> > arbiter, The reason is:
>> >   a) If a device would like to disable iommu, it also need call
>> > mtk_smi_larb_get/put to enable its power and clocks.
>> >   b) The iommu core don't support attach/detach a device within a
>> > iommu-group. So we cann't use iommu_attach_device(iommu_detach_device)
>> > instead
>> > of mtk_smi_larb_get/put.
>> >
> [..]
>> > +static int
>> > +mtk_smi_enable(struct device *dev, struct clk *apb, struct clk *smi)
>> > +{
>> > +   int ret;
>> > +
>> > +   ret = pm_runtime_get_sync(dev);
>> > +   if (ret < 0)
>> > +           return ret;
>> > +
>> > +   ret = clk_prepare_enable(apb);
>> > +   if (ret)
>> > +           goto err_put_pm;
>> > +
>> > +   ret = clk_prepare_enable(smi);
>> > +   if (ret)
>> > +           goto err_disable_apb;
>> > +
>> > +   return 0;
>> > +
>> > +err_disable_apb:
>> > +   clk_disable_unprepare(apb);
>> > +err_put_pm:
>> > +   pm_runtime_put_sync(dev);
>> > +   return ret;
>> > +}
>> > +
>> > +static void
>> > +mtk_smi_disable(struct device *dev, struct clk *apb, struct clk *smi)
>> > +{
>> > +   clk_disable_unprepare(smi);
>> > +   clk_disable_unprepare(apb);
>> > +   pm_runtime_put_sync(dev);
>> > +}
>> > +
>> > +static int mtk_smi_common_enable(struct mtk_smi_common *common)
>> > +{
>> > +   return mtk_smi_enable(common->dev, common->clk_apb, common->clk_smi);
>> > +}
>> > +
>> > +static void mtk_smi_common_disable(struct mtk_smi_common *common)
>> > +{
>> > +   mtk_smi_disable(common->dev, common->clk_apb, common->clk_smi);
>> > +}
>> > +
>> > +static int mtk_smi_larb_enable(struct mtk_smi_larb *larb)
>> > +{
>> > +   return mtk_smi_enable(larb->dev, larb->clk_apb, larb->clk_smi);
>> > +}
>> > +
>> > +static void mtk_smi_larb_disable(struct mtk_smi_larb *larb)
>> > +{
>> > +   mtk_smi_disable(larb->dev, larb->clk_apb, larb->clk_smi);
>> > +}
>> > +
>>
>> This is somehow over-engineered. Just use mtk_smi_enable and mtk_smi_disable
>> instead of adding an extra indirection.
>
> I added this only for readable...then the code in mtk_smi_larb_get below
> may looks simple and readable.
>
> If I use mtk_smi_enable/disable directly, the code will be like our
> v5[1], is it OK?
> Maybe I don't need these help function here, and only add more comment
> based on v5.
>
> [1]
> http://lists.linuxfoundation.org/pipermail/iommu/2015-October/014590.html

bike-shedding...

I like the fact that Yong is trying to make his helpers more type-safe.
But, perhaps we can rename "struct mtk_smi_common" as "struct
mtk_smi", and then make "struct mtk_smi_larb" contain a "struct
mtk_smi":

struct mtk_smi {
  struct device *dev;
  struct clk *clk_apb, *clk_smi;
}

struct mtk_smi_larb {
  struct mtk_smi;
  ...
}


Then, have:

int mtk_smi_enable(struct mtk_smi *smi)
{
  clk_enable(smi->clk_apb);
  ...
}

int mtk_smi_disable(struct mtk_smi *smi)
{
}

int mtk_smi_larb_get(struct device *larbdev)
{
  struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
  struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);

  mtk_smi_enable(common);
  mtk_smi_enable(&larb->smi);
  ...
}

>>
>> > +int mtk_smi_larb_get(struct device *larbdev)
>> > +{
>> > +   struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
>> > +   struct mtk_smi_common *common = dev_get_drvdata(larb->smi_common_dev);
>> > +   int ret;
>> > +
>> > +   ret = mtk_smi_common_enable(common);
>> > +   if (ret)
>> > +           return ret;
>> > +
>> > +   ret = mtk_smi_larb_enable(larb);
>> > +   if (ret)
>> > +           goto err_put_smi;
>> > +
>> > +   /* Configure the iommu info */
>> > +   writel_relaxed(larb->mmu, larb->base + SMI_LARB_MMU_EN);

I think this should probably be writel() not writel_relaxed, since you
really do want the barrier to ensure all other register accesses have
completed before enabling the MMU.

>> > +
>> > +   return 0;
>> > +
>> > +err_put_smi:
>> > +   mtk_smi_common_disable(common);
>> > +   return ret;
>> > +}
>> > +
>> > +void mtk_smi_larb_put(struct device *larbdev)
>> > +{
>> > +   struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
>> > +   struct mtk_smi_common *common = dev_get_drvdata(larb->smi_common_dev);
>> > +
>> > +   writel_relaxed(0, larb->base + SMI_LARB_MMU_EN);
>> > +   mtk_smi_larb_disable(larb);
>> > +   mtk_smi_common_disable(common);
>> > +}
>> > +
>>
>> Looks strange that you just disable all MMUs while you only enable some of
>> them at runtime. Unfortunately the datasheet I have lacks the SMI part, so I
>> can just guess how the HW is working.
>> From the DTS it looks like as if a larb can be used by two different
>> components (e.g. larb0 from ovl0 and rdma0). Wouldn't that produce a conflict?
>
> Thanks. It's really a problem.
>
> There are OVL0 and MDP in larb0, Both will call mtk_smi_larb_get/put, we
> cann't disable all the MMUs in whole the larb0 here.  This register
> should be reset to zero while the larb power domain turning off(rely on
> the power-domain ref count).
> I will delete this(keep this in our V5.)

Hmm, mtk_smi_config_port(.., false) clears the bit in larb->mmu, but
does not actually "disable" an enabled mmu.
The MMU will be disabled only on the next mtk_smi_larb_get() (for a
different port on the same larb).
I guess this is ok.  The only weird thing is this situation, where an
MMU can be left enabled when its user is done with it:

 /* configure port 0 as 'enabled' */
 mtk_smi_config_port(0, true);
 /* configure port 1 as 'enabled' */
 mtk_smi_config_port(1, true);

/* user of port 0 wants to do work */
mtk_smi_larb_get() /* turns on all clks, power & enables both MMUs */

/* user of port 1 wants to do work */
mtk_smi_larb_get()

/* user of port 1 done doing work */
mtk_smi_larb_put()

/* MMU 1 is still enabled */


Thanks!
-Dan
