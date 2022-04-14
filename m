Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3167FC433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 10:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB36860DA5;
	Thu, 14 Apr 2022 10:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cd_hSt0tADgb; Thu, 14 Apr 2022 10:32:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84C5660ED6;
	Thu, 14 Apr 2022 10:32:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44786C0033;
	Thu, 14 Apr 2022 10:32:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F775C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 10:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14C0460ED6
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 10:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AfYt1LsQ5zQ for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 10:32:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B63360DA5
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 10:32:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C563139F;
 Thu, 14 Apr 2022 03:32:45 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE0B3F5A1;
 Thu, 14 Apr 2022 03:32:43 -0700 (PDT)
Message-ID: <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
Date: Thu, 14 Apr 2022 11:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
 iommu@lists.linux-foundation.org, christophe.jaillet@wanadoo.fr,
 tglx@linutronix.de, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2022-04-13 21:19, Nicolin Chen wrote:
> Hi Robin,
> 
> On Wed, Apr 13, 2022 at 02:40:31PM +0100, Robin Murphy wrote:
>> On 2022-04-13 05:17, Nicolin Chen wrote:
>>> To calculate num_pages, the size should be aligned with
>>> "page size", determined by the tg value. Otherwise, its
>>> following "while (iova < end)" might become an infinite
>>> loop if unaligned size is slightly greater than 1 << tg.
>>
>> Hmm, how does a non-page-aligned invalidation request get generated in
>> the first place?
> 
> I don't have the testing environment because it was a bug,
> reported by a client who uses SVA feature on top of SMMU.
> 
> But judging from the log, the non-page-aligned inv request
> was coming from an likely incorrect end address, e.g.
> 	{ start = 0xff10000, end = 0xff20000 }
> So the size turned out to be 0x10001, unaligned.
> 
> I don't have a full call trace on hand right now to see if
> upper callers are doing something wrong when calculate the
> end address, though I've asked the owner to check.
> 
> By looking at the call trace within arm_smmu_* functions:
>    __arm_smmu_tlb_inv_range
>    arm_smmu_tlb_inv_range_asid
>    arm_smmu_mm_invalidate_range
>    {from mm_notifier_* functions}
> 
> There's no address alignment check. Although I do think we
> should fix the source who passes down the non-page-aligned
> parameter, the SMMU driver shouldn't silently dead loop if
> a set of unaligned inputs are given, IMHO.

Oh, sure, I'm not saying we definitely don't need to fix anything, I'd 
just like to get a better understanding of *what* we're fixing. I'd have 
(naively) expected the mm layer to give us page-aligned quantities even 
in the SVA notifier case, so if we've got a clear off-by-one somewhere 
in that path we should fix that before just blindly over-invalidating to 
paper over it; if we still also want to be robust at the SMMU driver end 
just in case, something like "if (WARN_ON(num_pages == 0)) num_pages = 
1;" might be more appropriate. However if it turns out that we *can* 
actually end up with unsanitised input from some userspace unmap 
interface getting this far, then a silent fixup is the best option, but 
if so I'd still like to confirm that we're rounding in the same 
direction as whoever touched the pagetables (since it can't have been us).

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
