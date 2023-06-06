Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909E37B70
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:10 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso43202841fa.1
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055448; x=1688647448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwN0tI2Kl+T0HN09yLqjcLaiWYt+x33veuBBB/2tgTQ=;
        b=aVWZFuHUTRWDrX0ticH4FlzHopsuDKvHUr124ajPfFWICxW6XYstyo1cqBGcB1hjJo
         SzOlOJ3v3H0PXU2Z+AJTmtihRZbKjLYpP1pCRdnD/oD/6KPqgXrzjP15M442rAmVWF+w
         cXtw1HZdvMYKbMBpnASuMSyILmM1QqNn4IB0VCjqCvRWMiT3xVqUho8ukTIvHtcne2ND
         isBrW1qcAVtJafjViAOEcb0zs+8J8lrNNwNDyCyzZ17h7m0D4dGUlacHszw2bELdpIbT
         XIUJF7tAtVg26qTJ1sWSjFTGkZBvaAvZb7mu7PC4aPT+CkdXmIhmL9iS9e7+oVujy1TC
         8cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055448; x=1688647448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwN0tI2Kl+T0HN09yLqjcLaiWYt+x33veuBBB/2tgTQ=;
        b=MAL6MpZ3QA9VvpE6d0MVQjlLYY0COFyzQ7p2xqY2OAE+pSSN4sKW5IzOp2lP+GCiXX
         149fS9G5ODUOWLjd+a5wXot+7hPpiaqw45EgL2sWxqMVXXCpBHnY7EJhO0Rg4a9I2jEl
         3GxiDaARSZGbb1IpxOFIfayyAIWc+A3f/LYgaNDxAk0xbzKOkgsrqof6uzvNlhsOtyTt
         7LuYGJlbJM9B6WsnIuX3n4O3Ur3NvDKfhK7qLnHT8nur+UQdz7hs5B6cpSy9ba/IHtOx
         3hxhRmOA8KdKOxCbEV37dbWN6evpQYkEeJVT8ShpEgqM8ocfb6uOD3lysrHxUWqO45Cv
         rfQg==
X-Gm-Message-State: AC+VfDwEFMfwBGZoqOVnvvpadfukhSHBq2pl/PaGzrFU8eWVMaXo4ZIu
	WBYGXhvpfNUTjt1eyxb7pTuFaQ==
X-Google-Smtp-Source: ACHHUZ6aO/1pq8KEvhZVd8M0EaZRDyi2x3/mS986KEl4lpoS9FLEUfcwiol40awMVLj9BbM/1PnLkw==
X-Received: by 2002:a2e:9258:0:b0:2ac:dd01:e169 with SMTP id v24-20020a2e9258000000b002acdd01e169mr993850ljg.40.1686055448226;
        Tue, 06 Jun 2023 05:44:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:07 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:43:52 +0200
Subject: [PATCH v6 01/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6350
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-1-dee6a882571b@linaro.org>
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
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1129;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jRckpE5DBdoe5VmYMwGlXlu4F2L97YNKmiEsTH+Z5Jc=;
 b=kpFcKUbuEtgTQtQl2WDDIygCPWJ3FbhWGRd2lOkRMB99UVp6BQaxv4NPaP1Br9hU0SNvditq6
 nCiQe0g3DZXBUQZexQr5BOBbwfYCSYUsPu8ssuRodOg2s9+x9rkQOu6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the DSI host found on SM6350.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 660e0f496826..8081ced7b297 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,sdm660-dsi-ctrl
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -299,6 +300,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

