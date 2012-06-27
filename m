From: Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 13:28:01 +0800
Message-ID: <23B010BBA481A74B98487467C29BA57BF2361DA44C@HKMAIL01.nvidia.com>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
 <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
 <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
 <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
 <4FEA6E09.30800@nvidia.com>
 <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
 <4FEA7472.7050201@nvidia.com>
 <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120627051418.GB7177-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> > On 06/26/2012 08:32 PM, Mark Zhang wrote:
> > >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> > >>>>> On Tue, 26 Jun 2012 12:55:13 +0200 Thierry Reding
> > >>>>> <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > >> ...
> > >>>> I'm not sure I understand how information about the carveout
> > >>>> would be obtained from the IOMMU API, though.
> > >>>
> > >>> I think that can be similar with current gart implementation. Define
> carveout as:
> > >>>
> > >>> carveout {
> > >>>         compatible = "nvidia,tegra20-carveout";
> > >>>         size = <0x10000000>;
> > >>> };
> > >>>
> > >>> Then create a file such like "tegra-carveout.c" to get these
> > >>> definitions and
> > >> register itself as platform device's iommu instance.
> > >>
> > >> The carveout isn't a HW object, so it doesn't seem appropriate to
> > >> define a DT node to represent it.
> > >
> > > Yes. But I think it's better to export the size of carveout as a configurable item.
> > > So we need to define this somewhere. How about define carveout as a
> property of gart?
> >
> > There already exists a way of preventing Linux from using certain
> > chunks of memory; the /memreserve/ syntax. From a brief look at the
> > dtc source, it looks like /memreserve/ entries can have labels, which
> > implies that a property in the GART node could refer to the
> > /memreserve/ entry by phandle in order to know what memory regions to use.
> 
> Wasn't the whole point of using a carveout supposed to be a replacement for the
> GART? As such I'd think the carveout should rather be a property of the host1x
> device.
> 
> AIUI what we want to do is have a large contiguous region of memory that a
> central component (host1x) manages as a pool from which clients (DRM, V4L, ...)
> can allocate buffers as needed. Since all of this memory will be contiguous
> anyway there isn't much use for the GART anymore.
> 

I have the same understanding. We don't need GART anymore if carveout is enabled.
I'm thinking that why we need to define a property and reference to global 
/memreserve/ in GART or HOST1X node?
We can just define a label for /memreserve/, so we can distinguish these memory 
reservations already in codes.

> But maybe I'm misunderstanding.
> 
> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1
