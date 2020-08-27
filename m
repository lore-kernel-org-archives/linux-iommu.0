Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A42C433DF
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 04:32:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DEE20786
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 04:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DEE20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E84E87A11;
	Thu, 27 Aug 2020 04:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXce9ZizMOQ1; Thu, 27 Aug 2020 04:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C23D4878B8;
	Thu, 27 Aug 2020 04:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF434C016F;
	Thu, 27 Aug 2020 04:32:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF22AC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 04:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 927A220417
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 04:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PwIiQYEeNzJA for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 04:32:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 7E25E20412
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 04:32:20 +0000 (UTC)
IronPort-SDR: zyQQ/QF6c/fDa28Q967z7/d2ZXm0K3BkyHZtpxq7sgK+xCSzAgkBRgQYcfiekc4GJjoAbIi0NF
 8sNXlHt0lyow==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153984615"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; d="scan'208";a="153984615"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 21:32:20 -0700
IronPort-SDR: KE9+dvvSE3l0GaVQ1uneodXF+TsriwcFAsQliiYinM7BFemm5QZFqtklAwNtuvnUwq+kIrwVgt
 ZjhTSXfxtOpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; d="scan'208";a="403287355"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 21:32:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Serialize IOMMU GCMD register modifications
Date: Thu, 27 Aug 2020 12:25:13 +0800
Message-Id: <20200827042513.30292-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 iommu@lists.linux-foundation.org
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

The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG General
Description) that:

If multiple control fields in this register need to be modified, software
must serialize the modifications through multiple writes to this register.

However, in irq_remapping.c, modifications of IRE and CFI are done in one
write. We need to do two separate writes with STS checking after each.

Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out security warning mess")
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Change log:
v1->v2:
  - v1 posted here
    https://lore.kernel.org/linux-iommu/20200826025825.2322-1-baolu.lu@linux.intel.com/;
  - Add status check before disabling CFI. (Kevin)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 9564d23d094f..7552bb7e92c8 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -507,12 +507,19 @@ static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
 
 	/* Enable interrupt-remapping */
 	iommu->gcmd |= DMA_GCMD_IRE;
-	iommu->gcmd &= ~DMA_GCMD_CFI;  /* Block compatibility-format MSIs */
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
-
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, (sts & DMA_GSTS_IRES), sts);
 
+	/* Block compatibility-format MSIs */
+	sts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (sts & DMA_GSTS_CFIS) {
+		iommu->gcmd &= ~DMA_GCMD_CFI;
+		writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
+		IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
+			      readl, !(sts & DMA_GSTS_CFIS), sts);
+	}
+
 	/*
 	 * With CFI clear in the Global Command register, we should be
 	 * protected from dangerous (i.e. compatibility) interrupts
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
