Return-Path: <SRS0=kiHz=X6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115BC47404
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 18:16:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D14320830
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjPWWFoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D14320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16901C91;
	Sat,  5 Oct 2019 18:16:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1BD9CC90
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 18:16:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0218C189
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 18:16:14 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id q1so20481369ion.1
	for <iommu@lists.linux-foundation.org>;
	Sat, 05 Oct 2019 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Ll5RHtOFuobwRtlJLsQ89F9ypIXdgrSVlv82LcmF+yo=;
	b=ZjPWWFoTHSpIhIlf8nDTg7stxHSR06DbnLNyx46zBn68DjEh2JwFjJsd+nX6sfWc+S
	XMQ/4e9kIH2xPQNBcVdurI5Qc5jtsReL8vXOGlYntGtXD2lGAsVuBR6UVXWYK6nGQytj
	ejao0fj2WAeb/PhJ0W9pUPYpWfHh9RsvcYhkFJF+Ye8Y/5viV7jtVihJKM/nPLNwYw/U
	o8OxN2NobHu5Uk5wweJ3Ox+BDIi19O4zFWKb9X92IrM8sqeqflui7QevNaqBU2fz1D53
	CdZFu6fdN/VeDb/Oo1G0rAhxGtQQMBWLKmRet/ed4X1awWaLkVyAxA1tk3lxONF9jnL5
	Sodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Ll5RHtOFuobwRtlJLsQ89F9ypIXdgrSVlv82LcmF+yo=;
	b=VqfTEIJo4nBKZxxGzOpcwk+SsO0Bv1aL6eJlCL3AjHsA+wUfWif1hOzTo1g3h3DESU
	tRTVPYUlPNBL4ylWP2kOMqGW6YS16lRRejfkHXI38CkXd+gnl3eHraHLUglXlsr61IJA
	U2HI0jG7JdbVpZiHcbDLyQIOHFhwozNjkyPN0fjCal1t1ghTo1hXr2ofUNs9E5KNjNqJ
	DYWbIy+3WHvIJ0WqwG0FW2r+zLhBh1RRszVFEYrI7kD65xYm1KcAEPfhNVhJCxCODvOm
	EK7JqqyHM5oTY/uWPS17veVedjpRTAfpU/GSfko6JYxQ/INM/1DlFH9rVbpUcc097Hzc
	H1PQ==
X-Gm-Message-State: APjAAAVKMaK/DIHGbhBQSKyTrRMCtO3Mxdz/kebS0vFZpqH0RD92aHkU
	yfZqCIicT/diYxmFJnW8rvtwi5Dg/r9efm0Qa24=
X-Google-Smtp-Source: APXvYqyU9NTuFbNN/k+RHZmqMjLGVCbi6uiijIFuJQfbPFB68JKY4j/PJ+ODbEb73IIK1iccWn5VvTXKgl4NQymngL4=
X-Received: by 2002:a5e:a712:: with SMTP id b18mr5960023iod.263.1570299374096; 
	Sat, 05 Oct 2019 11:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191005053317.7856-1-andrew.smirnov@gmail.com>
	<20191005082534.GA12308@lst.de>
In-Reply-To: <20191005082534.GA12308@lst.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sat, 5 Oct 2019 11:16:01 -0700
Message-ID: <CAHQ1cqH=26yvhEXePf6vE8z1Bga4FOih6SKCkahRaddq9ocjEw@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: fix false positivse warnings in
	dma_common_free_remap()
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vivien Didelot <vivien.didelot@gmail.com>, Chris Healy <cphealy@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sat, Oct 5, 2019 at 1:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Andrey,
>
> thanks for the patch.  I think it would be much easier to just
> use the original open coded check in dma_common_free_remap instead
> of adding a new helper.  What do you think of the version below?
>

Looks good to me. I am fine with either version.

Thanks,
Andrey Smirnov

