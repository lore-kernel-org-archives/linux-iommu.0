Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D076C11F65
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD37A61D05
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD37A61D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59DD660793;
	Tue, 29 Jun 2021 03:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oiIxKzHv2tEn; Tue, 29 Jun 2021 03:00:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4BA6D60789;
	Tue, 29 Jun 2021 03:00:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A7BC001A;
	Tue, 29 Jun 2021 03:00:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D3DC001A
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 870E440276
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pZIZCIwoY68z for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:00:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04F28400A8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:00:04 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id l24so971766edr.11
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 20:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tC8+eycXVZtpiOsN/AMjjNqu/G/aFD3wjzDfuO22bFA=;
 b=bh0RUiARewsKN3Hk1A5XuOHjErIfF3IJybc5hLJYfbWfR4avSK5I7hdl76VNLcFu7q
 8088kCiIqV50Zrxug6TOBHKzv4OP9W7BbMhVTNhAk6ocCnWhAIqqnTT10FM8YaafrMCS
 fobCNy4GG347XSHq5u7Sf803O0qFzJMLrz+vnGfYFFr/klFuR3RPi3Iak6Rw9TnxzkvS
 jm4cY1IhMqRmgfKwUNeapZTIbX9ZLISiGEUmAI75ltfyEpKq4cYArVE4ODOc/u0hrevV
 InesZfRLmS4f95S2/JcbikR32ocp9dRZ0Fyc+5Csa59s/feSzPNRPU4jOKrG7kq+cB/e
 t+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tC8+eycXVZtpiOsN/AMjjNqu/G/aFD3wjzDfuO22bFA=;
 b=InWWjfgoWi3zEGAt8T0N9uMJnH6E3E7Kb2kzH/mdLqzS3viGUVfF8bjM1rCyMF6nzP
 STP4K3ypO6j2O1v92RFLWEZcHg++hf/7pHE30uJxJIq633KXEzGEnOkTtjgGJlhZq67l
 idT7ET9wYM6e14BzHzo/nS91kD6ClGlA7A+UK1Otk/fvNk/x/zmmcNB2xHXXWCP+Au0C
 TyjQU9ZY77lRCB8NnwoNvzek0m0PACc4ZepXJcGL326OR45XVHdS3J0ab0i7EN3anNtq
 H+WzfpqUaNkq90xyBzu4icYyvhd3OXVD/BYDqca7QYzDy61r7f6LOxKyA9sppj7Ec48j
 16qA==
X-Gm-Message-State: AOAM531vZhv44+Typpc2cj+oeR3FhiRdUB2ykNGq24kmmhtHBuXiYL2r
 iF0V73BQ6XNipQrGjG43p3JI1eHih6Il5Rov11BN
X-Google-Smtp-Source: ABdhPJzg96tWiFpzAbCVxt+xiS/U5xotludj60TImfwJQUK2KdEwY2E/dV2mAC5D/i1Omtd+LCI76RG3K5V1lZFzRC8=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr36653348edu.253.1624935602535; 
 Mon, 28 Jun 2021 20:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
In-Reply-To: <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 10:59:51 +0800
Message-ID: <CACycT3vaXQ4dxC9QUzXXJs7og6TVqqVGa8uHZnTStacsYAiFwQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
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

