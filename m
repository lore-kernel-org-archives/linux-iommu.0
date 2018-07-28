From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date: Sat, 28 Jul 2018 14:40:57 +0300
Message-ID: <1710693.gjqKbZupki@dimapc>
References: <20180726231624.21084-1-digetx@gmail.com>
	<20180727170326.GA21283@jcrouse-lnx.qualcomm.com>
	<2402373.RyBdR7VSnO@dimapc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2402373.RyBdR7VSnO@dimapc>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Friday, 27 July 2018 20:16:53 MSK Dmitry Osipenko wrote:
> On Friday, 27 July 2018 20:03:26 MSK Jordan Crouse wrote:
> > On Fri, Jul 27, 2018 at 05:02:37PM +0100, Robin Murphy wrote:
> > > On 27/07/18 15:10, Dmitry Osipenko wrote:
> > > >On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
> > > >>On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
> > > >>>On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> > > >>>>The proposed solution adds a new option to the base device driver
> > > >>>>structure that allows device drivers to explicitly convey to the
> > > >>>>drivers
> > > >>>>core that the implicit IOMMU backing for devices must not happen.
> > > >>>
> > > >>>Why is IOMMU mapping a problem for the Tegra GPU driver?
> > > >>>
> > > >>>If we add something like this then it should not be the choice of the
> > > >>>device driver, but of the user and/or the firmware.
> > > >>
> > > >>Agreed, and it would still need somebody to configure an identity
> > > >>domain
> > > >>so
> > > >>that transactions aren't aborted immediately. We currently allow the
> > > >>identity domain to be used by default via a command-line option, so I
> > > >>guess
> > > >>we'd need a way for firmware to request that on a per-device basis.
> > > >
> > > >The IOMMU mapping itself is not a problem, the problem is the
> > > >management
> > > >of
> > > >the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
> > > >activities because:
> > > >
> > > >1) GPU HW require additional configuration for the IOMMU usage and dumb
> > > >mapping of the allocations simply doesn't work.
> > > 
> > > Generally, that's already handled by the DRM drivers allocating
> > > their own unmanaged domains. The only problem we really need to
> > > solve in that regard is that currently the device DMA ops don't get
> > > updated when moving away from the managed domain. That's been OK for
> > > the VFIO case where the device is bound to a different driver which
> > > we know won't make any explicit DMA API calls, but for the more
> > > general case of IOMMU-aware drivers we could certainly do with a bit
> > > of cooperation between the IOMMU API, DMA API, and arch code to
> > > update the DMA ops dynamically to cope with intermediate subsystems
> > > making DMA API calls on behalf of devices they don't know the
> > > intimate details of.
> > > 
> > > >2) Older Tegra generations have a limited resource and capabilities in
> > > >regards to IOMMU usage, allocating IOMMU domain per-device is just
> > > >impossible for example.
> > > >
> > > >3) HW performs context switches and so particular allocations have to
> > > >be
> > > >assigned to a particular contexts IOMMU domain.
> > > 
> > > I understand Qualcomm SoCs have a similar thing too, and AFAICS that
> > > case just doesn't fit into the current API model at all. We need the
> > > IOMMU driver to somehow know about the specific details of which
> > > devices have magic associations with specific contexts, and we
> > > almost certainly need a more expressive interface than
> > > iommu_domain_alloc() to have any hope of reliable results.
> > 
> > This is correct for Qualcomm GPUs - The GPU hardware context switching
> > requires a specific context and there are some restrictions around
> > secure contexts as well.
> > 
> > We don't really care if the DMA attaches to a context just as long as it
> > doesn't attach to the one(s) we care about. Perhaps a "valid context" mask
> > would work in from the DT or the device struct to give the subsystems a
> > clue as to which domains they were allowed to use. I recognize that there
> > isn't a one-size-fits-all solution to this problem so I'm open to
> > different
> > ideas.
> 
> Designating whether implicit IOMMU backing is appropriate for a device via
[snip]

[I've noticed that this should've been an answer to different message in the 
thread..]

As of the domain type, I don't think that any domain requirements should be 
defined via the DT, that should be purely internal to the kernel drivers. 
Maybe iommu_domain_alloc() could get an additional argument, like some 
platform-specific domain descriptor.

Anyway a custom IOMMU domain type requirements should be a different topic for 
discussion, at least for now (AFAIK) there is no need for that on Tegra and I 
can't suggest anything really constructive about it. Though maybe Mikko could 
give a comment from the Tegra perspective about whether custom domain type 
requirements could be ever needed on Tegra, what those requirements are and 
how it could be implemented.
