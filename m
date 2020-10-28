Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C7C388F7
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 04:57:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAC821655
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 04:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAC821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FA2B85F57;
	Wed, 28 Oct 2020 04:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NANrEgHrOjUy; Wed, 28 Oct 2020 04:57:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B90D5854E0;
	Wed, 28 Oct 2020 04:57:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 886C5C088B;
	Wed, 28 Oct 2020 04:57:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA44C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 04:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 42993204BA
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 04:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3iLZIDZs33X for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 04:57:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 0F0D020029
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 04:57:23 +0000 (UTC)
IronPort-SDR: rXG7/G9dQTFV9uunUikwJadf1pFgiSSsrbKlgsj3iN6CJgIdmmXs/m0NCNlaYk+LgX95tLinMf
 xYIFTvl072Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="232388333"
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="232388333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 21:57:21 -0700
IronPort-SDR: +cuJUi0eGQQFT79/b3YEPfN1sDQwxF/gBjWEdXSo+9lZHpfI/toXf/6+mCH1BwJVT1IcVC0Udy
 7Ah+lZGhk5BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="424619395"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2020 21:57:19 -0700
Subject: Re: [PATCH v1 1/3] iommu/vt-d: Fix prq reporting issues
To: Yi Sun <yi.y.sun@linux.intel.com>, joro@8bytes.org, dwmw2@infradead.org
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-2-git-send-email-yi.y.sun@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f330e49a-0bf4-08c7-8e24-04606ec4819e@linux.intel.com>
Date: Wed, 28 Oct 2020 12:50:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603849018-6578-2-git-send-email-yi.y.sun@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Yi,

On 10/28/20 9:36 AM, Yi Sun wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Should get correct sid and set it into sdev. Because we execute
> 'sdev->sid != req->rid' in the loop of prq_event_thread().

How about making the title more accurate, how about something like:

iommu/vt-d: Fix use before set issue in intel_svm_bind_gpasid()

> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>   drivers/iommu/intel/svm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index f1861fa..75d9dc9 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -277,6 +277,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   			  struct iommu_gpasid_bind_data *data)
>   {
>   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> +	struct device_domain_info *info;
>   	struct intel_svm_dev *sdev = NULL;
>   	struct dmar_domain *dmar_domain;
>   	struct intel_svm *svm = NULL;
> @@ -357,6 +358,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   		goto out;
>   	}
>   	sdev->dev = dev;
> +	info = get_domain_info(dev);
> +	sdev->sid = PCI_DEVID(info->bus, info->devfn);
>   
>   	/* Only count users if device has aux domains */
>   	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> 

How about moving get_domain_info() up to the sanity check part?

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f1861fa3d0e4..75846692f2f2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -279,6 +279,7 @@ int intel_svm_bind_gpasid(struct iommu_domain 
*domain, struct device *dev,
         struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
         struct intel_svm_dev *sdev = NULL;
         struct dmar_domain *dmar_domain;
+       struct device_domain_info *info;
         struct intel_svm *svm = NULL;
         int ret = 0;

@@ -310,6 +311,10 @@ int intel_svm_bind_gpasid(struct iommu_domain 
*domain, struct device *dev,
         if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
                 return -EINVAL;

+       info = get_domain_info(dev);
+       if (!info)
+               return -EINVAL;
+
         dmar_domain = to_dmar_domain(domain);

         mutex_lock(&pasid_mutex);
@@ -357,6 +362,7 @@ int intel_svm_bind_gpasid(struct iommu_domain 
*domain, struct device *dev,
                 goto out;
         }
         sdev->dev = dev;
+       sdev->sid = PCI_DEVID(info->bus, info->devfn);

         /* Only count users if device has aux domains */
         if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
