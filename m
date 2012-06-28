From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 19:19:52 +0200
Message-ID: <1340903992.1348.27.camel@antimon>
References: <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
	<4FEA6E09.30800@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	<4FEA7472.7050201@nvidia.com>
	<20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
	<20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
	<1340812795.1350.7.camel@antimon>
	<20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>
	<4FEC8B91.6010107@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FEC8B91.6010107-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Donnerstag, den 28.06.2012, 10:51 -0600 schrieb Stephen Warren:
> On 06/28/2012 05:12 AM, Thierry Reding wrote:
> > On Wed, Jun 27, 2012 at 05:59:55PM +0200, Lucas Stach wrote:
> >> Am Mittwoch, den 27.06.2012, 16:44 +0200 schrieb Thierry Reding:
> ...
> >>> In the ideal case I would want to not have a carveout size at
> >>> all. However there may be situations where you need to make
> >>> sure some driver can allocate a given amount of memory. Having
> >>> to specify this using a kernel command-line parameter is
> >>> cumbersome because it may require changes to the bootloader or
> >>> whatever. So if you know that a particular board always needs
> >>> 128 MiB of carveout, then it makes sense to specify it on a
> >>> per-board basis.
> >> 
> >> If we go with CMA, this is a non-issue, as CMA allows to use the
> >> contig area for normal allocations and only purges them if it
> >> really needs the space for contig allocs.
> > 
> > CMA certainly sounds like the most simple approach. While it may
> > not be suited for 3D graphics or multimedia processing later on, I
> > think we could use it at a starting point to get basic framebuffer
> > and X support up and running. We can always move to something more
> > advanced like TTM later.
> 
> I thought the whole purpose of CMA was to act as the infra-structure
> to provide buffers to 3D, camera, etc. in particular allowing sharing
> of buffers between them. In other words, isn't CMA the memory manager?
> If there's some deficiency with CMA for 3D graphics, it seems like
> that should be raised with those designing CMA. Or, am I way off base
> with my expectations of CMA?
> 
CMA is just a way of providing large contiguous address space blocks in
a dynamic fashion. The problem CMA solves is: we have a system with
relatively low amounts of sysmem (like 512MB), now to ensure we can
always get large contiguous buffers for use by GPU or VIDEO blocks, we
need to set aside a relatively large contiguous pool (like 128MB). So we
are stealing 128MB of memory from the system while we may or may not use
it, which is bad.
Now CMA allows to say: I may need 128MB of contig space, but the system
is free to use it as normal memory as long as I don't really need it. If
the space is really needed, CMA purges pages from the area and may even
swap them out. So yes CMA is a memory allocator for contig memory.

TTM though solves more advanced matters, like buffer synchronisation
between 3D and 2D block of hardware or syncing buffer access between GPU
and CPU.
One of the most interesting things of TTM is the ability to purge the
GPU DMA buffers to scattered sysmem or even swap them out, if they are
not currently used by the GPU. It then makes sure to move them in the
contig space again when the GPU really needs them and fix up the GPU
command stream with the new buffer address.

IMHO the best solution would be to use CMA as a flexible replacement of
the static carveout area and put TTM on top of this to solve the needs
of graphics drivers. We certainly don't want to reinvent the wheel
inside CMA. We have solutions for all those things in the kernel right
now, we just have to glue them together in a sane way.

Thanks,
Lucas
