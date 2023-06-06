Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783A37B7E
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:27 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b1ba018d94so41275101fa.0
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055465; x=1688647465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfoMnvnUW9JxHFNrsE+j3PaFEyoaLfNhlabOCKS4wNc=;
        b=V1ReI/T+XetTpZFV6pPbBNshd5IFECMTZE+/Ns0lqS2R+pNJudcsgIMQlDZyyK8ZXu
         mwymOckDZ9+J+c4V3PXyZWiExBZkJQkQz6Sa+M8eqGcjD0ffi7Uo+JJyN3bZ0bEBJ9L0
         fwhuoalot+ziIUjYt0vgKeYjSkCGgJbjnClOH9mqB7keqlTTmb20Aq2633UiOSKnclht
         3u/rFF3iTcVM2P4fAhNUFEHyk7JTbpSujYZtFRdnrXbpY28AijIHHgm5LL7kUXXOuAdr
         6qfvmBh6UjMSYb8YtvqJQbqXf3gS2zrT9YuAmKyI/bbe7fXEyAComsn5M7BBwjFmLry1
         9/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055465; x=1688647465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfoMnvnUW9JxHFNrsE+j3PaFEyoaLfNhlabOCKS4wNc=;
        b=d1hcdvx3BcEt/Z52BLWjgC61/ZhHzmwrSLvH3MBF727kaM2el2K0H5T59p8HV/3Klw
         Md/l6sYDTYFQ/ihRIvq6G15PZDJK+FP2tEfWYVis26h3dgRy1xsFbm4VVUhhdy57aP+j
         GghXtY1iofqjTRpkzVTbyvlZxjnPI1hH4xGjUXS5S3Yf7EYXS0ukO921CbxmUYiODiC3
         xhz6HUj5f27Z+uZOVhYEw7RxflL2j9ysgyDoCHOZxiq3JTezPnUCxPww6X/EzLhmxIe1
         1rRat8OTPrcEI6+Aia59gEjtg2i0hSb04ZOdOKxHamCh0BhB86HV25XBtJ6cz4Lvfuin
         PNKw==
X-Gm-Message-State: AC+VfDzTPWC/A5kQIscmhtiMRlsJvVqdwMrMdtBBdNDHq2D1o3b9fxub
	36C8CzpR+35r3gEenSb1nZOxSZqVlo4++kHlaWM=
X-Google-Smtp-Source: ACHHUZ7ekWTowrPVlra8w+zZoWxewe/oa3lUa6JCxAgmo+hje0H7GiRpgvh8WmtcKUSxXWPZeV25AA==
X-Received: by 2002:a2e:3c02:0:b0:2b1:eb9e:20df with SMTP id j2-20020a2e3c02000000b002b1eb9e20dfmr1073937lja.17.1686055465236;
        Tue, 06 Jun 2023 05:44:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:24 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:44:02 +0200
Subject: [PATCH v6 11/12] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-11-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=U7GrazUMOESVisMUp1R2X/i2E38+ra43yVyDZTsdMko=;
 b=jxGg9uqgLp6Xj4teEsBXHZg3TUHPabmerE8XQFJme0dKqJNcl1H0zer/Z3ueyg2C8OOTX/lsn
 lsiNsc2XIogAgDJnhIjXPMLCHVQZk9ZXI2zac2qD51AlEO2+Dsa/P9J
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 3800ab478216..cc574928c707 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ }

-- 
2.40.1

