Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DA5C43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 12:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A661E418F9;
	Mon, 27 Jun 2022 12:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A661E418F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZnhwOw37rvN; Mon, 27 Jun 2022 12:26:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 172EF415F0;
	Mon, 27 Jun 2022 12:26:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 172EF415F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E31DC0032;
	Mon, 27 Jun 2022 12:26:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2798BC002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 12:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E87F683F60
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 12:26:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E87F683F60
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cc9M43djZ7uC for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:26:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F3A583F5A
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F3A583F5A
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 12:26:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED441758;
 Mon, 27 Jun 2022 05:26:00 -0700 (PDT)
Received: from [10.57.84.159] (unknown [10.57.84.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4BE53F792;
 Mon, 27 Jun 2022 05:25:58 -0700 (PDT)
Message-ID: <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
Date: Mon, 27 Jun 2022 13:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Steven Price <steven.price@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <44338c87254d4d439d29694de8f19435@huawei.com>
Cc: lpieralisi@kernel.org, "jon@solid-run.com" <jon@solid-run.com>,
 Linuxarm <linuxarm@huawei.com>, "hch@infradead.org" <hch@infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
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

On 2022-06-24 16:44, Shameerali Kolothum Thodi via iommu wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 17 June 2022 13:42
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
>> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 15/06/2022 11:10, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v12 --> v13
>>>    -No changes. Rebased to 5.19-rc1.
>>>    -Picked up tags received from Laurentiu, Hanjun and Will. Thanks!.
>>
>> You've already got my Tested-by tags, but just to confirm I gave this a
>> spin and it works fine.
> 
> Thanks Steve.
> 
> I think the series is now in a good shape to be merged.
> 
> Hi Will/Robin,
> 
> Appreciate, if you could please take a look at the remaining SMMU related
> patches(7-9) and provide your approval?

I said v12 looked fine, but for the avoidance of doubt, here it is 
again, as formally as can be:

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
