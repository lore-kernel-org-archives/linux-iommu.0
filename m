Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADBC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 05:55:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E83A6056C
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 05:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E83A6056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 564FD80F18;
	Mon,  6 Sep 2021 05:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1jrQKIht8C2; Mon,  6 Sep 2021 05:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 112FA80EE5;
	Mon,  6 Sep 2021 05:55:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DACB3C0010;
	Mon,  6 Sep 2021 05:55:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 993FEC000E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 05:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80DF2403D3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 05:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12CO0BPaKnTA for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 05:54:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35D8E403D2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 05:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630907696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXUj74/nW7Dop13kd56Tk5oKTffqICUe0M10X4WaPl4=;
 b=GUdZ1eZQlzCOGh1NwV8LtGH2T8rzYVbjGWgYpiIJXoRpQ92bQe12hhNowOqoFXtPMxzW5u
 aP3PYHxyAmwSjUySiwvrIceX1TPdj2cz/H7djZxQi1eHPdnARmD4QnZmPJUGR8BF2LTKWC
 5MAZc/xWES7JWGitNVqcR86RsKXi2zg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-87JsLo7LPBS3V6YEqH-AIg-1; Mon, 06 Sep 2021 01:54:55 -0400
X-MC-Unique: 87JsLo7LPBS3V6YEqH-AIg-1
Received: by mail-wr1-f71.google.com with SMTP id
 q14-20020a5d574e000000b00157b0978ddeso850893wrw.5
 for <iommu@lists.linux-foundation.org>; Sun, 05 Sep 2021 22:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uXUj74/nW7Dop13kd56Tk5oKTffqICUe0M10X4WaPl4=;
 b=LP5SZR8vgqe7JGYpioH7K1CfweVysZH1MxXPdRv8pOa/VXLSd9BeSolvsi1/9L36zW
 yEPyCIcUoRLhdMHGskZc4UTc6zoQacOeROeZBvK4uD0dYj1ovW6glDaH134cojAv7Dps
 PdI52Bhb2P++xAe5kn4wA7xNgh/RzOKgZw7Q6RFhuGT5jA/ceWNqvItMhwbGLPiqesgT
 2erpYNnS8mqmpZnZLHTAjWwrM2CAHswnrbL+cBYhNdw019GY90MDxdA6X+h2SE0TPoB2
 f5y5pwHE4VzPHJlDrX+jLJMEcoeZQkwkTpKzaZ2GWGLgsUOdDtVERdheDnhdY+wagVKI
 BnNw==
X-Gm-Message-State: AOAM533xLjHx82NHB961YHa5xObm3OYcG4a7nUbIu4+C83yXxJYRdvvp
 73AN+UCDDPVmPu15hxtnAsxPD0oXNemvZjQFy0Vpt8sLBqlu+avhg4xsCrSq0+cs9xstTQ7RaRS
 7nLKibNOkUA3KsDash1NgdzU7+BBKLg==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11478503wre.115.1630907694507; 
 Sun, 05 Sep 2021 22:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR1O2bgM/VI9yvbWaSh3BRtvaI+DJ+X6rHFaklEn67szHR3xlYEE2NCPwCA7NsX4rJPFqdkg==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11478480wre.115.1630907694360; 
 Sun, 05 Sep 2021 22:54:54 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id h8sm6166143wmb.35.2021.09.05.22.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 22:54:53 -0700 (PDT)
Date: Mon, 6 Sep 2021 01:54:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v12 05/13] vdpa: Add reset callback in vdpa_config_ops
Message-ID: <20210906015243-mutt-send-email-mst@kernel.org>
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20210830141737.181-6-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210830141737.181-6-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 will@kernel.org, corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, sgarzare@redhat.com, xiaodong.liu@intel.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, joe@perches.com, robin.murphy@arm.com,
 mika.penttila@nextfour.com
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

On Mon, Aug 30, 2021 at 10:17:29PM +0800, Xie Yongji wrote:
> This adds a new callback to support device specific reset
> behavior. The vdpa bus driver will call the reset function
> instead of setting status to zero during resetting.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

This does gloss over a significant change though:

> @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>  	return vdev->dma_dev;
>  }
>  
> -static inline void vdpa_reset(struct vdpa_device *vdev)
> +static inline int vdpa_reset(struct vdpa_device *vdev)
>  {
>  	const struct vdpa_config_ops *ops = vdev->config;
>  
>  	vdev->features_valid = false;
> -	ops->set_status(vdev, 0);
> +	return ops->reset(vdev);
>  }
>  
>  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)

Unfortunately this breaks virtio_vdpa:


static void virtio_vdpa_reset(struct virtio_device *vdev)
{
        struct vdpa_device *vdpa = vd_get_vdpa(vdev);

        vdpa_reset(vdpa);
}


and there's no easy way to fix this, kernel can't recover
from a reset failure e.g. during driver unbind.

Find a way to disable virtio_vdpa for now?

> -- 
> 2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
