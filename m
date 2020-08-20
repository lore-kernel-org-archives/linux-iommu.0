Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31696C433E1
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 13:10:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0252D207BB
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 13:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0252D207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A1B4B220E5;
	Thu, 20 Aug 2020 13:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucYOFtMpUbCz; Thu, 20 Aug 2020 13:10:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3F2692107A;
	Thu, 20 Aug 2020 13:10:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFFAC088E;
	Thu, 20 Aug 2020 13:10:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 910F0C07FF
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6FEFD220E5
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id voi6pETW70T6 for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 13:10:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 4818C2107A
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:10:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D8D31B;
 Thu, 20 Aug 2020 06:10:09 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 797223F6CF;
 Thu, 20 Aug 2020 06:10:07 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: permit users to disable msi
 polling
To: Barry Song <song.bao.hua@hisilicon.com>, will@kernel.org, joro@8bytes.org
References: <20200818233827.21452-1-song.bao.hua@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6215bf9b-e137-ac84-ed8e-f6e8983bb1b1@arm.com>
Date: Thu, 20 Aug 2020 14:10:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818233827.21452-1-song.bao.hua@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 prime.zeng@hisilicon.com, linuxarm@huawei.com
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

On 2020-08-19 00:38, Barry Song wrote:
> patch 1/3 and patch 2/3 are the preparation of patch 3/3 which permits users
> to disable MSI-based polling by cmd line.
> 
> -v4:
>    with respect to Robin's comments
>    * cleanup the code of the existing module parameter disable_bypass
>    * add ARM_SMMU_OPT_MSIPOLL flag. on the other hand, we only need to check
>      a bit in options rather than two bits in features

Thanks Barry - for all 3 patches,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'd be inclined to squash #2 into #1, but I'll leave that up to Will.

Cheers,
Robin.

> 
> Barry Song (3):
>    iommu/arm-smmu-v3: replace symbolic permissions by octal permissions
>      for module parameter
>    iommu/arm-smmu-v3: replace module_param_named by module_param for
>      disable_bypass
>    iommu/arm-smmu-v3: permit users to disable msi polling
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
