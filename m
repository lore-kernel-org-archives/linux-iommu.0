Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38563C432BE
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:15:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E081561077
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E081561077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8325140219;
	Thu, 29 Jul 2021 07:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ny6Pks40FAJn; Thu, 29 Jul 2021 07:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B1B0400E6;
	Thu, 29 Jul 2021 07:15:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B8EC0010;
	Thu, 29 Jul 2021 07:15:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9250EC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AB2783A50
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:15:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zOtYD6E26Ei5 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B06783A49
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:15:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234711135"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; d="scan'208";a="234711135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 00:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; d="scan'208";a="464977711"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 00:15:33 -0700
Subject: Re: [PATCH v2 18/24] iommu: Express DMA strictness via the domain type
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
Date: Thu, 29 Jul 2021 15:13:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
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

Hi Robin,

On 7/28/21 11:58 PM, Robin Murphy wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 982545234cf3..eecb5657de69 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -136,6 +136,9 @@ static int __init iommu_subsys_init(void)
>   		}
>   	}
>   
> +	if (!iommu_default_passthrough() && !iommu_dma_strict)
> +		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;

iommu_dma_strict could be changed later by the vendor iommu driver via
iommu_set_dma_strict(). This seems not to be the right place to set
iommu_def_domain_type.

> +
>   	pr_info("Default domain type: %s %s\n",
>   		iommu_domain_type_str(iommu_def_domain_type),
>   		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
