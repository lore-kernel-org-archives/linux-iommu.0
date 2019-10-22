Return-Path: <SRS0=F9Hu=YP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B67CA9EA0
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 17:52:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB1420B7C
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 17:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB1420B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AD9B1C74;
	Tue, 22 Oct 2019 17:52:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9986DC6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 17:52:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (unknown [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4135F8A8
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 17:52:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A342431F;
	Tue, 22 Oct 2019 10:52:14 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FE23F718;
	Tue, 22 Oct 2019 10:52:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
To: Krishna Reddy <vdumpa@nvidia.com>, will@kernel.org
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d9e6425-fa69-9b76-b477-1fe50c459ca5@arm.com>
Date: Tue, 22 Oct 2019 18:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
Content-Language: en-GB
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, linux-kernel@vger.kernel.org,
	praithatha@nvidia.com, talho@nvidia.com,
	iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
	linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
	avanbrunt@nvidia.com, linux-arm-kernel@lists.infradead.org
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

Hi Krishna,

On 19/10/2019 00:31, Krishna Reddy wrote:
> Changes in v3:
> Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/ next.
> Resolved compile error seen with tegra194.dtsi changes after rebase.

Apologies for crossed wires, but I had a series getting rid of 
arm_smmu_flush_ops which was also meant to end up making things a bit 
easier for you:

https://lore.kernel.org/linux-iommu/cover.1568820087.git.robin.murphy@arm.com/

Will, did you have any plans to push out an updates or iommu/devel 
branch for Krishna to base on?

Robin.

> 
> v2 - https://lkml.org/lkml/2019/9/2/980
> v1 - https://lkml.org/lkml/2019/8/29/1588
> 
> Krishna Reddy (7):
>    iommu/arm-smmu: prepare arm_smmu_flush_ops for override
>    iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
>    dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
>    iommu/arm-smmu: Add global/context fault implementation hooks
>    arm64: tegra: Add Memory controller DT node on T194
>    arm64: tegra: Add DT node for T194 SMMU
>    arm64: tegra: enable SMMU for SDHCI and EQOS on T194
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         |   4 +
>   MAINTAINERS                                        |   2 +
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   4 +
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  88 +++++++
>   drivers/iommu/Makefile                             |   2 +-
>   drivers/iommu/arm-smmu-impl.c                      |   3 +
>   drivers/iommu/arm-smmu-nvidia.c                    | 287 +++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                           |  27 +-
>   drivers/iommu/arm-smmu.h                           |   8 +-
>   9 files changed, 413 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/iommu/arm-smmu-nvidia.c
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
