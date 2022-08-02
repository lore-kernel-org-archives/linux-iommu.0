Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE47F
	for <iommu@lists.linux.dev>; Tue,  2 Aug 2022 23:43:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="70963422"
X-IronPort-AV: E=Sophos;i="5.93,212,1654527600"; 
   d="scan'208";a="70963422"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 03 Aug 2022 08:42:24 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7689BD63C0
	for <iommu@lists.linux.dev>; Wed,  3 Aug 2022 08:42:23 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5C95BD9972
	for <iommu@lists.linux.dev>; Wed,  3 Aug 2022 08:42:22 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
	by oym-om1.fujitsu.com (Postfix) with ESMTP id 2E26F4008A7C3;
	Wed,  3 Aug 2022 08:42:22 +0900 (JST)
From: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	thunder.leizhen@huawei.com,
	jgg@ziepe.ca,
	tglx@linutronix.de,
	chenxiang66@hisilicon.com,
	christophe.jaillet@wanadoo.fr,
	john.garry@huawei.com,
	baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ishii.shuuichir@fujitsu.com
Subject: [PATCH] iommu/arm-smmu-v3: fixed check process for disable_bypass module parameter
Date: Wed,  3 Aug 2022 08:42:07 +0900
Message-Id: <20220802234207.1994093-1-ishii.shuuichir@fujitsu.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

The current process does not enable the bypass setting regardless of
the value of the disable_bypass module parameter when ACPI is enabled,
so the value of the disable_bypass module parameter has been corrected
so that it is handled correctly.

Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88817a3376ef..256d7b2a83a7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3396,7 +3396,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
-	if (!bypass || disable_bypass) {
+	if (!bypass && disable_bypass) {
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
-- 
2.27.0

