Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A15DC4332F
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 13:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE592405FA;
	Mon, 10 Jan 2022 13:54:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zRoQ1e5dHnbX; Mon, 10 Jan 2022 13:54:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F0B3404B9;
	Mon, 10 Jan 2022 13:54:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42F9DC002F;
	Mon, 10 Jan 2022 13:54:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A61C001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 13:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC456405F9
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 13:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AeMnOE-EcjLv for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 13:54:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17957405F2
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 13:54:20 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id m4so12375842edb.10
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=djPW+e1c8spfYeyL5AbJ32h9GSIUYbKoLv2DLHaOq+0=;
 b=bl9J2QtWDuUmQlp5N7WmOsJhVeMPiTX+NiVRwh9l87FNYClRzAhBufVdMy0MCqtNFV
 dq4421mAxg0ILI2S2MCCP1ns1H4QhlZT4aWwoBhR0cZUmunXHRx+d+HuOX/d5PKXrzPG
 TK+4Hu5xgpHlwxKj6pUbOw6pX2/G4EJ8DfXnXNMUesmDYorizgDzkPnVKpRJhctC8sUZ
 B2ri5NpHRwtPw2fRocdZhxoBuaBCKzAjfaykJZay8LbVDX930o0CDQ/LHWyda4xFV+Hc
 WugS89G4jBlr4VL2uypPxdIO8AzpqLxqh+es+3YLGWyAingktkoxMNPCyXb/hyfzuCo6
 mj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=djPW+e1c8spfYeyL5AbJ32h9GSIUYbKoLv2DLHaOq+0=;
 b=Z7v9WTkwgbxM3Yrb1ePNLIl74ZYO9PrNW/7eTHtaLcag8eigWOBq3BskemfORMowfV
 bA07e7fTq+sW8fnC080iBGIys6MLCAFd1v+vwjD+FK5OnQVksMCDY+zeCknehH4yHK68
 1ttsmguih+w8DloF8+fsHIIACrAv65lNcDseS3AJff2fEJp3SOarfNbDBnO1rKoL+HYQ
 AAYn2pJORMSzzdrFYyr+5fSK00mgFoi8D18iMlivBAB3LMTBgkr03sxGLbWt62/NXqcQ
 SH4YVB4QRZj+Ah+mR/+GVEqCvEtuN4rNNum7yYBtrq1aa8K9UbnjndQaKUZ+EKc1BX9R
 +m0w==
X-Gm-Message-State: AOAM530SjycwjAxT8HjcEfeO8CZw9BOHrCRIgSqVfmNKn11jDF+mJrr5
 FP+zaik8A8gsHeQyg/snTHVAkwJ/tOmggyirImqb
X-Google-Smtp-Source: ABdhPJyFGnfUMGEnoNxRXvUJpCvABNYtlKdS/8DhFo1CC6qDSFOT+cL5Hg32zlVk43P8LVymiEdjB1533Wdjtj+EyFw=
X-Received: by 2002:a05:6402:cbb:: with SMTP id
 cn27mr5089054edb.246.1641822858820; 
 Mon, 10 Jan 2022 05:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20220110075546-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220110075546-mutt-send-email-mst@kernel.org>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 10 Jan 2022 21:54:08 +0800
Message-ID: <CACycT3v1aEViw7vV4x5qeGVPrSrO-BTDvQshEX35rx_X0Au2vw@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] Introduce VDUSE - vDPA Device in Userspace
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
 bcrl@kvack.org, Netdev <netdev@vger.kernel.org>, Joe Perches <joe@perches.com>,
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

On Mon, Jan 10, 2022 at 8:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 30, 2021 at 10:17:24PM +0800, Xie Yongji wrote:
> > This series introduces a framework that makes it possible to implement
> > software-emulated vDPA devices in userspace. And to make the device
> > emulation more secure, the emulated vDPA device's control path is handled
> > in the kernel and only the data path is implemented in the userspace.
> >
> > Since the emuldated vDPA device's control path is handled in the kernel,
> > a message mechnism is introduced to make userspace be aware of the data
> > path related changes. Userspace can use read()/write() to receive/reply
> > the control messages.
> >
> > In the data path, the core is mapping dma buffer into VDUSE daemon's
> > address space, which can be implemented in different ways depending on
> > the vdpa bus to which the vDPA device is attached.
> >
> > In virtio-vdpa case, we implements a MMU-based software IOTLB with
> > bounce-buffering mechanism to achieve that. And in vhost-vdpa case, the dma
> > buffer is reside in a userspace memory region which can be shared to the
> > VDUSE userspace processs via transferring the shmfd.
> >
> > The details and our user case is shown below:
> >
> > ------------------------    -------------------------   ----------------------------------------------
> > |            Container |    |              QEMU(VM) |   |                               VDUSE daemon |
> > |       ---------      |    |  -------------------  |   | ------------------------- ---------------- |
> > |       |dev/vdx|      |    |  |/dev/vhost-vdpa-x|  |   | | vDPA device emulation | | block driver | |
> > ------------+-----------     -----------+------------   -------------+----------------------+---------
> >             |                           |                            |                      |
> >             |                           |                            |                      |
> > ------------+---------------------------+----------------------------+----------------------+---------
> > |    | block device |           |  vhost device |            | vduse driver |          | TCP/IP |    |
> > |    -------+--------           --------+--------            -------+--------          -----+----    |
> > |           |                           |                           |                       |        |
> > | ----------+----------       ----------+-----------         -------+-------                |        |
> > | | virtio-blk driver |       |  vhost-vdpa driver |         | vdpa device |                |        |
> > | ----------+----------       ----------+-----------         -------+-------                |        |
> > |           |      virtio bus           |                           |                       |        |
> > |   --------+----+-----------           |                           |                       |        |
> > |                |                      |                           |                       |        |
> > |      ----------+----------            |                           |                       |        |
> > |      | virtio-blk device |            |                           |                       |        |
> > |      ----------+----------            |                           |                       |        |
> > |                |                      |                           |                       |        |
> > |     -----------+-----------           |                           |                       |        |
> > |     |  virtio-vdpa driver |           |                           |                       |        |
> > |     -----------+-----------           |                           |                       |        |
> > |                |                      |                           |    vdpa bus           |        |
> > |     -----------+----------------------+---------------------------+------------           |        |
> > |                                                                                        ---+---     |
> > -----------------------------------------------------------------------------------------| NIC |------
> >                                                                                          ---+---
> >                                                                                             |
> >                                                                                    ---------+---------
> >                                                                                    | Remote Storages |
> >                                                                                    -------------------
> >
> > We make use of it to implement a block device connecting to
> > our distributed storage, which can be used both in containers and
> > VMs. Thus, we can have an unified technology stack in this two cases.
> >
> > To test it with null-blk:
> >
> >   $ qemu-storage-daemon \
> >       --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
> >       --monitor chardev=charmonitor \
> >       --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
> >       --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128
> >
> > The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse
>
> It's been half a year - any plans to upstream this?

Yeah, this is on my to-do list this month.

Sorry for taking so long... I've been working on another project
enabling userspace RDMA with VDUSE for the past few months. So I
didn't have much time for this. Anyway, I will submit the first
version as soon as possible.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
