From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 08/16] iommu/exynos: gating clocks of master H/W
Date: Fri, 09 Aug 2013 16:42:04 +0900
Message-ID: <20130809164204.49dc7fb10c5d5d9480db75b7@samsung.com>
References: <002c01ce941b$1fd0ab80$5f720280$@samsung.com>
	<7908536.azGeeOL56k@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <7908536.azGeeOL56k@flatron>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 09 Aug 2013 00:45:17 +0200, Tomasz Figa wrote:
> Hi KyongHo,
> 
> On Thursday 08 of August 2013 18:39:05 Cho KyongHo wrote:
> > This patch gates clocks of master H/W as well as clocks of System MMU
> > if master clocks are specified.
> > 
> > Some Exynos SoCs (i.e. GScalers in Exynos5250) have dependencies in
> > the gating clocks of master H/W and its System MMU. If a H/W is the
> > case, accessing control registers of System MMU is prohibited unless
> > both of the gating clocks of System MMU and its master H/W.
> > 
> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/exynos-iommu.c |   38
> > ++++++++++++++++++++++++++++++++++---- 1 files changed, 34
> > insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 0ee73e8..005a7ed 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -173,6 +173,7 @@ struct sysmmu_drvdata {
> >  	struct device *dev;	/* Owner of system MMU */
> >  	int nsfrs;
> >  	struct clk *clk;
> > +	struct clk *clk_master;
> >  	int activations;
> >  	rwlock_t lock;
> >  	struct iommu_domain *domain;
> > @@ -263,6 +264,8 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
> >  	if (!is_sysmmu_active(data))
> >  		goto finish;
> > 
> > +	clk_enable(data->clk_master);
> > +
> >  	for (i = 0; i < data->nsfrs; i++) {
> >  		if ((readl(data->sfrbases[i] + REG_MMU_VERSION) >> 28) == 
> 3) {
> >  			if (!sysmmu_block(data->sfrbases[i]))
> > @@ -288,6 +291,8 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
> >  			sysmmu_unblock(data->sfrbases[i]);
> >  		}
> >  	}
> > +
> > +	clk_disable(data->clk_master);
> >  finish:
> >  	read_unlock_irqrestore(&data->lock, flags);
> >  }
> > @@ -358,6 +363,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void
> > *dev_id) break;
> >  	}
> > 
> > +	clk_enable(data->clk_master);
> > +
> >  	if (i == pdev->num_resources) {
> >  		itype = SYSMMU_FAULT_UNKNOWN;
> >  	} else {
> > @@ -391,6 +398,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void
> > *dev_id) if (itype != SYSMMU_FAULT_UNKNOWN)
> >  		sysmmu_unblock(data->sfrbases[i]);
> > 
> > +	clk_disable(data->clk_master);
> > +
> >  	read_unlock(&data->lock);
> > 
> >  	return IRQ_HANDLED;
> > @@ -407,11 +416,14 @@ static bool __exynos_sysmmu_disable(struct
> > sysmmu_drvdata *data) if (!set_sysmmu_inactive(data))
> >  		goto finish;
> > 
> > +	clk_enable(data->clk_master);
> > +
> >  	for (i = 0; i < data->nsfrs; i++)
> >  		__raw_writel(CTRL_DISABLE, data->sfrbases[i] + 
> REG_MMU_CTRL);
> > 
> > -	if (data->clk)
> > -		clk_disable(data->clk);
> > +	clk_disable(data->clk_master);
> > +
> > +	clk_disable(data->clk);
> > 
> >  	disabled = true;
> >  	data->pgtable = 0;
> > @@ -454,11 +466,12 @@ static int __exynos_sysmmu_enable(struct
> > sysmmu_drvdata *data, goto finish;
> >  	}
> > 
> > -	if (data->clk)
> > -		clk_enable(data->clk);
> > +	clk_enable(data->clk);
> > 
> >  	data->pgtable = pgtable;
> > 
> > +	clk_enable(data->clk_master);
> > +
> >  	for (i = 0; i < data->nsfrs; i++) {
> >  		__sysmmu_set_ptbase(data->sfrbases[i], pgtable);
> > 
> > @@ -473,6 +486,8 @@ static int __exynos_sysmmu_enable(struct
> > sysmmu_drvdata *data, __raw_writel(CTRL_ENABLE, data->sfrbases[i] +
> > REG_MMU_CTRL); }
> > 
> > +	clk_disable(data->clk_master);
> > +
> >  	data->domain = domain;
> > 
> >  	dev_dbg(data->sysmmu, "Enabled\n");
> > @@ -528,6 +543,7 @@ static void sysmmu_tlb_invalidate_entry(struct
> > device *dev, unsigned long iova)
> > 
> >  	if (is_sysmmu_active(data)) {
> >  		int i;
> > +		clk_enable(data->clk_master);
> >  		for (i = 0; i < data->nsfrs; i++) {
> >  			if (sysmmu_block(data->sfrbases[i])) {
> >  				__sysmmu_tlb_invalidate_entry(
> > @@ -535,6 +551,7 @@ static void sysmmu_tlb_invalidate_entry(struct
> > device *dev, unsigned long iova) sysmmu_unblock(data->sfrbases[i]);
> >  			}
> >  		}
> > +		clk_disable(data->clk_master);
> >  	} else {
> >  		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating 
> TLB.\n");
> >  	}
> > @@ -551,12 +568,14 @@ void exynos_sysmmu_tlb_invalidate(struct device
> > *dev)
> > 
> >  	if (is_sysmmu_active(data)) {
> >  		int i;
> > +		clk_enable(data->clk_master);
> >  		for (i = 0; i < data->nsfrs; i++) {
> >  			if (sysmmu_block(data->sfrbases[i])) {
> >  				__sysmmu_tlb_invalidate(data-
> >sfrbases[i]);
> >  				sysmmu_unblock(data->sfrbases[i]);
> >  			}
> >  		}
> > +		clk_disable(data->clk_master);
> >  	} else {
> >  		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating 
> TLB.\n");
> >  	}
> > @@ -637,6 +656,17 @@ static int __init exynos_sysmmu_probe(struct
> > platform_device *pdev) return ret;
> >  	}
> > 
> > +	data->clk_master = devm_clk_get(dev, "master");
> > +	if (IS_ERR(data->clk_master))
> > +		data->clk_master = NULL;
> > +
> > +	ret = clk_prepare(data->clk_master);
> > +	if (ret) {
> > +		clk_unprepare(data->clk);
> > +		dev_err(dev, "Failed to prepare master's clk\n");
> > +		return ret;
> > +	}
> > +
> >  	rwlock_init(&data->lock);
> >  	INIT_LIST_HEAD(&data->node);
> 
> This should be done in a more appropriate way, but at the moment the PM 
> Core doesn't have any provision to implement any sane solution for this 
> kind of problems, so this is fine.
> 

I think it is just a work-around of H/W restriction that System MMU
can be accessed and work if the both clocks of System MMU and master IP
are ungated.
Exynos4210/4412 does not have the restriction.
Some H/W in Exynos5250, Exynos5420 have the restriction.

> Reviewed-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Thanks.
> 
> Best regards,
> Tomasz
> 
