Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449BAC433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 21:49:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D4822CB8
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 21:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D4822CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F16187057;
	Mon, 11 Jan 2021 21:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R74Gkw4dJU21; Mon, 11 Jan 2021 21:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD4CD86F8C;
	Mon, 11 Jan 2021 21:49:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A509EC0893;
	Mon, 11 Jan 2021 21:49:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 927CEC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 21:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7285686FB6
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 21:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JYgqRD0iAOtt for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 21:49:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2D0C786F8C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610401763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcHYs6OZqBWCMgb0rpCE3M6MXEuKUj2tsDDbqZh/79Q=;
 b=Hz2Y9oRlLLtMr3VK3hFnKgSjz/XHyxWZA316H6F4lON/5wdpYqWK+8ONUkDjxlnW0XTpjN
 wHflJdjBnNUr9NIoDmyp72csv5bhcRuMBP+xRfBPB5mc2pdrXSEugpmhNfTu9hiJu6jYg1
 qt2lzO7fsEFjgsevSv35ObPgMaYYJ6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-ekx4pMUpPXWmh16-SihWQQ-1; Mon, 11 Jan 2021 16:49:19 -0500
X-MC-Unique: ekx4pMUpPXWmh16-SihWQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B8F1107ACF7;
 Mon, 11 Jan 2021 21:49:16 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 828CE60BE2;
 Mon, 11 Jan 2021 21:49:14 +0000 (UTC)
Date: Mon, 11 Jan 2021 14:49:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 4/5] vfio/iommu_type1: Carefully use unmap_unpin_all
 during dirty tracking
Message-ID: <20210111144913.3092b1b1@omen.home.shazbot.org>
In-Reply-To: <20210107092901.19712-5-zhukeqian1@huawei.com>
References: <20210107092901.19712-1-zhukeqian1@huawei.com>
 <20210107092901.19712-5-zhukeqian1@huawei.com>
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

On Thu, 7 Jan 2021 17:29:00 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> If we detach group during dirty page tracking, we shouldn't remove
> vfio_dma, because dirty log will lose.
> 
> But we don't prevent unmap_unpin_all in vfio_iommu_release, because
> under normal procedure, dirty tracking has been stopped.

This looks like it's creating a larger problem than it's fixing, it's
not our job to maintain the dirty bitmap regardless of what the user
does.  If the user detaches the last group in a container causing the
mappings within that container to be deconstructed before the user has
collected dirty pages, that sounds like a user error.  A container with
no groups is de-privileged and therefore loses all state.  Thanks,

Alex

> Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for dirty pages tracking")
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 26b7eb2a5cfc..9776a059904d 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2373,7 +2373,12 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  			if (list_empty(&iommu->external_domain->group_list)) {
>  				vfio_sanity_check_pfn_list(iommu);
>  
> -				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> +				/*
> +				 * During dirty page tracking, we can't remove
> +				 * vfio_dma because dirty log will lose.
> +				 */
> +				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu) &&
> +				    !iommu->dirty_page_tracking)
>  					vfio_iommu_unmap_unpin_all(iommu);
>  
>  				kfree(iommu->external_domain);
> @@ -2406,10 +2411,15 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  		 * iommu and external domain doesn't exist, then all the
>  		 * mappings go away too. If it's the last domain with iommu and
>  		 * external domain exist, update accounting
> +		 *
> +		 * Note: During dirty page tracking, we can't remove vfio_dma
> +		 * because dirty log will lose. Just update accounting is a good
> +		 * choice.
>  		 */
>  		if (list_empty(&domain->group_list)) {
>  			if (list_is_singular(&iommu->domain_list)) {
> -				if (!iommu->external_domain)
> +				if (!iommu->external_domain &&
> +				    !iommu->dirty_page_tracking)
>  					vfio_iommu_unmap_unpin_all(iommu);
>  				else
>  					vfio_iommu_unmap_unpin_reaccount(iommu);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
