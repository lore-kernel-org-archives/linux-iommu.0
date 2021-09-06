Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412ADC433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 10:43:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D5160EBA
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 10:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1D5160EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4971401E0;
	Mon,  6 Sep 2021 10:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RXFc42S4mSxC; Mon,  6 Sep 2021 10:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADC6B40191;
	Mon,  6 Sep 2021 10:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87516C0022;
	Mon,  6 Sep 2021 10:43:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE24C001B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 10:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49A79401B9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 10:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kT4VR7YgZ-hD for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 10:43:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 644C240191
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630925008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul4qFH3gT696MqPqcmDxIOKc6JmUkzaJFABQhow9EWg=;
 b=Z/xs0+zLjrfh7JPYwEGwew8ZYHD1BIOpUhdnolj6GyzBYF7CUwgS/lwVstqN96ovtawMoz
 vN0WSjWEWfRpFtE25LpWPqoR4ykJKz0MOBYyo2hMM1YCnaBG2RY1m6ZgcGaPVXl5LyInc7
 JEj4Hf82G4s8tnMK2c06olMiisUUuHM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-uteeizzzM2ezXthtizcN1A-1; Mon, 06 Sep 2021 06:43:25 -0400
X-MC-Unique: uteeizzzM2ezXthtizcN1A-1
Received: by mail-wm1-f71.google.com with SMTP id
 y188-20020a1c7dc5000000b002e80e0b2f87so3760740wmc.1
 for <iommu@lists.linux-foundation.org>; Mon, 06 Sep 2021 03:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ul4qFH3gT696MqPqcmDxIOKc6JmUkzaJFABQhow9EWg=;
 b=JLeTfj+V/ZBr524QedJHIBbByOVwLA2PBaR2KFHpiTmIf3dB7k5MA2Xhagf6M6uLp9
 J3Ji+tQJMz61hbx2xJPKyN+0rsFkLwur91R6WKw0OImF8rdWQ372xjjwStRCmvAp2asn
 YqPwkPxaKvaZWuIoxwrKFeLvOP4fB+GPnIS9bFBXDRu8Evg18hIU2qubXDhb3cZrI6oM
 xZISJ9x+RrXdeKNkWMWdaeUBIa0qeT4qYee/dUEI3IiMhUAw2ru5gxGOBnFk7hxwdRsE
 COuExFFznHqQDY4RCfKn2r31LA7FRVxi+2ViWCFijeHyCRGblMI79qkOjqgpSCVeE+6b
 rRTA==
X-Gm-Message-State: AOAM533M19GL50KLuZgw4ZPtD1qaD0i5Y+aWup/PdVv1y2i94Osh9v/2
 iiELW3xwWqCyC+99ZT5R6sGsq2IXhz0L44x90KEJfNTEBfMlGgo2TOmIbsS5b5JlSsDzuRSvIUC
 ha9q13S7R+mr/q9IadQXQpoXV8hfEKw==
X-Received: by 2002:a05:600c:3543:: with SMTP id
 i3mr10798068wmq.2.1630925004205; 
 Mon, 06 Sep 2021 03:43:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq0y7NDDKEVc4QMn/xSXfsLrateDW5EX086OFKHb0Me/zK5A7xaZmIg1gdA2WViHz/LIzfeQ==
X-Received: by 2002:a05:600c:3543:: with SMTP id
 i3mr10798024wmq.2.1630925003942; 
 Mon, 06 Sep 2021 03:43:23 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id g5sm7424960wrq.80.2021.09.06.03.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 03:43:22 -0700 (PDT)
Date: Mon, 6 Sep 2021 06:43:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v13 05/13] vdpa: Add reset callback in vdpa_config_ops
Message-ID: <20210906053210-mutt-send-email-mst@kernel.org>
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
 <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
 <20210906023131-mutt-send-email-mst@kernel.org>
 <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
 <20210906035338-mutt-send-email-mst@kernel.org>
 <CACycT3vQHRsJ_j5f4T9RoB4MQzBoYO5ts3egVe9K6TcCVfLOFQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vQHRsJ_j5f4T9RoB4MQzBoYO5ts3egVe9K6TcCVfLOFQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

