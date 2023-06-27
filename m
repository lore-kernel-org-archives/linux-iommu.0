Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC91ACA0
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:24:59 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fa08687246so4695247e87.1
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883097; x=1690475097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSIrkDXpbBJJF79TNwbHEzUtRhMGVG0zQuOGkk3fmhI=;
        b=IoddTkfO5tyJTW4sBdG96yKju/2zkdaz8Ih6r1OgbZyFYIGnFb9FgdojUCQbNDpsC2
         CSDG1Y9IvFn0LGAkBT/zzvqbcU6oi0jFv3gJWgTtUrZ9OtczoQWBftZWtafS0go4jEhe
         uTdrSVkI5P2pU8jdHjBaNe7LbovRankNV5OBrCNbN8bts3hxbXbCCted9KSZ4btQFE4Z
         QxmC96DVoK0JJ2+wcl0s76bxFn6GyhL5tFD4rQsq+Nj+zPK4kMs/6lDlUINp9JGbJNqo
         cBhatXQ00E1GUSGawoBVzZCeOV0Ubb0Aa5ewYLXSP4z+8f7pPOhaKvSXo5RYGAjInEmp
         d2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883097; x=1690475097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSIrkDXpbBJJF79TNwbHEzUtRhMGVG0zQuOGkk3fmhI=;
        b=h6sy93BVAoAhK6kUTWgpdW2KlkuF5BzLrx2s127vRuu1hKcnQx5vEyuYSwnNqWoJx6
         LA/QjzNbadn8ZBgXAtzDGJ5yOArFADt96mPibzA2fTjJ0ZlEIS5qC3mOlMylczA6uKEq
         j1SDBnGu/Panxv/piQX0fieMGug+2kdkglDCgr3xGDJq/VPSOOqYibTAPem3EkykMQ1l
         un0xa1w1PP/nYB+nBqmAy0lpfcWCEIf1F7fhG7XYdntttoj8gLWf46Wx+tW0c9JRT83t
         B5M5aQownSMQfd2r+NfLKcGyiKJbn4bmQojL4+DCMvG+LcLyddcbFfx4e8mZE2rHC4wO
         rnFA==
X-Gm-Message-State: AC+VfDysLEHYh03B2yO1Jn7/bUhv4qDfTv3Aj7BkeMW5IJiO/+TlNB8n
	cuXMSLh3oBzmI8Esph/Drg3GJg==
X-Google-Smtp-Source: ACHHUZ4r9irVoENkd8byj3320r8JiIAdEQ/lABEZXknA2fxdO6BKPyPCZg1djvkW496qNULbkbBgNA==
X-Received: by 2002:a19:915d:0:b0:4fb:8aeb:d9be with SMTP id y29-20020a19915d000000b004fb8aebd9bemr731320lfj.30.1687883097444;
        Tue, 27 Jun 2023 09:24:57 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:57 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:24 +0200
Subject: [PATCH 08/11] dt-bindings: usb: ci-hdrc-usb2: Fix handling pinctrl
 properties
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-8-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>, 
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>, 
 Zac Crosby <zac@squareup.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>, 
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>, 
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>, 
 Andy Gross <andy.gross@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=1843;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vuI+abY7emKvxqxwg2J7Vf5U+QSl3xD3cylxKBp47QM=;
 b=cA//QEaEi/GzH/ZTEpwNhEiym+hD656nG3IixPCS0Yi7t2cIiwxXA4DNzeydmsOVFuKJMXujb
 YnsymIapOVCBidELFNlYPj1ztQ+aNTLBST/+567mWks3T4NqajGgjOd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Untangle the bit messy oneOf trees and add the missing pinctrl-2 mention
to handle the different pinctrl combinations.

Fixes: 4c8375d35f72 ("dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      | 27 ++++++----------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 782402800d4a..24431a7adf3e 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -199,17 +199,6 @@ properties:
       In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
       In this case, the "idle" state needs to pull down the data and
       strobe pin and the "active" state needs to pull up the strobe pin.
-    oneOf:
-      - items:
-          - const: idle
-          - const: active
-      - items:
-          - const: default
-          - enum:
-              - host
-              - device
-      - items:
-          - const: default
 
   pinctrl-0:
     maxItems: 1
@@ -357,17 +346,15 @@ allOf:
             - const: active
     else:
       properties:
+        pinctrl-2:
+          maxItems: 1
+
         pinctrl-names:
           minItems: 1
-          maxItems: 2
-          oneOf:
-            - items:
-                - const: default
-                - enum:
-                    - host
-                    - device
-            - items:
-                - const: default
+          items:
+            - const: default
+            - const: host
+            - const: device
   - if:
       properties:
         compatible:

-- 
2.41.0

