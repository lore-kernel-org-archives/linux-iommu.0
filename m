Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8ADC3A5A2
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 06:33:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622CB2070B
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 06:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XNzBFYZ9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Apy+Iem8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622CB2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DDF12DA7;
	Fri, 23 Aug 2019 06:33:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5153FDA6
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 06:33:11 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C604D67F
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 06:33:10 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A9C536118E; Fri, 23 Aug 2019 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566541990;
	bh=P4WMJZCUbit61VXbOdXn2Cni0Wq6Y5i5PXty4SNUUdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNzBFYZ9jBV/uENkt0i9Pp7Q++M24qUokPrOE0GZHs1rWKVZsyejHDpv7byCh0r1b
	iQevx8T4OIjD3nhpyOs5brbkWlQTjc2b6AhX4Gj8OW5CsfAISlIzqBVmZlq+zYidwl
	qVKjm1INlPTd1Z/8QuVkoOvHswiZcQAjhx25teTA=
Received: from blr-ubuntu-41.ap.qualcomm.com
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id C24C16110F;
	Fri, 23 Aug 2019 06:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566541989;
	bh=P4WMJZCUbit61VXbOdXn2Cni0Wq6Y5i5PXty4SNUUdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Apy+Iem8BLJ+DCK5hnkAfiAOzInZVJCqWtuqjkn/lYMW3KOuthO+RNMOvuOYnJGT5
	7tQQKZgSFLbCYxpcK4XNUadw2HmIX8veNTktDxlr8ckfJiTiVuZH9vujQ5UWMhk8Vg
	CN8iJABiiNnFLiaCeL9HC6dRUnD/Fc4PxTPADdLs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C24C16110F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, agross@kernel.org, will.deacon@arm.com,
	robin.murphy@arm.com, iommu@lists.linux-foundation.org
Subject: [PATCH v4 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
Date: Fri, 23 Aug 2019 12:02:48 +0530
Message-Id: <20190823063248.13295-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn.andersson@linaro.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Add reset hook for sdm845 based platforms to turn off
the wait-for-safe sequence.

Understanding how wait-for-safe logic affects USB and UFS performance
on MTP845 and DB845 boards:

Qcom's implementation of arm,mmu-500 adds a WAIT-FOR-SAFE logic
to address under-performance issues in real-time clients, such as
Display, and Camera.
On receiving an invalidation requests, the SMMU forwards SAFE request
to these clients and waits for SAFE ack signal from real-time clients.
The SAFE signal from such clients is used to qualify the start of
invalidation.
This logic is controlled by chicken bits, one for each - MDP (display),
IFE0, and IFE1 (camera), that can be accessed only from secure software
on sdm845.

This configuration, however, degrades the performance of non-real time
clients, such as USB, and UFS etc. This happens because, with wait-for-safe
logic enabled the hardware tries to throttle non-real time clients while
waiting for SAFE ack signals from real-time clients.

On mtp845 and db845 devices, with wait-for-safe logic enabled by the
bootloaders we see degraded performance of USB and UFS when kernel
enables the smmu stage-1 translations for these clients.
Turn off this wait-for-safe logic from the kernel gets us back the perf
of USB and UFS devices until we re-visit this when we start seeing perf
issues on display/camera on upstream supported SDM845 platforms.
The bootloaders on these boards implement secure monitor callbacks to
handle a specific command - QCOM_SCM_SVC_SMMU_PROGRAM with which the
logic can be toggled.

There are other boards such as cheza whose bootloaders don't enable this
logic. Such boards don't implement callbacks to handle the specific SCM
call so disabling this logic for such boards will be a no-op.

This change is inspired by the downstream change from Patrick Daly
to address performance issues with display and camera by handling
this wait-for-safe within separte io-pagetable ops to do TLB
maintenance. So a big thanks to him for the change and for all the
offline discussions.

Without this change the UFS reads are pretty slow:
$ time dd if=/dev/sda of=/dev/zero bs=1048576 count=10 conv=sync
10+0 records in
10+0 records out
10485760 bytes (10.0MB) copied, 22.394903 seconds, 457.2KB/s
real    0m 22.39s
user    0m 0.00s
sys     0m 0.01s

With this change they are back to rock!
$ time dd if=/dev/sda of=/dev/zero bs=1048576 count=300 conv=sync
300+0 records in
300+0 records out
314572800 bytes (300.0MB) copied, 1.030541 seconds, 291.1MB/s
real    0m 1.03s
user    0m 0.00s
sys     0m 0.54s

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu-impl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 3f88cd078dd5..0aef87c41f9c 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/qcom_scm.h>
 
 #include "arm-smmu.h"
 
@@ -102,7 +103,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 	return &cs->smmu;
 }
 
-
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
@@ -147,6 +147,28 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	arm_mmu500_reset(smmu);
+
+	/*
+	 * To address performance degradation in non-real time clients,
+	 * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
+	 * such as MTP and db845, whose firmwares implement secure monitor
+	 * call handlers to turn on/off the wait-for-safe logic.
+	 */
+	ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
+	if (ret)
+		dev_warn(smmu->dev, "Failed to turn off SAFE logic\n");
+
+	return 0;
+}
+
+const struct arm_smmu_impl qcom_sdm845_smmu500_impl = {
+	.reset = qcom_sdm845_smmu500_reset,
+};
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -170,5 +192,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 				  "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
 
+	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500"))
+		smmu->impl = &qcom_sdm845_smmu500_impl;
+
 	return smmu;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
