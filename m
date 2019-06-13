Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35157C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 08:19:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F8920866
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 08:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KC/rcPxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F8920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C1FA9AF0;
	Thu, 13 Jun 2019 08:19:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D53CCB43
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 08:15:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B1086711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 08:15:13 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id z25so29915808edq.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zXVzeJJ+IcjGVsluPoz9/xy53aYVquuN8J0o2PTuBWc=;
	b=KC/rcPxoGhLBIpZYwYWi0BTmEE8YpElkrwy0XNoxO38l2rjS3TteziEkuEVBsPU0yh
	m2QomK1otWSOlhUSBOTymdOGEY0yRqDJXSOT5bGACEIp3qVO8BEjaaMyAXRmKakH39xB
	U0oeVbnQlI76N26hdPBFHl2IeXK0TDwtre4kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zXVzeJJ+IcjGVsluPoz9/xy53aYVquuN8J0o2PTuBWc=;
	b=fUHCxI2yA2D+EFl26vgWn/LRwaJht29ILbHQ5HchojYURJxhEEwnZMdyx30+mU020V
	9SlhplVN8Xc35a3ozrq41KTX7gSCVI0OjP+YrrQIcIIMznjK1CcPPuIIO53clbIA64Sg
	BSIZWGK0rLeLMfZNMdolhZcHMz+ecUVi5z85mIf8qS4na0rI9HXfQ8mzIgI3yxxLKIGQ
	qniDjYeFiQFHPJAM/knAPCd07j1XvA1Rw0ZkvZ0a8JqNnBzk08LNezNq6Vu1HhKulr8i
	wBrJlhlr7On94RnJsckEEaPnSZk0qjvwtZvYMRit5TzG+UyTta/GwFMmobIaIZTH8CCJ
	Vl7g==
X-Gm-Message-State: APjAAAXNLvnFD9pOrZgl03ZKf5pJYWIKVURoYhFUTWb8Rp8ouXwh8569
	2t0FtL3jgfzznGRg8o/xeJsD0iJPKJrIx0U91LooqA==
X-Google-Smtp-Source: APXvYqxT6IXGmph6ZomYwynG6DDxK4YIvthvLw2oJLehuJkS3aaUPDoUAVg6rnvxEFX3et0JxEYuU3an+tdNdQyL7PY=
X-Received: by 2002:a50:bc15:: with SMTP id j21mr91500988edh.163.1560413711986;
	Thu, 13 Jun 2019 01:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
	<1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Thu, 13 Jun 2019 16:14:36 +0800
Message-ID: <CANdKZ0d873PJ2u=Hn_aUJBu3dDiNyueVwBv94-VXHGLJBvAbGg@mail.gmail.com>
Subject: Re: [PATCH v7 16/21] memory: mtk-smi: Add bus_sel for mt8183
To: Yong Wu <yong.wu@mediatek.com>
X-Mailman-Approved-At: Thu, 13 Jun 2019 08:19:30 +0000
Cc: youlin.pei@mediatek.com,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, "moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
	"moderated list:ARM/Mediatek SoC support"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8867390028290118547=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============8867390028290118547==
Content-Type: multipart/alternative; boundary="000000000000018fdc058b3021f6"

--000000000000018fdc058b3021f6
Content-Type: text/plain; charset="UTF-8"

Hi,
When I tested this patch series (Based on linux 5.2.0-rc2, and with
various other patch series about MT8183) with lockdep enabled, and I'm
seeing the following lockdep warning on boot.

By bisecting the commits, the first commit that introduce this warning
is this patch. The warning also doesn't appear if
https://lore.kernel.org/patchwork/patch/1086582/ and
https://lore.kernel.org/patchwork/patch/1086583/ are not applied.

Do anyone have idea on why this is happening, or any suggestion on
which part I should be digging into to figure this out? Thanks.

