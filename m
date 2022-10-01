Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
	(using TLSv1.2 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038F1FBA
	for <iommu@lists.linux.dev>; Sat,  1 Oct 2022 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593717; x=1696129717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1b+zli1SlijyBYxo6L1QFNxdyFYXGYqBZEJU1nQ9mhg=;
  b=R5nq0lU6qpl5HpXqnM26TgvhigyUFKRrehfSekvXEr0sNLhOts5k5H6H
   s0IKn6rM1Ot8suDqO9P6Km1abZDF2yf5Xme75BPO8XX4/hLJNljir+EOj
   U4/ud63FHV4qumliM0xaTMfDYfN4kChpzXJdahasDOtXpAJ29kIvnZ/eo
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Sep 2022 20:06:27 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:06:26 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:26 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Robin Murphy <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH 2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation
Date: Fri, 30 Sep 2022 20:06:15 -0700
Message-ID: <20221001030615.29135-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030615.29135-1-quic_molvera@quicinc.com>
References: <20221001030615.29135-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)

Add compatible for Qualcomm QDU1000 and QRU1000 SoCs to add iommu
support for them.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..2b9a3c917aae 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -439,6 +439,8 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500" },
 	{ .compatible = "qcom,sm8350-smmu-500" },
 	{ .compatible = "qcom,sm8450-smmu-500" },
+	{ .compatible = "qcom,qdu1000-smmu-500" },
+	{ .compatible = "qcom,qru1000-smmu-500" },
 	{ }
 };
 
-- 
2.37.3

