Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66467C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:46:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAE52065F
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAE52065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F3C5881C8;
	Tue, 30 Jun 2020 10:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Jl-7XRv12Jf; Tue, 30 Jun 2020 10:46:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 647C488180;
	Tue, 30 Jun 2020 10:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CECCC088F;
	Tue, 30 Jun 2020 10:46:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B422C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 58D6587CAE
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0lbrV15394N for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 10:46:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 812CF87C0A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:46:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59BF30E;
 Tue, 30 Jun 2020 03:46:43 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D153F68F;
 Tue, 30 Jun 2020 03:46:40 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To: Jon Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
 <20200629215124.GD27967@Asurada-Nvidia>
 <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <b353b3f0-ee7f-f777-4d38-c595bc990564@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <be484deb-efc9-72cd-f83f-e11713539023@arm.com>
Date: Tue, 30 Jun 2020 11:46:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b353b3f0-ee7f-f777-4d38-c595bc990564@nvidia.com>
Content-Language: en-GB
Cc: Sachin Nikam <Snikam@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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

On 2020-06-30 11:23, Jon Hunter wrote:
> 
> On 29/06/2020 23:49, Krishna Reddy wrote:
>>>> +     if (!nvidia_smmu->bases[0])
>>>> +             nvidia_smmu->bases[0] = smmu->base;
>>>> +
>>>> +     return nvidia_smmu->bases[inst] + (page << smmu->pgshift); }
>>
>>> Not critical -- just a nit: why not put the bases[0] in init()?
>>
>> smmu->base is not available during nvidia_smmu_impl_init() call. It is set afterwards in arm-smmu.c.
>> It can't be avoided without changing the devm_ioremap() and impl_init() call order in arm-smmu.c.
> 
> 
> Why don't we move the call to devm_ioremap_resource() to before
> arm_smmu_impl_init() in arm_smmu_device_probe()? From a quick look I
> don't see why we cannot do this and seems better than what we are
> currently doing which is quite confusing and hard to understand.

Yeah, I don't see any problem with adding a patch to do that. 
impl_init() does need to happen before generic probe starts touching any 
registers, but it wouldn't have any business overriding the platform 
resources or anything that would affect the ioremap itself. Plus it's 
reasonable that some theoretical future impl_init() might want to check 
registers for, say, a particular hardware revision, so having 
smmmu->base mapped and valid at that point would be no bad thing.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
