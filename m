Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5865DC28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 11:59:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F1520644
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 11:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F1520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CCF702517;
	Wed, 29 May 2019 11:59:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3E60A2513
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 11:55:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8E62BEC
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 11:55:51 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id C0B5D209AE;
	Wed, 29 May 2019 13:55:48 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id A6481207DC;
	Wed, 29 May 2019 13:55:48 +0200 (CEST)
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2] iommu/arm-smmu: Avoid constant zero in TLBI writes
Message-ID: <f523effd-ef81-46fe-1f9e-1a0cb42c8b7b@free.fr>
Date: Wed, 29 May 2019 13:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
	Wed May 29 13:55:48 2019 +0200 (CEST)
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	MSM <linux-arm-msm@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	iommu <iommu@lists.linux-foundation.org>, Andy Gross <agross@kernel.org>,
	AngeloGioacchino Del Regno <kholk11@gmail.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Robin Murphy <robin.murphy@arm.com>

Apparently, some Qualcomm arm64 platforms which appear to expose their
SMMU global register space are still, in fact, using a hypervisor to
mediate it by trapping and emulating register accesses. Sadly, some
deployed versions of said trapping code have bugs wherein they go
horribly wrong for stores using r31 (i.e. XZR/WZR) as the source
register.

While this can be mitigated for GCC today by tweaking the constraints
for the implementation of writel_relaxed(), to avoid any potential
arms race with future compilers more aggressively optimising register
allocation, the simple way is to just remove all the problematic
constant zeros. For the write-only TLB operations, the actual value is
irrelevant anyway and any old nearby variable will provide a suitable
GPR to encode. The one point at which we really do need a zero to clear
a context bank happens before any of the TLB maintenance where crashes
have been reported, so is apparently not a problem... :/

Reported-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
Changes from v1:
- Tweak commit message (remove "compilers", s/hangs/crashes)
- Add a comment before writel_relaxed
---
 drivers/iommu/arm-smmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5e54cc0a28b3..3f352268fa8b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -423,7 +423,8 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
 {
 	unsigned int spin_cnt, delay;
 
-	writel_relaxed(0, sync);
+	/* Write "garbage" (rather than 0) to work around a qcom bug */
+	writel_relaxed((unsigned long)sync, sync);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
 			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
@@ -1763,8 +1764,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/* Invalidate the TLB, just in case */
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
+	/* Write "garbage" (rather than 0) to work around a qcom bug */
+	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_TLBIALLH);
+	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 
-- 
2.17.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
