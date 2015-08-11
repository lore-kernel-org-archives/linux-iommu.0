From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
Date: Tue, 11 Aug 2015 11:49:51 +0200
Message-ID: <20150811094951.GD14980@8bytes.org>
References: <cover.1438362603.git.robin.murphy@arm.com>
	<8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
	<20150807085233.GV14980@8bytes.org> <55C4CE7C.7050205@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C4CE7C.7050205-5wv7dgnIgG8@public.gmane.org>
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
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 07, 2015 at 04:27:56PM +0100, Robin Murphy wrote:
> As per the comments, the issue here lies in the order in which the
> OF/driver core code currently calls things for platform devices: as
> it stands we can't attach the device to a domain in
> arch_setup_dma_ops() because it doesn't have a group, and we can't
> even add it to a group ourselves because it isn't fully created and
> doesn't exist in sysfs yet. The only reason arch/arm is currently
> getting away without this workaround is that the few IOMMU drivers
> there hooked up to the generic infrastructure don't actually mind
> that they get an attach_device from arch_setup_dma_ops() before
> they've even seen an add_device (largely because they don't care
> about groups).

Hmm, what about just registering the iommu-driver in arch_setup_dma_ops
with bus_set_iommu and not care about devices? The code will iterate
over the devices already on the bus and tries to attach them to the
iommu driver. But as you said, the devices are not yet on the bus, so
when a device is later added by the OF/driver core code you can do
everything needed for the device in the add_device call-back.

This might include initializing the hardware iommu needed for the
device and setting its per-device dma_ops.

> Laurent's probe-deferral series largely solves these problems in the
> right place - adding identical boilerplate code to every IOMMU
> driver to do something they shouldn't have to know about (and don't
> necessarily have all the right information for) is exactly what we
> don't want to do. As discussed over on another thread, I'm planning
> to pick that series up and polish it off after this, but my top
> priority is getting the basic dma_ops functionality into arm64 that
> people need right now. I will be only too happy when I can submit
> the patch removing this notifier workaround ;)

I've experienced it often that someone promises me to fix things later,
but that it doesn't happen then, so please understand that I am pretty
cautious about adding such hacks ;)

> No driver other than the AMD IOMMU has any support yet. Support for
> IOMMU_DOMAIN_DMA can easily be added to existing drivers based on
> patch 1 of this series, but more generally it's not entirely clear
> how default domains are going to work beyond x86. On systems like
> Juno or Seattle with different sets of masters behind different
> IOMMU instances (with limited domain contexts each), the most
> sensible approach would be to have a single default domain per IOMMU
> (spanning domains across instances would need some hideous
> synchronisation logic for some implementations), but the current
> domain_alloc interface gives us no way to do that. On something like
> RK3288 with two different types of IOMMU on the platform "bus", it
> breaks down even further as there's no way to guarantee that
> iommu_domain_alloc() even gives you a domain from the right *driver*
> (hence bypassing it by going through ops directly here).

Default domain allocation comes down to how the bus organizes its
iommu-groups. For every group (at least in its current design) a default
domain is allocated. An a group is typically only behind a single iommu
instance.

> Only for PCI devices, via iommu_group_get_for_pci_dev(). The code
> here, however, only runs for platform devices - ops will be always
> null for a PCI device since of_iommu_configure() will have bailed
> out (see the silly warning removed by my patch you picked up the
> other day). Once iommu_group_get_for_dev() supports platform
> devices, this too can go away. In the meantime if someone adds PCI
> support to of_iommu_configure() and IOMMU_DOMAIN_DMA support to
> their IOMMU driver, then we'll get a domain back from
> iommu_get_domain_for_dev() and just use that.

What is the plan for getting an iommu-groups implementation for the
platform bus?


	Joerg
