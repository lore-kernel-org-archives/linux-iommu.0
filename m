Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25AC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18696105A
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C18696105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92EA440259;
	Thu,  5 Aug 2021 07:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s8vgZK3PJpi2; Thu,  5 Aug 2021 07:19:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3177E401B4;
	Thu,  5 Aug 2021 07:19:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13062C001A;
	Thu,  5 Aug 2021 07:19:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2759C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 07:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFB8740259
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 07:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IVbkw-8x3lBP for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:19:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 789AB401B4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 07:19:27 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210805071925euoutp013c3382b3881e89ebb0896fada21cd73e~YV-LJ03tu2389023890euoutp01X
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 07:19:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210805071925euoutp013c3382b3881e89ebb0896fada21cd73e~YV-LJ03tu2389023890euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1628147965;
 bh=lQ7D6sXcucRemPw5Sk+qst0aIL0H5wxMDZeC1+ueYK8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=XVHzjwlYebSI7eO27lpM3T58yB9upB3Mcai2ZnsLijmOj07f0eEER0iwa1JD42DFE
 UzIW36fDbMgb/6zdnhfyGoXmDoLBz0EPRGlASZTFRvrdD0HCQkJVnBT3f29B9uBtYw
 7Iamq7fKY0FvS0EWT2R7VIrTDZYF/RbeOwl8Ay9o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210805071925eucas1p1c637846865fa9ce02c6f689b6e9686e5~YV-KtoQ_J2303623036eucas1p1s;
 Thu,  5 Aug 2021 07:19:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.10.45756.CF09B016; Thu,  5
 Aug 2021 08:19:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210805071924eucas1p21a01b7ed01000f6e83113ba7f8813e14~YV-KL3U_y2671826718eucas1p2u;
 Thu,  5 Aug 2021 07:19:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210805071924eusmtrp1e4e99d7311dc146e8a5bae4acc71e651~YV-KLGEfc2998329983eusmtrp1O;
 Thu,  5 Aug 2021 07:19:24 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-d5-610b90fcee54
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.1C.31287.CF09B016; Thu,  5
 Aug 2021 08:19:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210805071923eusmtip1b3097c7ead5eab6b5a77cf55f5543858~YV-JZggAN2899728997eusmtip1o;
 Thu,  5 Aug 2021 07:19:23 +0000 (GMT)
Subject: Re: [PATCH v3 05/25] iommu/exynos: Drop IOVA cookie management
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <28ba8847-b441-2937-7f9e-8b117abb6295@samsung.com>
Date: Thu, 5 Aug 2021 09:19:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fc13c3abc2939825f20ba4733ac8abb90b58528f.1628094601.git.robin.murphy@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87p/JnAnGvxdbWWxeeJWNovr164w
 WpxddpDNYsF+a4tN+5tYLTpnb2C32PT4GqvF5V1z2CxWrJrBaHHwwxNWi4k/FjBatNwxdeDx
 eHJwHpNH66W/bB5r5q1h9JjdcJHFY8GmUo/Hczeye7QcecvqsWlVJ5vHvJOBHpuX1HtMvrGc
 0ePzJrkAnigum5TUnMyy1CJ9uwSujCuXT7EUTBWpmHFlDksD43qBLkZODgkBE4lrZ9pZuxi5
 OIQEVjBKrHrWzAzhfGGUmPRpAhOE85lR4u+XF+wwLUue72ODSCxnlLjdcgWq5SOjxNPrH5hA
 qoQF3CV+zXsHZosIeEqc7d0BtoRZoIVJYuK6kywgCTYBQ4mut11sIDavgJ3Ein+LWEFsFgEV
 ic+P1oM1iwokS9w5/R6qRlDi5MwnYL2cAtES7/7PA7OZBeQltr+dwwxhi0vcejIf7G4JgdWc
 Ese/HGWCuNtF4sCp08wQtrDEq+NboP6RkTg9uYcFoqGZUeLhubXsEE4Po8TlphmMEFXWEnfO
 /QI6gwNohabE+l36EGFHiTWHzoOFJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09
 eOES8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMC0
 d/rf8U87GOe++qh3iJGJg/EQowQHs5IIb/JirkQh3pTEyqrUovz4otKc1OJDjNIcLErivKtm
 r4kXEkhPLEnNTk0tSC2CyTJxcEo1MMWE6pY+9KtcG7HKOlU9sfhB8ptkB7P8j7cMrv69KtAv
 +v5OQx5/zUWFVpkdfbY/mmbI3vTTZoq57qm8+X2dX3FCUY2R7y/mgzbvV2h9ThDdYeyvufWK
 dcIv4a6NUtLhT3TXsilrChauW/Nj7lr1hW3yXVP9tsiu+KvxUk/yqkZEmfu65fuyOnmnPtng
 xP7J3/DB6qgbp+wKvv8pz/byONi8cOuEXNbkmAyBvw/Mivzjbuse4jy56mFhh8it1KtffmyZ
 Lj5/N1/5lyNsPtsWFk669j6lSvPN85pzHp/3c7WVWrJoJvezKEziF7R0kSw4ZbRHdzef8dsC
 SR/vfp/GHU+fyqbplGx9vkZPVcpMiaU4I9FQi7moOBEAiOakGuoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7p/JnAnGly4IWaxeeJWNovr164w
 WpxddpDNYsF+a4tN+5tYLTpnb2C32PT4GqvF5V1z2CxWrJrBaHHwwxNWi4k/FjBatNwxdeDx
 eHJwHpNH66W/bB5r5q1h9JjdcJHFY8GmUo/Hczeye7QcecvqsWlVJ5vHvJOBHpuX1HtMvrGc
 0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9
 uwS9jCuXT7EUTBWpmHFlDksD43qBLkZODgkBE4klz/exgdhCAksZJZ7MNoCIy0icnNbACmEL
 S/y51gVUwwVU855R4tCTiWANwgLuEr/mvWMCsUUEPCXO9u5gBSliFmhhkjg0YS47RMcdRond
 zQ3sIFVsAoYSXW+7wLp5BewkVvxbBLaCRUBF4vOj9WCTRAWSJfq+TGCEqBGUODnzCQuIzSkQ
 LfHu/zwwm1nATGLe5ofMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1
 tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMq3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuFNXsyVKMSb
 klhZlVqUH19UmpNafIjRFOificxSosn5wDSTVxJvaGZgamhiZmlgamlmrCTOu3XumnghgfTE
 ktTs1NSC1CKYPiYOTqkGJhX2l3UK5Sf1P9YcetxY3/H3OEPJO4+orBN9O8/7T1jPdPIsz0SP
 jbd6tSu3B921aeJZGPBvOYfxtWS7Y8ePTd55jVflnWhFpcH6j2buEQryDC3On361J868PNVu
 hQD/jbmPvjwrD3t+4kVPbljf78vr3Wp7XrJ9iLvqfK9o8UOmRwuDntU0976yu31HyGbRv7wt
 5x/cDv383dltbjRvip11fuAt0xe32ziYf8Sw23NLdhTnKr7hWHyMRddM/reo69FLbsEp6XvN
 XeYFx148n3/uiNw/wyu9Pu8MU3Pmb5T+XCTNfDf6iUv+9Hy3BeoLGHV2h5lsnXtVM6/VQyrA
 IV6w4PPWmeKbuX6tb5qjpMRSnJFoqMVcVJwIAJJC00J7AwAA
