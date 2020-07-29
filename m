Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0175C433DF
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:25:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8474B2053B
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ca6ABU1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8474B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B56C85F9D;
	Wed, 29 Jul 2020 20:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpTZqqEERTqP; Wed, 29 Jul 2020 20:25:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB4048481F;
	Wed, 29 Jul 2020 20:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8FBCC004F;
	Wed, 29 Jul 2020 20:25:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DC4C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 245FB8481F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:25:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZFk5CMCi8uS for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 20:25:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B41D847D5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596054314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCZpvlTRYeKn2G2IpCrrj/S3gke7jRP5RvQ+owSSG9A=;
 b=Ca6ABU1R9C70AarbV3y+iuoM6OUVPPR6mFvcpR/gFYww6F8dHIiEgMw6WR1qjLJdQy1nBr
 mBvhY7aqALB+VvJz5oospbjDjHQd+E7UVyFveVhHyZ2LhCZHKkQB6kDOivFg3clUwD5XwZ
 c2wNKV8vywP4t9JV9MDq/HwjAz1hGSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-q_PLVkyGOsiYWaHlKxve7w-1; Wed, 29 Jul 2020 16:25:10 -0400
X-MC-Unique: q_PLVkyGOsiYWaHlKxve7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D638017FB;
 Wed, 29 Jul 2020 20:25:09 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12A4B512FE;
 Wed, 29 Jul 2020 20:25:07 +0000 (UTC)
Date: Wed, 29 Jul 2020 14:25:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] iommu: Add iommu_aux_get_domain_for_dev()
Message-ID: <20200729142507.182cd18a@x1.home>
In-Reply-To: <20200714055703.5510-4-baolu.lu@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-4-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Tue, 14 Jul 2020 13:57:02 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The device driver needs an API to get its aux-domain. A typical usage
> scenario is:
> 
>         unsigned long pasid;
>         struct iommu_domain *domain;
>         struct device *dev = mdev_dev(mdev);
>         struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
> 
>         domain = iommu_aux_get_domain_for_dev(dev);
>         if (!domain)
>                 return -ENODEV;
> 
>         pasid = iommu_aux_get_pasid(domain, iommu_device);
>         if (pasid <= 0)
>                 return -EINVAL;
> 
>          /* Program the device context */
>          ....
> 
> This adds an API for such use case.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 18 ++++++++++++++++++
>  include/linux/iommu.h |  7 +++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cad5a19ebf22..434bf42b6b9b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2817,6 +2817,24 @@ void iommu_aux_detach_group(struct iommu_domain *domain,
>  }
>  EXPORT_SYMBOL_GPL(iommu_aux_detach_group);
>  
> +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev)
> +{
> +	struct iommu_domain *domain = NULL;
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +
> +	if (group->aux_domain_attached)
> +		domain = group->domain;

Why wouldn't the aux domain flag be on the domain itself rather than
the group?  Then if we wanted sanity checking in patch 1/ we'd only
need to test the flag on the object we're provided.

If we had such a flag, we could create an iommu_domain_is_aux()
function and then simply use iommu_get_domain_for_dev() and test that
it's an aux domain in the example use case.  It seems like that would
resolve the jump from a domain to an aux-domain just as well as adding
this separate iommu_aux_get_domain_for_dev() interface.  The is_aux
test might also be useful in other cases too.  Thanks,

Alex

> +
> +	iommu_group_put(group);
> +
> +	return domain;
> +}
> +EXPORT_SYMBOL_GPL(iommu_aux_get_domain_for_dev);
> +
>  /**
>   * iommu_sva_bind_device() - Bind a process address space to a device
>   * @dev: the device
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9506551139ab..cda6cef7579e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -639,6 +639,7 @@ int iommu_aux_attach_group(struct iommu_domain *domain,
>  			   struct iommu_group *group, struct device *dev);
>  void iommu_aux_detach_group(struct iommu_domain *domain,
>  			   struct iommu_group *group, struct device *dev);
> +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev);
>  
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm,
> @@ -1040,6 +1041,12 @@ iommu_aux_detach_group(struct iommu_domain *domain,
>  {
>  }
>  
> +static inline struct iommu_domain *
> +iommu_aux_get_domain_for_dev(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
