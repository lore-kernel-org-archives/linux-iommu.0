Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418EC2D0C1
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD092468A
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPODlAUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD092468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E11022322B;
	Thu, 19 Dec 2019 12:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id onRQWSrOZaF0; Thu, 19 Dec 2019 12:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 171CF203BE;
	Thu, 19 Dec 2019 12:04:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1FCFC18DC;
	Thu, 19 Dec 2019 12:04:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2BE3C077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AC54A886B7
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXuGh0SFlDnb for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 176B5886B6
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 763C1222C2;
 Thu, 19 Dec 2019 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757040;
 bh=RJ3mvIaVqDC3kz+hjtWcHLqxdB4ZpdxAR3Q1j/eZavs=;
 h=From:To:Cc:Subject:Date:From;
 b=UPODlAURU4Z6I+ZrIbrO0SwBJGmkgWWMDyFoiiFjTqfXFRdrfca7ndq+YCw86qEvK
 dUWwMDy+/62dPQbFI2VNuPVd6OYISizRVts5FY3fimLiL+5N+7iJwev74E6KNf52Dh
 2oXUJOsfYsvuV0fRDMezfl0w/bexYbzxGEVXyWQU=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 00/16] iommu: Permit modular builds of ARM SMMU[v3] drivers
Date: Thu, 19 Dec 2019 12:03:36 +0000
Message-Id: <20191219120352.382-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

Hi all,

This is version four of the patches I previously posted here:

  v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
  v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org
  v3: https://lore.kernel.org/lkml/20191121114918.2293-1-will@kernel.org

Changes since v3 include:

  * Based on v5.5-rc1
  * ACPI/IORT support (thanks to Ard)
  * Export pci_{enable,disable}_ats() (thanks to Greg)
  * Added review tags

I tested this on AMD Seattle by loading arm-smmu-mod.ko from the initrd.

Cheers,

Will

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ard Biesheuvel <ardb@kernel.org>

--->8

Ard Biesheuvel (1):
  iommu/arm-smmu: Support SMMU module probing from the IORT

Greg Kroah-Hartman (1):
  PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()

Will Deacon (14):
  drivers/iommu: Export core IOMMU API symbols to permit modular drivers
  iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
  PCI: Export pci_ats_disabled() as a GPL symbol to modules
  drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
  iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
  drivers/iommu: Allow IOMMU bus ops to be unregistered
  Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
  Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
  iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
  iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
  iommu/arm-smmu-v3: Allow building as a module
  iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
  iommu/arm-smmu: Allow building as a module
  iommu/arm-smmu: Update my email address in MODULE_AUTHOR()

 drivers/acpi/arm64/iort.c   |   4 +-
 drivers/iommu/Kconfig       |  16 ++++-
 drivers/iommu/Makefile      |   3 +-
 drivers/iommu/arm-smmu-v3.c |  94 +++++++++++++++++---------
 drivers/iommu/arm-smmu.c    | 128 +++++++++++++++++++++++++-----------
 drivers/iommu/iommu-sysfs.c |   5 ++
 drivers/iommu/iommu.c       |  32 ++++++++-
 drivers/iommu/of_iommu.c    |  19 ++++--
 drivers/pci/ats.c           |   2 +
 drivers/pci/pci.c           |   1 +
 include/linux/iommu.h       |   4 +-
 11 files changed, 223 insertions(+), 85 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
