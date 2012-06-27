From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 10:13:56 +0200
Message-ID: <1340784836.1384.16.camel@antimon>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
	 <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	 <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
	 <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
	 <4FEA6E09.30800@nvidia.com>
	 <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	 <4FEA7472.7050201@nvidia.com>
	 <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120627051418.GB7177-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

I'm not sure what your exact plans are for the direction in which the
DRM driver should head, as I'm still a bit out of the loop as many of
those matters were only discussed internally at NVIDIA or with some NDA
developers. But I'll still try to get into the discussion.

Am Mittwoch, den 27.06.2012, 07:14 +0200 schrieb Thierry Reding:
> On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> > On 06/26/2012 08:32 PM, Mark Zhang wrote:
> > >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> > >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> > >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > >> ...
> > >>>> I'm not sure I understand how information about the carveout would be
> > >>>> obtained from the IOMMU API, though.
> > >>>
> > >>> I think that can be similar with current gart implementation. Define carveout as:
> > >>>
> > >>> carveout {
> > >>>         compatible = "nvidia,tegra20-carveout";
> > >>>         size = <0x10000000>;
> > >>> };
> > >>>
> > >>> Then create a file such like "tegra-carveout.c" to get these definitions and
> > >> register itself as platform device's iommu instance.
> > >>
> > >> The carveout isn't a HW object, so it doesn't seem appropriate to define a DT
> > >> node to represent it.
> > > 
> > > Yes. But I think it's better to export the size of carveout as a configurable item.
> > > So we need to define this somewhere. How about define carveout as a property of gart?
> > 
> > There already exists a way of preventing Linux from using certain chunks
> > of memory; the /memreserve/ syntax. From a brief look at the dtc source,
> > it looks like /memreserve/ entries can have labels, which implies that a
> > property in the GART node could refer to the /memreserve/ entry by
> > phandle in order to know what memory regions to use.
> 
> Wasn't the whole point of using a carveout supposed to be a replacement
> for the GART? As such I'd think the carveout should rather be a property
> of the host1x device.
> 
In my understanding carveout is neither a hardware nor software
component. It's just a somewhat special pool of memory. As I pointed out
in one of the older mails, carveout can not completely replace GART.
While normal allocations for graphics use should be done contiguous,
GART allows us to link normal scattered sysram buffers into GPU address
space, which is a nice thing to have.
IMHO if carveout is to be used exclusively by the GPU (i.e. the DRM
driver) it should be a property of the host1x device.

> AIUI what we want to do is have a large contiguous region of memory that
> a central component (host1x) manages as a pool from which clients (DRM,
> V4L, ...) can allocate buffers as needed. Since all of this memory will
> be contiguous anyway there isn't much use for the GART anymore.
> 
I think this is the wrong way to go. Having a special memory pool
managed by some driver adds one more allocator to the kernel, which is
clearly not desirable. If we want a special mem region for GPU use, we
should not share this memory pool with other components.

But if we want a mem region for contig allocations used by many
components, which seems to be consensus here, CMA is the way to go. In
this case I think we don't want to bother with the carveout property at
all at the DRM driver level. Such a shared mem region managed by CMA
should be defined at a higher level of the device tree.

Thanks,
Lucas
