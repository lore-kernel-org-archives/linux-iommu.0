Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C02C433E3
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 21:06:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6962075E
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 21:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFX43kJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6962075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80BCA86B05;
	Thu, 20 Aug 2020 21:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1a_owEIRBzU; Thu, 20 Aug 2020 21:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7ECF486AE6;
	Thu, 20 Aug 2020 21:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64910C07FF;
	Thu, 20 Aug 2020 21:06:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDF3FC0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B170D883BE
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sKeZIRjWGFf7 for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 21:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B1D44883BD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597957593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rG+0Ph4uNEh5HoJiSQCxU0AdH7yPtWs/ChEMaNuJT88=;
 b=bFX43kJrONhCsUeroo8HWhd1TDHdbgb2ZNxiRF//pwkYX4XyqVwbKZfd6Aon1IckiDS3Av
 OiAhwF6jZXuFWtVnTXkJ6BIh+y/Tebe3EDGRBmUckLrHff2ogUSXSgur0X0A4fbjgmyqVy
 C7vufOd4Ao1uiUhRvJRk2eG6z1ocCfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-HhsWVm-ENXCQUNs4rYgzZA-1; Thu, 20 Aug 2020 17:06:29 -0400
X-MC-Unique: HhsWVm-ENXCQUNs4rYgzZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA09107464C;
 Thu, 20 Aug 2020 21:06:26 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC8685C1BD;
 Thu, 20 Aug 2020 21:06:19 +0000 (UTC)
Date: Thu, 20 Aug 2020 15:06:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/15] iommu: Pass domain to sva_unbind_gpasid()
Message-ID: <20200820150619.5dc1ec7a@x1.home>
In-Reply-To: <1595917664-33276-9-git-send-email-yi.l.liu@intel.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-9-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com,
 jun.j.tian@intel.com
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

On Mon, 27 Jul 2020 23:27:37 -0700
Liu Yi L <yi.l.liu@intel.com> wrote:

> From: Yi Sun <yi.y.sun@intel.com>
> 
> Current interface is good enough for SVA virtualization on an assigned
> physical PCI device, but when it comes to mediated devices, a physical
> device may attached with multiple aux-domains. Also, for guest unbind,

s/may/may be/

> the PASID to be unbind should be allocated to the VM. This check requires
> to know the ioasid_set which is associated with the domain.
> 
> So this interface needs to pass in domain info. Then the iommu driver is
> able to know which domain will be used for the 2nd stage translation of
> the nesting mode and also be able to do PASID ownership check. This patch
> passes @domain per the above reason. Also, the prototype of &pasid is
> changed frnt" to "u32" as the below link.

s/frnt"/from an "int"/
 
> https://lore.kernel.org/kvm/27ac7880-bdd3-2891-139e-b4a7cd18420b@redhat.com/

This is really confusing, the link is to Eric's comment asking that the
conversion from (at the time) int to ioasid_t be included in the commit
log.  The text here implies that it's pointing to some sort of
justification for the change, which it isn't.  It just notes that it
happened, not why it happened, with a mostly irrelevant link.

> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v5 -> v6:
> *) use "u32" prototype for @pasid.
> *) add review-by from Eric Auger.

I'd probably hold off on adding Eric's R-b given the additional change
in this version FWIW.  Thanks,

Alex
 
> v2 -> v3:
> *) pass in domain info only
> *) use u32 for pasid instead of int type
> 
> v1 -> v2:
> *) added in v2.
> ---
>  drivers/iommu/intel/svm.c   | 3 ++-
>  drivers/iommu/iommu.c       | 2 +-
>  include/linux/intel-iommu.h | 3 ++-
>  include/linux/iommu.h       | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c27d16a..c85b8d5 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -436,7 +436,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	return ret;
>  }
>  
> -int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +int intel_svm_unbind_gpasid(struct iommu_domain *domain,
> +			    struct device *dev, u32 pasid)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>  	struct intel_svm_dev *sdev;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1ce2a61..bee79d7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2145,7 +2145,7 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	if (unlikely(!domain->ops->sva_unbind_gpasid))
>  		return -ENODEV;
>  
> -	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
> +	return domain->ops->sva_unbind_gpasid(domain, dev, data->hpasid);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 0d0ab32..f98146b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -738,7 +738,8 @@ extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			  struct iommu_gpasid_bind_data *data);
> -int intel_svm_unbind_gpasid(struct device *dev, int pasid);
> +int intel_svm_unbind_gpasid(struct iommu_domain *domain,
> +			    struct device *dev, u32 pasid);
>  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
>  				 void *drvdata);
>  void intel_svm_unbind(struct iommu_sva *handle);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b1ff702..80467fc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -303,7 +303,8 @@ struct iommu_ops {
>  	int (*sva_bind_gpasid)(struct iommu_domain *domain,
>  			struct device *dev, struct iommu_gpasid_bind_data *data);
>  
> -	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> +	int (*sva_unbind_gpasid)(struct iommu_domain *domain,
> +				 struct device *dev, u32 pasid);
>  
>  	int (*def_domain_type)(struct device *dev);
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
