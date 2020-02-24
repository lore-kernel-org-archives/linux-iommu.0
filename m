Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE00C38BE0
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6440620880
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhJnsCqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6440620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 46B7A8476C;
	Mon, 24 Feb 2020 18:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOaibd8P03H6; Mon, 24 Feb 2020 18:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25D5385E98;
	Mon, 24 Feb 2020 18:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A5DC18DA;
	Mon, 24 Feb 2020 18:25:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8778C18DA
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D46868486F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cocivyizBEfM for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 781F085F7E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z3so11585929wru.3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QhzuO7E/tPXvjm3lOwKKbbuvggFZYOykdp4cgLKXUjc=;
 b=rhJnsCqiLzzpFZarK5PZPVZX1EPddqa5jLad60Z8U7w1CG1LwjKmN75XJM0TeiQyCe
 xF4saHy4d5w8OAfJ718jBb2k58f1/pqxAYoczuciV29+MC44tfAxlD7Y+wBiF+LZB68V
 RYv5/ulpS06ZbNwFl+mhu1gA6Kl9BHPV5lnaFlE2EnPixaDyX/bg2ab7SWUeUnkoqeYp
 bTT6059LoN0iI2tvprDIzXCFDxybk6KHVhyYmYvfSvQDTpK7pqSdx2NLg8wB2lJvU/2H
 o3tLPeyWP+TuBaVKRakaD+TPB0K6BV67CsvAAuLzrEQEI2a45KdRXSTHgMvPMFuEycNP
 zgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QhzuO7E/tPXvjm3lOwKKbbuvggFZYOykdp4cgLKXUjc=;
 b=al2VedH8gOKkPPI8xhqZDoO+0avofKJBjg8JyIll5U+DfKERBVJScdv6wuPBKq7lXe
 XjvUsDsLec9vVTu7QscMEJdS6fmFBNBCHLDNuMkQsOUEOWWzVSuheloFGhLP+CC4LVt7
 /yeLBR0KcBaM/+vs1aCm+lH3Ht+y03tC3tZfyY0YqSGVhSx6fBRXOi4Ziaq+dIlr4b70
 nBYPUrd37/8Kk8cRNjt9J5uYo9uOzC6IHqtSHYGRDUJJPwX2vJYbAjRnO1PBAv2HuWIS
 /bIVs0QWjtmH8AV7sTUEXnR13tYTZi+CZRVz4YfXUxGcHdOhRRlzfcb5MzXh2VcnBEVW
 eRLw==
X-Gm-Message-State: APjAAAWgHJAgZPOKuby2dIPmL0b5V9GdeQPUNwP23KjP3dAFtE56KWyV
 cC2+7gegkl/NtkjwWYb+8iXKPxlxZU4=
X-Google-Smtp-Source: APXvYqzrOQRGThABy8GPo4IKa+3r1YNI9YUhNUvkDvOvqDRDj80+wwDRBgWca3hkV2MNzupjeXtT0g==
X-Received: by 2002:adf:e908:: with SMTP id f8mr4338897wrm.37.1582568698515;
 Mon, 24 Feb 2020 10:24:58 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:58 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 26/26] iommu/arm-smmu-v3: Add support for PRI
Date: Mon, 24 Feb 2020 19:24:01 +0100
Message-Id: <20200224182401.353359-27-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

For PCI devices that support it, enable the PRI capability and handle PRI
Page Requests with the generic fault handler. It is enabled on demand by
iommu_sva_device_init().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 278 +++++++++++++++++++++++++++++-------
 1 file changed, 228 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index da5dda5ba26a..f9732e397b2d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -248,6 +248,7 @@
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_PPAR		(1UL << 18)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
 #define STRTAB_STE_1_EATS		GENMASK_ULL(29, 28)
@@ -373,6 +374,9 @@
 #define CMDQ_PRI_0_SID			GENMASK_ULL(63, 32)
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
 #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
