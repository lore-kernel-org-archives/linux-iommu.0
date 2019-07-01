Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2FC0650E
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 12:39:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363FB214AE
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FB214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0CA4E4F9D;
	Mon,  1 Jul 2019 12:39:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5F8C34F9C
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 12:39:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 08698832
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 12:39:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90907344;
	Mon,  1 Jul 2019 05:39:57 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043783F246;
	Mon,  1 Jul 2019 05:39:56 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
To: Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicoleotsuka@gmail.com>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
	<20190701122158.GE8166@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
Date: Mon, 1 Jul 2019 13:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701122158.GE8166@8bytes.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 01/07/2019 13:21, Joerg Roedel wrote:
> On Fri, Jun 21, 2019 at 09:38:14PM -0700, Nicolin Chen wrote:
>> The max_len is a u32 type variable so the calculation on the
>> left hand of the last if-condition will potentially overflow
>> when a cur_len gets closer to UINT_MAX -- note that there're
>> drivers setting max_seg_size to UINT_MAX:
>>    drivers/dma/dw-edma/dw-edma-core.c:745:
>>      dma_set_max_seg_size(dma->dev, U32_MAX);
>>    drivers/dma/dma-axi-dmac.c:871:
>>      dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>>    drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
>>      dma_set_max_seg_size(dev, 0xffffffff);
>>    drivers/nvme/host/pci.c:2520:
>>      dma_set_max_seg_size(dev->dev, 0xffffffff);
>>
>> So this patch just casts the cur_len in the calculation to a
>> size_t type to fix the overflow issue, as it's not necessary
>> to change the type of cur_len after all.
>>
>> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Looks good to me, but I let Robin take a look too before I apply it,
> Robin?
I'll need to take a closer look at how exactly an overflow would happen 
here (just got back off some holiday), but my immediate thought is that 
if this is a real problem, then what about 32-bit builds where size_t 
would still overflow?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
