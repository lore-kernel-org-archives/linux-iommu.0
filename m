Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2225C433FE
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 16:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D078417AF;
	Wed, 20 Apr 2022 16:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wp-RQszDCkaR; Wed, 20 Apr 2022 16:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E8B54094E;
	Wed, 20 Apr 2022 16:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2265FC0033;
	Wed, 20 Apr 2022 16:05:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C9AC002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7233F417AF
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJUh1Kb--iBZ for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 16:05:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EA444094E
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:05:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5433E1424;
 Wed, 20 Apr 2022 09:05:13 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C9C83F766;
 Wed, 20 Apr 2022 09:05:10 -0700 (PDT)
Message-ID: <5ae51610-5027-777e-36e3-7bdb92e00752@arm.com>
Date: Wed, 20 Apr 2022 17:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/13] iommu/arm-smmu: Clean up bus_set_iommu()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
 <20220419144042.GA6186@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220419144042.GA6186@willie-the-truck>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

On 2022-04-19 15:40, Will Deacon wrote:
> On Thu, Apr 14, 2022 at 01:42:33PM +0100, Robin Murphy wrote:
>> Stop calling bus_set_iommu() since it's now unnecessary. With device
>> probes now replayed for every IOMMU instance registration, the whole
>> sorry ordering workaround for legacy DT bindings goes too, hooray!
> 
> Ha, I hope you tested this!

Oh alright then, since it's you... :)

I've hacked up a Juno DT with the old bindings, and (after needing a 
while to remember that they're fundamentally incompatible with 
disable_bypass), can confirm that with my whole dev branch including 
this series applied, it boots and creates IOMMU groups as expected. I 
then made the mistake of trying without the branch to check whether the 
squawks from iommu_setup_dma_ops() were new or not, and... well... plain 
rc3 doesn't even boot on the same setup - it's somehow blowing up in the 
failure cleanup path of iommu_bus_init(), apparently calling 
iommu_release_device() on something where dev->iommu->iommu_dev is NULL, 
for reasons that are far from clear and I'm not sure I can really be 
bothered to debug further... :/

Cheers,
Robin.

>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 84 +--------------------------
>>   1 file changed, 2 insertions(+), 82 deletions(-)
> 
> Assuming it works,
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
