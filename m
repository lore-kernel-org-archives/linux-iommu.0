Return-Path: <SRS0=FkPa=NQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14053C4338F
	for <iommu@archiver.kernel.org>; Wed, 25 Aug 2021 07:57:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8132E6138B
	for <iommu@archiver.kernel.org>; Wed, 25 Aug 2021 07:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8132E6138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4001C406FD;
	Wed, 25 Aug 2021 07:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mki5qKeT7_XT; Wed, 25 Aug 2021 07:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF8B440709;
	Wed, 25 Aug 2021 07:57:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C44C4C0010;
	Wed, 25 Aug 2021 07:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46B59C000E
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 07:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03DE1404FA
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 07:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ikp5UAf3CiVu for <iommu@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 07:57:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42DE0403B2
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 07:57:21 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id b7so35660818edu.3
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A3eDvUGO7s6rgbcqfVCZxuvxMbSRmJ1Jj8MfBoaTMPU=;
 b=I0obnZsM9J3DhGn8Ys+njqxlL+bvBvgmQCONvmFRG3akvZreIl/ty1+M2K3Frb8Fb2
 hSsA5AFpaI9srN6CIlMZizcgQO8A3NxT+xtcTgs9d/8FlFmBT0j8teuNajfiQhV4UrlU
 DI4rUsLWVef+y7quOM7/ssYW5S0FO4s1op+sfCFZlto6iKWSI6BCPaEtzhirnHYYVo06
 mikpSeFfIaI0sbYIAkO/PbG1HKRbajG9sRnjQyNlbNYpw7ddU/f5Svq12UMTS5SgkREH
 pYTyBM0g3UtNqg9Y7/2GqaKcShwxlSMVjWTG9unOAYYzvataVgFp+/PCUmIBVtPe6b1G
 9T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A3eDvUGO7s6rgbcqfVCZxuvxMbSRmJ1Jj8MfBoaTMPU=;
 b=tAWk1Qw0K28zY9DUBuYXiJiPXgcurqXbHfq2yYAu2GA7PGsOZFO4tpZCy9ZFyn6fuB
 SPVS8xPjEZYRW1YIxinK6fTTKC/Ki4aECqxNNXH34VgkrBDRg+vSTQreGmDZnpXfJRFu
 5PrFAzJCCH7weGCEFcGmus3gLvQH1sQp3ksQpJ+oUU2aw8looCPEeyOl4yAPZYNDpDtd
 eRIQKPndkX7NdCK5gG3dScknuyDWhZxSe+BY2rng2rbchgzNnvBO6eaQdXmI87CDI298
 HR/+VhsVJ/u7iXGTQkVMsqAaW9EPMv1Sgb5Rmgtd6ACQpLsy6omM8sw6klUAH/cycS8R
 nbSg==
X-Gm-Message-State: AOAM532m/tB/bp+eGD533NvdHo2hLtgWKiRK87P3kf9+gm+pubqiEOLb
 PgG9B0knddMpghXvhYMOA/q3+iJvnOWlTZG5EPzV
X-Google-Smtp-Source: ABdhPJx++s4yL0aljTFECCTgTqB0y8G0ZDiiFqmfkcPa/z8HtCB9PzVuE2+kCr4soT/hE2Bnuo8u47S4GL5NNC9DCyc=
X-Received: by 2002:a50:eb95:: with SMTP id y21mr46534633edr.5.1629878239593; 
 Wed, 25 Aug 2021 00:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
 <20210618084412.18257-1-zhe.he@windriver.com>
In-Reply-To: <20210618084412.18257-1-zhe.he@windriver.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 25 Aug 2021 15:57:08 +0800
Message-ID: <CACycT3sri2-GyaW08JhS2j1V2DRc7-Cv-tm6-T-dD7XVO=S6Vw@mail.gmail.com>
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To: He Zhe <zhe.he@windriver.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>, qiang.zhang@windriver.com,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

Hi guys,

Is there any comments or update for this patch?

Thanks,
Yongji

On Fri, Jun 18, 2021 at 4:47 PM He Zhe <zhe.he@windriver.com> wrote:
>
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
>
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
>
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
>
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
>
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
>
> The credit of modification for eventfd_signal_count goes to
> Xie Yongji <xieyongji@bytedance.com>
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  fs/eventfd.c            | 3 ++-
>  include/linux/eventfd.h | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..add6af91cacf 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -71,7 +71,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>          * it returns true, the eventfd_signal() call should be deferred to a
>          * safe context.
>          */
> -       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
> +           EFD_WAKE_COUNT_MAX))
>                 return 0;
>
>         spin_lock_irqsave(&ctx->wqh.lock, flags);
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index fa0a524baed0..74be152ebe87 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -29,6 +29,9 @@
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
>
> +/* This is the maximum recursion depth we find so far */
> +#define EFD_WAKE_COUNT_MAX 1
> +
>  struct eventfd_ctx;
>  struct file;
>
> @@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
>
>  static inline bool eventfd_signal_count(void)
>  {
> -       return this_cpu_read(eventfd_wake_count);
> +       return this_cpu_read(eventfd_wake_count) > EFD_WAKE_COUNT_MAX;
>  }
>
>  #else /* CONFIG_EVENTFD */
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
