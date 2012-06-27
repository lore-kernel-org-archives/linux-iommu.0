From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 15:44:00 +0300
Message-ID: <20120627154400.d9d7db67128404079d98ab39@nvidia.com>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
	<20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	<20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120626140033.GC1115-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 26 Jun 2012 16:00:33 +0200
Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:

> * PGP Signed by an unknown key
> 
> On Tue, Jun 26, 2012 at 04:02:24PM +0300, Hiroshi Doyu wrote:
> > Hi Thierry,
> > 
> > On Tue, 26 Jun 2012 12:55:13 +0200
> > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > 
> > > > Old Signed by an unknown key
> > > 
> > > Hi,
> > > 
> > > while I haven't got much time to work on the actual code right now, I
> > > think it might still be useful if we could get the device tree binding
> > > to a point where everybody is happy with it. That'll also save me some
> > > time once I get to writing the code because I won't have to redo it over
> > > again. =)
> > > 
> > > So here's the current proposal:
> > > 
> > > 	host1x {
> > > 		compatible = "nvidia,tegra20-host1x", "simple-bus";
> > > 		reg = <0x50000000 0x00024000>;
> > > 		interrupts = <0 64 0x04   /* cop syncpt */
> > > 			      0 65 0x04   /* mpcore syncpt */
> > > 			      0 66 0x04   /* cop general */
> > > 			      0 67 0x04>; /* mpcore general */
> > > 
> > > 		#address-cells = <1>;
> > > 		#size-cells = <1>;
> > > 
> > > 		ranges = <0x54000000 0x54000000 0x04000000>;
> > > 
> > > 		status = "disabled";
> > > 
> > > 		gart = <&gart>;
> > ...
> > > output and hooks up a static EDID block with the LVDS output. There is
> > > also a carveout property which might be a better replacement for the
> > > "crippled" GART on Tegra20. Alternatively the CMA might work just as
> > > well instead.
> > > 
> > > The Plutux can be described like this:
> > > 
> > > 	host1x {
> > > 		carveout = <0x0e000000 0x02000000>;
> > 
> > As discussed in the following ML thread previously, the necessary info
> > related to the "gart" would be got from the standard IOMMU API(or
> > something above layers, DMABUF or TTM?). So I don't think that we need
> > to refer to "gart" and "carveout" here in the end.
> > 
> > http://lists.linuxfoundation.org/pipermail/iommu/2012-June/004266.html
> 
> Yes, if IOMMU or some layer above can provide the same information, then
> that is certainly better than explicitly referencing it in the DT.
> 
> I'm not sure I understand how information about the carveout would be
> obtained from the IOMMU API, though.

I think that there are 2 cases:

  (1) discontiguous memory with IOMMU
  (2) contiguous memory without IOMMU(called "carveout" in general?)

For (1), the necessary info should be passed via IOMMU API as
mentioned in the previous reply, like DT->{GART,SMMU}->IOMMU->DRM.

  [PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
    https://lkml.org/lkml/2012/1/19/170

For (2), although memory is mostly anonymous one, we may need to know
how much to allocate, where we only need "size". This size is not from
h/w feature, but it depends on the system load/usage. So I think that
this size can be passed from kernel command line? For exmaple, we can
specify how much contiguous memory is necessary with putting
"coherent_pool=??M" in the kernel command line as below:

	coherent_pool=nn[KMG]	[ARM,KNL]
			Sets the size of memory pool for coherent, atomic dma
			allocations.
