Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64F4C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 23:46:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F63D64DD1
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 23:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F63D64DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD77C86357;
	Wed, 27 Jan 2021 23:46:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ezi0yKIM_Tk3; Wed, 27 Jan 2021 23:46:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE73986303;
	Wed, 27 Jan 2021 23:46:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F09C0FA7;
	Wed, 27 Jan 2021 23:46:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55592C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 23:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3AC30872F4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 23:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b9fYTMgpohRI for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 23:46:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3ED74872BD
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611791211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ/gs4iMushfcp0d07qS8uhcoreW6Bo1+Q0lKFHyKMM=;
 b=K5q5sx0F9JmAI66uRYMLVsuL2ASVd1C1MBvfcLdioqyRaISG82gNBKRXCOrZROvGZUtiZ9
 y8zLocIlesXDIlwnh/KO/rQHKSzyd2x9YFRztxl1jASYcsw02vT4spmDS7FUni8+tDC6VS
 4GxYoVfQdLf09Xl43EWhR+DbtvOVo2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-WQ5wUpHQOfu8sZ2HJIUVTg-1; Wed, 27 Jan 2021 18:46:47 -0500
X-MC-Unique: WQ5wUpHQOfu8sZ2HJIUVTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C137E8030A0;
 Wed, 27 Jan 2021 23:46:43 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E50C25C1BB;
 Wed, 27 Jan 2021 23:46:41 +0000 (UTC)
Date: Wed, 27 Jan 2021 16:46:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 2/2] vfio/iommu_type1: Fix some sanity checks in
 detach group
Message-ID: <20210127164641.36e17bf5@omen.home.shazbot.org>
In-Reply-To: <20210122092635.19900-3-zhukeqian1@huawei.com>
References: <20210122092635.19900-1-zhukeqian1@huawei.com>
 <20210122092635.19900-3-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, wanghaibin.wang@huawei.com,
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

On Fri, 22 Jan 2021 17:26:35 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> vfio_sanity_check_pfn_list() is used to check whether pfn_list and
> notifier are empty when remove the external domain, so it makes a
> wrong assumption that only external domain will use the pinning
> interface.
> 
> Now we apply the pfn_list check when a vfio_dma is removed and apply
> the notifier check when all domains are removed.
> 
> Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 161725395f2f..d8c10f508321 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -957,6 +957,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>  {
> +	WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list));
>  	vfio_unmap_unpin(iommu, dma, true);
>  	vfio_unlink_dma(iommu, dma);
>  	put_task_struct(dma->task);
> @@ -2250,23 +2251,6 @@ static void vfio_iommu_unmap_unpin_reaccount(struct vfio_iommu *iommu)
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
> @@ -2366,10 +2350,10 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  			kfree(group);
>  
>  			if (list_empty(&iommu->external_domain->group_list)) {
> -				vfio_sanity_check_pfn_list(iommu);
> -
> -				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> +				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +					WARN_ON(iommu->notifier.head);
>  					vfio_iommu_unmap_unpin_all(iommu);
> +				}
>  
>  				kfree(iommu->external_domain);
>  				iommu->external_domain = NULL;
> @@ -2403,10 +2387,12 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  		 */
>  		if (list_empty(&domain->group_list)) {
>  			if (list_is_singular(&iommu->domain_list)) {
> -				if (!iommu->external_domain)
> +				if (!iommu->external_domain) {
> +					WARN_ON(iommu->notifier.head);
>  					vfio_iommu_unmap_unpin_all(iommu);
> -				else
> +				} else {
>  					vfio_iommu_unmap_unpin_reaccount(iommu);
> +				}
>  			}
>  			iommu_domain_free(domain->domain);
>  			list_del(&domain->next);
> @@ -2488,9 +2474,10 @@ static void vfio_iommu_type1_release(void *iommu_data)
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_domain *domain, *domain_tmp;
>  
> +	WARN_ON(iommu->notifier.head);

I don't see that this does any harm, but isn't it actually redundant?
It seems vfio-core only calls the iommu backend release function after
removing all the groups, so the tests in _detach_group should catch all
cases.  We're expecting the vfio bus/mdev driver to remove the notifier
when a device is closed, which necessarily occurs before detaching the
group.  Thanks,

Alex

> +
>  	if (iommu->external_domain) {
>  		vfio_release_domain(iommu->external_domain, true);
> -		vfio_sanity_check_pfn_list(iommu);
>  		kfree(iommu->external_domain);
>  	}
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
