Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7AAC432BE
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 14:47:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A4061019
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 14:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71A4061019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3037E6075E;
	Mon,  9 Aug 2021 14:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rni49YqSRlb7; Mon,  9 Aug 2021 14:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08C83605D6;
	Mon,  9 Aug 2021 14:47:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0DDCC0010;
	Mon,  9 Aug 2021 14:47:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2ED7C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 14:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EA1582ED2
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 14:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bkin6yyv3vXL for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 14:47:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB60D82DDE
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 14:47:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD416D;
 Mon,  9 Aug 2021 07:47:38 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E0A3F718;
 Mon,  9 Aug 2021 07:47:37 -0700 (PDT)
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
To: Will Deacon <will@kernel.org>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
 <20210809125238.GB1097@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4c6ecfb1-cf64-fa35-9fa7-f6fa39e2c066@arm.com>
Date: Mon, 9 Aug 2021 15:47:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809125238.GB1097@willie-the-truck>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-08-09 13:52, Will Deacon wrote:
> On Wed, Aug 04, 2021 at 06:15:52PM +0100, Robin Murphy wrote:
>> Factor out flush queue setup from the initial domain init so that we
>> can potentially trigger it from sysfs later on in a domain's lifetime.
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>>   include/linux/dma-iommu.h |  9 ++++++---
>>   2 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 2e19505dddf9..f51b8dc99ac6 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>>   }
>>   
>> +int iommu_dma_init_fq(struct iommu_domain *domain)
>> +{
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
>> +		return -EINVAL;
>> +	if (cookie->fq_domain)
>> +		return 0;
>> +
>> +	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
>> +				  iommu_dma_entry_dtor)) {
>> +		pr_warn("iova flush queue initialization failed\n");
>> +		domain->type = IOMMU_DOMAIN_DMA;
>> +		return -ENODEV;
> 
> I do find this a bit odd: we assert that the caller has set domain->type
> to IOMMU_DOMAIN_DMA_FQ but then on failure we reset it to IOMMU_DOMAIN_DMA
> here. I think it would be less error-prone if the setting of domain->type
> was handled in the same function.

On reflection I think I agree. For some reason I settled on the idea of 
doing this to make the callers simpler, but it turns out that unpicking 
it to flow logically is in fact a +4/-5 diff essentially just moving all 
the same statements to different places, and that's before I update 
comments since that theoretical race between the sysfs and DMA ops paths 
only exists because of sysfs having to dance around the type check here...

I'll send v4 later today or possibly tomorrow, but not in such a hurry 
that I skimp on the build-testing this time!

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
