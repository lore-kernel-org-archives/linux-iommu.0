Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F4C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 06:10:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A7A238E6
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 06:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A7A238E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8EA085CD5;
	Wed, 28 Oct 2020 06:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d7L9EfB5EAuS; Wed, 28 Oct 2020 06:10:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1E0D84854;
	Wed, 28 Oct 2020 06:10:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AECA9C0859;
	Wed, 28 Oct 2020 06:10:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE904C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 06:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C383686895
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 06:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0aNWekZl161o for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 06:10:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2F7F38651A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 06:10:36 +0000 (UTC)
IronPort-SDR: nX6UShSmBT1I9yv/5g9UhByOqUv/XStDwZM6oU8dpVdXmCKCfe+2BHs5rt427wmA7hgMPrlaEE
 7to3IN/GJs1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="165620912"
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="165620912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 23:10:35 -0700
IronPort-SDR: uqpel1tmSkKXVc75j0vJOS+rbMkSD0RJCkN/4UmYkfBxJF+MbGh15BKTE9cu28s/EDgCvNWZkp
 VQeugtoInG2g==
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="468605696"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 27 Oct 2020 23:10:33 -0700
Date: Wed, 28 Oct 2020 14:05:55 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 1/3] iommu/vt-d: Fix prq reporting issues
Message-ID: <20201028060555.GC27139@yi.y.sun>
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-2-git-send-email-yi.y.sun@linux.intel.com>
 <f330e49a-0bf4-08c7-8e24-04606ec4819e@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f330e49a-0bf4-08c7-8e24-04606ec4819e@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Thanks! Will do the modifications according to your comments in next
version.

On 20-10-28 12:50:37, Lu Baolu wrote:
> Hi Yi,
> 
> On 10/28/20 9:36 AM, Yi Sun wrote:
> >From: Liu Yi L <yi.l.liu@intel.com>
> >
> >Should get correct sid and set it into sdev. Because we execute
> >'sdev->sid != req->rid' in the loop of prq_event_thread().
> 
> How about making the title more accurate, how about something like:
> 
> iommu/vt-d: Fix use before set issue in intel_svm_bind_gpasid()
> 
> >
> >Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> >---
> >  drivers/iommu/intel/svm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> >index f1861fa..75d9dc9 100644
> >--- a/drivers/iommu/intel/svm.c
> >+++ b/drivers/iommu/intel/svm.c
> >@@ -277,6 +277,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> >  			  struct iommu_gpasid_bind_data *data)
> >  {
> >  	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> >+	struct device_domain_info *info;
> >  	struct intel_svm_dev *sdev = NULL;
> >  	struct dmar_domain *dmar_domain;
> >  	struct intel_svm *svm = NULL;
> >@@ -357,6 +358,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> >  		goto out;
> >  	}
> >  	sdev->dev = dev;
> >+	info = get_domain_info(dev);
> >+	sdev->sid = PCI_DEVID(info->bus, info->devfn);
> >  	/* Only count users if device has aux domains */
> >  	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> >
> 
> How about moving get_domain_info() up to the sanity check part?
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index f1861fa3d0e4..75846692f2f2 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -279,6 +279,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain, struct device *dev,
>         struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>         struct intel_svm_dev *sdev = NULL;
>         struct dmar_domain *dmar_domain;
> +       struct device_domain_info *info;
>         struct intel_svm *svm = NULL;
>         int ret = 0;
> 
> @@ -310,6 +311,10 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain, struct device *dev,
>         if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
>                 return -EINVAL;
> 
> +       info = get_domain_info(dev);
> +       if (!info)
> +               return -EINVAL;
> +
>         dmar_domain = to_dmar_domain(domain);
> 
>         mutex_lock(&pasid_mutex);
> @@ -357,6 +362,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain, struct device *dev,
>                 goto out;
>         }
>         sdev->dev = dev;
> +       sdev->sid = PCI_DEVID(info->bus, info->devfn);
> 
>         /* Only count users if device has aux domains */
>         if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
