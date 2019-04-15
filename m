Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29078C10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 08:07:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61E7206BA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 08:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c99QFiXJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AImYsxeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61E7206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 83DB1AF7;
	Mon, 15 Apr 2019 08:07:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B0711AE7
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 08:07:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4AAA62C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 08:07:51 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1734761633; Mon, 15 Apr 2019 08:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555315671;
	bh=Sev9nk/GjSs3ut+txPBymvd0Ls4JpMVjwugfhgI0Xm4=;
	h=From:To:Cc:Subject:Date:From;
	b=c99QFiXJLz69YjbqTm4O7w3GP5b0cwjIg98qM9PpMYtFB8f3L2XCwnv2PA0lyPny9
	1X/3eE4UXuXB7GkMV5NlkLSNgDnFRQzRxOtD+DFjR1/jrgJ3i73feSkdVk34MD2haB
	C/SBe4dO63nTW7FKHDAP4IACnP8deshA5I9bYGWI=
Received: from blr-ubuntu-41.ap.qualcomm.com
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 0587260CF0;
	Mon, 15 Apr 2019 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555315670;
	bh=Sev9nk/GjSs3ut+txPBymvd0Ls4JpMVjwugfhgI0Xm4=;
	h=From:To:Cc:Subject:Date:From;
	b=AImYsxeUCc6jF2VImAPIMx9ej9MQYLDwfPU0TVCXLgdG+4HBD7eGoUBpje7N22CPF
	DexSInFSBscTBj/EYWfeST01g/onxrMQWSwk63NAizO5u13zC1f4yE56+OAQWN66Ie
	4H0+DGd+Yz9VFg+Szta7z2qZaCZjhhGg4JzTJi8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0587260CF0
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] iommu/arm-smmu: Add SID information to context fault log
Date: Mon, 15 Apr 2019 13:37:34 +0530
Message-Id: <20190415080734.6843-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
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
Message-ID: <20190415080734.3yS11hBjy-Yvu_FpV94AOmJF8KD_DW2AcPpgQWC_lpI@z>

Extract the SID and add the information to context fault log.
This is specially useful in a distributed smmu architecture
where multiple masters are connected to smmu. SID information
helps to quickly identify the faulting master device.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu-regs.h |  4 ++++
 drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..e5be0344b610 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -147,6 +147,10 @@ enum arm_smmu_s2cr_privcfg {
 #define CBAR_IRPTNDX_SHIFT		24
 #define CBAR_IRPTNDX_MASK		0xff
 
+#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
+#define CBFRSYNRA_V2_SID_MASK		0xffff
+#define CBFRSYNRA_V1_SID_MASK		0x7fff
+
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
 #define CBA2R_RW64_32BIT		(0 << 0)
 #define CBA2R_RW64_64BIT		(1 << 0)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..aa3426dc68d0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -575,7 +575,10 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
 	void __iomem *cb_base;
+	u32 cbfrsynra;
+	u16 sid;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
@@ -586,9 +589,16 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
 
+	cbfrsynra = readl_relaxed(gr1_base +
+				  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
+	if (smmu->version > ARM_SMMU_V1)
+		sid = cbfrsynra & CBFRSYNRA_V2_SID_MASK;
+	else
+		sid = cbfrsynra & CBFRSYNRA_V1_SID_MASK;
+
 	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
+	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d sid = %u\n",
+			    fsr, iova, fsynr, cfg->cbndx, sid);
 
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
 	return IRQ_HANDLED;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
