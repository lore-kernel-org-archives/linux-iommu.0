Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F79FC11F64
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 06:50:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13B16147D
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 06:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13B16147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC09360643;
	Thu,  1 Jul 2021 06:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8R-bX9c2TfPP; Thu,  1 Jul 2021 06:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD7EA60627;
	Thu,  1 Jul 2021 06:50:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F286C0010;
	Thu,  1 Jul 2021 06:50:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8D20C0010
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 06:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E46384039F
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 06:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YpYY67sfpSLr for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:50:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8561A401DF
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 06:50:16 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id c17so8564807ejk.13
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 23:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j02ToljqO7cRBUGAX2kOb5odUf1+MulKZRF56vB9XJw=;
 b=szPt3yjQkK/eOHnZmjZxK4k+ezfPy7N6CPhm+x7EICOpDhKGVX0SiYPkZ71JWWvZoa
 8pTmz5fIarGaEdAOZPXlqb3Ft+IEB/7WrLziKTUMgfJwbxqKu7WpgOrDt2jDUDrJtIWr
 cbeLlyv90jBAQgkaG5PcPMpKIESF32ydtpd5t9BVRkR/UxOzB7/03fJbEeEofSeS0xm4
 nBRhtXHTm/IybqaRL0yZyrTa8PU3gB2gMQ79/soCsEBZSt5m98thaMV4L8/9brwhRN7o
 B363iYyE78ClSv8CfWaatXdNXexk42WbsmRlR9FUB8yp+pkqine3MzByepxq/Xp9WTk6
 QDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j02ToljqO7cRBUGAX2kOb5odUf1+MulKZRF56vB9XJw=;
 b=f0ek0ea9Axo1vJEa12f9J9VzDOTZg5YFyR6+8ifwa1nHmyl4/OgcKNOpbv+OblL0Zx
 FWLosJi3YWUV2xmu0ODgpK8ndLb8lX5/mmCl/LhMvIrSTJwouK/k7LTF+ZtMm0vZtLyR
 GAwPv4r49ITB87PM+58GAZ7GPrcYO8hk8CKRHzd/od0t/K21Vr37ddpOR+XKJFyrMvPA
 rbmnRfUdgKZlOwFfFpzMgbi2CjzGLmZ6W5bfzcDSuC5D1hbM2uu3bNsl3CdLTk9aBqFc
 9NvN7bOI7/bGZo4o6ZyVi7uRP7Bkpm7ebVonPzMbQjdliPbs/vyiJfA0QHAijPxJ88mO
 mw2A==
X-Gm-Message-State: AOAM532GKd4lfkjkEEY1S7p/Swe3g7yHOqJJfBHrTTahIiAgklpmXjjG
 +ahfdxddC+P6Ydy7gJpg8HOdPnIfG1zVytLNHTBQ
X-Google-Smtp-Source: ABdhPJw5rO5qehXjBGvgudrN3VY1PB04pXHwf1f+BSEDIJShRRuy3gy/c2hvero6OzD/zDnU0PCg34TMpYMSKS1otIo=
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr39880031ejc.1.1625122214373; 
 Wed, 30 Jun 2021 23:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
 <CACycT3vaXQ4dxC9QUzXXJs7og6TVqqVGa8uHZnTStacsYAiFwQ@mail.gmail.com>
 <YNw+q/ADMPviZi6S@stefanha-x1.localdomain>
In-Reply-To: <YNw+q/ADMPviZi6S@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 1 Jul 2021 14:50:03 +0800
Message-ID: <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
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

On Wed, Jun 30, 2021 at 5:51 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Jun 29, 2021 at 10:59:51AM +0800, Yongji Xie wrote:
> > On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Tue, Jun 15, 2021 at 10:13:30PM +0800, Xie Yongji wrote:
> > > > +/* ioctls */
> > > > +
> > > > +struct vduse_dev_config {
> > > > +     char name[VDUSE_NAME_MAX]; /* vduse device name */
> > > > +     __u32 vendor_id; /* virtio vendor id */
> > > > +     __u32 device_id; /* virtio device id */
> > > > +     __u64 features; /* device features */
> > > > +     __u64 bounce_size; /* bounce buffer size for iommu */
> > > > +     __u16 vq_size_max; /* the max size of virtqueue */
> > >
> > > The VIRTIO specification allows per-virtqueue sizes. A device can have
> > > two virtqueues, where the first one allows up to 1024 descriptors and
> > > the second one allows only 128 descriptors, for example.
> > >
> >
> > Good point! But it looks like virtio-vdpa/virtio-pci doesn't support
> > that now. All virtqueues have the same maximum size.
>
> I see struct vpda_config_ops only supports a per-device max vq size:
> u16 (*get_vq_num_max)(struct vdpa_device *vdev);
>
> virtio-pci supports per-virtqueue sizes because the struct
> virtio_pci_common_cfg->queue_size register is per-queue (controlled by
> queue_select).
>

Oh, yes. I miss queue_select.

> I guess this is a question for Jason: will vdpa will keep this limitation?
> If yes, then VDUSE can stick to it too without running into problems in
> the future.
>
> > > > +     __u16 padding; /* padding */
> > > > +     __u32 vq_num; /* the number of virtqueues */
> > > > +     __u32 vq_align; /* the allocation alignment of virtqueue's metadata */
> > >
> > > I'm not sure what this is?
> > >
> >
> >  This will be used by vring_create_virtqueue() too.
>
> If there is no official definition for the meaning of this value then
> "/* same as vring_create_virtqueue()'s vring_align parameter */" would
> be clearer. That way the reader knows what to research in order to
> understand how this field works.
>

OK.

> I don't remember but maybe it was used to support vrings when the
> host/guest have non-4KB page sizes. I wonder if anyone has an official
> definition for this value?

Not sure. Maybe we might need some alignment which is less than
PAGE_SIZE sometimes.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