[    4.664194] ======================================================
[    4.670368] WARNING: possible circular locking dependency detected
[    4.676545] 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20 Tainted: G S
[    4.684539] ------------------------------------------------------
[    4.690714] kworker/4:1/51 is trying to acquire lock:
[    4.695760] (____ptrval____) (regulator_list_mutex){+.+.},
at:regulator_lock_dependent+0xdc/0x6c4
[    4.704732]
[    4.704732] but task is already holding lock:
[    4.710556] (____ptrval____) (&genpd->mlock/1){+.+.},
at:genpd_lock_nested_mtx+0x24/0x30
[    4.718740]
[    4.718740] which lock already depends on the new lock.
[    4.718740]
[    4.726908]
[    4.726908] the existing dependency chain (in reverse order) is:
[    4.734382]
[    4.734382] -> #4 (&genpd->mlock/1){+.+.}:
[    4.739963]        __mutex_lock_common+0x1a0/0x1fe8
[    4.744836]        mutex_lock_nested+0x40/0x50
[    4.749275]        genpd_lock_nested_mtx+0x24/0x30
[    4.754063]        genpd_add_subdomain+0x150/0x524
[    4.758850]        pm_genpd_add_subdomain+0x3c/0x5c
[    4.763723]        scpsys_probe+0x520/0xe78
[    4.767902]        platform_drv_probe+0xf4/0x134
[    4.772517]        really_probe+0x214/0x4dc
[    4.776696]        driver_probe_device+0xcc/0x1d4
[    4.781396]        __device_attach_driver+0x10c/0x180
[    4.786442]        bus_for_each_drv+0x124/0x184
[    4.790968]        __device_attach+0x1c0/0x2d8
[    4.795407]        device_initial_probe+0x20/0x2c
[    4.800106]        bus_probe_device+0x80/0x16c
[    4.804546]        deferred_probe_work_func+0x120/0x168
[    4.809767]        process_one_work+0x858/0x1208
[    4.814379]        worker_thread+0x9ec/0xcb8
[    4.818644]        kthread+0x2b8/0x2d0
[    4.822391]        ret_from_fork+0x10/0x18
[    4.826480]
[    4.826480] -> #3 (&genpd->mlock){+.+.}:
[    4.831880]        __mutex_lock_common+0x1a0/0x1fe8
[    4.836752]        mutex_lock_nested+0x40/0x50
[    4.841190]        genpd_lock_mtx+0x20/0x2c
[    4.845369]        genpd_runtime_resume+0x140/0x434
[    4.850241]        __rpm_callback+0xb0/0x1e4
[    4.854506]        rpm_callback+0x54/0x1a8
[    4.858597]        rpm_resume+0xc6c/0x10c4
[    4.862689]        __pm_runtime_resume+0xb4/0x124
[    4.867387]        device_link_add+0x598/0x8d0
[    4.871829]        mtk_smi_larb_probe+0x2b0/0x340
[    4.876528]        platform_drv_probe+0xf4/0x134
[    4.881141]        really_probe+0x214/0x4dc
[    4.885320]        driver_probe_device+0xcc/0x1d4
[    4.890020]        __device_attach_driver+0x10c/0x180
[    4.895066]        bus_for_each_drv+0x124/0x184
[    4.899591]        __device_attach+0x1c0/0x2d8
[    4.904031]        device_initial_probe+0x20/0x2c
[    4.908730]        bus_probe_device+0x80/0x16c
[    4.913169]        deferred_probe_work_func+0x120/0x168
[    4.918387]        process_one_work+0x858/0x1208
[    4.923000]        worker_thread+0x9ec/0xcb8
[    4.927264]        kthread+0x2b8/0x2d0
[    4.931009]        ret_from_fork+0x10/0x18
[    4.935098]
[    4.935098] -> #2 (dpm_list_mtx){+.+.}:
[    4.940412]        __mutex_lock_common+0x1a0/0x1fe8
[    4.945284]        mutex_lock_nested+0x40/0x50
[    4.949722]        device_pm_lock+0x1c/0x24
[    4.953900]        device_link_add+0x98/0x8d0
[    4.958252]        _regulator_get+0x3f0/0x504
[    4.962606]        _devm_regulator_get+0x58/0xb8
[    4.967218]        devm_regulator_get+0x28/0x34
[    4.971746]        pwm_backlight_probe+0x61c/0x1b90
[    4.976617]        platform_drv_probe+0xf4/0x134
[    4.981230]        really_probe+0x214/0x4dc
[    4.985409]        driver_probe_device+0xcc/0x1d4
[    4.990108]        device_driver_attach+0xe4/0x104
[    4.994894]        __driver_attach+0x134/0x14c
[    4.999333]        bus_for_each_dev+0x120/0x180
[    5.003859]        driver_attach+0x48/0x54
[    5.007950]        bus_add_driver+0x2ac/0x44c
[    5.012303]        driver_register+0x160/0x288
[    5.016742]        __platform_driver_register+0xcc/0xdc
[    5.021964]        pwm_backlight_driver_init+0x1c/0x24
[    5.027097]        do_one_initcall+0x38c/0x994
[    5.031536]        do_initcall_level+0x3a4/0x4b8
[    5.036148]        do_basic_setup+0x84/0xa0
[    5.036153]        kernel_init_freeable+0x23c/0x324
[    5.036158]        kernel_init+0x14/0x110
[    5.036164]        ret_from_fork+0x10/0x18
[    5.036166]
[    5.036166] -> #1 (device_links_lock){+.+.}:
[    5.065905]        __mutex_lock_common+0x1a0/0x1fe8
[    5.070777]        mutex_lock_nested+0x40/0x50
[    5.075215]        device_link_remove+0x40/0xe0
[    5.079740]        _regulator_put+0x104/0x2d8
[    5.084093]        regulator_put+0x30/0x44
[    5.088184]        devm_regulator_release+0x38/0x44
[    5.093056]        release_nodes+0x604/0x670
[    5.097320]        devres_release_all+0x70/0x8c
[    5.101846]        really_probe+0x270/0x4dc
[    5.106024]        driver_probe_device+0xcc/0x1d4
[    5.110724]        device_driver_attach+0xe4/0x104
[    5.115510]        __driver_attach+0x134/0x14c
[    5.119949]        bus_for_each_dev+0x120/0x180
[    5.124474]        driver_attach+0x48/0x54
[    5.128566]        bus_add_driver+0x2ac/0x44c
[    5.132919]        driver_register+0x160/0x288
[    5.137357]        __platform_driver_register+0xcc/0xdc
[    5.142576]        pwm_backlight_driver_init+0x1c/0x24
[    5.147708]        do_one_initcall+0x38c/0x994
[    5.152146]        do_initcall_level+0x3a4/0x4b8
[    5.156758]        do_basic_setup+0x84/0xa0
[    5.160936]        kernel_init_freeable+0x23c/0x324
[    5.165807]        kernel_init+0x14/0x110
[    5.169813]        ret_from_fork+0x10/0x18
[    5.173901]
[    5.173901] -> #0 (regulator_list_mutex){+.+.}:
[    5.179910]        lock_acquire+0x350/0x4d4
[    5.184088]        __mutex_lock_common+0x1a0/0x1fe8
[    5.184095]        mutex_lock_nested+0x40/0x50
[    5.197475]        regulator_lock_dependent+0xdc/0x6c4
[    5.197482]        regulator_disable+0xa0/0x138
[    5.197487]        scpsys_power_off+0x38c/0x4bc
[    5.197495]        genpd_power_off+0x3d8/0x6a0
[    5.209399]        genpd_power_off+0x530/0x6a0
[    5.209406]        genpd_power_off_work_fn+0x74/0xc0
[    5.209411]        process_one_work+0x858/0x1208
[    5.209419]        worker_thread+0x9ec/0xcb8
[    5.219067]        kthread+0x2b8/0x2d0
[    5.219073]        ret_from_fork+0x10/0x18
[    5.219077]
[    5.219077] other info that might help us debug this:
[    5.219077]
[    5.219080] Chain exists of:
[    5.219080]   regulator_list_mutex --> &genpd->mlock --> &genpd->mlock/1
[    5.219080]
[    5.228039]  Possible unsafe locking scenario:
[    5.228039]
[    5.228042]        CPU0                    CPU1
[    5.228046]        ----                    ----
[    5.228048]   lock(&genpd->mlock/1);
[    5.228058]                                lock(&genpd->mlock);
[    5.311647]                                lock(&genpd->mlock/1);
[    5.317736]   lock(regulator_list_mutex);
[    5.321742]
[    5.321742]  *** DEADLOCK ***
[    5.321742]
[    5.327655] 4 locks held by kworker/4:1/51:
[    5.331831]  #0: (____ptrval____) ((wq_completion)pm){+.+.},
at:process_one_work+0x57c/0x1208
[    5.340444]  #1: (____ptrval____)
((work_completion)(&genpd->power_off_work)){+.+.},
at:process_one_work+0x5b8/0x1208
[    5.351139]  #2: (____ptrval____) (&genpd->mlock){+.+.},
at:genpd_lock_mtx+0x20/0x2c
[    5.358970]  #3: (____ptrval____) (&genpd->mlock/1){+.+.},
at:genpd_lock_nested_mtx+0x24/0x30
[    5.367584]
[    5.367584] stack backtrace:
[    5.371939] CPU: 4 PID: 51 Comm: kworker/4:1 Tainted: G S
 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20
