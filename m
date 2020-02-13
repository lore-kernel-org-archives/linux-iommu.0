Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A92C3F68F
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 17:23:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687D3217F4
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 17:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687D3217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D8CE2153F;
	Thu, 13 Feb 2020 17:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOeP4tJv28mM; Thu, 13 Feb 2020 17:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2EB852152F;
	Thu, 13 Feb 2020 17:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D05C08A4;
	Thu, 13 Feb 2020 17:23:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 213B3C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 17:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F6BF86657
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 17:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id saDfY8Jj8r04 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 17:23:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9138886292
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 17:23:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75ED328;
 Thu, 13 Feb 2020 09:23:25 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568773F6CF;
 Thu, 13 Feb 2020 09:23:24 -0800 (PST)
Subject: Re: [PATCH v4 0/5] memory: Introduce memory controller mini-framework
To: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9841eb35-65e4-632a-ceff-bb2ba3b11bb0@arm.com>
Date: Thu, 13 Feb 2020 17:23:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

[+ Maxime]

On 13/02/2020 4:39 pm, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi,
> 
> this set of patches adds a new binding that allows device tree nodes to
> explicitly define the DMA parent for a given device. This supplements
> the existing interconnect bindings and is useful to disambiguate in the
> case where a device has multiple paths to system memory. Beyond that it
> can also be useful when there aren't any actual interconnect paths that
> can be controlled, so in simple cases this can serve as a simpler
> variant of interconnect paths.

Isn't that still squarely the intent of the "dma-mem" binding, though? 
i.e. it's not meant to be a 'real' interconnect provider, but a very 
simple way to encode DMA parentage piggybacked onto a more general 
binding (with the *option* of being a full-blown interconnect if it 
wants to, but certainly no expectation).

Robin.

> One other case where this is useful is to describe the relationship
> between devices such as the memory controller and an IOMMU, for example.
> On Tegra186 and later, the memory controller is programmed with a set of
> stream IDs that are to be associated with each memory client. This
> programming needs to happen before translations through the IOMMU start,
> otherwise the used stream IDs may deviate from the expected values. The
> memory-controllers property is used in this case to ensure that the
> memory controller driver has been probed (and hence has programmed the
> stream ID mappings) before the IOMMU becomes available.
> 
> Patch 1 introduces the memory controller bindings, both from the
> perspective of the provider and the consumer. Patch 2 makes use of a
> memory-controllers property to determine the DMA parent for the purpose
> of setting up DMA masks (based on the dma-ranges property of the DMA
> parent). Patch 3 introduces a minimalistic framework that is used to
> register memory controllers with along with a set of helpers to look up
> the memory controller from device tree.
> 
> An example of how to register a memory controller is shown in patch 4
> for Tegra186 (and later) and finally the ARM SMMU driver is extended to
> become a consumer of an (optional) memory controller. As described
> above, the goal is to defer probe as long as the memory controller has
> not yet programmed the stream ID mappings.
> 
> Thierry
> 
> Thierry Reding (5):
>    dt-bindings: Add memory controller bindings
>    of: Use memory-controllers property for DMA parent
>    memory: Introduce memory controller mini-framework
>    memory: tegra186: Register as memory controller
>    iommu: arm-smmu: Get reference to memory controller
> 
>   .../bindings/memory-controllers/consumer.yaml |  14 +
>   .../memory-controllers/memory-controller.yaml |  32 +++
>   drivers/iommu/arm-smmu.c                      |  11 +
>   drivers/iommu/arm-smmu.h                      |   2 +
>   drivers/memory/Makefile                       |   1 +
>   drivers/memory/core.c                         | 248 ++++++++++++++++++
>   drivers/memory/tegra/tegra186.c               |   9 +-
>   drivers/of/address.c                          |  25 +-
>   include/linux/memory-controller.h             |  34 +++
>   9 files changed, 366 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/consumer.yaml
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml
>   create mode 100644 drivers/memory/core.c
>   create mode 100644 include/linux/memory-controller.h
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
