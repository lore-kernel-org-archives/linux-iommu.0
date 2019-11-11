Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50228C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:37:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A6A222CF
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vfXZ5zZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A6A222CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E2936CA6;
	Mon, 11 Nov 2019 14:37:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 065CEA95
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:37:41 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BBD9712E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:37:40 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 956B321655;
	Mon, 11 Nov 2019 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573483060;
	bh=zRua+W/OXpoT6rPkS0FoAqe1tWUfeIAMJIZnqn4qqxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vfXZ5zZoDzwQT5hwJ2MVW16ffjW1d5UUDhDCRgrE7mDMbtIXhRCyQ7immT/ZJpIPg
	vl88r5ejbTpLGm/AhRMEZ5CGznC1t4UG6ai2DtFCLzBCpzbLaoe2W6KztHJtf0XMnJ
	UnDcprY4jGSG+lXaW9Ld1kPpDSFuawDnFa6WuOGQ=
Date: Mon, 11 Nov 2019 14:37:36 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Remove duplicate error message
Message-ID: <20191111143736.GB10488@willie-the-truck>
References: <20191111111721.4145919-1-jean-philippe@linaro.org>
	<20191111111721.4145919-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111111721.4145919-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Nov 11, 2019 at 12:17:21PM +0100, Jean-Philippe Brucker wrote:
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
> to platform_get_irq*()"), platform_get_irq() displays an error when the
> IRQ isn't found. Remove the error print from the SMMU driver. Note the
> slight change of behaviour: no message is printed if platform_get_irq()
> returns -EPROBE_DEFER, which probably doesn't concern the SMMU.
> 
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7c503a6bc585..6f676686752c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2062,10 +2062,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	for (i = 0; i < num_irqs; ++i) {
>  		int irq = platform_get_irq(pdev, i);
>  
> -		if (irq < 0) {
> -			dev_err(dev, "failed to get irq index %d\n", i);
> +		if (irq < 0)
>  			return -ENODEV;
> -		}
>  		smmu->irqs[i] = irq;
>  	}

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
