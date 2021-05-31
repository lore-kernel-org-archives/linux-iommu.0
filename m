Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD4C47094
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 06:19:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DA061248
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 06:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DA061248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27EF560A41;
	Mon, 31 May 2021 06:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSkJ85P1n3mp; Mon, 31 May 2021 06:19:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E534860629;
	Mon, 31 May 2021 06:19:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE893C000E;
	Mon, 31 May 2021 06:19:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91032C000E
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 06:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F5474014B
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 06:19:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mXNPPRkuAoyw for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:19:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0D4340134
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 06:19:50 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id ci15so11602207ejc.10
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 23:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7bEMlb5GJnKoHl8SpkOQX3JFXjx8ZQxpVkCFt5EoYmw=;
 b=Ls9LQv0i3iJbU1z5UJZXY6AeHd3GDC4esNjbcR20048Z7nj5bPUHKS3EBTeOdf3fF3
 SRWQE3AE3hpFGPSdIl2RCG7cPt0IhAYm+7LP7gcGyOwrwi/klUcnBjy1Q2O10MW0Yxlm
 f9Z0L0DK1/28QjUCRiXR2oOS4gy63oyvXVR2BIw9foi02cZsa7eQrN6Y8FjwlfA8eN9q
 0W9VTFMJtY02a1p+DN7MJSfqywy7fMmGldlzcWvxU5R2+fwMiLWNC68FKxkusUyBG7D0
 nhe25POF/9pIY4y1ip/yYUrD9WOenEZ4gQ8Xs15XAlOVPWdsmGByT9luAj4SrY+s80V9
 /RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7bEMlb5GJnKoHl8SpkOQX3JFXjx8ZQxpVkCFt5EoYmw=;
 b=nT5fJuO2VZrwCOCcLzZeL+xk85RkJD7TD8o86Q+8YyOySz3SfGaxdqVZxuCF2LJd6O
 cNmd5ED+mIjMpz4otRzdsvqQUnYneq52D0kmEATU+ZvKUF0wHts+ExoDn7DLXdu6KPwk
 SL7h7rlGf98CG1SppEvUKTBeAgpT+8ROiE2brN1nfYXORtfkQ6eNK0Y1c5upBAbqY3wX
 3aodZQqVS2i6fMXgBuvVj6fWhOPi9iYV8TmsJhK6ejLqcgPHzW6EjLlYbVpotcS5RLDk
 aSf5JEhE3J4qmJfaf1I9tVt/MQR+zoKqSatv0xjZ1A9owHqNgcDvZl4WzuGS+DlVggCQ
 Im0Q==
X-Gm-Message-State: AOAM532Yzicu7Rx8GGxHSCK/eQe3cU63rIFvmHjZA60Xjwtb7gRkBvTZ
 HkoPvWwjJeEAcfW3VYUeYqVZ7hReZQ9N6zjDV9k6
X-Google-Smtp-Source: ABdhPJwuBhBc2sqonaY7g3Uw2ldI0Yl0ApoGOit6DAeP/9k9jTaa1Mal+z2O20b6FoR+z3L/o/96desbl15o3ZcaXic=
X-Received: by 2002:a17:906:b84f:: with SMTP id
 ga15mr8450191ejb.372.1622441988884; 
 Sun, 30 May 2021 23:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <YLRsehBRAiCJEDl0@kroah.com>
In-Reply-To: <YLRsehBRAiCJEDl0@kroah.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 31 May 2021 14:19:37 +0800
Message-ID: <CACycT3vRHPfOGxmy1Uv=8_dqqq8iG4YTZHUizo+y8EYKGS5g8g@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
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

Hi Greg,

Thanks a lot for the review!

