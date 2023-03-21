Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB98BE1
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 10:15:27 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id bc12so14868919plb.0
        for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679393727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYIEmKf52NYEWrNdpaXJ3v1W0hKF3ftprNKh3Wud+Dw=;
        b=BmyyTr+3j2Vvujb32yH2EM+vbvlpatom5s2GPyNol5mKx1hZWtWwfJ5YxZPRtlO+wR
         X3eajkA02HKDYXJiMVg0FxsQeS0JVBKMypwGmrRP53GjctYSxKVUCRkkQKsWf0vCPG6i
         5ZekszoXrCkfj95X/4IZVYRng/YD2FvBmc7CD2F24kIE4dP4cS1cDOkki9jLBHLr86vH
         bUE9oIDX+yCpW/gECTMAXV2gAwgpvPAffHoLQwqNvvCR0R2RTzPrkfK4snkEWAwgc0qm
         5GRPy+3RxJ0qWe7U1W6V+H6Kcy2iRJc9XBL+XsqFqDRXsjOD7L/6trcCKyyugWbrYXEC
         Pl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYIEmKf52NYEWrNdpaXJ3v1W0hKF3ftprNKh3Wud+Dw=;
        b=QPsB1czUJnypFkPWBvASDrGoTGE+pKuqbB1Mknen6BPudhac2a8bqa0b0cu0OATbrZ
         Nk8V0pkzixD1ha/k+ghoJqScOXaWiRHOItZ/Bx0EWbN0YoQGRxGbo5+qvbOPmlRD5Z8n
         ILuoEU3LuA2YV7d5QGaUrFn0pdgWAhYo0GixJBKWQCKJmvTZfKzWzukzxT3F5cdGcoHl
         GEEVDh34w4+TCTPacxeC7AYAWq5oR4HYqeZGTAZq5Tappj38BL/0Q2HVivsM83jhB2F8
         b4wgR7C2Tl4+DddSxZ8YQEQkIOJhbiCjEAs4aXxCe+oaITN7FvyNEBCCfr+sHo7gn+0N
         JbmQ==
X-Gm-Message-State: AO0yUKUQSPKd3plzd6us/oftbV8MWRT5SMPlZSg0hdqnCkCmiKgKDtc8
	Ce2ixKwIdusM6QZnyqsI5uZ9
X-Google-Smtp-Source: AK7set8wT5e21KPeq70SJ2RVHMDL8pXfqoa+nAuyHbWCb/g80CXj+qROT4H42dOBTddU2G4mhbI32Q==
X-Received: by 2002:a17:90b:4a43:b0:23f:e4b7:afb3 with SMTP id lb3-20020a17090b4a4300b0023fe4b7afb3mr2102902pjb.9.1679393727395;
        Tue, 21 Mar 2023 03:15:27 -0700 (PDT)
Received: from localhost.localdomain ([117.217.184.244])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b0019eae717885sm8371936pln.107.2023.03.21.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:15:27 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	andersson@kernel.org,
	johan+linaro@kernel.org,
	steev@kali.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Date: Tue, 21 Mar 2023 14:43:32 +0530
Message-Id: <20230321091332.18334-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some Qualcomm platforms, the hypervisor emulates more than 128 SMR
(Stream Matching Register) groups. This doesn't conform to the ARM SMMU
architecture specification which defines the range of 0-127. Moreover, the
emulated groups don't exhibit the same behavior as the architecture
supported ones.

For instance, emulated groups will not detect the quirky behavior of some
firmware versions intercepting writes to S2CR register, thus skipping the
quirk implemented in the driver and causing boot crash.

So let's limit the groups to 128 and issue a notice to users in that case.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v4:

* Spun off the SMR limiting part into a separate patch
* Dropped the quirk rework part as it is not really needed for now

Changes in v3:

* Limited num_mapping_groups to 128 as per ARM SMMU spec and removed the
  check for 128 groups in qcom_smmu_bypass_quirk()
* Reworded the commit message accordingly

Changes in v2:

* Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
* Moved the quirk handling to its own function
* Collected review tag from Bjorn

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..54f62d409619 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -268,12 +268,26 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	unsigned int last_s2cr;
 	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * Limit the number of stream matching groups to 128 as the ARM SMMU
+	 * architecture specification defines NUMSMRG (Number of Stream Mapping
+	 * Register Groups) in the range of 0-127, but some Qcom platforms
+	 * emulate more stream mapping groups. And those groups don't exhibit
+	 * the same behavior as the architecture supported ones.
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
2.25.1