[    5.382809] Workqueue: pm genpd_power_off_work_fn
[    5.382816] Call trace:
[    5.382822]  dump_backtrace+0x0/0x2c0
[    5.382830]  show_stack+0x20/0x2c
[    5.409174]  dump_stack+0x10c/0x17c
[    5.412659]  print_circular_bug+0x42c/0x4d0
[    5.416838]  __lock_acquire+0x4c88/0x5484
[    5.420843]  lock_acquire+0x350/0x4d4
[    5.424500]  __mutex_lock_common+0x1a0/0x1fe8
[    5.428851]  mutex_lock_nested+0x40/0x50
[    5.432770]  regulator_lock_dependent+0xdc/0x6c4
[    5.437383]  regulator_disable+0xa0/0x138
[    5.441389]  scpsys_power_off+0x38c/0x4bc
[    5.445393]  genpd_power_off+0x3d8/0x6a0
[    5.449310]  genpd_power_off+0x530/0x6a0
[    5.453229]  genpd_power_off_work_fn+0x74/0xc0
[    5.457667]  process_one_work+0x858/0x1208
[    5.461758]  worker_thread+0x9ec/0xcb8
[    5.465503]  kthread+0x2b8/0x2d0
[    5.468727]  ret_from_fork+0x10/0x18

On Mon, Jun 10, 2019 at 8:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
> ...


On Mon, Jun 10, 2019 at 8:21 PM Yong Wu <yong.wu@mediatek.com> wrote:

> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
>
> And, the base of smi-common is completely different with smi_ao_base
> of gen1, thus I add new variable for that.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 9790801..08cf40d 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -49,6 +49,12 @@
>  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
>  #define F_MMU_EN               BIT(0)
>
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> +
>  enum mtk_smi_gen {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -57,6 +63,7 @@ enum mtk_smi_gen {
>  struct mtk_smi_common_plat {
>         enum mtk_smi_gen gen;
>         bool             has_gals;
> +       u32              bus_sel; /* Balance some larbs to enter mmu0 or
> mmu1 */
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -72,8 +79,8 @@ struct mtk_smi {
>         struct clk                      *clk_apb, *clk_smi;
>         struct clk                      *clk_gals0, *clk_gals1;
>         struct clk                      *clk_async; /*only needed by
> mt2701*/
> -       void __iomem                    *smi_ao_base;
> -
> +       void __iomem                    *smi_ao_base; /* only for gen1 */
> +       void __iomem                    *base;        /* only for gen2 */
>         const struct mtk_smi_common_plat *plat;
>  };
>
> @@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct
> device *dev)
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>         .gen      = MTK_SMI_GEN2,
>         .has_gals = true,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> +                   F_MMU1_LARB(7),
>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> @@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct
> platform_device *pdev)
>                 ret = clk_prepare_enable(common->clk_async);
>                 if (ret)
>                         return ret;
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               common->base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(common->base))
> +                       return PTR_ERR(common->base);
>         }
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, common);
> @@ -497,6 +511,7 @@ static int mtk_smi_common_remove(struct
> platform_device *pdev)
>  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>  {
>         struct mtk_smi *common = dev_get_drvdata(dev);
> +       u32 bus_sel = common->plat->bus_sel;
>         int ret;
>
>         ret = mtk_smi_clk_enable(common);
> @@ -504,6 +519,9 @@ static int __maybe_unused mtk_smi_common_resume(struct
> device *dev)
>                 dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
>                 return ret;
>         }
> +
> +       if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
> +               writel(bus_sel, common->base + SMI_BUS_SEL);
>         return 0;
>  }
>
> --
> 1.9.1
>
>

