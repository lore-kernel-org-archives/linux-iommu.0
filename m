From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops into
 arch_setup_dma_ops
Date: Wed, 14 Jan 2015 14:51:36 +0100
Message-ID: <4122226.MTzV1JgdDD@phil>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1902738.pEWEpHICtU"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150114104610.GC4050@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "arnd@arndb.de" <arnd@arndb.de>, djkurtz@chromium.org, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.

--nextPart1902738.pEWEpHICtU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Will, Alexandre, Daniel,

Am Mittwoch, 14. Januar 2015, 10:46:10 schrieb Will Deacon:
> Hi Alex,
> 
> On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> > On 12/02/2014 01:57 AM, Will Deacon wrote:
> > > This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> > > actually called outside of a few drivers) into arch_setup_dma_ops, so
> > > that we can use IOMMUs for DMA transfers in a more generic fashion.
> > > 
> > > Since this significantly complicates the arch_setup_dma_ops function,
> > > it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> > > is not set, the iommu parameter is ignored and the normal ops are used
> > > instead.
> > 
> > A series for IOMMU support with Tegra/Nouveau ceased to work after this
> > patch.
> 
> Which series? This code shouldn't even be executed unless you start using
> of_xlate and the generic bindings.
> 
> > The Tegra IOMMU is not registered by the time the DT is parsed,
> > and thus all devices end up without the proper DMA ops set up because
> > the phandle to the IOMMU cannot be resolved.
> 
> You might want to look at the patches posted for the exynos, renesas and ARM
> SMMUs for some hints in how to use the new API.
> 
> > Subsequently calling arm_iommu_create_mapping() and
> > arm_iommu_attach_device() from the driver (as I used to do until 3.18)
> > does not help since the call to set_dma_ops() has been moved out of
> > arm_iommu_attach_device(). Therefore there seems to be no way for a device
> > to gets its correct DMA ops unless the IOMMU is ready by the time the DT
> > is parsed.
> > 
> > Also potentially affected by this are the Rockchip DRM and OMAP3 ISP
> > drivers, which follow the same pattern.
> 
> I don't understand why any code currently in mainline should be affected.
> Please can you elaborate on the failure case?

As Alexandre suspected the new Rockchip drm code seems to be affected by
this. I hadn't played with the drm code before last weekend and was then
stumbling over different iommu related issues. As I hadn't to much contact
with iommus till now I didn't get very far.

But with Alexandre's bandaid patch of adding
	set_dma_ops(dev, &iommu_ops);
to arm_iommu_attach_device both problems go away.


So to elaborate on the two failure cases:

When attaching either hdmi or vga connectors at runtime, I get

[drm:drm_mode_debug_printmodeline] Modeline 26:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
[drm:drm_crtc_helper_set_mode] [CRTC:14]
[drm:vop_crtc_dpms] crtc[14] mode[0]
rockchip-vop ff930000.vop: Attached to iommu domain
[drm] processing encoder TMDS-18
[drm] processing encoder DAC-22
[drm] processing connector HDMI-A-1
[drm] processing connector VGA-1
[drm:vop_win_update] [PLANE:12] [FB:-1->24] update
rk_iommu ff930300.iommu: Page fault at 0x2d400500 of type read
rk_iommu ff930300.iommu: iova = 0x2d400500: dte_index: 0xb5 pte_index: 0x0 page_offset: 0x500
rk_iommu ff930300.iommu: mmu_dte_addr: 0x2e3b3000 dte@0x2e3b32d4: 0x000000 valid: 0 pte@0x00000000: 0x000000 valid: 0 page@0x00000000 flags: 0x0
[drm:drm_crtc_helper_set_mode] [ENCODER:22:DAC-22] set [MODE:26:1024x768]

===============
When my wip vga-connector is plugged in at boot, I get


