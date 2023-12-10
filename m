Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A06FAD
	for <iommu@lists.linux.dev>; Sun, 10 Dec 2023 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlwDX+fW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ce72730548so3148099b3a.1
        for <iommu@lists.linux.dev>; Sun, 10 Dec 2023 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702231622; x=1702836422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTV7HGPkUIAwckXy51M7re7fb1HUU7ow6BY0UtdbRw=;
        b=mlwDX+fWw/xZkYjZsaRLyPcMjO1tFIw94YUWatZHtjXhXQRLpZQJkw069Mz20s6Ho5
         DstxgT9WHDs5q2X9up8Mum80SdJdLIPf8KX9Jiwp9Qx0yIE/6+CWlPMBo8iaOQe+475p
         3DhHMi05G1Y3861JOvqYsVa1hZiWAkvXh6pt66rAlmsW0r5hATf1GEtutVBwKCNZ6MpQ
         Ns0gswpK7/LQSFkbG6oqa2xDbkfoeq2DexWx/Vmc1K5WLOuG2UOqMcORgFPMfYubq7Wh
         rFscNhywmHNBMiOAktNyPcdHNhiBuD+TGjoe8Hn+9RE/cyr56K4MSPOHSk5yNK9zTZUo
         hIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702231622; x=1702836422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OTV7HGPkUIAwckXy51M7re7fb1HUU7ow6BY0UtdbRw=;
        b=Xn1Hb3duLHkjfehy0iE6F7pWEZmTK8mL3RnFluZcNsn1gLASgGI+KL/ACJsPxgsDDw
         naz4drdcOUrigFh9rX5aJ2vCVdaMSj5mvdSV80neiKj93U6qmFwcYYUwspwUz1zpTVVn
         aUGIAEvnqew65MQV69d/pu0PcAfGIhEk6Kr054yH9oYLshW/RL5FiupZBow8Q6mJ4ZpX
         1aW9y6UI5+uq1Vt9VMq/M1bUPNdsx3ifUVZo8EkixiazJRAKwALoAij7xCZD85gTOnJ7
         h5jEbptgspChtzoKlBmMH3q9rO5MR8IPw2G9jq4xeQaZVCJJKxlnd4nUL7DxxewIdvjR
         4SxQ==
X-Gm-Message-State: AOJu0Yzu2S33bdgLWrpIZu5FZrzVoJEMUj4SyevlQSUbqWq3bcyjwicG
	x+YbQjn/09l/jESpa4vNHe0=
X-Google-Smtp-Source: AGHT+IGf1cjoJui1YLxDAmJIwqwz1hXkSEY0wBxCHb7JCefydWE1QX71XuqaZiGK7iUv67Arc0VJrQ==
X-Received: by 2002:a05:6a20:7f9b:b0:18f:97c:8a3b with SMTP id d27-20020a056a207f9b00b0018f097c8a3bmr5034958pzj.102.1702231621767;
        Sun, 10 Dec 2023 10:07:01 -0800 (PST)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id 11-20020a63154b000000b005b458aa0541sm4769792pgv.15.2023.12.10.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 10:07:01 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Johan Hovold <johan@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/arm-smmu-qcom: Add missing GMU entry to match table
Date: Sun, 10 Dec 2023 10:06:53 -0800
Message-ID: <20231210180655.75542-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

In some cases the firmware expects cbndx 1 to be assigned to the GMU,
so we also want the default domain for the GMU to be an identy domain.
This way it does not get a context bank assigned.  Without this, both
of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
allocating and configuring a context bank.  So GMU ends up attached to
both cbndx 1 and later cbndx 2.  This arrangement seemingly confounds
and surprises the firmware if the GPU later triggers a translation
fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
getting wedged and the GPU stuck without memory access.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
---

I didn't add a fixes tag because really this issue has been there
all along, but either didn't matter with other firmware or we didn't 
notice the problem.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..d326fa230b96 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -243,6 +243,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
-- 
2.43.0

