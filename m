Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B65C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 23:44:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6049F23A5E
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 23:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6049F23A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D3F9A2E194;
	Fri, 15 Jan 2021 23:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqaIMmrv3N7J; Fri, 15 Jan 2021 23:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B44462E18C;
	Fri, 15 Jan 2021 23:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9838DC088B;
	Fri, 15 Jan 2021 23:44:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7A8FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 23:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AF16986D3A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 23:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v89OXSA7gVZY for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 23:44:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0BCC86D39
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 23:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610754258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFW1VUjwMynufyzYqhPYoWPpgrZOI0t/FMMBS/7NFuk=;
 b=gohl73o9eT/G361syxSRRGpOiTkWSZ3dQCaoVqpIlZqJ98WjAqH4SF3KWOTRJFvpkQ184d
 8l2mbo6XNFQ/HY72uID2wH0fXdPSC0Zy1t0yJYMDzs2OdZYXa8a/tLt6VSFrRxOfYMy6iA
 iIa0ArTL5Uhn5nPsfGi/c+buqSxUqTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-hWKr_bYZNwaEcqZInJIslA-1; Fri, 15 Jan 2021 18:44:14 -0500
X-MC-Unique: hWKr_bYZNwaEcqZInJIslA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D817F107ACF8;
 Fri, 15 Jan 2021 23:44:11 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52BDA5D751;
 Fri, 15 Jan 2021 23:44:10 +0000 (UTC)
Date: Fri, 15 Jan 2021 16:44:09 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 6/6] vfio/iommu_type1: Drop parameter "pgsize" of
 update_user_bitmap
Message-ID: <20210115164409.3e7ddb28@omen.home.shazbot.org>
In-Reply-To: <20210107044401.19828-7-zhukeqian1@huawei.com>
References: <20210107044401.19828-1-zhukeqian1@huawei.com>
 <20210107044401.19828-7-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Alexios Zavras <alexios.zavras@intel.com>, iommu@lists.linux-foundation.org,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com,
 Thomas Gleixner <tglx@linutronix.de>, jiangkunkun@huawei.com,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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

On Thu, 7 Jan 2021 12:44:01 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> We always use the smallest supported page size of vfio_iommu as
> pgsize. Drop parameter "pgsize" of update_user_bitmap.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 82649a040148..bceda5e8baaa 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -978,10 +978,9 @@ static void vfio_update_pgsize_bitmap(struct vfio_iommu *iommu)
>  }
>  
>  static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
> -			      struct vfio_dma *dma, dma_addr_t base_iova,
> -			      size_t pgsize)
> +			      struct vfio_dma *dma, dma_addr_t base_iova)
>  {
> -	unsigned long pgshift = __ffs(pgsize);
> +	unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
>  	unsigned long nbits = dma->size >> pgshift;
>  	unsigned long bit_offset = (dma->iova - base_iova) >> pgshift;
>  	unsigned long copy_offset = bit_offset / BITS_PER_LONG;
> @@ -1046,7 +1045,7 @@ static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>  		if (dma->iova > iova + size - 1)
>  			break;
>  
> -		ret = update_user_bitmap(bitmap, iommu, dma, iova, pgsize);
> +		ret = update_user_bitmap(bitmap, iommu, dma, iova);
>  		if (ret)
>  			return ret;
>  
> @@ -1192,7 +1191,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  
>  		if (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
>  			ret = update_user_bitmap(bitmap->data, iommu, dma,
> -						 unmap->iova, pgsize);
> +						 unmap->iova);
>  			if (ret)
>  				break;
>  		}

Same as the previous, both call sites already have both pgsize and
pgshift, pass both rather than recalculate.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
