From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 15 Dec 2014 18:09:33 +0000
Message-ID: <20141215180933.GW20738@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<6860089.2Ca399bIPK@avalon> <20141215164041.GN20738@arm.com>
	<1612493.xCj1Tx0M4k@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1612493.xCj1Tx0M4k@avalon>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 15, 2014 at 05:16:50PM +0000, Laurent Pinchart wrote:
> On Monday 15 December 2014 16:40:41 Will Deacon wrote:
> > On Sun, Dec 14, 2014 at 03:49:34PM +0000, Laurent Pinchart wrote:
> > > On Wednesday 10 December 2014 15:08:53 Will Deacon wrote:
> > > > On Wed, Dec 10, 2014 at 02:52:56PM +0000, Rob Clark wrote:
> > > > > so, what is the way for a driver that explicitly wants to manage it's
> > > > > own device virtual address space to opt out of this?  I suspect that
> > > > > won't be the common case, but for a gpu, if dma layer all of a sudden
> > > > > thinks it is in control of the gpu's virtual address space, things are
> > > > > going to end in tears..
> > > > 
> > > > I think you'll need to detach from the DMA domain, then have the driver
> > > > manage everything itself. As you say, it's not the common case, so you
> > > > may need to add some hooks for detaching from the default domain and
> > > > swizzling your DMA ops.
> > > 
> > > I'm wondering if it's such an exotic case after all. I can see two reasons
> > > not to use the default domain. In addition to special requirements coming
> > > from the bus master side, the IOMMU itself might not support one domain
> > > per bus master (I'm of course raising the issue from a very selfish
> > > Renesas IPMMU point of view).
> > 
> > Do you mean that certain masters must be grouped into the same domain, or
> > that the IOMMU can fail with -ENOSPC?
> 
> My IOMMU has hardware supports for 4 domains, and serves N masters (where N is 
> dependent on the SoC but is > 4). In its current form the driver supports a 
> single domain and thus detaches devices from the default domain in the 
> add_device callback:

Hmm, ok. Ideally, you wouldn't need to do any of that in the driver, but I
can understand why you decided to go down that route.

> 	/*
> 	 * Detach the device from the default ARM VA mapping and attach it to
> 	 * our private mapping.
> 	 */
> 	arm_iommu_detach_device(dev);
> 	ret = arm_iommu_attach_device(dev, mmu->mapping);
> 	if (ret < 0) {
> 		dev_err(dev, "Failed to attach device to VA mapping\n");
> 		return ret;
> 	}
> 
> I would have implemented that in the of_xlate callback, but that's too early 
> as the ARM default domain isn't created yet at that point.

Yup, the mythical ->get_default_domain might be the right place instead.

> Using a single domain is a bit of a waste of resources in my case, so an 
> evolution would be to create four domains and assign devices to them based on 
> a policy. The policy could be fixed (round-robin for instance), or 
> configurable (possibly through DT, although it's really a policy, not a 
> hardware description).

I think having one default domain, which is home to all of the masters that
don't have any DMA restrictions is a good use of the hardware. That then
leaves you with three domains to cover VFIO, devices with DMA limitations
and potentially device isolation (if we had a way to describe that).

> > For the former, we need a way to represent IOMMU groups for the platform
> > bus.
> 
> To be honest I'm not entirely sure how IOMMU groups are supposed to be used. I 
> understand they can be used by VFIO to group several masters that will be able 
> to see each other's memory through the same page table, and also that a page 
> table could be shared between multiple groups. When it comes to group 
> creation, though, things get fuzzy. I started with creating one group per 
> master in my driver, which is probably not the thing to do. The Exynos IOMMU 
> driver used to do the same, until Marek's patch series converting it to DT-
> based instantiation (on top of your patch set) has removed groups altogether. 
> Groups seem to be more or less optional, except in a couple of places (for 
> instance the remove_device callback will not be called by the 
> BUS_NOTIFY_DEL_DEVICE notifier if the device isn't part of an iommu group).
> 
> I'd appreciate if someone could clarify this to help me make an informed 
> opinion on the topic.

Ok, an iommu_group is the minimum granularity for which a specific IOMMU
can offer address translation. So, if your IPMMU can isolate an arbitrary
device (assuming there is a domain available), then each device is in its
own iommu_group. This isn't always the case, for example if two masters are
behind some sort of bridge that makes them indistinguishable to the IOMMU
(perhaps they appear to have the same master ID), then they would have to
be in the same iommu_group. Essentially, iommu_groups are a property of
the hardware and should be instantiated by the bus. PCI does this, but
we don't yet have anything for the platform bus.

VFIO puts multiple groups (now called vfio_groups) into a container. The
container is synoymous to an iommu_domain (i.e. a shared address space).

Will
