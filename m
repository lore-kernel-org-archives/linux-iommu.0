Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B245C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 11:52:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B45218B0
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B45218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DEF5AF40;
	Wed, 24 Apr 2019 11:52:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C7D3EF3E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 11:52:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 52D9EF4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 11:52:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C27A78;
	Wed, 24 Apr 2019 04:52:56 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E8D3F238;
	Wed, 24 Apr 2019 04:52:54 -0700 (PDT)
Date: Wed, 24 Apr 2019 12:52:52 +0100
From: Will Deacon <will.deacon@arm.com>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.2
Message-ID: <20190424115252.GB14829@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: marc.w.gonzalez@free.fr, jean-philippe.brucker@arm.com,
	dianders@chromium.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424115252.CyTDEBUUr1Vhyz2dAdBPMSNplea_3qmwpWn2OpJDbIk@z>

Hi Joerg,

Please can you pull these ARM SMMU updates for 5.2? The highlight is ATS
support in the SMMUv3 driver from Jean-Philippe. I have collected the
appropriate Acks from the PCI and IORT sides.

There is a trivial conflict with your api-features branch due to the diff
context in linux/iommu.h.

Cheers,

Will

--->8

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to bc580b56cb7888d1f09fff8a50270228fb834ae8:

  iommu/arm-smmu: Log CBFRSYNRA register on context fault (2019-04-23 12:23:16 +0100)

----------------------------------------------------------------
Douglas Anderson (1):
      iommu/arm-smmu: Break insecure users by disabling bypass by default

Jean-Philippe Brucker (9):
      PCI: Move ATS declarations outside of CONFIG_PCI
      PCI: Add a stub for pci_ats_disabled()
      ACPI/IORT: Check ATS capability in root complex nodes
      iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
      iommu/arm-smmu-v3: Store SteamIDs in master
      iommu/arm-smmu-v3: Add a master->domain pointer
      iommu/arm-smmu-v3: Link domains and devices
      iommu/arm-smmu-v3: Add support for PCI ATS
      iommu/arm-smmu-v3: Disable tagged pointers

Vivek Gautam (1):
      iommu/arm-smmu: Log CBFRSYNRA register on context fault

Will Deacon (1):
      iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel

 drivers/acpi/arm64/iort.c     |  11 ++
 drivers/iommu/Kconfig         |  25 +++
 drivers/iommu/arm-smmu-regs.h |   2 +
 drivers/iommu/arm-smmu-v3.c   | 355 +++++++++++++++++++++++++++++++++---------
 drivers/iommu/arm-smmu.c      |  11 +-
 include/linux/iommu.h         |   4 +
 include/linux/pci.h           |  31 ++--
 7 files changed, 344 insertions(+), 95 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
