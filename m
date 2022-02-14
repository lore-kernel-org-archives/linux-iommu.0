Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9D8C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB72B828AA;
	Mon, 14 Feb 2022 12:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqpyQ54e-aCQ; Mon, 14 Feb 2022 12:32:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC38181432;
	Mon, 14 Feb 2022 12:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FEF6C0011;
	Mon, 14 Feb 2022 12:32:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C132C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0F2560F1D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dExy15pViD4B for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:32:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5312060F18
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:32:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6694C1396;
 Mon, 14 Feb 2022 04:32:27 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572EB3F718;
 Mon, 14 Feb 2022 04:32:26 -0800 (PST)
Message-ID: <c95e5d3a-d2b4-dcc1-b6ba-2e4e9ebc5bb0@arm.com>
Date: Mon, 14 Feb 2022 12:32:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, Jiasheng Jiang <jiasheng@iscas.ac.cn>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
 <YgpAfVVhkNljJhJY@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YgpAfVVhkNljJhJY@8bytes.org>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 iommu@lists.linux-foundation.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, will@kernel.org,
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

On 2022-02-14 11:43, Joerg Roedel wrote:
> Adding more potential reviewers.
> 
> On Thu, Jan 06, 2022 at 10:43:02AM +0800, Jiasheng Jiang wrote:
>> Because of the possible failure of the dma_supported(), the
>> dma_set_mask_and_coherent() may return error num.
>> Therefore, it should be better to check it and return the error if
>> fails.

In this particular case it cannot fail on any system the driver actually 
runs on - it's a platform device so the dma_mask pointer is always 
initialised, then dma_direct_supported() on arm64 will always return 
true for any mask wider than 32 bits, while arm_dma_supported() will 
also always pass since a 32-bit system cannot have memory above 40 bits 
either.

There's no great harm in adding the check for the sake of consistency, I 
guess, but it's purely cosmetic and not fixing anything.

Thanks,
Robin.

>> Fixes: 1c894225bf5b ("iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>   drivers/iommu/ipmmu-vmsa.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index aaa6a4d59057..7df5da44a004 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -1003,7 +1003,9 @@ static int ipmmu_probe(struct platform_device *pdev)
>>   	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>>   	mmu->features = of_device_get_match_data(&pdev->dev);
>>   	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
>> -	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>> +	if (ret)
>> +		return ret;
>>   
>>   	/* Map I/O memory and request IRQ. */
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -- 
>> 2.25.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
