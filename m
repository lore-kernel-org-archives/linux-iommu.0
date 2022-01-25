Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A73DC433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 19:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 466FA82702;
	Tue, 25 Jan 2022 19:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CN1QLHe36_BC; Tue, 25 Jan 2022 19:30:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B3D2826FB;
	Tue, 25 Jan 2022 19:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D807FC0039;
	Tue, 25 Jan 2022 19:30:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E70C1C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 19:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C077782702
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 19:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqquWcWxHPIF for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 842E9826FB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 19:30:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 788AC1FB;
 Tue, 25 Jan 2022 11:30:51 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5BD3F7D8;
 Tue, 25 Jan 2022 11:30:49 -0800 (PST)
Message-ID: <93374408-9522-8648-3417-0d8750d652bb@arm.com>
Date: Tue, 25 Jan 2022 19:30:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <9da65c2504b944398188e468eac1abff@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9da65c2504b944398188e468eac1abff@huawei.com>
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
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

On 2022-01-25 13:00, Shameerali Kolothum Thodi wrote:
> Hi Robin/Lorenzo,
> 
>> -----Original Message-----
>> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf
>> Of Shameer Kolothum
>> Sent: 05 August 2021 09:07
>> To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: robin.murphy@arm.com; jon@solid-run.com; Linuxarm
>> <linuxarm@huawei.com>; steven.price@arm.com; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; yangyicong <yangyicong@huawei.com>;
>> Sami.Mujawar@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>
>> Subject: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> Hi,
>>
>> The series adds support to IORT RMR nodes specified in IORT
>> Revision E.b -ARM DEN 0049E[0]. RMR nodes are used to describe
>> memory ranges that are used by endpoints and require a unity
>> mapping in SMMU.
>>
>> We have faced issues with 3408iMR RAID controller cards which
>> fail to boot when SMMU is enabled. This is because these
>> controllers make use of host memory for various caching related
>> purposes and when SMMU is enabled the iMR firmware fails to
>> access these memory regions as there is no mapping for them.
>> IORT RMR provides a way for UEFI to describe and report these
>> memory regions so that the kernel can make a unity mapping for
>> these in SMMU.
>>
>> Change History:
>>
>> v6 --> v7
>>
>> The only change from v6 is the fix pointed out by Steve to
>> the SMMUv2 SMR bypass install in patch #8.
>>
>> Thanks to the Tested-by tags by Laurentiu with SMMUv2 and
>> Hanjun/Huiqiang with SMMUv3 for v6. I haven't added the tags
>> yet as the series still needs more review[1].
>>
>> Feedback and tests on this series is very much appreciated.
> 
> Since we have an update to IORT spec(E.c) now[1] and includes additional
> attributes/flags for the RMR node, I am planning to respin this series soon.
> 
> Going through the new spec, I have a few queries,
> 
> The memory range attributes can now be described as one of the following,
> 
> 0x00: Device-nGnRnE memory
> 0x01: Device-nGnRE memory
> 0x02: Device-nGRE memory
> 0x03: Device-GRE memory
> 0x04: Normal Inner Non-cacheable Outer Non-cacheable
> 0x05: Normal Inner Write-back Outer Write-back Inner Shareable
> 
> I am not sure how this needs to be captured and used in the kernel. Is there
> any intention of using these fine-grained attributes in the kernel now
> or a generic mapping of the above to the struct iommu_rev_region prot field
> is enough? i.e., something like,
> 
> {
>      ....
>      prot = IOMMU_READ | IOMMU_WRITE;
> 
>      if (rmr_attr == normal_mem) // 0x05
>          prot |= IOMMU_CACHE;
>      
>      if (rmr_attr == device_mem) { //0x00 - 0x03
>          prot |= IOMMU_MMIO;
>          prot |= IOMMU_NOEXEC;
>      }
>      ....
> }

Yup, pretty much that, except don't bother with IOMMU_NOEXEC. We can't 
reliably infer it - e.g. on an AXI-based interconnect AxCACHE and AxPROT 
are entirely orthogonal, so a Device-type read with the "Instruction 
access" hint is perfectly legal - and in the common IORT code we're not 
in a position to second-guess what any given RMR might represent for 
whatever agent is accessing it.

All we can reasonably do here is map the Device types to IOMMU_MMIO and 
Write-back to IOMMU_CACHE, and if anyone ever does want to insist that 
that's not sufficient, then they're welcome to send patches to make the 
IOMMU API more expressive :)

> Similarly for the 'flags' field, the new 'Access Privilege' is intended to set the
> IOMMU_PRIV ?

Yes, exactly!

Cheers,
Robin.

>    
> Please let me know.
> 
> Thanks,
> Shameer
> 
> [1] https://developer.arm.com/documentation/den0049/ec/?lang=en
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
