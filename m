Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7155C433E0
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 13:15:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D521E23128
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 13:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D521E23128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 641558846E;
	Thu,  6 Aug 2020 13:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3gpoXqU66hI; Thu,  6 Aug 2020 13:14:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD4428846B;
	Thu,  6 Aug 2020 13:14:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C9E3C0050;
	Thu,  6 Aug 2020 13:14:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19AB7C004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 10:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 015EB2039D
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 10:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vHtg+EHh6I1 for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 10:46:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
 by silver.osuosl.org (Postfix) with ESMTPS id 04B641FE32
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 10:46:23 +0000 (UTC)
Received: by mail-il1-f197.google.com with SMTP id c84so12146989ila.18
 for <iommu@lists.linux-foundation.org>; Thu, 06 Aug 2020 03:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=Xf+oi/xhH3Z8Onoel7rwP1/y3FbNGfPBV1TIGKlxAAQ=;
 b=VpzxI8GNBZdHUA6g3TEJ0JmpY4yhB1hAy22RAe4cwPnHOACr5294lrUhl7oBmWMtwI
 1Lzsfs0UU4NLsxCylj8Y98DpWVTFmJ+arQq8tb7BuLQpS8pARDQSOCwki01Fg+nToBjn
 1ZOBn7+8exHcfDkjXjKwqu5PdeEIrRkoB/l7OCBjo6RWbQswvq6pVV3lc+YQ7Ew5Wtrh
 K84l6yABd4rH5ggCbiM9Xd4UPI+glpPz+DLiF4aiBwpifyG30yOQ5dCu7ie5NzorquVh
 xuKLLJAeyDYY7/e76VDWbhgKCrIr/nbMZO6Yk+E4g1ElMzUJilVbBLL4nRFtCUfQI8ak
 PWMA==
X-Gm-Message-State: AOAM533vMXJakZrMXwazYtY48rENDk4SB+4P84aFVYL3fg5izy021vzv
 ZKQQ5fOMww9g8x1+0VTilFY/76HABSvCqOSuhS6EnTtF5C8j
X-Google-Smtp-Source: ABdhPJxGOdr/tdOh8dZ1djI7bPUhKLp8L58bkpXtToegryosLVXZrRW+4Gcyac1KwfUFl8Poo8hlKZyvlKN0xwpaXr8jmdvKUys8
MIME-Version: 1.0
X-Received: by 2002:a92:cf10:: with SMTP id c16mr8151131ilo.88.1596710783293; 
 Thu, 06 Aug 2020 03:46:23 -0700 (PDT)
Date: Thu, 06 Aug 2020 03:46:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c1f0005ac333382@google.com>
Subject: upstream boot error: general protection fault in swiotlb_map
From: syzbot <syzbot+3f86afd0b1e4bf1cb64c@syzkaller.appspotmail.com>
To: hch@lst.de, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, 
 linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
 syzkaller-bugs@googlegroups.com
X-Mailman-Approved-At: Thu, 06 Aug 2020 13:14:48 +0000
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

Hello,

syzbot found the following issue on:

HEAD commit:    47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fe1dea900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c06047f622c5724
dashboard link: https://syzkaller.appspot.com/bug?extid=3f86afd0b1e4bf1cb64c
compiler:       gcc (GCC) 10.1.0-syz 20200507

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f86afd0b1e4bf1cb64c@syzkaller.appspotmail.com

