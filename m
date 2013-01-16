From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 06/14] ARM: EXYNOS: add System MMU definition to DT
Date: Wed, 16 Jan 2013 17:43:21 +0100
Message-ID: <20130116.184321.179736289870581833.hdoyu@nvidia.com>
References: <003601cdd790$082a1310$187e3930$%cho@samsung.com><20130116115114.GB16543@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130116115114.GB16543-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel@lists.i>
List-Id: iommu@lists.linux-foundation.org

Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Wed, 16 Jan 2013 12:51:14 +0100:

> On Tue, Dec 11, 2012 at 11:09:47AM +0000, Cho KyongHo wrote:
> > This commit adds System MMU nodes to DT of Exynos SoCs.
> 
> [Adding devicetree-discuss and some other IOMMU/DT people to CC]
> 
> > Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/arm/exynos/system-mmu.txt  |  86 ++++++++++++
> >  arch/arm/boot/dts/exynos4210.dtsi                  |  96 ++++++++++++++
> >  arch/arm/boot/dts/exynos4x12.dtsi                  | 124 +++++++++++++++++
> >  arch/arm/boot/dts/exynos5250.dtsi                  | 147 ++++++++++++++++++++-
> >  4 files changed, 451 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/exynos/system-mmu.txt

nit, we have this doc in Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt.

Probably under Documentation/devicetree/bindings/iommu, it's easier to
find the similarity among SoC IOMMUs.

> > diff --git a/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
> > b/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
> > new file mode 100644
> > index 0000000..9c30a36
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
> > @@ -0,0 +1,86 @@
> > +* Samsung Exynos System MMU
> > +
> > +Samsung's Exynos architecture includes System MMU that enables scattered
> > +physical chunks to be visible as a contiguous region to DMA-capabile peripheral
> > +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> > +
> > +System MMU is a sort of IOMMU and support identical translation table format to
> > +ARMv7 translation tables with minimum set of page properties including access
> > +permissions, shareability and security protection. In addition System MMU has
> > +another capabilities like L2 TLB or block-fetch buffers to minimize translation
> > +latency
> 
> ARMv7 has two translation table formats -- please specify which ones you
> support. Stage-2 descriptors also have a few differences, so you should
> describe what you actually support.
> 
> > +Each System MMU is included in the H/W block of a peripheral device. Thus, it is
> > +important to specify that a System MMU is dedicated to which peripheral device
> > +before using System MMU. System initialization must specify the relationships
> > +between a System MMU and a peripheral device that owns the System MMU.
> > +
> > +Some device drivers may control several peripheral devices with a single device
> > +descriptor like MFC. Since handling a System MMU with IOMMU API requires a
> > +device descriptor that needs the System MMU, it is best to combine the System
> > +MMUs of the peripheral devices and control them with a single System MMU device
> > +descriptor. If it is unable to combine them into a single device descriptor,
> > +they can be linked with each other by the means of device.parent relationship.
> 
> I agree with the sentiment here, but I don't think your solution really
> caters for the generic case (outside of exynos). For example, I've recently
> started looking at writing an IOMMU driver for ARM's System MMU
> Architecture, where a likely use-case is for an SoC where there are a bunch
> of MMIO devices, with subsets of these devices assigned to different IOMMUs.
> This is similar to your scenario, except that the System MMU is not
> necessarily tied to a specific hardware block:
> 
> 
>                                Bus
>             =========================================
>                      ||                   ||
>                 +----------+         +----------+
>                 |  IOMMU0  |         |  IOMMU1  |
>                 +----------+         +----------+
>                  |        |           |        |
>                  |        |           |        |
>               Device0  Device1     Device2  Device3
> 
> 
> From Linux's perspective, all of these devices sit on the platform bus
> and are probed using device tree. That is where the fun starts: because
> the platform bus has only one set of iommu_ops associated with it, the
> driver needs to handle each IOMMU instance explicitly, choosing the
> appropriate one for the device when setting up or tearing down an I/O
> mapping. To complicate this further, each device has a unique StreamID
> assigned statically in the hardware which is required when programming
> the IOMMU in order to describe translations for a particular bus master.
> 
> In this case, your mmu-master property doesn't work because there are a
> multiple devices sharing an IOMMU. Furthermore, the StreamIDs for each
> client device need to encoded somewhere as well.
> 
> Given that this information is not discoverable, it needs to be encoded
> in the device tree, but where? I can see two approaches:
> 
>   1. For each IOMMU node, list phandles to the devices connected to it
>      and have a corresponding list of StreamIDs.
> 
> or
> 
>   2. For each device wishing to use an IOMMU, have a phandle to the
>      IOMMU node and a separate StreamID property. The IOMMU would then
>      parse this information when the device is added to the bus.
> 
> Although I prefer the second approach, it has the downside of affecting
> all device bindings that wish to use an IOMMU, so I'm open to any other
> ideas.

