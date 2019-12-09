Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D28C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 12:55:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5B42077B
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 12:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0366F86D95;
	Mon,  9 Dec 2019 12:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id feUUQ5P-LqQ8; Mon,  9 Dec 2019 12:55:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4A0F81FA0;
	Mon,  9 Dec 2019 12:55:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA2FCC1796;
	Mon,  9 Dec 2019 12:55:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69425C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 12:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F359880CC
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 12:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YSIhExx-XZgy for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 12:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 970BC880CA
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 12:55:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2910328;
 Mon,  9 Dec 2019 04:55:25 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606613F718;
 Mon,  9 Dec 2019 04:55:25 -0800 (PST)
Subject: Re: [PATCH] iommu/dma: Map MSI doorbell with iommu_map_atomic()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
References: <20191209123825.137391-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c44950e6-648c-3f71-9f12-d70d17de9f4a@arm.com>
Date: Mon, 9 Dec 2019 12:55:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209123825.137391-1-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: jroedel@suse.de
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

On 09/12/2019 12:38 pm, Jean-Philippe Brucker wrote:
> Since commit 781ca2de89ba ("iommu: Add gfp parameter to
> iommu_ops::map"), iommu_map() might sleep. iommu_dma_get_msi_page() runs
> in atomic context and thus should call iommu_map_atomic() instead.

Spooky... I'm rebasing my local branches and this arrived at the exact 
moment I came across my fix[1] that I'd otherwise forgotten about. As 
covered there, this really doesn't need to be atomic at all now, so I'd 
prefer to see it cleaned up more thoroughly.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/5af5e77102ca52576cb96816f0abcf6398820055.1571245656.git.robin.murphy@arm.com/

> Fixes: 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0cc702a70a96..f5add956641d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1184,7 +1184,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	if (!iova)
>   		goto out_free_page;
>   
> -	if (iommu_map(domain, iova, msi_addr, size, prot))
> +	if (iommu_map_atomic(domain, iova, msi_addr, size, prot))
>   		goto out_free_iova;
>   
>   	INIT_LIST_HEAD(&msi_page->list);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
