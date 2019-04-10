Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68843C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 09:44:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C64120830
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 09:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C64120830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0E6F3169B;
	Wed, 10 Apr 2019 09:44:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ED7A81685
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:44:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id A251A17E
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:44:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E6715AB;
	Wed, 10 Apr 2019 02:44:05 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBA93F68F;
	Wed, 10 Apr 2019 02:44:04 -0700 (PDT)
Subject: Re: [bug report] iommu/io-pgtable-arm: Fix pgtable allocation in
	selftest
To: Dan Carpenter <dan.carpenter@oracle.com>, jean-philippe.brucker@arm.com
References: <20190410093405.GA9889@kadam>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <782a999e-ce70-bd8e-5a7b-cd320ce98144@arm.com>
Date: Wed, 10 Apr 2019 10:44:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410093405.GA9889@kadam>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410094403.Ne9xwD2UKsbCmKkFY4U9R22CJ51-dZ2ano4xE0UoBHA@z>

Hi Dan,

On 10/04/2019 10:34, Dan Carpenter wrote:
> Hello Jean-Philippe Brucker,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch fac83d29d954: "iommu/io-pgtable-arm: Fix pgtable allocation
> in selftest" from Jun 18, 2018, leads to the following Smatch
> complaint:
> 
>      drivers/iommu/io-pgtable-arm.c:246 __arm_lpae_alloc_pages()
>      error: we previously assumed 'dev' could be null (see line 239)
> 
> drivers/iommu/io-pgtable-arm.c
>     238		VM_BUG_ON((gfp & __GFP_HIGHMEM));
>     239		p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
>                                       ^^^
> We added a NULL check here
> 
>     240				     gfp | __GFP_ZERO, order);
>     241		if (!p)
>     242			return NULL;
>     243	
>     244		pages = page_address(p);
>     245		if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {

The selftests *should* always set this quirk such that they never get to 
the DMA mapping calls (that was one of the reasons for implementing 
things that way) - I guess that might be a bit too sneaky for Smatch, 
but I can take a look to double-check that the flow is working correctly 
such that this really is a false-positive.

Robin.

>     246			dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>                                               ^^^
> But dma_map_single() can't take a NULL argument either.
> 
>     247			if (dma_mapping_error(dev, dma))
>     248				goto out_free;
> 
> I don't know why this warning is only showing up now, almost a year
> later.  Sorry about that.
> 
> regards,
> dan carpenter
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
