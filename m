Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FEAECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 18:00:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5322086A
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 18:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5322086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0E79EC6C;
	Tue, 15 Oct 2019 18:00:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC992C37
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 18:00:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 40338821
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 18:00:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B79BE337;
	Tue, 15 Oct 2019 11:00:20 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7303F6C4;
	Tue, 15 Oct 2019 11:00:18 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] SMMUv3 PMCG IMP DEF event support
To: John Garry <john.garry@huawei.com>, lorenzo.pieralisi@arm.com,
	guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
	will@kernel.org
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <66a3ce9f-d3cd-110f-7353-46e6eaf25b7c@arm.com>
Date: Tue, 15 Oct 2019 19:00:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: nleeder@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Hi John,

On 30/09/2019 15:33, John Garry wrote:
> This patchset adds IMP DEF event support for the SMMUv3 PMCG.
> 
> It is marked as an RFC as the method to identify the PMCG implementation
> may be a quite disliked. And, in general, the series is somewhat
> incomplete.
> 
> So the background is that the PMCG supports IMP DEF events, yet we have no
> method to identify the PMCG to know the IMP DEF events.
> 
> A method for identifying the PMCG implementation could be using
> PMDEVARCH, but we cannot rely on this being set properly, as whether this
> is implemented is not defined in SMMUv3 spec.
> 
> Another method would be perf event aliasing, but this method of event
> matching is based on CPU id, which would not guarantee same
> uniqueness as PMCG implementation.
> 
> Yet another method could be to continue using ACPI OEM ID in the IORT
> code, but this does not scale. And it is not suitable if we ever add DT
> support to the PMCG driver.
> 
> The method used in this series is based on matching on the parent SMMUv3
> IIDR. We store this IIDR contents in the arm smmu structure as the first
> element, which means that we don't have to expose SMMU APIs - this is
> the part which may be disliked.
> 
> The final two patches switch the pre-existing PMCG model identification
> from ACPI OEM ID to the same parent SMMUv3 IIDR matching.
> 
> For now, we only consider SMMUv3' nodes being the associated node for
> PMCG.

Two significant concerns right off the bat:

- It seems more common than not for silicon designers to fail to 
implement IIDR correctly, so it's only a matter of time before 
inevitably needing to bring back some firmware-level identifier 
abstraction (if not already - does Hi161x have PMCGs?)

- This seems like a step in entirely the wrong direction for supporting 
PMCGs that reference a Named Component or Root Complex.

Interpreting the Node Reference is definitely a welcome improvement over 
matching table headers, but absent a truly compelling argument to the 
contrary, I'd rather retain the "PMCG model" abstraction in between that 
and the driver itself (especially since those can trivially be hung off 
compatibles once it comes to DT support).

Thanks,
Robin.

> 
> John Garry (6):
>    ACPI/IORT: Set PMCG device parent
>    iommu/arm-smmu-v3: Record IIDR in arm_smmu_device structure
>    perf/smmuv3: Retrieve parent SMMUv3 IIDR
>    perf/smmuv3: Support HiSilicon hip08 (hi1620) IMP DEF events
>    perf/smmuv3: Match implementation options based on parent SMMU IIDR
>    ACPI/IORT: Drop code to set the PMCG software-defined model
> 
>   drivers/acpi/arm64/iort.c     | 69 ++++++++++++++--------------
>   drivers/iommu/arm-smmu-v3.c   |  5 +++
>   drivers/perf/arm_smmuv3_pmu.c | 84 ++++++++++++++++++++++++++++++-----
>   include/linux/acpi_iort.h     |  8 ----
>   4 files changed, 112 insertions(+), 54 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
