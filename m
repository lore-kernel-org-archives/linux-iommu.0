Return-Path: <SRS0=1ePL=L4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED7EC07E9B
	for <iommu@archiver.kernel.org>; Sun,  4 Jul 2021 09:49:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CB461410
	for <iommu@archiver.kernel.org>; Sun,  4 Jul 2021 09:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CB461410
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16635402C0;
	Sun,  4 Jul 2021 09:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tWlOD1UPiKJX; Sun,  4 Jul 2021 09:49:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BB7A140001;
	Sun,  4 Jul 2021 09:49:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F931C001A;
	Sun,  4 Jul 2021 09:49:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 938D5C000E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 09:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7481D4029B
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 09:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhpqZ2Cdsl1q for <iommu@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 09:49:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69C9640001
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 09:49:28 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id gn32so24276754ejc.2
 for <iommu@lists.linux-foundation.org>; Sun, 04 Jul 2021 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qzAkMSP1FVlaF7igte07rNyxkup5fEZ5Kcb9vm7Jix8=;
 b=SMZguhe0gCeK+K4fpWOBc4ZZOnMdsFi7GKjeWwau3BD+++plq8ypU2RwuzRKIlFwVo
 EGstmcx5t98kTfUG9bhwv7ljPdHJ1Ls/qe95Asrjrtk1uCd4NQCBIIh0EKmHqhRoEYol
 hldjt8N2LAzTyoYWQYZ2JlXUJXARXI1msbzhZKzCTFr69fWdoeJSsY/Sjn4i8pXkFpIo
 YjRAzIAXBf6AhnVeSqz4sTXfeQB3jlvLSRpBgcbieZielxBSuw+ikxw+y8aApqvhW7Pn
 QNM7ylmDgZqeNb+fgsjdZgKC1v3EleI+8SmZhbsCtEMJIhKligBSReCYfqRjdsfmjyH1
 YajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qzAkMSP1FVlaF7igte07rNyxkup5fEZ5Kcb9vm7Jix8=;
 b=hNsImZgZOB8nqGbXjK3tvL8IK3sexK/6JmphiR5+UhAUunQImr8SbYLmMdpPbNup79
 Y/Q3T9aXnWxCLBvtwFSF17adJpo7eL1MkgRa5txAJ1n3pGTb2Qhc8oYIDVnlWwJ0r+tt
 RO/B/0s55q6v0nRYUMUxbUgW5BjrSsmO+uY9JWzS+PRI5gj8xJOqrlMXzLAhUewg1VAx
 FAIW3LHgVTxLz8bSl5tK+EsgG7zDJCzBUWAUBWeO8T8QyFofdhIBrBWcB5XWZur8hghS
 +E7R6bhrLWhSgJqGceCgjApDC/EUt6TTcUGwY6flzxeN7IH0d0SWZjY0k+WAEUzr2quw
 Wo9A==
X-Gm-Message-State: AOAM533KojHzdNrbQR6/r0cPVJIq1EZaslDtTztm4c5d+Wi6875ZPj2k
 VMVcLrn5peeoEEyTZsud82xwogXEkmWicXJliQ+N
X-Google-Smtp-Source: ABdhPJxvRtQJIj/yqZPkvbZHD8DNlSHEoDvhzkPyPsAyedq1EVF9bW4cXHVy5LeU0C2sRpYjWJqArcNlZLkm0IT3QiI=
X-Received: by 2002:a17:907:1690:: with SMTP id
 hc16mr8249257ejc.247.1625392166205; 
 Sun, 04 Jul 2021 02:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
In-Reply-To: <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Sun, 4 Jul 2021 17:49:15 +0800
Message-ID: <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v8 10/10] Documentation: Add documentation for
 VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
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

On Thu, Jul 1, 2021 at 9:15 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Jul 01, 2021 at 06:00:48PM +0800, Yongji Xie wrote:
> > On Wed, Jun 30, 2021 at 6:06 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Tue, Jun 29, 2021 at 01:43:11PM +0800, Yongji Xie wrote:
> > > > On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > > On Tue, Jun 15, 2021 at 10:13:31PM +0800, Xie Yongji wrote:
> > > > > > +     static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t *len)
> > > > > > +     {
> > > > > > +             int fd;
> > > > > > +             void *addr;
> > > > > > +             size_t size;
> > > > > > +             struct vduse_iotlb_entry entry;
> > > > > > +
> > > > > > +             entry.start = iova;
> > > > > > +             entry.last = iova + 1;
> > > > >
> > > > > Why +1?
> > > > >
> > > > > I expected the request to include *len so that VDUSE can create a bounce
> > > > > buffer for the full iova range, if necessary.
> > > > >
> > > >
> > > > The function is used to translate iova to va. And the *len is not
> > > > specified by the caller. Instead, it's used to tell the caller the
> > > > length of the contiguous iova region from the specified iova. And the
> > > > ioctl VDUSE_IOTLB_GET_FD will get the file descriptor to the first
> > > > overlapped iova region. So using iova + 1 should be enough here.
> > >
> > > Does the entry.last field have any purpose with VDUSE_IOTLB_GET_FD? I
> > > wonder why userspace needs to assign a value at all if it's always +1.
> > >
> >
> > If we need to get some iova regions in the specified range, we need
> > the entry.last field. For example, we can use [0, ULONG_MAX] to get
> > the first overlapped iova region which might be [4096, 8192]. But in
> > this function, we don't use VDUSE_IOTLB_GET_FD like this. We need to
> > get the iova region including the specified iova.
>
> I see, thanks for explaining!
>
> > > > > > +             return addr + iova - entry.start;
> > > > > > +     }
> > > > > > +
> > > > > > +- VDUSE_DEV_GET_FEATURES: Get the negotiated features
> > > > >
> > > > > Are these VIRTIO feature bits? Please explain how feature negotiation
> > > > > works. There must be a way for userspace to report the device's
> > > > > supported feature bits to the kernel.
> > > > >
> > > >
> > > > Yes, these are VIRTIO feature bits. Userspace will specify the
> > > > device's supported feature bits when creating a new VDUSE device with
> > > > ioctl(VDUSE_CREATE_DEV).
> > >
> > > Can the VDUSE device influence feature bit negotiation? For example, if
> > > the VDUSE virtio-blk device does not implement discard/write-zeroes, how
> > > does QEMU or the guest find out about this?
> > >
> >
> > There is a "features" field in struct vduse_dev_config which is used
> > to do feature negotiation.
>
> This approach is more restrictive than required by the VIRTIO
> specification:
>
>   "The device SHOULD accept any valid subset of features the driver
>   accepts, otherwise it MUST fail to set the FEATURES_OK device status
>   bit when the driver writes it."
>
>   https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-130002
>
> The spec allows a device to reject certain subsets of features. For
> example, if feature B depends on feature A and can only be enabled when
> feature A is also enabled.
>
> From your description I think VDUSE would accept feature B without
> feature A since the device implementation has no opportunity to fail
> negotiation with custom logic.
>