+#define CMDQ_PRI_1_RESP_FAILURE		0UL
+#define CMDQ_PRI_1_RESP_INVALID		1UL
+#define CMDQ_PRI_1_RESP_SUCCESS		2UL
 
 #define CMDQ_RESUME_0_SID		GENMASK_ULL(63, 32)
 #define CMDQ_RESUME_0_RESP_TERM		0UL
@@ -445,12 +449,6 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
-enum pri_resp {
-	PRI_RESP_DENY = 0,
-	PRI_RESP_FAIL = 1,
-	PRI_RESP_SUCC = 2,
-};
-
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -533,7 +531,7 @@ struct arm_smmu_cmdq_ent {
 			u32			sid;
 			u32			ssid;
 			u16			grpid;
-			enum pri_resp		resp;
+			u8			resp;
 		} pri;
 
 		#define CMDQ_OP_RESUME		0x44
@@ -611,6 +609,7 @@ struct arm_smmu_evtq {
 
 struct arm_smmu_priq {
 	struct arm_smmu_queue		q;
+	struct iopf_queue		*iopf;
 };
 
 /* High-level stream table and context descriptor structures */
@@ -743,6 +742,8 @@ struct arm_smmu_master {
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
+	bool				pri_supported;
+	bool				prg_resp_needs_ssid;
 	unsigned int			ssid_bits;
 };
 
@@ -1015,14 +1016,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= FIELD_PREP(CMDQ_PRI_0_SSID, ent->pri.ssid);
 		cmd[0] |= FIELD_PREP(CMDQ_PRI_0_SID, ent->pri.sid);
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_GRPID, ent->pri.grpid);
-		switch (ent->pri.resp) {
-		case PRI_RESP_DENY:
-		case PRI_RESP_FAIL:
-		case PRI_RESP_SUCC:
-			break;
-		default:
-			return -EINVAL;
-		}
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
 		break;
 	case CMDQ_OP_RESUME:
@@ -1602,6 +1595,7 @@ static int arm_smmu_page_response(struct device *dev,
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_fwspec_get(dev)->iommu_priv;
+	bool pasid_valid = resp->flags & IOMMU_PAGE_RESP_PASID_VALID;
 	int sid = master->streams[0].id;
 
 	if (master->stall_enabled) {
@@ -1619,8 +1613,27 @@ static int arm_smmu_page_response(struct device *dev,
 		default:
 			return -EINVAL;
 		}
+	} else if (master->pri_supported) {
+		cmd.opcode		= CMDQ_OP_PRI_RESP;
+		cmd.substream_valid	= pasid_valid &&
+					  master->prg_resp_needs_ssid;
+		cmd.pri.sid		= sid;
+		cmd.pri.ssid		= resp->pasid;
+		cmd.pri.grpid		= resp->grpid;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_FAILURE:
+			cmd.pri.resp = CMDQ_PRI_1_RESP_FAILURE;
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			cmd.pri.resp = CMDQ_PRI_1_RESP_INVALID;
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			cmd.pri.resp = CMDQ_PRI_1_RESP_SUCCESS;
+			break;
+		default:
+			return -EINVAL;
+		}
 	} else {
-		/* TODO: insert PRI response here */
 		return -ENODEV;
 	}
 
@@ -2215,6 +2228,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
 			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
