Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4377C43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 11:22:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1594920684
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 11:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1594920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 83E352E19F;
	Thu, 10 Sep 2020 11:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WuA0wXDIwiB6; Thu, 10 Sep 2020 11:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5293D204B0;
	Thu, 10 Sep 2020 11:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 432C7C0052;
	Thu, 10 Sep 2020 11:22:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 994F7C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 80258875B9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZ8lEjPdG259 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:22:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8106E875B6
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:22:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95571045;
 Thu, 10 Sep 2020 04:22:49 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1938A3F68F;
 Thu, 10 Sep 2020 04:22:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] dma-mapping: remove the dma_dummy_ops export
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20200908163959.3177173-1-hch@lst.de>
 <20200908163959.3177173-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5b2dc452-7005-1ff3-6ab5-a9fc03345485@arm.com>
Date: Thu, 10 Sep 2020 12:22:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908163959.3177173-2-hch@lst.de>
Content-Language: en-GB
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

On 2020-09-08 17:39, Christoph Hellwig wrote:
> dma_dummy_ops is only used by the ACPI code, which can't be modular.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/dummy.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
> index 05607642c888d9..6974b1bd7d0b88 100644
> --- a/kernel/dma/dummy.c
> +++ b/kernel/dma/dummy.c
> @@ -36,4 +36,3 @@ const struct dma_map_ops dma_dummy_ops = {
>   	.map_sg                 = dma_dummy_map_sg,
>   	.dma_supported          = dma_dummy_supported,
>   };
> -EXPORT_SYMBOL(dma_dummy_ops);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
