Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6FCC433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3605A61040
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3605A61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03054401B1;
	Tue, 16 Nov 2021 12:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DKrvmzY6OJGL; Tue, 16 Nov 2021 12:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A55BA40004;
	Tue, 16 Nov 2021 12:03:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6550EC001E;
	Tue, 16 Nov 2021 12:03:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3E89C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 12:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B291440185
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 12:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Irbl7_SDG_Q for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 12:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5366F40004
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 12:02:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EDE11FB;
 Tue, 16 Nov 2021 04:02:57 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A58CC3F5A1;
 Tue, 16 Nov 2021 04:02:55 -0800 (PST)
Message-ID: <3b5cb536-5a11-5096-4369-cec3d369ec52@arm.com>
Date: Tue, 16 Nov 2021 12:02:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] perf/smmuv3: Support devicetree
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, robh+dt@kernel.org
References: <20211116113536.69758-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211116113536.69758-1-jean-philippe@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2021-11-16 11:35, Jean-Philippe Brucker wrote:
> Add devicetree binding for the SMMUv3 PMU, called Performance Monitoring
> Counter Group (PMCG) in the spec. Each SMMUv3 implementation can have
> multiple independent PMCGs, for example one for the Translation Control
> Unit (TCU) and one per Translation Buffer Unit (TBU).
> 
> I previously sent the binding as reply to Jay Chen's thread implementing
> device tree support [1]. This posting addresses the comments from that
> thread.

Ha, I'd also resurrected this and was planning to post it at some point 
this week[0] - you should have said :)

> Patch 1 adds two compatible strings. "arm,smmu-v3-pmcg" is common to all
> PMCGs. "hisilicon,smmu-v3-pmcg-hip08" allows to support the same quirk
> as IORT for that implementation (see patch 2). We'll probably want to
> also introduce compatible strings for each implementation that has
> additional perf events. For example the MMU-600 implementation has
> different events for TCU and TBU PMCGs [2], but both components have the
> same device IDs. So the driver could differentiate them if they had two
> distinct compatible strings such as "arm,mmu-600-pmcg-tbu" and
> "arm,mmu-600-pmcg-tcu".

Actually it only needs a general MMU-600 compatible, since once you know 
it's an Arm Ltd. implementation, you can assume the pattern for the 
IMP_DEF ID registers to figure out the rest.

Robin.

[0] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/smmu-pmcg

> The series doesn't deal with this because for testing I use a software
> model which only implements architected events. I do not include DTS
> change for that platform because enabling PMCGs requires an additional
> model option. See my branch smmu/pmu-dt [3] for details.
> 
> [1] https://lore.kernel.org/all/20200707150114.GC159413@myrica/
> [2] https://developer.arm.com/documentation/100310/0202/Functional-description/Operation/Performance-Monitoring-Unit
> [3] https://jpbrucker.net/git/linux/log/?h=smmu/pmu-dt
> 
> Jean-Philippe Brucker (2):
>    dt-bindings: Add Arm SMMUv3 PMCG binding
>    perf/smmuv3: Add devicetree support
> 
>   .../bindings/iommu/arm,smmu-v3-pmcg.yaml      | 67 +++++++++++++++++++
>   drivers/perf/arm_smmuv3_pmu.c                 | 25 ++++++-
>   2 files changed, 90 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
