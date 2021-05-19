Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EE6C433B4
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 13:39:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A615A610A8
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 13:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A615A610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A12B6078D;
	Wed, 19 May 2021 13:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6CvBj1UtLCV; Wed, 19 May 2021 13:39:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D3B76062B;
	Wed, 19 May 2021 13:39:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21C7FC000E;
	Wed, 19 May 2021 13:39:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 514CCC0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 13:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31E6482C1C
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 13:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R_vsI4Az8OUY for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 13:39:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55AE982E54
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 13:39:33 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id o5so6422824edc.5
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 06:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZyIq8u+kwqwBpbcwfduylW+9xPyGO1H5rtatjl1f/C8=;
 b=xs/S/LlOVbGml0EAnOsGRxZ5oyqDBbSJlCsgVvbQ04i5427YcKz67n0cj1OtSeZJzl
 3OctonqM0oElTfaoTOk7R2GorMPYS4s6Btg8XNc/c8YJCgYkjK+9gWKXqHAD42DxLpI8
 u88O6hu8P5tyhEqbon4FApOFc19n66atecuVED7etO6q1DkSFutUnSZJ47B113wTUxY4
 BDyFvGJ7MTYq9/FGHolluJ7KGdFbHah2Ii04NPVk3Do6Edo/rTmDaygSrsV/k7OCxbIf
 5fhm7wm6SKx4287C/a43687P2ouGxwFMVU1e5nxsCdXnJ4V1slDmpOxWqN3L8omzqx2q
 Gnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZyIq8u+kwqwBpbcwfduylW+9xPyGO1H5rtatjl1f/C8=;
 b=blpLXcwkmh+LacgNGAnKKqH/Znr5AD1wwcKwoJy5AlMeIo3Gw1/uz5l99BKTyhHi+t
 rGr+kzhddY0qSwDQdI0RJ2vOlEEjIi14CLs8wBBvFeczFiqmZp38n/GeErJffsiZxsdI
 XHqW0BGmonn+ljgnXaUWOVYZCLscfe9m/weMeGT8vkzmOdT5XT4gNmJ//2L7SEgDqQMP
 LSAXXAsu0Xc1G32s7q1hUuX2CNQV2aKapmVJuwHhoUEkq+Jhu4J0ODpijiHMXXxzmkzu
 42X3LtvSAjQG4kVZ7OseJEtMC490C8oIEFuweTdfrn5qDGOhmfncpo4lNmW/h+cP99ve
 SCCQ==
X-Gm-Message-State: AOAM5306qtroqUUXJWx0MT8HK2vz26nmGgWFiFjnncePs1huufc8pY1k
 k+OJRZnc9Fsy+SAXUGnJR+6aIMBbKIj4YI2LkBNK
X-Google-Smtp-Source: ABdhPJyUaoeoU6jHmwL2wRih6mMfwzvW50aSrjBZb35A6Wf6KcfF+IKFvuHwvdNQjGh/v4RZkom8EsJySMDZrk7j/3M=
X-Received: by 2002:a05:6402:4252:: with SMTP id
 g18mr14312783edb.195.1621431571306; 
 Wed, 19 May 2021 06:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-5-xieyongji@bytedance.com>
In-Reply-To: <20210517095513.850-5-xieyongji@bytedance.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 19 May 2021 21:39:20 +0800
Message-ID: <CACycT3s1rEvNnNkJKQsHGRsyLPADieFdVkb1Sp3GObR0Vox5Fg@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] virtio-blk: Add validation for block size in
 config space
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Parav Pandit <parav@nvidia.com>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <christian.brauner@canonical.com>,
 Randy Dunlap <rdunlap@infradead.org>, 
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 Jens Axboe <axboe@kernel.dk>, 
 bcrl@kvack.org, Jonathan Corbet <corbet@lwn.net>, 
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, 
 Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
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

On Mon, May 17, 2021 at 5:56 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ebb4d3fe803f..c848aa36d49b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -826,7 +826,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>                                    struct virtio_blk_config, blk_size,
>                                    &blk_size);
> -       if (!err)
> +       if (!err && blk_size > 0 && blk_size <= max_size)

The check here is incorrect. I will use PAGE_SIZE as the maximum
boundary in the new version.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
