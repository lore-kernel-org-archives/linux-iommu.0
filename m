Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54827C433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:03:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2553420853
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2553420853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E09BB89359;
	Wed,  1 Jul 2020 19:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsYxgWbSlSrD; Wed,  1 Jul 2020 19:03:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3869A8928E;
	Wed,  1 Jul 2020 19:03:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EA4FC0865;
	Wed,  1 Jul 2020 19:03:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA94FC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BD48222091
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClYtODyEk3ty for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 19:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 50B2022053
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:03:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3441FB;
 Wed,  1 Jul 2020 12:03:14 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0A843F68F;
 Wed,  1 Jul 2020 12:03:11 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To: Jon Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a9e0b213-0601-01fa-8664-e292bf7c81aa@arm.com>
Date: Wed, 1 Jul 2020 20:03:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
Content-Language: en-GB
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Bryan Huntsman <bhuntsman@nvidia.com>,
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

On 2020-07-01 19:47, Jon Hunter wrote:
> 
> On 01/07/2020 19:28, Krishna Reddy wrote:
>>>> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
>>> Hmm, there must be a better way to word that to express that it only applies to the sets of SMMUs that must be programmed identically, and not any other independent MMU-500s that might also happen to be in the same SoC.
>>
>> Let me reword it to "NVIDIA SoCs that must program multiple MMU-500s identically".
>>
>>>> +        items:
>>>> +          - enum:
>>>> +              - nvdia,tegra194-smmu
>>>> +          - const: arm,mmu-500
>>
>>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
>>
>> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.
> 
> The problem is, if for some reason someone had a Tegra194, but only set
> the compatible string to 'arm,mmu-500' it would assume that it was a
> normal arm,mmu-500 and only one instance would be programmed. We always
> want at least 2 of the 3 instances programmed and so we should only
> match 'nvidia,tegra194-smmu'. In fact, I think that we also need to
> update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with
> the data set to &arm_mmu500.

Right, the main concern is if the shiny new DT gets passed to an older 
kernel (or other OS entirely) which doesn't know the 
"nvdia,tegra194-smmu" compatible but would match on "arm,mmu-500" and 
bind a standard driver thinking it's going to work OK. The user would 
probably prefer that no driver matched and both instances were left 
turned off, than face the fallout of only one of them being set up.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