--000000000000018fdc058b3021f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>When I tested this patch series (Based on linux 5.2=
.0-rc2, and with<br>various other patch series about MT8183) with lockdep e=
nabled, and I&#39;m<br>seeing the following lockdep warning on boot.<br><br=
>By bisecting the commits, the first commit that introduce this warning<br>=
is this patch. The warning also doesn&#39;t appear if<br><a href=3D"https:/=
/lore.kernel.org/patchwork/patch/1086582/">https://lore.kernel.org/patchwor=
k/patch/1086582/</a> and<br><a href=3D"https://lore.kernel.org/patchwork/pa=
tch/1086583/">https://lore.kernel.org/patchwork/patch/1086583/</a> are not =
applied.<br><br>Do anyone have idea on why this is happening, or any sugges=
tion on<br>which part I should be digging into to figure this out? Thanks.<=
div><br>[ =C2=A0 =C2=A04.664194] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>[ =C2=A0 =C2=A04.670368] W=
ARNING: possible circular locking dependency detected<br>[ =C2=A0 =C2=A04.6=
76545] 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20 Tainted: G S<br>[ =
=C2=A0 =C2=A04.684539] ----------------------------------------------------=
--<br>[ =C2=A0 =C2=A04.690714] kworker/4:1/51 is trying to acquire lock:<br=
>[ =C2=A0 =C2=A04.695760] (____ptrval____) (regulator_list_mutex){+.+.}, at=
:regulator_lock_dependent+0xdc/0x6c4<br>[ =C2=A0 =C2=A04.704732]<br>[ =C2=
=A0 =C2=A04.704732] but task is already holding lock:<br>[ =C2=A0 =C2=A04.7=
10556] (____ptrval____) (&amp;genpd-&gt;mlock/1){+.+.}, at:genpd_lock_neste=
d_mtx+0x24/0x30<br>[ =C2=A0 =C2=A04.718740]<br>[ =C2=A0 =C2=A04.718740] whi=
ch lock already depends on the new lock.<br>[ =C2=A0 =C2=A04.718740]<br>[ =
=C2=A0 =C2=A04.726908]<br>[ =C2=A0 =C2=A04.726908] the existing dependency =
chain (in reverse order) is:<br>[ =C2=A0 =C2=A04.734382]<br>[ =C2=A0 =C2=A0=
4.734382] -&gt; #4 (&amp;genpd-&gt;mlock/1){+.+.}:<br>[ =C2=A0 =C2=A04.7399=
63] =C2=A0 =C2=A0 =C2=A0 =C2=A0__mutex_lock_common+0x1a0/0x1fe8<br>[ =C2=A0=
 =C2=A04.744836] =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock_nested+0x40/0x50<br>=
[ =C2=A0 =C2=A04.749275] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_lock_nested_mtx+0=
x24/0x30<br>[ =C2=A0 =C2=A04.754063] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_add_s=
ubdomain+0x150/0x524<br>[ =C2=A0 =C2=A04.758850] =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pm_genpd_add_subdomain+0x3c/0x5c<br>[ =C2=A0 =C2=A04.763723] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0scpsys_probe+0x520/0xe78<br>[ =C2=A0 =C2=A04.767902] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0platform_drv_probe+0xf4/0x134<br>[ =C2=A0 =C2=A04.7=
72517] =C2=A0 =C2=A0 =C2=A0 =C2=A0really_probe+0x214/0x4dc<br>[ =C2=A0 =C2=
=A04.776696] =C2=A0 =C2=A0 =C2=A0 =C2=A0driver_probe_device+0xcc/0x1d4<br>[=
 =C2=A0 =C2=A04.781396] =C2=A0 =C2=A0 =C2=A0 =C2=A0__device_attach_driver+0=
x10c/0x180<br>[ =C2=A0 =C2=A04.786442] =C2=A0 =C2=A0 =C2=A0 =C2=A0bus_for_e=
ach_drv+0x124/0x184<br>[ =C2=A0 =C2=A04.790968] =C2=A0 =C2=A0 =C2=A0 =C2=A0=
__device_attach+0x1c0/0x2d8<br>[ =C2=A0 =C2=A04.795407] =C2=A0 =C2=A0 =C2=
=A0 =C2=A0device_initial_probe+0x20/0x2c<br>[ =C2=A0 =C2=A04.800106] =C2=A0=
 =C2=A0 =C2=A0 =C2=A0bus_probe_device+0x80/0x16c<br>[ =C2=A0 =C2=A04.804546=
] =C2=A0 =C2=A0 =C2=A0 =C2=A0deferred_probe_work_func+0x120/0x168<br>[ =C2=
=A0 =C2=A04.809767] =C2=A0 =C2=A0 =C2=A0 =C2=A0process_one_work+0x858/0x120=
8<br>[ =C2=A0 =C2=A04.814379] =C2=A0 =C2=A0 =C2=A0 =C2=A0worker_thread+0x9e=
c/0xcb8<br>[ =C2=A0 =C2=A04.818644] =C2=A0 =C2=A0 =C2=A0 =C2=A0kthread+0x2b=
8/0x2d0<br>[ =C2=A0 =C2=A04.822391] =C2=A0 =C2=A0 =C2=A0 =C2=A0ret_from_for=
k+0x10/0x18<br>[ =C2=A0 =C2=A04.826480]<br>[ =C2=A0 =C2=A04.826480] -&gt; #=
3 (&amp;genpd-&gt;mlock){+.+.}:<br>[ =C2=A0 =C2=A04.831880] =C2=A0 =C2=A0 =
=C2=A0 =C2=A0__mutex_lock_common+0x1a0/0x1fe8<br>[ =C2=A0 =C2=A04.836752] =
=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock_nested+0x40/0x50<br>[ =C2=A0 =C2=A04.=
841190] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_lock_mtx+0x20/0x2c<br>[ =C2=A0 =C2=
=A04.845369] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_runtime_resume+0x140/0x434<br=
>[ =C2=A0 =C2=A04.850241] =C2=A0 =C2=A0 =C2=A0 =C2=A0__rpm_callback+0xb0/0x=
1e4<br>[ =C2=A0 =C2=A04.854506] =C2=A0 =C2=A0 =C2=A0 =C2=A0rpm_callback+0x5=
4/0x1a8<br>[ =C2=A0 =C2=A04.858597] =C2=A0 =C2=A0 =C2=A0 =C2=A0rpm_resume+0=
xc6c/0x10c4<br>[ =C2=A0 =C2=A04.862689] =C2=A0 =C2=A0 =C2=A0 =C2=A0__pm_run=
time_resume+0xb4/0x124<br>[ =C2=A0 =C2=A04.867387] =C2=A0 =C2=A0 =C2=A0 =C2=
=A0device_link_add+0x598/0x8d0<br>[ =C2=A0 =C2=A04.871829] =C2=A0 =C2=A0 =
=C2=A0 =C2=A0mtk_smi_larb_probe+0x2b0/0x340<br>[ =C2=A0 =C2=A04.876528] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0platform_drv_probe+0xf4/0x134<br>[ =C2=A0 =C2=A04.8=
81141] =C2=A0 =C2=A0 =C2=A0 =C2=A0really_probe+0x214/0x4dc<br>[ =C2=A0 =C2=
=A04.885320] =C2=A0 =C2=A0 =C2=A0 =C2=A0driver_probe_device+0xcc/0x1d4<br>[=
 =C2=A0 =C2=A04.890020] =C2=A0 =C2=A0 =C2=A0 =C2=A0__device_attach_driver+0=
