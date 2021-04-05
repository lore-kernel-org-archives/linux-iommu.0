Return-Path: <SRS0=tsXo=JC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A91C433B4
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 06:09:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537AC61395
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 06:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537AC61395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1CA64022C;
	Mon,  5 Apr 2021 06:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEbd7hs7qfJk; Mon,  5 Apr 2021 06:09:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04605401CE;
	Mon,  5 Apr 2021 06:09:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6D33C000C;
	Mon,  5 Apr 2021 06:09:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43E56C000A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 06:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B22940226
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 06:09:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mr6T3RYax4D8 for <iommu@lists.linux-foundation.org>;
 Mon,  5 Apr 2021 06:09:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BACB5401CE
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 06:09:31 +0000 (UTC)
IronPort-SDR: LLA8IvR4izTuivMsYeZiskHx10tfiL3iuy9hLQmykWEiprRil0duh+qHnHCiwf6LSWARaZlJFU
 vM/g9vDTsWHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9944"; a="256768682"
X-IronPort-AV: E=Sophos;i="5.81,305,1610438400"; d="scan'208";a="256768682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2021 23:09:30 -0700
IronPort-SDR: E7sR6tD/Szb+4pKym881v9kliQ88+lQU3eAZ0MEszuYnTRtEULAY7/peo0U4Aull1oVhg+pJcU
 m0LApbx8tiRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,305,1610438400"; d="scan'208";a="440392644"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2021 23:09:28 -0700
Subject: Re: [PATCH v2 07/12] iommu: Hook up '->unmap_pages' driver callback
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20210402013452.4013-1-isaacm@codeaurora.org>
 <20210402013452.4013-8-isaacm@codeaurora.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0d1a6c6b-c523-8868-99c5-51c6a1e40cc4@linux.intel.com>
Date: Mon, 5 Apr 2021 14:00:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210402013452.4013-8-isaacm@codeaurora.org>
Content-Language: en-US
Cc: robin.murphy@arm.com, Will Deacon <will@kernel.org>, pratikp@codeaurora.org
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

On 4/2/21 9:34 AM, Isaac J. Manjarres wrote:
>   static size_t __iommu_unmap(struct iommu_domain *domain,
>   			    unsigned long iova, size_t size,
>   			    struct iommu_iotlb_gather *iotlb_gather)
> @@ -2476,7 +2519,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	unsigned long orig_iova = iova;
>   	unsigned int min_pagesz;
>   
> -	if (unlikely(ops->unmap == NULL ||
> +	if (unlikely((ops->unmap == NULL && ops->unmap_pages == NULL) ||
>   		     domain->pgsize_bitmap == 0UL))

This change should also be applied to __iommu_map() path. And perhaps
could be:

	if (unlikely(!(ops->unmap || ops->unmap_pages) || !domain->pgsize_bitmap))

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