+		if (master->prg_resp_needs_ssid)
+			dst[1] |= STRTAB_STE_1_PPAR;
+
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
@@ -2460,61 +2476,110 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
-	u32 sid, ssid;
-	u16 grpid;
-	bool ssv, last;
-
-	sid = FIELD_GET(PRIQ_0_SID, evt[0]);
-	ssv = FIELD_GET(PRIQ_0_SSID_V, evt[0]);
-	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : 0;
-	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
-	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
-
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
-		 sid, ssid, grpid, last ? "L" : "",
-		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
-		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
-		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-		 evt[1] & PRIQ_1_ADDR_MASK);
-
-	if (last) {
-		struct arm_smmu_cmdq_ent cmd = {
-			.opcode			= CMDQ_OP_PRI_RESP,
-			.substream_valid	= ssv,
-			.pri			= {
-				.sid	= sid,
-				.ssid	= ssid,
-				.grpid	= grpid,
-				.resp	= PRI_RESP_DENY,
-			},
+	u32 sid = FIELD_PREP(PRIQ_0_SID, evt[0]);
+
+	bool pasid_valid, last;
+	struct arm_smmu_master *master;
+	struct iommu_fault_event fault_evt = {
+		.fault.type = IOMMU_FAULT_PAGE_REQ,
+		.fault.prm = {
+			.pasid		= FIELD_GET(PRIQ_0_SSID, evt[0]),
+			.grpid		= FIELD_GET(PRIQ_1_PRG_IDX, evt[1]),
+			.addr		= evt[1] & PRIQ_1_ADDR_MASK,
+		},
+	};
+	struct iommu_fault_page_request *pr = &fault_evt.fault.prm;
+
+	pasid_valid = evt[0] & PRIQ_0_SSID_V;
+	last = evt[0] & PRIQ_0_PRG_LAST;
+
+	/* Discard Stop PASID marker, it isn't used */
+	if (!(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)) && last)
+		return;
+
+	if (last)
+		pr->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (pasid_valid)
+		pr->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	if (evt[0] & PRIQ_0_PERM_READ)
+		pr->perm |= IOMMU_FAULT_PERM_READ;
+	if (evt[0] & PRIQ_0_PERM_WRITE)
+		pr->perm |= IOMMU_FAULT_PERM_WRITE;
+	if (evt[0] & PRIQ_0_PERM_EXEC)
+		pr->perm |= IOMMU_FAULT_PERM_EXEC;
+	if (evt[0] & PRIQ_0_PERM_PRIV)
+		pr->perm |= IOMMU_FAULT_PERM_PRIV;
+
+	master = arm_smmu_find_master(smmu, sid);
+	if (WARN_ON(!master))
+		return;
+
+	if (iommu_report_device_fault(master->dev, &fault_evt)) {
+		/*
+		 * No handler registered, so subsequent faults won't produce
+		 * better results. Try to disable PRI.
+		 */
+		struct iommu_page_response resp = {
+			.flags		= pasid_valid ?
+				          IOMMU_PAGE_RESP_PASID_VALID : 0,
+			.pasid		= pr->pasid,
+			.grpid		= pr->grpid,
+			.code		= IOMMU_PAGE_RESP_FAILURE,
 		};
 
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		dev_warn(master->dev,
+			 "PPR 0x%x:0x%llx 0x%x: nobody cared, disabling PRI\n",
+			 pasid_valid ? pr->pasid : 0, pr->addr, pr->perm);
+		if (last)
+			arm_smmu_page_response(master->dev, NULL, &resp);
 	}
 }
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 {
+	int num_handled = 0;
+	bool overflow = false;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
+	size_t queue_size = 1 << llq->max_n_shift;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	spin_lock(&q->wq.lock);
 	do {
-		while (!queue_remove_raw(q, evt))
+		while (!queue_remove_raw(q, evt)) {
+			spin_unlock(&q->wq.lock);
 			arm_smmu_handle_ppr(smmu, evt);
+			spin_lock(&q->wq.lock);
+			if (++num_handled == queue_size) {
+				q->batch++;
+				wake_up_all_locked(&q->wq);
+				num_handled = 0;
+			}
+		}
 
-		if (queue_sync_prod_in(q) == -EOVERFLOW)
+		if (queue_sync_prod_in(q) == -EOVERFLOW) {
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+			overflow = true;
+		}
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
 		      Q_IDX(llq, llq->cons);
 	queue_sync_cons_out(q);
+
+	wake_up_all_locked(&q->wq);
+	spin_unlock(&q->wq.lock);
+
+	/*
+	 * On overflow, the SMMU might have discarded the last PPR in a group.
+	 * There is no way to know more about it, so we have to discard all
+	 * partial faults already queued.
+	 */
+	if (overflow)
+		iopf_queue_discard_partial(smmu->priq.iopf);
+
 	return IRQ_HANDLED;
 }
 
@@ -2545,6 +2610,30 @@ static int arm_smmu_flush_evtq(void *cookie, struct device *dev, int pasid)
 	return ret;
 }
 
