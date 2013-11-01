From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Fri, 1 Nov 2013 09:41:07 +0200
Message-ID: <20131101094107.c93003fc71c86ca621fa7843@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
	<5271893C.6000507@wwwdotorg.org>	<20131031173132.GD3037@kartoffel>
	<20131031180029.GB31082@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131031180029.GB31082-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> > The ARM SMMU refers to these as "stream IDs", as that's the architected name
> > that appears in all the hardware documentation. If "swgroup" is the term used
> > in the hardware documentation I think it makes sense to stick with it, as long
> > as there's a description in the binding document that points out what an
> > "swgroup" is. If there's a common term that both binding documents could refer
> > to to define what stream-id/swgroup are, that would be nice.
>
> Sounds like:
>
>   stream id == memory client id   (part of the binding)
>   context id == address space id  (internal to the driver)

Good explanation. This would be helpful when I read ARM SMMU TRM;)

> > There are a few other differences in approach with the current ARM SMMU binding:
> > Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >
> > We should probably begin to look for commonality such that the next iommu
> > device that gets a binding is closer to a generic iommu class binding.

I think that now I got the "mmu-masters".

- mmu-masters   : A list of phandles to device nodes representing bus
		  masters for which the SMMU can provide a translation
		  and their corresponding StreamIDs (see example below).
		  Each device node linked from this list must have a
		  "#stream-id-cells" property, indicating the number of
		  StreamIDs associated with it.

If I apply this to Tegra, this would be:

	host1x {
            #swgroup-id-cells = <1>;

               gr3d {
                   #swgroup-id-cells = <2>;
               };

	};

	smmu: iommu {
		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
		reg = <0x70019010 0x02c>,
		      <0x700191f0 0x010>,
		      <0x70019228 0x074>;
		.......
		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
			      <&mpe TEGRA_SWGROUP_MPE>,
			      ..........
			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>;
	};

>From consistency POV, this may look better. Also if "stream-id-cells",
"mmu-masters" is defined as IOMMU standard tag, it would be more
easier. Otherwise, I may need to stick to "swgroup-id-cells".

> > > Assuming "swgroup" is "memory client ID", why can't the driver just
> > > create a list/... of known swgroups at runtime, based on the swgroup
> > > values that each device uses, which would presumably be either
> > > hard-coded in the client device's driver, or represented in the DT smmu
> > > property's "iommu specifier" value.
> >
> > Assuming that the swgroup values of IP block instances are static, that sounds
> > like the ARM SMMU binding approach. Are the IDs static, or can they be assigned
> > at runtime?
>
> The only valid case I can think of for dynamic IDs is for hotpluggable
> devices sitting being a form of host controller (e.g. PCIe). In that case,
> the host controller should handle the ID assignment, which must remain
> static for the lifetime of a device.

In Tegra PCIe clients belong to one swgroup statically.
