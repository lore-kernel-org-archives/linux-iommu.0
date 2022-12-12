Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB61FDA
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 10:06:22 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id x28so17679426lfn.6
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHwpzdAgeysBPjazrb8MZAklpvcch7q79EoiQSklm4=;
        b=a/cqR3OmFlwQ2CdWLT4/9k8uaKshPkOmZbfG58+OuOX46knLAG7cQEu2GCEwRyPqEs
         y/hD4vUys0tprqY3OHNqDXo7pdF4W9IOwifvY+6SIB9TvrQWqas14voG4g4kXszGsOvA
         NXtqYPzKGddJg0cs9et+X09UEkCyx+/dWT4W2GNM0wrmvOoP28wTJMLQNVnDyxgT076S
         I6L9kDhnyEsTfpFw6PLHrFYzHEXpNx+Mf9F3PFJFgKtz7I60mQqetqkr8qkQaRX/wj2w
         PI/avCbXLGjhbVdybY4qsfoAh38TItwsuK7GO61nal47ZsRU0eOnsY1bDwBvpL9ym8hy
         2tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxHwpzdAgeysBPjazrb8MZAklpvcch7q79EoiQSklm4=;
        b=vzEYYq8NAsur/ExL0L2tqQClSlnTpSYXTl4j+tU5+z0B/LxXnGjahxq0fj0iV33RzB
         /5Yc1l52SLEy0Y1WD9aJBrqUMKVB/wCUwdZWCkh5a2xXzCDe7MQbp01/6lINwvNjLgW3
         J/xcWY0gcZKgPqd7ionY664bSRSyvWuOAV+Jlk1H1bGQMJfXEBLVpIaHVl9+3tP2BL1N
         rLFrsxY6yWyS/wz0dES1lqwiuxD2yo6KoZzxIfsXTj+muwPHCOrQ22jEh5WUgNde4Z6W
         LNN2WJ4Vo6fZEPDnRPj01X+D3rwUYIn03jg5r+k3Ld2lTwgijVnPa3sB/2+q6uUW93hu
         Xr9Q==
X-Gm-Message-State: ANoB5pl+UnlelBNSJDP5hz2u76L4F2N9Yb7JYeV7nxo7U3S+1k75j2W9
	oP1qHbFxM0iZdTcCeO7fz3RWxQ==
X-Google-Smtp-Source: AA0mqf5CzScTMQIXPiYPV2YD594XKdZ5k3C8WvM0e52jzUu7K/7Aeq2ynaYjH+BhVeHCMGpOTa6GRA==
X-Received: by 2002:a05:6512:358d:b0:4b5:6c00:429b with SMTP id m13-20020a056512358d00b004b56c00429bmr3733559lfr.26.1670839580725;
        Mon, 12 Dec 2022 02:06:20 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id o27-20020ac25e3b000000b00498fc3d4cfdsm1586330lfg.189.2022.12.12.02.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:06:20 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: marijn.suijten@somainline.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	Adam Skladowski <a39.skl@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Date: Mon, 12 Dec 2022 11:06:16 +0100
Message-Id: <20221212100617.18190-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marijn Suijten <marijn.suijten@somainline.org>

Add the SM8150 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Depends on the binding here:

[1] https://lore.kernel.org/linux-arm-msm/20221212093315.11390-1-konrad.dybcio@linaro.org/T/#t

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6610f5d2877d..cd74c1efcfde 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
+	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
-- 
2.38.1

