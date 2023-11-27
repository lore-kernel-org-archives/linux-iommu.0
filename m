Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814E321AF
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGX7tZeO"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54b0c7987easo3479314a12.3
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 07:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098933; x=1701703733; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDUaT/KJ/VNfco6RB2vLVEnszdzFi1oNwuTEuo9Y8w0=;
        b=pGX7tZeOUJkhJe5SKm1W8db/B/fv9zqsoqbZOAojaET4jwkmB1w8u5cPRgwXQvCWBW
         7foJbNNaWty9kiWHfi+XHjsmdPZD2lYX39yeb9Jyrop6WPkaZB+RuRgedDL1HW76MZf+
         j7m50l1NIyZ16UoCbfhWc9hGgY6ZKPJhvOUpEYp7RDk0P4XVmxiH1NpEsp9pFqR1rkNa
         1ZjmthAAQ+Ezfytbi1zAtpfUlSFzIOKPavOGqPaAEcGuZUZ+LN7uQDYL4oyax40rgLb3
         EYw+dKzbZKzHfyBESEK46mjw3SHlhvQUy8GKla8tETF8p8mRAUo6D1yhSh4zI12XxdIR
         ZDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098933; x=1701703733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDUaT/KJ/VNfco6RB2vLVEnszdzFi1oNwuTEuo9Y8w0=;
        b=XWYVoV+NzREJY+ywizWLXhSDVcfmIwl2PnGBZrpiIH0dLUI17OetfLZAC6pCShFqPA
         gvxzLlInOCIilgEcUSvbISBmVpk2OPPwE6yevOZq7gexpdBlFOctWrTyJz1gJRsh2VOO
         NJMgtMX9JQtuMnVDLr3KiXpuGEG43ii7qeBm8MJQvSxmXEG2G11zPJ6ZI1RmkXr6uCHE
         DGbvmsWhCUlfiQL3SbjkGA5wR/cGZqWMQ3X4qx6UFkSF8fG1SFtoueFi3J982kg9zddw
         lCiSEmQLEXcAMU2dhkiE6U9Q9X7dTlsHTrkzF623G3vil4WvrVhZ8M6T3lvMB+F2aFii
         UNNg==
X-Gm-Message-State: AOJu0Yzz2lVviRmD9Ynp8ZL8K7de4IEZw5bS2gDskz2SGhW7+dR55OYc
	WunpWb4S+quj/kCCTF5Mp4Jtvg==
X-Google-Smtp-Source: AGHT+IEzmMDYeClli0bsqBMCQzev/3yzgw7HjJl19gGbvndSUAHwGg0er0pMbvZpi1YMHIF7FhqcWA==
X-Received: by 2002:a50:ccc2:0:b0:548:4da2:fecc with SMTP id b2-20020a50ccc2000000b005484da2feccmr8744965edj.3.1701098933173;
        Mon, 27 Nov 2023 07:28:53 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:28:52 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:41 +0100
Subject: [PATCH v2 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-1-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1474;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=StOyqUBN12uWXGz5VxyIVjZXe8BbnbVf9Pwbyqv47+8=;
 b=2AvUROB7bo2pn+OEKisCdCRJFBG9VM6cMv+CV/oyTrlgWcVcR2CBpCZ+93Xw3LHZ0rKPc8zwJ
 YESXk2ZQrZpBDMG0mpAz8rh1T4OM3ctfOJ1lfQm20vjIxYEWsctWK1F
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The "qcom,dsi-ctrl-6g-qcm2290" has been deprecated in commit 0c0f65c6dd44
("dt-bindings: msm: dsi-controller-main: Add compatible strings for every
current SoC"), but the example hasn't been updated to reflect that.

Fix that.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 5ad155612b6c..d71a8e09a798 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -56,7 +56,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,dsi-ctrl-6g-qcm2290
+        items:
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -136,7 +138,8 @@ examples:
         };
 
         dsi@5e94000 {
-            compatible = "qcom,dsi-ctrl-6g-qcm2290";
+            compatible = "qcom,qcm2290-dsi-ctrl",
+                         "qcom,mdss-dsi-ctrl";
             reg = <0x05e94000 0x400>;
             reg-names = "dsi_ctrl";
 

-- 
2.43.0

