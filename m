Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28C33C2
	for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 18:18:54 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso9226012pjh.5
        for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3UPV+AIr+VN1gJBjfNvC42kkO2spb7wnrBuGNcr6epA=;
        b=qvSOn95xRk74S7zpkCSkCjyYWsHCcZk6bI8EiNG721G1MkN0hChGYrFZXC4KLeE/I+
         4OJ+apvmmxlT0d86KhV/qCQw/sYVc6hVP6zkxAiettOdUxl9hQPWOx6PoYLRTtl7YQGJ
         DTu874p88RWKZUOTvQaToVZPYns9dhdjHDx/yq9qjAEou5Q/gJTlafvC7DP8ao4Lpyzt
         ApfRLIXQdlDXhLz4kYkymAP1Kjlu0/S7ygei/KXj1+Eab8wBJBNRjWvS0x7gPdleLnEB
         xeJy9jwo7wPZdQjDogYg+2QQR7q1rqP/qYK1VDEodix280gbUvEHWKl6BFrGrZaAxagE
         IuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3UPV+AIr+VN1gJBjfNvC42kkO2spb7wnrBuGNcr6epA=;
        b=aA+zJwhHMnqXNtwI8qtAnynfGjH87UdM+2sl/EXyvAhXNp4mf9M+/y6zenxDcMZEkS
         a9ArmV/Ar5p7lWD+U1LScS7d42JoIU3xknH2Vzv0g2dcAVeuXPTfqqwjwLp8xmO3n6X2
         dg6664rdAp65R93U2lkdHl8FRllkFx/3C9Muk1upEF97RhCFli71FLTyKhwvz1N6z0yl
         QYlZNLtWJjvNBacASQG1RRPq5Q3KSkyBWT/H/jKspHpvxTWu7g6Ig/N6GY5Z3/TMRDtE
         Xoo59GzCjei4CJWxdCmzRw4jW8L1/kcaWT+XjGt+B8YZG+EHftPwKWkWRrXmosFTM6Ti
         TDAQ==
X-Gm-Message-State: ACgBeo3cdl+++/gnK7HJPXywyOKIzTtV5G3W+0I1yK/wDkO+BHcRfHOY
	y8tnWF0JhlDrKIMu0NBdYDc=
X-Google-Smtp-Source: AA6agR7dtmESYOitnU5DYhjNSHX3sh73wN0UvrFXYQMVn/nBm2N8GH+sNa7fESl2HF3bNjC49hhRdQ==
X-Received: by 2002:a17:90b:3d7:b0:1fa:e708:ef43 with SMTP id go23-20020a17090b03d700b001fae708ef43mr13620916pjb.239.1661105933694;
        Sun, 21 Aug 2022 11:18:53 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001726b585d4bsm6792298plh.202.2022.08.21.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:52 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] iommu/arm-smmu-qcom: Provide way to access current TTBR0
Date: Sun, 21 Aug 2022 11:19:03 -0700
Message-Id: <20220821181917.1188021-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181917.1188021-1-robdclark@gmail.com>
References: <20220821181917.1188021-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

The drm driver can skip tlbinv when unmapping from something that isn't
the current pgtables, as there is already a tlbinv on context switch.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
 include/linux/adreno-smmu-priv.h           | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7820711c4560..59b460c1c9a5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -157,6 +157,14 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 	return 0;
 }
 
+static u64 qcom_adreno_smmu_get_ttbr0(const void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+
+	return arm_smmu_cb_readq(smmu_domain->smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
+}
+
 static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 					       struct arm_smmu_device *smmu,
 					       struct device *dev, int start)
@@ -217,6 +225,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->cookie = smmu_domain;
 	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
+	priv->get_ttbr0 = qcom_adreno_smmu_get_ttbr0;
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
 	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->resume_translation = qcom_adreno_smmu_resume_translation;
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index ac4c2c0ab724..4ad90541a095 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -43,6 +43,7 @@ struct adreno_smmu_fault_info {
  * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
  *                 NULL config disables TTBR0 translation, otherwise
  *                 TTBR0 translation is enabled with the specified cfg
+ * @get_ttbr0:     Get current TTBR0 value
  * @get_fault_info: Called by the GPU fault handler to get information about
  *                  the fault
  * @set_stall:     Configure whether stall on fault (CFCFG) is enabled.  Call
@@ -64,6 +65,7 @@ struct adreno_smmu_priv {
 	const void *cookie;
 	const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
 	int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
+	u64 (*get_ttbr0)(const void *cookie);
 	void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
 	void (*set_stall)(const void *cookie, bool enabled);
 	void (*resume_translation)(const void *cookie, bool terminate);
-- 
2.37.2

