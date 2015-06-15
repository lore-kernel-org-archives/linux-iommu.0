From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 (alternative) 1/3] drm/exynos: fimd: ensure proper hw
 state in fimd_clear_channel()
Date: Mon, 15 Jun 2015 15:35:21 +0200
Message-ID: <557ED499.9080605@samsung.com>
References: <557AA0D3.8010808@samsung.com>
 <1434100037-12304-1-git-send-email-m.szyprowski@samsung.com>
 <1434100037-12304-2-git-send-email-m.szyprowski@samsung.com>
 <557ACC51.9090109@samsung.com> <557AE3C7.7090804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <557AE3C7.7090804@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Inki Dae <inki.dae@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-06-12 15:51, Inki Dae wrote:
> On 2015=EB=85=84 06=EC=9B=94 12=EC=9D=BC 21:10, Inki Dae wrote:
>> On 2015=EB=85=84 06=EC=9B=94 12=EC=9D=BC 18:07, Marek Szyprowski wro=
te:
>>> One should not do any assumptions on the stare of the fimd hardware
>>> during driver initialization, so to properly reset fimd before enab=
ling
>>> IOMMU, one should ensure that all power domains and clocks are real=
ly
>>> enabled. This patch adds pm_runtime and clocks management in the
>>> fimd_clear_channel() function to ensure that any access to fimd
>>> registers will be performed with clocks and power domains enabled.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.u=
k>
>>> ---
>>> Changelog:
>>> v3 (alternative):
>>> - araranged code by moving fimd_{enable,disable}_vblank functions b=
efore
>>>    fimd_clear_channel to avoid forward declaration usage
>> Marek,
>>
>> For the iommu and atomic feature test, I merged below patches in
>> addition and tested them.
>>
>> [PATCH v2 1/3] drm/exynos: remove to call mixer_wait_for_vblank
>> [PATCH v2 2/3] drm/exynos: remove chained calls to enable
>> [PATCH v2 3/3] drm/exynos: initialize VIDCON0 when fimd is disabled
>>
>>
>> However, I see below one warning log,
>>
>> [    1.227115] [drm] Initialized drm 1.1.0 20060810
>> [    1.235852] exynos-drm exynos-drm: bound exynos-drm-vidi (ops
>> vidi_component_ops)
>> [    1.253548] ------------[ cut here ]------------
>> [    1.256700] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/drm_irq.c:1=
718
>> drm_handle_vblank+0x2a0/0x308()
>> [    1.265800] Modules linked in:
>> [    1.268844] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>> 4.1.0-rc4-00574-gf8eb363-dirty #1412
>> [    1.277085] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [    1.283184] [<c0015464>] (unwind_backtrace) from [<c00123c0>]
>> (show_stack+0x10/0x14)
>> [    1.288540] exynos-drm exynos-drm: bound 11c00000.fimd (ops
>> fimd_component_ops)
>> [    1.288883] exynos-drm exynos-drm: bound 11c80000.dsi (ops
>> exynos_dsi_component_ops)
>> [    1.288888] [drm] Supports vblank timestamp caching Rev 2 (21.10.=
2013).
>> [    1.288891] [drm] No driver support for vblank timestamp query.
>> [    1.288932] [drm] Initialized exynos 1.0.0 20110530 on minor 0
>> [    1.324248] [<c00123c0>] (show_stack) from [<c0528f74>]
>> (dump_stack+0x84/0xc4)
>> [    1.331437] [<c0528f74>] (dump_stack) from [<c00246ac>]
>> (warn_slowpath_common+0x80/0xb0)
>> [    1.339504] [<c00246ac>] (warn_slowpath_common) from [<c0024778>]
>> (warn_slowpath_null+0x1c/0x24)
>> [    1.348270] [<c0024778>] (warn_slowpath_null) from [<c029c898>]
>> (drm_handle_vblank+0x2a0/0x308)
>> [    1.356965] [<c029c898>] (drm_handle_vblank) from [<c02b8c80>]
>> (fimd_irq_handler+0x78/0xd0)
>> [    1.365292] [<c02b8c80>] (fimd_irq_handler) from [<c00608f8>]
>> (handle_irq_event_percpu+0x78/0x134)
>> [    1.374231] [<c00608f8>] (handle_irq_event_percpu) from [<c00609f=
0>]
>> (handle_irq_event+0x3c/0x5c)
>> [    1.374244] [<c00609f0>] (handle_irq_event) from [<c0063698>]
>> (handle_level_irq+0xc4/0x13c)
>> [    1.374256] [<c0063698>] (handle_level_irq) from [<c005ff7c>]
>> (generic_handle_irq+0x2c/0x3c)
>> [    1.374269] [<c005ff7c>] (generic_handle_irq) from [<c02214ec>]
>> (combiner_handle_cascade_irq+0x94/0x100)
>> [    1.374281] [<c02214ec>] (combiner_handle_cascade_irq) from
>> [<c005ff7c>] (generic_handle_irq+0x2c/0x3c)
>> [    1.374290] [<c005ff7c>] (generic_handle_irq) from [<c0060248>]
>> (__handle_domain_irq+0x7c/0xec)
>> [    1.374300] [<c0060248>] (__handle_domain_irq) from [<c0009434>]
>> (gic_handle_irq+0x30/0x68)
>>
>>
>> And below one page fault error when modetest is terminated,
>>
>> # modetest -M exynos -v -s 31@29:720x1280
>> setting mode 720x1280-60Hz@XR24 on connectors 31, crtc 29
>> freq: 59.99Hz
>>
>> [   34.831025] PAGE FAULT occurred at 0x20400000 by 11e20000.sysmmu(=
Page
>> table base: 0x6e324000)
>> [   34.838072]  Lv1 entry: 0x6e92dc01
>> [   34.841489] ------------[ cut here ]------------
>> [   34.846058] kernel BUG at drivers/iommu/exynos-iommu.c:364!
>> [   34.851614] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>> [   34.857428] Modules linked in:
>> [   34.860472] CPU: 0 PID: 6 Comm: kworker/u8:0 Tainted: G        W
>>    4.1.0-rc4-00574-gf8eb363-dirty #1412
>> [   34.870188] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [   34.876273] Workqueue: events_unbound async_run_entry_fn
>> [   34.881560] task: ee879540 ti: ee8a2000 task.ti: ee8a2000
>> [   34.886946] PC is at exynos_sysmmu_irq+0x184/0x208
>> [   34.891716] LR is at exynos_sysmmu_irq+0xd4/0x208
>> [   34.896404] pc : [<c02880d0>]    lr : [<c0288020>]    psr: 600001=
93
>> [   34.896404] sp : ee8a3c00  ip : 00000000  fp : eeacbc10
>> [   34.907860] r10: c07c27ef  r9 : 00000204  r8 : 20400000
>> [   34.913068] r7 : ee324000  r6 : ee9b3428  r5 : ee9b3410  r4 : 000=
00000
>> [   34.919577] r3 : 6e92dc01  r2 : 6e92dc01  r1 : eea55810  r0 : eeb=
0a000
>> [   34.926089] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
>> Segment kernel
>> [   34.933466] Control: 10c5387d  Table: 6dd2c04a  DAC: 00000015
>> [   34.939195] Process kworker/u8:0 (pid: 6, stack limit =3D 0xee8a2=
210)
>> [   34.945444] Stack: (0xee8a3c00 to 0xee8a4000)
>> [   34.949788] 3c00: ee8a3c0c c0049df8 00000000 6e324000 0003d4f3
>> ee9b13c0 ee84ad20 00000000
>> [   34.957947] 3c20: 00000000 00000026 ee84acc0 c00608f8 60000093
>> eef84580 ee84acc0 ee84ad20
>> [   34.966106] 3c40: ee9b13c0 00000015 ee804450 ee8a3cd8 ee808000
>> c00609f0 ee84acc0 ee84ad20
>> [   34.974265] 3c60: ee807000 c0063698 00000026 c079d6f8 ee807000
>> c005ff7c 0000000a c02214ec
>> [   34.982424] 3c80: 00000015 00000000 00000015 00000000 00000001
>> c005ff7c c0789aac c0060248
>> [   34.990583] 3ca0: f002000c 00000015 c078e7ac ee8a3cd8 f0020000
>> ee8a2000 00000001 c0009434
>> [   34.998742] 3cc0: c052e8fc 60000013 ffffffff ee8a3d0c 00000004
>> c0012ec0 eeacbd18 ee879540
>> [   35.006901] 3ce0: 00000000 00000271 eeacbd18 00000000 eea55010
>> c078e100 00000004 ee8a2000
>> [   35.015061] 3d00: 00000001 eeacbc10 eeacbd88 ee8a3d20 c052e8f8
>> c052e8fc 60000013 ffffffff
>> [   35.023220] 3d20: eeacbd18 c02dab48 20000113 00000003 60000013
>> eeacbd18 00000004 eeacbc60
>> [   35.031379] 3d40: ffff30d5 eeacbca8 eeacbd18 00000004 60000013
>> ffff30d5 c0802fe8 c02db05c
>> [   35.039538] 3d60: eeacbc60 00000002 c078e100 eeacbc60 ffff30d5
>> c03b0f2c c078bb40 ee8a3e28
>> [   35.047697] 3d80: 00000001 ee8a3db8 eeacbc70 00000002 eeacbc70
>> ee8a3db8 eeacbca8 c052e880
>> [   35.055857] 3da0: eeacbc70 c052d818 00000000 00000009 00000000
>> c002791c ee8a3db8 11111111
>> [   35.064016] 3dc0: 11111111 ee8a3dc4 11111111 eeacbc60 00000002
>> c078e100 ee8a3e28 ffff30d5
>> [   35.072175] 3de0: c0802fe8 00000001 ee80b400 c03ac4cc 00000000
>> eeacbc60 ee8a3e28 00000002
>> [   35.080334] 3e00: eea47ac0 00000000 ee849d00 c03ac69c 00000000
>> 00000001 00000001 eea47ac0
>> [   35.088493] 3e20: eea47ac0 c02e9f10 00000009 60000001 eea47ac0
>> 00010009 00000001 eea47ac0
>> [   35.096653] 3e40: ee29149c 00000000 ee00c200 c02e5bdc 00000001
>> c004425c ee00c200 00000047
>> [   35.104812] 3e60: ee00c200 ee00c200 ee8a3eb4 ee8a3eb4 00000000
>> c02e5c5c ee00c200 ee00c200
>> [   35.112971] 3e80: 00000047 c02e564c ee00c200 00000047 ee8a3eb4
>> ee80da00 00000000 c02e5704
>> [   35.121130] 3ea0: eeafd800 c07c5020 eeafd84c c025383c ee849d00
>> c052d110 eeafd800 c0252a48
>> [   35.129289] 3ec0: ee914724 c07c5020 edcc9c40 c0252f58 edcc9c50
>> c003ed48 eef84580 eea2f700
>> [   35.137448] 3ee0: ee849d00 edcc9c50 ee80b400 c0037944 ee8a2000
>> ee80b400 00000001 ee80b400
>> [   35.145608] 3f00: ee849d18 ee80b420 ee8a2000 00000088 c07c27bc
>> ee849d00 ee80b400 c0037ba0
>> [   35.153767] 3f20: c078e100 ee80b570 ee849d00 00000000 ee84b540
>> ee849d00 c0037b54 00000000
>> [   35.161926] 3f40: 00000000 00000000 00000000 c003c8b8 ffffffff
>> 00000000 ffffffff ee849d00
>> [   35.170085] 3f60: 00000000 00000000 dead4ead ffffffff ffffffff
>> ee8a3f74 ee8a3f74 00000000
>> [   35.178245] 3f80: 00000000 dead4ead ffffffff ffffffff ee8a3f90
>> ee8a3f90 ee8a3fac ee84b540
>> [   35.186403] 3fa0: c003c7dc 00000000 00000000 c000f5a0 00000000
>> 00000000 00000000 00000000
>> [   35.194562] 3fc0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> [   35.202722] 3fe0: 00000000 00000000 00000000 00000000 00000013
>> 00000000 ffffffff ffffffff
>> [   35.210894] [<c02880d0>] (exynos_sysmmu_irq) from [<c00608f8>]
>> (handle_irq_event_percpu+0x78/0x134)
>> [   35.219914] [<c00608f8>] (handle_irq_event_percpu) from [<c00609f=
0>]
>> (handle_irq_event+0x3c/0x5c)
>> [   35.228768] [<c00609f0>] (handle_irq_event) from [<c0063698>]
>> (handle_level_irq+0xc4/0x13c)
>> [   35.237101] [<c0063698>] (handle_level_irq) from [<c005ff7c>]
>> (generic_handle_irq+0x2c/0x3c)
>> [   35.245521] [<c005ff7c>] (generic_handle_irq) from [<c02214ec>]
>> (combiner_handle_cascade_irq+0x94/0x100)
>> [   35.254980] [<c02214ec>] (combiner_handle_cascade_irq) from
>> [<c005ff7c>] (generic_handle_irq+0x2c/0x3c)
>> [   35.264353] [<c005ff7c>] (generic_handle_irq) from [<c0060248>]
>> (__handle_domain_irq+0x7c/0xec)
>> [   35.273034] [<c0060248>] (__handle_domain_irq) from [<c0009434>]
>> (gic_handle_irq+0x30/0x68)
>> [   35.281366] [<c0009434>] (gic_handle_irq) from [<c0012ec0>]
>> (__irq_svc+0x40/0x74)
>>
>> Could you check the iommu with atomic feature? I tested these featur=
es
>> on trats2 board, and enabled one more crtc drivers - HDMI, VIDI, and=
 FIMD.
>>
>> To other Exynos guys,
>> could you guys check the same issues also? If you give some helps to=
 us,
>> we'd be glad.
> I resolved above page fault issue with below patch:
> 	[PATCH] drm/exynos: fimd: fix page fault issue with iommu
>
> However, I still see above warning log. The problem is because
> dev->num_crtcs is 0 when drm_handle_vblank function is called by fimd
> irq handler.

Okay, I've managed to reproduce this issue. I will post v4 patch soon.=20
Setting
ctx->pipe to -1 temporarily for vblank enable/wait/disable sequence=20
solves this
issue.

 > (...)


Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland
