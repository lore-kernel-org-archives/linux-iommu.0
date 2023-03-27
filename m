Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2269807
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 08:00:39 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso10441802pjf.0
        for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679904039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t835u8fPpTnpgpz0aOnogBgxIgEA8yK0GAtsldSZe9U=;
        b=IHujZ+yJH5Qfn6DB3SeaG6Lv0s3K8PfGgLtlNTZ/z2YwYag+mamqHhak08nyiSD202
         kGUyYiy3bfj06OKK+9FFuXG+j7pBDTHyDbbJKy+bA4W5zD7/SToBdUrJgiLUMgdawblz
         i0NmCSwGiJrFzwVYEe5HM4wItvf0xqgUtWVTCdBjV1ruzZdMkwJ5H6+TGQlQSUAdRJSY
         +3+2B44HzRMacOeF8Z31ktcDtrAXwpKjdpvE+CFso0R2jEg4BiBxCdCX518nWo4q5lQY
         3sVqqI6L91nqyB3c5HYrRXkFv/IAihCzguoF73FOeyhtDFEu4cptDMynTU4LuFKHkjsH
         AA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t835u8fPpTnpgpz0aOnogBgxIgEA8yK0GAtsldSZe9U=;
        b=ATt5R72ghdunwY0+r9Qvg0664u3l1k3CWtml2s3El65ulowHHOXf3OwwHU/D7iFnj3
         OjUr9DUAU+BjVgJk8xmWQeydHGgmYByq6wi0xOoNaXK2R+w796aFsEBzNfzLEFveykMZ
         wTCmuIMs7vPnc1gnxTSuEK0On/YN9vZe5a85e8np0/yP8arlK6cvSIL73HnKvzjpF/Ci
         tff2PtBqgPuPIHEetE9sIbHUmdyrERYQ5DqrsivygAGXAxNxObBQXV6Sr0MKr8Jr1nut
         IVExTN+1QOmUK16cwIJAO8X7+u1d+wfE/nmRVEnjiP6w6EqH5xHgPz99+SPzAD0VYjSa
         np4g==
X-Gm-Message-State: AAQBX9debcWSmyMslayXnAOuB9igL7DDbF4NAUSqmqILDGl7HU6ycRsl
	MYjLP7QHkfiQ7Jcvw50wu269
X-Google-Smtp-Source: AKy350Yl/PP07MKLFG2pkiPDQVZC7O3+X0DB170zIRdxpW6VfRQUJZ83xB4ggU47iKV+/Qgt3rV7CQ==
X-Received: by 2002:a17:902:e0c5:b0:1a2:1a5b:cc69 with SMTP id e5-20020a170902e0c500b001a21a5bcc69mr8084298pla.32.1679904039265;
        Mon, 27 Mar 2023 01:00:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.184.83])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902b94c00b001a1ed2fce9asm9844469pls.235.2023.03.27.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:00:38 -0700 (PDT)
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
Subject: [PATCH v5] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Date: Mon, 27 Mar 2023 13:30:29 +0530
Message-Id: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

Changes in v5:

* Reworded the commit message and comment to reflect the fact that the
  hardware indeed supports more than 128 groups.
* Collected tags

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
index d1b296b95c86..decf63b8c97c 100644
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
+	 * Some platforms support more than 128 stream matching groups than
+	 * what is defined by the ARM SMMU architecture specification. But due
+	 * to some unknown reasons, those additional groups don't exhibit the
+	 * same behavior as the architecture supported ones. So limit the groups
+	 * to 128 until the behavior is fixed for the other groups.
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