x10c/0x180<br>[ =C2=A0 =C2=A04.895066] =C2=A0 =C2=A0 =C2=A0 =C2=A0bus_for_e=
ach_drv+0x124/0x184<br>[ =C2=A0 =C2=A04.899591] =C2=A0 =C2=A0 =C2=A0 =C2=A0=
__device_attach+0x1c0/0x2d8<br>[ =C2=A0 =C2=A04.904031] =C2=A0 =C2=A0 =C2=
=A0 =C2=A0device_initial_probe+0x20/0x2c<br>[ =C2=A0 =C2=A04.908730] =C2=A0=
 =C2=A0 =C2=A0 =C2=A0bus_probe_device+0x80/0x16c<br>[ =C2=A0 =C2=A04.913169=
] =C2=A0 =C2=A0 =C2=A0 =C2=A0deferred_probe_work_func+0x120/0x168<br>[ =C2=
=A0 =C2=A04.918387] =C2=A0 =C2=A0 =C2=A0 =C2=A0process_one_work+0x858/0x120=
8<br>[ =C2=A0 =C2=A04.923000] =C2=A0 =C2=A0 =C2=A0 =C2=A0worker_thread+0x9e=
c/0xcb8<br>[ =C2=A0 =C2=A04.927264] =C2=A0 =C2=A0 =C2=A0 =C2=A0kthread+0x2b=
8/0x2d0<br>[ =C2=A0 =C2=A04.931009] =C2=A0 =C2=A0 =C2=A0 =C2=A0ret_from_for=
k+0x10/0x18<br>[ =C2=A0 =C2=A04.935098]<br>[ =C2=A0 =C2=A04.935098] -&gt; #=
2 (dpm_list_mtx){+.+.}:<br>[ =C2=A0 =C2=A04.940412] =C2=A0 =C2=A0 =C2=A0 =
=C2=A0__mutex_lock_common+0x1a0/0x1fe8<br>[ =C2=A0 =C2=A04.945284] =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mutex_lock_nested+0x40/0x50<br>[ =C2=A0 =C2=A04.949722]=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_pm_lock+0x1c/0x24<br>[ =C2=A0 =C2=A04.95=
3900] =C2=A0 =C2=A0 =C2=A0 =C2=A0device_link_add+0x98/0x8d0<br>[ =C2=A0 =C2=
=A04.958252] =C2=A0 =C2=A0 =C2=A0 =C2=A0_regulator_get+0x3f0/0x504<br>[ =C2=
=A0 =C2=A04.962606] =C2=A0 =C2=A0 =C2=A0 =C2=A0_devm_regulator_get+0x58/0xb=
8<br>[ =C2=A0 =C2=A04.967218] =C2=A0 =C2=A0 =C2=A0 =C2=A0devm_regulator_get=
+0x28/0x34<br>[ =C2=A0 =C2=A04.971746] =C2=A0 =C2=A0 =C2=A0 =C2=A0pwm_backl=
ight_probe+0x61c/0x1b90<br>[ =C2=A0 =C2=A04.976617] =C2=A0 =C2=A0 =C2=A0 =
=C2=A0platform_drv_probe+0xf4/0x134<br>[ =C2=A0 =C2=A04.981230] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0really_probe+0x214/0x4dc<br>[ =C2=A0 =C2=A04.985409] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0driver_probe_device+0xcc/0x1d4<br>[ =C2=A0 =C2=A04.=
990108] =C2=A0 =C2=A0 =C2=A0 =C2=A0device_driver_attach+0xe4/0x104<br>[ =C2=
=A0 =C2=A04.994894] =C2=A0 =C2=A0 =C2=A0 =C2=A0__driver_attach+0x134/0x14c<=
br>[ =C2=A0 =C2=A04.999333] =C2=A0 =C2=A0 =C2=A0 =C2=A0bus_for_each_dev+0x1=
20/0x180<br>[ =C2=A0 =C2=A05.003859] =C2=A0 =C2=A0 =C2=A0 =C2=A0driver_atta=
ch+0x48/0x54<br>[ =C2=A0 =C2=A05.007950] =C2=A0 =C2=A0 =C2=A0 =C2=A0bus_add=
_driver+0x2ac/0x44c<br>[ =C2=A0 =C2=A05.012303] =C2=A0 =C2=A0 =C2=A0 =C2=A0=
driver_register+0x160/0x288<br>[ =C2=A0 =C2=A05.016742] =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__platform_driver_register+0xcc/0xdc<br>[ =C2=A0 =C2=A05.021964] =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm_backlight_driver_init+0x1c/0x24<br>[ =C2=A0 =
=C2=A05.027097] =C2=A0 =C2=A0 =C2=A0 =C2=A0do_one_initcall+0x38c/0x994<br>[=
 =C2=A0 =C2=A05.031536] =C2=A0 =C2=A0 =C2=A0 =C2=A0do_initcall_level+0x3a4/=
