Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31251C4363A
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 12:55:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E441206ED
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 12:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E441206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C82C1860AD;
	Fri, 30 Oct 2020 12:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ooOkHHBggfpz; Fri, 30 Oct 2020 12:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6991885F44;
	Fri, 30 Oct 2020 12:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20C6CC088B;
	Fri, 30 Oct 2020 12:55:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B46E2C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 12:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 91C3F20416
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 12:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBNsIhQ9JjwQ for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 12:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 02522203EE
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 12:55:01 +0000 (UTC)
IronPort-SDR: aVlykGNyjuViaudV7pEFgOvghXvz8d8fstdliY1b4ZOQRrFxQH3ZOdYko9MhZzvIhzugaLkNE9
 A1dDH1HtizIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="166014591"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; d="scan'208";a="166014591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2020 05:55:01 -0700
IronPort-SDR: EQEJIWfEwF9HnjLzf2NvqY/yF+Agy3SzVDSC7NzNZ1QYd5tQlCOS0evb1dYdDAnpIcJJ8EI9ba
 n1f5Ha+xYAiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; d="scan'208";a="425338716"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2020 05:54:56 -0700
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Fix sid not set issue in
 intel_svm_bind_gpasid()
To: Yi Sun <yi.y.sun@linux.intel.com>, joro@8bytes.org, dwmw2@infradead.org,
 jean-philippe@linaro.org
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
 <1604025444-6954-2-git-send-email-yi.y.sun@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fa69b000-b790-ae8c-2a40-618ca2631ac4@linux.intel.com>
Date: Fri, 30 Oct 2020 20:48:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604025444-6954-2-git-send-email-yi.y.sun@linux.intel.com>
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

On 10/30/20 10:37 AM, Yi Sun wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Should get correct sid and set it into sdev. Because we execute
> 'sdev->sid != req->rid' in the loop of prq_event_thread().
> 
> Fixes: eb8d93ea3c1d ("iommu/vt-d: Report page request faults for guest SVA")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Cc: stable@ver.kernel.org
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index f1861fa..7584669 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -279,6 +279,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>   	struct intel_svm_dev *sdev = NULL;
>   	struct dmar_domain *dmar_domain;
> +	struct device_domain_info *info;
>   	struct intel_svm *svm = NULL;
>   	int ret = 0;
>   
> @@ -310,6 +311,10 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
>   		return -EINVAL;
>   
> +	info = get_domain_info(dev);
> +	if (!info)
> +		return -EINVAL;
> +
>   	dmar_domain = to_dmar_domain(domain);
>   
>   	mutex_lock(&pasid_mutex);
> @@ -357,6 +362,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   		goto out;
>   	}
>   	sdev->dev = dev;
> +	sdev->sid = PCI_DEVID(info->bus, info->devfn);
>   
>   	/* Only count users if device has aux domains */
>   	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
