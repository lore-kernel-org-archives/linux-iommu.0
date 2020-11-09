Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C284FC2D0A3
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 11:43:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F19A20789
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 11:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F19A20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 84C7A8557B;
	Mon,  9 Nov 2020 11:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6+zq3kEoLy7; Mon,  9 Nov 2020 11:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4543F82534;
	Mon,  9 Nov 2020 11:43:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E381C0889;
	Mon,  9 Nov 2020 11:43:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1EB1C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 11:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 984FE20519
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 11:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 64tWJC8rusyv for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 11:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 2522720517
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 11:43:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9901106F;
 Mon,  9 Nov 2020 03:43:36 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE423F718;
 Mon,  9 Nov 2020 03:43:32 -0800 (PST)
Subject: Re: [PATCH] dma-pool: no need to check return value of debugfs_create
 functions
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <936ffd36-8814-a8d2-ab94-3edc0642e5a7@arm.com>
Date: Mon, 9 Nov 2020 11:43:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Xuefeng Li <lixuefeng@loongson.cn>,
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

On 2020-11-07 10:03, Tiezhu Yang wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Well, the only difference in behaviour is that it won't attempt to call 
further debugfs functions if they're definitely going to fail anyway, so 
no "real" logic is affected. AFAICS it's not possible for 
debugfs_create_dir() to return NULL, so this check makes no practical 
difference, just means that if it did ever fail we would save a bit of 
unnecessary work by not subsequently calling all the way down to the "if 
(IS_ERR(parent))" check in start_creating() several times.

So the given justification is a little overdramatic for this particular 
situation, when it's really just that it's not worth optimising an 
unexpected failure case, but the change itself is obviously fine.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   kernel/dma/pool.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index d4637f7..5f84e6c 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -38,9 +38,6 @@ static void __init dma_atomic_pool_debugfs_init(void)
>   	struct dentry *root;
>   
>   	root = debugfs_create_dir("dma_pools", NULL);
> -	if (IS_ERR_OR_NULL(root))
> -		return;
> -
>   	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
>   	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
>   	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
