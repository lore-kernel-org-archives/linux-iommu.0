Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02BC433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:45:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E205610FB
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E205610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F109A607CA;
	Fri,  9 Apr 2021 12:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HFnae0MJKP9x; Fri,  9 Apr 2021 12:45:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id F15F260750;
	Fri,  9 Apr 2021 12:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1151C000B;
	Fri,  9 Apr 2021 12:45:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83B32C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DB32607CA
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHVmbexH0QB2 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 12:45:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 946E760750
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:45:30 +0000 (UTC)
IronPort-SDR: iqB9PnCN9uDfUQbvbOHO9V6tbF6rh8DRA9M5YHkIv1MFd9TWYttpROjxFT0gbjUuwQX/79GWzK
 zwVdwk8scJEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="255085454"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; d="scan'208";a="255085454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 05:45:28 -0700
IronPort-SDR: J94+ZmKkZJjSqlr6+lLmCF0kmDHnfTMyeqpMal5eYal2X3t1/7Vx23ZOjTVO5Gd4Jiz6cdcNwj
 ZkM2sWPffxmA==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; d="scan'208";a="422714028"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.245])
 ([10.254.211.245])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 05:45:25 -0700
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f29495e1-e3a0-8c45-bfca-067c1e996eca@linux.intel.com>
Date: Fri, 9 Apr 2021 20:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org
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

Hi,

On 2021/4/9 1:08, Jacob Pan wrote:
>   /**
>    * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
>    * @min: minimum PASID value (inclusive)
>    * @max: maximum PASID value (inclusive)
>    *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> + * Try to allocate a PASID for the current mm, or take a reference to the
> + * existing one provided it fits within the [@min, @max] range. On success
> + * the PASID is available in the current mm->pasid, and must be released with
> + * iommu_sva_free_pasid().
>    * @min must be greater than 0, because 0 indicates an unused mm->pasid.
>    *
>    * Returns 0 on success and < 0 on error.
>    */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
>   {
>   	int ret = 0;
>   	ioasid_t pasid;
> +	struct mm_struct *mm;
>   
>   	if (min == INVALID_IOASID || max == INVALID_IOASID ||
>   	    min == 0 || max < min)
>   		return -EINVAL;
>   
>   	mutex_lock(&iommu_sva_lock);
> +	mm = get_task_mm(current);

How could we allocate a supervisor PASID through iommu_sva_alloc_pasid()
if we always use current->mm here?

> +	if (!mm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
>   	if (mm->pasid) {
>   		if (mm->pasid >= min && mm->pasid <= max)
>   			ioasid_get(mm->pasid);
> @@ -45,22 +51,32 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   		else
>   			mm->pasid = pasid;
>   	}
> +	mmput(mm);
> +out_unlock:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