Yes, we discussed it [1] before. So I'd like to re-introduce
SET_STATUS messages so that the userspace can fail feature negotiation
during setting FEATURES_OK status bit.

[1]  https://lkml.org/lkml/2021/6/28/1587

> Ideally VDUSE would send a SET_FEATURES message to userspace, allowing
> the device implementation full flexibility in which subsets of features
> to accept.
>
> This is a corner case. Many or maybe even all existing VIRTIO devices
> don't need this flexibility, but I want to point out this limitation in
> the VDUSE interface because it may cause issues in the future.
>
> > > > > > +- VDUSE_DEV_UPDATE_CONFIG: Update the configuration space and inject a config interrupt
> > > > >
> > > > > Does this mean the contents of the configuration space are cached by
> > > > > VDUSE?
> > > >
> > > > Yes, but the kernel will also store the same contents.
> > > >
> > > > > The downside is that the userspace code cannot generate the
> > > > > contents on demand. Most devices doin't need to generate the contents
> > > > > on demand, so I think this is okay but I had expected a different
> > > > > interface:
> > > > >
> > > > > kernel->userspace VDUSE_DEV_GET_CONFIG
> > > > > userspace->kernel VDUSE_DEV_INJECT_CONFIG_IRQ
> > > > >
> > > >
> > > > The problem is how to handle the failure of VDUSE_DEV_GET_CONFIG. We
> > > > will need lots of modification of virtio codes to support that. So to
> > > > make it simple, we choose this way:
> > > >
> > > > userspace -> kernel VDUSE_DEV_SET_CONFIG
> > > > userspace -> kernel VDUSE_DEV_INJECT_CONFIG_IRQ
> > > >
> > > > > I think you can leave it the way it is, but I wanted to mention this in
> > > > > case someone thinks it's important to support generating the contents of
> > > > > the configuration space on demand.
> > > > >
> > > >
> > > > Sorry, I didn't get you here. Can't VDUSE_DEV_SET_CONFIG and
> > > > VDUSE_DEV_INJECT_CONFIG_IRQ achieve that?
> > >
> > > If the contents of the configuration space change continuously, then the
> > > VDUSE_DEV_SET_CONFIG approach is inefficient and might have race
> > > conditions. For example, imagine a device where the driver can read a
> > > timer from the configuration space. I think the VIRTIO device model
> > > allows that although I'm not aware of any devices that do something like
> > > it today. The problem is that VDUSE_DEV_SET_CONFIG would have to be
> > > called frequently to keep the timer value updated even though the guest
> > > driver probably isn't accessing it.
> > >
> >
> > OK, I get you now. Since the VIRTIO specification says "Device
> > configuration space is generally used for rarely-changing or
> > initialization-time parameters". I assume the VDUSE_DEV_SET_CONFIG
> > ioctl should not be called frequently.
>
> The spec uses MUST and other terms to define the precise requirements.
> Here the language (especially the word "generally") is weaker and means
> there may be exceptions.
>
> Another type of access that doesn't work with the VDUSE_DEV_SET_CONFIG
> approach is reads that have side-effects. For example, imagine a field
> containing an error code if the device encounters a problem unrelated to
> a specific virtqueue request. Reading from this field resets the error
> code to 0, saving the driver an extra configuration space write access
> and possibly race conditions. It isn't possible to implement those
> semantics suing VDUSE_DEV_SET_CONFIG. It's another corner case, but it
> makes me think that the interface does not allow full VIRTIO semantics.
>

Agreed. I will use VDUSE_DEV_GET_CONFIG in the next version. And to
handle the message failure, I'm going to add a return value to
virtio_config_ops.get() and virtio_cread_* API so that the error can
be propagated to the virtio device driver. Then the virtio-blk device
driver can be modified to handle that.

Jason and Stefan, what do you think of this way?

> > > What's worse is that there might be race conditions where other
> > > driver->device operations are supposed to update the configuration space
> > > but VDUSE_DEV_SET_CONFIG means that the VDUSE kernel code is caching an
> > > outdated copy.
> > >
> >
> > I'm not sure. Should the device and driver be able to access the same
> > fields concurrently?
>
> Yes. The VIRTIO spec has a generation count to handle multi-field
> accesses so that consistency can be ensured:
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-180004
>

I see.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
