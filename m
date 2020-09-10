Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D7C2D0A7
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 22:06:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B584520BED
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLhyZT+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B584520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 699F7871C7;
	Thu, 10 Sep 2020 22:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XocE4U2o9Jtp; Thu, 10 Sep 2020 22:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D730C871B5;
	Thu, 10 Sep 2020 22:06:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D13EBC0052;
	Thu, 10 Sep 2020 22:06:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DE6C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C7095871BF
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bAVgwuKOnNyl for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 22:06:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E28DC871B5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599775566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05X3JBoOf2nSTm0BfJQfmt6ZAPBt0WusmBmxwnQgG+Y=;
 b=BLhyZT+4z0HcOBb20rGS77/MNbdwN8HfIiXbN2BhjGWIuxtTUZLGpc8Gzt4vk8c3HfRMnN
 iGqkM4Filz5cK70u1qIf2c1QOk5w0QolsYT4RAxrKqGB3+bYe11Jcz0JJQE+LE2JsEXl6W
 2tnx0NgfKkyCcegZiupJRulesURBZ5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-ed_PetvbPx2GWGF4j7giBg-1; Thu, 10 Sep 2020 18:06:01 -0400
X-MC-Unique: ed_PetvbPx2GWGF4j7giBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01BE0196634A;
 Thu, 10 Sep 2020 22:05:51 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F0E97EB74;
 Thu, 10 Sep 2020 22:05:50 +0000 (UTC)
Date: Thu, 10 Sep 2020 16:05:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 1/5] iommu: Add optional subdev in aux_at(de)tach ops
Message-ID: <20200910160549.2b176ac5@w520.home>
In-Reply-To: <20200901033422.22249-2-baolu.lu@linux.intel.com>
References: <20200901033422.22249-1-baolu.lu@linux.intel.com>
 <20200901033422.22249-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Tue,  1 Sep 2020 11:34:18 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> In the vfio/mdev use case of aux-domain, the subdevices are created from
> the physical devices with IOMMU_DEV_FEAT_AUX enabled and the aux-domains
> are attached to the subdevices through the iommu_ops.aux_attach_dev()
> interface.
> 
> Current iommu_ops.aux_at(de)tach_dev() design only takes the aux-domain
> and the physical device as the parameters, this is insufficient if we
> want the vendor iommu drivers to learn the knowledge about relationships
> between the aux-domains and the subdevices. Add a @subdev parameter to
> iommu_ops.aux_at(de)tach_dev() interfaces so that a subdevice could be
> opt-in.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++----
>  drivers/iommu/iommu.c       |  4 ++--
>  include/linux/iommu.h       |  6 ++++--
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bce158468abf..3c12fd06856c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5338,8 +5338,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>  	return domain_add_dev_info(to_dmar_domain(domain), dev);
>  }
>  
> -static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
> -					 struct device *dev)
> +static int
> +intel_iommu_aux_attach_device(struct iommu_domain *domain,
> +			      struct device *dev, struct device *subdev)
>  {
>  	int ret;
>  
> @@ -5359,8 +5360,9 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
>  	dmar_remove_one_dev_info(dev);
>  }
>  
> -static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
> -					  struct device *dev)
> +static void
> +intel_iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev,
> +			      struct device *subdev)
>  {
>  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>  }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 609bd25bf154..38cdfeb887e1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2728,7 +2728,7 @@ int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
>  	int ret = -ENODEV;
>  
>  	if (domain->ops->aux_attach_dev)
> -		ret = domain->ops->aux_attach_dev(domain, dev);
> +		ret = domain->ops->aux_attach_dev(domain, dev, NULL);
>  
>  	if (!ret)
>  		trace_attach_device_to_domain(dev);
> @@ -2740,7 +2740,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
>  void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
>  {
>  	if (domain->ops->aux_detach_dev) {
> -		domain->ops->aux_detach_dev(domain, dev);
> +		domain->ops->aux_detach_dev(domain, dev, NULL);
>  		trace_detach_device_from_domain(dev);
>  	}
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fee209efb756..871267104915 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -279,8 +279,10 @@ struct iommu_ops {
>  	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
>  
>  	/* Aux-domain specific attach/detach entries */
> -	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
> -	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev,
> +			      struct device *subdev);
> +	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev,
> +			       struct device *subdev);
>  	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
>  
>  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,

Would this be a good spot in the code to provide comments more formally
defining this subdevice concept?  For example, what exactly is the
relationship between the device and the subdevice and which device do
we use for the remaining aux domain functions, ex. aux_get_pasid().
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
