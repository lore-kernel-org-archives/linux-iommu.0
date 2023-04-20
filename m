Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048689471
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 22:31:41 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso932725e87.3
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029900; x=1684621900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7U+MQQRn266X/fu48wXlntxvnDdxvseAqEyvV5bnYU=;
        b=tMlxGgaR6TjY9h0TBPC//jlkuKqvmqB/3gCELO4fQHzbhqM1pN8tWw5LvbFYIMEFAx
         2W7OizUDJ7IuE4yeBSwaonNURn0iha2+UHhiZRq+ZPzmsZ6oJJ6udJxD2ptavJ5iWxgb
         LhBoIarkiSGbTzPKLaNsjYWrh1W2ySxsIHaSfTwYeuQt2axkX9zm5bsuf+tAuvXDAGPF
         RybMNWmjB7IpiOJFEvXvk/QJsAbSrcIpGKZR20E/1ICfsQdRqG6X1+v0r/Qv8t49I0s0
         y0JlgurZs8Nmwa9ZuqONoww3D7GdNClHsi2aGUU5viYJviBhqcpwXnerXS58bixKFHIQ
         yWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029900; x=1684621900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7U+MQQRn266X/fu48wXlntxvnDdxvseAqEyvV5bnYU=;
        b=WSKLmNxDrJhJDb1zxQUeanRcpSjeotA75NPO1c85tKN6WEM+D00xrGhHt5mveHwZjP
         auV9Gbqf6MT1IeF3vfU/pEKusHOoojMbNv7/XJspxczHhnDESyuPjqM8DgGg0Zb45sRS
         qxINBvefP86EGQMOHPMmBo8Z6l1cC7I6IK+Vjlatv2MOZZJbuplNaAnd3nxBycfhfJEy
         D0lOMMelrC8dvtUGkXBLWYHq7pGAXAg1PvA8iMIx6fSJHNUGGZwaejJp4LIPbZ8QrRAU
         gOSF55p2rMgXAaulMCrHnQR/PkWp+sWXF+mHf9E5ljUTbSNV5RZRmyFfvUo6ka0NcPpY
         2/uA==
X-Gm-Message-State: AAQBX9c9XHVNImD452Pf9AIvn+yWp3uIwS4Vp7rQ7m1h9fh1ujrfXEbR
	ZIfsqYbdjlo0dew9bjJu1UV/SQ==
X-Google-Smtp-Source: AKy350ZHaiUf6dhHxtQIv5/1RWQP/D8HT6ayzW/hPzmDLaYG8EmD3Kj8tDGo9DQ1XAOeCfV2w5oZjQ==
X-Received: by 2002:a19:c503:0:b0:4db:513b:6ef4 with SMTP id w3-20020a19c503000000b004db513b6ef4mr861359lfe.11.1682029900156;
        Thu, 20 Apr 2023 15:31:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:39 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 21 Apr 2023 00:31:20 +0200
Subject: [PATCH v2 11/13] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-11-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=785;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/9HUTFzDlWhvA+x0Ieoh1uk/GJ56evseSi3zEZVI4y0=;
 b=ROJxpQig3kurlmL1S3QtRtECNCPVtfMcinbv+K27HQnjedkIX8uJX5aG6iQpvL9I7p/oUOGv9hbW
 FCr4DwNFAO+ezsbjZfziED0S7dhYav6nqfEfdzaeIBUDDYNQX+Nk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae09c627bc84..995ab5172883 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ }
 };
 

-- 
2.40.0

