Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6E6D3F
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 13:55:49 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 124406602A5B;
	Fri, 11 Nov 2022 13:55:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668174942;
	bh=5J9op1SHRAc7CVXi/aw9XgRw2WXyTLhdCxf9a+Y9k1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtmY98hVSESAsKLj+JAoVSi0ZpQwDDjGfwHGD1cq09h55a5M7sEEvCNaEHvsUeb1v
	 lKNShXEKBW2tC7U6fbPqBf5gPac5IYVa7MLRf7EiV9r831/Rp6mxdf3AANYfmJ1qqu
	 OQnaTTYebbC7Cdc6e2nXLHhe2kGx4QM4WRHa/uGWaDGnzXD2wCEoCPb4WdzXfqSy5K
	 a9dOeGhZhlGq9iRQEAYy1CajMgRX8keyZR1GB5aXVRcGnRcAVqFV7xl0J9xhlX3oPb
	 3N04zXlnb29x4Njjf8wBfipU7+v+ip+FA2n8wv2Ucpyi+ZvbBDkFne44h0OkY6fSCq
	 249up9nUekmng==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: agross@kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robdclark@gmail.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	marijn.suijten@somainline.org,
	kernel@collabora.com,
	luca@z3ntu.xyz,
	a39.skl@gmail.com,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/7] iommu/qcom: Index contexts by asid number to allow asid 0
Date: Fri, 11 Nov 2022 14:55:22 +0100
Message-Id: <20221111135525.204134-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
References: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver was indexing the contexts by asid-1, which is probably
done under the assumption that the first ASID is always 1.

Unfortunately this is not always true: at least for MSM8956 and
MSM8976's GPU IOMMU, the gpu_user context's ASID number is zero.
To allow using a zero asid number, index the contexts by `asid`
instead of by `asid - 1`.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 5b127ac41b5e..1fcee74154f0 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -52,7 +52,7 @@ struct qcom_iommu_dev {
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 num_ctxs;
-	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
+	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
 struct qcom_iommu_ctx {
@@ -94,7 +94,7 @@ static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid
 	struct qcom_iommu_dev *qcom_iommu = d->iommu;
 	if (!qcom_iommu)
 		return NULL;
-	return qcom_iommu->ctxs[asid - 1];
+	return qcom_iommu->ctxs[asid];
 }
 
 static inline void
@@ -563,12 +563,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
 	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere, since 'asid - 1' is used to
-	 * index into qcom_iommu->ctxs:
+	 * to sanity check this elsewhere:
 	 */
-	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
-	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
+	if (WARN_ON(asid >= qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -726,7 +724,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "found asid %u\n", ctx->asid);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
+	qcom_iommu->ctxs[ctx->asid] = ctx;
 
 	return 0;
 }
@@ -738,7 +736,7 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
+	qcom_iommu->ctxs[ctx->asid] = NULL;
 
 	return 0;
 }
@@ -779,7 +777,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct clk *clk;
-	int ret, max_asid = 0;
+	int ret, num_ctxs, max_asid = 0;
 
 	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
 	 * many child ctx devices we have:
@@ -787,11 +785,13 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	for_each_child_of_node(dev->of_node, child)
 		max_asid = max(max_asid, get_asid(child));
 
-	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
+	num_ctxs = max_asid + 1;
+
+	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, num_ctxs),
 				  GFP_KERNEL);
 	if (!qcom_iommu)
 		return -ENOMEM;
-	qcom_iommu->num_ctxs = max_asid;
+	qcom_iommu->num_ctxs = num_ctxs;
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.38.1