+static int arm_smmu_flush_priq(void *cookie, struct device *dev, int pasid)
+{
+	int ret;
+	u64 batch;
+	bool overflow = false;
+	struct arm_smmu_device *smmu = cookie;
+	struct arm_smmu_queue *q = &smmu->priq.q;
+
+	spin_lock(&q->wq.lock);
+	if (queue_sync_prod_in(q) == -EOVERFLOW) {
+		dev_err(smmu->dev, "priq overflow detected -- requests lost\n");
+		overflow = true;
+	}
+
+	batch = q->batch;
+	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
+					      q->batch >= batch + 2);
+	spin_unlock(&q->wq.lock);
+
+	if (overflow)
+		iopf_queue_discard_partial(smmu->priq.iopf);
+	return ret;
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
@@ -3208,6 +3297,75 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static int arm_smmu_init_pri(struct arm_smmu_master *master)
+{
+	int pos;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -EINVAL;
+
+	if (!(master->smmu->features & ARM_SMMU_FEAT_PRI))
+		return 0;
+
+	pdev = to_pci_dev(master->dev);
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	/* If the device supports PASID and PRI, set STE.PPAR */
+	if (master->ssid_bits)
+		master->prg_resp_needs_ssid = pci_prg_resp_pasid_required(pdev);
+
+	master->pri_supported = true;
+	return 0;
+}
+
+static int arm_smmu_enable_pri(struct arm_smmu_master *master)
+{
+	int ret;
+	struct pci_dev *pdev;
+	/*
+	 * TODO: find a good inflight PPR number. We should divide the PRI queue
+	 * by the number of PRI-capable devices, but it's impossible to know
+	 * about future (probed late or hotplugged) devices. So we're at risk of
+	 * dropping PPRs (and leaking pending requests in the FQ).
+	 */
+	size_t max_inflight_pprs = 16;
+
+	if (!master->pri_supported || !master->ats_enabled)
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_pri(pdev, max_inflight_pprs);
+	if (ret) {
+		dev_err(master->dev, "cannot enable PRI: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void arm_smmu_disable_pri(struct arm_smmu_master *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pri_enabled)
+		return;
+
+	pci_disable_pri(pdev);
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -3603,6 +3761,8 @@ static int arm_smmu_add_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	arm_smmu_init_pri(master);
+
 	ret = iommu_device_link(&smmu->iommu, dev);
 	if (ret)
 		goto err_disable_pasid;
@@ -3639,6 +3799,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 	iopf_queue_remove_device(smmu->evtq.iopf, dev);
+	iopf_queue_remove_device(smmu->priq.iopf, dev);
 	iommu_sva_disable(dev);
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
@@ -3762,7 +3923,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
 {
-	return master->stall_enabled;
+	return master->stall_enabled || master->pri_supported;
 }
 
 static bool arm_smmu_dev_has_feature(struct device *dev,
@@ -3820,6 +3981,15 @@ static int arm_smmu_dev_enable_sva(struct device *dev)
 		ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
 		if (ret)
 			goto err_disable_sva;
+	} else if (master->pri_supported) {
+		ret = iopf_queue_add_device(master->smmu->priq.iopf, dev);
+		if (ret)
+			goto err_disable_sva;
+
+		if (arm_smmu_enable_pri(master)) {
+			iopf_queue_remove_device(master->smmu->priq.iopf, dev);
+			goto err_disable_sva;
+		}
 	}
 	return 0;
 
@@ -3855,7 +4025,9 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
+		arm_smmu_disable_pri(master);
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+		iopf_queue_remove_device(master->smmu->priq.iopf, dev);
 		return iommu_sva_disable(dev);
 	default:
 		return -EINVAL;
@@ -3999,6 +4171,11 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
+	smmu->priq.iopf = iopf_queue_alloc(dev_name(smmu->dev),
+					   arm_smmu_flush_priq, smmu);
+	if (!smmu->priq.iopf)
+		return -ENOMEM;
+
 	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
 				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
 				       "priq");
@@ -4971,6 +5148,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
+	iopf_queue_free(smmu->priq.iopf);
 
 	return 0;
 }
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
