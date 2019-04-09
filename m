Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E14C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5AD21473
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5AD21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D835BFD8;
	Tue,  9 Apr 2019 15:56:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8BED7B8A
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 15:56:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BE609852
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 15:56:18 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id y10so5762886itc.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 09 Apr 2019 08:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=68C3iwnYo2Xm/QppO0J52a1O4X/I+vs9O44WQpI5AC4=;
	b=lbARl36enpW4fJSnlxdBC/1+v8K4lksLdsofvzQubf6ISbAQJbnV+UaeF87j8RaLyE
	IUE5eRqnmdHiuNH5PvUcynCQKyd0XByoNF7toeLPTKSUOelHoQae92tN4qvchJNOZtEG
	QytkREC0VTKs/cE6b0qsXZv8HeXkacWdGhUQFOIIJKlgCCNN9BYtl5vBXMnxCZZhLnJ5
	KRo121PxuRHjf6XzRPPwtc/TxB/aXZLVBCdM21xJ2hUtjKqXiH/JrYXoBazCHAxu/+J8
	ii8mNBRakI0SqmgGnGQUJz2tvX+S0jXVb4u672uA/kjpO5VvqDWzNBySfIRcB2QspqgP
	Cbjg==
X-Gm-Message-State: APjAAAV1yDyPWW3JLmwrWaH4iTgDeV7dNNuDlnVXeRGdp5M9w67OUyKV
	KNIMaF4hrlqvuVyvtURGb5tvKbRwBq/c61YCuSc=
X-Google-Smtp-Source: APXvYqwTqrcXs4HLZBRm+YVMq+4XVf2s96If7WZyhZIF2BCAp66UjjkSH6JCvuXzN/CK4lM+kNvk6VXEBUNfPW8Cr68=
X-Received: by 2002:a02:6f55:: with SMTP id b21mr26845136jae.30.1554825378032; 
	Tue, 09 Apr 2019 08:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org>
	<20190401074730.12241-4-robh@kernel.org>
	<5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
	<CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Tue, 9 Apr 2019 17:56:05 +0200
Message-ID:
 <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To: Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>, David Airlie <airlied@linux.ie>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Marty E . Plummer" <hanetzer@startmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409155605.inBgiyg6c8YfHaphxiZ2hVqD7dCheEv2IyWVN2UI1gg@z>

