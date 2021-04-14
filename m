Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65CC433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 05:33:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BFD61242
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 05:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BFD61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 631AB84629;
	Wed, 14 Apr 2021 05:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNIZFiWIugMl; Wed, 14 Apr 2021 05:33:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46F2084604;
	Wed, 14 Apr 2021 05:33:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC88C000B;
	Wed, 14 Apr 2021 05:33:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A4B2C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 05:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00AED401EC
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 05:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cMUgAvb82SK for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 05:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E299640F0F
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 05:33:47 +0000 (UTC)
IronPort-SDR: i7xO7oQBnZY/jdnSE+b+mVAXinrCe4qpltvJ69odXPmZXmK9G7AVBuniw7g+OgM+sv/2DEFWg5
 A6q95PjR1GQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194680939"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; d="scan'208";a="194680939"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2021 22:33:46 -0700
IronPort-SDR: 0SQIb/JLxSHbcLOZLryhl6PMjIY4xMOaZNxAyQASAFxpnHCbd/ZGhae5wowrVK9lPvm53ZUXfK
 V+TOJYQxRwcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; d="scan'208";a="443689817"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2021 22:33:43 -0700
Subject: Re: [PATCH][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210413195409.GA322376@embeddedor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <61b37f83-eb9e-cf81-c5e6-ca322f76f490@linux.intel.com>
Date: Wed, 14 Apr 2021 13:24:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413195409.GA322376@embeddedor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
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

Hi Gustavo,

On 4/14/21 3:54 AM, Gustavo A. R. Silva wrote:
> Replace call to memcpy() with just a couple of simple assignments in
> order to fix the following out-of-bounds warning:
> 
> drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
> 
> The problem is that the original code is trying to copy data into a
> couple of struct members adjacent to each other in a single call to
> memcpy(). This causes a legitimate compiler warning because memcpy()
> overruns the length of &desc.qw2.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/iommu/intel/svm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 5165cea90421..65909f504c50 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1194,9 +1194,10 @@ int intel_svm_page_response(struct device *dev,
>   		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
>   		desc.qw2 = 0;
>   		desc.qw3 = 0;
> -		if (private_present)
> -			memcpy(&desc.qw2, prm->private_data,
> -			       sizeof(prm->private_data));

The same memcpy() is used in multiple places in this file. Did they
compile the same warnings? Or there are multiple patches to fix them
one by one?

Best regards,
baolu

> +		if (private_present) {
> +			desc.qw2 = prm->private_data[0];
> +			desc.qw3 = prm->private_data[1];
> +		}
>   
>   		qi_submit_sync(iommu, &desc, 1, 0);
>   	}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