[drm:drm_target_preferred] found mode 1280x1024
[drm:drm_setup_crtcs] picking CRTCs for 4096x4096 config
[drm:drm_setup_crtcs] desired mode 1280x1024 set on crtc 14 (0,0)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 33 at mm/page_alloc.c:2645 __alloc_pages_nodemask+0x18c/0x6a8()
Modules linked in:
CPU: 1 PID: 33 Comm: kworker/u8:1 Not tainted 3.19.0-rc1+ #1512
Hardware name: Rockchip Cortex-A9 (Device Tree)
Workqueue: deferwq deferred_probe_work_func
[<c00148e4>] (unwind_backtrace) from [<c00111e0>] (show_stack+0x10/0x14)
[<c00111e0>] (show_stack) from [<c0426564>] (dump_stack+0x6c/0x84)
[<c0426564>] (dump_stack) from [<c0021f34>] (warn_slowpath_common+0x80/0xac)
[<c0021f34>] (warn_slowpath_common) from [<c0021f78>] (warn_slowpath_null+0x18/0x1c)
[<c0021f78>] (warn_slowpath_null) from [<c008b114>] (__alloc_pages_nodemask+0x18c/0x6a8)
[<c008b114>] (__alloc_pages_nodemask) from [<c001a274>] (__dma_alloc_buffer.isra.18+0x2c/0x80)
[<c001a274>] (__dma_alloc_buffer.isra.18) from [<c001a2dc>] (__alloc_remap_buffer.isra.22+0x14/0x5c)
[<c001a2dc>] (__alloc_remap_buffer.isra.22) from [<c001a490>] (__dma_alloc+0x16c/0x1d8)
[<c001a490>] (__dma_alloc) from [<c001a614>] (arm_dma_alloc+0x84/0x90)
[<c001a614>] (arm_dma_alloc) from [<c022f610>] (rockchip_gem_create_object+0x8c/0xc4)
[<c022f610>] (rockchip_gem_create_object) from [<c022f158>] (rockchip_drm_fbdev_create+0x6c/0x1ec)
[<c022f158>] (rockchip_drm_fbdev_create) from [<c021499c>] (drm_fb_helper_initial_config+0x230/0x328)
[<c021499c>] (drm_fb_helper_initial_config) from [<c022f388>] (rockchip_drm_fbdev_init+0xa4/0xc0)
[<c022f388>] (rockchip_drm_fbdev_init) from [<c022ea18>] (rockchip_drm_load+0x1b8/0x1f4)
[<c022ea18>] (rockchip_drm_load) from [<c021c218>] (drm_dev_register+0x80/0x100)
[<c021c218>] (drm_dev_register) from [<c022e77c>] (rockchip_drm_bind+0x48/0x74)
[<c022e77c>] (rockchip_drm_bind) from [<c0234a58>] (try_to_bring_up_master.part.2+0xa4/0xf4)
[<c0234a58>] (try_to_bring_up_master.part.2) from [<c0234c58>] (component_add+0x9c/0x104)
[<c0234c58>] (component_add) from [<c023a1e4>] (platform_drv_probe+0x48/0x90)
[<c023a1e4>] (platform_drv_probe) from [<c0238c30>] (driver_probe_device+0x130/0x340)
[<c0238c30>] (driver_probe_device) from [<c0237270>] (bus_for_each_drv+0x70/0x84)
[<c0237270>] (bus_for_each_drv) from [<c0238a8c>] (device_attach+0x64/0x88)
[<c0238a8c>] (device_attach) from [<c0238090>] (bus_probe_device+0x28/0x98)
[<c0238090>] (bus_probe_device) from [<c0238548>] (deferred_probe_work_func+0x78/0xa4)
[<c0238548>] (deferred_probe_work_func) from [<c0034008>] (process_one_work+0x1c8/0x2f4)
[<c0034008>] (process_one_work) from [<c0034448>] (worker_thread+0x2e8/0x450)
[<c0034448>] (worker_thread) from [<c00380a8>] (kthread+0xdc/0xf0)
[<c00380a8>] (kthread) from [<c000e8b8>] (ret_from_fork+0x14/0x3c)
---[ end trace ce23b3730f8c0d32 ]---
[drm:rockchip_gem_create_object] *ERROR* failed to allocate 0x500000 byte dma buffer


where Daniel Kurtz already deducted in private:

"But, more importantly, this call stack has "arm_dma_alloc", which
suggests that are not actually using the iommu dma allocators.
The allocation should have been handled by arm_iommu_alloc_attrs(),
but for some reason, it is not.
The iommu allocator should have been installed as the allocator for
the drm device by the call to arm_iommu_attach_device() in
rockchip_drm_load."


