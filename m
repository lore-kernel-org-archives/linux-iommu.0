Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83BC4708F
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 07:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259F26100A
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 07:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259F26100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5EE240378;
	Mon, 31 May 2021 07:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1hP8LRU5lk1; Mon, 31 May 2021 07:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69EDC4035D;
	Mon, 31 May 2021 07:13:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39844C000E;
	Mon, 31 May 2021 07:13:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4527AC0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 07:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16A194023F
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 07:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IaVk_it7HNCh for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:13:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E22B940134
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 07:13:31 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id r11so12258194edt.13
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HsUiQi3ntUxHPOgfLtJZfOJE0YtMnjg4ItjU9q5zMjE=;
 b=pjl+eyiZ3SVuMuplEw97FDWO0PFqcd17F4vwf+if4jHNgPbn1w1mQjgqab4EuyqMH4
 i2yCpgZbMQHteb4eEJfalzc4jiHuoaRyUEnLGscOViLDFU+FaIzY9+FgYY/vzLGLhGwa
 Cl2uBYhAWAGrrML81PUus32wzX3oLmigWxiVFrw0QBv51HciWo8blYjKOHMBj9iDIhBq
 OA8nYaQ7Aw+DzdfB6Pms1I5qeAWNW6gF1ew/EkpajY0jHoLlTYi9BzhksrzBNJSWC4xg
 fhqGEFYXOVa6N6fS6yzpW9wpuwbybGX9qNarvRbYOiESGPy1kA70dU0szyW+EGJSqMkW
 Qvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HsUiQi3ntUxHPOgfLtJZfOJE0YtMnjg4ItjU9q5zMjE=;
 b=g9ETJ8M+P58tkbtc85LQbl1Q8JJd4wW/9gKpB+3xId2Tn7qLFUXqDVFlw+WL5VgIN8
 d1KKG6NRxw5raZ9uk7PPZ2kwpwauMHDj67kMSMP0b254YQ4YQRBhlAzob1YJPLV8RXLz
 Z/pDgB3cX8UJqexMnw4JDsqn9wnqHsDTkB//xjHHfjUtgTYYcGPewuZTh5WCQG4O26EJ
 B+UnbqEc5DGPolL3sU9JiH14vIv2czbuTI86f3g/4QlNp2AvkDhJ/xcO3Dq0KLtoTONT
 I1+3sL7tqnDdyGXArvcxYWpZGVcy6UtQ0zXrS1krU32HFg4v+GdCHDLLP10D9opCi0Eb
 M+Vg==
X-Gm-Message-State: AOAM533bOhzX4nPSATc4JarUSgx4fEZdtnCjL11hgR04b1d/aiK0yiFj
 JdMT1klKjXjLrynM3EdX3D1R0dKPdVQBV8etqRjO
X-Google-Smtp-Source: ABdhPJxz6zmra41o6Y5jQKsKyQQGK6vr2Kk7000vKI5r+AMsAhkzn/ieUzE/Q93Iok6mSGB/HstZcEDQcLUJcTjE5oM=
X-Received: by 2002:a50:9e8e:: with SMTP id a14mr2295520edf.5.1622445209532;
 Mon, 31 May 2021 00:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <YLRsehBRAiCJEDl0@kroah.com>
 <CACycT3vRHPfOGxmy1Uv=8_dqqq8iG4YTZHUizo+y8EYKGS5g8g@mail.gmail.com>
 <YLSC6AthAl+VeQsv@kroah.com>
In-Reply-To: <YLSC6AthAl+VeQsv@kroah.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 31 May 2021 15:13:18 +0800
Message-ID: <CACycT3t4OABUoXGjx4Fyf1iMm--OTC8Vdp8rN1ppCs0W15V6iA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
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

