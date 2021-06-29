Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD4C11F68
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 05:43:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B747F61DC5
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 05:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B747F61DC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77A57833AF;
	Tue, 29 Jun 2021 05:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id crOqiPW9Uooh; Tue, 29 Jun 2021 05:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B65482FE7;
	Tue, 29 Jun 2021 05:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DADA5C0010;
	Tue, 29 Jun 2021 05:43:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27940C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 05:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14BF082FF9
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 05:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYoMk8eMnFS4 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 05:43:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7167982FE7
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 05:43:24 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id o5so9169185ejy.7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xrRIpRDMYCUuT0N0nNIsJAiVOtwEfWYTgjznAQmmJS4=;
 b=zt+lQ72MfdZKLD/3wmTWnyWnfinGHARJvCXzW/1j5X5loBw/AZilf2bArM91E1pEc6
 nu02CLwJ2Bgicv9Js08Q+qJwrx6Lnb57MVpml4D03kMn1p8Gus9nawMWipqIAWChe6Cb
 shCLxFQH6FZzK8Ue9dD3o/tqFGT0M0akJdImfYEmKefhQUwDm3gonC0mhAAhBqekvdJC
 vsi7qD3kA/DBKAPwtMSkBcr07EtFTVsNPpofmP+LoRSUL9q7kq5geQ6NC5iN+OA8QFjQ
 t6IA0nyY7nP6z8J8yEg/30Q3BGkEQ47rvi2Y61UTiDLAlxNQj+5RwsipSh2DVkHeRk2R
 h+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xrRIpRDMYCUuT0N0nNIsJAiVOtwEfWYTgjznAQmmJS4=;
 b=RfvdiDsjUo61P+isgTQaay2UNyYwO1/I7sKJWgvydjtzgJSSNHsnHMnluxzwRuEbVI
 CxfLNlp3mmkpJ3Eupsz1BrTlCP28GsCd+N2gatkvg27bCWzJPaoupwWCt7P5RIwZxpfz
 HfvNVzuQ4/aJ8IgEMaYU7XxT10b6bc+BfJHHN+4jYqwaQ57h/WnyCYyd6XAX+K27P+6u
 32eNO2+/qf3Be0BwPtCwePFSMnORNirS4UX/5lX2S8z3CY1d0N/Xu0ld793GTCoJwxnG
 adeynWW/+0Ph9G6T7zF/ea79qu32Z7gtyE6Wz/H15DJpIG8gEG4FYXhH0/UesYSoZ2Ax
 WnWQ==
X-Gm-Message-State: AOAM530luJPiIqfy2sHys+RBGQsraO0cJU6sF+iNpHp2YKdP38hTvsHr
 D5nYGnW5puOHFzdbw4mMA5vIqmSROuAjLT+WVh+r
X-Google-Smtp-Source: ABdhPJznY7JybRnyMOh3MFPA6NLlIedQGO9ql6pXFq4VoDrTgHJmjFcBCVMzahKj2en5XHaS1+eg82lK0YHgoHdqdic=
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr28378543ejc.1.1624945402507; 
 Mon, 28 Jun 2021 22:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
