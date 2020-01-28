Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850ECC2D0DB
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B212467E
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gR7ATslb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B212467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3F1D420764;
	Tue, 28 Jan 2020 22:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E8uZWu6gJ1Nl; Tue, 28 Jan 2020 22:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0C0F20523;
	Tue, 28 Jan 2020 22:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99DB0C0175;
	Tue, 28 Jan 2020 22:16:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B6F6C0171
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 079B288042
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xs60JsLxMDqi for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 22:16:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 376B587FD8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1580249786; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GpI+mTVrUBvTTsjKcw+tKygwnL3f9JdTCVmD4fbxwzA=;
 b=gR7ATslbSSj18nQT/bUDYmdONgi/GVGt5pote5MHCHxnb/5Vg1Uc/gPKwM71yD/T0SXO9FB6
 ZgV2heB9DhOAExlBicW0XoY1hWLvortlw71ZztL5BpB1u/V4ZprGL+BOe5kxb8r+XBtOpQLx
 1zJHaDXAHvFP+GuL0t7ZVn5heJM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b2b5.7f22f61ceed8-smtp-out-n03;
 Tue, 28 Jan 2020 22:16:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 73C54C433A2; Tue, 28 Jan 2020 22:16:21 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 17571C4479F;
 Tue, 28 Jan 2020 22:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17571C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v1 3/6] drm/msm/adreno: ADd support for IOMMU auxiliary domains
Date: Tue, 28 Jan 2020 15:16:07 -0700
Message-Id: <1580249770-1088-4-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
Cc: freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
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

Add support for creating a auxiliary domain from the IOMMU device to
implement per-instance pagetables. Also add a helper function to
return the pagetable base address (ttbr) and asid to the caller so
that the GPU target code can set up the pagetable switch.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_iommu.c | 72 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h   |  3 ++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index e773ef8..df0d70a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -7,9 +7,17 @@
 #include "msm_drv.h"
 #include "msm_mmu.h"
 
+/*
+ * It is up to us to assign ASIDS for our instances. Start at 32 to give a
+ * cushion to account for ASIDS assigned to real context banks
+ */
+static int msm_iommu_asid = 32;
+
 struct msm_iommu {
 	struct msm_mmu base;
 	struct iommu_domain *domain;
+	u64 ttbr;
+	int asid;
 };
 #define to_msm_iommu(x) container_of(x, struct msm_iommu, base)
 
@@ -58,6 +66,20 @@ static void msm_iommu_destroy(struct msm_mmu *mmu)
 	kfree(iommu);
 }
 
+static void msm_iommu_aux_detach(struct msm_mmu *mmu)
+{
+	struct msm_iommu *iommu = to_msm_iommu(mmu);
+
+	iommu_aux_detach_device(iommu->domain, mmu->dev);
+}
+
+static const struct msm_mmu_funcs aux_funcs = {
+		.detach = msm_iommu_aux_detach,
+		.map = msm_iommu_map,
+		.unmap = msm_iommu_unmap,
+		.destroy = msm_iommu_destroy,
+};
+
 static const struct msm_mmu_funcs funcs = {
 		.detach = msm_iommu_detach,
 		.map = msm_iommu_map,
@@ -65,6 +87,56 @@ static const struct msm_mmu_funcs funcs = {
 		.destroy = msm_iommu_destroy,
 };
 
+bool msm_iommu_get_ptinfo(struct msm_mmu *mmu, u64 *ttbr, u32 *asid)
+{
+	struct msm_iommu *iommu = to_msm_iommu(mmu);
+
+	if (!iommu->ttbr)
+		return false;
+
+	if (ttbr)
+		*ttbr = iommu->ttbr;
+	if (asid)
+		*asid = iommu->asid;
+
+	return true;
+}
+
+struct msm_mmu *msm_iommu_new_instance(struct device *dev,
+		struct iommu_domain *domain)
+{
+	struct msm_iommu *iommu;
+	u64 ptbase;
+	int ret;
+
+	ret = iommu_aux_attach_device(domain, dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
+	if (ret) {
+		iommu_aux_detach_device(domain, dev);
+		return ERR_PTR(ret);
+	}
+
+	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
+	if (!iommu) {
+		iommu_aux_detach_device(domain, dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	iommu->domain = domain;
+	iommu->ttbr = ptbase;
+	iommu->asid = msm_iommu_asid++;
+
+	if (msm_iommu_asid > 0xff)
+		msm_iommu_asid = 32;
+
+	msm_mmu_init(&iommu->base, dev, &aux_funcs);
+
+	return &iommu->base;
+}
+
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 {
 	struct msm_iommu *iommu;
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index bae9e8e..65a5cb2 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -32,6 +32,9 @@ static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
 }
 
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
+struct msm_mmu *msm_iommu_new_instance(struct device *dev,
+		struct iommu_domain *domain);
+bool msm_iommu_get_ptinfo(struct msm_mmu *mmu, u64 *ttbr, u32 *asid);
 struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu);
 
 static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
