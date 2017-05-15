From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
	deferred probing or error
Date: Tue, 16 May 2017 00:34:18 +0300
Message-ID: <1804176.uxVOFWagsb@avalon>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
	<26defadf-6380-4af4-6323-b51198376bc1@codeaurora.org>
	<1900421.tkAiezvoW8@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1900421.tkAiezvoW8@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,

On Monday 15 May 2017 23:37:16 Laurent Pinchart wrote:
> On Wednesday 03 May 2017 15:54:59 Sricharan R wrote:
> > On 5/3/2017 3:24 PM, Robin Murphy wrote:
> >> On 02/05/17 19:35, Geert Uytterhoeven wrote:
> >>> On Fri, Feb 3, 2017 at 4:48 PM, Sricharan R wrote:
> >>>> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> >>>> 
> >>>> Failures to look up an IOMMU when parsing the DT iommus property need
> >>>> to be handled separately from the .of_xlate() failures to support
> >>>> deferred probing.
> >>>> 
> >>>> The lack of a registered IOMMU can be caused by the lack of a driver
> >>>> for the IOMMU, the IOMMU device probe not having been performed yet,
> >>>> having been deferred, or having failed.
> >>>> 
> >>>> The first case occurs when the device tree describes the bus master
> >>>> and IOMMU topology correctly but no device driver exists for the IOMMU
> >>>> yet or the device driver has not been compiled in. Return NULL, the
> >>>> caller will configure the device without an IOMMU.
> >>>> 
> >>>> The second and third cases are handled by deferring the probe of the
> >>>> bus master device which will eventually get reprobed after the IOMMU.
> >>>> 
> >>>> The last case is currently handled by deferring the probe of the bus
> >>>> master device as well. A mechanism to either configure the bus master
> >>>> device without an IOMMU or to fail the bus master device probe
> >>>> depending on whether the IOMMU is optional or mandatory would be a good
> >>>> enhancement.
> >>>> 
> >>>> Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>>> Signed-off-by: Laurent Pichart
> >>>> <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> >>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>> 
> >>> This patch broke Renesas R-Car Gen3 platforms in renesas-drivers.
> >>> As the IOMMU nodes in DT are not yet enabled, all devices having iommus
> >>> properties in DT now fail to probe.
> >> 
> >> How exactly do they fail to probe? Per d7b0558230e4, if there are no ops
> >> registered then they should merely defer until we reach the point of
> >> giving up and ignoring the IOMMU. Is it just that you have no other
> >> late-probing drivers or post-init module loads to kick the deferred
> >> queue after that point? I did try to find a way to explicitly kick it
> >> from a suitably late initcall, but there didn't seem to be any obvious
> >> public interface - anyone have any suggestions?
> >> 
> >> I think that's more of a general problem with the probe deferral
> >> mechanism itself (I've seen the same thing happen with some of the
> >> CoreSight stuff on Juno due to the number of inter-component
> >> dependencies) rather than any specific fault of this series.
> > 
> > I was thinking of an additional check like below to avoid the
> > situation ?
> > 
> > From 499b6e662f60f23740b8880882b0a16f16434501 Mon Sep 17 00:00:00 2001
> > From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Date: Wed, 3 May 2017 13:16:59 +0530
> > Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
> > 
> > While returning EPROBE_DEFER for iommu masters
> > take in to account of iommu nodes that could be
> > marked in DT as 'status=disabled', in which case
> > simply return NULL and let the master's probe
> > continue rather than deferring.
> > 
> > Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > ---
> > 
> >  drivers/iommu/of_iommu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 9f44ee8..e6e9bec 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node
> > *np)
> > 
> >         ops = iommu_ops_from_fwnode(fwnode);
> >         if ((ops && !ops->of_xlate) ||
> > +           !of_device_is_available(iommu_spec->np) ||
> >             (!ops && !of_iommu_driver_present(iommu_spec->np)))
> >                 return NULL;
> 
> This looks good to me, but won't be enough. The ipmmu-vmsa driver in
> v4.12-rc1 doesn't call iommu_device_register() and thus won't be found by
> iommu_ops_from_fwnode(). Furthermore, it doesn't IOMMU_OF_DECLARE(), and
> thus will always be considered as absent.
> 
> I agree that the ipmmu-vmsa driver needs to be fixed, but it would have been
> nice to check existing IOMMU drivers before merging this patch series...

Please pardon the question, but has this patch series been tested on ARM32 ?

When the device is probed the arch_setup_dma_ops() function is called. It sets 
the device's dma_ops and the mapping (in __arm_iommu_attach_device()). If 
probe is deferred, arch_teardown_dma_ops() is called which in turn calls 
arch_teardown_dma_ops(). This removes the mapping but doesn't touch the 
dma_ops. The next time the device is probed, arch_setup_dma_ops() bails out 
immediately as the dma_ops are already set, leaving us with a device bound to 
IOMMU operations but with no mapping. This oopses later as soon as the kernel 
tries to map memory for the device through the IOMMU.

I might be missing something obvious, but I don't see how this can work.

> >>> This can be fixed by either:
> >>>   - Disabling CONFIG_IPMMU_VMSA, or
> >>>   - Reverting commit 7b07cbefb68d486f (but keeping "int ret = 0;").
> >>> 
> >>> Note that this was a bit hard to investigate, as R-Car Gen3 support
> >>> wasn't upstreamed yet, so bisection pointed to a merge commit.

-- 
Regards,

Laurent Pinchart
