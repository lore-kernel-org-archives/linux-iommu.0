Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C0C2D0DB
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:34:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FF5214D8
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="R1DBoWxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FF5214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF54981EE4;
	Tue, 28 Jan 2020 22:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQcvRxXMm9JQ; Tue, 28 Jan 2020 22:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 408A4824E3;
	Tue, 28 Jan 2020 22:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31ABFC0175;
	Tue, 28 Jan 2020 22:34:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F981C0171
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3FFC586FBB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdiezzQ1Cfdu for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 22:34:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8558788012
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:34:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1580250855; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=KPGUQcF0y0b6zGbjLTPz7+ZC/IF0jWlRKWGLcU9qULU=;
 b=R1DBoWxbtYoy49iSqlxCmx7ghbw0IfhWzD33/yGVEWtA1cBadWB54mLsjBCmZHWw3bG7Ldss
 MIpO8WRHg+sr0Om+R1DK4ejg5UenTvoDLofXEHkydEaMVvcYWEiCOhNn6Pbs98VE22pbfjCv
 AOiDlTPyyMBLkmQ4V36pU70VUjw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b6e0.7fec54b04308-smtp-out-n01;
 Tue, 28 Jan 2020 22:34:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 687B9C4479F; Tue, 28 Jan 2020 22:34:07 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D9F38C43383;
 Tue, 28 Jan 2020 22:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9F38C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	Rob Clark <robdclark@gmail.com>
Subject: [RFC PATCH v1] iommu/arm-smmu: Allow domains to choose a context bank
Date: Tue, 28 Jan 2020 15:33:43 -0700
Message-Id: <1580250823-30739-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Domains which are being set up for split pagetables usually want to be
on a specific context bank for hardware reasons. Force the context
bank for domains with the split-pagetable quirk to context bank 0.
If context bank 0 is taken, move that context bank to another unused
bank and rewrite the stream matching registers accordingly.

This is be used by [1] and [2] to leave context bank 0 open so that
the Adreno GPU can program it.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041438.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041444.html

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 85a6773..799a254 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -254,6 +254,43 @@ static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 	return idx;
 }
 
+static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx);
+
+static int __arm_smmu_alloc_cb(struct arm_smmu_device *smmu, int start,
+		int target)
+{
+	int new, i;
+
+       /* Allocate a new context bank id */
+	new = __arm_smmu_alloc_bitmap(smmu->context_map, start,
+		smmu->num_context_banks);
+
+	if (new < 0)
+		return new;
+
+	/* If no target is set or we actually got the bank index we wanted */
+	if (target == -1 || new == target)
+		return new;
+
+	/* Copy the context configuration to the new index */
+	memcpy(&smmu->cbs[new], &smmu->cbs[target], sizeof(*smmu->cbs));
+	smmu->cbs[new].cfg->cbndx = new;
+
+	/* FIXME: Do we need locking here? */
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		if (smmu->s2crs[i].cbndx == target) {
+			smmu->s2crs[i].cbndx = new;
+			arm_smmu_write_s2cr(smmu, i);
+		}
+	}
+
+	/*
+	 * FIXME: Does getting here imply that 'target' is already set in the
+	 * context_map?
+	 */
+	return target;
+}
+
 static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 {
 	clear_bit(idx, map);
@@ -770,6 +807,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	unsigned long quirks = 0;
+	int forcecb = -1;
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -844,8 +882,25 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			 * SEP_UPSTREAM so we don't need to reduce the size of
 			 * the ias to account for the sign extension bit
 			 */
-			if (smmu_domain->split_pagetables)
-				quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
+			if (smmu_domain->split_pagetables) {
+				/*
+				 * If split pagetables are enabled, assume that
+				 * the user's intent is to use per-instance
+				 * pagetables which, at least on a QCOM target,
+				 * means that this domain should be on context
+				 * bank 0.
+				 */
+
+				/*
+				 * If we can't force to context bank 0 then
+				 * don't bother enabling split pagetables which
+				 * then would not allow aux domains
+				 */
+				if (start == 0) {
+					forcecb = 0;
+					quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
+				}
+			}
 		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
 			fmt = ARM_32_LPAE_S1;
 			ias = min(ias, 32UL);
@@ -883,8 +938,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
+
+	ret = __arm_smmu_alloc_cb(smmu, start, forcecb);
 	if (ret < 0)
 		goto out_unlock;
 
-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
