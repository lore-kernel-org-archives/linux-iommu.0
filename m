Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4F1C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 08:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B867540A92;
	Tue, 10 May 2022 08:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HuDt49nZCG55; Tue, 10 May 2022 08:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D8D440A9B;
	Tue, 10 May 2022 08:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1B3C0032;
	Tue, 10 May 2022 08:07:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A622C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 08:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 846E5402C5
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 08:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z016NHGNq-sv for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 08:07:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3791B4025E
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 08:07:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D6B12FC;
 Tue, 10 May 2022 01:07:08 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039643F73D;
 Tue, 10 May 2022 01:07:05 -0700 (PDT)
Message-ID: <5c8ae673-f8e3-0ed3-e62d-d445913b012c@arm.com>
Date: Tue, 10 May 2022 09:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
 <8e4f012717e34195a53cb73f8ce28627@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8e4f012717e34195a53cb73f8ce28627@huawei.com>
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "hch@infradead.org" <hch@infradead.org>,
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

On 2022-05-10 08:23, Shameerali Kolothum Thodi wrote:
> Hi Joerg/Robin,
> 
> I think this series is now ready to be merged. Could you please let
> me know if there is anything missing.

Fine by me - these patches have had enough review and testing now that 
even if anything else did come up, I think it would be better done as 
follow-up work on the merged code.

Cheers,
Robin.

> 
> Thanks,
> Shameer
> 
>> -----Original Message-----
>> From: Guohanjun (Hanjun Guo)
>> Sent: 05 May 2022 02:24
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; steven.price@arm.com;
>> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
>> laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 2022/5/4 0:33, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v11 --> v12
>>>     -Minor fix in patch #4 to address the issue reported by the kernel test
>> robot.
>>>     -Added R-by tags by Christoph(patch #1) and Lorenzo(patch #4).
>>>     -Added T-by from Steve to all relevant patches. Many thanks!.
>>>
>>> Please note, this series has a dependency on the ACPICA header patch
>>> here[1].
>>
>> Tested on a Kunpeng920 server machine with SMMUv3, the 3408iMR RAID
>> controller card works as expected,
>>
>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Thanks
>> Hanjun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
