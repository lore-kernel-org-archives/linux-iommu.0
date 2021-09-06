Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F02C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 07:07:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A56860F21
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 07:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A56860F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C7EC403C1;
	Mon,  6 Sep 2021 07:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKYdfpnRRAqd; Mon,  6 Sep 2021 07:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05EC7403E2;
	Mon,  6 Sep 2021 07:06:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5FAC0020;
	Mon,  6 Sep 2021 07:06:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 985D8C001B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 07:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EFAE403E0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 07:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id taUs_Jc2GK60 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 07:06:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 626AE403D3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 07:06:57 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id lc21so11477773ejc.7
 for <iommu@lists.linux-foundation.org>; Mon, 06 Sep 2021 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q3MG6YTB+QzDfQAiZySr2rS0jN8YaIk13obJQJ/stWo=;
 b=lkQZaa6g9ei4zhefeS4/oyNQrJS2xco6ilGBKyKlZ6vC0SUD8QQ+1knPvpyi6IaHac
 GqpF6T/J9e8UZEhbRcxYY2Vqkdxa9S0Mc6OSDQEPV8Lm2RG5xwllvm/ICW7ihxTyN8cQ
 6q8HxGdwJRriwFkXrBLniQ+rOGGSciTVwRPaZN0SjIEyZqVJuZ/w0QfR4/wBg4GuaIvK
 u5g1glJnwNcAurESAAaeIz8Og+r0qqEHDRcUcXNFnSlIosPcpoHpNITG9ICSkR9Z8ltb
 ne8SJRTHipR+XIW/F978DLyiAT4QKN6N8mAAM4madRU69d+NI8I3REMHopnFJfCrL03M
 8PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q3MG6YTB+QzDfQAiZySr2rS0jN8YaIk13obJQJ/stWo=;
 b=MlVmfha0FCZAGxtzRgGtV0/N/zSRKu2OrHHBbG6Og51GZLR0slg2XPzjmtDM2FrQpH
 +em9KWgKyqrHZ1haRJVgGtiflnT7awkkteeuFLeQ8OhYJ20wfwJaI/0KFvJEPjWtHuWP
 EZccGIDwWTNoe4OibIMHXkQmWxnkxWJxoNU9SOgh04zjD2x3O69GSOjskRot5NUjXD+d
 Ro/RIN2bJKf+FQxTXA42U1jUDyd1Xc9ybD2hGUKYlBxsEHrOWgvxR99BehJKKlEcwt8J
 OiDwAK3hgnOTXqJLJfRL6ZMY66VrZV43Ju5JGpjiln5utN6nFTo5QbE+eXU/51ZaqiEt
 zIkw==
X-Gm-Message-State: AOAM530hbnc5bCHN6+ld1zxW38WupETjmkb9q8NkoYeYM19g0sI7wSpt
 ZSLa3trrHtjjh6z15OBPvk14JyM5kMKQmA+cVK+M
X-Google-Smtp-Source: ABdhPJywBwaaVm3boucqd1sdO/Cfi8IGS0P4Me7y+BCi/2fL1YgT6rXVQRK94JvNPY5a+i9h1dktiuFSZgpWUJHXv74=
X-Received: by 2002:a17:906:8da:: with SMTP id
 o26mr12057282eje.424.1630912015321; 
 Mon, 06 Sep 2021 00:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
 <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
 <20210906023131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210906023131-mutt-send-email-mst@kernel.org>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 6 Sep 2021 15:06:44 +0800
Message-ID: <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
Subject: Re: [PATCH v13 05/13] vdpa: Add reset callback in vdpa_config_ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Sep 6, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> > On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > > This adds a new callback to support device specific reset
> > > > behavior. The vdpa bus driver will call the reset function
> > > > instead of setting status to zero during resetting.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > >
> > >
> > > This does gloss over a significant change though:
> > >
> > >
> > > > ---
> > > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > > >       return vdev->dma_dev;
> > > >  }
> > > >
> > > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > > >  {
> > > >       const struct vdpa_config_ops *ops = vdev->config;
> > > >
> > > >       vdev->features_valid = false;
> > > > -     ops->set_status(vdev, 0);
> > > > +     return ops->reset(vdev);
> > > >  }
> > > >
> > > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > >
> > >
> > > Unfortunately this breaks virtio_vdpa:
> > >
> > >
> > > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > > {
> > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > >
> > >         vdpa_reset(vdpa);
> > > }
> > >
> > >
> > > and there's no easy way to fix this, kernel can't recover
> > > from a reset failure e.g. during driver unbind.
> > >
> >
> > Yes, but it should be safe with the protection of software IOTLB even
> > if the reset() fails during driver unbind.
> >
> > Thanks,
> > Yongji
>
> Hmm. I don't see it.
> What exactly will happen? What prevents device from poking at
> memory after reset? Note that dma unmap in e.g. del_vqs happens
> too late.

But I didn't see any problems with touching the memory for virtqueues.
The memory should not be freed after dma unmap?

And the memory for the bounce buffer should also be safe to be
accessed by userspace in this case.

> And what about e.g. interrupts?
> E.g. we have this:
>
>         /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
>         vblk->vdev = NULL;
>
> and this is no longer true at this point.
>

You're right. But I didn't see where the interrupt handler will use
the vblk->vdev.

So it seems to be not too late to fix it:

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
b/drivers/vdpa/vdpa_user/vduse_dev.c
index 5c25ff6483ad..ea41a7389a26 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -665,13 +665,13 @@ static void vduse_vdpa_set_config(struct
vdpa_device *vdpa, unsigned int offset,
 static int vduse_vdpa_reset(struct vdpa_device *vdpa)
 {
        struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+       int ret;

-       if (vduse_dev_set_status(dev, 0))
-               return -EIO;
+       ret = vduse_dev_set_status(dev, 0);

        vduse_dev_reset(dev);

-       return 0;
+       return ret;
 }

 static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
