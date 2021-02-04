Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C146C433E6
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:52:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9727D64E42
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9727D64E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 39D0227261;
	Thu,  4 Feb 2021 01:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id up3cE1kur-52; Thu,  4 Feb 2021 01:52:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7D544272DB;
	Thu,  4 Feb 2021 01:52:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62A29C0174;
	Thu,  4 Feb 2021 01:52:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC2FC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5E90C272F6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HiEsCxeTFrg for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:52:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id CD30C27261
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:52:52 +0000 (UTC)
IronPort-SDR: oWVYYuNUBeio3tAYiOs52jfivXo1PlHr+1q4KDMd5tgsnO5qnyS2GYxBLIWXVQ/Njmwfnz2lFM
 ETy0XQPMTSig==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245227129"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="245227129"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 17:52:49 -0800
IronPort-SDR: MEgtl62wKpM65VuPdZz9KrQo6SOE0KeQ/ExiaRQa2EdxujUgRxTJPaiXQnQKkzSNxj4yz3hfxj
 tZ9+N3DMJKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="406911190"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 17:52:46 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Update for v5.12
Date: Thu,  4 Feb 2021 09:43:54 +0800
Message-Id: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Chuck Lever <chuck.lever@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

The patches queued in this series is for v5.12. It includes:

 - Audit capability consistency among different IOMMUs
 - Add SATC reporting structure support
 - Add iotlb_sync_map callback support
 - Misc cleanup

Please consider them for v5.12.

Best regards,
Lu Baolu

Bjorn Helgaas (1):
  iommu/vt-d: Fix 'physical' typos

Kyung Min Park (2):
  iommu/vt-d: Audit IOMMU Capabilities and add helper functions
  iommu/vt-d: Move capability check code to cap_audit files

Lu Baolu (1):
  iommu/vt-d: Add iotlb_sync_map callback

Yian Chen (3):
  iommu/vt-d: Add new enum value and structure for SATC
  iommu/vt-d: Parse SATC reporting structure
  iommu/vt-d: Apply SATC policy

 drivers/iommu/intel/Makefile        |   2 +-
 drivers/iommu/intel/cap_audit.c     | 205 +++++++++++++++++
 drivers/iommu/intel/cap_audit.h     | 130 +++++++++++
 drivers/iommu/intel/dmar.c          |   8 +
 drivers/iommu/intel/iommu.c         | 337 +++++++++++++++++++---------
 drivers/iommu/intel/irq_remapping.c |   8 +
 include/acpi/actbl1.h               |  11 +-
 include/linux/dmar.h                |   2 +
 include/linux/intel-iommu.h         |  41 ++--
 9 files changed, 615 insertions(+), 129 deletions(-)
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
