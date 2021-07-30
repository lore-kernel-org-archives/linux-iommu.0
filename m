Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5034EC432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:14:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028556101C
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 028556101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2533606EB;
	Fri, 30 Jul 2021 06:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxzcMK6n-H1O; Fri, 30 Jul 2021 06:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5C9B6063F;
	Fri, 30 Jul 2021 06:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB8ECC001A;
	Fri, 30 Jul 2021 06:14:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50303C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30F234027D
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pno5DMc_Zl7d for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:14:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1C2340212
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:14:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="213070402"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="213070402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465345547"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:14:37 -0700
Subject: Re: [PATCH v2 24/24] iommu: Only log strictness for DMA domains
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <b2da9ba999b54acded9198cf92cf9b7d0fce1b45.1627468310.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7a071314-ee88-fcff-baf0-fb8e33a86dd4@linux.intel.com>
Date: Fri, 30 Jul 2021 14:12:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b2da9ba999b54acded9198cf92cf9b7d0fce1b45.1627468310.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 7/28/21 11:58 PM, Robin Murphy wrote:
> When passthrough is enabled, the default strictness policy becomes
> irrelevant, since any subsequent runtime override to a DMA domain type
> now embodies an explicit choice of strictness as well. Save on noise by
> only logging the default policy when it is meaningfully in effect.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index be399d630953..87d7b299436e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -144,10 +144,11 @@ static int __init iommu_subsys_init(void)
>   		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
>   			"(set via kernel command line)" : "");
>   
> -	pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
> -		iommu_dma_strict ? "strict" : "lazy",
> -		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
> -			"(set via kernel command line)" : "");
> +	if (!iommu_default_passthrough())
> +		pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
> +			iommu_dma_strict ? "strict" : "lazy",
> +			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
> +				"(set via kernel command line)" : "");
>   
>   	return 0;
>   }
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
