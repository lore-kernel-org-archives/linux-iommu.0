Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E439AC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 10:30:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E4022CF4
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 10:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1mH2rd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E4022CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 87566D67;
	Tue, 20 Aug 2019 10:30:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E3B1D36
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:30:54 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DCF7B89B
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:30:52 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 91D2C22CF4;
	Tue, 20 Aug 2019 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566297052;
	bh=QX6X9ApCRnaZQJs+459lUXGpL+CPfmZcq+MysQfUQl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1mH2rd6XYodYNmUQgNUW1rB1/NWbtjp6uBe4QvCwjawlLf/x5NCS7x9h4VioQGER
	AA9lYfuOfhqRcYQPxfEogwInO7X8ga1CPbGo7+xMeaTDLvn+rQsKnxJHjj7gKfFSxy
	Bhmp23scHmc35dY4bfAtRba2DVAojTUUqN5vo93g=
Date: Tue, 20 Aug 2019 11:30:48 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/4] iommu/io-pgtable-arm: Prepare for TTBR1 usage
Message-ID: <20190820103048.xacfbtn5o4wermhi@willie-the-truck>
References: <cover.1566238530.git.robin.murphy@arm.com>
	<6596469d5fa1e918145fdd4e6b1a3ad67f7cde2e.1566238530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6596469d5fa1e918145fdd4e6b1a3ad67f7cde2e.1566238530.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Aug 19, 2019 at 07:19:31PM +0100, Robin Murphy wrote:
> Now that callers are free to use a given table for TTBR1 if they wish
> (all they need do is shift the provided attributes when constructing
> their final TCR value), the only remaining impediment is the address
> validation on map/unmap. The fact that the LPAE address space split is
> symmetric makes this easy to accommodate - by simplifying the current
> range checks into explicit tests that address bits above IAS are all
> zero, it then follows straightforwardly to add the inverse test to
> allow the all-ones case as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 09cb20671fbb..f39c50356351 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -475,13 +475,13 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int ret, lvl = ARM_LPAE_START_LVL(data);
>  	arm_lpae_iopte prot;
> +	long iaext = (long)iova >> data->iop.cfg.ias;
>  
>  	/* If no access, then nothing to do */
>  	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>  		return 0;
>  
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> -		    paddr >= (1ULL << data->iop.cfg.oas)))
> +	if (WARN_ON((iaext && ~iaext) || paddr >> data->iop.cfg.oas))

I had to read that '&&' twice, but I see what you're doing now :)

>  		return -ERANGE;

This doesn't seem sufficient to prevent a mixture of TTBR1 and TTBR0
addresses from being mapped in the same TTBR. Perhaps we need a quirk for
TTBR1, which could then take care of setting EPDx appropriately?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
