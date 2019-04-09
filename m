Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FBCC282CE
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3142F20883
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3142F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DE328DA6;
	Tue,  9 Apr 2019 17:02:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1D9A1DA1
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:01:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BFD9CF4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:01:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C23F15BE;
	Tue,  9 Apr 2019 10:01:58 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAAA93F68F; 
	Tue,  9 Apr 2019 10:01:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: will.deacon@arm.com
Subject: [PATCH v2 0/7] Add PCI ATS support to Arm SMMUv3
Date: Tue,  9 Apr 2019 17:52:38 +0100
Message-Id: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Message-ID: <20190409165238.vE5evpcpt0QrP8KPi_HdVjtLjd2eWuGJdAp1mYqv6_E@z>

This series enables PCI ATS in SMMUv3. Changes since v1 [1]:

* Simplify the SMMU structures (patches 2-4 are new).

* Don't enable ATS for devices that are attached to a bypass domain,
  because in that case a translation request would cause F_BAD_ATS_TREQ.
  Translation requests in that case cause F_BAD_ATS_TREQ. Enable ATS in
  attach_dev() rather than add_device().

* Enable ATS for stage-1 and stage-2 STEs alike. There is no benefit to
  disabling ATS for stage-2 domains.

[1] https://www.spinics.net/lists/arm-kernel/msg714628.html

Jean-Philippe Brucker (7):
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
  iommu/arm-smmu-v3: Store SteamIDs in master
  iommu/arm-smmu-v3: Add a master->domain pointer
  iommu/arm-smmu-v3: Link domains and devices
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers

 drivers/acpi/arm64/iort.c   |  11 ++
 drivers/iommu/arm-smmu-v3.c | 340 ++++++++++++++++++++++++++++--------
 include/linux/iommu.h       |   4 +
 3 files changed, 286 insertions(+), 69 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
