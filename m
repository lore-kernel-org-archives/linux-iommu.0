Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5162F9F0
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 09:51:35 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F0EE6606F8D;
	Tue, 20 Jun 2023 10:51:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687254694;
	bh=3K/g1tbaM/y2c9YEm8HiMo7STgxOq2EJPtZTFgO09Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEXcYiVtv408pbwHBwLzhU9/pM2S1KmEAC7lbY5J7GiTjGsGWQH1z6OurDjb5dUT6
	 KhJe01jQ18k8Vf9/rVypZClSO2TEUVb5yVYzEV3uTW+9w03f1CVoHPKGxVW4819i1M
	 hcXstTG1pGZ4icQLhqnn7+XA8qK/WI/4891y7ajDmBRhxk+A6ybC9srseCBfkptxnR
	 YbEq5Dpk68nMoFFL7zAfBvd87PDxygRcADjoIjE/U6x3Gf2qWBwoXB6eoXlGa8ktpb
	 1hsMn9+Kk33ZYrbeVaZJ1RH3tffOrK3uG/9RjdDhHwbel1Fwfmr3r8RCRYDLE/MGZb
	 BiRpWVPZAQ/sA==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: agross@kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	dmitry.baryshkov@linaro.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	robdclark@gmail.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com,
	Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v4 2/6] iommu/qcom: Use the asid read from device-tree if specified
Date: Tue, 20 Jun 2023 11:51:23 +0200
Message-Id: <20230620095127.96600-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As specified in this driver, the context banks are 0x1000 apart but
on some SoCs the context number does not necessarily match this
logic, hence we end up using the wrong ASID: keeping in mind that
this IOMMU implementation relies heavily on SCM (TZ) calls, it is
mandatory that we communicate the right context number.

Since this is all about how context banks are mapped in firmware,
which may be board dependent (as a different firmware version may
eventually change the expected context bank numbers), introduce a
new property "qcom,ctx-num": when found, the ASID will be forced
as read from the devicetree.

When "qcom,ctx-num" is not found, this driver retains the previous
behavior as to avoid breaking older devicetrees or systems that do
not require forcing ASID numbers.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
[Marijn: Rebased over next-20221111]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a503ed758ec3..b661b559ea01 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -531,7 +531,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	 * index into qcom_iommu->ctxs:
 	 */
 	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
+	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -617,7 +618,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 
 static int get_asid(const struct device_node *np)
 {
-	u32 reg;
+	u32 reg, val;
+	int asid;
 
 	/* read the "reg" property directly to get the relative address
 	 * of the context bank, and calculate the asid from that:
@@ -625,7 +627,17 @@ static int get_asid(const struct device_node *np)
 	if (of_property_read_u32_index(np, "reg", 0, &reg))
 		return -ENODEV;
 
-	return reg / 0x1000;      /* context banks are 0x1000 apart */
+	/*
+	 * Context banks are 0x1000 apart but, in some cases, the ASID
+	 * number doesn't match to this logic and needs to be passed
+	 * from the DT configuration explicitly.
+	 */
+	if (!of_property_read_u32(np, "qcom,ctx-num", &val))
+		asid = val;
+	else
+		asid = reg / 0x1000;
+
+	return asid;
 }
 
 static int qcom_iommu_ctx_probe(struct platform_device *pdev)
-- 
2.40.1

