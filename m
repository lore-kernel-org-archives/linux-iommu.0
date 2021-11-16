Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B4EC433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 17:00:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EAB61A88
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 17:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66EAB61A88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 205CC60674;
	Tue, 16 Nov 2021 17:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQYYeRx7fBQZ; Tue, 16 Nov 2021 17:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04EFC6066D;
	Tue, 16 Nov 2021 17:00:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEB1DC002E;
	Tue, 16 Nov 2021 17:00:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 052CFC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 17:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D326980CE8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 17:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9bx5Ot-ga6A for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 17:00:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B570680CF8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 17:00:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE736D;
 Tue, 16 Nov 2021 09:00:20 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00BE73F5A1;
 Tue, 16 Nov 2021 09:00:18 -0800 (PST)
Message-ID: <54be6173-59d3-7ce8-e04b-b5197fdc0e10@arm.com>
Date: Tue, 16 Nov 2021 17:00:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] perf/smmuv3: Support devicetree
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <3b5cb536-5a11-5096-4369-cec3d369ec52@arm.com> <YZPRTUis+G279XIO@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YZPRTUis+G279XIO@myrica>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, uchida.jun@socionext.com,
 leo.yan@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2021-11-16 15:42, Jean-Philippe Brucker wrote:
> On Tue, Nov 16, 2021 at 12:02:47PM +0000, Robin Murphy wrote:
>> On 2021-11-16 11:35, Jean-Philippe Brucker wrote:
>>> Add devicetree binding for the SMMUv3 PMU, called Performance Monitoring
>>> Counter Group (PMCG) in the spec. Each SMMUv3 implementation can have
>>> multiple independent PMCGs, for example one for the Translation Control
>>> Unit (TCU) and one per Translation Buffer Unit (TBU).
>>>
>>> I previously sent the binding as reply to Jay Chen's thread implementing
>>> device tree support [1]. This posting addresses the comments from that
>>> thread.
>>
>> Ha, I'd also resurrected this and was planning to post it at some point this
>> week[0] - you should have said :)
> 
> Ah sorry about that, I just resent because there was some demand for it at
> Linaro

Heh, no worries - it's not like you were even CC'ed on the thread where 
I only mentioned I *might* do it.

Can I get away with being cheeky and just saying that my review comments 
are the diff between my branch and yours, I wonder...

>>> Patch 1 adds two compatible strings. "arm,smmu-v3-pmcg" is common to all
>>> PMCGs. "hisilicon,smmu-v3-pmcg-hip08" allows to support the same quirk
>>> as IORT for that implementation (see patch 2). We'll probably want to
>>> also introduce compatible strings for each implementation that has
>>> additional perf events. For example the MMU-600 implementation has
>>> different events for TCU and TBU PMCGs [2], but both components have the
>>> same device IDs. So the driver could differentiate them if they had two
>>> distinct compatible strings such as "arm,mmu-600-pmcg-tbu" and
>>> "arm,mmu-600-pmcg-tcu".
>>
>> Actually it only needs a general MMU-600 compatible, since once you know
>> it's an Arm Ltd. implementation, you can assume the pattern for the IMP_DEF
>> ID registers to figure out the rest.
> 
> It might be an error in the MMU-600 spec specifically, both TBU and TCU
> PMU registers have a 0x83 PIDR0, where I think the TBU should be 0x84 (the
> revC model uses that value). It's possible that the implementation
> actually has 0x84 instead.

Yup, it's a mistake in the TRM. I just checked a real MMU-600 and the 
PMU PIDRs match the main TCU/TBU PIDRs as expected. At least the MMU-700 
docs haven't repeated the same error.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