> ---
> From 2cf2aa6a69db0b17b3979144287af8775c1c1534 Mon Sep 17 00:00:00 2001
> From: Andrey Smirnov <andrew.smirnov@gmail.com>
> Date: Sat, 5 Oct 2019 10:23:30 +0200
> Subject: dma-mapping: fix false positivse warnings in dma_common_free_remap()
>
> Commit 5cf4537975bb ("dma-mapping: introduce a dma_common_find_pages
> helper") changed invalid input check in dma_common_free_remap() from:
>
>     if (!area || !area->flags != VM_DMA_COHERENT)
>
> to
>
>     if (!area || !area->flags != VM_DMA_COHERENT || !area->pages)
>
> which seem to produce false positives for memory obtained via
> dma_common_contiguous_remap()
>
> This triggers the following warning message when doing "reboot" on ZII
> VF610 Dev Board Rev B:
>
> WARNING: CPU: 0 PID: 1 at kernel/dma/remap.c:112 dma_common_free_remap+0x88/0x8c
> trying to free invalid coherent area: 9ef82980
> Modules linked in:
> CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.3.0-rc6-next-20190820 #119
> Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
> Backtrace:
> [<8010d1ec>] (dump_backtrace) from [<8010d588>] (show_stack+0x20/0x24)
>  r7:8015ed78 r6:00000009 r5:00000000 r4:9f4d9b14
> [<8010d568>] (show_stack) from [<8077e3f0>] (dump_stack+0x24/0x28)
> [<8077e3cc>] (dump_stack) from [<801197a0>] (__warn.part.3+0xcc/0xe4)
> [<801196d4>] (__warn.part.3) from [<80119830>] (warn_slowpath_fmt+0x78/0x94)
>  r6:00000070 r5:808e540c r4:81c03048
> [<801197bc>] (warn_slowpath_fmt) from [<8015ed78>] (dma_common_free_remap+0x88/0x8c)
>  r3:9ef82980 r2:808e53e0
>  r7:00001000 r6:a0b1e000 r5:a0b1e000 r4:00001000
> [<8015ecf0>] (dma_common_free_remap) from [<8010fa9c>] (remap_allocator_free+0x60/0x68)
>  r5:81c03048 r4:9f4d9b78
> [<8010fa3c>] (remap_allocator_free) from [<801100d0>] (__arm_dma_free.constprop.3+0xf8/0x148)
>  r5:81c03048 r4:9ef82900
> [<8010ffd8>] (__arm_dma_free.constprop.3) from [<80110144>] (arm_dma_free+0x24/0x2c)
>  r5:9f563410 r4:80110120
> [<80110120>] (arm_dma_free) from [<8015d80c>] (dma_free_attrs+0xa0/0xdc)
> [<8015d76c>] (dma_free_attrs) from [<8020f3e4>] (dma_pool_destroy+0xc0/0x154)
>  r8:9efa8860 r7:808f02f0 r6:808f02d0 r5:9ef82880 r4:9ef82780
> [<8020f324>] (dma_pool_destroy) from [<805525d0>] (ehci_mem_cleanup+0x6c/0x150)
>  r7:9f563410 r6:9efa8810 r5:00000000 r4:9efd0148
> [<80552564>] (ehci_mem_cleanup) from [<80558e0c>] (ehci_stop+0xac/0xc0)
>  r5:9efd0148 r4:9efd0000
> [<80558d60>] (ehci_stop) from [<8053c4bc>] (usb_remove_hcd+0xf4/0x1b0)
>  r7:9f563410 r6:9efd0074 r5:81c03048 r4:9efd0000
> [<8053c3c8>] (usb_remove_hcd) from [<8056361c>] (host_stop+0x48/0xb8)
>  r7:9f563410 r6:9efd0000 r5:9f5f4040 r4:9f5f5040
> [<805635d4>] (host_stop) from [<80563d0c>] (ci_hdrc_host_destroy+0x34/0x38)
>  r7:9f563410 r6:9f5f5040 r5:9efa8800 r4:9f5f4040
> [<80563cd8>] (ci_hdrc_host_destroy) from [<8055ef18>] (ci_hdrc_remove+0x50/0x10c)
> [<8055eec8>] (ci_hdrc_remove) from [<804a2ed8>] (platform_drv_remove+0x34/0x4c)
>  r7:9f563410 r6:81c4f99c r5:9efa8810 r4:9efa8810
> [<804a2ea4>] (platform_drv_remove) from [<804a18a8>] (device_release_driver_internal+0xec/0x19c)
>  r5:00000000 r4:9efa8810
> [<804a17bc>] (device_release_driver_internal) from [<804a1978>] (device_release_driver+0x20/0x24)
>  r7:9f563410 r6:81c41ed0 r5:9efa8810 r4:9f4a1dac
> [<804a1958>] (device_release_driver) from [<804a01b8>] (bus_remove_device+0xdc/0x108)
> [<804a00dc>] (bus_remove_device) from [<8049c204>] (device_del+0x150/0x36c)
>  r7:9f563410 r6:81c03048 r5:9efa8854 r4:9efa8810
> [<8049c0b4>] (device_del) from [<804a3368>] (platform_device_del.part.2+0x20/0x84)
>  r10:9f563414 r9:809177e0 r8:81cb07dc r7:81c78320 r6:9f563454 r5:9efa8800
>  r4:9efa8800
> [<804a3348>] (platform_device_del.part.2) from [<804a3420>] (platform_device_unregister+0x28/0x34)
>  r5:9f563400 r4:9efa8800
> [<804a33f8>] (platform_device_unregister) from [<8055dce0>] (ci_hdrc_remove_device+0x1c/0x30)
>  r5:9f563400 r4:00000001
> [<8055dcc4>] (ci_hdrc_remove_device) from [<805652ac>] (ci_hdrc_imx_remove+0x38/0x118)
>  r7:81c78320 r6:9f563454 r5:9f563410 r4:9f541010
> [<8056538c>] (ci_hdrc_imx_shutdown) from [<804a2970>] (platform_drv_shutdown+0x2c/0x30)
> [<804a2944>] (platform_drv_shutdown) from [<8049e4fc>] (device_shutdown+0x158/0x1f0)
> [<8049e3a4>] (device_shutdown) from [<8013ac80>] (kernel_restart_prepare+0x44/0x48)
>  r10:00000058 r9:9f4d8000 r8:fee1dead r7:379ce700 r6:81c0b280 r5:81c03048
>  r4:00000000
> [<8013ac3c>] (kernel_restart_prepare) from [<8013ad14>] (kernel_restart+0x1c/0x60)
> [<8013acf8>] (kernel_restart) from [<8013af84>] (__do_sys_reboot+0xe0/0x1d8)
>  r5:81c03048 r4:00000000
> [<8013aea4>] (__do_sys_reboot) from [<8013b0ec>] (sys_reboot+0x18/0x1c)
>  r8:80101204 r7:00000058 r6:00000000 r5:00000000 r4:00000000
> [<8013b0d4>] (sys_reboot) from [<80101000>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0x9f4d9fa8 to 0x9f4d9ff0)
> 9fa0:                   00000000 00000000 fee1dead 28121969 01234567 379ce700
> 9fc0: 00000000 00000000 00000000 00000058 00000000 00000000 00000000 00016d04
> 9fe0: 00028e0c 7ec87c64 000135ec 76c1f410
>
> Restore original invalid input check in dma_common_free_remap() to
> avoid this problem.
>
> Fixes: 5cf4537975bb ("dma-mapping: introduce a dma_common_find_pages helper")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> [hch: just revert the offending hunk instead of creating a new helper]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/remap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index ca4e5d44b571..c00b9258fa6a 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -87,9 +87,9 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
>   */
>  void dma_common_free_remap(void *cpu_addr, size_t size)
>  {
> -       struct page **pages = dma_common_find_pages(cpu_addr);
> +       struct vm_struct *area = find_vm_area(cpu_addr);
>
> -       if (!pages) {
> +       if (!area || area->flags != VM_DMA_COHERENT) {
>                 WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
>                 return;
>         }
> --
> 2.20.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
