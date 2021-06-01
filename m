Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C004C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 12:26:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA136101C
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 12:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA136101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5BC140440;
	Tue,  1 Jun 2021 12:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ynwHZ59H29Sw; Tue,  1 Jun 2021 12:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37CB140449;
	Tue,  1 Jun 2021 12:26:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0FDFC000D;
	Tue,  1 Jun 2021 12:26:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCE52C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 12:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6408400C4
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 12:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6iGnCpTsQBg5 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 12:26:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F4C040004
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 12:26:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D66B060FF0;
 Tue,  1 Jun 2021 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622550411;
 bh=eXqJC3GRoWPNutXm6EevRjIRj1wQ3hmw12wr3ZM5m7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rN+o2G4MHs1yeYvPmTOT8oqOzaqINuKaNHKggKT77EUnHxTV67rhmn3KfH6IAxtlL
 m3vCUBcCZ5+DouvljOQC1q4oELw6hDAZ6N3IMWVzvr0OOhDt2YzUyk1GxbmSKyv+y2
 Ld1+GprZJWsbWVt3rnlSqeCUPysA8HBELfRYmBzakT51wYAgBMzLYgxmDwyzkY22VV
 Keivj4UvIYKb4UKDCa9mmJIrs4XxR7sMBc4xeO3alvw30Xu0uGyKYhlW/DUei7tBY9
 y+kL4Bc+ylMniYyeteVF5h9KfvjBxV9VlB17TZbmvKp4p2g77My4xf463aUNLsxbUd
 YVoiotYyNBDRQ==
Date: Tue, 1 Jun 2021 13:26:46 +0100
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Message-ID: <20210601122646.GB27832@willie-the-truck>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLEi2FonP568wYrE@orome.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Hi,
> > 
> > this is a set of patches that is the result of earlier discussions
> > regarding early identity mappings that are needed to avoid SMMU faults
> > during early boot.
> > 
> > The goal here is to avoid early identity mappings altogether and instead
> > postpone the need for the identity mappings to when devices are attached
> > to the SMMU. This works by making the SMMU driver coordinate with the
> > memory controller driver on when to start enforcing SMMU translations.
> > This makes Tegra behave in a more standard way and pushes the code to
> > deal with the Tegra-specific programming into the NVIDIA SMMU
> > implementation.
> > 
> > Compared to the original version of these patches, I've split the
> > preparatory work into a separate patch series because it became very
> > large and will be mostly uninteresting for this audience.
> > 
> > Patch 1 provides a mechanism to program SID overrides at runtime. Patch
> > 2 updates the ARM SMMU device tree bindings to include the Tegra186
> > compatible string as suggested by Robin during review.
> > 
> > Patches 3 and 4 create the fundamentals in the SMMU driver to support
> > this and also make this functionality available on Tegra186. Patch 5
> > hooks the ARM SMMU up to the memory controller so that the memory client
> > stream ID overrides can be programmed at the right time.
> > 
> > Patch 6 extends this mechanism to Tegra186 and patches 7-9 enable all of
> > this through device tree updates. Patch 10 is included here to show how
> > SMMU will be enabled for display controllers. However, it cannot be
> > applied yet because the code to create identity mappings for potentially
> > live framebuffers hasn't been merged yet.
> > 
> > The end result is that various peripherals will have SMMU enabled, while
> > the display controllers will keep using passthrough, as initially set up
> > by firmware. Once the device tree bindings have been accepted and the
> > SMMU driver has been updated to create identity mappings for the display
> > controllers, they can be hooked up to the SMMU and the code in this
> > series will automatically program the SID overrides to enable SMMU
> > translations at the right time.
> > 
> > Note that the series creates a compile time dependency between the
> > memory controller and IOMMU trees. If it helps I can provide a branch
> > for each tree, modelling the dependency, once the series has been
> > reviewed.
> > 
> > Changes in v2:
> > - split off the preparatory work into a separate series (that needs to
> >   be applied first)
> > - address review comments by Robin
> > 
> > Thierry
> > 
> > Thierry Reding (10):
> >   memory: tegra: Implement SID override programming
> >   dt-bindings: arm-smmu: Add Tegra186 compatible string
> >   iommu/arm-smmu: Implement ->probe_finalize()
> >   iommu/arm-smmu: tegra: Detect number of instances at runtime
> >   iommu/arm-smmu: tegra: Implement SID override programming
> >   iommu/arm-smmu: Use Tegra implementation on Tegra186
> >   arm64: tegra: Use correct compatible string for Tegra186 SMMU
> >   arm64: tegra: Hook up memory controller to SMMU on Tegra186
> >   arm64: tegra: Enable SMMU support on Tegra194
> >   arm64: tegra: Enable SMMU support for display on Tegra194
> > 
> >  .../devicetree/bindings/iommu/arm,smmu.yaml   |  11 +-
> >  arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   4 +-
> >  arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 166 ++++++++++++++++++
> >  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +-
> >  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  90 ++++++++--
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c         |  13 ++
> >  drivers/iommu/arm/arm-smmu/arm-smmu.h         |   1 +
> >  drivers/memory/tegra/mc.c                     |   9 +
> >  drivers/memory/tegra/tegra186.c               |  72 ++++++++
> >  include/soc/tegra/mc.h                        |   3 +
> >  10 files changed, 349 insertions(+), 23 deletions(-)
> 
> Will, Robin,
> 
> do you have any more comments on the ARM SMMU bits of this series? If
> not, can you guys provide an Acked-by so that Krzysztof can pick this
> (modulo the DT patches) up into the memory-controller tree for v5.14?
> 
> I'll send out a v3 with the bisectibilitiy fix that Krishna pointed
> out.

Probably best if I queue 3-6 on a separate branch once you send a v3,
then Krzysztof can pull that in if he needs it.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
