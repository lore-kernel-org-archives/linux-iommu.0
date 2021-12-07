Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85458C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 13:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B58483342;
	Tue,  7 Dec 2021 13:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aMoOYjbaXwDL; Tue,  7 Dec 2021 13:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D75D78338B;
	Tue,  7 Dec 2021 13:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C1BC001E;
	Tue,  7 Dec 2021 13:46:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED307C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEA848338B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QNUWhIJJOWX for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 13:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C70683342
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:46:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC85B11FB;
 Tue,  7 Dec 2021 05:46:54 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC683F5A1;
 Tue,  7 Dec 2021 05:46:53 -0800 (PST)
Message-ID: <675bfd78-69ac-608f-1303-e86b90a83f72@arm.com>
Date: Tue, 7 Dec 2021 13:46:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Content-Language: en-GB
To: Leo Yan <leo.yan@linaro.org>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
 <20211117144844.241072-4-jean-philippe@linaro.org>
 <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
 <766ac58a-ffb7-f673-709b-0f0f740f3cfd@arm.com>
 <53f868a8-c7ae-b69d-b061-bb0a7dc98f8a@huawei.com>
 <d60110c4-c179-45d6-512d-3d058caac974@arm.com>
 <20211207132007.GB255238@leoy-ThinkPad-X240s>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211207132007.GB255238@leoy-ThinkPad-X240s>
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, uchida.jun@socionext.com, will@kernel.org,
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

On 2021-12-07 13:20, Leo Yan wrote:
> On Tue, Dec 07, 2021 at 12:48:13PM +0000, Robin Murphy wrote:
>> On 2021-12-07 12:28, John Garry via iommu wrote:
>>> On 07/12/2021 12:04, Robin Murphy wrote:
>>>>>>
>>>>> So is there some userspace part to go with this now?
>>>>
>>>> FWIW I've not looked into it - is it just a case of someone knocking
>>>> out some JSON from the MMU-600/700 TRMs, or is there still mroe to
>>>> do?
>>>
>>> That should just be it.
> 
> Hope I didn't arrive too late :)
> 
> Yes, I think we just missed two things: the DT binding for SMMUv3 PMU
> which is just addressed by this patchset; and the PMU event aliasing
> for SMMUv3 PMU, before I inquired with John and John said he would
> upstream the related patches after kernel can export a IIDR value via
> sysfs node.
> 
> Seems to me, after this patchset for DT binding and PMU event alias
> patches are landed to the mainline kernel, it would be perfect.
> 
>>>> I had the impression that *some* part of the process was stalled
>>>> until implementations can start providing meaningful IIDRs, but I
>>>> wasn't sure whether that was tooling or just data. I just work the
>>>> low-level enablement angle :)
>>>
>>> Tooling should be ok, but I would just like to see more of these JSONs
>>> so any tooling issues can be ironed out.
>>
>> Sounds good - Jean, Leo, is that something Linaro might like to pick up as
>> part of the PMCG interest, or shall I make a note on my to-do list for the
>> new year?
> 
> I took a look for current patch for using PIDR to synthesize IIDR, it
> looks good to me.  But I tested it on Hisilicon D06 board and observed
> the composed IIDR values are still zeros.
> 
> I added a printk sentence to dump iidr value at the end of the function
> smmu_pmu_get_iidr():
> 
>    leoy@ubuntu:~$ dmesg | grep iidr
>    [   28.674087] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.8.auto: iidr=0x0
>    [   28.705239] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.9.auto: iidr=0x0
>    [   28.729924] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.10.auto: iidr=0x0
>    [   28.754855] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.11.auto: iidr=0x0
>    [   28.779811] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.12.auto: iidr=0x0
>    [   28.804755] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.13.auto: iidr=0x0
>    [   28.829825] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.14.auto: iidr=0x0
>    [   28.854767] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: iidr=0x0
> 
> Please confirm if this is expected or not?  I think this might
> introduce difficulty for John for the PMU event alias patches, which
> is dependent on a non-zero IIDR.

Yes, from previous discussions I believe the HiSilicon implementations 
don't have much meaningful ID information at all (hence why we have to 
match ACPI table headers to identify the counter erratum). My trick only 
works for Arm Ltd. implementations since they happen to have the IMP-DEF 
CoreSight registers with the same information as would be in the future 
IIDR.

To clarify, the proposal at this point is to write up JSON files for 
MMU-600/MMU-700, based on this patch, in order to pipe-clean the process 
for future SMMUv3.3 PMCG implementations with real IIDRs.

Whether other implementers might retroactively define "equivalent" IIDR 
values for their existing implementations in a way we could potentially 
quirk in the driver is an orthogonal question.

Cheers,
Robin.

> 
> At last, very appreciate your (Jean-Philippe, Robin and John) help!
> 
> Thanks,
> Leo
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