On Mon, Sep 06, 2021 at 04:45:55PM +0800, Yongji Xie wrote:
> On Mon, Sep 6, 2021 at 4:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 06, 2021 at 03:06:44PM +0800, Yongji Xie wrote:
> > > On Mon, Sep 6, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> > > > > On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > > > > > This adds a new callback to support device specific reset
> > > > > > > behavior. The vdpa bus driver will call the reset function
> > > > > > > instead of setting status to zero during resetting.
> > > > > > >
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > >
> > > > > >
> > > > > > This does gloss over a significant change though:
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > > > > > >       return vdev->dma_dev;
> > > > > > >  }
> > > > > > >
> > > > > > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > > > > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > > > > > >  {
> > > > > > >       const struct vdpa_config_ops *ops = vdev->config;
> > > > > > >
> > > > > > >       vdev->features_valid = false;
> > > > > > > -     ops->set_status(vdev, 0);
> > > > > > > +     return ops->reset(vdev);
> > > > > > >  }
> > > > > > >
> > > > > > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > > > >
> > > > > >
> > > > > > Unfortunately this breaks virtio_vdpa:
> > > > > >
> > > > > >
> > > > > > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > > > > > {
> > > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > > >
> > > > > >         vdpa_reset(vdpa);
> > > > > > }
> > > > > >
> > > > > >
> > > > > > and there's no easy way to fix this, kernel can't recover
> > > > > > from a reset failure e.g. during driver unbind.
> > > > > >
> > > > >
> > > > > Yes, but it should be safe with the protection of software IOTLB even
> > > > > if the reset() fails during driver unbind.
> > > > >
> > > > > Thanks,
> > > > > Yongji
> > > >
> > > > Hmm. I don't see it.
> > > > What exactly will happen? What prevents device from poking at
> > > > memory after reset? Note that dma unmap in e.g. del_vqs happens
> > > > too late.
> > >
> > > But I didn't see any problems with touching the memory for virtqueues.
> >
> > Drivers make the assumption that after reset returns no new
> > buffers will be consumed. For example a bunch of drivers
> > call virtqueue_detach_unused_buf.
> 
> I'm not sure if I get your point. But it looks like
> virtqueue_detach_unused_buf() will check the driver's metadata first
> rather than read the memory from virtqueue.
> 
> > I can't say whether block makes this assumption anywhere.
> > Needs careful auditing.
> >
> > > The memory should not be freed after dma unmap?
> >
> > But unmap does not happen until after the reset.
> >
> 
> I mean the memory is totally allocated and controlled by the VDUSE
> driver. The VDUSE driver will not return them to the buddy system
> unless userspace unmap it.

Right. But what stops VDUSE from poking at memory after
reset failed?



> >
> > > And the memory for the bounce buffer should also be safe to be
> > > accessed by userspace in this case.
> > >
> > > > And what about e.g. interrupts?
> > > > E.g. we have this:
> > > >
> > > >         /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
> > > >         vblk->vdev = NULL;
> > > >
> > > > and this is no longer true at this point.
> > > >
> > >
> > > You're right. But I didn't see where the interrupt handler will use
> > > the vblk->vdev.
> >
> > static void virtblk_done(struct virtqueue *vq)
> > {
> >         struct virtio_blk *vblk = vq->vdev->priv;
> >
> > vq->vdev is the same as vblk->vdev.
> >
> 
> We will test the vq->ready (will be set to false in del_vqs()) before
> injecting an interrupt in the VDUSE driver. So it should be OK?

Maybe not ...  It's not designed for such asynchronous access, so e.g.
there's no locking or memory ordering around accesses.


> >
> > > So it seems to be not too late to fix it:
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 5c25ff6483ad..ea41a7389a26 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -665,13 +665,13 @@ static void vduse_vdpa_set_config(struct
> > > vdpa_device *vdpa, unsigned int offset,
> > >  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
> > >  {
> > >         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > +       int ret;
> > >
> > > -       if (vduse_dev_set_status(dev, 0))
> > > -               return -EIO;
> > > +       ret = vduse_dev_set_status(dev, 0);
> > >
> > >         vduse_dev_reset(dev);
> > >
> > > -       return 0;
> > > +       return ret;
> > >  }
> > >
> > >  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> > >
> > > Thanks,
> > > Yongji
> >
> > Needs some comments to explain why it's done like this.
> >
> 
> This is used to make sure the userspace can't not inject the interrupt
> any more after reset. The vduse_dev_reset() will clear the interrupt
> callback and flush the irq kworker.
> 
> > BTW device is generally wedged at this point right?
> > E.g. if reset during initialization fails, userspace
> > will still get the reset at some later point and be
> > confused ...
> >
> 
> Sorry, I don't get why userspace will get the reset at some later point?
> 
> Thanks,
> Yongji

I am generally a bit confused about how does reset work with vduse.
We clearly want device to get back to its original state.
How is that supposed to be achieved?

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
