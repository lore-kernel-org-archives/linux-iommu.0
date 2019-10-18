Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED21CA9EA1
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 13:51:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08305222C6
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 13:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08305222C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BDA25B49;
	Fri, 18 Oct 2019 13:51:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E1BBB43
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 13:51:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (unknown [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 105168AB
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 13:51:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E89FC2;
	Fri, 18 Oct 2019 06:51:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A52A03F6C4;
	Fri, 18 Oct 2019 06:51:26 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Relax locking in iommu_dma_prepare_msi()
To: Christoph Hellwig <hch@infradead.org>
References: <5af5e77102ca52576cb96816f0abcf6398820055.1571245656.git.robin.murphy@arm.com>
	<20191017162453.GA6012@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2309c311-7378-385d-bf97-57965d36c18b@arm.com>
Date: Fri, 18 Oct 2019 14:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191017162453.GA6012@infradead.org>
Content-Language: en-GB
Cc: maz@kernel.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, julien.grall@arm.com
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

On 17/10/2019 17:24, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 06:07:36PM +0100, Robin Murphy wrote:
>> @@ -1180,7 +1179,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   	struct iommu_dma_cookie *cookie;
>>   	struct iommu_dma_msi_page *msi_page;
>> -	unsigned long flags;
>> +	static DEFINE_MUTEX(msi_prepare_lock);
> 
> Just a style nitpick, but I find locks declared inside functions
> really weird.  In addition to that locks not embedded into a structure
> and not directly next to variables or data structures they protect
> really need a comment explaining what they are trying to serialize.

Hmm, the lock itself is merely a glorified comment, it's named for the 
operation it protects, its entire existence spans 15 consecutive lines, 
and 27% of those lines are dedicated to explaining that it's technically 
redundant. Is there *really* anything that isn't clear from the context?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
