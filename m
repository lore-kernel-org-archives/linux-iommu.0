Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45435C433E3
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 00:59:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CAE2070C
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 00:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CAE2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E5ACE251AE;
	Thu,  2 Jul 2020 00:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOQg8D6+AAwJ; Thu,  2 Jul 2020 00:59:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0075C24CBC;
	Thu,  2 Jul 2020 00:59:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC027C0865;
	Thu,  2 Jul 2020 00:59:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78B40C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 00:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 58CFC24CEB
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 00:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohjNybONLafk for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 00:59:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 3D1FE24CBC
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 00:59:37 +0000 (UTC)
IronPort-SDR: 5RukQ49Xf5UEKuVX6hPjWc+Q6u/xPHFsWTHAvNiR86JMx9yogNNt+5ELLqF4C4yeIn3zSwueey
 psbT5GlgodhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="145840520"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; d="scan'208";a="145840520"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 17:59:36 -0700
IronPort-SDR: k5ecF3Q6zcI3nWdx6Qxil4zw34HSk4hd+mydaYVi7w6tm8PQg46p6c+8WxquLmwqn9ztPbCacq
 Z4wN3zre0KZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; d="scan'208";a="304061442"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 17:59:34 -0700
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Warn on out-of-range invalidation
 address
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-7-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a960a831-e763-6ee6-e012-64f8acb365b6@linux.intel.com>
Date: Thu, 2 Jul 2020 08:55:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

On 7/1/20 11:33 PM, Jacob Pan wrote:
> For guest requested IOTLB invalidation, address and mask are provided as
> part of the invalidation data. VT-d HW silently ignores any address bits
> below the mask. SW shall also allow such case but give warning if
> address does not align with the mask. This patch relax the fault
> handling from error to warning and proceed with invalidation request
> with the given mask.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6a0c62c7395c..2e1b53ade784 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   
>   		switch (BIT(cache_type)) {
>   		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			/* HW will ignore LSB bits based on address mask */
>   			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
>   			    size &&
>   			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> -				pr_err_ratelimited("Address out of range, 0x%llx, size order %llu\n",
> -						   inv_info->addr_info.addr, size);
> -				ret = -ERANGE;
> -				goto out_unlock;
> +				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
> +					  inv_info->addr_info.addr, size);
>   			}
>   
>   			/*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
