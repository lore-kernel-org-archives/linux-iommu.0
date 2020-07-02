Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A27CC433DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 16:05:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59862207CD
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 16:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59862207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A1388AFEC;
	Thu,  2 Jul 2020 16:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vShlsnJDvX7; Thu,  2 Jul 2020 16:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E1ED8AFDF;
	Thu,  2 Jul 2020 16:05:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44409C0888;
	Thu,  2 Jul 2020 16:05:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68D82C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 16:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 562FB8AFDF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 16:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qAylt0h6p78T for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 16:05:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id F1FEB8AFE2
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 16:05:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD53C1FB;
 Thu,  2 Jul 2020 09:05:17 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D70973F71E;
 Thu,  2 Jul 2020 09:05:14 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To: Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
 <BYAPR12MB282245DD6BB50ECA700AC69EB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <b10673f6-2a01-b9e5-0948-9684ffbe1813@nvidia.com>
 <BYAPR12MB2822EE99210BFA984ECB954AB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <04e35d51-5e65-047d-90ef-a2de901eb15d@arm.com>
Date: Thu, 2 Jul 2020 17:05:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2822EE99210BFA984ECB954AB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
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

On 2020-07-01 20:39, Krishna Reddy wrote:
> On 01/07/2020 20:00, Krishna Reddy wrote:
>>>>>>> +        items:
>>>>>>> +          - enum:
>>>>>>> +              - nvdia,tegra194-smmu
>>>>>>> +          - const: arm,mmu-500
>>>>>
>>>>>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
>>>>>
>>>>> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.
>>>
>>>> The problem is, if for some reason someone had a Tegra194, but only set the compatible string to 'arm,mmu-500' it would assume that it was a normal arm,mmu-500 and only one instance would be programmed. We always want at least 2 of the 3 instances >>programmed and so we should only match 'nvidia,tegra194-smmu'. In fact, I think that we also need to update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with the data set to &arm_mmu500.
>>>
>>> In that case, new binding "nvidia,smmu-v2" can be added with data set to &arm_mmu500 and enumeration would have nvidia,tegra194-smmu and another variant for next generation SoC in future.
> 
>> I think you would be better off with nvidia,smmu-500 as smmu-v2 appears to be something different. I see others have a smmu-v2 but I am not sure if that is legacy. We have an smmu-500 and so that would seem more appropriate.
> 
> I tried to use the binding synonymous to other vendors.
> V2 is the architecture version.  MMU-500 is the actual implementation from ARM based on V2 arch.  As we just use the MMU-500 IP as it is, It can be named as nvidia,smmu-500 or similar as well.

Yup, that sounds OK to me if you want a broader compatible to 
potentially match other future SoCs as well.

> Others probably having their own implementation based on V2 arch.

Exactly - "cavium,smmu-v2" and "qcom,smmu-v2" are their own in-house 
microarchitectures, not one of Arm's designs, so they don't really have 
a suitable 'product name' we could have used for the bindings.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
