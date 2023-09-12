Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27986377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:32:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4013454fa93so63952455e9.0
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525523; x=1695130323; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fIbXPUxOgaRdqz8db2Ih/LEJAu25y/8yx2Z1zWWYkc=;
        b=hd+o54iK/49vqXlHFqRQ3y8mIJwNXJ08oc1RlXQapbu3sZHgVX0n+srwzfcqktVjXD
         MdklMR1jRaFvK4d2XJNV1Z6lU0stsTvSooH50q+cDURKDOeFKq8B8/0hG1c9N3HD3KMK
         K7FzFruVMzWjCQnL73HKxrc+a7y94+nvLnh2mJcAWdACyLZvAjEl973UxNxK6fns3I15
         lYHJewk6tVGwj4J8CdUFhduV06yS+ciPRvOCAbgu0oWqyQRAGXqbZcHT/e1tDNv3Kkbn
         gDOaNdxMYzJr6TKFYnLNSBl3UpVjSJoQsqu+803vlLH+iDF8eXuPoA8nQV+OemgBsX1r
         xEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525523; x=1695130323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fIbXPUxOgaRdqz8db2Ih/LEJAu25y/8yx2Z1zWWYkc=;
        b=wm3QSR1POCU5TdXdFztyV7V6hz7FghXx0X8BufGcp9LE0Zu9BdT4s1/aGS/nVHPL/B
         OPK3+GverWEQDukml3gvtpWoNklL5qLj0c92h91Pi7nfAhUhO36vwJrqJ4wz2c9YHe/U
         OD/iOs2RFWwj8Xr2COZW+0UDGkRs65rFWcceo1rFcbMABYR8P4p15sNNMAQuH012B0Wk
         wx2GbZRWX4vLRDvjkgoqdo6KY0kyGJ0raC5kwUYuHo+EGwNEGzh7tZKzbM5FG6q33off
         1Qo5Yo+5aYD+IqlDGP1tttHbutH09XzsmPB57u2xuVwVeB7GteduRo82mLUXrC6fjsI2
         7Yhg==
X-Gm-Message-State: AOJu0Yyqni85S0K2X14uW/gpESHMowM0r/R+OFFd6T60SH6kGeAA1QvX
	fGii4MZNDCeX7eCn5WpLJm5uIQ==
X-Google-Smtp-Source: AGHT+IHzJIPQHME1Q7uvTkr6fW7CEioQdhde5+dmoERPBsutUw7GSxKetx2FMzynENM3rKV8xd5oDw==
X-Received: by 2002:a5d:448c:0:b0:31c:7ada:5e05 with SMTP id j12-20020a5d448c000000b0031c7ada5e05mr10020874wrq.51.1694525523578;
        Tue, 12 Sep 2023 06:32:03 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:03 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:46 +0200
Subject: [PATCH v2 08/14] dt-bindings: remoteproc: qcom,adsp: Remove AGGRE2
 clock
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-8-1e506593b1bd@linaro.org>
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
 linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1615;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nFM/c4yhEW/1Dlnb7a6ypwnImP1sGtGxirXiBz1eak0=;
 b=JDyPUD41UqorWQJn/tchpJ3anwshIH4V9EmIuE8LBebXP25/DZMh3KXg4CQrOMQ4VZ/xrZfs3
 iIhGTWcO1/6Aymi8D5hrH5z4wKppS/IuNsDm4BZdJkVbXR+2a1OMcBI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml    | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index a2b0079de039..661c2b425da3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -66,7 +66,9 @@ allOf:
               - qcom,msm8953-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
+              - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
+              - qcom,msm8998-slpi-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
               - qcom,sdm845-slpi-pas
@@ -79,24 +81,6 @@ allOf:
           items:
             - const: xo
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8996-slpi-pil
-              - qcom,msm8998-slpi-pas
-    then:
-      properties:
-        clocks:
-          items:
-            - description: XO clock
-            - description: AGGRE2 clock
-        clock-names:
-          items:
-            - const: xo
-            - const: aggre2
-
   - if:
       properties:
         compatible:

-- 
2.42.0

