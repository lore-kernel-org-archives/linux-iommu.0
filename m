Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C32C4332D
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 20:55:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E9E216FD
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 20:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8ZE5K3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E9E216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC18886B9E;
	Wed, 18 Mar 2020 20:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9o1qsNq2Q9YC; Wed, 18 Mar 2020 20:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D973A86ACB;
	Wed, 18 Mar 2020 20:55:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3906C1D7E;
	Wed, 18 Mar 2020 20:55:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5B6C013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EE62785C54
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRGE6q7LAOxV for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 20:55:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6C00B85BE4
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:55:01 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8BBD421473;
 Wed, 18 Mar 2020 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584564901;
 bh=l6DvBGw4cKYvjyvNNBYmUeY/T80hQ8zM0ealCYAMkT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M8ZE5K3STC6CVBPyYnFuVkm6SEXhfdOd336O3NH8d7GgJ4Djdf7Z+9jP57STzL6hh
 PMIKin2HntF+6Gtar8VdfgeBKxhsRmy6kMbhClE2LQymO3fpzyKgws6uo5CSmHGf5U
 r3QtMUB9SuXd64pjZ19HBl/poCbESXiOt2f0yfRQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 68/73] iommu/vt-d: Fix debugfs register reads
Date: Wed, 18 Mar 2020 16:53:32 -0400
Message-Id: <20200318205337.16279-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Megha Dey <megha.dey@linux.intel.com>
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

From: Megha Dey <megha.dey@linux.intel.com>

[ Upstream commit ba3b01d7a6f4ab9f8a0557044c9a7678f64ae070 ]

Commit 6825d3ea6cde ("iommu/vt-d: Add debugfs support to show register
contents") dumps the register contents for all IOMMU devices.

Currently, a 64 bit read(dmar_readq) is done for all the IOMMU registers,
even though some of the registers are 32 bits, which is incorrect.

Use the correct read function variant (dmar_readl/dmar_readq) while
reading the contents of 32/64 bit registers respectively.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
Link: https://lore.kernel.org/r/1583784587-26126-2-git-send-email-megha.dey@linux.intel.com
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu-debugfs.c | 40 ++++++++++++++++++-----------
 include/linux/intel-iommu.h         |  2 ++
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 471f05d452e01..80378c10dd77a 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -32,38 +32,42 @@ struct iommu_regset {
 
 #define IOMMU_REGSET_ENTRY(_reg_)					\
 	{ DMAR_##_reg_##_REG, __stringify(_reg_) }
-static const struct iommu_regset iommu_regs[] = {
+
+static const struct iommu_regset iommu_regs_32[] = {
 	IOMMU_REGSET_ENTRY(VER),
-	IOMMU_REGSET_ENTRY(CAP),
-	IOMMU_REGSET_ENTRY(ECAP),
 	IOMMU_REGSET_ENTRY(GCMD),
 	IOMMU_REGSET_ENTRY(GSTS),
-	IOMMU_REGSET_ENTRY(RTADDR),
-	IOMMU_REGSET_ENTRY(CCMD),
 	IOMMU_REGSET_ENTRY(FSTS),
 	IOMMU_REGSET_ENTRY(FECTL),
 	IOMMU_REGSET_ENTRY(FEDATA),
 	IOMMU_REGSET_ENTRY(FEADDR),
 	IOMMU_REGSET_ENTRY(FEUADDR),
-	IOMMU_REGSET_ENTRY(AFLOG),
 	IOMMU_REGSET_ENTRY(PMEN),
 	IOMMU_REGSET_ENTRY(PLMBASE),
 	IOMMU_REGSET_ENTRY(PLMLIMIT),
+	IOMMU_REGSET_ENTRY(ICS),
+	IOMMU_REGSET_ENTRY(PRS),
+	IOMMU_REGSET_ENTRY(PECTL),
+	IOMMU_REGSET_ENTRY(PEDATA),
+	IOMMU_REGSET_ENTRY(PEADDR),
+	IOMMU_REGSET_ENTRY(PEUADDR),
+};
+
+static const struct iommu_regset iommu_regs_64[] = {
+	IOMMU_REGSET_ENTRY(CAP),
+	IOMMU_REGSET_ENTRY(ECAP),
+	IOMMU_REGSET_ENTRY(RTADDR),
+	IOMMU_REGSET_ENTRY(CCMD),
+	IOMMU_REGSET_ENTRY(AFLOG),
 	IOMMU_REGSET_ENTRY(PHMBASE),
 	IOMMU_REGSET_ENTRY(PHMLIMIT),
 	IOMMU_REGSET_ENTRY(IQH),
 	IOMMU_REGSET_ENTRY(IQT),
 	IOMMU_REGSET_ENTRY(IQA),
-	IOMMU_REGSET_ENTRY(ICS),
 	IOMMU_REGSET_ENTRY(IRTA),
 	IOMMU_REGSET_ENTRY(PQH),
 	IOMMU_REGSET_ENTRY(PQT),
 	IOMMU_REGSET_ENTRY(PQA),
-	IOMMU_REGSET_ENTRY(PRS),
-	IOMMU_REGSET_ENTRY(PECTL),
-	IOMMU_REGSET_ENTRY(PEDATA),
-	IOMMU_REGSET_ENTRY(PEADDR),
-	IOMMU_REGSET_ENTRY(PEUADDR),
 	IOMMU_REGSET_ENTRY(MTRRCAP),
 	IOMMU_REGSET_ENTRY(MTRRDEF),
 	IOMMU_REGSET_ENTRY(MTRR_FIX64K_00000),
@@ -126,10 +130,16 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 		 * by adding the offset to the pointer (virtual address).
 		 */
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
-		for (i = 0 ; i < ARRAY_SIZE(iommu_regs); i++) {
-			value = dmar_readq(iommu->reg + iommu_regs[i].offset);
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs_32); i++) {
+			value = dmar_readl(iommu->reg + iommu_regs_32[i].offset);
+			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
+				   iommu_regs_32[i].regs, iommu_regs_32[i].offset,
+				   value);
+		}
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs_64); i++) {
+			value = dmar_readq(iommu->reg + iommu_regs_64[i].offset);
 			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
-				   iommu_regs[i].regs, iommu_regs[i].offset,
+				   iommu_regs_64[i].regs, iommu_regs_64[i].offset,
 				   value);
 		}
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6d8bf4bdf240d..1e5dad8b8e59b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -120,6 +120,8 @@
 
 #define dmar_readq(a) readq(a)
 #define dmar_writeq(a,v) writeq(v,a)
+#define dmar_readl(a) readl(a)
+#define dmar_writel(a, v) writel(v, a)
 
 #define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
 #define DMAR_VER_MINOR(v)		((v) & 0x0f)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
