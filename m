Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C6C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E20561431
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E20561431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50DF640267;
	Mon, 14 Jun 2021 10:35:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNzvr-wIflai; Mon, 14 Jun 2021 10:35:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B07940168;
	Mon, 14 Jun 2021 10:35:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C51BEC000E;
	Mon, 14 Jun 2021 10:35:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD7E0C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACA7340169
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xk9_H9kcT6q4 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9168340168
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:35:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06BA1FB;
 Mon, 14 Jun 2021 03:35:13 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064133F694;
 Mon, 14 Jun 2021 03:35:11 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
 <260859e85c854b90b513599f4febfbad@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <00b7b9e2-190a-6c84-9248-8526021e4d97@arm.com>
Date: Mon, 14 Jun 2021 11:35:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <260859e85c854b90b513599f4febfbad@huawei.com>
Content-Language: en-GB
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

On 2021-05-26 17:36, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
>> Sent: 26 May 2021 08:53
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
>> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
>> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
>> regions
>>
>> Hi Shameer,
>>
>> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
>>> Add a helper function that retrieves RMR memory descriptors
>>> associated with a given IOMMU. This will be used by IOMMU
>>> drivers to setup necessary mappings.
>>>
>>> Now that we have this, invoke it from the generic helper
>>> interface.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>   drivers/acpi/arm64/iort.c | 50
>> +++++++++++++++++++++++++++++++++++++++
>>>   drivers/iommu/dma-iommu.c |  4 ++++
>>>   include/linux/acpi_iort.h |  7 ++++++
>>>   3 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index fea1ffaedf3b..01917caf58de 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -12,6 +12,7 @@
>>>
>>>   #include <linux/acpi_iort.h>
>>>   #include <linux/bitfield.h>
>>> +#include <linux/dma-iommu.h>
>>>   #include <linux/iommu.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/list.h>
>>> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
>> device *dev)
>>>   	return err;
>>>   }
>>>
>>> +/**
>>> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
>> IOMMU
>>> + * @iommu: fwnode for the IOMMU
>>> + * @head: RMR list head to be populated
>>> + *
>>> + * Returns: 0 on success, <0 failure
>>> + */
>>> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
>>> +			struct list_head *head)
>>> +{
>>> +	struct iort_rmr_entry *e;
>>> +	struct acpi_iort_node *iommu;
>>> +	int rmrs = 0;
>>> +
>>> +	iommu = iort_get_iort_node(iommu_fwnode);
>>> +	if (!iommu || list_empty(&iort_rmr_list))
>>> +		return -ENODEV;
>>> +
>>> +	list_for_each_entry(e, &iort_rmr_list, list) {
>>> +		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
>> IOMMU_MMIO;
>>
>> We have a case with an IP block that needs EXEC rights on its reserved
>> memory, so could you please drop the IOMMU_NOEXEC flag?
> 
> Ok, I think I can drop that one if there are no other concerns. I was not quite
> sure what to include here in the first place as the IORT spec is not giving any
> further details about the RMR regions(May be the flags field can be extended to
> describe these details).

Right, it's reserved for the device to use *somehow* - that's all we 
know, so it's not our place to try and enforce any restrictive 
permissions. All it could possibly achieve is the ability to log an 
error to say "a thing did an unknown thing in a way we didn't expect!", 
and there's hardly much value in that.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