In-Reply-To: <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 13:43:11 +0800
Message-ID: <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
Subject: Re: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
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
> On Tue, Jun 15, 2021 at 10:13:31PM +0800, Xie Yongji wrote:
> > VDUSE (vDPA Device in Userspace) is a framework to support
> > implementing software-emulated vDPA devices in userspace. This
> > document is intended to clarify the VDUSE design and usage.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  Documentation/userspace-api/index.rst |   1 +
> >  Documentation/userspace-api/vduse.rst | 222 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 223 insertions(+)
> >  create mode 100644 Documentation/userspace-api/vduse.rst
> >
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> > index 0b5eefed027e..c432be070f67 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -27,6 +27,7 @@ place where this information is gathered.
> >     iommu
> >     media/index
> >     sysfs-platform_profile
> > +   vduse
> >
> >  .. only::  subproject and html
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> > new file mode 100644
> > index 000000000000..2f9cd1a4e530
> > --- /dev/null
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -0,0 +1,222 @@
> > +==================================
> > +VDUSE - "vDPA Device in Userspace"
> > +==================================
> > +
> > +vDPA (virtio data path acceleration) device is a device that uses a
> > +datapath which complies with the virtio specifications with vendor
> > +specific control path. vDPA devices can be both physically located on
> > +the hardware or emulated by software. VDUSE is a framework that makes it
> > +possible to implement software-emulated vDPA devices in userspace. And
> > +to make it simple, the emulated vDPA device's control path is handled in
> > +the kernel and only the data path is implemented in the userspace.
> > +
> > +Note that only virtio block device is supported by VDUSE framework now,
> > +which can reduce security risks when the userspace process that implements
> > +the data path is run by an unprivileged user. The Support for other device
> > +types can be added after the security issue is clarified or fixed in the future.
> > +
> > +Start/Stop VDUSE devices
> > +------------------------
> > +
> > +VDUSE devices are started as follows:
> > +
> > +1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +   /dev/vduse/control.
> > +
> > +2. Begin processing VDUSE messages from /dev/vduse/$NAME. The first
> > +   messages will arrive while attaching the VDUSE instance to vDPA bus.
> > +
> > +3. Send the VDPA_CMD_DEV_NEW netlink message to attach the VDUSE
> > +   instance to vDPA bus.
> > +
> > +VDUSE devices are stopped as follows:
> > +
> > +1. Send the VDPA_CMD_DEV_DEL netlink message to detach the VDUSE
> > +   instance from vDPA bus.
> > +
> > +2. Close the file descriptor referring to /dev/vduse/$NAME
> > +
> > +3. Destroy the VDUSE instance with ioctl(VDUSE_DESTROY_DEV) on
> > +   /dev/vduse/control
> > +
> > +The netlink messages metioned above can be sent via vdpa tool in iproute2
> > +or use the below sample codes:
> > +
> > +.. code-block:: c
> > +
> > +     static int netlink_add_vduse(const char *name, enum vdpa_command cmd)
> > +     {
> > +             struct nl_sock *nlsock;
> > +             struct nl_msg *msg;
> > +             int famid;
> > +
> > +             nlsock = nl_socket_alloc();
> > +             if (!nlsock)
> > +                     return -ENOMEM;
> > +
> > +             if (genl_connect(nlsock))
> > +                     goto free_sock;
> > +
> > +             famid = genl_ctrl_resolve(nlsock, VDPA_GENL_NAME);
> > +             if (famid < 0)
> > +                     goto close_sock;
> > +
> > +             msg = nlmsg_alloc();
> > +             if (!msg)
> > +                     goto close_sock;
> > +
> > +             if (!genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, famid, 0, 0, cmd, 0))
> > +                     goto nla_put_failure;
> > +
> > +             NLA_PUT_STRING(msg, VDPA_ATTR_DEV_NAME, name);
> > +             if (cmd == VDPA_CMD_DEV_NEW)
> > +                     NLA_PUT_STRING(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse");
> > +
> > +             if (nl_send_sync(nlsock, msg))
> > +                     goto close_sock;
> > +
> > +             nl_close(nlsock);
> > +             nl_socket_free(nlsock);
> > +
> > +             return 0;
> > +     nla_put_failure:
> > +             nlmsg_free(msg);
> > +     close_sock:
> > +             nl_close(nlsock);
> > +     free_sock:
> > +             nl_socket_free(nlsock);
> > +             return -1;
> > +     }
> > +
> > +How VDUSE works
> > +---------------
> > +
> > +Since the emuldated vDPA device's control path is handled in the kernel,
>
> s/emuldated/emulated/
>

Will fix it.

> > +a message-based communication protocol and few types of control messages
> > +are introduced by VDUSE framework to make userspace be aware of the data
> > +path related changes:
> > +
> > +- VDUSE_GET_VQ_STATE: Get the state for virtqueue from userspace
> > +
> > +- VDUSE_START_DATAPLANE: Notify userspace to start the dataplane
> > +
> > +- VDUSE_STOP_DATAPLANE: Notify userspace to stop the dataplane
> > +
> > +- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping in device IOTLB
> > +
> > +Userspace needs to read()/write() on /dev/vduse/$NAME to receive/reply
> > +those control messages from/to VDUSE kernel module as follows:
> > +
> > +.. code-block:: c
> > +
> > +     static int vduse_message_handler(int dev_fd)
> > +     {
> > +             int len;
> > +             struct vduse_dev_request req;
> > +             struct vduse_dev_response resp;
> > +
> > +             len = read(dev_fd, &req, sizeof(req));
> > +             if (len != sizeof(req))
> > +                     return -1;
> > +
> > +             resp.request_id = req.request_id;
> > +
> > +             switch (req.type) {
> > +
> > +             /* handle different types of message */
> > +
> > +             }
> > +
> > +             if (req.flags & VDUSE_REQ_FLAGS_NO_REPLY)
> > +                     return 0;
> > +
> > +             len = write(dev_fd, &resp, sizeof(resp));
> > +             if (len != sizeof(resp))
> > +                     return -1;
> > +
> > +             return 0;
> > +     }
> > +
> > +After VDUSE_START_DATAPLANE messages is received, userspace should start the
> > +dataplane processing with the help of some ioctls on /dev/vduse/$NAME:
> > +
> > +- VDUSE_IOTLB_GET_FD: get the file descriptor to the first overlapped iova region.
> > +  Userspace can access this iova region by passing fd and corresponding size, offset,
> > +  perm to mmap(). For example:
> > +
> > +.. code-block:: c
> > +
> > +     static int perm_to_prot(uint8_t perm)
> > +     {
> > +             int prot = 0;
> > +
> > +             switch (perm) {
> > +             case VDUSE_ACCESS_WO:
> > +                     prot |= PROT_WRITE;
> > +                     break;
> > +             case VDUSE_ACCESS_RO:
> > +                     prot |= PROT_READ;
> > +                     break;
> > +             case VDUSE_ACCESS_RW:
> > +                     prot |= PROT_READ | PROT_WRITE;
> > +                     break;
> > +             }
> > +
> > +             return prot;
> > +     }
> > +
> > +     static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t *len)
> > +     {
> > +             int fd;
> > +             void *addr;
> > +             size_t size;
> > +             struct vduse_iotlb_entry entry;
> > +
> > +             entry.start = iova;
> > +             entry.last = iova + 1;
>
> Why +1?
>
> I expected the request to include *len so that VDUSE can create a bounce
> buffer for the full iova range, if necessary.
>

The function is used to translate iova to va. And the *len is not
specified by the caller. Instead, it's used to tell the caller the
length of the contiguous iova region from the specified iova. And the
ioctl VDUSE_IOTLB_GET_FD will get the file descriptor to the first
overlapped iova region. So using iova + 1 should be enough here.

> > +             fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD, &entry);
> > +             if (fd < 0)
> > +                     return NULL;
> > +
> > +             size = entry.last - entry.start + 1;
> > +             *len = entry.last - iova + 1;
> > +             addr = mmap(0, size, perm_to_prot(entry.perm), MAP_SHARED,
> > +                         fd, entry.offset);
> > +             close(fd);
> > +             if (addr == MAP_FAILED)
> > +                     return NULL;
> > +
> > +             /* do something to cache this iova region */
>
> How is userspace expected to manage iotlb mmaps? When should munmap(2)
> be called?
>

