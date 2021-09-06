Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DCC433FE
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 06:09:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A77660EE1
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 06:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A77660EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28697403BB;
	Mon,  6 Sep 2021 06:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBhoUiz9FVjw; Mon,  6 Sep 2021 06:09:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B9452403BD;
	Mon,  6 Sep 2021 06:09:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94849C0010;
	Mon,  6 Sep 2021 06:09:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F59C000E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 06:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6625D40298
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 06:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWxiA5LXfJhD for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 06:09:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D3D3401C6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 06:09:37 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id dm15so7941775edb.10
 for <iommu@lists.linux-foundation.org>; Sun, 05 Sep 2021 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iLQZhgxKgfIDFt5lvdc2MzHzo2TIxIc31ByxAdyguDw=;
 b=odHfcBGsXMMsYB2K8Do9ItkBkMTq6LWsGfzwSwjDSZ150IpQF83y0vfBln5L7YVgiw
 3MpZwyeS+QD8McxuPPxYxbm0B8uAK5/6bNVzGCQ3vsq1gUyf9m37Tv+e5qVdZqDNjAev
 Xaqo2CLPu9Y3meToLpI9B7J78zGlu+7JUYZ4izYbDZgP2XtyOGajNL0pzHncLqlgsEVm
 4bIszAuRtDUfeh0uGsQB/wMMzlHe4FXMtOXP7CcKYI3X3EKfrVxan8x6W96Lfrgxnfnf
 VkoHn8zk2d48PQu1VwJZG2YCEYOwA1Adig/icsv06Ld2WfJcAwY0GQAelyk08s8IO8Ul
 YFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iLQZhgxKgfIDFt5lvdc2MzHzo2TIxIc31ByxAdyguDw=;
 b=eUYg7XLFRP/UkQ2CawJHableuUblSbqFMGOyJ6p++DWQz4gsABdBOpTtxegGtMqQPq
 iGdrEB+FhZNl2MzK+uH1wMTJI6ioVLL1USZo+MOlGS2++t4czhWWvVBKozUBwdgbiuEX
 CjeRSDwJGB4zuTIZfPF3P1cr7Wsw+ZPojOVruQp0DGVQyFgD4jrNtNG3p5jDDhUVppAT
 WU4dnHZDwUKDwQWpM4cirmcGVAPK6qbbHmngdDPfyTDUGoiWsr4Cqcgq7uy8eE601Bfz
 ooOgWZ8FkP07P0SibTLkZiKtnhZpBXtpPqZf8KUai/vr6VyqbThdPZe9rNliiKbWxQAt
 /rcg==
X-Gm-Message-State: AOAM533nJVIcUfCRZHrGmMTPSSAgDxTu2fh/E73j49QfHOvy8YoSrB6+
 MrcU1zjm1A7JIsoHAeg+NPe2OS5keO9httVdVcjs
X-Google-Smtp-Source: ABdhPJwAFlEIMtTqX/FnP+Pe+DBoVGCsW7XaaIAidi/YyhHjkzk2b+1T+9ejMprIIKa+g3AudWKBbxIRe912O1wmSz0=
X-Received: by 2002:a05:6402:4247:: with SMTP id
 g7mr11700392edb.287.1630908576144; 
 Sun, 05 Sep 2021 23:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210906015524-mutt-send-email-mst@kernel.org>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 6 Sep 2021 14:09:25 +0800
Message-ID: <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
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

On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > This adds a new callback to support device specific reset
> > behavior. The vdpa bus driver will call the reset function
> > instead of setting status to zero during resetting.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> This does gloss over a significant change though:
>
>
> > ---
> > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> >       return vdev->dma_dev;
> >  }
> >
> > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > +static inline int vdpa_reset(struct vdpa_device *vdev)
> >  {
> >       const struct vdpa_config_ops *ops = vdev->config;
> >
> >       vdev->features_valid = false;
> > -     ops->set_status(vdev, 0);
> > +     return ops->reset(vdev);
> >  }
> >
> >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>
>
> Unfortunately this breaks virtio_vdpa:
>
>
> static void virtio_vdpa_reset(struct virtio_device *vdev)
> {
>         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>
>         vdpa_reset(vdpa);
> }
>
>
> and there's no easy way to fix this, kernel can't recover
> from a reset failure e.g. during driver unbind.
>

Yes, but it should be safe with the protection of software IOTLB even
if the reset() fails during driver unbind.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
