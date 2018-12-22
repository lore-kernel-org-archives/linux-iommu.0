From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 03/18] memory: mtk-smi: Use a general config_port
	interface
Date: Sat, 22 Dec 2018 11:57:09 +0800
Message-ID: <1545451029.29587.88.camel@mhfsdcap03>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
	<1544258371-4600-4-git-send-email-yong.wu@mediatek.com>
	<aa91ceb7-673b-7022-d718-f9f61d4b2f23@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <aa91ceb7-673b-7022-d718-f9f61d4b2f23-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2018-12-21 at 18:47 +0100, Matthias Brugger wrote:
> 
> On 08/12/2018 09:39, Yong Wu wrote:
> > The config_port of mt2712 and mt8183 are the same. Use a general
> > config_port interface instead.
> > 
> > In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
> > are not the normal larb, their register space are different from the
> > normal one. thus, we can not call the general config_port. In mt8183,
> > IPU0/1 and CCU connect with smi-common directly, they also are not
> > the normal larb. Hence, we add a "larb_special_mask" for these special
> > larbs.
> > 
> > This is also a preparing patch for adding mt8183 SMI support.
> > 
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/memory/mtk-smi.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 8f2d152..3b9ad0e 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -53,6 +53,7 @@ struct mtk_smi_larb_gen {
> >  	bool need_larbid;
> >  	int port_in_larb[MTK_LARB_NR_MAX + 1];
> >  	void (*config_port)(struct device *);
> > +	unsigned int larb_special_mask; /* The special larbs mask. */
> 
> I'm not really happy with the name larb_special_mask but I can't think of
> anything else. The comment is not needed as it just rewords the name of the
> variable.

Thanks this comment. then I reword more detail instead this common
"special", How about "larb_to_common_directly_mask"?

> 
> Other then that (or even without changing anything):
> 
> Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks.

> 
> >  };
> >  
> >  struct mtk_smi {
> > @@ -176,17 +177,13 @@ void mtk_smi_larb_put(struct device *larbdev)
> >  	return -ENODEV;
> >  }
> >  
> > -static void mtk_smi_larb_config_port_mt2712(struct device *dev)
> > +static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> >  {
> >  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> >  	u32 reg;
> >  	int i;
> >  
> > -	/*
> > -	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
> > -	 * Don't need to set it again.
> > -	 */
> > -	if (larb->larbid == 8 || larb->larbid == 9)
> > +	if (BIT(larb->larbid) & larb->larb_gen->larb_special_mask)
> >  		return;
> >  
> >  	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> > @@ -261,7 +258,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  
> >  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> >  	.need_larbid = true,
> > -	.config_port = mtk_smi_larb_config_port_mt2712,
> > +	.config_port       = mtk_smi_larb_config_port_gen2_general,
> > +	.larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
> >  };
> >  
> >  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> > 
