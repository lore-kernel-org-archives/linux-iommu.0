Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A373C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:05:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B89B20738
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1tq323Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B89B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E289286891;
	Wed, 30 Sep 2020 08:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wGqGk23QgDvZ; Wed, 30 Sep 2020 08:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 012338687E;
	Wed, 30 Sep 2020 08:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8B82C0890;
	Wed, 30 Sep 2020 08:05:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7A78C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 963348688D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAynfzMdH+Mk for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:05:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DBEE986886
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:05:28 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 615432072E;
 Wed, 30 Sep 2020 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601453128;
 bh=7JYxs9JSU+BxuljUNkjSTE7tyNPi9bfc9U9063UfASs=;
 h=Date:From:To:Cc:Subject:From;
 b=1tq323Rfi4bfF5jkhFvFM3www8VuwlCCwtOEL6rGlNhu9BVfipz23YgAs7FSDf8/1
 lNK4uVkB1Ojn4kD4vgb3BFHRWe7dz3XyrifwR5RPXUaLFMTzvqs+8ZK2qe3glwFlYj
 OSMCVo3Sax9FkjMYbNtdzoZMUcuMw2eu3uQT2aMA=
Date: Wed, 30 Sep 2020 09:05:23 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.10
Message-ID: <20200930080523.GA15805@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

Please pull these arm-smmu updates for 5.10. Summary in the tag, but the
big thing here is the long-awaited SVM enablement from Jean-Philippe.
We're not quite done yet, but this pull extends the SMMUv3 driver so that
we're very close to being able to share page-tables directly with the CPU.

Other than that, there are a couple of things to note:

  1. My PGP subkeys expired. I've updated them here:

	https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/3E542FD9.asc

     and I've also mailed an updated copy for inclusion in the pgpkeys
     repository on kernel.org, but it hasn't landed yet:

	https://lore.kernel.org/keys/20200929222707.GA14916@willie-the-truck/T/#u

  2. The SVM enablement has a dependency on some ASID allocation rework
     in the arm64 tree, so I made a shared branch and pulled that in here
     too.

Please shout if you run into any problems.

Will

--->8

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e2eae09939a89e0994f7965ba3c676a5eac8b4b0:

  iommu/qcom: add missing put_device() call in qcom_iommu_of_xlate() (2020-09-29 16:25:52 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.10

- Continued SVM enablement, where page-table is shared with CPU

- Groundwork to support integrated SMMU with Adreno GPU

- Allow disabling of MSI-based polling on the kernel command-line

- Minor driver fixes and cleanups (octal permissions, error messages, ...)

----------------------------------------------------------------
Barry Song (3):
      iommu/arm-smmu-v3: replace symbolic permissions by octal permissions for module parameter
      iommu/arm-smmu-v3: replace module_param_named by module_param for disable_bypass
      iommu/arm-smmu-v3: permit users to disable msi polling

Jean-Philippe Brucker (9):
      iommu/arm-smmu-v3: Fix endianness annotations
      arm64: mm: Pin down ASIDs for sharing mm with devices
      arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
      iommu/io-pgtable-arm: Move some definitions to a header
      iommu/arm-smmu-v3: Move definitions to a header
      iommu/arm-smmu-v3: Share process page tables
      iommu/arm-smmu-v3: Seize private ASID
      iommu/arm-smmu-v3: Check for SVA features
      iommu/arm-smmu-v3: Add SVA device feature

Jordan Crouse (3):
      iommu/arm-smmu: Pass io-pgtable config to implementation specific function
      iommu/arm-smmu: Add support for split pagetables
      iommu/arm-smmu: Prepare for the adreno-smmu implementation

Rob Clark (1):
      iommu/arm-smmu: Constify some helpers

Will Deacon (1):
      Merge branch 'for-next/svm' of git://git.kernel.org/.../arm64/linux into for-joerg/arm-smmu/updates

Yu Kuai (1):
      iommu/qcom: add missing put_device() call in qcom_iommu_of_xlate()

Zenghui Yu (1):
      iommu/arm-smmu-v3: Fix l1 stream table size in the error message

Zhou Wang (1):
      iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer

 MAINTAINERS                                     |   3 +-
 arch/arm64/include/asm/barrier.h                |   1 +
 arch/arm64/include/asm/io.h                     |   1 +
 arch/arm64/include/asm/mmu.h                    |   3 +
 arch/arm64/include/asm/mmu_context.h            |  11 +-
 arch/arm64/kernel/cpufeature.c                  |   1 +
 arch/arm64/mm/context.c                         | 105 ++-
 drivers/iommu/Kconfig                           |  10 +
 drivers/iommu/arm/arm-smmu-v3/Makefile          |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 248 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 843 +++++-------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 723 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c      |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c           | 102 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h           |  84 ++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c         |   8 +-
 drivers/iommu/io-pgtable-arm.c                  |  27 +-
 drivers/iommu/io-pgtable-arm.h                  |  30 +
 18 files changed, 1410 insertions(+), 798 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
 create mode 100644 drivers/iommu/io-pgtable-arm.h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