0x4b8<br>[ =C2=A0 =C2=A05.036148] =C2=A0 =C2=A0 =C2=A0 =C2=A0do_basic_setup=
+0x84/0xa0<br>[ =C2=A0 =C2=A05.036153] =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_in=
it_freeable+0x23c/0x324<br>[ =C2=A0 =C2=A05.036158] =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kernel_init+0x14/0x110<br>[ =C2=A0 =C2=A05.036164] =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret_from_fork+0x10/0x18<br>[ =C2=A0 =C2=A05.036166]<br>[ =C2=A0 =
=C2=A05.036166] -&gt; #1 (device_links_lock){+.+.}:<br>[ =C2=A0 =C2=A05.065=
905] =C2=A0 =C2=A0 =C2=A0 =C2=A0__mutex_lock_common+0x1a0/0x1fe8<br>[ =C2=
=A0 =C2=A05.070777] =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock_nested+0x40/0x50<=
br>[ =C2=A0 =C2=A05.075215] =C2=A0 =C2=A0 =C2=A0 =C2=A0device_link_remove+0=
x40/0xe0<br>[ =C2=A0 =C2=A05.079740] =C2=A0 =C2=A0 =C2=A0 =C2=A0_regulator_=
put+0x104/0x2d8<br>[ =C2=A0 =C2=A05.084093] =C2=A0 =C2=A0 =C2=A0 =C2=A0regu=
lator_put+0x30/0x44<br>[ =C2=A0 =C2=A05.088184] =C2=A0 =C2=A0 =C2=A0 =C2=A0=
devm_regulator_release+0x38/0x44<br>[ =C2=A0 =C2=A05.093056] =C2=A0 =C2=A0 =
=C2=A0 =C2=A0release_nodes+0x604/0x670<br>[ =C2=A0 =C2=A05.097320] =C2=A0 =
=C2=A0 =C2=A0 =C2=A0devres_release_all+0x70/0x8c<br>[ =C2=A0 =C2=A05.101846=
] =C2=A0 =C2=A0 =C2=A0 =C2=A0really_probe+0x270/0x4dc<br>[ =C2=A0 =C2=A05.1=
06024] =C2=A0 =C2=A0 =C2=A0 =C2=A0driver_probe_device+0xcc/0x1d4<br>[ =C2=
=A0 =C2=A05.110724] =C2=A0 =C2=A0 =C2=A0 =C2=A0device_driver_attach+0xe4/0x=
104<br>[ =C2=A0 =C2=A05.115510] =C2=A0 =C2=A0 =C2=A0 =C2=A0__driver_attach+=
0x134/0x14c<br>[ =C2=A0 =C2=A05.119949] =C2=A0 =C2=A0 =C2=A0 =C2=A0bus_for_=
each_dev+0x120/0x180<br>[ =C2=A0 =C2=A05.124474] =C2=A0 =C2=A0 =C2=A0 =C2=
=A0driver_attach+0x48/0x54<br>[ =C2=A0 =C2=A05.128566] =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bus_add_driver+0x2ac/0x44c<br>[ =C2=A0 =C2=A05.132919] =C2=A0 =C2=A0=
 =C2=A0 =C2=A0driver_register+0x160/0x288<br>[ =C2=A0 =C2=A05.137357] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__platform_driver_register+0xcc/0xdc<br>[ =C2=A0 =
=C2=A05.142576] =C2=A0 =C2=A0 =C2=A0 =C2=A0pwm_backlight_driver_init+0x1c/0=
x24<br>[ =C2=A0 =C2=A05.147708] =C2=A0 =C2=A0 =C2=A0 =C2=A0do_one_initcall+=
0x38c/0x994<br>[ =C2=A0 =C2=A05.152146] =C2=A0 =C2=A0 =C2=A0 =C2=A0do_initc=
all_level+0x3a4/0x4b8<br>[ =C2=A0 =C2=A05.156758] =C2=A0 =C2=A0 =C2=A0 =C2=
=A0do_basic_setup+0x84/0xa0<br>[ =C2=A0 =C2=A05.160936] =C2=A0 =C2=A0 =C2=
=A0 =C2=A0kernel_init_freeable+0x23c/0x324<br>[ =C2=A0 =C2=A05.165807] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0kernel_init+0x14/0x110<br>[ =C2=A0 =C2=A05.169813] =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ret_from_fork+0x10/0x18<br>[ =C2=A0 =C2=A05.1739=
01]<br>[ =C2=A0 =C2=A05.173901] -&gt; #0 (regulator_list_mutex){+.+.}:<br>[=
 =C2=A0 =C2=A05.179910] =C2=A0 =C2=A0 =C2=A0 =C2=A0lock_acquire+0x350/0x4d4=