Actually the above summarize tegra SMMU situation well too. For
example, each IOMMU'able device has IOVA constraint that some of the
address area isn't available because of its MMIO. This info needs to
be described in DT. If <IOMMU phandle> + some parametes are embedded
in a device node, that info could be dealt at a bus notifier(*1).

*1: http://lists.linuxfoundation.org/pipermail/iommu/2012-November/004934.html

> > +Required properties:
> > +- compatible: Should be "samsung,exynos-sysmmu".
> > +- reg: Tuples of base address and size of System MMU registers. The number of
> > +       tuples can be more than one if two or more System MMUs are controlled
> > +       by a single device descriptor.
> > +- interrupt-parent: The phandle of the interrupt controller of System MMU
> > +- interrupts: Tuples of numbers that indicates the interrupt source. The
> > +              number of elements in the tuple is dependent upon
> > +             'interrupt-parent' property. The number of tuples in this property
> > +             must be the same with 'reg' property.
> > +
> > +Optional properties:
> > +- mmuname: Strings of the name of System MMU for debugging purpose. The number
> > +          of strings must be the same with the number of tuples in 'reg'
> > +          property.
> > +- mmu-master: phandle to the device node that owns System MMU. Only the device
> > +          that is specified whith this property can control System MMU with
> > +          IOMMU API.
> > +
> > +Examples:
> > +
> > +MFC has 2 System MMUs for each port that MFC is attached. Thus it seems natural
> > +to define 2 System MMUs for each port of the MFC:
> > +
> > +       sysmmu-mfc-l {
> > +               mmuname = "mfc_l";
> > +               reg = <0x11210000 0x1000>;
> > +               compatible = "samsung,exynos-sysmmu";
> > +               interrupt-parent = <&combiner>;
> > +               interrupts = <8 5>;
> > +               mmu-master = <&mfc>;
> > +       };
> > +
> > +       sysmmu-mfc-r {
> > +               mmuname = "mfc_r";
> > +               reg = <0x11200000 0x1000>;
> > +               compatible = "samsung,exynos-sysmmu";
> > +               interrupt-parent = <&combiner>;
> > +               interrupts = <6 2>;
> > +               mmu-master = <&mfc>;
> > +       };
> > +
> > +Actually, MFC device driver requires sub-devices that represents each port and
> > +above 'mmu-master' properties of sysmmu-mfc-l and sysmmu-mfc-r have the phandles
> > +to those sub-devices.
> > +
> > +However, it is also a good idea that treats the above System MMUs as one System
> > +MMU because those System MMUs are actually required by the MFC device:
> > +
> > +       sysmmu-mfc {
> > +               mmuname = "mfc_l", "mfc_r";
> > +               reg = <0x11210000 0x1000
> > +                      0x11200000 0x1000>;
> > +               compatible = "samsung,exynos-sysmmu";
> > +               interrupt-parent = <&combiner>;
> > +               interrupts = <8 5
> > +                             6 2>;
> > +               mmu-master = <&mfc>;
> > +       };
> 
> Merging the nodes like this has strong requirements for uniform smmu
> devices, which I think are unreasonable. I would not be surprised to see
> some system MMUs have more interrupts than others, for example. Furthermore,
> you may chain stage-1 System MMUs with a stage-2 System MMU and these would
> need to be described as separate nodes (this actually complicates my two
> suggestions earlier on...).
> 
> > +If System MMU of MFC is defined like the above, the number of elements and the
> > +order of list in 'mmuname', 'reg' and 'interrupts' must be the same.
> 
> That's a really nasty restriction (the interrupts could even be ORd
> together).
> 
> I appreciate that this is a samsung/exynos-specific binding but if we can
> generalise at least some parts of it then they can be re-used by other
> SoCs with multiple IOMMUs too.
> 
> Will
