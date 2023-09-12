Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAE7377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:32:07 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-501be2d45e0so9486488e87.3
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525526; x=1695130326; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5TUXFOv6yn9qpDAW3kO5jAn0DGFePw29Rv/Qa+Dofg=;
        b=rId8ffOjgzgqBfQqCx8GhytJ0HfIwVKVQyxlZXzjD1LNdSaQ/mvnSUfUUunF8FOBB8
         RYzMHW+CBs3Pa/ICmC1JgWEJQrAG6nD8pjYTeEC6g0JvbyceddooBMYLoP73VBvzP5WV
         SgNVbThy/3u6FM76u8FeFZD6PsHLz37xfsJMhR3WIsfZ43/Cbm3xKOkxM7yJ+tvvWn6P
         msz64WdfR/qiGLta17cXBShaOpjVpkfENsZ2+r8tAeubc/oZXLTNmNGKYrS0TUO9Irxc
         3Tn02VT1PU3RF4aBJloyJutPsZmC2kqmbNfdoElPBFwCtoYVIWpNH8pzdpCfIH6cFfRj
         SMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525526; x=1695130326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5TUXFOv6yn9qpDAW3kO5jAn0DGFePw29Rv/Qa+Dofg=;
        b=lCPPpFGdl4jm+Kaygn9YU/d95B7yB+OA82gMlHtemdRY+bjaIJ0uBJhJfAFYouTZGC
         L3D40csxIYXT1TpOR2aLiIq4h8NnC2Mi4mbz85tC6pv6RGgRutonoVO8foUR+HrkXRKN
         Rl5v8U9eJo0jtipjWaYlOGOnMSQMQYAxE2ccF4uwFry7QovM04xUAPCHSAe55PsLXNfI
         6eoPqq1dsHXddtGsJUNlnVnRPWZHjpIdjPGLPicmJrYfZ1GsUUIiE/wHDBHG6zAx6kVy
         N56t+hQUqJ3gIBtLiXr0xc4ZqGyzXvupddrsN37JzI4WRLHhu/cqmoqd9BTPKuQN+fAu
         YD4Q==
X-Gm-Message-State: AOJu0YzQumnrVcjj0O3k9VNKrGUh+XcnlwEMUoVUYsvI0EdqzC/JrL72
	MTS2ORnNi7sBZW2b5vuZdu4iTA==
X-Google-Smtp-Source: AGHT+IHJT5ownOgbIaxSDc0bjTSHUboWqifcbF1bbRzUuxxzkufa54Qv6/pZdVwNX0+AypcHeAsw4Q==
X-Received: by 2002:a05:6512:36c2:b0:500:a2d0:51ba with SMTP id e2-20020a05651236c200b00500a2d051bamr8884352lfs.44.1694525526211;
        Tue, 12 Sep 2023 06:32:06 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:05 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:47 +0200
Subject: [PATCH v2 09/14] dt-bindings: remoteproc: qcom,msm8996-mss-pil:
 Remove PNoC clock
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-9-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1303;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=365nLiorSKhklpxOJKGzrpOJcjkDQ3JA1L7vx8xj8ao=;
 b=ySRL9bhp5qv2LV2atLTYfW8bK0jq1ULmiT06RNxNxp7RXo7yb3yJDGE30x8jvAVd8tI2P5hSh
 SmOedpd+V+SCvsris2NdjIHKDtQdhxNuBTsCKDJeGhS4i0WUKkpGulP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The PNoC clock is a clock for the entire PNoC bus, managed from
within the interconnect driver. Attaching it to MSS was a total hack.
Get rid of it.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index 0643faae2c39..971734085d51 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -220,7 +220,6 @@ allOf:
             - description: GCC MSS GPLL0 clock
             - description: GCC MSS SNOC_AXI clock
             - description: GCC MSS MNOC_AXI clock
-            - description: RPM PNOC clock
             - description: RPM QDSS clock
         clock-names:
           items:
@@ -231,7 +230,6 @@ allOf:
             - const: gpll0_mss
             - const: snoc_axi
             - const: mnoc_axi
-            - const: pnoc
             - const: qdss
         glink-edge: false
       required:

-- 
2.42.0

