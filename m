Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A50C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 14:54:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A0B613CA
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 14:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0B613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 725F5405B1;
	Thu, 17 Jun 2021 14:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhPGoiB6Mssh; Thu, 17 Jun 2021 14:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1EAB64040E;
	Thu, 17 Jun 2021 14:54:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA50EC000D;
	Thu, 17 Jun 2021 14:54:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95403C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 14:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 834DB415E1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 14:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCtM1YK7BTBG for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 14:54:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70DA3415B1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 14:54:04 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 2512B90;
 Thu, 17 Jun 2021 16:54:00 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/vt-d: Fix W=1 clang warning in intel/perf.c
Date: Thu, 17 Jun 2021 16:53:39 +0200
Message-Id: <20210617145339.2692-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

From: Joerg Roedel <jroedel@suse.de>

Fix this warning when compiled with clang and W=1:

	drivers/iommu/intel/perf.c:16: warning: Function parameter or member 'latency_lock' not described in 'DEFINE_SPINLOCK'
	drivers/iommu/intel/perf.c:16: warning: expecting prototype for perf.c(). Prototype was for DEFINE_SPINLOCK() instead

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 55ee5e67a59a ("iommu/vt-d: Add common code for dmar latency performance monitors")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 73b7ec705552..0e8e03252d92 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * perf.c - performance monitor
  *
  * Copyright (C) 2021 Intel Corporation
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
