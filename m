Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20AC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:16:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1470761163
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1470761163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C51FF607B1;
	Thu, 20 May 2021 03:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQsrX5DRgMXw; Thu, 20 May 2021 03:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B28FA60716;
	Thu, 20 May 2021 03:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DDBAC0011;
	Thu, 20 May 2021 03:16:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E016C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 518EA40610
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TP3tavvgPILR for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 03:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02221405D4
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:46 +0000 (UTC)
IronPort-SDR: 2L66TX+ELItWM1KB+XtNF1/mOckKohmfsawV3rgjqB9rD5OHI/EIcuCbsp2qYQGJ/Hamcm/df4
 yV74+FZLOv/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659601"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="286659601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 20:16:45 -0700
IronPort-SDR: 9k6sy+XDAQQIIPMCc053Z4fRy85gaC85Ws3ZQ027xLft/tNZj7auaK2Zfi/N5POPshW4WbBzp0
 cJ24R31Gf5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="395527153"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 00/11] Convert Intel IOMMU to use sva-lib helpers
Date: Thu, 20 May 2021 11:15:20 +0800
Message-Id: <20210520031531.712333-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

This patch series converts the Intel IOMMU to use the generic sva
helpers defined in iommu-sva-lib.c and io-pgfault.c. It includes the
SVA pasid management and IO page fault handling.

This series could be divided into below parts:
PATCH[1~3]: Use iommu_sva_alloc/free_pasid() to manage the SVA pasid.
PATCH[4-6]: Use the generic sva io page fault handler iommu_queue_iopf.
PATCH[7-11]: Add ftrace and debugfs support for io page fault handling.

Please help to review.

Best regards,
baolu

Lu Baolu (11):
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

 include/linux/intel-iommu.h        |  33 +-
 drivers/iommu/intel/perf.h         |  73 ++++
 include/trace/events/intel_iommu.h |  37 ++
 drivers/iommu/intel/debugfs.c      | 111 +++++
 drivers/iommu/intel/dmar.c         |  31 ++
 drivers/iommu/intel/iommu.c        |  73 +++-
 drivers/iommu/intel/perf.c         | 166 ++++++++
 drivers/iommu/intel/svm.c          | 627 ++++++++++++++---------------
 drivers/iommu/intel/Kconfig        |   5 +
 drivers/iommu/intel/Makefile       |   1 +
 10 files changed, 819 insertions(+), 338 deletions(-)
 create mode 100644 drivers/iommu/intel/perf.h
 create mode 100644 drivers/iommu/intel/perf.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
