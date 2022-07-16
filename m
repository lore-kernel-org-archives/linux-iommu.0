Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546391844
	for <iommu@lists.linux.dev>; Sat, 16 Jul 2022 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
	by m-r1.th.seeweb.it (Postfix) with ESMTPA id B374E1F57A;
	Sat, 16 Jul 2022 21:32:31 +0200 (CEST)
From: Konrad Dybcio <konrad.dybcio@somainline.org>
To: ~postmarketos/upstreaming@lists.sr.ht
Cc: martin.botka@somainline.org,
	angelogioacchino.delregno@somainline.org,
	marijn.suijten@somainline.org,
	jamipkettunen@somainline.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Rob Clark <robdclark@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Add SM6375 SMMU compatible
Date: Sat, 16 Jul 2022 21:32:23 +0200
Message-Id: <20220716193223.455859-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220716193223.455859-1-konrad.dybcio@somainline.org>
References: <20220716193223.455859-1-konrad.dybcio@somainline.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for SM6375 to the qcom impl match list.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 8100ef7768eb..10d0df9e6b75 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -415,6 +415,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
+	{ .compatible = "qcom,sm6375-smmu-500" },
 	{ .compatible = "qcom,sm8150-smmu-500" },
 	{ .compatible = "qcom,sm8250-smmu-500" },
 	{ .compatible = "qcom,sm8350-smmu-500" },
-- 
2.37.0