> > This raises the following questions:
> > 
> > 1) Why are arm_iommu_create_mapping() and arm_iommu_attach_device()
> > still public since they cannot set the DMA ops and thus seem to be
> > useless outside of arch_setup_dma_ops()?
> 
> It has callers outside of the file. I'd like to make it static, but that
> means doing some non-trivial porting of all the callers, which I'm also
> unable to test.
> 
> > 2) Say you want to use the IOMMU API in your driver, and have an iommu
> > property in your device's DT node. If by chance your IOMMU is registered
> > early, you will already have a mapping automatically created even before
> > your probe function is called. Can this be avoided? Is it even safe?
> 
> Currently, I think you have to either teardown the ops manually or return
> an error from of_xlate. Thierry was also looking at this sort of thing,
> so it might be worth talking to him.
> 
> Will

--nextPart1902738.pEWEpHICtU
Content-Disposition: attachment; filename="log.hotplugged"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="log.hotplugged"

[drm:output_poll_execute] [CONNECTOR:23:VGA-1] status updated from disconnected to connected
[drm:drm_fb_helper_hotplug_event] 
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:20:HDMI-A-1]
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:20:HDMI-A-1] disconnected
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:23:VGA-1]
[drm:drm_mode_debug_printmodeline] Modeline 26:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 0x5
[drm:drm_mode_prune_invalid] Not using 1280x1024 mode 12
[drm:drm_mode_debug_printmodeline] Modeline 27:"1152x864" 0 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[drm:drm_mode_prune_invalid] Not using 1152x864 mode 12
[drm:drm_mode_debug_printmodeline] Modeline 38:"1280x1024" 0 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[drm:drm_mode_prune_invalid] Not using 1280x1024 mode 12
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:23:VGA-1] probed modes :
[drm:drm_mode_debug_printmodeline] Modeline 28:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 39:"1024x768" 75 78800 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 40:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 41:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 42:"832x624" 75 57284 832 864 928 1152 624 625 628 667 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 29:"800x600" 85 56250 800 832 896 1048 600 601 604 631 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 43:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 44:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 31:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 32:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 30:"640x480" 85 36000 640 696 752 832 480 481 484 509 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 33:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 34:"640x480" 73 31500 640 664 704 832 480 489 491 520 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 35:"640x480" 67 30240 640 704 768 864 480 483 486 525 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 36:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 37:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[drm:drm_setup_crtcs] 
[drm:drm_enable_connectors] connector 20 enabled? no
[drm:drm_enable_connectors] connector 23 enabled? yes
[drm:drm_target_preferred] looking for cmdline mode on connector 23
[drm:drm_target_preferred] looking for preferred mode on connector 23 0
[drm:drm_target_preferred] found mode 1024x768
[drm:drm_setup_crtcs] picking CRTCs for 4096x4096 config
[drm:drm_setup_crtcs] desired mode 1024x768 set on crtc 14 (0,0)
[drm:drm_crtc_helper_set_config] 
[drm:drm_crtc_helper_set_config] [CRTC:8] [NOFB]
[drm:vop_crtc_dpms] crtc[8] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:vop_crtc_dpms] crtc[14] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:drm_crtc_helper_set_config] 
[drm:drm_crtc_helper_set_config] [CRTC:14] [FB:24] #connectors=1 (x y) (0 0)
[drm:drm_crtc_helper_set_config] crtc has no fb, full mode set
[drm:drm_crtc_helper_set_config] modes are different, full mode set
[drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[drm:drm_mode_debug_printmodeline] Modeline 26:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
[drm:drm_crtc_helper_set_config] encoder changed, full mode switch
[drm:drm_crtc_helper_set_config] [CONNECTOR:20:HDMI-A-1] to [NOCRTC]
[drm:drm_crtc_helper_set_config] crtc changed, full mode switch
[drm:drm_crtc_helper_set_config] [CONNECTOR:23:VGA-1] to [CRTC:14]
[drm:drm_crtc_helper_set_config] attempting to set mode from userspace
[drm:drm_mode_debug_printmodeline] Modeline 26:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
[drm:drm_crtc_helper_set_mode] [CRTC:14]
[drm:vop_crtc_dpms] crtc[14] mode[0]
rockchip-vop ff930000.vop: Attached to iommu domain
[drm] processing encoder TMDS-18
[drm] processing encoder DAC-22
[drm] processing connector HDMI-A-1
[drm] processing connector VGA-1
[drm:vop_win_update] [PLANE:12] [FB:-1->24] update
rk_iommu ff930300.iommu: Page fault at 0x2d400500 of type read
rk_iommu ff930300.iommu: iova = 0x2d400500: dte_index: 0xb5 pte_index: 0x0 page_offset: 0x500
rk_iommu ff930300.iommu: mmu_dte_addr: 0x2e3b3000 dte@0x2e3b32d4: 0x000000 valid: 0 pte@0x00000000: 0x000000 valid: 0 page@0x00000000 flags: 0x0
[drm:drm_crtc_helper_set_mode] [ENCODER:22:DAC-22] set [MODE:26:1024x768]
[drm:drm_crtc_helper_set_config] Setting connector DPMS state to on
[drm:drm_crtc_helper_set_config] 	[CONNECTOR:23:VGA-1] set DPMS on
[drm:vop_crtc_dpms] crtc[8] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter rk3x-i2c
[drm:output_poll_execute] [CONNECTOR:23:VGA-1] status updated from connected to disconnected
[drm:drm_fb_helper_hotplug_event] 
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:20:HDMI-A-1]
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:20:HDMI-A-1] disconnected
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:23:VGA-1]
[drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter rk3x-i2c
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:23:VGA-1] disconnected
[drm:drm_setup_crtcs] 
[drm:drm_enable_connectors] connector 20 enabled? no
[drm:drm_enable_connectors] connector 23 enabled? no
[drm:drm_setup_crtcs] picking CRTCs for 4096x4096 config
[drm:drm_crtc_helper_set_config] 
[drm:drm_crtc_helper_set_config] [CRTC:8] [NOFB]
[drm:vop_crtc_dpms] crtc[8] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:drm_crtc_helper_set_config] 
[drm:drm_crtc_helper_set_config] [CRTC:14] [NOFB]
[drm:vop_crtc_dpms] crtc[8] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:vop_crtc_dpms] crtc[14] mode[3]
rk_iommu ff930300.iommu: Enable stall request timed out, status: 0x00004b
rk_iommu ff930300.iommu: Disable paging request timed out, status: 0x00004b
rockchip-vop ff930000.vop: Detached from iommu domain

