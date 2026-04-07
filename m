Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A43A1E8C
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550284; cv=none; b=VQe4OQj6s2G4vnDBmcslqlbn9T4PlxpD9+yO/Prmb1QdyVnV3iX+Af/OANQ+cNyJAehZBPRx+zStHcjwOQL31ZzB14W4ouUv7hY+hb1cs3OeCOBmkJ4WlCcrUpnWNVlIeDbZxdvyNRXUb4LYr4vS8o/bWcNpv/l2H1aRVG/n0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550284; c=relaxed/simple;
	bh=sxgmmB/s8dU0sog7lx+d0UeghLAKezo0fo702m0l6r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J37FVUR/WeICinrmOhDkRM4e00cqwIjjz9ZDVF+UDs343u5Kgibq7QNgm3fE4vqDNtvKxuarrDOnGXXah54kYiS6rUkUolRB4uiQqTAQJgWbAo+RK9eTxQ+LOSS8/PdWI4jrUrjhxmpYjhhNKHAyDBabf/LqzHsnHDxKzzVnZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07663862|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0156302-0.00341411-0.980956;FP=1117291624617541927|2|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032027189;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.h6dNpqZ_1775550264;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.h6dNpqZ_1775550264 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 16:24:29 +0800
From: Fu Hao <fuhao@open-hieco.net>
To: joro@8bytes.org,
	will@kernel.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH v2 8/8] iommu/hygon: Add support for Hygon family 18h model 4h IOAPIC
Date: Tue,  7 Apr 2026 16:25:40 +0800
Message-Id: <3c1d95e3f53b250c97c60f613ead7e0ec0ea2d87.1775548724.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775548724.git.fuhao@open-hieco.net>
References: <cover.1775548724.git.fuhao@open-hieco.net>
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

