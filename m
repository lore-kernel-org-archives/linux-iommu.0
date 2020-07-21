Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC04C433E3
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928D520709
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6oaoypm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928D520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4ADB025F8B;
	Tue, 21 Jul 2020 08:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSctAdmC3Lcb; Tue, 21 Jul 2020 08:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9405B261B4;
	Tue, 21 Jul 2020 08:03:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76EBEC088E;
	Tue, 21 Jul 2020 08:03:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC3FAC016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C1873894D9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9BmmPReO9zkY for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 08:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3F651894D8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:03:58 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8E4820709;
 Tue, 21 Jul 2020 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595318638;
 bh=+MyaGmTaU19aPpvAgrnfqAXQzHmb6mhfDcgxCLDkT9E=;
 h=Date:From:To:Cc:Subject:From;
 b=a6oaoypm/8b8eKHs4w9CyA8FwIifMPoXrvDj5jj0k0QhmP89uNbdaXVhTvSeLCvOj
 9ptI6ZQw/oWLsYe3436+stZiDSd/Gzxo0/KCc2AIHGFxUmz1TeVShAhd8Wnn4VxjUz
 SSAUielerz1JpuKgUy5MgxVHUz7hFc7JqBzPFW/s=
Date: Tue, 21 Jul 2020 09:03:53 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.9
Message-ID: <20200721080352.GA13023@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

Please pull these Arm SMMU driver updates for 5.9. Summary is in the tag,
but the main thing is support for two new SoC integrations, one of which
is considerably more brain-dead than the other (determining which one is
left as an exercise to the reader although the diffstat is fairly revealing).

Cheers,

Will

--->8

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to aa7ec73297df57a86308fee78d2bf86e22ea0bae:

  iommu/arm-smmu: Add global/context fault implementation hooks (2020-07-20 09:30:51 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.9

- Support for SMMU-500 implementation in Marvell Armada-AP806 SoC

- Support for SMMU-500 implementation in NVIDIA Tegra194 SoC

- DT compatible string updates

- Remove unused IOMMU_SYS_CACHE_ONLY flag

----------------------------------------------------------------
Hanna Hawa (1):
      iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743

John Garry (1):
      iommu/arm-smmu-v3: Fix trivial typo

Jonathan Marek (2):
      dt-bindings: arm-smmu: Add sm8150 and sm8250 compatible strings
      iommu: arm-smmu-impl: Use qcom impl for sm8150 and sm8250 compatibles

Krishna Reddy (5):
      iommu/arm-smmu: move TLB timeout and spin count macros
      iommu/arm-smmu: ioremap smmu mmio region before implementation init
      iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
      dt-bindings: arm-smmu: add binding for Tegra194 SMMU
      iommu/arm-smmu: Add global/context fault implementation hooks

Robin Murphy (1):
      iommu/arm-smmu: Update impl quirks comment

Tomasz Nowicki (2):
      iommu/arm-smmu: Call configuration impl hook before consuming features
      dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500

Will Deacon (1):
      iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag

 Documentation/arm64/silicon-errata.rst             |   3 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  31 ++-
 MAINTAINERS                                        |   2 +
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm-smmu-impl.c                      |  60 ++++-
 drivers/iommu/arm-smmu-nvidia.c                    | 278 +++++++++++++++++++++
 drivers/iommu/arm-smmu-v3.c                        |   2 +-
 drivers/iommu/arm-smmu.c                           |  40 ++-
 drivers/iommu/arm-smmu.h                           |   6 +
 drivers/iommu/io-pgtable-arm.c                     |   3 -
 include/linux/iommu.h                              |   6 -
 11 files changed, 403 insertions(+), 30 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