On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 10:13:30PM +0800, Xie Yongji wrote:
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > new file mode 100644
> > index 000000000000..f21b2e51b5c8
> > --- /dev/null
> > +++ b/include/uapi/linux/vduse.h
> > @@ -0,0 +1,143 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_VDUSE_H_
> > +#define _UAPI_VDUSE_H_
> > +
> > +#include <linux/types.h>
> > +
> > +#define VDUSE_API_VERSION    0
> > +
> > +#define VDUSE_NAME_MAX       256
> > +
> > +/* the control messages definition for read/write */
> > +
> > +enum vduse_req_type {
> > +     /* Get the state for virtqueue from userspace */
> > +     VDUSE_GET_VQ_STATE,
> > +     /* Notify userspace to start the dataplane, no reply */
> > +     VDUSE_START_DATAPLANE,
> > +     /* Notify userspace to stop the dataplane, no reply */
> > +     VDUSE_STOP_DATAPLANE,
> > +     /* Notify userspace to update the memory mapping in device IOTLB */
> > +     VDUSE_UPDATE_IOTLB,
> > +};
> > +
> > +struct vduse_vq_state {
> > +     __u32 index; /* virtqueue index */
> > +     __u32 avail_idx; /* virtqueue state (last_avail_idx) */
> > +};
> > +
> > +struct vduse_iova_range {
> > +     __u64 start; /* start of the IOVA range */
> > +     __u64 last; /* end of the IOVA range */
>
> Please clarify whether this describes a closed range [start, last] or an
> open range [start, last).
>

OK.

> > +};
> > +
> > +struct vduse_dev_request {
> > +     __u32 type; /* request type */
> > +     __u32 request_id; /* request id */
> > +#define VDUSE_REQ_FLAGS_NO_REPLY     (1 << 0) /* No need to reply */
> > +     __u32 flags; /* request flags */
> > +     __u32 reserved; /* for future use */
> > +     union {
> > +             struct vduse_vq_state vq_state; /* virtqueue state */
> > +             struct vduse_iova_range iova; /* iova range for updating */
> > +             __u32 padding[16]; /* padding */
> > +     };
> > +};
> > +
> > +struct vduse_dev_response {
> > +     __u32 request_id; /* corresponding request id */
> > +#define VDUSE_REQ_RESULT_OK  0x00
> > +#define VDUSE_REQ_RESULT_FAILED      0x01
> > +     __u32 result; /* the result of request */
> > +     __u32 reserved[2]; /* for future use */
> > +     union {
> > +             struct vduse_vq_state vq_state; /* virtqueue state */
> > +             __u32 padding[16]; /* padding */
> > +     };
> > +};
> > +
> > +/* ioctls */
> > +
> > +struct vduse_dev_config {
> > +     char name[VDUSE_NAME_MAX]; /* vduse device name */
> > +     __u32 vendor_id; /* virtio vendor id */
> > +     __u32 device_id; /* virtio device id */
> > +     __u64 features; /* device features */
> > +     __u64 bounce_size; /* bounce buffer size for iommu */
> > +     __u16 vq_size_max; /* the max size of virtqueue */
>
> The VIRTIO specification allows per-virtqueue sizes. A device can have
> two virtqueues, where the first one allows up to 1024 descriptors and
> the second one allows only 128 descriptors, for example.
>

Good point! But it looks like virtio-vdpa/virtio-pci doesn't support
that now. All virtqueues have the same maximum size.

> This constant seems to impose the constraint that all virtqueues have
> the same maximum size. Is this really necessary?
>

This will be used by vring_create_virtqueue(). We need to specify the
maximum queue size supported by the device.

> > +     __u16 padding; /* padding */
> > +     __u32 vq_num; /* the number of virtqueues */
> > +     __u32 vq_align; /* the allocation alignment of virtqueue's metadata */
>
> I'm not sure what this is?
>

 This will be used by vring_create_virtqueue() too.

> > +     __u32 config_size; /* the size of the configuration space */
> > +     __u32 reserved[15]; /* for future use */
> > +     __u8 config[0]; /* the buffer of the configuration space */
> > +};
> > +
> > +struct vduse_iotlb_entry {
> > +     __u64 offset; /* the mmap offset on fd */
> > +     __u64 start; /* start of the IOVA range */
> > +     __u64 last; /* last of the IOVA range */
>
> Same here, please specify whether this is an open range or a closed
> range.
>

Sure.

> > +#define VDUSE_ACCESS_RO 0x1
> > +#define VDUSE_ACCESS_WO 0x2
> > +#define VDUSE_ACCESS_RW 0x3
> > +     __u8 perm; /* access permission of this range */
> > +};
> > +
> > +struct vduse_config_update {
> > +     __u32 offset; /* offset from the beginning of configuration space */
> > +     __u32 length; /* the length to write to configuration space */
> > +     __u8 buffer[0]; /* buffer used to write from */
> > +};
> > +
> > +struct vduse_vq_info {
> > +     __u32 index; /* virtqueue index */
> > +     __u32 avail_idx; /* virtqueue state (last_avail_idx) */
> > +     __u64 desc_addr; /* address of desc area */
> > +     __u64 driver_addr; /* address of driver area */
> > +     __u64 device_addr; /* address of device area */
> > +     __u32 num; /* the size of virtqueue */
> > +     __u8 ready; /* ready status of virtqueue */
> > +};
> > +
> > +struct vduse_vq_eventfd {
> > +     __u32 index; /* virtqueue index */
> > +#define VDUSE_EVENTFD_DEASSIGN -1
> > +     int fd; /* eventfd, -1 means de-assigning the eventfd */
> > +};
> > +
> > +#define VDUSE_BASE   0x81
> > +
> > +/* Get the version of VDUSE API. This is used for future extension */
> > +#define VDUSE_GET_API_VERSION        _IOR(VDUSE_BASE, 0x00, __u64)
> > +
> > +/* Set the version of VDUSE API. */
> > +#define VDUSE_SET_API_VERSION        _IOW(VDUSE_BASE, 0x01, __u64)
> > +
> > +/* Create a vduse device which is represented by a char device (/dev/vduse/<name>) */
> > +#define VDUSE_CREATE_DEV     _IOW(VDUSE_BASE, 0x02, struct vduse_dev_config)
> > +
> > +/* Destroy a vduse device. Make sure there are no references to the char device */
> > +#define VDUSE_DESTROY_DEV    _IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
> > +
> > +/*
> > + * Get a file descriptor for the first overlapped iova region,
> > + * -EINVAL means the iova region doesn't exist.
> > + */
> > +#define VDUSE_IOTLB_GET_FD   _IOWR(VDUSE_BASE, 0x04, struct vduse_iotlb_entry)
> > +
> > +/* Get the negotiated features */
> > +#define VDUSE_DEV_GET_FEATURES       _IOR(VDUSE_BASE, 0x05, __u64)
> > +
> > +/* Update the configuration space */
> > +#define VDUSE_DEV_UPDATE_CONFIG      _IOW(VDUSE_BASE, 0x06, struct vduse_config_update)
> > +
> > +/* Get the specified virtqueue's information */
> > +#define VDUSE_VQ_GET_INFO    _IOWR(VDUSE_BASE, 0x07, struct vduse_vq_info)
> > +
> > +/* Setup an eventfd to receive kick for virtqueue */
> > +#define VDUSE_VQ_SETUP_KICKFD        _IOW(VDUSE_BASE, 0x08, struct vduse_vq_eventfd)
> > +
> > +/* Inject an interrupt for specific virtqueue */
> > +#define VDUSE_VQ_INJECT_IRQ  _IOW(VDUSE_BASE, 0x09, __u32)
>
> There is not enough documentation to use this header file. For example,
> which ioctls are used with /dev/vduse and which are used with
> /dev/vduse/<name>?
>
> Please document that ioctl API fully. It will not only help userspace
> developers but also define what is part of the interface and what is an
> implementation detail that can change in the future.

OK, I will try to add more details.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
