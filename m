Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA8C433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 00:02:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C8460233
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 00:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C8460233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 144344018D;
	Thu, 15 Apr 2021 00:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s48mhO2OLdDa; Thu, 15 Apr 2021 00:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 103A640118;
	Thu, 15 Apr 2021 00:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D09F9C000C;
	Thu, 15 Apr 2021 00:02:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A60C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 00:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5234C60814
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 00:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6B0xuY97t3OM for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 00:02:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B374160813
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 00:02:11 +0000 (UTC)
IronPort-SDR: IjK8ptScoQmqeuQ6p789wx4gZrI2wGMOt1BkHhSiPLLv7e0uKeuhMZf14/EjscLebyFDkeIk/i
 /VYtlM5sSLbw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174259229"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="174259229"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 17:02:10 -0700
IronPort-SDR: gzweu2Lq5EAvp9QHVB6sL26GIzb2BZtG7XWDtK1xA0XGSL/+zEmRcydXarQGaH9wUmifsSw0d6
 UA7HwCMmlKmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="461415805"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 14 Apr 2021 17:02:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 0/2] Simplify and restrict IOMMU SVA APIs
Date: Wed, 14 Apr 2021 08:27:55 -0700
Message-Id: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org
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

A couple of small changes to simplify and restrict SVA APIs. The motivation
is to make PASID allocation palatable for cgroup consumptions. Misc cgroup
is merged for v5.13, it can be extended for IOASID as another scalar
resource.

I have not tested on ARM platforms due to availability. Would appreciate
if someone could help with the testing on ARM.

Thanks,

Jacob

ChangeLog:
V2
	- retained mm argument in iommu_sva_alloc_pasid()
	- keep generic supervisor flag separated from vt-d's SRE
	- move flag declaration out of CONFIG_IOMMU_API


Jacob Pan (2):
  iommu/sva: Tighten SVA bind API with explicit flags
  iommu/sva: Remove mm parameter from SVA bind API

 drivers/dma/idxd/cdev.c                       |  2 +-
 drivers/dma/idxd/init.c                       |  7 +++---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++--
 drivers/iommu/intel/svm.c                     | 14 ++++-------
 drivers/iommu/iommu-sva-lib.c                 | 11 +++++----
 drivers/iommu/iommu.c                         | 23 +++++++++++++------
 drivers/misc/uacce/uacce.c                    |  2 +-
 include/linux/intel-iommu.h                   |  2 +-
 include/linux/intel-svm.h                     | 17 ++------------
 include/linux/iommu.h                         | 20 ++++++++++++----
 11 files changed, 57 insertions(+), 50 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
