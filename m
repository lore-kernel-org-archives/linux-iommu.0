Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFEC282DD
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733002175B
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733002175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5C09BF3B;
	Tue, 23 Apr 2019 10:55:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7CB7BF33
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 10:55:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 36B00F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 10:55:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D7A374;
	Tue, 23 Apr 2019 03:55:39 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5470A3F557;
	Tue, 23 Apr 2019 03:55:36 -0700 (PDT)
Subject: Re: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two
	parts
To: Christoph Hellwig <hch@infradead.org>
References: <20190418172611.21561-1-julien.grall@arm.com>
	<20190418172611.21561-3-julien.grall@arm.com>
	<20190423070823.GA12114@infradead.org>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <7af177e1-dfd9-2a91-3fd9-dfe53a6a9014@arm.com>
Date: Tue, 23 Apr 2019 11:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423070823.GA12114@infradead.org>
Content-Language: en-US
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, miquel.raynal@bootlin.com,
	tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org
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
Message-ID: <20190423105534.XEWZiaV3YVpGxAa5xXdyPohV1HQESgIGodfQSQGeQ8I@z>

Hi,

On 4/23/19 8:08 AM, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 06:26:06PM +0100, Julien Grall wrote:
>> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>>   {
>> +	struct device *dev = msi_desc_to_dev(desc);
>>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   	struct iommu_dma_cookie *cookie;
>>   	unsigned long flags;
>>   
>> +	if (!domain || !domain->iova_cookie) {
>> +		desc->iommu_cookie = NULL;
>> +		return 0;
>> +	}
>>   
>>   	cookie = domain->iova_cookie;
>>   
>> @@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>>   	 * of an MSI from within an IPI handler.
>>   	 */
>>   	spin_lock_irqsave(&cookie->msi_lock, flags);
>> +	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
>>   	spin_unlock_irqrestore(&cookie->msi_lock, flags);
>>   
>> +	return (desc->iommu_cookie) ? 0 : -ENOMEM;
> 
> No need for the braces.  Also I personally find a:
> 
> 	if (!desc->iommu_cookie)
> 		return -ENOMEM;
> 	return 0;
> 
> much more readable, but that might just be personal preference.

I am happy either way. I will use your suggestion in the next version.

Cheers,

-- 
Julien Grall
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
