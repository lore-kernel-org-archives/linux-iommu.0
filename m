Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A8CC48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CE96140F
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CE96140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8703160719;
	Thu, 10 Jun 2021 02:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4QlNgszNeqJZ; Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A46060881;
	Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 924C7C002A;
	Thu, 10 Jun 2021 02:04:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08289C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BF5E40542
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CXYvZ3xou84Z for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:04:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 355EA4059D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:17 +0000 (UTC)
IronPort-SDR: Y6DAZzwiI/BXnN7YT+vyI7EgfDQP8VFomnWACbCUYQxKQBUIhmgVrF09P4XuzWOSJCV7NMhpPw
 8PozQ1+WmmEg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184361"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:04:03 -0700
IronPort-SDR: T2vebRARFt4nIgK5SIp5yq01yvVo8/MtIHvewD1D2H7jzViU1ck26NDCtnsGXESIcgCpw/uXjD
 8w6Z3XX8fe+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500572"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:04:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 21/23] iommu/vt-d: Remove unnecessary braces
Date: Thu, 10 Jun 2021 10:01:13 +0800
Message-Id: <20210610020115.1637656-22-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
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

From: Parav Pandit <parav@nvidia.com>

No need for braces for single line statement under if() block.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210530075053.264218-1-parav@nvidia.com
---
 drivers/iommu/intel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd8ecfbfdb23..d9a248ee5779 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -683,9 +683,8 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	struct intel_iommu *iommu;
 	int mask = 0x3;
 
-	if (!intel_iommu_superpage) {
+	if (!intel_iommu_superpage)
 		return 0;
-	}
 
 	/* set iommu_superpage to the smallest common denominator */
 	rcu_read_lock();
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