--nextPart1902738.pEWEpHICtU
Content-Disposition: attachment; filename="log.plugged-on-boot"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="log.plugged-on-boot"

rockchip-drm display-subsystem: bound ff940000.vop (ops vop_component_ops)
rockchip-drm display-subsystem: bound ff930000.vop (ops vop_component_ops)
dwhdmi-rockchip ff980000.hdmi: Detected HDMI controller 0x20:0xa:0xa0:0xc1
rockchip-drm display-subsystem: bound ff980000.hdmi (ops dw_hdmi_rockchip_ops)
rockchip-drm display-subsystem: bound vga-bridge (ops vga_bridge_ops)
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
[drm:vop_crtc_dpms] crtc[8] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:vop_crtc_dpms] crtc[14] mode[3]
[drm:vop_crtc_dpms] desired dpms mode is same as previous one.
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:20:HDMI-A-1]
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:20:HDMI-A-1] disconnected
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:23:VGA-1]
[drm:drm_helper_probe_single_connector_modes_merge_bits] [CONNECTOR:23:VGA-1] probed modes :
[drm:drm_mode_debug_printmodeline] Modeline 25:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 0x5
[drm:drm_mode_debug_printmodeline] Modeline 37:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 26:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 27:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 38:"1024x768" 75 78800 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 39:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 40:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 41:"832x624" 75 57284 832 864 928 1152 624 625 628 667 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 28:"800x600" 85 56250 800 832 896 1048 600 601 604 631 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 42:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 43:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 30:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 31:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[drm:drm_mode_debug_printmodeline] Modeline 29:"640x480" 85 36000 640 696 752 832 480 481 484 509 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 32:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 33:"640x480" 73 31500 640 664 704 832 480 489 491 520 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 34:"640x480" 67 30240 640 704 768 864 480 483 486 525 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 35:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[drm:drm_mode_debug_printmodeline] Modeline 36:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[drm:drm_setup_crtcs] 
[drm:drm_enable_connectors] connector 20 enabled? no
[drm:drm_enable_connectors] connector 23 enabled? yes
[drm:drm_target_preferred] looking for cmdline mode on connector 23
[drm:drm_target_preferred] looking for preferred mode on connector 23 0
[drm:drm_target_preferred] found mode 1280x1024
[drm:drm_setup_crtcs] picking CRTCs for 4096x4096 config
[drm:drm_setup_crtcs] desired mode 1280x1024 set on crtc 14 (0,0)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 33 at mm/page_alloc.c:2645 __alloc_pages_nodemask+0x18c/0x6a8()
Modules linked in:
CPU: 1 PID: 33 Comm: kworker/u8:1 Not tainted 3.19.0-rc1+ #1512
Hardware name: Rockchip Cortex-A9 (Device Tree)
Workqueue: deferwq deferred_probe_work_func
[<c00148e4>] (unwind_backtrace) from [<c00111e0>] (show_stack+0x10/0x14)
[<c00111e0>] (show_stack) from [<c0426564>] (dump_stack+0x6c/0x84)
[<c0426564>] (dump_stack) from [<c0021f34>] (warn_slowpath_common+0x80/0xac)
[<c0021f34>] (warn_slowpath_common) from [<c0021f78>] (warn_slowpath_null+0x18/0x1c)
[<c0021f78>] (warn_slowpath_null) from [<c008b114>] (__alloc_pages_nodemask+0x18c/0x6a8)
[<c008b114>] (__alloc_pages_nodemask) from [<c001a274>] (__dma_alloc_buffer.isra.18+0x2c/0x80)
[<c001a274>] (__dma_alloc_buffer.isra.18) from [<c001a2dc>] (__alloc_remap_buffer.isra.22+0x14/0x5c)
[<c001a2dc>] (__alloc_remap_buffer.isra.22) from [<c001a490>] (__dma_alloc+0x16c/0x1d8)
[<c001a490>] (__dma_alloc) from [<c001a614>] (arm_dma_alloc+0x84/0x90)
[<c001a614>] (arm_dma_alloc) from [<c022f610>] (rockchip_gem_create_object+0x8c/0xc4)
[<c022f610>] (rockchip_gem_create_object) from [<c022f158>] (rockchip_drm_fbdev_create+0x6c/0x1ec)
[<c022f158>] (rockchip_drm_fbdev_create) from [<c021499c>] (drm_fb_helper_initial_config+0x230/0x328)
[<c021499c>] (drm_fb_helper_initial_config) from [<c022f388>] (rockchip_drm_fbdev_init+0xa4/0xc0)
[<c022f388>] (rockchip_drm_fbdev_init) from [<c022ea18>] (rockchip_drm_load+0x1b8/0x1f4)
[<c022ea18>] (rockchip_drm_load) from [<c021c218>] (drm_dev_register+0x80/0x100)
[<c021c218>] (drm_dev_register) from [<c022e77c>] (rockchip_drm_bind+0x48/0x74)
[<c022e77c>] (rockchip_drm_bind) from [<c0234a58>] (try_to_bring_up_master.part.2+0xa4/0xf4)
[<c0234a58>] (try_to_bring_up_master.part.2) from [<c0234c58>] (component_add+0x9c/0x104)
[<c0234c58>] (component_add) from [<c023a1e4>] (platform_drv_probe+0x48/0x90)
[<c023a1e4>] (platform_drv_probe) from [<c0238c30>] (driver_probe_device+0x130/0x340)
[<c0238c30>] (driver_probe_device) from [<c0237270>] (bus_for_each_drv+0x70/0x84)
[<c0237270>] (bus_for_each_drv) from [<c0238a8c>] (device_attach+0x64/0x88)
[<c0238a8c>] (device_attach) from [<c0238090>] (bus_probe_device+0x28/0x98)
[<c0238090>] (bus_probe_device) from [<c0238548>] (deferred_probe_work_func+0x78/0xa4)
[<c0238548>] (deferred_probe_work_func) from [<c0034008>] (process_one_work+0x1c8/0x2f4)
[<c0034008>] (process_one_work) from [<c0034448>] (worker_thread+0x2e8/0x450)
[<c0034448>] (worker_thread) from [<c00380a8>] (kthread+0xdc/0xf0)
[<c00380a8>] (kthread) from [<c000e8b8>] (ret_from_fork+0x14/0x3c)
---[ end trace ce23b3730f8c0d32 ]---
[drm:rockchip_gem_create_object] *ERROR* failed to allocate 0x500000 byte dma buffer

--nextPart1902738.pEWEpHICtU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--nextPart1902738.pEWEpHICtU--
