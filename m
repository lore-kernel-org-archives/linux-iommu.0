From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
	SoCs
Date: Mon, 05 Aug 2013 15:09:53 +0200
Message-ID: <1429191.3FDem6vW0S@amdc1032>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
	<27536111.odlCO093Zi@amdc1032>
	<003c01ce91cd$427fad70$c77f0850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <003c01ce91cd$427fad70$c77f0850$@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Keyyoung Park' <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday, August 05, 2013 08:16:40 PM Cho KyongHo wrote:
> > -----Original Message-----
> > From: Bartlomiej Zolnierkiewicz [mailto:b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org]
> > Sent: Saturday, August 03, 2013 2:14 AM
> > 
> > Hi,
> > 
> > On Friday, July 26, 2013 08:28:19 PM Cho KyongHo wrote:
> > > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
> > >  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
> > >  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
> > >  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
> > >  arch/arm/boot/dts/exynos5250.dtsi                  |  291 ++++++++++++++++++++
> > >  5 files changed, 617 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> > > b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> > > new file mode 100644
> > > index 0000000..92f0a33
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> > > @@ -0,0 +1,103 @@
> > > +Samsung Exynos4210 IOMMU H/W, System MMU (System Memory Management Unit)
> > > +
> > > +Samsung's Exynos architecture contains System MMU that enables scattered
> > > +physical memory chunks visible as a contiguous region to DMA-capable peripheral
> > > +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> > > +
> > > +System MMU is a sort of IOMMU and support identical translation table format to
> > > +ARMv7 translation tables with minimum set of page properties including access
> > > +permissions, shareability and security protection. In addition, System MMU has
> > > +another capabilities like L2 TLB or block-fetch buffers to minimize translation
> > > +latency.
> > > +
> > > +A System MMU is dedicated to a single master peripheral device.  Thus, it is
> > > +important to specify the correct System MMU in the device node of its master
> > > +device. Whereas a System MMU is dedicated to a master device, the master device
> > > +may have more than one System MMU.
> > > +
> > > +Required properties:
> > > +- compatible: Should be "samsung,exynos4210-sysmmu"
> > > +- reg: A tuple of base address and size of System MMU registers.
> > > +- interrupt-parent: The phandle of the interrupt controller of System MMU
> > > +- interrupts: A tuple of numbers that indicates the interrupt source.
> > > +- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
> > > +               Please refer to the following documents:
> > > +	       Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > +	       Documentation/devicetree/bindings/clock/exynos4-clock.txt
> > > +	       Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> > > +	       Optional "master" if the clock to the System MMU is gated by
> > > +	       another gate clock other than "sysmmu". The System MMU driver
> > > +	       sets "master" the parent of "sysmmu".
> > > +	       Exynos4 SoCs, there needs no "master" clocks.
> > > +	       Exynos5 SoCs, some System MMUs must have "master" clocks.
> > > +- clocks: Required if the System MMU is needed to gate its clock.
> > > +	  Please refer to the documents listed above.
> > > +- samsung,power-domain: Required if the System MMU is needed to gate its power.
> > > +	  Please refer to the following document:
> > > +	  Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> > > +
> > > +Required properties for the master peripheral devices:
> > > +- iommu: phandles to the System MMUs of the device
> > > +
> > > +Examples:
> > > +A System MMU is dedicated to a single master device.
> > > +	gsc_0:  gsc@0x13e00000 {
> > > +		compatible = "samsung,exynos5-gsc";
> > > +		reg = <0x13e00000 0x1000>;
> > > +		interrupts = <0 85 0>;
> > > +		samsung,power-domain = <&pd_gsc>;
> > > +		clocks = <&clock 256>;
> > > +		clock-names = "gscl";
> > > +		iommu = <&sysmmu_gsc1>;
> > > +	};
> > > +
> > > +	sysmmu_gsc0: sysmmu@13E80000 {
> > > +		compatible = "samsung,exynos4210-sysmmu";
> > > +		reg = <0x13E80000 0x1000>;
> > > +		interrupt-parent = <&combiner>;
> > > +		interrupt-names = "sysmmu-gsc0";
> > > +		interrupts = <2 0>;
> > > +		clock-names = "sysmmu", "master";
> > > +		clocks = <&clock 262>, <&clock 256>;
> > > +		samsung,power-domain = <&pd_gsc>;
> > > +		status = "ok";
> > > +	};
> > > +
> > > +MFC has 2 System MMUs for each port that MFC is attached. Thus it seems natural
> > > +to define 2 System MMUs for each port of the MFC:
> > 
> > Marek Szyprowski (added to cc:) has a patch fixing MFC to create separate
> > mfc_l and mfc_r devices (like it was in the past). Using this patch it
> > would be possible to bind sysmmu_mfc_l to mfc_l device and sysmmu_mfc_r to
> > mfc_r device. This probably also requires adding some MFC specific handling
> > in a device tree node and to the new master's device PM ops (in patch #10)
> > as previously (in our trees) sysmmu_mfc r device was set as parent of
> > sysmmu_mfc_l device which in turn was a parent for main MFC device (to make
> > runtime Power Management work). However because MFC is the only device
> > requiring use of multiple System MMUs above changes would allow us (unless
> > I'm missing something?) to use just one System MMU device per struct
> > exynos_iommu_client instance (making driver a lot simpler).
> > 
> 
> Does it mean that we can make the exynos-iommu driver simpler
> with Marek Szyprowski's patch?

I think so and you probably need to change MFC handling anyway because
MFC driver does DMA allocations per mfc_l/mfc_r devices and not per main
device (at least in the upstream kernels).

[ Marek, could you please resfresh and post your patch on the list? ]

BTW There is an additional problem with combining System MMU devices per
one main device - it limits available address space (which in case of MFC
is very limited by hardware design).

> It is welcome but I don't think it covers all topologies of System MMU and
> master H/W. Those are getting more complex.

Could you please be more specific? I know about FIMC ISP subsystem but
it doesn't require combining System MMUs. Are there any other examples of
complex System MMU + master H/W topologies?

Anyway I think that System MMUs should not be combined (as it is done in
patch #10) and should be binded per "memport" devices and not per main
device (as done in this patch).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
