Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB414A88
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 21:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E87DC4339B;
	Tue,  9 May 2023 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683667204;
	bh=lcel328loRITeXRv3RE9jcY84pE3zVBvwqmUAMUcinU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ep1/o5qXy9RlqJmdFI6omvXy03pj5PmXO5T+Q///381lfQUpdUD1CGoVpWpl101nN
	 E08ui/0XqGs/LQj68N/PrSLedymbs84VE4uzB4F/oowaq2VD1dtTw+MtJLgh2m9JUV
	 zk6yaXe5a+ASyz7ike57Yt0bDld/xO58FEisWhUmlwWLZPejk8TIUr2quryCnEVlLM
	 vFUNnYSufqVUXUi41Aa3UER3E8KCUhlTZQRgfliDAz0hIoYkrjlxg03nKhFX0/Ql5S
	 uqDPLbFaGOqUk7FugIngFEbyCu6wA6vfXA2WXfwK91Mx/PCDIqMj8Wqt7NmPPf2k0I
	 jKI90YnjHZkfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	dmitry.baryshkov@linaro.org,
	quic_saipraka@quicinc.com,
	konrad.dybcio@linaro.org,
	quic_bjorande@quicinc.com,
	marijn.suijten@somainline.org,
	quic_eberman@quicinc.com,
	mani@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.2 03/18] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Date: Tue,  9 May 2023 17:19:41 -0400
Message-Id: <20230509211958.21596-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211958.21596-1-sashal@kernel.org>
References: <20230509211958.21596-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 12261134732689b7e30c59db9978f81230965181 ]

Some platforms support more than 128 stream matching groups than what is
defined by the ARM SMMU architecture specification. But due to some unknown
reasons, those additional groups don't exhibit the same behavior as the
architecture supported ones.

For instance, the additional groups will not detect the quirky behavior of
some firmware versions intercepting writes to S2CR register, thus skipping
the quirk implemented in the driver and causing boot crash.

So let's limit the groups to 128 for now until the issue with those groups
are fixed and issue a notice to users in that case.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20230327080029.11584-1-manivannan.sadhasivam@linaro.org
[will: Reworded the comment slightly]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 91d404deb1155..f43499869e381 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -266,12 +266,26 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	unsigned int last_s2cr;
 	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * Some platforms support more than the Arm SMMU architected maximum of
+	 * 128 stream matching groups. For unknown reasons, the additional
+	 * groups don't exhibit the same behavior as the architected registers,
+	 * so limit the groups to 128 until the behavior is fixed for the other
+	 * groups.
+	 */
+	if (smmu->num_mapping_groups > 128) {
+		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+		smmu->num_mapping_groups = 128;
+	}
+
+	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
 	 * ignored, and writing BYPASS will end up written as FAULT in the
-- 
2.39.2

