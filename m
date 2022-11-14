Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438879C9
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:06:46 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id j4so20395227lfk.0
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u8ckjitOk87OPv1Jwz8aOeKIkjevPLVEgZLx8LVKu0=;
        b=RKwF7+xKIOGSnKveI2PAInWKUnqEGSjLhQQFfCvQVMPJtbi24+cGu0b3OcSyBWppll
         azC4x8354D0ekmcZLlbmkrrPTGLZ6URFJGHgfgj6MZRRWKbm57ekKj/VRsrX+dLG6mtT
         5PdEX7ghguLGv4P9P6nctM16YxC1j3bEkYx6zSCnVoY1MApK84obwxNNeWUKGAkktnf/
         9EKacFihcXAH7XE6hu1+s5RMFbm4zIF5/lyodKZHmITBZ+RWQmbFTpfQxDiC8rXNq5pE
         aqiHMTlwOuWc4bWrCVEZB8e+kQGeIMo/dbg3fznpg/d2JzLVAhAytnSORJJP/Qa74Z8x
         NXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u8ckjitOk87OPv1Jwz8aOeKIkjevPLVEgZLx8LVKu0=;
        b=QO1HaHuqAuLcv5MZuZIy8Xm6u3iIYfSbMBuxxDveH/d3oGzqcOwgBuzx//j8/24I4U
         67iWrEXYa47Txu+C0ZqbA0WzN3sh+8i1v+EUPgjK/7mHxZN2b/Q+ML3jQfNzPzIcQXHp
         PNcn/v59Pm0N19uEJmBuxZll4BlXN+ulzIPL2yWCE7exkJ1WKlHwHUrqiB450JrqFxad
         9g9ATS7b2oDJGO3K3XyShuU+xzIpjRG6fA5y4KCRXqtF4tg8lhBW4mQPQw+l8RDOWU7i
         Lf2pBcelQQm3rLffDcgZm0QQRiD8JI55cEje1z/blk4TI2FxfcyK4qSyVYvoQJLtggEY
         hQmw==
X-Gm-Message-State: ANoB5pmydZN+KoKStEwWAYV4M3WhrbjfcyYngTzzYfMvXtK/qwA3/Lev
	/ZHfjK0NuK6HPFMIOFqO0/0nSQ==
X-Google-Smtp-Source: AA0mqf6iE8d2S2e+OPdybOymDTWtPOKfA6NgyrVu0mdAo+HMp22j6G/cBaBrN6dsAlqFPBVieiGcXQ==
X-Received: by 2002:a05:6512:79a:b0:4b0:efed:e3a7 with SMTP id x26-20020a056512079a00b004b0efede3a7mr4543580lfr.323.1668445604416;
        Mon, 14 Nov 2022 09:06:44 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b004a2ae643b99sm1896344lfr.170.2022.11.14.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:06:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH v1 10/10] iommu/arm-smmu-qcom: Add generic qcom,smmu-500 match entry
Date: Mon, 14 Nov 2022 20:06:35 +0300
Message-Id: <20221114170635.1406534-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
References: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic qcom,smmu-500 compatibility string. Newer platforms should
use this generic entry rather than declaring per-SoC entries.

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b93aaa0594d3..0830e614f3be 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -496,6 +496,10 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.cfg = &qcom_smmu_impl0_cfg,
 };
 
+/*
+ * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
+ * special handling and can not be covered by the qcom,smmu-500 entry.
+ */
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
@@ -516,6 +520,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
 
-- 
2.35.1