X-CMS-MailID: 20210805071924eucas1p21a01b7ed01000f6e83113ba7f8813e14
X-Msg-Generator: CA
X-RootMTR: 20210804171621eucas1p2753f1185eb87c4a137e99e1ac2cc10d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210804171621eucas1p2753f1185eb87c4a137e99e1ac2cc10d3
References: <cover.1628094600.git.robin.murphy@arm.com>
 <CGME20210804171621eucas1p2753f1185eb87c4a137e99e1ac2cc10d3@eucas1p2.samsung.com>
 <fc13c3abc2939825f20ba4733ac8abb90b58528f.1628094601.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 04.08.2021 19:15, Robin Murphy wrote:
> The core code bakes its own cookies now.
>
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> v3: Also remove unneeded include
> ---
>   drivers/iommu/exynos-iommu.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index d0fbf1d10e18..939ffa768986 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -21,7 +21,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/slab.h>
> -#include <linux/dma-iommu.h>
>   
>   typedef u32 sysmmu_iova_t;
>   typedef u32 sysmmu_pte_t;
> @@ -735,20 +734,16 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
>   	/* Check if correct PTE offsets are initialized */
>   	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
>   
> +	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;
> +
>   	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>   	if (!domain)
>   		return NULL;
>   
> -	if (type == IOMMU_DOMAIN_DMA) {
> -		if (iommu_get_dma_cookie(&domain->domain) != 0)
> -			goto err_pgtable;
> -	} else if (type != IOMMU_DOMAIN_UNMANAGED) {
> -		goto err_pgtable;
> -	}
> -
>   	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
>   	if (!domain->pgtable)
> -		goto err_dma_cookie;
> +		goto err_pgtable;
>   
>   	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
>   	if (!domain->lv2entcnt)
> @@ -779,9 +774,6 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
>   	free_pages((unsigned long)domain->lv2entcnt, 1);
>   err_counter:
>   	free_pages((unsigned long)domain->pgtable, 2);
> -err_dma_cookie:
> -	if (type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&domain->domain);
>   err_pgtable:
>   	kfree(domain);
>   	return NULL;
> @@ -809,9 +801,6 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
>   
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   
> -	if (iommu_domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(iommu_domain);
> -
>   	dma_unmap_single(dma_dev, virt_to_phys(domain->pgtable), LV1TABLE_SIZE,
>   			 DMA_TO_DEVICE);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
