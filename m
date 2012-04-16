From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Mon, 16 Apr 2012 13:12:38 +0200
Message-ID: <20120416.141238.381304581863200083.hdoyu@nvidia.com>
References: <20120413.143104.1310879848248152784.hdoyu@nvidia.com><20120413121510.GD11605@avionic-0098.mockup.avionic-design.de><4F887DA0.8030103@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F887DA0.8030103-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Fri, 13 Apr 2012 21:25:20 +0200
Message-ID: <4F887DA0.8030103-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

> On 04/13/2012 06:15 AM, Thierry Reding wrote:
> > * Hiroshi Doyu wrote:
> >> Thierry Reding wrote:
> >>> * Hiroshi Doyu wrote:
> >>>> +	smmu: smmu@7000f000 {
> >>>> +		compatible = "nvidia,tegra30-smmu";
> >>>> +		reg = < 0x7000f000 0x400	/* controller registers */
> >>>> +			0x6000c000 0x150	/* AHB Arbitration registers */
> >>>> +			0x00001000 0x3ffff000 >;/* Virtual address space range
> >>>> +						 * Exclude the 1st & last page
> >>>> +						 */
> >>>> +		interrupts = < 0 13 0x40 >;
> >>>> +	};
> >>>>  };
> >>>
> >>> Why is the virtual address space range limited to 1 GiB? What is the reason
> >>> for the exclusion of the first and last pages?
> >>
> >> It's because physical RAM is located 2-4GB, and we may want to use
> >> those area 1-1(V==P) mapping in some cases. This could be extended
> >> with larger RAM without 1-1 mapping theoretically. So far 1GB seems to
> >> be enough.
> >
> > I'm thinking that this would be better off in a separate property so that
> > it's easier for boards to override it.
>
> Yes, and for another reason: The entries in the reg property are
> supposed to be within the bus address space that contains the device,
> whereas here this 3rd reg entry is being used to define something about
> an entirely unrelated address space - the virtual address space seen by
> SMMU clients.

What about using "dma-window" property to specify IOVA range in dtsi as below?

arch/powerpc/platforms/cell/iommu.c:

698 static int __init cell_iommu_get_window(struct device_node *np,
699                                          unsigned long *base,
700                                          unsigned long *size)
701 {
702         const void *dma_window;
703         unsigned long index;
704
705         /* Use ibm,dma-window if available, else, hard code ! */
706         dma_window = of_get_property(np, "ibm,dma-window", NULL);
707         if (dma_window == NULL) {          ^^^^^^^^^^^^^^
708                 *base = 0;
709                 *size = 0x80000000u;
710                 return -ENODEV;
711         }
712
713         of_parse_dma_window(np, dma_window, &index, base, size);
714         return 0;
715 }


> >> The 1st page for AVP vector, and the last one is required by another
> >> H/W entity.
> >
> > I would expect such peculiarities to be handled by the driver internally.
> > That way users wouldn't have to know or care about these kind of details.
> > If it can't be handled by the driver then at least it should be mentioned
> > explicitly in the binding documentation.
>
> I agree, but:
>
> Why do those pages even need special handling? Doesn't the AVP get its
> own address space ID, and then can set it up however it wants?

This sounds better than dealing with prefixed mappings at booting. At
least we need to pass # of ASIDs, and client should claim one of them.
