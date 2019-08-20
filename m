Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD830C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 13:00:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15C422D6D
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15C422D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7E2BAD39;
	Tue, 20 Aug 2019 13:00:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 817CAC5D
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 13:00:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 19A1587
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 13:00:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62189344;
	Tue, 20 Aug 2019 06:00:53 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206CA3F246;
	Tue, 20 Aug 2019 06:00:51 -0700 (PDT)
Subject: Re: [PATCH v2 17/17] iommu/arm-smmu: Add context init implementation
	hook
To: Vivek Gautam <vivek.gautam@codeaurora.org>, will@kernel.org
References: <cover.1565892337.git.robin.murphy@arm.com>
	<f50c14834bb7a4f0f7c765d433c2defdb03661c9.1565892337.git.robin.murphy@arm.com>
	<8306f3f1-925c-0b02-8103-9d4a510005b2@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8bd76c3e-823d-86b2-785e-e80685edfa6c@arm.com>
Date: Tue, 20 Aug 2019 14:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8306f3f1-925c-0b02-8103-9d4a510005b2@codeaurora.org>
Content-Language: en-GB
Cc: gregory.clement@bootlin.com, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 20/08/2019 11:15, Vivek Gautam wrote:
[...]
> Hi Robin,
> 
> Sorry for responding late to this series. I have couple of doubts here 
> that I wanted to discuss.
> 
> Are we standardizing these implementation specific ops? Each vendor 
> implementations will have something peculiar to take care. Things are 
> good right now with 'reset', 'cfg_probe', and 'init_context' hooks.
> But, on top of vendor implementation details, there can be SoC specific 
> errata changes that need to be added.

The idea behind the impl hooks is to try to have them in logical places 
which should be suitable for multiple different workarounds (e.g. 
init_context is arranged to allow replacing smmu_domain->tlb_ops) - I 
want to avoid proliferating dozens of them that end up each being 
specific to individual workarounds, but that's not to say that the 
design we're starting with here is by any means complete or final. We're 
almost certainly going to evolve more hooks (and possibly adjust the 
current ones) in future.

> Moreover, adding implementation data based on __model__ may not suffice 
> for long. Do you suggest adding any other data variable in the 
> ARM_SMMU_MATCH_DATA?

As commented in the code, the setup for the existing quirks works out to 
be deceptively simple, and it can and will change. Ultimately I'm fully 
expecting to end up with complex logic hanging off arm_smmu_impl_init() 
to detect the integration details and compose sets of impl hooks in 
various ways as appropriate - I doubt that it's going to be practical or 
even possible to have static data for *every* possibility. The 
fundamental shape of the code is based on "model" quirks being more 
general than "integration" quirks, such that the latter should be in a 
position to dynamically inherit (or statically replace, in simple cases) 
the hooks of the former.

> To show SoC specific needs, I have the change attached in this email to 
> take care of the SDM845 'wait-for-safe' sequence.
> Please take a look.

Other than that introducing QCOM_SMMU500 seems to be redundant, and 
whether it also needs ACPI-based detection, that certainly seems fairly 
reasonable for a simple isolated workaround. However, is the firmware 
call really a one-off probe-time thing? If the firmware does take care 
of preserving the wait-for-safe state across 
suspend/resume/hibernate/etc. then fair enough, but I would have assumed 
that the reset hook would be the more likely place to put it.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
