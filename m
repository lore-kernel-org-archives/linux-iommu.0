Received: from out28-129.mail.aliyun.com (out28-129.mail.aliyun.com [115.124.28.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAF19ABC6
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599128; cv=none; b=W2gX8cK4+fqqlI7+LlVCjZoq+fJyPMhLRxy50a6Ihj6ld9iy3S0mfr/TbL8Jm9W4s8RHdAM49WEEUvxm0mFZTCOUpFFgMCv2J+kFKQyes+5+02cIUEgMxIR1oCmovFkCsdBau0tD5/FAnkSyy8lsFx+2If+mdW0DvMS4MhLXsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599128; c=relaxed/simple;
	bh=sxgmmB/s8dU0sog7lx+d0UeghLAKezo0fo702m0l6r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fd30ELhn3Uvp0rle7obOQujIeXXgHyuzas5z3CTTPqFjHWo/74AUEGLxjg9W/hWCFCBJdsPZrFpaY7Kd999rOf/OeIgBXnyZ+gII8Ea/B6WtEclSLT4jOxEP6AGUZ0K/9ms/1xvKdHksChzBQSgZxKtkSEcacR4AN1logODqb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07662987|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_regular_dialog|0.0156302-0.00341411-0.980956;FP=1117291624617476391|4|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.h.ByvTR_1774599111;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.h.ByvTR_1774599111 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 16:11:56 +0800
From: Fu Hao <fuhao@open-hieco.net>
To: joro@8bytes.org,
	will@kernel.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH 8/8] iommu/hygon: Add support for Hygon family 18h model 4h IOAPIC
Date: Fri, 27 Mar 2026 16:11:46 +0800
Message-Id: <314f4dff30610306c10e8de17509fca291411841.1774595153.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774595153.git.fuhao@open-hieco.net>
References: <cover.1774595153.git.fuhao@open-hieco.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SB IOAPIC is on the device 0xb from Hygon family 18h model 4h.

Signed-off-by: Fu Hao <fuhao@open-hieco.net>
---
 drivers/iommu/amd/init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39e..568851cc2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3096,6 +3096,9 @@ static void __init free_iommu_resources(void)
 /* SB IOAPIC is always on this device in AMD systems */
 #define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
 
+/* SB IOAPIC for Hygon family 18h model 4h is on the device 0xb */
+#define IOAPIC_SB_DEVID_FAM18H_M4H	((0x00 << 8) | PCI_DEVFN(0xb, 0))
+
 static bool __init check_ioapic_information(void)
 {
 	const char *fw_bug = FW_BUG;
@@ -3121,7 +3124,12 @@ static bool __init check_ioapic_information(void)
 			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
-		} else if (devid == IOAPIC_SB_DEVID) {
+		} else if (devid == IOAPIC_SB_DEVID ||
+			   (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+			    boot_cpu_data.x86 == 0x18 &&
+			    boot_cpu_data.x86_model >= 0x4 &&
+			    boot_cpu_data.x86_model <= 0xf &&
+			    devid == IOAPIC_SB_DEVID_FAM18H_M4H)) {
 			has_sb_ioapic = true;
 			ret           = true;
 		}
-- 
2.34.1

