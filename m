Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E7BC433EF
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:44:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24C960F46
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B24C960F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8839D605A0;
	Fri, 12 Nov 2021 13:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f00Vhf8sqASf; Fri, 12 Nov 2021 13:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A0C16068A;
	Fri, 12 Nov 2021 13:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 577F7C001E;
	Fri, 12 Nov 2021 13:44:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB0FC0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BE4A40148
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FoLr2p-wjrP0 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 13:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D099400CC
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:43:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5207CED1;
 Fri, 12 Nov 2021 05:43:56 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359863F70D;
 Fri, 12 Nov 2021 05:43:55 -0800 (PST)
Subject: Re: [PATCH 0/4] iommu/arm-smmu: Support Tegra234 SMMU
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20211112131231.3683098-1-thierry.reding@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e19479d9-f0b4-5347-1a43-2fcf5224a090@arm.com>
Date: Fri, 12 Nov 2021 13:43:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112131231.3683098-1-thierry.reding@gmail.com>
Content-Language: en-GB
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
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

On 12/11/2021 1:12 pm, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi,
> 
> this series of patches adds and enables support for the ARM SMMU
> instances found on the new Tegra234 SoC. This is mostly similar to what
> can be found on Tegra194 except that there are a few more instances to
> meet increased bandwidth needs.
> 
> In addition to adding support for the new Tegra234 compatible string,
> this also adds a missing description for the nvidia,memory-controller
> property to the ARM SMMU device tree binding.

Besides a nitpick about the inconsistent enum ordering in patch #2,

Acked-by: Robin Murphy <robin.murphy@arm.com>

for patches #1-3.

Cheers,
Robin.

> I plan on picking up patch 4 into the Tegra tree because it has a
> dependency (for the stream ID definitions) on a separate patch series
> for the memory controller that I sent out earlier.
> 
> Thanks,
> Thierry
> 
> Thierry Reding (4):
>    dt-bindings: arm-smmu: Document nvidia,memory-controller property
>    dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
>    iommu/arm-smmu: Support Tegra234 SMMU
>    arm64: tegra: Add Tegra234 IOMMUs
> 
>   .../devicetree/bindings/iommu/arm,smmu.yaml   |  13 +-
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 426 ++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +-
>   3 files changed, 440 insertions(+), 2 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
