Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1201C07E9A
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 11:17:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4116260FF1
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 11:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4116260FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F41E8404C6;
	Mon, 12 Jul 2021 11:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OsTgWlAlfPER; Mon, 12 Jul 2021 11:16:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77907404B4;
	Mon, 12 Jul 2021 11:16:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6CADC0023;
	Mon, 12 Jul 2021 11:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 065F4C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02943833B7
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4EL11IiXVRD for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 11:16:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DD9E833C9
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:16:57 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNgxC5LVBz6G8qL;
 Mon, 12 Jul 2021 19:08:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 13:16:55 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:16:51 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>, <corbet@lwn.net>
Subject: [PATCH v15 1/6] iommu: Deprecate Intel and AMD cmdline methods to
 enable strict mode
Date: Mon, 12 Jul 2021 19:12:15 +0800
Message-ID: <1626088340-5838-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
References: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: dianders@chromium.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org
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

Now that the x86 drivers support iommu.strict, deprecate the custom
methods.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 ++-------
 drivers/iommu/amd/init.c                        | 4 +++-
 drivers/iommu/intel/iommu.c                     | 1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..a04d2748c99a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -290,10 +290,7 @@
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
-			fullflush - enable flushing of IO/TLB entries when
-				    they are unmapped. Otherwise they are
-				    flushed before they will be reused, which
-				    is a lot of faster
+			fullflush - Deprecated, equivalent to iommu.strict=1
 			off	  - do not initialize any AMD IOMMU found in
 				    the system
 			force_isolation - Force device isolation for all
@@ -1944,9 +1941,7 @@
 			this case, gfx device will use physical address for
 			DMA.
 		strict [Default Off]
-			With this option on every unmap_single operation will
-			result in a hardware IOTLB flush operation as opposed
-			to batching them for performance.
+			Deprecated, equivalent to iommu.strict=1.
 		sp_off [Default Off]
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..3a2fb805f11e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
 static int __init parse_amd_iommu_options(char *str)
 {
 	for (; *str; ++str) {
-		if (strncmp(str, "fullflush", 9) == 0)
+		if (strncmp(str, "fullflush", 9) == 0) {
+			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
 			amd_iommu_unmap_flush = true;
+		}
 		if (strncmp(str, "force_enable", 12) == 0)
 			amd_iommu_force_enable = true;
 		if (strncmp(str, "off", 3) == 0)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a6a07d985709..67c52b60f8de 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
 			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
 			iommu_dma_forcedac = true;
 		} else if (!strncmp(str, "strict", 6)) {
+			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
 			pr_info("Disable batched IOTLB flush\n");
 			intel_iommu_strict = 1;
 		} else if (!strncmp(str, "sp_off", 6)) {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
