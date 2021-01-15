Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A4C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 19:14:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB8C235F8
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 19:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB8C235F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E8DF720411;
	Fri, 15 Jan 2021 19:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPW3wM3IY5ub; Fri, 15 Jan 2021 19:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 20469203AF;
	Fri, 15 Jan 2021 19:14:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 070A3C088B;
	Fri, 15 Jan 2021 19:14:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CCA4C013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 19:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 57381203BD
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 19:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z1VSTNKtgW+0 for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 19:14:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 403DF203AF
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610738094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4FwxeAEyXEI6CWznvqU5AtMWFcpWnT8O1IOjG3Vr1Y=;
 b=fAe+ajtVIYBEQkzCXTRIf548lc2wwxiv7Jett+ryDUdvQh1FPckIaQhQZnakBj7VHaj4hY
 jEOQXlZ42Yfq+Ibk4UjbTPcuqZOqEvFwCt2Z6wrna2T90VzB3J9yo0Dmg6UkusGccKklKp
 VsinUcEbltPu0mVuoGmvtxlOjx0Sr+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-QqrpG32lOIWZOPK7xYEGTg-1; Fri, 15 Jan 2021 14:14:52 -0500
X-MC-Unique: QqrpG32lOIWZOPK7xYEGTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C32806662;
 Fri, 15 Jan 2021 19:14:49 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6AFB5D9C6;
 Fri, 15 Jan 2021 19:14:47 +0000 (UTC)
Date: Fri, 15 Jan 2021 12:14:47 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2 2/2] vfio/iommu_type1: Sanity check pfn_list when
 remove vfio_dma
Message-ID: <20210115121447.54c96857@omen.home.shazbot.org>
In-Reply-To: <20210115092643.728-3-zhukeqian1@huawei.com>
References: <20210115092643.728-1-zhukeqian1@huawei.com>
 <20210115092643.728-3-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Fri, 15 Jan 2021 17:26:43 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> vfio_sanity_check_pfn_list() is used to check whether pfn_list of
> vfio_dma is empty when remove the external domain, so it makes a
> wrong assumption that only external domain will add pfn to dma pfn_list.
> 
> Now we apply this check when remove a specific vfio_dma and extract
> the notifier check just for external domain.

The page pinning interface is gated by having a notifier registered for
unmaps, therefore non-external domains would also need to register a
notifier.  There's currently no other way to add entries to the
pfn_list.  So if we allow pinning for such domains, then it's wrong to
WARN_ON() when the notifier list is not-empty when removing an external
domain.  Long term we should probably extend page {un}pinning for the
caller to pass their notifier to be validated against the notifier list
rather than just allowing page pinning if *any* notifier is registered.
Thanks,

Alex
 
> Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 4e82b9a3440f..a9bc15e84a4e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -958,6 +958,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>  {
> +	WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list);
>  	vfio_unmap_unpin(iommu, dma, true);
>  	vfio_unlink_dma(iommu, dma);
>  	put_task_struct(dma->task);
> @@ -2251,23 +2252,6 @@ static void vfio_iommu_unmap_unpin_reaccount(struct vfio_iommu *iommu)
>  	}
>  }
>  
> -static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
> -{
> -	struct rb_node *n;
> -
> -	n = rb_first(&iommu->dma_list);
> -	for (; n; n = rb_next(n)) {
> -		struct vfio_dma *dma;
> -
> -		dma = rb_entry(n, struct vfio_dma, node);
> -
> -		if (WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list)))
> -			break;
> -	}
> -	/* mdev vendor driver must unregister notifier */
> -	WARN_ON(iommu->notifier.head);
> -}
> -
>  /*
>   * Called when a domain is removed in detach. It is possible that
>   * the removed domain decided the iova aperture window. Modify the
> @@ -2367,7 +2351,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  			kfree(group);
>  
>  			if (list_empty(&iommu->external_domain->group_list)) {
> -				vfio_sanity_check_pfn_list(iommu);
> +				/* mdev vendor driver must unregister notifier */
> +				WARN_ON(iommu->notifier.head);
>  
>  				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
>  					vfio_iommu_unmap_unpin_all(iommu);
> @@ -2491,7 +2476,8 @@ static void vfio_iommu_type1_release(void *iommu_data)
>  
>  	if (iommu->external_domain) {
>  		vfio_release_domain(iommu->external_domain, true);
> -		vfio_sanity_check_pfn_list(iommu);
> +		/* mdev vendor driver must unregister notifier */
> +		WARN_ON(iommu->notifier.head);
>  		kfree(iommu->external_domain);
>  	}
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
