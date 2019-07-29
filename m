Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283EC7618B
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 13:15:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B116C2070B
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 13:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B116C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 82BB21868;
	Mon, 29 Jul 2019 13:15:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 49151185E
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 13:13:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B7CEA89D
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 13:13:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA5328;
	Mon, 29 Jul 2019 06:13:47 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0363D3F71F;
	Mon, 29 Jul 2019 06:13:45 -0700 (PDT)
Subject: Re: [PATCH 07/24] iommu/dma: Move domain lookup into
	__iommu_dma_{map, unmap}
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Christoph Hellwig <hch@lst.de>
References: <20190520072948.11412-1-hch@lst.de>
	<20190520072948.11412-8-hch@lst.de>
	<5FC3163CFD30C246ABAA99954A238FA83F328FAB@lhreml524-mbb.china.huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9027b5f1-545b-e11b-ca8f-f1e0bd701634@arm.com>
Date: Mon, 29 Jul 2019 14:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F328FAB@lhreml524-mbb.china.huawei.com>
Content-Language: en-GB
Cc: Tom Murphy <tmurphy@arista.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
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

Hi Shameer,

On 29/07/2019 13:12, Shameerali Kolothum Thodi wrote:
> Hi Robin,
> 
>> -----Original Message-----
>> From: iommu-bounces@lists.linux-foundation.org
>> [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of Christoph
>> Hellwig
>> Sent: 20 May 2019 08:30
>> To: Robin Murphy <robin.murphy@arm.com>
>> Cc: Tom Murphy <tmurphy@arista.com>; Catalin Marinas
>> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
>> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: [PATCH 07/24] iommu/dma: Move domain lookup into
>> __iommu_dma_{map, unmap}
>>
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Most of the callers don't care, and the couple that do already have the
>> domain to hand for other reasons are in slow paths where the (trivial)
>> overhead of a repeated lookup will be utterly immaterial.
> 
> On a Hisilicon ARM64 platform with 5.3-rc1, a F_TRANSALTION error from
> smmuv3 is reported when an attempt is made to assign a ixgbe vf dev to a
> Guest.
> 
> [  196.747107] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> [  196.747109] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000180 00000010
> [  196.747110] arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000020100000000
> [  196.747111] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000000ffffe040
> [  196.747113] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000000ffffe000
> 
> Git bisect points to this patch.
> 
> Please see below.
[...]
>> *iommu_dma_get_msi_page(struct device *dev,
>>   	if (!msi_page)
>>   		return NULL;
>>
>> -	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
>> +	iova = __iommu_dma_map(dev, msi_addr, size, prot);
> 
> I think the domain here is retrieved using iommu_get_domain_for_dev()
> which may not be the default domain returned by iommu_get_dma_domain().

Urgh, yes, how did I manage to miss that? :(

I doubt this patch reverts cleanly, but I don't think it needs to be 
completely undone anyway; give me a moment...

Robin.

> 
> Please check and let me know.
> 
> Thanks,
> Shameer
> 
>>   	if (iova == DMA_MAPPING_ERROR)
>>   		goto out_free_page;
>> --
>> 2.20.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
