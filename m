Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82CFC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 18:01:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403A222262
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403A222262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BB596203D1;
	Fri, 15 Jan 2021 18:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gC2beWkR8fFG; Fri, 15 Jan 2021 18:01:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EA63320366;
	Fri, 15 Jan 2021 18:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9DE1C088B;
	Fri, 15 Jan 2021 18:01:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90A1AC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 18:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F36486D21
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 18:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnX+jP0V9zjG for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 18:01:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8D23386CE3
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610733714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gq10Kr5xse22ieR9b4aF/0j+yRbARGW5WK7gbGTTvCI=;
 b=AACCP0VmzRAPiQcQ43ied0klwKAs4QBIgqTsiW81gqngo7pN+40H+8LGEWH+63exEV0WLq
 gy1MHqrsd5FbUIA6Un02tVaW8LertZyhPHrtnpyAB9YPE3yISoL236MOdd0TNrsI42MDdo
 srlZ9kb2Lt5KN7RuK+o6RfTcyyc6FyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-gAhkavzzP3CD-QHWbBOljQ-1; Fri, 15 Jan 2021 13:01:50 -0500
X-MC-Unique: gAhkavzzP3CD-QHWbBOljQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A11F6107ACF8;
 Fri, 15 Jan 2021 18:01:47 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90E4460BF3;
 Fri, 15 Jan 2021 18:01:45 +0000 (UTC)
Date: Fri, 15 Jan 2021 11:01:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2 1/2] vfio/iommu_type1: Populate full dirty when
 detach non-pinned group
Message-ID: <20210115110144.61e3c843@omen.home.shazbot.org>
In-Reply-To: <20210115092643.728-2-zhukeqian1@huawei.com>
References: <20210115092643.728-1-zhukeqian1@huawei.com>
 <20210115092643.728-2-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, wanghaibin.wang@huawei.com,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

On Fri, 15 Jan 2021 17:26:42 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> If a group with non-pinned-page dirty scope is detached with dirty
> logging enabled, we should fully populate the dirty bitmaps at the
> time it's removed since we don't know the extent of its previous DMA,
> nor will the group be present to trigger the full bitmap when the user
> retrieves the dirty bitmap.
> 
> Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for dirty pages tracking")
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 0b4dedaa9128..4e82b9a3440f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -236,6 +236,19 @@ static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t pgsize)
>  	}
>  }
>  
> +static void vfio_iommu_populate_bitmap_full(struct vfio_iommu *iommu)
> +{
> +	struct rb_node *n;
> +	unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
> +
> +	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> +
> +		if (dma->iommu_mapped)
> +			bitmap_set(dma->bitmap, 0, dma->size >> pgshift);
> +	}
> +}
> +
>  static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
>  {
>  	struct rb_node *n;
> @@ -2415,8 +2428,11 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  	 * Removal of a group without dirty tracking may allow the iommu scope
>  	 * to be promoted.
>  	 */
> -	if (update_dirty_scope)
> +	if (update_dirty_scope) {
>  		update_pinned_page_dirty_scope(iommu);
> +		if (iommu->dirty_page_tracking)
> +			vfio_iommu_populate_bitmap_full(iommu);
> +	}
>  	mutex_unlock(&iommu->lock);
>  }
>  

This doesn't do the right thing.  This marks the bitmap dirty if:

 * The detached group dirty scope was not limited to pinned pages

 AND

 * Dirty tracking is enabled

 AND

 * The vfio_dma is *currently* (ie. after the detach) iommu_mapped

We need to mark the bitmap dirty based on whether the vfio_dma *was*
iommu_mapped by the group that is now detached.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
