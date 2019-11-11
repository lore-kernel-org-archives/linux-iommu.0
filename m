Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327CCC43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:37:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F7B21783
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFVvRPU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F7B21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6F38CA8;
	Mon, 11 Nov 2019 14:37:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7841FA95
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:37:02 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 215A712E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:37:02 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id ECE18214E0;
	Mon, 11 Nov 2019 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573483022;
	bh=St7ZnV5WSa+yszDcbQGqtCcdVAO1nZ3efPLKJ2qswg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFVvRPU0o3E4Rfl2RAfAAvItIYq3+SRTw2zPaCArwNfgUnw/DVX9zhjbOzLtdjhHn
	IbSSPpJ4Fq/uxMOq+Xf96Hd8rmpv2vCxp6gWSx3iq8mhGzXzQfuOK+DjLt6u++8YY4
	CRJ0R/AlPz6gdJZphnyAK1J1zuqe/GRh/brPPwS8=
Date: Mon, 11 Nov 2019 14:36:57 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Don't display an error when IRQ
	lines are missing
Message-ID: <20191111143656.GA10488@willie-the-truck>
References: <20191111111721.4145919-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111111721.4145919-1-jean-philippe@linaro.org>
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

On Mon, Nov 11, 2019 at 12:17:20PM +0100, Jean-Philippe Brucker wrote:
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
> ---
>  drivers/iommu/arm-smmu-v3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index bfa4a0f39ed0..a89797f346a4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -5207,19 +5207,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  
>  	/* Interrupt lines */
>  
> -	irq = platform_get_irq_byname(pdev, "combined");
> +	irq = platform_get_irq_byname_optional(pdev, "combined");
>  	if (irq > 0)
>  		smmu->combined_irq = irq;
>  	else {
> -		irq = platform_get_irq_byname(pdev, "eventq");
> +		irq = platform_get_irq_byname_optional(pdev, "eventq");
>  		if (irq > 0)
>  			smmu->evtq.q.irq = irq;
>  
> -		irq = platform_get_irq_byname(pdev, "priq");
> +		irq = platform_get_irq_byname_optional(pdev, "priq");
>  		if (irq > 0)
>  			smmu->priq.q.irq = irq;
>  
> -		irq = platform_get_irq_byname(pdev, "gerror");
> +		irq = platform_get_irq_byname_optional(pdev, "gerror");
>  		if (irq > 0)
>  			smmu->gerr_irq = irq;
>  	}

Thanks, looks mechanical enough for me:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