ceph: loaded (mds proto 32)
NET: Registered protocol family 38
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Asymmetric key parser 'tpm_parser' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
hgafb: HGA card not detected.
hgafb: probe of hgafb.0 failed with error -22
usbcore: registered new interface driver udlfb
uvesafb: failed to execute /sbin/v86d
uvesafb: make sure that the v86d helper is installed and executable
uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)
uvesafb: vbe_init() failed with -22
uvesafb: probe of uvesafb.0 failed with error -22
vga16fb: mapped to 0x000000008aac772d
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
PCI Interrupt Link [GSIF] enabled at IRQ 21
PCI Interrupt Link [GSIG] enabled at IRQ 22
PCI Interrupt Link [GSIH] enabled at IRQ 23
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Cyclades driver 2.6
Initializing Nozomi driver 2.1d
RocketPort device driver module, version 2.09, 12-June-2003
No rocketport ports found; unloading driver
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
usbcore: registered new interface driver udl
[drm] pci: virtio-vga detected at 0000:00:01.0
fb0: switching to virtiodrmfb from VGA16 VGA
Console: switching to colour VGA+ 80x25
virtio-pci 0000:00:01.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
[drm] features: -virgl +edid
[drm] number of scanouts: 1
[drm] number of cap sets: 0
[drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on minor 2
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:swiotlb_map+0x5ac/0x700 kernel/dma/swiotlb.c:683
Code: 28 04 00 00 48 c1 ea 03 80 3c 02 00 0f 85 4d 01 00 00 4c 8b a5 18 04 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 01 00 00 48 8d 7d 50 4d 8b 24 24 48 b8 00 00
RSP: 0000:ffffc9000034f3e0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8162cc1d
RDX: 0000000000000000 RSI: ffffffff8162cc98 RDI: ffff88802971a470
RBP: ffff88802971a048 R08: 0000000000000001 R09: ffffffff8c5dba77
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000007ac00000 R14: dffffc0000000000 R15: 0000000000001000
FS:  0000000000000000(0000) GS:ffff88802ce00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000ffffffff CR3: 0000000009a8d000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dma_direct_map_page include/linux/dma-direct.h:170 [inline]
 dma_direct_map_sg+0x3bb/0x670 kernel/dma/direct.c:368
 dma_map_sg_attrs+0xd0/0x160 kernel/dma/mapping.c:183
 drm_gem_shmem_get_pages_sgt drivers/gpu/drm/drm_gem_shmem_helper.c:700 [inline]
 drm_gem_shmem_get_pages_sgt+0x1fc/0x310 drivers/gpu/drm/drm_gem_shmem_helper.c:679
 virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:153 [inline]
 virtio_gpu_object_create+0x2fd/0xa70 drivers/gpu/drm/virtio/virtgpu_object.c:232
 virtio_gpu_gem_create drivers/gpu/drm/virtio/virtgpu_gem.c:45 [inline]
 virtio_gpu_mode_dumb_create+0x298/0x530 drivers/gpu/drm/virtio/virtgpu_gem.c:85
 drm_mode_create_dumb+0x27c/0x300 drivers/gpu/drm/drm_dumb_buffers.c:94
 drm_client_buffer_create drivers/gpu/drm/drm_client.c:267 [inline]
 drm_client_framebuffer_create+0x1b7/0x770 drivers/gpu/drm/drm_client.c:412
 drm_fb_helper_generic_probe+0x1e5/0x810 drivers/gpu/drm/drm_fb_helper.c:2086
 drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1635 [inline]
 __drm_fb_helper_initial_config_and_unlock+0xbc6/0x12d0 drivers/gpu/drm/drm_fb_helper.c:1793
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1888 [inline]
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1880 [inline]
 drm_fbdev_client_hotplug+0x2d4/0x580 drivers/gpu/drm/drm_fb_helper.c:2180
 drm_fbdev_generic_setup+0x1c8/0x450 drivers/gpu/drm/drm_fb_helper.c:2262
 virtio_gpu_probe+0x28f/0x2e0 drivers/gpu/drm/virtio/virtgpu_drv.c:127
 virtio_dev_probe+0x445/0x6f0 drivers/virtio/virtio.c:248
 really_probe+0x282/0x9f0 drivers/base/dd.c:553
 driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:738
 device_driver_attach+0x228/0x290 drivers/base/dd.c:1013
 __driver_attach drivers/base/dd.c:1090 [inline]
 __driver_attach+0xda/0x240 drivers/base/dd.c:1044
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
 bus_add_driver+0x348/0x5a0 drivers/base/bus.c:622
 driver_register+0x220/0x3a0 drivers/base/driver.c:171
 do_one_initcall+0x10a/0x7b0 init/main.c:1201
 do_initcall_level init/main.c:1274 [inline]
 do_initcalls init/main.c:1290 [inline]
 do_basic_setup init/main.c:1310 [inline]
 kernel_init_freeable+0x589/0x638 init/main.c:1505
 kernel_init+0xd/0x1c0 init/main.c:1399
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 11a290451cfd19ed ]---
RIP: 0010:swiotlb_map+0x5ac/0x700 kernel/dma/swiotlb.c:683
Code: 28 04 00 00 48 c1 ea 03 80 3c 02 00 0f 85 4d 01 00 00 4c 8b a5 18 04 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 01 00 00 48 8d 7d 50 4d 8b 24 24 48 b8 00 00
RSP: 0000:ffffc9000034f3e0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8162cc1d
RDX: 0000000000000000 RSI: ffffffff8162cc98 RDI: ffff88802971a470
RBP: ffff88802971a048 R08: 0000000000000001 R09: ffffffff8c5dba77
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000007ac00000 R14: dffffc0000000000 R15: 0000000000001000
FS:  0000000000000000(0000) GS:ffff88802ce00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000ffffffff CR3: 0000000009a8d000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