<br>[ =C2=A0 =C2=A05.184088] =C2=A0 =C2=A0 =C2=A0 =C2=A0__mutex_lock_common=
+0x1a0/0x1fe8<br>[ =C2=A0 =C2=A05.184095] =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_=
lock_nested+0x40/0x50<br>[ =C2=A0 =C2=A05.197475] =C2=A0 =C2=A0 =C2=A0 =C2=
=A0regulator_lock_dependent+0xdc/0x6c4<br>[ =C2=A0 =C2=A05.197482] =C2=A0 =
=C2=A0 =C2=A0 =C2=A0regulator_disable+0xa0/0x138<br>[ =C2=A0 =C2=A05.197487=
] =C2=A0 =C2=A0 =C2=A0 =C2=A0scpsys_power_off+0x38c/0x4bc<br>[ =C2=A0 =C2=
=A05.197495] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_power_off+0x3d8/0x6a0<br>[ =
=C2=A0 =C2=A05.209399] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_power_off+0x530/0x6=
a0<br>[ =C2=A0 =C2=A05.209406] =C2=A0 =C2=A0 =C2=A0 =C2=A0genpd_power_off_w=
ork_fn+0x74/0xc0<br>[ =C2=A0 =C2=A05.209411] =C2=A0 =C2=A0 =C2=A0 =C2=A0pro=
cess_one_work+0x858/0x1208<br>[ =C2=A0 =C2=A05.209419] =C2=A0 =C2=A0 =C2=A0=
 =C2=A0worker_thread+0x9ec/0xcb8<br>[ =C2=A0 =C2=A05.219067] =C2=A0 =C2=A0 =
=C2=A0 =C2=A0kthread+0x2b8/0x2d0<br>[ =C2=A0 =C2=A05.219073] =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret_from_fork+0x10/0x18<br>[ =C2=A0 =C2=A05.219077]<br>[ =C2=
=A0 =C2=A05.219077] other info that might help us debug this:<br>[ =C2=A0 =
=C2=A05.219077]<br>[ =C2=A0 =C2=A05.219080] Chain exists of:<br>[ =C2=A0 =
=C2=A05.219080] =C2=A0 regulator_list_mutex --&gt; &amp;genpd-&gt;mlock --&=
gt; &amp;genpd-&gt;mlock/1<br>[ =C2=A0 =C2=A05.219080]<br>[ =C2=A0 =C2=A05.=
228039] =C2=A0Possible unsafe locking scenario:<br>[ =C2=A0 =C2=A05.228039]=
<br>[ =C2=A0 =C2=A05.228042] =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU1<br>[ =C2=A0 =C2=
=A05.228046] =C2=A0 =C2=A0 =C2=A0 =C2=A0---- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----<br>[ =C2=A0 =C2=A05.228048] =
=C2=A0 lock(&amp;genpd-&gt;mlock/1);<br>[ =C2=A0 =C2=A05.228058] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0lock(&amp;genpd-&gt;mlock);<br>[ =C2=A0 =C2=A05.=
311647] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lock(&amp;genpd-&gt;mlock/1);<=
br>[ =C2=A0 =C2=A05.317736] =C2=A0 lock(regulator_list_mutex);<br>[ =C2=A0 =
=C2=A05.321742]<br>[ =C2=A0 =C2=A05.321742] =C2=A0*** DEADLOCK ***<br>[ =C2=
=A0 =C2=A05.321742]<br>[ =C2=A0 =C2=A05.327655] 4 locks held by kworker/4:1=
/51:<br>[ =C2=A0 =C2=A05.331831] =C2=A0#0: (____ptrval____) ((wq_completion=
)pm){+.+.}, at:process_one_work+0x57c/0x1208<br>[ =C2=A0 =C2=A05.340444] =
=C2=A0#1: (____ptrval____) ((work_completion)(&amp;genpd-&gt;power_off_work=
)){+.+.}, at:process_one_work+0x5b8/0x1208<br>[ =C2=A0 =C2=A05.351139] =C2=
=A0#2: (____ptrval____) (&amp;genpd-&gt;mlock){+.+.}, at:genpd_lock_mtx+0x2=
0/0x2c<br>[ =C2=A0 =C2=A05.358970] =C2=A0#3: (____ptrval____) (&amp;genpd-&=
gt;mlock/1){+.+.}, at:genpd_lock_nested_mtx+0x24/0x30<br>[ =C2=A0 =C2=A05.3=
67584]<br>[ =C2=A0 =C2=A05.367584] stack backtrace:<br>[ =C2=A0 =C2=A05.371=
939] CPU: 4 PID: 51 Comm: kworker/4:1 Tainted: G S=C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.2.0-rc2-next-20190528-44527-g6c94b6=
475c04 #20<br>[ =C2=A0 =C2=A05.382809] Workqueue: pm genpd_power_off_work_f=
n<br>[ =C2=A0 =C2=A05.382816] Call trace:<br>[ =C2=A0 =C2=A05.382822] =C2=
=A0dump_backtrace+0x0/0x2c0<br>[ =C2=A0 =C2=A05.382830] =C2=A0show_stack+0x=
20/0x2c<br>[ =C2=A0 =C2=A05.409174] =C2=A0dump_stack+0x10c/0x17c<br>[ =C2=
=A0 =C2=A05.412659] =C2=A0print_circular_bug+0x42c/0x4d0<br>[ =C2=A0 =C2=A0=
5.416838] =C2=A0__lock_acquire+0x4c88/0x5484<br>[ =C2=A0 =C2=A05.420843] =
=C2=A0lock_acquire+0x350/0x4d4<br>[ =C2=A0 =C2=A05.424500] =C2=A0__mutex_lo=
ck_common+0x1a0/0x1fe8<br>[ =C2=A0 =C2=A05.428851] =C2=A0mutex_lock_nested+=
0x40/0x50<br>[ =C2=A0 =C2=A05.432770] =C2=A0regulator_lock_dependent+0xdc/0=
x6c4<br>[ =C2=A0 =C2=A05.437383] =C2=A0regulator_disable+0xa0/0x138<br>[ =
=C2=A0 =C2=A05.441389] =C2=A0scpsys_power_off+0x38c/0x4bc<br>[ =C2=A0 =C2=
=A05.445393] =C2=A0genpd_power_off+0x3d8/0x6a0<br>[ =C2=A0 =C2=A05.449310] =
=C2=A0genpd_power_off+0x530/0x6a0<br>[ =C2=A0 =C2=A05.453229] =C2=A0genpd_p=
ower_off_work_fn+0x74/0xc0<br>[ =C2=A0 =C2=A05.457667] =C2=A0process_one_wo=
rk+0x858/0x1208<br>[ =C2=A0 =C2=A05.461758] =C2=A0worker_thread+0x9ec/0xcb8=
<br>[ =C2=A0 =C2=A05.465503] =C2=A0kthread+0x2b8/0x2d0<br>[ =C2=A0 =C2=A05.=
468727] =C2=A0ret_from_fork+0x10/0x18<br><br>On Mon, Jun 10, 2019 at 8:21 P=
M Yong Wu &lt;<a href=3D"mailto:yong.wu@mediatek.com">yong.wu@mediatek.com<=
/a>&gt; wrote:<br>&gt; ...</div></div><br><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 10, 2019 at 8:21 PM Yong Wu=
 &lt;<a href=3D"mailto:yong.wu@mediatek.com">yong.wu@mediatek.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">There are =