On Mon, May 31, 2021 at 2:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 31, 2021 at 02:19:37PM +0800, Yongji Xie wrote:
> > Hi Greg,
> >
> > Thanks a lot for the review!
> >
> > On Mon, May 31, 2021 at 12:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:
> > > > +struct vduse_dev {
> > > > +     struct vduse_vdpa *vdev;
> > > > +     struct device dev;
> > > > +     struct cdev cdev;
> > >
> > > You now have 2 reference counted devices controling the lifespace of a
> > > single structure.  A mess that is guaranteed to go wrong.  Please never
> > > do this.
> > >
> >
> > These two are both used by cdev_device_add(). Looks like I didn't find
> > any problem. Any suggestions?
>
> Make one of these dynamic and do not have them both control the lifespan
> of the structure.
>

I see some comments in cdev_device_add():

"This function should be used whenever the struct cdev and the struct
device are members of the same structure whose lifetime is managed by
the struct device."

So it seems to be ok here?

> > > > +     struct vduse_virtqueue *vqs;
> > > > +     struct vduse_iova_domain *domain;
> > > > +     char *name;
> > > > +     struct mutex lock;
> > > > +     spinlock_t msg_lock;
> > > > +     atomic64_t msg_unique;
> > >
> > > Why do you need an atomic and a lock?
> > >
> >
> > You are right. We don't need an atomic here.
> >
> > > > +     wait_queue_head_t waitq;
> > > > +     struct list_head send_list;
> > > > +     struct list_head recv_list;
> > > > +     struct list_head list;
> > > > +     struct vdpa_callback config_cb;
> > > > +     struct work_struct inject;
> > > > +     spinlock_t irq_lock;
> > > > +     unsigned long api_version;
> > > > +     bool connected;
> > > > +     int minor;
> > > > +     u16 vq_size_max;
> > > > +     u32 vq_num;
> > > > +     u32 vq_align;
> > > > +     u32 config_size;
> > > > +     u32 device_id;
> > > > +     u32 vendor_id;
> > > > +};
> > > > +
> > > > +struct vduse_dev_msg {
> > > > +     struct vduse_dev_request req;
> > > > +     struct vduse_dev_response resp;
> > > > +     struct list_head list;
> > > > +     wait_queue_head_t waitq;
> > > > +     bool completed;
> > > > +};
> > > > +
> > > > +struct vduse_control {
> > > > +     unsigned long api_version;
> > >
> > > u64?
> > >
> >
> > OK.
> >
> > > > +};
> > > > +
> > > > +static unsigned long max_bounce_size = (64 * 1024 * 1024);
> > > > +module_param(max_bounce_size, ulong, 0444);
> > > > +MODULE_PARM_DESC(max_bounce_size, "Maximum bounce buffer size. (default: 64M)");
> > > > +
> > > > +static unsigned long max_iova_size = (128 * 1024 * 1024);
> > > > +module_param(max_iova_size, ulong, 0444);
> > > > +MODULE_PARM_DESC(max_iova_size, "Maximum iova space size (default: 128M)");
> > > > +
> > > > +static bool allow_unsafe_device_emulation;
> > > > +module_param(allow_unsafe_device_emulation, bool, 0444);
> > > > +MODULE_PARM_DESC(allow_unsafe_device_emulation, "Allow emulating unsafe device."
> > > > +     " We must make sure the userspace device emulation process is trusted."
> > > > +     " Otherwise, don't enable this option. (default: false)");
> > > > +
> > >
> > > This is not the 1990's anymore, please never use module parameters, make
> > > these per-device attributes if you really need them.
> > >
> >
> > These parameters will be used before the device is created. Or do you
> > mean add some attributes to the control device?
>
> You need to do something, as no one can mess with a module parameter
> easily.  Why do you need them at all, shouldn't it "just work" properly
> with no need for userspace interaction?
>

OK, I get you. It works fine with the default value. So I think it
should be ok to remove these parameters before we find a situation
that really needs them.

> > > > +static int vduse_init(void)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     if (max_bounce_size >= max_iova_size)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret = misc_register(&vduse_misc);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     vduse_class = class_create(THIS_MODULE, "vduse");
> > >
> > > If you have a misc device, you do not need to create a class at the same
> > > time.  Why are you doing both here?  Just stick with the misc device, no
> > > need for anything else.
> > >
> >
> > The misc device is the control device represented by
> > /dev/vduse/control. Then a VDUSE device represented by
> > /dev/vduse/$NAME can be created by the ioctl(VDUSE_CREATE_DEV) on this
> > control device.
>
> Ah.  Then how about using the same MAJOR for all of these, and just have
> the first minor (0) be your control?  That happens for other device
> types (raw, loop, etc.).  Or just document this really well please, as
> it was not obvious what you were doing here.
>

OK, I will reserve the first minor (0) for the control device instead.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
