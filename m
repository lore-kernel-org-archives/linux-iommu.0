Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BFBC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 07:03:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6384761261
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 07:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6384761261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 182FD60A53;
	Thu, 20 May 2021 07:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h17CVjTd0A0g; Thu, 20 May 2021 07:03:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E86E3607A6;
	Thu, 20 May 2021 07:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8D02C000D;
	Thu, 20 May 2021 07:03:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E14D0C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3B974017E
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id piRV3sf4i8kI for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:03:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97897400AB
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:03:14 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id lg14so23543689ejb.9
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wZuC9MkEtBjxIYtF7kqVL9Ifpq76zVZvowCEWkRzdAs=;
 b=isU1Bu0LYOcmwo2kZ+cxn6aLNagpy/yAVpavSdt0QoSh70Zxzbz5Cbo9vgX0zVM+vf
 tJNWmzAPB2voZMyxrgD0fjafieA+/5wH0Mv8ATKJmh53aalUm9SUQODFqqVPbg+PUdXo
 H9R7EQmWsf3D+ZUsHmp9gvDaJl1QtHo6qQ2vRr8rGBd+2OjYWeVB9bT0M1QVLkN5C8NS
 CmrUJFwCufbKYOtmvdGOBvbocV6hZEeNWi65kA9s7cR0hY6RVWe/Ei7CHfzZxWR5wnd8
 oE71NvDhg8fGP9ZL2M9OYpa+NfrMb0l/lEZ9YFBFN741IDnOTCnHVcEs0BWYU0gIhGb4
 /1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wZuC9MkEtBjxIYtF7kqVL9Ifpq76zVZvowCEWkRzdAs=;
 b=gd/QLdo2xZ8pqNhksfLXNRbafQIbWvC0PSGLVehnxYStAZEVmodJ5KCNpneTw5nrhI
 0nDI0RN44thtZ/0XKiPR9VE/0h98WBiQThXnrwRGU+SaE31WEi0e+NV7oPBrm2gAM0Gg
 D3K6mOKob3vj1LwgYCags0Nb8W3HiMQVCFy/O+j48dezCqKfjseWMT6lBUItPGkXJMKp
 zps0L84mbn75qhBXEtN5OHmBruTeFazmtA4c2AAeUNXmo40AIYcX/ceIQ95JgbfQe3Rl
 eeI6Ayr8lk9c2moLKfPYK2ljy2Fcd9bxNkIYHXfPFGO3C16qpQJ2tid7WZeEjpqS08Uj
 souw==
X-Gm-Message-State: AOAM533PDTTv2fYBx+ym3D0nOP4fLdIrcQC4zkJohEG1qRxObpv+RfjF
 CWJtbFzqx3z1eNwg6/uqoGg08ctLLNuJHYxHIe2l
X-Google-Smtp-Source: ABdhPJxdx8w+fCqswSdKs59iVuZd4vAf9uGIN8nGG/abyN54M6HaotKLEQyMezCx9lo1kEngrpWm4QyOMlEiGHNAl0E=
X-Received: by 2002:a17:906:c211:: with SMTP id
 d17mr3165937ejz.247.1621494192590; 
 Thu, 20 May 2021 00:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <YKYBle/F8aOgHO9p@zeniv-ca.linux.org.uk>
In-Reply-To: <YKYBle/F8aOgHO9p@zeniv-ca.linux.org.uk>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 20 May 2021 15:03:01 +0800
Message-ID: <CACycT3vTvdJN4qnp=O8E5fxR15evMexzsK+V_uFT0LZkRSCitw@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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

On Thu, May 20, 2021 at 2:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:
>
> > +     case VDUSE_IOTLB_GET_FD: {
> > +             struct vduse_iotlb_entry entry;
> > +             struct vhost_iotlb_map *map;
> > +             struct vdpa_map_file *map_file;
> > +             struct vduse_iova_domain *domain = dev->domain;
> > +             struct file *f = NULL;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(&entry, argp, sizeof(entry)))
> > +                     break;
>
>                         return -EFAULT;
> surely?
> > +
> > +             ret = -EINVAL;
> > +             if (entry.start > entry.last)
> > +                     break;
>
> ... and similar here, etc.
>

OK.

> > +             spin_lock(&domain->iotlb_lock);
> > +             map = vhost_iotlb_itree_first(domain->iotlb,
> > +                                           entry.start, entry.last);
> > +             if (map) {
> > +                     map_file = (struct vdpa_map_file *)map->opaque;
> > +                     f = get_file(map_file->file);
> > +                     entry.offset = map_file->offset;
> > +                     entry.start = map->start;
> > +                     entry.last = map->last;
> > +                     entry.perm = map->perm;
> > +             }
> > +             spin_unlock(&domain->iotlb_lock);
> > +             ret = -EINVAL;
> > +             if (!f)
> > +                     break;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_to_user(argp, &entry, sizeof(entry))) {
> > +                     fput(f);
> > +                     break;
> > +             }
> > +             ret = receive_fd(f, perm_to_file_flags(entry.perm));
> > +             fput(f);
> > +             break;
>
> IDGI.  The main difference between receive_fd() and plain old
> get_unused_fd_flags() + fd_install() is __receive_sock() call.
> Which does nothing whatsoever in case of non-sockets.  Can you
> get a socket here?
>

Actually what I want here is the security_file_receive() hook in receive_fd().

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
