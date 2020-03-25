Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E036C2D0E5
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CE520737
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmqP2Or9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CE520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 938B185319;
	Wed, 25 Mar 2020 21:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHqOYtFcjZkQ; Wed, 25 Mar 2020 21:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1528D86D79;
	Wed, 25 Mar 2020 21:05:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFB74C1D89;
	Wed, 25 Mar 2020 21:05:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D9C5C1D74
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 21:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 442F720527
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 21:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O5N6c24fNPVF for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 21:05:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by silver.osuosl.org (Postfix) with ESMTPS id 5EDDA204C1
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 21:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585170325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geCa1OSxny+PzgSp/iZxt6RW2EJVp1S56y0SbXLYQ/Q=;
 b=KmqP2Or98K9bGioZaH2B1B+9o0H7M3Xx9Tazl/cpY5OJUM5znwklPLB4KXvouxf8SW/Z2o
 LHSR1kzIlSGHst1h/nw/g23nTLjHvQcugp1Nr2cI5mG2JXYCv1TJ1OfH9Sh5pcuAAvrQMC
 m4mbYa9Dn97VF3ZLpsxzN3IPnjONTRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-KBGHRYj6MUGvl1wqUslS3g-1; Wed, 25 Mar 2020 17:05:23 -0400
X-MC-Unique: KBGHRYj6MUGvl1wqUslS3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0969E189F762;
 Wed, 25 Mar 2020 21:05:22 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 839E95D9CA;
 Wed, 25 Mar 2020 21:05:18 +0000 (UTC)
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8305aadc-ee0e-382d-b605-b6cfce98b2ac@redhat.com>
Date: Wed, 25 Mar 2020 22:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200318114047.1518048-1-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: robin.murphy@arm.com, Bharat Bhushan <bbhushan2@marvell.com>
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

Hi Jean,

On 3/18/20 12:40 PM, Jean-Philippe Brucker wrote:
> We don't currently support IOMMUs with a page granule larger than the
> system page size. The IOVA allocator has a BUG_ON() in this case, and
> VFIO has a WARN_ON().
> 
> It might be possible to remove these obstacles if necessary. If the host
> uses 64kB pages and the guest uses 4kB, then a device driver calling
> alloc_page() followed by dma_map_page() will create a 64kB mapping for a
> 4kB physical page, allowing the endpoint to access the neighbouring 60kB
> of memory. This problem could be worked around with bounce buffers.
> 
> For the moment, rather than triggering the IOVA BUG_ON() on mismatched
> page sizes, abort the virtio-iommu probe with an error message.
> 
> Reported-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 6d4e3c2a2ddb..80d5d8f621ab 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -998,6 +998,7 @@ static int viommu_probe(struct virtio_device *vdev)
>  	struct device *parent_dev = vdev->dev.parent;
>  	struct viommu_dev *viommu = NULL;
>  	struct device *dev = &vdev->dev;
> +	unsigned long viommu_page_size;
>  	u64 input_start = 0;
>  	u64 input_end = -1UL;
>  	int ret;
> @@ -1028,6 +1029,14 @@ static int viommu_probe(struct virtio_device *vdev)
>  		goto err_free_vqs;
>  	}
>  
> +	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
Given the fact we now head towards probing the device for its
page_size_mask in viommu_add_device() the check may need to happen
later, in viommu_domain_finalise() for instance?

Thanks

Eric
> +	if (viommu_page_size > PAGE_SIZE) {
> +		dev_err(dev, "granule 0x%lx larger than system page size 0x%lx\n",
> +			viommu_page_size, PAGE_SIZE);
> +		ret = -EINVAL;
> +		goto err_free_vqs;
> +	}
> +
>  	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
>  	viommu->last_domain = ~0U;
>  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
