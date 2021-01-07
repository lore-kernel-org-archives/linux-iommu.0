Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC2EC433E0
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 01:26:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E569223123
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 01:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E569223123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C29686599;
	Thu,  7 Jan 2021 01:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-7KfpU_71A9; Thu,  7 Jan 2021 01:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA3C286591;
	Thu,  7 Jan 2021 01:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC6FCC088B;
	Thu,  7 Jan 2021 01:26:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8815BC013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 01:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 59891203E7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 01:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fsUfhlCtpRT for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 01:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 48F3A20373
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 01:26:11 +0000 (UTC)
IronPort-SDR: XlFfcEf5P/n9ck8iooegl8pGFQAlX4Vbs0MSgojFmzV1QfCcbhWnrVBcOU8VZxLFvLvp9UfWuv
 6EAnQDYO8lBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="195911841"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; d="scan'208";a="195911841"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2021 17:26:08 -0800
IronPort-SDR: jzL1YFjGafPDx2idGwAvsKr+rzjXe8L4W+nKAGn8kVJJUaezW9UBr/wrA/0qzDVUpWj5XdPucn
 2HTqzuAMQ5pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; d="scan'208";a="462860266"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2021 17:26:04 -0800
Subject: Re: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
 <1609940111-28563-7-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
Date: Thu, 7 Jan 2021 09:18:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609940111-28563-7-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/6/21 9:35 PM, John Garry wrote:
> Function iommu_dev_has_feature() has never been referenced in the tree,
> and there does not appear to be anything coming soon to use it, so delete
> it.

It will be used by the device driver which want to support the aux-
domain capability, for example, below series is under discussion.

https://lore.kernel.org/linux-pci/160408357912.912050.17005584526266191420.stgit@djiang5-desk3.ch.intel.com/

The typical use case is

         if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
                 rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX);
                 if (rc < 0) {
                         dev_warn(dev, "Failed to enable aux-domain: 
%d\n", rc);
                         return rc;
                 }
         }

So please don't remove it.

Best regards,
baolu

> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iommu.c | 11 -----------
>   include/linux/iommu.h |  7 -------
>   2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 20201ef97b8f..91f7871f5a37 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2853,17 +2853,6 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>   /*
>    * Per device IOMMU features.
>    */
> -bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
> -{
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> -
> -	if (ops && ops->dev_has_feat)
> -		return ops->dev_has_feat(dev, feat);
> -
> -	return false;
> -}
> -EXPORT_SYMBOL_GPL(iommu_dev_has_feature);
> -
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 72059fcfa108..91d94c014f47 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -626,7 +626,6 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>   int iommu_probe_device(struct device *dev);
>   void iommu_release_device(struct device *dev);
>   
> -bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>   bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
> @@ -975,12 +974,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>   	return NULL;
>   }
>   
> -static inline bool
> -iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
> -{
> -	return false;
> -}
> -
>   static inline bool
>   iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
