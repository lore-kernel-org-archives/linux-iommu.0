Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899DBC433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 15:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1095060794;
	Wed,  8 Dec 2021 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coJtlrOXXXNB; Wed,  8 Dec 2021 15:45:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF1916070D;
	Wed,  8 Dec 2021 15:45:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A694CC002F;
	Wed,  8 Dec 2021 15:45:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED07C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FC16824E3
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxQwbsCJ28Tk for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:45:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCD17824DC
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:02 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20211208154500euoutp02ed75ba014813f18cb633720e91e37980~_0hSYZUH50112101121euoutp02X
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20211208154500euoutp02ed75ba014813f18cb633720e91e37980~_0hSYZUH50112101121euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1638978300;
 bh=nIULE6ahW6qWz4c0HicGhVMHyFI42r3hYZP+a4mnHLE=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=tnPRHITtkWd2tAItRr3fj2wzNUsQPcM750hoJurFD5BAPKbVSxnfDNPnGflu9r8MW
 aKoQC/fxCcTX2GYScP1ABX9IJIAKNrgWMsYBIRL53yHWB+DofPf30D/1ukiwa9fl0L
 P+3ukqbtC1LrswBHYB1q1o7nxa6jijfP7GkGDCaI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20211208154500eucas1p27945477d88484fac84b8220c97493ae7~_0hSR4JUE1984119841eucas1p2I;
 Wed,  8 Dec 2021 15:45:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 12.34.10260.BF2D0B16; Wed,  8
 Dec 2021 15:45:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20211208154459eucas1p24743399c20b5d1fbc3f519d68d9660a6~_0hRtbIMW0691406914eucas1p22;
 Wed,  8 Dec 2021 15:44:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20211208154459eusmtrp1b30f31739ba02bb56e9b5f2e851b6c64~_0hRsysV71385013850eusmtrp1x;
 Wed,  8 Dec 2021 15:44:59 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-31-61b0d2fb8d7f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.76.09404.BF2D0B16; Wed,  8
 Dec 2021 15:44:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20211208154459eusmtip158924f93f0c17530d706815604e449a1~_0hRVyxgU3151031510eusmtip11;
 Wed,  8 Dec 2021 15:44:59 +0000 (GMT)
