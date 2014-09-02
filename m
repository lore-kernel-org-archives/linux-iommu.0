From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Tue, 2 Sep 2014 12:03:40 +0100
Message-ID: <20140902110340.GI25379@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-5-git-send-email-will.deacon@arm.com>
	<1485866.XbpZvVaUr8@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1485866.XbpZvVaUr8@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 02, 2014 at 11:51:54AM +0100, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

> On Friday 29 August 2014 16:54:27 Will Deacon wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index dd5112265cc9..6d13f962f156 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -15,7 +15,7 @@ if IOMMU_SUPPORT
> > 
> >  config OF_IOMMU
> >         def_bool y
> > -       depends on OF
> > +       depends on OF && IOMMU_API
> > 
> >  config FSL_PAMU
> >  	bool "Freescale IOMMU support"
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index f9209666157c..a7d3b3a13b83 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -19,6 +19,7 @@
> > 
> >  #include <linux/export.h>
> >  #include <linux/limits.h>
> > +#include <linux/iommu.h>
> 
> Pet peeve of mine, how about keeping the headers alphabetically sorted ?

D'oh, I'm an idiot. Will fix.

> >  #include <linux/of.h>
> >  #include <linux/of_iommu.h>
> > 
> > @@ -90,6 +91,41 @@ int of_get_dma_window(struct device_node *dn, const char
> > *prefix, int index, }
> >  EXPORT_SYMBOL_GPL(of_get_dma_window);
> > 
> > +int of_iommu_configure(struct device *dev)
> > +{
> > +	struct of_phandle_args iommu_spec;
> > +	struct bus_type *bus = dev->bus;
> > +	const struct iommu_ops *ops = bus->iommu_ops;
> > +	int ret = -EINVAL, idx = 0;
> > +
> > +	if (!iommu_present(bus))
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * We don't currently walk up the tree looking for a parent IOMMU.
> > +	 * See the `Notes:' section of
> > +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> > +	 */
> > +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> > +					   "#iommu-cells", idx,
> > +					   &iommu_spec)) {
> > +		void *data = of_iommu_get_data(iommu_spec.np);
> > +
> > +		of_node_put(iommu_spec.np);
> > +		if (!ops->add_device_master_ids)
> > +			return -ENODEV;
> 
> Can't you move this outside of the loop ?

Yup, done.

> > +
> > +		ret = ops->add_device_master_ids(dev, iommu_spec.args_count,
> > +						 iommu_spec.args, data);
> 
> I'm curious, how do you envision support for devices connected to multiple 
> IOMMUs ? IOMMU drivers usually allocate a per-device archdata structure in the 
> add_device operation and store it in the dev->archdata.iommu field. How would 
> that work with multiple invocations of add_device or add_device_master_ids ?

Even devices with a single IOMMU could have multiple callbacks, since the
IOMMU gets called back once per ID in reality. That means the IOMMU drivers
will need to be tolerant of adding a master they already know about (by
looking up the device and adding the additional IDs).

Once I've reworked the data argument to be a struct iommu, we can add fields
there if they're generally useful.

Will
