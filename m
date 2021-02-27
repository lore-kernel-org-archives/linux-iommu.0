Return-Path: <SRS0=v/hM=H5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60389C433E0
	for <iommu@archiver.kernel.org>; Sat, 27 Feb 2021 07:40:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3F564E24
	for <iommu@archiver.kernel.org>; Sat, 27 Feb 2021 07:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3F564E24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 532CF4F09E;
	Sat, 27 Feb 2021 07:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FgxAlIKq5zoK; Sat, 27 Feb 2021 07:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0536B4F093;
	Sat, 27 Feb 2021 07:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D464BC000B;
	Sat, 27 Feb 2021 07:40:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45E66C0001
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 07:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A56C83E30
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 07:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Bw75nPcwCkq for <iommu@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 07:40:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F3EC83E2D
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 07:40:36 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dndgc4FJSz16Cm2;
 Sat, 27 Feb 2021 15:38:52 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 15:40:23 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/vt-d: Fix status code for Allocate/Free PASID command
Date: Sat, 27 Feb 2021 15:39:09 +0800
Message-ID: <20210227073909.432-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kevin.tian@intel.com, dwmw2@infradead.org, wanghaibin.wang@huawei.com,
 will@kernel.org
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

As per Intel vt-d spec, Rev 3.0 (section 10.4.45 "Virtual Command Response
Register"), the status code of "No PASID available" error in response to
the Allocate PASID command is 2, not 1. The same for "Invalid PASID" error
in response to the Free PASID command.

We will otherwise see confusing kernel log under the command failure from
guest side. Fix it.

Fixes: 24f27d32ab6b ("iommu/vt-d: Enlightened PASID allocation")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/iommu/intel/pasid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 97dfcffbf495..444c0bec221a 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -30,8 +30,8 @@
 #define VCMD_VRSP_IP			0x1
 #define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
 #define VCMD_VRSP_SC_SUCCESS		0
-#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
-#define VCMD_VRSP_SC_INVALID_PASID	1
+#define VCMD_VRSP_SC_NO_PASID_AVAIL	2
+#define VCMD_VRSP_SC_INVALID_PASID	2
 #define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
 #define VCMD_CMD_OPERAND(e)		((e) << 8)
 /*
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
