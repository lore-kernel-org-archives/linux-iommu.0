Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48BBC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A9D2073F
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cbr20Gb/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e50MCywd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A9D2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4C04BA5E;
	Mon, 15 Apr 2019 17:38:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBC7E7F6
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 17:38:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 668DB1C0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 17:38:15 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 308BC61194; Mon, 15 Apr 2019 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555349895;
	bh=EPRjzbK2YO1ZdVR6Hhmsw5ZEruqZqn5nBe33XtS1EuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbr20Gb/1bG2Qqy/7SBNRlBnq3SV0MLlE8fzDRbYO7kS73LfKQzy1MyJiVv07nAw7
	/z57hrqAHzT0D2/J7UYNoXse4l0nTslUz4GxCXOHo/z9mGgRWYb0cs9mYFAOlb6D7g
	/jWHxvTiR41ISlABbG3CLqrWahVxuTiBy6To50X8=
Received: from blr-ubuntu-41.ap.qualcomm.com
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E4EE61194;
	Mon, 15 Apr 2019 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555349894;
	bh=EPRjzbK2YO1ZdVR6Hhmsw5ZEruqZqn5nBe33XtS1EuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e50MCywdbbCMyCCAB7kwCnMxUT5jNc+l7va1/lEr1q9XXtaKs6UlJzFYmwX0y8LFs
	cnTTxuLEwoazqB05o5BbdwKAdxI3iPCYTe7e8uml5y87j3PTMcZm6O3a1n+eVjgBCj
	TBY+CSgLnWHZ7/fK9tIh84rxoFIUHo5bKpIKkF4A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E4EE61194
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context fault
Date: Mon, 15 Apr 2019 23:07:58 +0530
Message-Id: <20190415173758.22112-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
References: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415173758.Bp_Y-WrJrLQ0LSPkHWsUy16hKP-5ifUsUXihLcllEp4@z>

Bits[15:0] in CBFRSYNRA register contain information about
StreamID of the incoming transaction that generated the
fault. Dump CBFRSYNRA register to get this info.
This is specially useful in a distributed SMMU architecture
where multiple masters are connected to the SMMU.
SID information helps to quickly identify the faulting
master device.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

V1 of the patch available @
https://lore.kernel.org/patchwork/patch/1061615/

Changes from v1:
 - Dump the raw register value of CBFRSYNRA register in the
   context fault log rather than extracting the SID inforamtion
   and dumping that.

 drivers/iommu/arm-smmu-regs.h | 2 ++
 drivers/iommu/arm-smmu.c      | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..e9132a926761 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
 #define CBAR_IRPTNDX_SHIFT		24
 #define CBAR_IRPTNDX_MASK		0xff
 
+#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
+
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
 #define CBA2R_RW64_32BIT		(0 << 0)
 #define CBA2R_RW64_64BIT		(1 << 0)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..a4773e8c6b0e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
 	void __iomem *cb_base;
+	u32 cbfrsynra;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
@@ -585,10 +587,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	cbfrsynra = readl_relaxed(gr1_base +
+				  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
 
 	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
+	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra = 0x%x, cb=%d\n",
+			    fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
 
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
 	return IRQ_HANDLED;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
