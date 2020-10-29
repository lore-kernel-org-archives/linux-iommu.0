Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5482AC4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 00:40:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD9F20790
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 00:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AYUqXj27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD9F20790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C974C204E1;
	Thu, 29 Oct 2020 00:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XY1WtAFnac1X; Thu, 29 Oct 2020 00:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC06920414;
	Thu, 29 Oct 2020 00:40:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5210C088B;
	Thu, 29 Oct 2020 00:40:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A85BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 00:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F1C16204C4
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 00:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLiT2P7-vq4h for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 00:40:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by silver.osuosl.org (Postfix) with ESMTPS id C381E20414
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 00:40:28 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CM66Z1Bl8z9sRK;
 Thu, 29 Oct 2020 11:40:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1603932022;
 bh=gNUYMrF01adrDgOyn82MgF7OEhnrFjYiVS+QzNHILmY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AYUqXj27bneMgn85a2lqzmgV3IwgBW13pt5FfGC5d5Vj4abOzMEcnWyiVYc8SwRBF
 rMdW6yq1MWL024XFWutj8Gn1LTUcVh5PX6Qm8tnjgNiIuSy7mqJFV3zFNUUtmiCwYx
 +H/JMzkNiGYLMqMklEXjQJmrT1SL2TwmxEfkTkXd/ePCfkpCSkh9gbDLaXP0BQ71W6
 M6JwPBvRkfONnNX2FACnVqzMg+7c+Io5HwXjZ+Sgd68gxZTfBH6LF6+7dmG7bjjDL+
 q0HmLqdSxGZUsQMZkN4z/X9Zx/NY50LJDCJh8FABwDC3DpcteqRiebxV0DQmg+SEvf
 GhI/bDOafIA8A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v3 2/2] powerpc/dma: Fallback to dma_ops when
 persistent memory present
In-Reply-To: <20201028070030.60643-3-aik@ozlabs.ru>
References: <20201028070030.60643-1-aik@ozlabs.ru>
 <20201028070030.60643-3-aik@ozlabs.ru>
Date: Thu, 29 Oct 2020 11:40:21 +1100
Message-ID: <87eelhx3t6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index e4198700ed1a..91112e748491 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1111,11 +1112,13 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>   */
>  static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>  {
> -	int len, ret;
> +	int len = 0, ret;
> +	bool pmem_present = of_find_node_by_type(NULL, "ibm,pmemory") != NULL;

That leaks a reference on the returned node.

	dn = of_find_node_by_type(NULL, "ibm,pmemory");
	pmem_present = dn != NULL;
	of_node_put(dn);


> @@ -1126,7 +1129,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>  
>  	mutex_lock(&direct_window_init_mutex);
>  
> -	dma_addr = find_existing_ddw(pdn);
> +	dma_addr = find_existing_ddw(pdn, &len);

I don't see len used anywhere?

>  	if (dma_addr != 0)
>  		goto out_unlock;
>  
> @@ -1212,14 +1215,26 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>  	}
>  	/* verify the window * number of ptes will map the partition */
>  	/* check largest block * page size > max memory hotplug addr */
> -	max_addr = ddw_memory_hotplug_max();
> -	if (query.largest_available_block < (max_addr >> page_shift)) {
> -		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
> -			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
> -			  1ULL << page_shift);
> +	/*
> +	 * The "ibm,pmemory" can appear anywhere in the address space.
> +	 * Assuming it is still backed by page structs, try MAX_PHYSMEM_BITS
> +	 * for the upper limit and fallback to max RAM otherwise but this
> +	 * disables device::dma_ops_bypass.
> +	 */
> +	len = max_ram_len;

Here you override whatever find_existing_ddw() wrote to len?

> +	if (pmem_present) {
> +		if (query.largest_available_block >=
> +		    (1ULL << (MAX_PHYSMEM_BITS - page_shift)))
> +			len = MAX_PHYSMEM_BITS - page_shift;
> +		else
> +			dev_info(&dev->dev, "Skipping ibm,pmemory");
> +	}
> +
> +	if (query.largest_available_block < (1ULL << (len - page_shift))) {
> +		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
> +			1ULL << len, query.largest_available_block, 1ULL << page_shift);
>  		goto out_failed;
>  	}
> -	len = order_base_2(max_addr);
>  	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
>  	if (!win64) {
>  		dev_info(&dev->dev,


cheers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
