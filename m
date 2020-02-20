Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D11C11D20
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 20:55:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C62420679
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF9sTn4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C62420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1331C86432;
	Thu, 20 Feb 2020 20:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSNitp8gusoT; Thu, 20 Feb 2020 20:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 91BA786055;
	Thu, 20 Feb 2020 20:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E5B9C1D81;
	Thu, 20 Feb 2020 20:55:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B1FC013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B7BCF87DAF
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D59l+RELOyum for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 20:55:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7E36F87D63
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582232128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n59pKOcdTZlkr3iRkuuDYSYR3kx21EL+m/7qJp3dlcc=;
 b=jF9sTn4f7GzlwLrgM5rOZA3oEVFU8WbzjZydOVNO/ngBP8J8np0VBl6srFKi2SL8u+L1bV
 GFXMvfRLGIoYmHguzjvcxTa7jidj0KqjH7DT/iFuLu8DvGcVFA2qUhbRHj1F/4PyFGcwa7
 UAYsVO4G6PKGq/rzS9qVIm7IVxwzZ0Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-19chX6fTPxGe_RHoj100fg-1; Thu, 20 Feb 2020 15:55:22 -0500
X-MC-Unique: 19chX6fTPxGe_RHoj100fg-1
Received: by mail-qt1-f200.google.com with SMTP id m8so3161qta.20
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 12:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n59pKOcdTZlkr3iRkuuDYSYR3kx21EL+m/7qJp3dlcc=;
 b=JqR8IqvfYtP8XZ+IoyH9C1iHyTCeIL5q4Mpqnyggu3NwlWLei/zhXIlU+wyN/Uliij
 UwS0R6Ssl/dsysg7U040fbBw2X3pdoAsAUueWwskhcOQdXEP+Y1jQAdcYl9xKtSes3Fb
 UMRKye96SXPTrFXqiixOrm374Hq6Vjb6zTjSVLwnK0HSM9zAh19L3GWuBY4iwHrBPgnB
 OtjTIbNwoHoO5i2AyrRLLhyBQJ3DfoR1/Sz3YtmR5lkZuJAkH2VhptjX/E7GdYAZVzwa
 WZzIUUOGUhWXOsxzem4i39QDQVWlOHhOMRav63yk9Tn8imhU003kS5orLV2ExWLdvOd5
 Ajbg==
X-Gm-Message-State: APjAAAXENUhYjP7xh7MxYTSp1KSIEC4wXhzR0PEvG7TNpPjy3hhh+aXn
 B5gdDsG8zRw/43D8TC6q7hZ1KBdEKbkVF7AFLpFEtUkhZp41usDy8V2e03xRQEH3T8fKdGvxji9
 3BVdYh6tCp3d1QwcwPYMcxQvEvEDc+A==
X-Received: by 2002:a0c:b920:: with SMTP id u32mr26145218qvf.173.1582232121724; 
 Thu, 20 Feb 2020 12:55:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYbEyWlyA1CtyLkpPuUF6uywJfTlRwR2s/p8kqFjjrgLX6Ni1df+OO/USj4ggxNDPJ4/sgrw==
X-Received: by 2002:a0c:b920:: with SMTP id u32mr26145171qvf.173.1582232121178; 
 Thu, 20 Feb 2020 12:55:21 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id g19sm391571qkk.91.2020.02.20.12.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:55:20 -0800 (PST)
Date: Thu, 20 Feb 2020 15:55:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200220154904-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200220160606.53156-3-pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> Currently the advanced guest memory protection technologies (AMD SEV,
> powerpc secure guest technology and s390 Protected VMs) abuse the
> VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
> is in turn necessary, to make IO work with guest memory protection.
> 
> But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
> different beast: with virtio devices whose implementation runs on an SMP
> CPU we are still fine with doing all the usual optimizations, it is just
> that we need to make sure that the memory protection mechanism does not
> get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> side of the guest (and possibly he host side as well) than we actually
> need.
> 
> An additional benefit of teaching the guest to make the right decision
> (and use DMA API) on it's own is: removing the need, to mandate special
> VM configuration for guests that may run with protection. This is
> especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> the virtio control structures into the first 2G of guest memory:
> something we don't necessarily want to do per-default.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Ram Pai <linuxram@us.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>

This might work for you but it's fragile, since without
VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
GPA's, not DMA addresses.



IOW this looks like another iteration of:

	virtio: Support encrypted memory on powerpc secure guests

which I was under the impression was abandoned as unnecessary.


To summarize, the necessary conditions for a hack along these lines
(using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:

  - secure guest mode is enabled - so we know that since we don't share
    most memory regular virtio code won't
    work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
  - DMA API is giving us addresses that are actually also physical
    addresses
  - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
 
I don't see how this patch does this.


> ---
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 867c7ebd3f10..fafc8f924955 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (!virtio_has_iommu_quirk(vdev))
>  		return true;
>  
> +	if (force_dma_unencrypted(&vdev->dev))
> +		return true;
> +
>  	/* Otherwise, we are left to guess. */
>  	/*
>  	 * In theory, it's possible to have a buggy QEMU-supposed
> -- 
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
