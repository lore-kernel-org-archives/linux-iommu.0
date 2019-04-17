Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54504C282DC
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4D12064B
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4D12064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EC17BE52;
	Wed, 17 Apr 2019 18:28:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 35F3EE4E
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 18:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DB2BF14D
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 18:28:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7675E15AB;
	Wed, 17 Apr 2019 11:28:09 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C687B3F59C; 
	Wed, 17 Apr 2019 11:28:06 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: will.deacon@arm.com,
	lorenzo.pieralisi@arm.com,
	bhelgaas@google.com
Subject: [PATCH v3 0/9] Add PCI ATS support to Arm SMMUv3
Date: Wed, 17 Apr 2019 19:24:39 +0100
Message-Id: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Message-ID: <20190417182439.zR_Xr9UrVF2mlkdhFzzcmoJ_ENdhV0wnNZP4c3PCSA8@z>

This series enables PCI ATS in SMMUv3. Changes since v2 [1]:

* Fix build failure when building arm-smmu-v3 without CONFIG_PCI
  Patches 1 and 2 are new.

* Only enable ATS if the root complex supports it. For the moment, only
  IORT provides this information. I have patches for devicetree but
  they are less mature and I'd rather make it a separate series.

* Tried to address most comments. I'll see if I can improve the firmware
  code when adding devicetree support (see [2]).

Note that there is a small conflict with the SVA API. This series
applies on top of Joerg's api-features branch for v5.2.

[1] https://www.spinics.net/lists/arm-kernel/msg719722.html
[2] git://linux-arm.org/linux-jpb.git ats/current

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

 drivers/acpi/arm64/iort.c   |  11 ++
 drivers/iommu/arm-smmu-v3.c | 345 ++++++++++++++++++++++++++++--------
 include/linux/iommu.h       |   4 +
 include/linux/pci.h         |  31 ++--
 4 files changed, 306 insertions(+), 85 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
