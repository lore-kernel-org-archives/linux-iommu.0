From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 14/16] iommu/exynos: add support for power management
	subsystems.
Date: Fri, 09 Aug 2013 10:32:40 +0200
Message-ID: <3833452.V3JQdooaWE@flatron>
References: <003201ce941b$6e5a90e0$4b0fb2a0$@samsung.com>
	<1949492.N82v2nAcIY@flatron>
	<20130809164943.fe4b673e92b3f7680562f29b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130809164943.fe4b673e92b3f7680562f29b-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Friday 09 of August 2013 16:49:43 Cho KyongHo wrote:
> On Fri, 09 Aug 2013 01:03:05 +0200, Tomasz Figa wrote:
> > Hi KyongHo,
> > 
> > nit: Please drop the trailing dot at the end of patch subject.
> 
> Oh. I didn't catch that.
> Thank you.
> 
> > On Thursday 08 of August 2013 18:41:17 Cho KyongHo wrote:
> > > This adds support for Advance Power Management and Runtime Power
> > > Management.
> > 
> > This patch adds support for system-wide and runtime power management.
> 
> Ok.
> 
> > > Since System MMU is located in the same local power domain of its
> > > master H/W, System MMU must be initialized before it is working if
> > > its power domain was ever turned off. TLB invalidation according to
> > > unmapping on page tables must also be performed while power domain
> > > is
> > > turned on.
> > > 
> > > This patch ensures that resume and runtime_resume(restore_state)
> > > functions in this driver is called before the calls to resume and
> > > runtime_resume callback functions in the drivers of master H/Ws.
> > > Likewise, suspend and runtime_suspend(save_state) functions in this
> > > driver is called after the calls to suspend and runtime_suspend in
> > > the
> > > drivers of master H/Ws.
> > > 
> > > In order to get benefit of this support, the master H/W and its
> > > System
> > > MMU must resides in the same power domain in terms of Linux kernel.
> > > If
> > > a master H/W does not use generic I/O power domain, its driver must
> > > call iommu_attach_device() after its local power domain is turned
> > > on,
> > > iommu_detach_device before turned off.
> > 
> > I don't get the point of this last paragraph. What a power domain can
> > be in other terms? Is there any other way to support power domains on
> > Exynos than generic power domains?
> 
> I just addressed the case a device driver turns off local power of its
> device without the help of generic I/O powerdomain.

Out of curiosity, do we have such cases for Exynos in mainline kernel? 
IMHO this is what the generic PM core is for and drivers shouldn't care 
about such low level PM details.

> > > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > > 
> > >  drivers/iommu/exynos-iommu.c |  235
> > > 
> > > +++++++++++++++++++++++++++++++++++++++++- 1 files changed, 231
> > > insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/exynos-iommu.c
> > > b/drivers/iommu/exynos-iommu.c index 9e64483..56aead9 100644
> > > --- a/drivers/iommu/exynos-iommu.c
> > > +++ b/drivers/iommu/exynos-iommu.c
> > > @@ -28,6 +28,7 @@
> > > 
> > >  #include <linux/export.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_platform.h>
> > > 
> > > +#include <linux/pm_domain.h>
> > > 
> > >  #include <linux/notifier.h>
> > >  
> > >  #include <asm/cacheflush.h>
> > > 
> > > @@ -186,6 +187,7 @@ struct sysmmu_drvdata {
> > > 
> > >  	int activations;
> > >  	rwlock_t lock;
> > >  	struct iommu_domain *domain;
> > > 
> > > +	bool runtime_active;
> > > 
> > >  	unsigned long pgtable;
> > >  	void __iomem *sfrbases[0];
> > >  
> > >  };
> > > 
> > > @@ -438,7 +440,8 @@ static bool __sysmmu_disable(struct
> > > sysmmu_drvdata
> > > *data) data->pgtable = 0;
> > > 
> > >  		data->domain = NULL;
> > > 
> > > -		__sysmmu_disable_nocount(data);
> > > +		if (data->runtime_active)
> > > +			__sysmmu_disable_nocount(data);
> > > 
> > >  		dev_dbg(data->sysmmu, "Disabled\n");
> > >  	
> > >  	} else  {
> > > 
> > > @@ -505,7 +508,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata
> > > *data, data->pgtable = pgtable;
> > > 
> > >  		data->domain = domain;
> > > 
> > > -		__sysmmu_enable_nocount(data);
> > > +		if (data->runtime_active)
> > > +			__sysmmu_enable_nocount(data);
> > > 
> > >  		dev_dbg(data->sysmmu, "Enabled\n");
> > >  	
> > >  	} else {
> > > 
> > > @@ -609,7 +613,7 @@ static void sysmmu_tlb_invalidate_entry(struct
> > > device *dev, unsigned long iova) data =
> > > dev_get_drvdata(client->sysmmu[i]);
> > > 
> > >  		read_lock_irqsave(&data->lock, flags);
> > > 
> > > -		if (is_sysmmu_active(data)) {
> > > +		if (is_sysmmu_active(data) && data->runtime_active) {
> > > 
> > >  			int i;
> > >  			clk_enable(data->clk_master);
> > >  			for (i = 0; i < data->nsfrs; i++)
> > > 
> > > @@ -637,7 +641,8 @@ void exynos_sysmmu_tlb_invalidate(struct device
> > > *dev) data = dev_get_drvdata(client->sysmmu[i]);
> > > 
> > >  		read_lock_irqsave(&data->lock, flags);
> > > 
> > > -		if (is_sysmmu_active(data)) {
> > > +		if (is_sysmmu_active(data) &&
> > > +				data->runtime_active) {
> > 
> > nit: The whole if condition fits into single line.
> 
> Ok.
> 
> > >  			int i;
> > >  			for (i = 0; i < data->nsfrs; i++) {
> > >  			
> > >  				clk_enable(data->clk_master);
> > > 
> > > @@ -711,6 +716,8 @@ static int __init exynos_sysmmu_probe(struct
> > > platform_device *pdev) }
> > > 
> > >  	}
> > > 
> > > +	pm_runtime_enable(dev);
> > > +
> > > 
> > >  	data->sysmmu = dev;
> > >  	
> > >  	data->clk = devm_clk_get(dev, "sysmmu");
> > > 
> > > @@ -736,6 +743,8 @@ static int __init exynos_sysmmu_probe(struct
> > > platform_device *pdev) return ret;
> > > 
> > >  	}
> > > 
> > > +	data->runtime_active = !pm_runtime_enabled(dev);
> > > +
> > > 
> > >  	rwlock_init(&data->lock);
> > >  	
> > >  	platform_set_drvdata(pdev, data);
> > > 
> > > @@ -744,6 +753,34 @@ static int __init exynos_sysmmu_probe(struct
> > > platform_device *pdev) return ret;
> > > 
> > >  }
> > > 
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int sysmmu_suspend(struct device *dev)
> > > +{
> > > +	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> > > +	unsigned long flags;
> > > +	read_lock_irqsave(&data->lock, flags);
> > > +	if (is_sysmmu_active(data) &&
> > > +		(!pm_runtime_enabled(dev) || data->runtime_active))
> > > +		__sysmmu_disable_nocount(data);
> > > +	read_unlock_irqrestore(&data->lock, flags);
> > > +	return 0;
> > > +}
> > > +
> > > +static int sysmmu_resume(struct device *dev)
> > > +{
> > > +	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> > > +	unsigned long flags;
> > > +	read_lock_irqsave(&data->lock, flags);
> > > +	if (is_sysmmu_active(data) &&
> > > +		(!pm_runtime_enabled(dev) || data->runtime_active))
> > > +		__sysmmu_enable_nocount(data);
> > > +	read_unlock_irqrestore(&data->lock, flags);
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > > +static SIMPLE_DEV_PM_OPS(sysmmu_pm_ops, sysmmu_suspend,
> > > sysmmu_resume); +
> > > 
> > >  #ifdef CONFIG_OF
> > >  static struct of_device_id sysmmu_of_match[] __initconst = {
> > >  
> > >  	{ .compatible	= "samsung,exynos4210-sysmmu", },
> > > 
> > > @@ -756,6 +793,7 @@ static struct platform_driver
> > > exynos_sysmmu_driver
> > > __refdata = { .driver	= {
> > > 
> > >  		.owner		= THIS_MODULE,
> > >  		.name		= "exynos-sysmmu",
> > > 
> > > +		.pm		= &sysmmu_pm_ops,
> > > 
> > >  		.of_match_table	= of_match_ptr(sysmmu_of_match),
> > >  	
> > >  	}
> > >  
> > >  };
> > > 
> > > @@ -1141,6 +1179,163 @@ static int __init exynos_iommu_init(void)
> > > 
> > >  }
> > >  subsys_initcall(exynos_iommu_init);
> > > 
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int sysmmu_pm_genpd_suspend(struct device *dev)
> > > +{
> > > +	struct exynos_iommu_client *client = dev->archdata.iommu;
> > > +	int ret = 0;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < client->num_sysmmu; i++) {
> > > +		ret = pm_generic_suspend(client->sysmmu[i]);
> > > +		if (ret)
> > > +			break;
> > > +	}
> > > +
> > > +	if (!ret)
> > > +		ret = pm_generic_suspend(dev);
> > > +
> > > +	if (ret) {
> > > +		int j;
> > > +
> > > +		for (j = 0; j < i; j++)
> > > +			pm_generic_resume(client->sysmmu[j]);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sysmmu_pm_genpd_resume(struct device *dev)
> > > +{
> > > +	struct exynos_iommu_client *client = dev->archdata.iommu;
> > > +	int ret = 0;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < client->num_sysmmu; i++) {
> > > +		ret = pm_generic_resume(client->sysmmu[i]);
> > > +		if (ret)
> > > +			break;
> > 
> > Error handling here can be cleaned up a lot.
> > 
> > s/break/goto err_suspend/
> > 
> > > +	}
> > > +
> > > +	if (!ret)
> > 
> > Now you can drop this check.
> > 
> > > +		ret = pm_generic_resume(dev);
> > 	
> > 	ret = pm_generic_resume(dev);
> > 	if (ret)
> > 	
> > 		goto err_suspend;
> > 	
> > 	return 0;
> > 	
> > > +
> > 
> > err_suspend:
> > > +	if (ret) {
> > 
> > This check can be dropped here as well now.
> 
> Ok.
> 
> Let me think about it :)

Thanks.

Best regards,
Tomasz
