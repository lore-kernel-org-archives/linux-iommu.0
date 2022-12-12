Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45123BD
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 12:10:59 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 1so18202116lfz.4
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArZdgDUPTxxyHH9qYlQrCbZtI7IOKmLLf9ZbqR0krVg=;
        b=euJoDwYFzbm62Z2MoNPWwEh0uYkbDZZY5Ge2FXxsFmGKf8k35Tw5IyBCfaFR3xIuYW
         i5KD9wihfj0XjGvieZjDZneMohCZyhVsSmdu4QN++NKWb1Lz0uRB9c78yrNzGnG/qW8q
         BvdNUFd19wjl+xz3oHZanWNyR3v6Gf2DAl8vkURtOXaXTdr94MtUzuBECLaIuFUtrEB3
         KXgCzDdg+XG3SAN+esCfhrlOmynUDQfs7fvg+lCGvV3LIlcFTDLKsPNj7S07Rzix6AmV
         OwSHjBBTC62wSdr9InzccDj5Jlvcvfwj6vpq36jK901X3dRl3U13gK6zxHfckMI/uADH
         5pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArZdgDUPTxxyHH9qYlQrCbZtI7IOKmLLf9ZbqR0krVg=;
        b=E84zQda8r15+K4lGkKKh5VNPC4uPGtl/x0jqA/SlVa7AdwRm1h2QAQetpUZ2gUaCcp
         4/uWhJT/1v629bYJ2d4uEJ88l+gDaz551pAgtjWIR6LGwCpAvhw1lp8xId6qCouJWljV
         1Y+KJnQzgFYcvRz6cfXXvSzRg//eQ4U7WrCj6febExsymXon3zlmFFhDEOLSN/dYXzvP
         //E75pf6Bb/2uPPrcU6tHDDyk+5PANkwyTObPZh/y0/ckXmq5icuFHXNViohXxEVJ0R/
         JKGkD8s/JAmPBm4Yq6DVNg4f8ADI0BhWk4D/2Yny14bmE357hT9wQL9k0UFD9L9//QgD
         iwow==
X-Gm-Message-State: ANoB5pmG6LgVRPi2KPcxZaS91386LORH8pKBf4XOVS18a9MgQ2o6xh7Q
	dUpHtgobMiFDPp2KPjBivDGeyg==
X-Google-Smtp-Source: AA0mqf4UwVm2QNGEWhCr8AWM3w7xJopx1vjnQH10HOcb31DgqEYIDHUbF+ieDqBsnWDwIh7npmW6Gw==
X-Received: by 2002:a05:6512:224a:b0:4a4:68b9:19fc with SMTP id i10-20020a056512224a00b004a468b919fcmr6308665lfu.36.1670847057942;
        Mon, 12 Dec 2022 04:10:57 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c7-20020ac25f67000000b004b55ef84338sm1604592lfc.305.2022.12.12.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:10:57 -0800 (PST)
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
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Date: Mon, 12 Dec 2022 13:10:53 +0100
Message-Id: <20221212121054.193059-1-konrad.dybcio@linaro.org>
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
Changes since v1:
- rebase on clean -next

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 91d404deb115..ed884c85e262 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -250,6 +250,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mdss" },
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
+	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
-- 
2.38.1