On Mon, 8 Apr 2019 at 23:04, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
> >
> > On 01/04/2019 08:47, Rob Herring wrote:
> > > This adds the initial driver for panfrost which supports Arm Mali
> > > Midgard and Bifrost family of GPUs. Currently, only the T860 and
> > > T760 Midgard GPUs have been tested.
>
> [...]
> > > +
> > > +             if (status & JOB_INT_MASK_ERR(j)) {
> > > +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
> > > +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
> >
> > Hard-stopping an already completed job isn't likely to do very much :)
> > Also you are using the "_0" version which is only valid when "job chain
> > disambiguation" is present.

Yeah, guess that can be removed.

> > I suspect in this case you should also be signalling the fence? At the
> > moment you rely on the GPU timeout recovering from the fault.
>
> I'll defer to Tomeu who wrote this (IIRC).

Yes, that would be an improvement.

> > One issue that I haven't got to the bottom of is that I can trigger a
> > lockdep splat:
> >
> > -----8<------
> > panfrost ffa30000.gpu: js fault, js=1, status=JOB_CONFIG_FAULT,
> > head=0x0, tail=0x0
> > root@debian:~/ddk_panfrost# panfrost ffa30000.gpu: gpu sched timeout,
> > js=1, status=0x40, head=0x0, tail=0x0, sched_job=12a94ba6
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.0.0+ #32 Not tainted
> > ------------------------------------------------------
> > kworker/1:0/608 is trying to acquire lock:
> > 89b1e2d8 (&(&js->job_lock)->rlock){-.-.}, at:
> > dma_fence_remove_callback+0x14/0x50
> >
> > but task is already holding lock:
> > a887e4b2 (&(&sched->job_list_lock)->rlock){-.-.}, at:
> > drm_sched_stop+0x24/0x10c
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (&(&sched->job_list_lock)->rlock){-.-.}:
> >        drm_sched_process_job+0x60/0x208
> >        dma_fence_signal+0x1dc/0x1fc
> >        panfrost_job_irq_handler+0x160/0x194
> >        __handle_irq_event_percpu+0x80/0x388
> >        handle_irq_event_percpu+0x24/0x78
> >        handle_irq_event+0x38/0x5c
> >        handle_fasteoi_irq+0xb4/0x128
> >        generic_handle_irq+0x18/0x28
> >        __handle_domain_irq+0xa0/0xb4
> >        gic_handle_irq+0x4c/0x78
> >        __irq_svc+0x70/0x98
> >        arch_cpu_idle+0x20/0x3c
> >        arch_cpu_idle+0x20/0x3c
> >        do_idle+0x11c/0x22c
> >        cpu_startup_entry+0x18/0x20
> >        start_kernel+0x398/0x420
> >
> > -> #0 (&(&js->job_lock)->rlock){-.-.}:
> >        _raw_spin_lock_irqsave+0x50/0x64
> >        dma_fence_remove_callback+0x14/0x50
> >        drm_sched_stop+0x5c/0x10c
> >        panfrost_job_timedout+0xd0/0x180
> >        drm_sched_job_timedout+0x34/0x5c
> >        process_one_work+0x2ac/0x6a4
> >        worker_thread+0x28c/0x3fc
> >        kthread+0x13c/0x158
> >        ret_from_fork+0x14/0x20
> >          (null)
> >
> > other info that might help us debug this:
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&(&sched->job_list_lock)->rlock);
> >                                lock(&(&js->job_lock)->rlock);
> >                                lock(&(&sched->job_list_lock)->rlock);
> >   lock(&(&js->job_lock)->rlock);
> >
> >  *** DEADLOCK ***
> >
> > 3 locks held by kworker/1:0/608:
> >  #0: 9b350627 ((wq_completion)"events"){+.+.}, at:
> > process_one_work+0x1f8/0x6a4
> >  #1: a802aa2d ((work_completion)(&(&sched->work_tdr)->work)){+.+.}, at:
> > process_one_work+0x1f8/0x6a4
> >  #2: a887e4b2 (&(&sched->job_list_lock)->rlock){-.-.}, at:
> > drm_sched_stop+0x24/0x10c
> >
> > stack backtrace:
> > CPU: 1 PID: 608 Comm: kworker/1:0 Not tainted 5.0.0+ #32
> > Hardware name: Rockchip (Device Tree)
> > Workqueue: events drm_sched_job_timedout
> > [<c0111088>] (unwind_backtrace) from [<c010c9a8>] (show_stack+0x10/0x14)
> > [<c010c9a8>] (show_stack) from [<c0773df4>] (dump_stack+0x9c/0xd4)
> > [<c0773df4>] (dump_stack) from [<c016d034>]
> > (print_circular_bug.constprop.15+0x1fc/0x2cc)
> > [<c016d034>] (print_circular_bug.constprop.15) from [<c016f6c0>]
> > (__lock_acquire+0xe5c/0x167c)
> > [<c016f6c0>] (__lock_acquire) from [<c0170828>] (lock_acquire+0xc4/0x210)
> > [<c0170828>] (lock_acquire) from [<c07920e0>]
> > (_raw_spin_lock_irqsave+0x50/0x64)
> > [<c07920e0>] (_raw_spin_lock_irqsave) from [<c0516784>]
> > (dma_fence_remove_callback+0x14/0x50)
> > [<c0516784>] (dma_fence_remove_callback) from [<c04def38>]
> > (drm_sched_stop+0x5c/0x10c)
> > [<c04def38>] (drm_sched_stop) from [<c04ec80c>]
> > (panfrost_job_timedout+0xd0/0x180)
> > [<c04ec80c>] (panfrost_job_timedout) from [<c04df340>]
> > (drm_sched_job_timedout+0x34/0x5c)
> > [<c04df340>] (drm_sched_job_timedout) from [<c013ec70>]
> > (process_one_work+0x2ac/0x6a4)
> > [<c013ec70>] (process_one_work) from [<c013fe48>]
> > (worker_thread+0x28c/0x3fc)
> > [<c013fe48>] (worker_thread) from [<c01452a0>] (kthread+0x13c/0x158)
> > [<c01452a0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > Exception stack(0xeebd7fb0 to 0xeebd7ff8)
> > 7fa0:                                     00000000 00000000 00000000
> > 00000000
> > 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000
> > 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > ----8<----
> >
> > This is with the below simple reproducer:
> >
> > ----8<----
> > #include <sys/ioctl.h>
> > #include <fcntl.h>
> > #include <stdio.h>
> >
> > #include <libdrm/drm.h>
> > #include "panfrost_drm.h"
> >
> > int main(int argc, char **argv)
> > {
> >         int fd;
> >
> >         if (argc == 2)
> >                 fd = open(argv[1], O_RDWR);
> >         else
> >                 fd = open("/dev/dri/renderD128", O_RDWR);
> >         if (fd == -1) {
> >                 perror("Failed to open");
> >                 return 0;
> >         }
> >
> >         struct drm_panfrost_submit submit = {
> >                 .jc = 0,
> >         };
> >         return ioctl(fd, DRM_IOCTL_PANFROST_SUBMIT, &submit);
> > }
> > ----8<----
> >
> > Any ideas? I'm not an expert on DRM, so I got somewhat lost!
>
> Tomeu?

Ran out of time today, but will be able to look at it tomorrow.

Thanks!

Tomeu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
