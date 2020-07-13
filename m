Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE2C433E4
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 14:10:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667A72072D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 14:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667A72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0280A2014B;
	Mon, 13 Jul 2020 14:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORf3KS4-y5tF; Mon, 13 Jul 2020 14:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DCFB320013;
	Mon, 13 Jul 2020 14:10:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8062C088E;
	Mon, 13 Jul 2020 14:10:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB899C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 14:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9636786381
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 14:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3xpk6g1DstR for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 14:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C0A1D845A3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 14:10:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D3E30E;
 Mon, 13 Jul 2020 07:10:45 -0700 (PDT)
Received: from [10.57.62.178] (unknown [10.57.62.178])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2E43F7BB;
 Mon, 13 Jul 2020 07:10:40 -0700 (PDT)
Subject: Re: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
To: Krishna Reddy <vdumpa@nvidia.com>, Rob Herring <robh@kernel.org>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-5-vdumpa@nvidia.com> <20200709201348.GA808454@bogus>
 <BYAPR12MB2822514F93F831507A811EE9B3650@BYAPR12MB2822.namprd12.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c2ab2a0d-419d-555f-c124-2cfa1ecb2a81@arm.com>
Date: Mon, 13 Jul 2020 15:10:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2822514F93F831507A811EE9B3650@BYAPR12MB2822.namprd12.prod.outlook.com>
Content-Language: en-GB
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>,
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

On 2020-07-10 21:29, Krishna Reddy wrote:
> Thanks Rob. One question on setting "minItems: ". Please see below.
> 
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - nvidia,tegra194-smmu
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 2
>>> +          maxItems: 2
> 
>> This doesn't work. The main part of the schema already said there's only
>> 1 reg region. This part is ANDed with that, not an override. You need to add an else clause with 'maxItems: 1' and change the base schema to
>> {minItems: 1, maxItems: 2}.
> 
> As the earlier version of base schema doesn't have "minItems: " set, should it be set to 0 for backward compatibility?  Or can it just be omitted setting in base schema as before?

We've always needed at least 1 "reg" specifier in practice, so I don't 
think being backwards-compatible with broken DTs is a concern :)

Robin.

> 
> "else" part to set "maxItems: 1" and setting "maxItems: 2" in base schema is clear to me.
> 
> 
> -KR
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
