Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347BBC63697
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 15:19:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64E221D46
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 15:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64E221D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D5DE87735;
	Thu, 26 Nov 2020 15:19:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IPDPyUFQfa7W; Thu, 26 Nov 2020 15:19:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A515F87749;
	Thu, 26 Nov 2020 15:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 884B8C0891;
	Thu, 26 Nov 2020 15:19:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4320C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 15:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 96F2E1FFFF
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 15:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M33Du7icztpG for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 15:19:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id C58AA2E25E
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 15:19:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC2631B;
 Thu, 26 Nov 2020 07:19:32 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47AEB3F71F;
 Thu, 26 Nov 2020 07:19:30 -0800 (PST)
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cbc9763b-aa7e-aea9-2a21-315dfdd2c407@arm.com>
Date: Thu, 26 Nov 2020 15:19:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201120090628.6566-1-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On 2020-11-20 09:06, Yong Wu wrote:
> Currently direct_mapping always use the smallest pgsize which is SZ_4K
> normally to mapping. This is unnecessary. we could gather the size, and
> call iommu_map then, iommu_map could decide how to map better with the
> just right pgsize.
> 
>  From the original comment, we should take care overlap, otherwise,
> iommu_map may return -EEXIST. In this overlap case, we should map the
> previous region before overlap firstly. then map the left part.
> 
> Each a iommu device will call this direct_mapping when its iommu
> initialize, This patch is effective to improve the boot/initialization
> time especially while it only needs level 1 mapping.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/iommu.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index df87c8e825f7..854a8fcb928d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   	/* We need to consider overlapping regions for different devices */
>   	list_for_each_entry(entry, &mappings, list) {
>   		dma_addr_t start, end, addr;
> +		size_t unmapped_sz = 0;
>   
>   		if (domain->ops->apply_resv_region)
>   			domain->ops->apply_resv_region(dev, domain, entry);
> @@ -752,10 +753,25 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   			phys_addr_t phys_addr;
>   
>   			phys_addr = iommu_iova_to_phys(domain, addr);
> -			if (phys_addr)
> +			if (phys_addr == 0) {
> +				unmapped_sz += pg_size; /* Gather the size. */
>   				continue;
> +			}

I guess the reason we need to validate every page is because they may 
already have been legitimately mapped if someone else's reserved region 
overlaps - is it worth explicitly validating that, i.e. bail out if 
something's gone wrong enough that phys_addr != addr?

Other than the naming issue (I agree that map_size is a far, far better 
choice), I don't have any strong opinions about the rest of the 
implementation - I've written enough variations of this pattern to know 
that there's just no "nice" way to do it in C; all you can do is shuffle 
the clunkiness around :)

Robin.

>   
> -			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
> +			if (unmapped_sz) {
> +				/* Map the region before the overlap. */
> +				ret = iommu_map(domain, start, start,
> +						unmapped_sz, entry->prot);
> +				if (ret)
> +					goto out;
> +				start += unmapped_sz;
> +				unmapped_sz = 0;
> +			}
> +			start += pg_size;
> +		}
> +		if (unmapped_sz) {
> +			ret = iommu_map(domain, start, start, unmapped_sz,
> +					entry->prot);
>   			if (ret)
>   				goto out;
>   		}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
