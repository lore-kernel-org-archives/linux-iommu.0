From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Wed, 07 Jan 2015 11:03:12 +0900
Message-ID: <54AC93E0.8010705@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Inki Dae <inki.dae@samsung.com>, iommu@lists.linux-foundation.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Gustavo Padovan <gustavo.>
List-Id: iommu@lists.linux-foundation.org

On 01/06/2015 06:49 PM, Javier Martinez Canillas wrote:
> Hello Marek,
> 
> On Fri, Dec 5, 2014 at 11:22 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 2014-12-02 10:59, Sjoerd Simons wrote:
>>>>
>>>> This is another attempt to finally make Exynos SYSMMU driver fully
>>>> integrated with DMA-mapping subsystem. The main change from previous
>>>> version is a rebase onto latest "automatic DMA configuration for IOMMU
>>>> masters" patches from Will Deacon.
>>>
>>> Do you happen to know if anyone is working on iommu/dma-mapping patches
>>> for Exynos 5 based on this patchset?
>>
>>
>> I hope to add Exynos5 SYSMMU patches to the next iteration of my patchset,
>> but I doubt it will get into v3.19-rc1.
>>
>>> For some background to that question, We (re-)discovered yesterday that
>>> the out-of-tree exynos-reference kernel iommu patches are required to
>>> get HDMI out working on exynos 5 boards. The current situation in
>>> mainline is rather broken, HDMI output without CONFIG_DRM_EXYNOS_IOMMU
>>> results in just displaying stripes[0]. While turning on
>>> CONFIG_DRM_EXYNOS_IOMMU causes a kernel oops at boot....
>>
>>
>> We have observed similar issues with Exynos4 based boards, when LCD0 power
>> domain was turned off and only TV power domain has been powered on. Please
>> check the power domain configuration. Maybe in case of Exynos5 the same
> 
> So IIUC what you are saying is that enabling the Exynos DRM IOMMU
> support has the side effect of turning on all the power domains needed
> by HDMI? I've compared the power domains configuration in mainline
> with the downstream exynos-reference [0] tree and I didn't find any
> differences.
> 
>> issue
>> is caused by the interaction between DISP1 and GSCL domains.
>>
> 
> I was also not able to find a dependency betwen GSCL and DISP1 power
> domains in the Exynos 5420 manual. But If that's the case then your
> patch to add support for sub-power domains on Exynos [1] will also be
> needed, right?
> 
> AFAICT from the manual, all the used modules in the case of HDMI +
> Display (LCD, DP, HDMI and MIXER) needs only the DISP1 power domain to
> be enabled which BTW was removed for Exynos5420 on commit d51cad7
> ("ARM: dts: remove display power domain for exynos5420"). It seems to
> work just because the power domain is turned on by the bootloader.
> 
> Also I tried forcing the kernel to not disable unused power domains by
> passing the pd_ignore_unused parameter to the kernel command line. I
> see on the kernel log a "genpd: Not disabling unused power domains"
> message but HDMI output still has the stripes that Sjoerd mentioned.
> Do you know if Exynos DRM HDMI in mainline is supposed to work without
> SysMMU / IOMMU support?
> 

I don't think iommu support and power domain issue are related. I also
get displaying stripes via hdmi but it is just power domain issue
regardless iommu support.

I observed 8th bit from 0x1445000C register of mixer is set to 1 with
displaying stripes. It means "The graphic layer0 line buffer underflow".
There was same underflow issue on Exynos4 based boards. As Marek said,
because LCD0 power domain was turned off.

I just tried to turn off DISP1 power domain at u-boot and DISP1 power
domain is turned on from kernel hdmi and mixer driver on odroid xu3 
board. As the result, i can see displaying penguin logo from hdmi.

But the problem exists still because it is failed to control on/off of
DISP1 power domain more than twice from kernel hdmi and mixer driver.[0]

Thanks.

