Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED90C433E3
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 17:03:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6830A208B3
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 17:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6830A208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0C99920426;
	Thu, 20 Aug 2020 17:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16tc66qJ4Am2; Thu, 20 Aug 2020 17:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7D1362047F;
	Thu, 20 Aug 2020 17:03:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52D60C07FF;
	Thu, 20 Aug 2020 17:03:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AA74C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 17:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6240B85036
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 17:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mYy8EPzaTV7n for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 17:03:36 +0000 (UTC)
X-Greylist: delayed 00:08:43 by SQLgrey-1.7.6
Received: from hillosipuli.retiisi.org.uk (retiisi.org.uk [95.216.213.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CFE684FFF
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 17:03:36 +0000 (UTC)
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2a01:4f9:c010:4572::80:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id E79D7634C87;
 Thu, 20 Aug 2020 19:53:39 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1k8nop-0002qv-OM; Thu, 20 Aug 2020 19:53:39 +0300
Date: Thu, 20 Aug 2020 19:53:39 +0300
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 17/18] media/omap3isp: Clean up IOMMU workaround
Message-ID: <20200820165339.GK7145@valkosipuli.retiisi.org.uk>
References: <cover.1597931875.git.robin.murphy@arm.com>
 <11d8419744e4e744a9448180801b0c4683328afd.1597931876.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11d8419744e4e744a9448180801b0c4683328afd.1597931876.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, digetx@gmail.com, will@kernel.org,
 hch@lst.de, linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 linux@armlinux.org.uk, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, t-kristo@ti.com, kyungmin.park@samsung.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On Thu, Aug 20, 2020 at 04:08:36PM +0100, Robin Murphy wrote:
> Now that arch/arm is wired up for default domains and iommu-dma, devices
> behind IOMMUs will get mappings set up automatically as appropriate, so
> there is no need for drivers to do so manually.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for the patch.

I haven't looked at the details but it seems that this causes the buffer
memory allocation to be physically contiguous, which causes a failure to
allocate video buffers of entirely normal size. I guess that was not
intentional?

-----------------8<---------------------------
[  218.934448] WARNING: CPU: 0 PID: 1994 at mm/page_alloc.c:4859 __alloc_pages_nodemask+0x9c/0xb1c
[  218.943847] Modules linked in: omap3_isp videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common leds_as3645a smiapp v4l2_flash_led_class led_class_flash v4l2_fwnode smiapp_pll videodev leds_gpio mc led_class
[  218.964660] CPU: 0 PID: 1994 Comm: yavta Not tainted 5.9.0-rc1-dirty #1818
[  218.972442] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[  218.978973] Backtrace: 
[  218.981842] [<c010bf90>] (dump_backtrace) from [<c010c350>] (show_stack+0x20/0x24)
[  218.989715]  r7:00000000 r6:00000009 r5:c08f03bc r4:c08f2fef
[  218.995880] [<c010c330>] (show_stack) from [<c03d3328>] (dump_stack+0x28/0x30)
[  219.003631] [<c03d3300>] (dump_stack) from [<c012e324>] (__warn+0x100/0x118)
[  219.010955]  r5:c08f03bc r4:00000000
[  219.014953] [<c012e224>] (__warn) from [<c012e6f4>] (warn_slowpath_fmt+0x84/0xa8)
[  219.022949]  r9:c0232090 r8:c08f03bc r7:c0b08a88 r6:00000009 r5:000012fb r4:00000000
[  219.031036] [<c012e674>] (warn_slowpath_fmt) from [<c0232090>] (__alloc_pages_nodemask+0x9c/0xb1c)
[  219.040557]  r9:c0185c3c r8:00000000 r7:010ec000 r6:00000000 r5:0000000d r4:00000000
[  219.048858] [<c0231ff4>] (__alloc_pages_nodemask) from [<c01108f0>] (__dma_alloc_buffer.constprop.14+0x3c/0x90)
[  219.059570]  r10:00000cc0 r9:c0185c3c r8:00000000 r7:010ec000 r6:0000000d r5:c0b08a88
[  219.067901]  r4:00000cc0
[  219.070587] [<c01108b4>] (__dma_alloc_buffer.constprop.14) from [<c0110a6c>] (remap_allocator_alloc+0x34/0x7c)
[  219.081207]  r9:c0185c3c r8:00000247 r7:e6d7fb84 r6:010ec000 r5:c0b08a88 r4:00000001
[  219.089263] [<c0110a38>] (remap_allocator_alloc) from [<c010f4f4>] (__dma_alloc+0x124/0x21c)
[  219.098236]  r9:ed99fc10 r8:e69aa890 r7:00000000 r6:ffffffff r5:c0b08a88 r4:e6fdd680
[  219.106536] [<c010f3d0>] (__dma_alloc) from [<c010f69c>] (arm_dma_alloc+0x68/0x74)
[  219.114654]  r10:00000cc0 r9:c0185c3c r8:00000cc0 r7:e69aa890 r6:010ec000 r5:ed99fc10
[  219.122985]  r4:00000000
[  219.125671] [<c010f634>] (arm_dma_alloc) from [<c0185c3c>] (dma_alloc_attrs+0xe4/0x120)
[  219.134216]  r9:00000000 r8:e69aa890 r7:010ec000 r6:c0b08a88 r5:ed99fc10 r4:c010f634
[  219.142517] [<c0185b58>] (dma_alloc_attrs) from [<bf095c3c>] (vb2_dc_alloc+0xcc/0x108 [videobuf2_dma_contig])
[  219.153076]  r10:e6885ca8 r9:e6abfc48 r8:00000002 r7:00000000 r6:010ec000 r5:ed99fc10
[  219.161407]  r4:e69aa880
[  219.164184] [<bf095b70>] (vb2_dc_alloc [videobuf2_dma_contig]) from [<bf080fd0>] (__vb2_queue_alloc+0x258/0x4a4 [videobuf2_common])
[  219.176696]  r8:bf095b70 r7:010ec000 r6:00000000 r5:e6885ca8 r4:e6abfc00
[  219.183959] [<bf080d78>] (__vb2_queue_alloc [videobuf2_common]) from [<bf0833a0>] (vb2_core_reqbufs+0x408/0x498 [videobuf2_common])
[  219.196533]  r10:e6885ce8 r9:00000000 r8:e6d7fe24 r7:e6d7fcec r6:bf09ced4 r5:bf088580
[  219.204895]  r4:e6885ca8
[  219.207672] [<bf082f98>] (vb2_core_reqbufs [videobuf2_common]) from [<bf08e1cc>] (vb2_reqbufs+0x64/0x70 [videobuf2_v4l2])
[  219.219268]  r10:00000000 r9:bf032bc0 r8:c0145608 r7:bf0ad4a4 r6:e6885ca8 r5:00000000
[  219.227600]  r4:e6d7fe24
[  219.230499] [<bf08e168>] (vb2_reqbufs [videobuf2_v4l2]) from [<bf09d7b4>] (isp_video_reqbufs+0x40/0x54 [omap3_isp])
[  219.241607]  r7:bf0ad4a4 r6:e6d7fe24 r5:e6885c00 r4:e6cca928
[  219.247924] [<bf09d774>] (isp_video_reqbufs [omap3_isp]) from [<bf01de4c>] (v4l_reqbufs+0x4c/0x50 [videodev])
[  219.258514]  r7:bf0ad4a4 r6:e6885c00 r5:e6d7fe24 r4:e7efbec0
[  219.264984] [<bf01de00>] (v4l_reqbufs [videodev]) from [<bf01eeb4>] (__video_do_ioctl+0x2d8/0x414 [videodev])
[  219.275512]  r7:bf01de00 r6:00000000 r5:00000000 r4:e6cca2e0
[  219.281982] [<bf01ebdc>] (__video_do_ioctl [videodev]) from [<bf01fa1c>] (video_usercopy+0x144/0x508 [videodev])
[  219.292816]  r10:e7efbec0 r9:c0145608 r8:e6d7fe24 r7:00000000 r6:00000000 r5:bf01ebdc
[  219.300933]  r4:c0145608
[  219.304168] [<bf01f8d8>] (video_usercopy [videodev]) from [<bf01fdfc>] (video_ioctl2+0x1c/0x24 [videodev])
[  219.314453]  r10:e7fbfda0 r9:e7efbec0 r8:00000003 r7:00000000 r6:bee658f4 r5:c0145608
[  219.322784]  r4:e7efbec0
[  219.325775] [<bf01fde0>] (video_ioctl2 [videodev]) from [<bf01814c>] (v4l2_ioctl+0x50/0x64 [videodev])
[  219.335845] [<bf0180fc>] (v4l2_ioctl [videodev]) from [<c02654a0>] (vfs_ioctl+0x30/0x44)
[  219.344482]  r7:00000000 r6:e7efbec0 r5:bee658f4 r4:c0145608
[  219.350402] [<c0265470>] (vfs_ioctl) from [<c0265e9c>] (sys_ioctl+0xdc/0x7ec)
[  219.358062] [<c0265dc0>] (sys_ioctl) from [<c0100080>] (ret_fast_syscall+0x0/0x28)
[  219.366149] Exception stack(0xe6d7ffa8 to 0xe6d7fff0)
[  219.371673] ffa0:                   00000000 bee65c1a 00000003 c0145608 bee658f4 00000001
[  219.380157] ffc0: 00000000 bee65c1a 00000000 00000036 000009a0 00000000 0000ef30 010eb400
[  219.388885] ffe0: 0001716c bee65104 0000b588 b6e413ac
[  219.394409]  r10:00000036 r9:e6d7e000 r8:c0100244 r7:00000036 r6:00000000 r5:bee65c1a
[  219.402740]  r4:00000000
[  219.405426] irq event stamp: 5075
[  219.408905] hardirqs last  enabled at (5083): [<c01778b0>] console_unlock+0x4cc/0x524
[  219.417297] hardirqs last disabled at (5092): [<c01777ac>] console_unlock+0x3c8/0x524
[  219.425628] softirqs last  enabled at (4532): [<c01017d8>] __do_softirq+0x1f0/0x490
[  219.433837] softirqs last disabled at (4493): [<c0132c20>] irq_exit+0xe4/0x160
[  219.441558] ---[ end trace 8c56810633cf24db ]---
[  219.446502] omap3isp 480bc000.isp: dma_alloc_coherent of size 17743872 failed
-----------------8<---------------------------

-- 
Kind regards,

Sakari Ailus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
