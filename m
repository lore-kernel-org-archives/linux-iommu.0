Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B01C49EA4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 03:29:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD056613BF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 03:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD056613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86940401EC;
	Fri, 18 Jun 2021 03:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ocA-IRnMaWJG; Fri, 18 Jun 2021 03:29:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B46E40003;
	Fri, 18 Jun 2021 03:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E5C2C000D;
	Fri, 18 Jun 2021 03:29:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B194C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 03:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D675B401CB
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 03:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stGvfc8aTvhu for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 03:29:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41E23401C8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 03:29:31 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id df12so4118115edb.2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 20:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RMJgBEdiibhwSUyvuLKFkBrL4/U8fE/jxx04irYLGbA=;
 b=av/95B/MiI0xJSuNnIDSIou3GubtAy+v+Cj0IrEJ68VjpsLdRM7w3o1oORGPuxM9E9
 WcXBTXk69tPR+JRT9pirwPl1i4rEmPN+ROSzO+PpYUb6DGevaUs4cQChuJ9gWp9jybLU
 337xsWnlSDEFmVS8b9WCf45xojO+ucnKBtO3ThsQgErg6gNQGMsF1NJtWAQTA+IzuLEE
 lYIbqpRQcPEBixvBPRcSDXBPAnVFOEE11AW5zQ6nXaMHXzougZshHL3HBZOa0i1hhh2b
 I2Et2SNidVGS73kG8qlrW1IyTkcBNKTv++J6c5+xl/hwwNMONF8NwQMk+WXrJ33LwaNC
 opBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RMJgBEdiibhwSUyvuLKFkBrL4/U8fE/jxx04irYLGbA=;
 b=VZDAmPgSiOIGJAadOJ4laafw6b7tVRPm6VDGVYHm88NyvRP7nVdW4pYnHAPLSkMSky
 /RRzqNJBilVqNyXFB6K1pLvXVeYiiaqP9w6C+1Vp0GYBtg0HrAmiFZuUtjVToKPkWRjt
 Nl7hiKe+cVg7R59Tg/F+S7jvlw8bQ1iK8qCuSbsznxQOJkG2QZGy2ORN4/53074oo+T9
 P2sAdFziW7mj45PKPZeM1Ap1WlYRRNnLwb6jNDJ2TZXgljMY9AJkYEU69XvyLjPg3l7b
 uPBNzwGmXbBs8BmIrKKlvoamswIL2mt6m3jAZJSakT2ppYvaWateH7/bmSJGsxNp7lIC
 LK8A==
X-Gm-Message-State: AOAM533spxM74KAoXnhMt/VIQhX7j5gz7hndYzS3xgULgAhDHzwR2+yl
 a7ViftvIRSWdD8w3ldBkg3hfIer+tCHVbAfbenxq
X-Google-Smtp-Source: ABdhPJykGigJ4CmNJwWRgh5x2T6MNjBJPAc2OA16hTcBQrCjxSZwuj53EmfZdOWUW2UcDeCGl7ONh7uq9+Uou058YZU=
X-Received: by 2002:aa7:d9d3:: with SMTP id v19mr2042806eds.145.1623986969936; 
 Thu, 17 Jun 2021 20:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-4-xieyongji@bytedance.com>
 <8aeac914-7602-7323-31bd-71015a26f74c@windriver.com>
In-Reply-To: <8aeac914-7602-7323-31bd-71015a26f74c@windriver.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 18 Jun 2021 11:29:19 +0800
Message-ID: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
Subject: Re: Re: [PATCH v8 03/10] eventfd: Increase the recursion depth of
 eventfd_signal()
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
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

On Thu, Jun 17, 2021 at 4:34 PM He Zhe <zhe.he@windriver.com> wrote:
>
>
>
> On 6/15/21 10:13 PM, Xie Yongji wrote:
> > Increase the recursion depth of eventfd_signal() to 1. This
> > is the maximum recursion depth we have found so far, which
> > can be triggered with the following call chain:
> >
> >     kvm_io_bus_write                        [kvm]
> >       --> ioeventfd_write                   [kvm]
> >         --> eventfd_signal                  [eventfd]
> >           --> vhost_poll_wakeup             [vhost]
> >             --> vduse_vdpa_kick_vq          [vduse]
> >               --> eventfd_signal            [eventfd]
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> The fix had been posted one year ago.
>
> https://lore.kernel.org/lkml/20200410114720.24838-1-zhe.he@windriver.com/
>

OK, so it seems to be a fix for the RT system if my understanding is
correct? Any reason why it's not merged? I'm happy to rebase my series
on your patch if you'd like to repost it.

BTW, I also notice another thread for this issue:

https://lore.kernel.org/linux-fsdevel/DM6PR11MB420291B550A10853403C7592FF349@DM6PR11MB4202.namprd11.prod.outlook.com/T/

>
> > ---
> >  fs/eventfd.c            | 2 +-
> >  include/linux/eventfd.h | 5 ++++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/eventfd.c b/fs/eventfd.c
> > index e265b6dd4f34..cc7cd1dbedd3 100644
> > --- a/fs/eventfd.c
> > +++ b/fs/eventfd.c
> > @@ -71,7 +71,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
> >        * it returns true, the eventfd_signal() call should be deferred to a
> >        * safe context.
> >        */
> > -     if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> > +     if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH))
> >               return 0;
> >
> >       spin_lock_irqsave(&ctx->wqh.lock, flags);
> > diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> > index fa0a524baed0..886d99cd38ef 100644
> > --- a/include/linux/eventfd.h
> > +++ b/include/linux/eventfd.h
> > @@ -29,6 +29,9 @@
> >  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
> >  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
> >
> > +/* Maximum recursion depth */
> > +#define EFD_WAKE_DEPTH 1
> > +
> >  struct eventfd_ctx;
> >  struct file;
> >
> > @@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
> >
> >  static inline bool eventfd_signal_count(void)
> >  {
> > -     return this_cpu_read(eventfd_wake_count);
> > +     return this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH;
>
> count is just count. How deep is acceptable should be put
> where eventfd_signal_count is called.
>

The return value of this function is boolean rather than integer.
Please see the comments in eventfd_signal():

"then it should check eventfd_signal_count() before calling this
function. If it returns true, the eventfd_signal() call should be
deferred to a safe context."

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
