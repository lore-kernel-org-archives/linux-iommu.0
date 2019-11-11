Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915DBC43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 11:52:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5790521655
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 11:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5790521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02DA7C6C;
	Mon, 11 Nov 2019 11:52:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 61CE9B62
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 11:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D23988E3
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 11:52:43 +0000 (UTC)
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
	by Forcepoint Email with ESMTP id 3AEBA609B00C25622120;
	Mon, 11 Nov 2019 11:52:40 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
	lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP
	Server (TLS) id 14.3.408.0; Mon, 11 Nov 2019 11:52:39 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
	(10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5;
	Mon, 11 Nov 2019 11:52:39 +0000
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Don't display an error when IRQ
	lines are missing
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>
References: <20191111111721.4145919-1-jean-philippe@linaro.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <d0dfd82d-dcec-010c-6a69-c8f2b15f5c7a@huawei.com>
Date: Mon, 11 Nov 2019 11:52:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191111111721.4145919-1-jean-philippe@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
	lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: will@kernel.org, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 11/11/2019 11:17, Jean-Philippe Brucker wrote:
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
> to platform_get_irq*()"), platform_get_irq_byname() displays an error
> when the IRQ isn't found. Since the SMMUv3 driver uses that function to
> query which interrupt method is available, the message is now displayed
> during boot for any SMMUv3 that doesn't implement the combined
> interrupt, or that implements MSIs.
> 
> [   20.700337] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ combined not found
> [   20.706508] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ eventq not found
> [   20.712503] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ priq not found
> [   20.718325] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ gerror not found
> 
> Use platform_get_irq_byname_optional() to avoid displaying a spurious
> error.
> 
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

That stops a nuisance:
Tested-by: John Garry <john.garry@huawei.com>

However, I will say though that the combined irq seems necessary for 
TX2, which is not warned about being missing now.

Finally, A cover letter would have been handy to mention that the new 
API was only introduced after rc1

thanks

> ---
>   drivers/iommu/arm-smmu-v3.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index bfa4a0f39ed0..a89797f346a4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -5207,19 +5207,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   
>   	/* Interrupt lines */
>   
> -	irq = platform_get_irq_byname(pdev, "combined");
> +	irq = platform_get_irq_byname_optional(pdev, "combined");
>   	if (irq > 0)
>   		smmu->combined_irq = irq;
>   	else {
> -		irq = platform_get_irq_byname(pdev, "eventq");
> +		irq = platform_get_irq_byname_optional(pdev, "eventq");
>   		if (irq > 0)
>   			smmu->evtq.q.irq = irq;
>   
> -		irq = platform_get_irq_byname(pdev, "priq");
> +		irq = platform_get_irq_byname_optional(pdev, "priq");
>   		if (irq > 0)
>   			smmu->priq.q.irq = irq;
>   
> -		irq = platform_get_irq_byname(pdev, "gerror");
> +		irq = platform_get_irq_byname_optional(pdev, "gerror");
>   		if (irq > 0)
>   			smmu->gerr_irq = irq;
>   	}
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
