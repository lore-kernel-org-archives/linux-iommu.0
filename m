Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473C7B
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 00:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFDCC433C1;
	Thu, 13 Oct 2022 00:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620185;
	bh=XBFpSNBpsvsC+odxjmIBVDNq5cxpXJDA1q+v7F0LK8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP811IJMfpACJUm2/ycjY4Jz0ADqpLUp5zLyl9eNbMoWOMibzhKQnfnhKPvRnEVlK
	 Am7qJcrs+/TgpRbNaDyP4C8Xdc5wRXjXtcYKrsdGl7En2dCrVqGgNayrMKx05di6Tb
	 nA416BSfdLmESBlw2pa4L407NYZWNxlHJYjLfel3M3XF7fnsG5TkaF5fMR/BCb14OH
	 xKleUPc3jEIw7jKYn0npB9lIqUlFf/v0u9jYFuPYDhH5qVORMw0uhpHuPuYIbcTU0z
	 hgvvo3G7TxlcYojtgsGTODc2YyX9WZzsvd4KqtmEOiaTYsNL92VDduq2RV5ff0FW+/
	 9ciQQMrZKWbYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	John Garry <john.garry@huawei.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	jgg@ziepe.ca,
	tglx@linutronix.de,
	shameerali.kolothum.thodi@huawei.com,
	christophe.jaillet@wanadoo.fr,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.0 13/67] iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to identity
Date: Wed, 12 Oct 2022 20:14:54 -0400
Message-Id: <20221013001554.1892206-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 24b6c7798a0122012ca848ea0d25e973334266b0 ]

The DMA operations of HiSilicon PTT device can only work properly with
identical mappings. So add a quirk for the device to force the domain
as passthrough.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/20220816114414.4092-2-yangyicong@huawei.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.35.1