Message-ID: <4e0eafe8-075d-c249-0298-d2612faa5704@samsung.com>
Date: Wed, 8 Dec 2021 16:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 11/11] dma-direct: add a dma_direct_use_pool helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211111065028.32761-12-hch@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned0/lzYkGvRGWaxcfZTJYsF+a4u2
 JRuZLA5+eMLqwOKxZt4aRo8Fm0o9Jt9Yzuix+2YDWwBLFJdNSmpOZllqkb5dAlfGtIWFBTPF
 KrZ9WMbSwPhIsIuRk0NCwERi44bVzF2MXBxCAisYJRbO2cQI4XxhlPj9sJsNpEpI4DOjRPsa
 T5iOp0uXs0MULWeU2HOzhQ3C+cgosfvqGXaQKl4BO4mPS+YxgtgsAioSz759YIWIC0qcnPmE
 BcQWFUiSmHBiNxOILSzgLjH5YxPYNmYBcYlbT+aDxUUEXCSWP7jIAhH3lzj0fAEziM0mYCjR
 9bYLrJ4TyH78rB+qV15i+9s5YP9ICOzgkHh2eT4LxNkuEh97fkLZwhKvjm9hh7BlJE5P7mGB
 aGhmlHh4bi07hNPDKHG5aQYjRJW1xJ1zv4BWcACt0JRYv0sfIuwocWvNckaQsIQAn8SNt4IQ
 R/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLKVhmIXl/FpJ3ZiHsXcDIsopRPLW0
 ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwrZz+d/zrDsYVrz7qHWJk4mA8xCjBwawkwqv2cG2i
 EG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBiadnTz/Xtjr
 vuFc42+0+NXLt3Gq102KogQqLSX7Nx0LVMq68mO1hnqmy7kNH5asjnb02Wb3eqXipCWXo7x3
 KlfXpUn77u5732Yvlrpz/Rlnrl27LetDZh3VP7m670rR6XnnZ67blBr6KEpQ/KKALouSCIee
 56x4iXVOdw56/P+7uN9wEVvt5tzrMXrhYbNm6uRMEnuipFYwteEX9+tNOYKHL7e+ZhJofP94
 /91pFm6/I/JZLxXKXj/2Piv/ader3exTH/zvOvdv26YlN/TemjkkT+o9fFJa9Pqyio/rYt+o
 lhWvy98oOy337bQZh9YKhXYLzuVe4vc0/tOde3sOLFrNESR2XK//s3/xJOYPrAdMlFiKMxIN
 tZiLihMBP5Whq5oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7q/L21INJj4VM5i5eqjTBYL9ltb
 tC3ZyGRx8MMTVgcWjzXz1jB6LNhU6jH5xnJGj903G9gCWKL0bIryS0tSFTLyi0tslaINLYz0
 DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MqYtLCyYKVax7cMylgbGR4JdjJwcEgIm
 Ek+XLmfvYuTiEBJYyijRsPwBK0RCRuLktAYoW1jiz7UuNoii94wSB5omgCV4BewkPi6Zxwhi
 swioSDz79gEqLihxcuYTFhBbVCBJ4umBTjYQW1jAXWLyxyYwm1lAXOLWk/lMILaIgIvE8gcX
 WSDivhJruyaBzRESCJPo7lzJDGKzCRhKdL3tAuvlBLIfP+uHmmMm0bW1ixHClpfY/nYO8wRG
 oVlIzpiFZN0sJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERhJ24793LKDceWr
 j3qHGJk4GA8xSnAwK4nwqj1cmyjEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84GxnFcSb2hm
 YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwOS4YFV6tK3Z6dipLgVhF3/9
 maRztLZpvnXdLrm7O0z389U5/bp8S3qGwF7btJA/kzn+RD4LFXwUNVNHeO+JDpd5ejcX/LS/
 kG5S/UtHrGwHL+8zBm9vmWR2dze+lNwJ2tXR1vv1PlW9SZytfbnswp5GsUllT9hTnJ59mhCy
 0/5a0P3tb5Y+LTsskv/Mpp5vcqmm+7d976ulBFONVHblGKW+YJh7LmyL/8Y3iX+9rA980/1+
 NubCmsKqc0aJ548u0madZdUX9aAq8liwVVjwv5qWvw8VFPiFXy7aNb2udkX6te/fF2mGPTH5
 bRfh7JYvphNcELCbt8mR43PBuX0b5htM3rtl/eTrYbl/tndzv1ZiKc5INNRiLipOBAAy6XXO
 LQMAAA==
X-CMS-MailID: 20211208154459eucas1p24743399c20b5d1fbc3f519d68d9660a6
X-Msg-Generator: CA
X-RootMTR: 20211208154459eucas1p24743399c20b5d1fbc3f519d68d9660a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211208154459eucas1p24743399c20b5d1fbc3f519d68d9660a6
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-12-hch@lst.de>
 <CGME20211208154459eucas1p24743399c20b5d1fbc3f519d68d9660a6@eucas1p2.samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
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

Hi Christoph,

On 11.11.2021 07:50, Christoph Hellwig wrote:
> Add a helper to check if a potentially blocking operation should
> dip into the atomic pools.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   kernel/dma/direct.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 924937c54e8ab..d0a317ed8f029 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -156,6 +156,15 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   	return page;
>   }
>   
> +/*
> + * Check if a potentially blocking operations needs to dip into the atomic
> + * pools for the given device/gfp.
> + */
> +static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
> +{
> +	return gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
This should be:

return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);

otherwise all dma allocations fail badly on ARM64, what happens on today's linux-next (plenty of "Failed to get suitable pool for XYZ" messages).

Do you want me to send a fixup patch or would you simply fix it in your tree?

> +}
> +
>   static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp)
>   {
> @@ -235,8 +244,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		 */
>   		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
>   		if (remap) {
> -			if (!gfpflags_allow_blocking(gfp) &&
> -			    !is_swiotlb_for_alloc(dev))
> +			if (dma_direct_use_pool(dev, gfp))
>   				return dma_direct_alloc_from_pool(dev, size,
>   						dma_handle, gfp);
>   		} else {
> @@ -250,8 +258,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	 * Decrypting memory may block, so allocate the memory from the atomic
>   	 * pools if we can't block.
>   	 */
> -	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
> -	    !is_swiotlb_for_alloc(dev))
> +	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
>   	/* we always manually zero the memory once we are done */
> @@ -360,8 +367,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	struct page *page;
>   	void *ret;
>   
> -	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
> -	    !is_swiotlb_for_alloc(dev))
> +	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
>   	page = __dma_direct_alloc_pages(dev, size, gfp);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
