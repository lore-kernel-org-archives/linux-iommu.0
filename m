Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF9C48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9C361413
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9C361413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92DD2401BC;
	Thu, 10 Jun 2021 02:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-lPLgy9f7xE; Thu, 10 Jun 2021 02:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E046401D3;
	Thu, 10 Jun 2021 02:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52ADEC000E;
	Thu, 10 Jun 2021 02:02:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6454AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D2D36076C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KidHv128e5aR for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:02:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E8C360747
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:02:53 +0000 (UTC)
IronPort-SDR: d3RIPkXNP2bs8lzZRbSRhzy9qdEli/AQjYy2qGMIrNo9hxxmAcR2Wix3Y5AaE7vYFlAW1vlytQ
 rud1uRDUDNLg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="203359262"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="203359262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:02:52 -0700
IronPort-SDR: eD1jrpV51iDwifpdlHdFZVt3Q2rdx+u2/+tHFRGMbtrrBkSzaasMbxJBhZypNrcMENd8Mt69ty
 zAEskqwIRG/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500206"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:02:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 00/23] [PULL REQUEST] Intel IOMMU Updates for Linux v5.14
Date: Thu, 10 Jun 2021 10:00:52 +0800
Message-Id: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
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

Hi Joerg,

The patches queued in this series are for v5.14.
It includes:

 - Convert Intel IOMMU to use sva_lib helpers in iommu core
 - ftrace and debugfs supports for page fault handling
 - Support asynchronous nested capabilities
 - Various misc cleanups

Please pull.

Best regards,
Baolu

Aditya Srivastava (1):
  iommu/vt-d: Fix kernel-doc syntax in file header

Colin Ian King (1):
  iommu/vt-d: Remove redundant assignment to variable agaw

Gustavo A. R. Silva (1):
  iommu/vt-d: Fix out-bounds-warning in intel/svm.c

Lu Baolu (14):
  iommu/vt-d: Tweak the description of a DMA fault
  iommu/vt-d: Select PCI_ATS explicitly
  iommu/vt-d: Support asynchronous IOMMU nested capabilities
  iommu/vt-d: Add pasid private data helpers
  iommu/vt-d: Use iommu_sva_alloc(free)_pasid() helpers
  iommu/vt-d: Use common helper to lookup svm devices
  iommu/vt-d: Refactor prq_event_thread()
  iommu/vt-d: Allocate/register iopf queue for sva devices
  iommu/vt-d: Report prq to io-pgfault framework
  iommu/vt-d: Add prq_report trace event
  iommu/vt-d: Add common code for dmar latency performance monitors
  iommu/vt-d: Expose latency monitor data through debugfs
  iommu/vt-d: Add cache invalidation latency sampling
  iommu/vt-d: Add PRQ handling latency sampling

Parav Pandit (5):
  iommu/vt-d: Use bitfields for DMAR capabilities
  iommu/vt-d: Removed unused iommu_count in dmar domain
  iommu/vt-d: Remove unnecessary braces
  iommu/vt-d: Define counter explicitly as unsigned int
  iommu/vt-d: No need to typecast

YueHaibing (1):
  iommu/vt-d: Use DEVICE_ATTR_RO macro

 include/linux/intel-iommu.h        |  44 +-
 drivers/iommu/intel/perf.h         |  73 ++++
 include/trace/events/intel_iommu.h |  37 ++
 drivers/iommu/intel/debugfs.c      | 111 +++++
 drivers/iommu/intel/dmar.c         |  54 ++-
 drivers/iommu/intel/iommu.c        | 163 +++++---
 drivers/iommu/intel/pasid.c        |   2 +-
 drivers/iommu/intel/perf.c         | 166 ++++++++
 drivers/iommu/intel/svm.c          | 643 ++++++++++++++---------------
 drivers/iommu/intel/Kconfig        |   6 +
 drivers/iommu/intel/Makefile       |   1 +
 11 files changed, 894 insertions(+), 406 deletions(-)
 create mode 100644 drivers/iommu/intel/perf.h
 create mode 100644 drivers/iommu/intel/perf.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
