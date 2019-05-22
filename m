Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42469C282DD
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 13:55:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215A321473
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 13:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215A321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C50F1DC6;
	Wed, 22 May 2019 13:55:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9A10ADB8
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 13:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 36D2D7FB
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 13:55:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8DE80D;
	Wed, 22 May 2019 06:55:53 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C903F575;
	Wed, 22 May 2019 06:55:52 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
To: Christoph Hellwig <hch@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com>
	<20190522123243.GA26390@lst.de>
	<6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
	<20190522130921.GA26874@lst.de>
	<fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
	<20190522133400.GA27229@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
Date: Wed, 22 May 2019 14:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522133400.GA27229@lst.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-imx@nxp.com
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

On 22/05/2019 14:34, Christoph Hellwig wrote:
> On Wed, May 22, 2019 at 02:25:38PM +0100, Robin Murphy wrote:
>> Sure, but that should be irrelevant since the effective problem here is in
>> the sync_*_for_cpu direction, and it's the unmap which nobbles the buffer.
>> If the driver does this:
>>
>> 	dma_map_single(whole buffer);
>> 	<device writes to part of buffer>
>> 	dma_unmap_single(whole buffer);
>> 	<contents of rest of buffer now undefined>
>>
>> then it could instead do this and be happy:
>>
>> 	dma_map_single(whole buffer, SKIP_CPU_SYNC);
>> 	<device writes to part of buffer>
>> 	dma_sync_single_for_cpu(updated part of buffer);
>> 	dma_unmap_single(whole buffer, SKIP_CPU_SYNC);
>> 	<contents of rest of buffer still valid>
> 
> Assuming the driver knows how much was actually DMAed this would
> solve the issue.  Horia, does this work for you?

Ohhh, and now I've just twigged what you were suggesting - your 
DMA_ATTR_PARTIAL flag would mean "treat this as a read-modify-write of 
the buffer because we *don't* know exactly which parts the device may 
write to". So indeed if we did go down that route we wouldn't need any 
of the sync stuff I was worrying about (but I might suggest naming it 
DMA_ATTR_UPDATE instead). Apologies for being slow :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
