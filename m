Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA12C433E3
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 00:46:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0A1206C3
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 00:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0A1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F0ED28685D;
	Mon,  1 Jun 2020 00:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaD6qnjVcakv; Mon,  1 Jun 2020 00:46:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 47E2D8687B;
	Mon,  1 Jun 2020 00:46:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31F52C0893;
	Mon,  1 Jun 2020 00:46:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A076FC0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 00:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8FB942002A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 00:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0VPKCuRxNlBa for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 00:46:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id BF4E420409
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 00:46:52 +0000 (UTC)
IronPort-SDR: 70sSCVJZjp88RoijCYJRf3vNEjP2A8a/P9TFm5p6tz9Oa5YqJQvyvRyR4l7KoA7ue7+GNwkbY0
 kJFj7ZJ2txzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2020 17:46:52 -0700
IronPort-SDR: nd/M+bdP6yXC1OUWF5lwfikcgzQMmwk+oVT7AaCBNEQOTMVtlKDZpUZXpOR4LaYvdS0feeoUFW
 r4KqG5EZSB5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,458,1583222400"; d="scan'208";a="293005926"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 May 2020 17:46:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu/vt-d: Make Intel SVM code 64-bit only
Date: Mon,  1 Jun 2020 08:42:56 +0800
Message-Id: <20200601004257.15591-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601004257.15591-1-baolu.lu@linux.intel.com>
References: <20200601004257.15591-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Current Intel SVM is designed by setting the pgd_t of the processor page
table to FLPTR field of the PASID entry. The first level translation only
supports 4 and 5 level paging structures, hence it's infeasible for the
IOMMU to share a processor's page table when it's running in 32-bit mode.
Let's disable 32bit support for now and claim support only when all the
missing pieces are ready in the future.

Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index aca76383f201..e6e0259c0a1c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -211,7 +211,7 @@ config INTEL_IOMMU_DEBUGFS
 
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
-	depends on INTEL_IOMMU && X86
+	depends on INTEL_IOMMU && X86_64
 	select PCI_PASID
 	select PCI_PRI
 	select MMU_NOTIFIER
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
