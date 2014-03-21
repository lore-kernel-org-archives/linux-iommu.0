From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 20/27] iommu/exynos: allow having multiple System MMUs
	for a master H/W
Date: Fri, 21 Mar 2014 14:21:43 +0900
Message-ID: <20140321142143.8eea5af6bfc21fa535e1052e@samsung.com>
References: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
	<53232A53.4040708@samsung.com>
	<20140318220128.564740c88d06b86c9c5c10e3@samsung.com>
	<532857A8.5060000@samsung.com>
	<20140319093929.d3a7cea131c626cf978e0ff1@samsung.com>
	<532999A2.6030107@samsung.com> <5329B471.7030703@samsung.com>
	<20140320192235.69386eba6ea04b7745b5fcca@samsung.com>
	<532AC902.6050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <532AC902.6050909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 20 Mar 2014 11:54:58 +0100, Tomasz Figa wrote:
> On 20.03.2014 11:22, Cho KyongHo wrote:
> > On Wed, 19 Mar 2014 16:14:57 +0100, Tomasz Figa wrote:
> >> On 19.03.2014 14:20, Tomasz Figa wrote:
> >>> On 19.03.2014 01:39, Cho KyongHo wrote:
> >>>> On Tue, 18 Mar 2014 15:26:48 +0100, Tomasz Figa wrote:
> >>>>>
> >>>>>
> >>>>> On 18.03.2014 14:01, Cho KyongHo wrote:
> >>>>>> On Fri, 14 Mar 2014 17:12:03 +0100, Tomasz Figa wrote:
> >>>>>>> Hi KyongHo,
> >>>>>>>
> >>>>>>> On 14.03.2014 06:10, Cho KyongHo wrote:
> >>>>>>>> Some master device descriptor like fimc-is which is an abstraction
> >>>>>>>> of very complex H/W may have multiple System MMUs. For those devices,
> >>>>>>>> the design of the link between System MMU and its master H/W is
> >>>>>>>> needed
> >>>>>>>> to be reconsidered.
> >>>>>>>>
> >>>>>>>> A link structure, sysmmu_list_data is introduced that provides a link
> >>>>>>>> to master H/W and that has a pointer to the device descriptor of a
> >>>>>>>> System MMU. Given a device descriptor of a master H/W, it is possible
> >>>>>>>> to traverse all System MMUs that must be controlled along with the
> >>>>>>>> master H/W.
> >>>>>>>
> >>>>>>> NAK.
> >>>>>>>
> >>>>>>> A device driver should handle particular hardware instances
> >>>>>>> separately,
> >>>>>>> without abstracting a virtual hardware instance consisting of multiple
> >>>>>>> physical ones.
> >>>>>>>
> >>>>>>> If such abstraction is needed, it should be done above the
> >>>>>>> exynos-iommu
> >>>>>>> driver, e.g. by something like iommu-composite driver that would
> >>>>>>> aggregate several IOMMUs. Keep in mind that such IOMMUs in a group
> >>>>>>> could
> >>>>>>> be different, e.g. different Exynos SysMMU versions or even completely
> >>>>>>> different IPs handled by different drivers.
> >>>>>>>
> >>>>>>> Still, I don't think there is a real need for such abstraction.
> >>>>>>> Instead,
> >>>>>>> related drivers shall be fixed to properly handle multiple memory
> >>>>>>> masters and their IOMMUs.
> >>>>>>>
> >>>>>>
> >>>>>> G2D, Scalers and FIMD of Exynos5420 has 2 System MMUs while aother
> >>>>>> SoC like
> >>>>>> Exynos5250 does not.
> >>>>>>
> >>>>>> I don't understand why you are negative to this approach.
> >>>>>> This is the simplest than the others.
> >>>>>>
> >>>>>> Let me show you an example.
> >>>>>> FIMC-IS driver just controls MCU in FIMC-IS subsystem and the
> >>>>>> firmware of
> >>>>>> the MCU controls all other peripherals in the subsystem. Each
> >>>>>> peripherals
> >>>>>> have their own System MMU. Moreover, the configuration of the
> >>>>>> peripherals
> >>>>>> varies according to the SoCs.
> >>>>>>
> >>>>>> If System MMU driver accepts multiple masters, everything is done in
> >>>>>> DT.
> >>>>>> But I worry that it is not easy if System MMU driver does not support
> >>>>>> multiple masters.
> >>>>>
> >>>>> I believe I have stated enough reasons why this kind of implementation
> >>>>> is bad. I'm not going to waste time repeating myself.
> >>>>>
> >>>>> Your concerns presented above are valid, however they are not related to
> >>>>> what is wrong with this patch. I have given you two proper ways to
> >>>>> handle this, none should be forced upon particular IOMMU master drivers
> >>>>> - their authors should have the chance to select the method that works
> >>>>> best for them.
> >>>>>
> >>>>
> >>>> I don't still understand why you think this patch is wrong.
> >>>> I think this is the best way not to think for all the driver developers
> >>>> about other things than their business logic.
> >>>
> >>> I agree, but one of the ways I proposed (an iommu-composite layer above
> >>> the IOMMU low level drivers) doesn't add any extra responsibility of
> >>> driver developers.
> >>>
> >>> Moreover, it's this kind of business logic in low level drivers that is
> >>> adding more responsibility, because it introduces additional complexity
> >>> and makes the driver harder to read, maintain and extend in future.
> >>>
> >>>>
> >>>> This does not hurt anyone and I think this is good enough.
> >>>>
> >>>
> >>> Well, it is barely good enough. It is a good practice to make a low
> >>> level driver handle a single device instance and this is how Linux
> >>> driver model is designed.
> >>>
> >>> Moreover, a single device tree node _must_ represent a single hardware
> >>> block, so you can't group multiple SysMMUs into a single device tree node.
> >>>
> >>
> >> OK, you add nodes for single SysMMUs devices which is fine, sorry. I was
> >> under impression that one kernel device (struct device) corresponds to
> >> multiple SysMMUs, but this was before your patches, sorry. So one issue
> >> less, but it's still not good.
> >>
> >
> > Ok. Understood why you have mentioned such.
> >
> >>> Furthermore, if you force grouping of SysMMUs into a single virtual one,
> >>> you enforce using the same address space for all masters of some
> >>> particular hardware blocks, while potentially driver developers would
> >>> like to separate them.
> >>
> >> Probably some clarification is needed. Your other patch adds:
> >>
> >> 	sysmmu_fimd0w04: sysmmu@14640000 {
> >> 		compatible = "samsung,sysmmu-v3.3";
> >> 		reg = <0x14640000 0x1000>;
> >> 		interrupt-parent = <&combiner>;
> >> 		interrupts = <3 2>;
> >> 		clock-names = "sysmmu", "master";
> >> 		clocks = <&clock 422>, <&clock 421>;
> >> 		samsung,power-domain = <&disp_pd>;
> >> 		mmu-masters = <&fimd>;
> >> 	};
> >>
> >> 	sysmmu_fimd0w123: sysmmu@14680000 {
> >> 		compatible = "samsung,sysmmu-v3.3";
> >> 		reg = <0x14680000 0x1000>;
> >> 		interrupt-parent = <&combiner>;
> >> 		interrupts = <3 0>;
> >> 		clock-names = "sysmmu", "master";
> >> 		clocks = <&clock 423>, <&clock 421>;
> >> 		samsung,power-domain = <&disp_pd>;
> >> 		mmu-masters = <&fimd>;
> >> 	};
> >>
> >>   From such description, in future FIMD driver won't be able to determine
> >> which SysMMU is used for windows 0 and 4 and which for windows 1, 2 and
> >> 3. However it would be desirable to handle both SysMMUs separately,
> >> allowing each SysMMU to have only mappings for frame buffers needed by
> >> respective FIMD windows.
> >>
> >
> > If it is required to map frame buffers for the System MMU of a specific window,
> > you can specify different phandles to mmu-masters of sysmmu_fimd0w04 and
> > sysmmu_0w123.
> >
> > However, I think it is more convenient that all windows of a FIMD share the
> > same virtual address space because
> >   - Exynos5250: FIMD has one System MMU
> >   - Exynos5420: FIMD has 2 System MMUs for Window 0,4 and 1,2,3
> >   - Another SoC which is not ready for upstreaming: FIMD has 2 System MMUs for window 0,1 and 2,3,4
> > (I also discouraged when I found a new Soc has different H/W bus topology :)
> >
> > For this reason, I prefer allowing a single master to have multiple System MMU.
> >
> 
> Well, it sure can be more convenient from programming point of view, but 
> there might be certain security-related aspects that would prefer more 
> fine-granular control over memory accesses of IP blocks.
> 
> >>> A good interface design should not enforce any particular implementation
> >>> and this is what we should stick to in this case as well.
> >>>
> >>>> If you want to provide another layer between master device and system mmu
> >>>> as you mentioned, you do that. This patch does not restrict it.
> >>>
> >>> It does, as mentioned above. With a device tree listing multiple SysMMUs
> >>> as one, you can't separate them.
> >>
> >> What I mean is that based on DT description, drivers should be able to
> >> control SysMMUs separately if they want to.
> >>
> >
> > As I mentioned above, drivers can control every System MMU separately.
> 
> You are missing one point here - device tree stability. Once you specify 
> the same phandle for both masters of FIMD (or any other multi-master IP 
> block) and distribute such device tree, FIMD (or any other) driver will 
> be able to support only shared address space mode on such board.

Nothing is prepared for the relationship between FIMD and System MMU.
I can remove all 'mmu-masters' property from the nodes of System MMU until
master drivers define their way of the relationship control.
But I think that the current driver must work with the smallest effort.
If the driver developer feels that the separate address space for each
System MMUs, they can do that with a bit modification to DT.

> Probably the preferred solution would be to reuse stream ID mechanism of 
> ARM System MMU bindings and make such multi master devices specify 
> #stream-id-cells = <1> and have IDs properly assigned for each of their 
> masters. This would be the best choice for consistency reasons, as 
> existing bindings would be reused, without reinventing the wheel.

Actually, the issue is not that a System MMU has multiple masters but
a master has multiple System MMUs.

Thank you

KyongHo
