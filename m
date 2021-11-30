Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE7C433F5
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 08:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81BB0403C2;
	Tue, 30 Nov 2021 08:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFQKu8caC030; Tue, 30 Nov 2021 08:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D81E402B2;
	Tue, 30 Nov 2021 08:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21EA7C0012;
	Tue, 30 Nov 2021 08:14:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DEB9C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 08:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBF8B40133
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 08:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VeofkfP38pWU for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 08:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2325F40105
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 08:14:46 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jkchen@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UyrajG9_1638260080; 
Received: from localhost(mailfrom:jkchen@linux.alibaba.com
 fp:SMTPD_---0UyrajG9_1638260080) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 30 Nov 2021 16:14:41 +0800
From: Jay Chen <jkchen@linux.alibaba.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 inux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH] per device enable smmu whem iommu passthrough
Date: Tue, 30 Nov 2021 16:14:40 +0800
Message-Id: <20211130081440.12397-1-jkchen@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: zhangliguang@linux.alibaba.com
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

Currently, when iommu.passthrough=1 is set,
all arm smmu peripherals are bypassed. This
patch allows specific peripherals to use smmu translate.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 41 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..7ecc7a4c84d7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2076,6 +2076,12 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	smmuv3_no_passthrough=
+			[ARM64] enable smmu for devices when iommu.passthrough=1.
+			Format: {83:00.0,84:00.0,devname}
+			83:00.0 - the bdf for one pci devices
+			devname - the name for the platform device
+
 	io7=		[HW] IO7 for Marvel-based Alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a388e318f86e..e2a57bd37f32 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -76,6 +76,8 @@ struct arm_smmu_option_prop {
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
+char *smmuv3_nopt;
+
 /*
  * Special value used by SVA when a process dies, to quiesce a CD without
  * disabling it.
@@ -102,6 +104,17 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
+static int __init arm_smmu_no_passthrough_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	smmuv3_nopt = str;
+
+	return 0;
+}
+__setup("smmuv3_no_passthrough=", arm_smmu_no_passthrough_setup);
+
 /* Low-level queue manipulation functions */
 static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 {
@@ -2831,6 +2844,33 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 	}
 }
 
+static int arm_smmu_def_domain_type(struct device *dev)
+{
+	char *str = smmuv3_nopt;
+	const char *tmp;
+
+	if (!dev || !str)
+		return 0;
+
+	if (dev_is_pci(dev)) {
+		tmp = dev_name(dev);
+		tmp += strcspn(tmp, ":") + 1;
+	} else {
+		tmp = dev_name(dev);
+	}
+
+	while (*str) {
+		if (!strncmp(str, tmp, strlen(tmp)))
+			return IOMMU_DOMAIN_DMA;
+
+		str += strcspn(str, ",");
+		while (*str == ',')
+			str++;
+	}
+
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2856,6 +2896,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.sva_unbind		= arm_smmu_sva_unbind,
 	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.page_response		= arm_smmu_page_response,
+	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 };
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