On Mon, May 31, 2021 at 12:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:
> > +struct vduse_dev {
> > +     struct vduse_vdpa *vdev;
> > +     struct device dev;
> > +     struct cdev cdev;
>
> You now have 2 reference counted devices controling the lifespace of a
> single structure.  A mess that is guaranteed to go wrong.  Please never
> do this.
>

These two are both used by cdev_device_add(). Looks like I didn't find
any problem. Any suggestions?

> > +     struct vduse_virtqueue *vqs;
> > +     struct vduse_iova_domain *domain;
> > +     char *name;
> > +     struct mutex lock;
> > +     spinlock_t msg_lock;
> > +     atomic64_t msg_unique;
>
> Why do you need an atomic and a lock?
>

You are right. We don't need an atomic here.

> > +     wait_queue_head_t waitq;
> > +     struct list_head send_list;
> > +     struct list_head recv_list;
> > +     struct list_head list;
> > +     struct vdpa_callback config_cb;
> > +     struct work_struct inject;
> > +     spinlock_t irq_lock;
> > +     unsigned long api_version;
> > +     bool connected;
> > +     int minor;
> > +     u16 vq_size_max;
> > +     u32 vq_num;
> > +     u32 vq_align;
> > +     u32 config_size;
> > +     u32 device_id;
> > +     u32 vendor_id;
> > +};
> > +
> > +struct vduse_dev_msg {
> > +     struct vduse_dev_request req;
> > +     struct vduse_dev_response resp;
> > +     struct list_head list;
> > +     wait_queue_head_t waitq;
> > +     bool completed;
> > +};
> > +
> > +struct vduse_control {
> > +     unsigned long api_version;
>
> u64?
>

OK.

> > +};
> > +
> > +static unsigned long max_bounce_size = (64 * 1024 * 1024);
> > +module_param(max_bounce_size, ulong, 0444);
> > +MODULE_PARM_DESC(max_bounce_size, "Maximum bounce buffer size. (default: 64M)");
> > +
> > +static unsigned long max_iova_size = (128 * 1024 * 1024);
> > +module_param(max_iova_size, ulong, 0444);
> > +MODULE_PARM_DESC(max_iova_size, "Maximum iova space size (default: 128M)");
> > +
> > +static bool allow_unsafe_device_emulation;
> > +module_param(allow_unsafe_device_emulation, bool, 0444);
> > +MODULE_PARM_DESC(allow_unsafe_device_emulation, "Allow emulating unsafe device."
> > +     " We must make sure the userspace device emulation process is trusted."
> > +     " Otherwise, don't enable this option. (default: false)");
> > +
>
> This is not the 1990's anymore, please never use module parameters, make
> these per-device attributes if you really need them.
>

These parameters will be used before the device is created. Or do you
mean add some attributes to the control device?

> > +static int vduse_init(void)
> > +{
> > +     int ret;
> > +
> > +     if (max_bounce_size >= max_iova_size)
> > +             return -EINVAL;
> > +
> > +     ret = misc_register(&vduse_misc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     vduse_class = class_create(THIS_MODULE, "vduse");
>
> If you have a misc device, you do not need to create a class at the same
> time.  Why are you doing both here?  Just stick with the misc device, no
> need for anything else.
>

The misc device is the control device represented by
/dev/vduse/control. Then a VDUSE device represented by
/dev/vduse/$NAME can be created by the ioctl(VDUSE_CREATE_DEV) on this
control device.

> > +     if (IS_ERR(vduse_class)) {
> > +             ret = PTR_ERR(vduse_class);
> > +             goto err_class;
> > +     }
> > +     vduse_class->devnode = vduse_devnode;
> > +
> > +     ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
>
> Wait, you want a whole major?  What is the misc device for?
>

The misc device is used for controlling. And VDUSE devices are
allocated in a dynamic chardev range. Or do I need to reserve the
first minor for the control device instead?

> > +MODULE_VERSION(DRV_VERSION);
>
> MODULE_VERSION() makes no sense when the code is merged into the kernel
> tree, so you can just drop that.
>

Will do it.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
