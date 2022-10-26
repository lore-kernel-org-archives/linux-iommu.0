Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
	(using TLSv1.2 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB96AD24
	for <iommu@lists.linux.dev>; Wed, 26 Oct 2022 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666811276; x=1698347276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CTeiZ4hWxpNnCAIJGQUzuGaxbO50pTdY/6SPH/RoXJk=;
  b=jH/N6gAYgnVHRhA+oOVWWhNUxEOER+vlA0Rp525v1d90xJQ0L0q4XKi/
   RCQ78HGA76NBQ1GGmatVsmhnrfbQ0N4qeZJ3CXpZPmXZL2C37cN9WgUpg
   uN0b77DwJSidmD9DsnzYzrnsfBRh/VSRLhom1HmzgTjTepjKiQbRpT/qb
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Oct 2022 12:05:47 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 12:05:47 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:05:46 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Robin Murphy <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH v3 0/2] Add smmu support for QDU1000/QRU1000 SoCs
Date: Wed, 26 Oct 2022 12:05:32 -0700
Message-ID: <20221026190534.4004945-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)

This patchset adds smmu bindings and driver support for the QDU1000
and QRU1000 SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Changes from v2:
- Removed qru compat strings

Melody Olvera (2):
  dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
  drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)


base-commit: 60eac8672b5b6061ec07499c0f1b79f6d94311ce
-- 
2.25.1

