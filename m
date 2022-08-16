Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166363C27
	for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 11:46:20 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6TlD6F24zXdbK;
	Tue, 16 Aug 2022 19:42:00 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 19:46:11 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
	<leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
	<corbet@lwn.net>, <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
	<jonathan.cameron@huawei.com>, <john.garry@huawei.com>
CC: <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
	<suzuki.poulose@arm.com>, <joro@8bytes.org>,
	<shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
	<zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <bagasdotme@gmail.com>
Subject: [PATCH v12 1/5] iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to identity
Date: Tue, 16 Aug 2022 19:44:10 +0800
Message-ID: <20220816114414.4092-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220816114414.4092-1-yangyicong@huawei.com>
References: <20220816114414.4092-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected

From: Yicong Yang <yangyicong@hisilicon.com>

The DMA operations of HiSilicon PTT device can only work properly with
identical mappings. So add a quirk for the device to force the domain
as passthrough.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d32b02336411..71f7edded9cf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2817,6 +2817,26 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 	}
 }
 
+/*
+ * HiSilicon PCIe tune and trace device can be used to trace TLP headers on the
+ * PCIe link and save the data to memory by DMA. The hardware is restricted to
+ * use identity mapping only.
+ */
+#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
+					 (pdev)->device == 0xa12e)
+
+static int arm_smmu_def_domain_type(struct device *dev)
+{
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (IS_HISI_PTT_DEVICE(pdev))
+			return IOMMU_DOMAIN_IDENTITY;
+	}
+
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2831,6 +2851,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.sva_unbind		= arm_smmu_sva_unbind,
 	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.page_response		= arm_smmu_page_response,
+	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.24.0

