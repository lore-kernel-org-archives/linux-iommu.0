Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A7BC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:24:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAF5613AF
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAF5613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2A3B4019A;
	Wed, 14 Jul 2021 05:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPzzkLk6hY2Q; Wed, 14 Jul 2021 05:24:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6ED9B40104;
	Wed, 14 Jul 2021 05:24:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B854C001A;
	Wed, 14 Jul 2021 05:24:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70518C001A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66116406AC
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qrTT27L_CjlK for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 05:24:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24256406AB
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:24:14 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id hr1so1314953ejc.1
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 22:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IR3H7P/Qqdz0+z7mAz+4BcJc0mjzsggsr8mNH8312vk=;
 b=J2IDtTc5DxsvAMq/DAkPuYqj0Y7dNpRgm5w+Q5Mo3F1Au3zIy957DexG4xM3ot9TeB
 gz7qUXOBffxs7ZJq8NwJJx3+F2yWdVty637g3WtUU13nzkMXjdWWulrIly/TOJxD+Hyy
 /NqXLpxJ8/rX9zvF4onj7kuKA/hY855NC/q2nDjsHgyYw3/sSLkn4POQUtEcySzhEGrh
 CDn9h5b45a/ov20IIHnvFDOFr1x5Vomj6Ve9ZjPNFGa6QG+3p9U0VzK3a00J7z6C/fWK
 eWV/SVtA1pGWD7wh4Q6+tQY/Bv7Ble6R8AihTwasCDJOPdVPj+NAufXpshOEW+KCfFKO
 W7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IR3H7P/Qqdz0+z7mAz+4BcJc0mjzsggsr8mNH8312vk=;
 b=ec2zEZsgGSFBvP68uNxQ2cMvM4CGNJxhsPcS4SX5WwVu/7zQjaukGTV/PtIHxBKuCf
 8bZuuOZiub10J9dbrqzT80/+NZ/4Jee4LSFQ+t7yms3zUJ6ilaF+9XmzVDOTYJGqsbkG
 UnBOYVK+vbopUo9NhGJeTg9vajGqAyL460xoA2c+ZS8RkNHAjf+3oasuXunC/VGAIOrN
 jUo/h783sNOf2wj/qwTieHHFVfUB5otVSvUKaeDLmaqWKv8qHfKgkWVe9CVSXKQ1A4S7
 3IeOyX9NczyT7OqsNiJP+jiBRVygnH68FA9LmWM+kMyC81s5idIIhZmWRKUSbprHp4dJ
 fIEg==
X-Gm-Message-State: AOAM530yocPQ3l03FRVpFzIe+Uns8/X3fF+Ct3+zIIoWR4XqEv2AuEIO
 ry5laCGxw0SOG9FdJO7Es7xAstbaWbghpGAngEZ7
X-Google-Smtp-Source: ABdhPJwiVScNvW759FNHFZbUm6bF1Hh8xD+5SHXF+XpeC6RBKLMlly39eCK/TlQciP+Rhit5f+SlsKPq8Beb+93M0R0=
X-Received: by 2002:a17:906:4b46:: with SMTP id
 j6mr10270164ejv.247.1626240253024; 
 Tue, 13 Jul 2021 22:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com>
 <20210713113114.GL1954@kadam>
In-Reply-To: <20210713113114.GL1954@kadam>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 14 Jul 2021 13:24:02 +0800
Message-ID: <CACycT3uKwu5xzj2ynWH5njCKHaYyOPkDb8BVLTHE5NJ-qpD3xQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, He Zhe <zhe.he@windriver.com>,
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

On Tue, Jul 13, 2021 at 7:31 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jul 13, 2021 at 04:46:52PM +0800, Xie Yongji wrote:
> > @@ -613,37 +618,28 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
> >       }
> >  }
> >
> > -static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > -                                        struct vhost_iotlb_msg *msg)
> > +static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > +                          u64 iova, u64 size, u64 uaddr, u32 perm)
> >  {
> >       struct vhost_dev *dev = &v->vdev;
> > -     struct vhost_iotlb *iotlb = dev->iotlb;
> >       struct page **page_list;
> >       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
> >       unsigned int gup_flags = FOLL_LONGTERM;
> >       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> >       unsigned long lock_limit, sz2pin, nchunks, i;
> > -     u64 iova = msg->iova;
> > +     u64 start = iova;
> >       long pinned;
> >       int ret = 0;
> >
> > -     if (msg->iova < v->range.first ||
> > -         msg->iova + msg->size - 1 > v->range.last)
> > -             return -EINVAL;
>
> This is not related to your patch, but can the "msg->iova + msg->size"
> addition can have an integer overflow.  From looking at the callers it
> seems like it can.  msg comes from:
>   vhost_chr_write_iter()
>   --> dev->msg_handler(dev, &msg);
>       --> vhost_vdpa_process_iotlb_msg()
>          --> vhost_vdpa_process_iotlb_update()
>
> If I'm thinking of the right thing then these are allowed to overflow to
> 0 because of the " - 1" but not further than that.  I believe the check
> needs to be something like:
>
>         if (msg->iova < v->range.first ||
>             msg->iova - 1 > U64_MAX - msg->size ||
>             msg->iova + msg->size - 1 > v->range.last)
>

Make sense.

> But writing integer overflow check correctly is notoriously difficult.
> Do you think you could send a fix for that which is separate from the
> patcheset?  We'd want to backport it to stable.
>

OK, I will send a patch to fix it.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
