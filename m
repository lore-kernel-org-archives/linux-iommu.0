Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B1C2D0DB
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 21:41:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2657206F0
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 21:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTm1H9fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2657206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C8435863A1;
	Wed, 29 Jan 2020 21:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlpWqkGorPRf; Wed, 29 Jan 2020 21:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45F1486352;
	Wed, 29 Jan 2020 21:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBBFC0881;
	Wed, 29 Jan 2020 21:41:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE6EC0171
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 21:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F176A22122
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 21:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4wtdaWjSfhUn for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 21:40:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id BB5D21FDAF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580334057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pjsr+8GgeZRx08ogbJ32q6tJdvfyOSXMDX5qngbmsc=;
 b=FTm1H9fwZ/C9f9Ta7DbE9BrBwpNEqGsS8JJLJKzFaEahKNBaRnzPU+4pPcBB315GVWSuFG
 ptL0xmN96iXlAoRJi6fhZhVYYMaMUt/Vv1grgdx+LQsf8WV9ZsYMP5Xghkz/l7GiIFimaV
 qSn7ZkddUITbVQyQfUhAFOi5juxDfks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-BKFe_yzwM1CxZrLAq07h-g-1; Wed, 29 Jan 2020 16:40:53 -0500
X-MC-Unique: BKFe_yzwM1CxZrLAq07h-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ECCA18A6EC1;
 Wed, 29 Jan 2020 21:40:51 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE8F687B07;
 Wed, 29 Jan 2020 21:40:47 +0000 (UTC)
Date: Wed, 29 Jan 2020 14:40:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200129144046.3f91e4c1@w520.home>
In-Reply-To: <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Tue, 28 Jan 2020 22:02:04 -0800
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> IOMMU UAPI can be extended in the future by adding new
> fields at the end of each user data structure. Since we use
> a unified UAPI version for compatibility checking, a lookup
> function is needed to find the correct user data size to copy
> from user.
> 
> This patch adds a helper function based on a 2D lookup with
> version and type as input arguments.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>  include/linux/iommu.h |  6 ++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7dd51c5d2ba1..9e5de9abebdf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1696,6 +1696,28 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
>  
> +
> +/**
> + * Maintain a UAPI version to user data structure size lookup for each
> + * API function types we support. e.g. bind guest pasid, cache invalidation.
> + * As data structures being extended with new members, the offsetofend()
> + * will identify the new sizes.
> + */
> +const static int iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> +	/* IOMMU_UAPI_BIND_GPASID */
> +	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
> +	/* IOMMU_UAPI_CACHE_INVAL */
> +	{offsetofend(struct iommu_cache_invalidate_info, addr_info)},
> +	/* IOMMU_UAPI_PAGE_RESP */
> +	{offsetofend(struct iommu_page_response, code)},
> +};
> +
> +int iommu_uapi_get_data_size(int type, int version)
> +{

Seems like this is asking for a bounds check,

  if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
  	return -EINVAL;

If we add new types in future versions, I assume we'd back fill the
table with -EINVAL as well (rather than zero).  Thanks,

Alex

> +	return iommu_uapi_data_size[type][version - 1];
> +}
> +EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9718c109ea0a..416fe02160ba 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -500,6 +500,7 @@ extern int iommu_report_device_fault(struct device *dev,
>  				     struct iommu_fault_event *evt);
>  extern int iommu_page_response(struct device *dev,
>  			       struct iommu_page_response *msg);
> +extern int iommu_uapi_get_data_size(int type, int version);
>  
>  extern int iommu_group_id(struct iommu_group *group);
>  extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -885,6 +886,11 @@ static inline int iommu_page_response(struct device *dev,
>  	return -ENODEV;
>  }
>  
> +static int iommu_uapi_get_data_size(int type, int version)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_group_id(struct iommu_group *group)
>  {
>  	return -ENODEV;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