The simple way is using a list to store the iotlb mappings. And we
should call the munmap(2) for the old mappings when VDUSE_UPDATE_IOTLB
or VDUSE_STOP_DATAPLANE message is received.

> Should userspace expect VDUSE_IOTLB_GET_FD to return a full chunk of
> guest RAM (e.g. multiple gigabytes) that can be cached permanently or
> will it return just enough pages to cover [start, last)?
>

It should return one iotlb mapping that covers [start, last). In
vhost-vdpa cases, it might be a full chunk of guest RAM. In
virtio-vdpa cases, it might be the whole bounce buffer or one coherent
mapping (produced by dma_alloc_coherent()).

> > +
> > +             return addr + iova - entry.start;
> > +     }
> > +
> > +- VDUSE_DEV_GET_FEATURES: Get the negotiated features
>
> Are these VIRTIO feature bits? Please explain how feature negotiation
> works. There must be a way for userspace to report the device's
> supported feature bits to the kernel.
>

Yes, these are VIRTIO feature bits. Userspace will specify the
device's supported feature bits when creating a new VDUSE device with
ioctl(VDUSE_CREATE_DEV).

> > +- VDUSE_DEV_UPDATE_CONFIG: Update the configuration space and inject a config interrupt
>
> Does this mean the contents of the configuration space are cached by
> VDUSE?

Yes, but the kernel will also store the same contents.

> The downside is that the userspace code cannot generate the
> contents on demand. Most devices doin't need to generate the contents
> on demand, so I think this is okay but I had expected a different
> interface:
>
> kernel->userspace VDUSE_DEV_GET_CONFIG
> userspace->kernel VDUSE_DEV_INJECT_CONFIG_IRQ
>

The problem is how to handle the failure of VDUSE_DEV_GET_CONFIG. We
will need lots of modification of virtio codes to support that. So to
make it simple, we choose this way:

userspace -> kernel VDUSE_DEV_SET_CONFIG
userspace -> kernel VDUSE_DEV_INJECT_CONFIG_IRQ

> I think you can leave it the way it is, but I wanted to mention this in
> case someone thinks it's important to support generating the contents of
> the configuration space on demand.
>

Sorry, I didn't get you here. Can't VDUSE_DEV_SET_CONFIG and
VDUSE_DEV_INJECT_CONFIG_IRQ achieve that?

> > +- VDUSE_VQ_GET_INFO: Get the specified virtqueue's metadata
> > +
> > +- VDUSE_VQ_SETUP_KICKFD: set the kickfd for virtqueue, this eventfd is used
> > +  by VDUSE kernel module to notify userspace to consume the vring.
> > +
> > +- VDUSE_INJECT_VQ_IRQ: inject an interrupt for specific virtqueue
>
> This information is useful but it's not enough to be able to implement a
> userspace device. Please provide more developer documentation or at
> least refer to uapi header files, published documents, etc that contain
> the details.

OK, I will try to add more details.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
