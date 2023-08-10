Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB5214E8
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 17:45:12 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so1856636e87.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689511; x=1692294311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ8fNoRhbMQbavYz3EL1f8wM8/yF7KTjRgYXkDMQaMA=;
        b=dljhf77Tr4NJUgwvW7DEWrM77eYKaj1NZPVDcNqopcd2ADIHl1fR1PgaqlCeE/VQ/G
         6VCfQgdfV6VOX2BZcMQeXfBQf7tk0qf00dWcwCObbS7FhFmASmUgZnosyuhS2pnLd5jA
         EVyLw1wh8GeF3k9B1pNVZl0A3AU/4DAuZvOdTt+bwE5tXT1sfw4cVHuRKlg4MJI/b4zC
         5+BTn5E6KPO2aTr6yMLL1nCYnQYrf5PP3udZ53rYrmphlygeUMEq4ogGijJzkCp4zJb7
         0yFB89FzxLBtoIne4UyCZhRxUBUgdFcdy9Amyui/8xc9ysC3oAyeVMYj63wPvm4ZXge1
         EwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689511; x=1692294311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ8fNoRhbMQbavYz3EL1f8wM8/yF7KTjRgYXkDMQaMA=;
        b=ZB+k+vVcB+xMmBACiPvD7D5bz0SjtEwSIXyUf/Yb/4jBrOz6wRwW/QVFgxI5cGHTXw
         kd4NBhrFqJZ8O8ft1KPwuF0+cMPUgBYiLRMcbNJBePLCio2mbcf71lJdgWNobMXHH8Q+
         1XmIsU5wCry9t4hphX5oIPrIRdzuzQYqphP+rhxZ26mVyBrG/6T0e4Aor2QRdEJ9Rbr5
         0d49M0LvYRwJqd2fEHo8ejo8Wj1h2hpGLOYiKA/a9DQeCVT8j3nQ7A5t0vDxKvE98Z0F
         H7kCC2k3XEm5KWhgq0hmgCrAlmAe0jt+qcieKJqoWAfrRVxROdfNYFzK/g1OK0cmBJwV
         e+Dg==
X-Gm-Message-State: AOJu0YxvpB6i0Nl7eGZtabB0beX6mNAjwe/KXO8rtO1+fyDVLIcvDQeQ
	YPAeAbbS4ieZuER5UUD7rmjNOw==
X-Google-Smtp-Source: AGHT+IH3O45J0mhWQQdaSnbK/VkyJ1m35ng5Kc/xDbldxVSiEHLm1bnbl74iwcErP3kckBDfXP0ZtA==
X-Received: by 2002:a05:6512:2520:b0:4fe:8f0:6aa with SMTP id be32-20020a056512252000b004fe08f006aamr3439265lfb.49.1691689510706;
        Thu, 10 Aug 2023 10:45:10 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:10 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 10 Aug 2023 19:45:04 +0200
Subject: [PATCH 1/4] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-topic-lost_smmu_compats-v1-1-64a0d8749404@linaro.org>
References: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
In-Reply-To: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=1026;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QsYXprleFiyojpiKbE6Kw0XKenZmtLGgzHLB9aaIrjw=;
 b=WMMj34R8wVtLr6EyGNZVl1+X0m1IGx4HSfAaxjcEtJ2WlM+ceIXOdP/694tFuv1SiqByGVCAg
 FV4tVNagA2fCO94pQtttmg2xOjGEAkhExIBjE3RZHJ8B6vwiDXsshdU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

It got broken at some point, fix it up.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c71afda79d64..3800ab478216 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,10 +251,10 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
-	{ .compatible = "qcom,sm8150-mdss" },
-	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm8150-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
 

-- 
2.41.0