2 mmu cells in a M4U HW. we could adjust some larbs entering<br>
mmu0 or mmu1 to balance the bandwidth via the smi-common register<br>
SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).<br>
<br>
In mt8183, For better performance, we switch larb1/2/5/7 to enter<br>
mmu1 while the others still keep enter mmu0.<br>
<br>
In mt8173 and mt2712, we don&#39;t get the performance issue,<br>
Keep its default value(0x0), that means all the larbs enter mmu0.<br>
<br>
Note: smi gen1(mt2701/mt7623) don&#39;t have this bus_sel.<br>
<br>
And, the base of smi-common is completely different with smi_ao_base<br>
of gen1, thus I add new variable for that.<br>
<br>
CC: Matthias Brugger &lt;<a href=3D"mailto:matthias.bgg@gmail.com" target=
=3D"_blank">matthias.bgg@gmail.com</a>&gt;<br>
Signed-off-by: Yong Wu &lt;<a href=3D"mailto:yong.wu@mediatek.com" target=
=3D"_blank">yong.wu@mediatek.com</a>&gt;<br>
Reviewed-by: Evan Green &lt;<a href=3D"mailto:evgreen@chromium.org" target=
=3D"_blank">evgreen@chromium.org</a>&gt;<br>
---<br>
=C2=A0drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--<br>
=C2=A01 file changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c<br>
index 9790801..08cf40d 100644<br>
--- a/drivers/memory/mtk-smi.c<br>
+++ b/drivers/memory/mtk-smi.c<br>
@@ -49,6 +49,12 @@<br>
=C2=A0#define SMI_LARB_NONSEC_CON(id)=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x380 + (=
(id) * 4))<br>
=C2=A0#define F_MMU_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(0)<br>
<br>
+/* SMI COMMON */<br>
+#define SMI_BUS_SEL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x220<br>
+#define SMI_BUS_LARB_SHIFT(larbid)=C2=A0 =C2=A0 =C2=A0((larbid) &lt;&lt; 1=
)<br>
+/* All are MMU0 defaultly. Only specialize mmu1 here. */<br>
+#define F_MMU1_LARB(larbid)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1 =
&lt;&lt; SMI_BUS_LARB_SHIFT(larbid))<br>
+<br>
=C2=A0enum mtk_smi_gen {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MTK_SMI_GEN1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MTK_SMI_GEN2<br>
@@ -57,6 +63,7 @@ enum mtk_smi_gen {<br>
=C2=A0struct mtk_smi_common_plat {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum mtk_smi_gen gen;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0has_gals;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */<br>
=C2=A0};<br>
<br>
=C2=A0struct mtk_smi_larb_gen {<br>
@@ -72,8 +79,8 @@ struct mtk_smi {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *clk_apb, *clk_smi;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *clk_gals0, *clk_gals1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *clk_async; /*only needed by mt27=
01*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *smi_ao_base;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *smi_ao_base; /* only for gen1 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *base;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* onl=
y for gen2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct mtk_smi_common_plat *plat;<br>
=C2=A0};<br>
<br>
@@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct d=
evice *dev)<br>
=C2=A0static const struct mtk_smi_common_plat mtk_smi_common_mt8183 =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .gen=C2=A0 =C2=A0 =C2=A0 =3D MTK_SMI_GEN2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .has_gals =3D true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.bus_sel=C2=A0 =3D F_MMU1_LARB(1) | F_MMU1_LARB=
(2) | F_MMU1_LARB(5) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0F_MMU=
1_LARB(7),<br>
=C2=A0};<br>
<br>
=C2=A0static const struct of_device_id mtk_smi_common_of_ids[] =3D {<br>
@@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device=
 *pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D clk_prepare=
_enable(common-&gt;clk_async);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_ge=
t_resource(pdev, IORESOURCE_MEM, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0common-&gt;base =3D=
 devm_ioremap_resource(dev, res);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(common-&=
gt;base))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return PTR_ERR(common-&gt;base);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_enable(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, common);<br>
@@ -497,6 +511,7 @@ static int mtk_smi_common_remove(struct platform_device=
 *pdev)<br>
=C2=A0static int __maybe_unused mtk_smi_common_resume(struct device *dev)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mtk_smi *common =3D dev_get_drvdata(dev)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 bus_sel =3D common-&gt;plat-&gt;bus_sel;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mtk_smi_clk_enable(common);<br>
@@ -504,6 +519,9 @@ static int __maybe_unused mtk_smi_common_resume(struct =
device *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(common-&gt;=
dev, &quot;Failed to enable clock(%d).\n&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (common-&gt;plat-&gt;gen =3D=3D MTK_SMI_GEN2=
 &amp;&amp; bus_sel)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(bus_sel, com=
mon-&gt;base + SMI_BUS_SEL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-- <br>
1.9.1<br>
<br>
</blockquote></div>

--000000000000018fdc058b3021f6--

--===============8867390028290118547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8867390028290118547==--
