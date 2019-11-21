Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E56C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683202089D
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnJgpSRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683202089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 435E586F8D;
	Thu, 21 Nov 2019 11:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNS1eF4PVf_K; Thu, 21 Nov 2019 11:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1983586F80;
	Thu, 21 Nov 2019 11:49:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1877C1DD8;
	Thu, 21 Nov 2019 11:49:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86437C18DA
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6F9BB24074
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HBiZrKajWhL6 for <iommu@lists.linuxfoundation.org>;
 Thu, 21 Nov 2019 11:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 705DD2151E
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 05F0220898;
 Thu, 21 Nov 2019 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574336964;
 bh=PdT7/vjeG9qVa+Z4rGos3rHHIh/e4XCZdgXcB6xN00c=;
 h=From:To:Cc:Subject:Date:From;
 b=CnJgpSRU+BCftuywRCvfcH6mcTonCZhx3FKxuOCpNHwKqe5qVufZMKjeg5NgxQZg2
 Th+EITTwNMA9zDnNLX0+xnu2cx2GduL4GFSd1YwczFvZHWz4a7IyP6TrqAb2MLpWDy
 FT08tPUMC2o74E7WGXXgty7g0TlkZlJhq2v9l+64=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] iommu: Permit modular builds of ARM SMMU[v3] drivers
Date: Thu, 21 Nov 2019 11:49:04 +0000
Message-Id: <20191121114918.2293-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

Hi everyone,

This is version three of the patches I previously posted here:

  v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
  v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org

Changes since v2 include:

  * Tested successfully on real hardware (!)
  * Handle re-registering of IOMMU bus ops
  * Unregister IOMMU on unload
  * Prevent forced unbinding of SMMU drivers via sysfs
  * Update my email address in MODULE_AUTHOR

Note that if you want to rely on the 'of_devlink' support in linux-next
for dependent probe ordering, then you'll need an extra patch [1] to
support PCI devices upstream of an SMMU. I'm routing that one via Greg.

Will

[1] https://lore.kernel.org/lkml/20191120190028.4722-1-will@kernel.org

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

--->8

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

 drivers/iommu/Kconfig       |  16 ++++-
 drivers/iommu/Makefile      |   3 +-
 drivers/iommu/arm-smmu-v3.c |  93 +++++++++++++++++---------
 drivers/iommu/arm-smmu.c    | 127 +++++++++++++++++++++++++-----------
 drivers/iommu/iommu-sysfs.c |   5 ++
 drivers/iommu/iommu.c       |  32 ++++++++-
 drivers/iommu/of_iommu.c    |  17 +++--
 drivers/pci/pci.c           |   1 +
 include/linux/iommu.h       |   2 +
 9 files changed, 215 insertions(+), 81 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