[0]:
[   63.477922] Power domain power-domain disable failed
[   63.481416] power-domain: Power-off latency exceeded, new value 10613042 ns
[   63.499805] power-domain: Power-on latency exceeded, new value 8863333 ns
[   63.506766] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0280000
[   63.514191] Internal error: : 1008 [#1] PREEMPT SMP ARM
[   63.519386] Modules linked in:
[   63.522425] CPU: 0 PID: 1499 Comm: modetest Not tainted 3.18.1-00007-g04f5a4b-dirty #13
[   63.530393] task: eddd3400 ti: edfd0000 task.ti: edfd0000
[   63.535779] PC is at mixer_dpms+0x1dc/0x704
[   63.539931] LR is at __mutex_unlock_slowpath+0xa8/0x194
[   63.545125] pc : [<c02c0540>]    lr : [<c04c3eb8>]    psr: 60000013
[   63.545125] sp : edfd1c98  ip : ee709ef4  fp : ee752aa0
[   63.556561] r10: c07124b8  r9 : ee752800  r8 : c0712a38
[   63.561761] r7 : c0712a38  r6 : ee451a80  r5 : ee523a28  r4 : ee523a10
[   63.568260] r3 : f0280000  r2 : eddd3400  r1 : 035c035b  r0 : ee523a28
[   63.574760] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   63.581864] Control: 10c5387d  Table: 6d81006a  DAC: 00000015
[   63.587584] Process modetest (pid: 1499, stack limit = 0xedfd0238)
[   63.593736] Stack: (0xedfd1c98 to 0xedfd2000)
[   63.598070] 1c80:                                                       c02c0364 c0766b8c
[   63.606219] 1ca0: 00000000 edf8d000 c0712a38 ee753c00 ee752800 c07124b8 ee752aa0 c02b5118
[   63.614365] 1cc0: edf8d900 ee422c08 ee422810 ee753c00 edf8d900 ee752800 ee753c00 c0712a38
[   63.622510] 1ce0: edf8d000 00000001 edf8d900 c02b52c4 ee752a9c ee753c00 edf8d000 c02901cc
[   63.630656] 1d00: 00000000 00000000 00000001 edf8d014 00000000 00000000 00000000 ee753c68
[   63.638801] 1d20: ee753c00 c0766b8c 00000000 00000000 00000018 dededede 00000000 30323931
[   63.646946] 1d40: 38303178 00000030 00000000 00000000 00000000 00000000 00000000 00000000
[   63.655092] 1d60: 00000048 00024414 00000780 000007d8 00000804 00000898 00000000 00000438
[   63.663237] 1d80: 0000043c 00000441 00000465 00000000 00000005 00000256 00000150 00024414
[   63.671382] 1da0: 00000780 00000780 00000898 000007d8 00000804 00000898 00000000 00000438
[   63.679528] 1dc0: 00000438 00000465 0000043c 00000441 00000465 00000000 00000000 0000003c
[   63.687674] 1de0: 00000000 00000000 00000001 ee753c00 ee752a7c ee5a2b80 ee752a88 ee752aa0
[   63.695820] 1e00: eddd2c00 c0766b8c 00000001 c0290d18 00000000 c0040374 ee753c10 edfd0000
[   63.703965] 1e20: ee752800 00000001 00000000 ed82bec0 00000000 00000000 ee753c00 ee752aa0
[   63.712110] 1e40: c07124b8 00000000 ee753c10 edfa8580 ee753c00 00000000 edc8b500 00000000
[   63.720256] 1e60: ed8827a8 ee525580 ee752958 c02a5f58 ee5a2b80 00000001 00000000 edc8b500
[   63.728402] 1e80: 00000000 c02971b8 ee752800 edc8b500 ee752800 edc8b500 ee75285c ee752800
[   63.736547] 1ea0: ee752834 c02971f4 ee752800 c0766b8c ee75285c c029c3c0 ed8827ac ed882700
[   63.744692] 1ec0: ee75285c c029c7c4 ee24b0e8 00000001 edfa8f80 ee752960 60000013 00000000
[   63.752838] 1ee0: ee7a9508 ed882000 ede78d60 00000000 edf8d490 ee0bd7b8 00000008 ed882008
[   63.760983] 1f00: 00000000 c00cbf78 00000000 00000000 eddd374c 00000000 c072ad84 eddd3400
[   63.769129] 1f20: edfd0008 00000000 ed874e44 c003777c eddd375c eddd3400 edfd0000 ed874e00
[   63.777274] 1f40: edfd0008 c0022af8 00000000 00000001 ed874e04 ee78d898 ee78d8a0 c00b1d2c
[   63.785420] 1f60: 000000dd edcdb700 00000000 edfd0000 000000f8 c000e824 edfd0000 00000000
[   63.793566] 1f80: 00000000 c0023ee8 000a3d78 b6f2a770 b6f2a770 000000f8 c000e824 c0023f64
[   63.801711] 1fa0: 000a3d78 c000e6a0 000a3d78 b6f2a770 00000000 000a3d64 00000008 00000000
[   63.809857] 1fc0: 000a3d78 b6f2a770 b6f2a770 000000f8 b6e56248 00000000 0000fd4c 00000000
[   63.818002] 1fe0: b6fa2000 bed38ba8 b6e1a4dc b6e883d4 60000010 00000000 ffffffff ffffffff
[   63.826162] [<c02c0540>] (mixer_dpms) from [<c02b5118>] (exynos_drm_crtc_dpms+0x6c/0x17c)
[   63.834296] [<c02b5118>] (exynos_drm_crtc_dpms) from [<c02b52c4>] (exynos_drm_crtc_commit+0x14/0x44)
[   63.843400] [<c02b52c4>] (exynos_drm_crtc_commit) from [<c02901cc>] (drm_crtc_helper_set_mode+0x3d0/0x51c)
[   63.853016] [<c02901cc>] (drm_crtc_helper_set_mode) from [<c0290d18>] (drm_crtc_helper_set_config+0x87c/0x9dc)
[   63.862982] [<c0290d18>] (drm_crtc_helper_set_config) from [<c02a5f58>] (drm_mode_set_config_internal+0x58/0xd4)
[   63.873119] [<c02a5f58>] (drm_mode_set_config_internal) from [<c02971b8>] (restore_fbdev_mode+0xcc/0xec)
[   63.882562] [<c02971b8>] (restore_fbdev_mode) from [<c02971f4>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x1c/0x30)
[   63.893135] [<c02971f4>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c029c3c0>] (drm_lastclose+0x34/0x118)
[   63.903358] [<c029c3c0>] (drm_lastclose) from [<c029c7c4>] (drm_release+0x320/0x4c8)
[   63.911071] [<c029c7c4>] (drm_release) from [<c00cbf78>] (__fput+0x80/0x1c8)
[   63.918095] [<c00cbf78>] (__fput) from [<c003777c>] (task_work_run+0xac/0xe4)
[   63.925204] [<c003777c>] (task_work_run) from [<c0022af8>] (do_exit+0x2cc/0x958)
[   63.932563] [<c0022af8>] (do_exit) from [<c0023ee8>] (do_group_exit+0x4c/0xb8)
[   63.939754] [<c0023ee8>] (do_group_exit) from [<c0023f64>] (__wake_up_parent+0x0/0x18)
[   63.947636] Code: e1a00005 e5c43011 eb080e99 e5943044 (e5936000) 
[   63.953701] ---[ end trace d3294b7b867ca713 ]---
[   63.958290] Fixing recursive fault but reboot is needed!
