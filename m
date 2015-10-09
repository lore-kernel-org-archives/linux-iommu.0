From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Fri, 9 Oct 2015 13:44:53 +0800
Message-ID: <1444369493.24380.53.camel@mhfsdcap03>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
	<1444129203.6621.46.camel@mhfsdcap03> <56154349.8040101@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56154349.8040101-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-10-07 at 17:07 +0100, Robin Murphy wrote:
> On 06/10/15 12:00, Yong Wu wrote:
> > On Thu, 2015-10-01 at 20:13 +0100, Robin Murphy wrote:
> >> Taking some inspiration from the arch/arm code, implement the
> >> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> >>
> >> Since there is still work to do elsewhere to make DMA configuration happen
> >> in a more appropriate order and properly support platform devices in the
> >> IOMMU core, the device setup code unfortunately starts out carrying some
> >> workarounds to ensure it works correctly in the current state of things.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>   arch/arm64/mm/dma-mapping.c | 435 ++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 435 insertions(+)
> >>
> > [...]
> >> +/*
> >> + * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
> >> + * everything it needs to - the device is only partially created and the
> >> + * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
> >> + * need this delayed attachment dance. Once IOMMU probe ordering is sorted
> >> + * to move the arch_setup_dma_ops() call later, all the notifier bits below
> >> + * become unnecessary, and will go away.
> >> + */
> >
> > Hi Robin,
> >        Could I ask a question about the plan in the future:
> >        How to move arch_setup_dma_ops() call later than IOMMU probe?
> >
> >        arch_setup_dma_ops is from of_dma_configure which is from
> > arm64_device_init, and IOMMU probe is subsys_init. So
> > arch_setup_dma_ops will run before IOMMU probe normally, is it right?
> 
> Yup, hence the need to call of_platform_device_create() manually in your 
> IOMMU_OF_DECLARE init function if you need the actual device instance to 
> be ready before the root of_platform_populate() runs.

Thanks. I have added of_platform_device_create.

If the arch_setup_dma_ops always be called before IOMMU probe, What's
the meaning of the TODO comment here?  Does the arch_setup_dma_ops()
will be moved to run later than IOMMU probe? How to do this.

> 
> >        Does Laurent's probe-deferral series could help do this? what's
> > the state of this series.
> 
> What Laurent's patches do is to leave the DMA mask configuration where 
> it is early in device creation, but split out the dma_ops configuration 
> to be called just before the actual driver probe, and defer that if the 
> IOMMU device hasn't probed yet. At the moment, those patches (plus a bit 
> of my own development on top) are working fairly well in the simple 
> case, but I've seen things start falling apart if the client driver then 
> requests its own probe deferral, and there are probably other 
> troublesome edge cases to find - I need to dig into that further, but 
> sorting out my ARM SMMU driver patches is currently looking like a 
> higher priority.
> 
> >> +struct iommu_dma_notifier_data {
> >> +	struct list_head list;
> >> +	struct device *dev;
> >> +	const struct iommu_ops *ops;
> >> +	u64 dma_base;
> >> +	u64 size;
> >> +};
> [...]
> >> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >> +				  const struct iommu_ops *ops)
> >> +{
> >> +	struct iommu_group *group;
> >> +
> >> +	if (!ops)
> >> +		return;
> >> +	/*
> >> +	 * TODO: As a concession to the future, we're ready to handle being
> >> +	 * called both early and late (i.e. after bus_add_device). Once all
> >> +	 * the platform bus code is reworked to call us late and the notifier
> >> +	 * junk above goes away, move the body of do_iommu_attach here.
> >> +	 */
> >> +	group = iommu_group_get(dev);
> >
> >     If iommu_setup_dma_ops run after bus_add_device, then the device has
> > its group here. It will enter do_iommu_attach which will alloc a default
> > iommu domain and attach this device to the new iommu domain.
> >     But mtk-iommu don't expect like this, we would like to attach to the
> > same domain. So we should alloc a default iommu domain(if there is no
> > iommu domain at that time) and attach the device to the same domain in
> > our xx_add_device, is it right?
> 
> Yes, if you attach the device to your own 'real' default domain after 
> setting up the group in add_device, then do_iommu_attach() will now pick 
> that domain up and use it instead of trying to create a new one, and the 
> arch code will stop short of tearing the domain down if the device probe 
> fails and it gets detached again. Additionally, since from add_device 
> you should hopefully have all the information you need to get back to 
> the relevant m4u instance, it should now be OK to keep the default 
> domain there and finally get rid of that pesky global variable.
> 
> Robin.

Thanks very much for your confirm.

I have added it following this. As above, the arch_setup_dma_ops always
be called before IOMMU probe, so the attach_device will be called
earlier than probe and the iommu domain will exist already in
add_device.

Meanwhile I attach all the iommu devices into the same domain in the
add_device and free the other unnecessary domains in the attach_device.

Here I wrote may be not clear, so I send the detail code[1]. when you
are free, please also help have a look.

Currently it's based on the condition that arch_setup_dma_ops run before
IOMMU probe, But from your TODO comment, the sequence of
arch_setup_dma_ops may be changed. this series is not a final version?
You also question me "how can you guarantee domain_alloc() happens
before this driver is probed?". So I am a little confused this TODO.

[1]:http://lists.linuxfoundation.org/pipermail/iommu/2015-October/014591.html

> 
> >> +	if (group) {
> >> +		do_iommu_attach(dev, ops, dma_base, size);
> >> +		iommu_group_put(group);
> >> +	} else {
> >> +		queue_iommu_attach(dev, ops, dma_base, size);
> >> +	}
> >> +}
> >> +
> >> +#else
> >> +
> >> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >> +				  struct iommu_ops *iommu)
> >> +{ }
> >> +
> >> +#endif  /* CONFIG_IOMMU_DMA */
> >> +
> >
> 
