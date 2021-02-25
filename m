Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A4CC433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 17:52:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A34B64F3B
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 17:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A34B64F3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72051432C0;
	Thu, 25 Feb 2021 17:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-mE_z7nW6ub; Thu, 25 Feb 2021 17:51:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 46600432CD;
	Thu, 25 Feb 2021 17:51:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C44D1C0010;
	Thu, 25 Feb 2021 17:51:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3D97C000B
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 17:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id C69D0432C8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 17:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id OFL8BkCccSh1 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 17:51:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from z11.mailgun.us (z11.mailgun.us [104.130.96.11])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 7B348432C2
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 17:51:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1614275516; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DGq6IDzFUvvJIL7ZMOUaKbC0+G2XRnz/QgQTPcnn1yo=;
 b=gneZWF7YHO0+eayyokbUyUAt3PZJXfCzaCvL9K95AJAeDL9n0eSHmQ7He5It0ToziJOQJKx8
 TYs5JuxgZlfF+NcRQegD9G8j7PuNx4YNoCzB6lvU9H9hAzfwPz43hvCjll6SJ6dI0nr0TrIx
 sP7l6cBV4mL9UX/r6L2MryHJFpI=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6037e3baea793fa30389f226 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 17:51:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id EFC7CC43461; Thu, 25 Feb 2021 17:51:53 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C253C433ED;
 Thu, 25 Feb 2021 17:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C253C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/3] drm/msm: Improve the a6xx page fault handler
Date: Thu, 25 Feb 2021 10:51:35 -0700
Message-Id: <20210225175135.91922-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225175135.91922-1-jcrouse@codeaurora.org>
References: <20210225175135.91922-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Sean Paul <sean@poorly.run>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 iommu@lists.linux-foundation.org,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>
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

Use the new adreno-smmu-priv fault info function to get more SMMU
debug registers and print the current TTBR0 to debug per-instance
pagetables and figure out which GPU block generated the request.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 76 +++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_iommu.c       | 11 +++-
 drivers/gpu/drm/msm/msm_mmu.h         |  4 +-
 4 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 7e553d3efeb2..56b548921c4e 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1075,7 +1075,7 @@ bool a5xx_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return true;
 }
 
-static int a5xx_fault_handler(void *arg, unsigned long iova, int flags)
+static int a5xx_fault_handler(void *arg, unsigned long iova, int flags, void *data)
 {
 	struct msm_gpu *gpu = arg;
 	pr_warn_ratelimited("*** gpu fault: iova=%08lx, flags=%d (%u,%u,%u,%u)\n",
@@ -1085,7 +1085,7 @@ static int a5xx_fault_handler(void *arg, unsigned long iova, int flags)
 			gpu_read(gpu, REG_A5XX_CP_SCRATCH_REG(6)),
 			gpu_read(gpu, REG_A5XX_CP_SCRATCH_REG(7)));
 
-	return -EFAULT;
+	return 0;
 }
 
 static void a5xx_cp_err_irq(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 064b7face504..97eabd87740c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -959,18 +959,88 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	msm_gpu_hw_init(gpu);
 }
 
-static int a6xx_fault_handler(void *arg, unsigned long iova, int flags)
+static const char *a6xx_uche_fault_block(struct msm_gpu *gpu, u32 mid)
+{
+	static const char *uche_clients[7] = {
+		"VFD", "SP", "VSC", "VPC", "HLSQ", "PC", "LRZ",
+	};
+	u32 val;
+
+	if (mid < 1 || mid > 3)
+		return "UNKNOWN";
+
+	/*
+	 * The source of the data depends on the mid ID read from FSYNR1.
+	 * and the client ID read from the UCHE block
+	 */
+	val = gpu_read(gpu, REG_A6XX_UCHE_CLIENT_PF);
+
+	/* mid = 3 is most precise and refers to only one block per client */
+	if (mid == 3)
+		return uche_clients[val & 7];
+
+	/* For mid=2 the source is TP or VFD except when the client id is 0 */
+	if (mid == 2)
+		return ((val & 7) == 0) ? "TP" : "TP|VFD";
+
+	/* For mid=1 just return "UCHE" as a catchall for everything else */
+	return "UCHE";
+}
+
+static const char *a6xx_fault_block(struct msm_gpu *gpu, u32 id)
+{
+	if (id == 0)
+		return "CP";
+	else if (id == 4)
+		return "CCU";
+	else if (id == 6)
+		return "CDP Prefetch";
+
+	return a6xx_uche_fault_block(gpu, id);
+}
+
+#define ARM_SMMU_FSR_TF                 BIT(1)
+#define ARM_SMMU_FSR_PF			BIT(3)
+#define ARM_SMMU_FSR_EF			BIT(4)
+
+static int a6xx_fault_handler(void *arg, unsigned long iova, int flags, void *data)
 {
 	struct msm_gpu *gpu = arg;
+	struct adreno_smmu_fault_info *info = data;
+	const char *type = "UNKNOWN";
 
-	pr_warn_ratelimited("*** gpu fault: iova=%08lx, flags=%d (%u,%u,%u,%u)\n",
+	/*
+	 * Print a default message if we couldn't get the data from the
+	 * adreno-smmu-priv
+	 */
+	if (!info) {
+		pr_warn_ratelimited("*** gpu fault: iova=%.16lx flags=%d (%u,%u,%u,%u)\n",
 			iova, flags,
 			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(4)),
 			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(5)),
 			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(6)),
 			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(7)));
 
-	return -EFAULT;
+		return 0;
+	}
+
+	if (info->fsr & ARM_SMMU_FSR_TF)
+		type = "TRANSLATION";
+	else if (info->fsr & ARM_SMMU_FSR_PF)
+		type = "PERMISSION";
+	else if (info->fsr & ARM_SMMU_FSR_EF)
+		type = "EXTERNAL";
+
+	pr_warn_ratelimited("*** gpu fault: ttbr0=%.16llx iova=%.16lx dir=%s type=%s source=%s (%u,%u,%u,%u)\n",
+			info->ttbr0, iova,
+			flags & IOMMU_FAULT_WRITE ? "WRITE" : "READ", type,
+			a6xx_fault_block(gpu, info->fsynr1 & 0xff),
+			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(4)),
+			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(5)),
+			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(6)),
+			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(7)));
+
+	return 0;
 }
 
 static void a6xx_cp_hw_err_irq(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 50d881794758..6975b95c3c29 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -211,8 +211,17 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
 	struct msm_iommu *iommu = arg;
+	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.dev);
+	struct adreno_smmu_fault_info info, *ptr = NULL;
+
+	if (adreno_smmu->get_fault_info) {
+		adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);
+		ptr = &info;
+	}
+
 	if (iommu->base.handler)
-		return iommu->base.handler(iommu->base.arg, iova, flags);
+		return iommu->base.handler(iommu->base.arg, iova, flags, ptr);
+
 	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 61ade89d9e48..a88f44c3268d 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -26,7 +26,7 @@ enum msm_mmu_type {
 struct msm_mmu {
 	const struct msm_mmu_funcs *funcs;
 	struct device *dev;
-	int (*handler)(void *arg, unsigned long iova, int flags);
+	int (*handler)(void *arg, unsigned long iova, int flags, void *data);
 	void *arg;
 	enum msm_mmu_type type;
 };
@@ -43,7 +43,7 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
 struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu);
 
 static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
-		int (*handler)(void *arg, unsigned long iova, int flags))
+		int (*handler)(void *arg, unsigned long iova, int flags, void *data))
 {
 	mmu->arg = arg;
 	mmu->handler = handler;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
