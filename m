Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2481ACA2
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:25:04 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so4421957e87.2
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883102; x=1690475102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQgv+M2yvcOQU4FeOLMklrteeN9rCIkhqHWc6b1bMlw=;
        b=kDAt9Yy2OlLY6IWaIgh8Bk9OfVdK25RlsrNuwLLMtXXbG397TVa8a3J+BE2Rthx19v
         ohLNC/e5SJMBYIIx9zS2sFd/JWPzMOHoJq33iJVFsCwitbawpcYQxHixGIODdZjNyoBa
         ZzskP4FEFk2ilEFEAaixuyH1WQha+2ExAWd6CEgTK1Y9lQ77j2gYVGYys3ECidK9mrHk
         nvJj+DSJ2Zxm3GEMajsX81wBQieJ1d4ahWo9QmqJRXHZlDJLhMcjLkakBY8kA8KmjYwC
         VFI7sMK3I0eHGPSZYa3fQRAeFm0je1CrG0P0NoPv5kecifNBI9VjBaa7iVbD/OGDkCea
         ax8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883102; x=1690475102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQgv+M2yvcOQU4FeOLMklrteeN9rCIkhqHWc6b1bMlw=;
        b=EV+O1ACy5KlqQcJsp/uHKJnQNVLq61NsaQ4iDdDFp5wM6LviMPDswnVF1mDsiNmZUX
         GvKSfkn1W9QmKZhKIX5/msM8BCAWITBoWfzqJ4DQ0UbWMomSMalFDj4hABbWpZsUDx9y
         4p8uAu82DUW6isb4uH97guiBQkulm2tcOJ0O9gdBr5mw4ptYC8yTzJW2CtL+/4M9YEhf
         VUum9GYvEXpXE5382uPfVqGJ4P3hWiPQEJZJPCUOGvL/5NKyrrlXAPGEXrknyf6vx2/O
         jWD/aAOSGcEd5Usa65KUYgoe1sTIX76a4pkp2Y6YyfQ7DVIbNJwNKlb2rcYdZDrylbGZ
         v4Og==
X-Gm-Message-State: AC+VfDxhT7EInmUK9AdoayiY9ciTFo9ZumrG9nv7I0V/qXbTinIzzcZn
	kS2mTyVWGFOXJLF811m3QLmPkw==
X-Google-Smtp-Source: ACHHUZ5yApBC4INNLgHvtxRRdunBBs9+0RduUnvVu4BrnfQlBcgFBMr/Gb/6J5qgvmBXvYAWuE6Fvw==
X-Received: by 2002:a05:6512:3c9e:b0:4fb:7be5:46b3 with SMTP id h30-20020a0565123c9e00b004fb7be546b3mr3902801lfv.55.1687883102401;
        Tue, 27 Jun 2023 09:25:02 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:25:02 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:26 +0200
Subject: [PATCH 10/11] dt-bindings: usb: dwc3: Allow just 1 interrupt for
 MSM8996
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-10-6b4b6cd081e5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=1056;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uv1qnNvLB8G/rnBdtPGJ5lEE8zxGk1cKOrp6LALI2o0=;
 b=CbB0RfIBkaHhb6P0sSoQoxoKLH0+Nroq3t9sxL+VfHWMFB3r3IxNmJNLNTbVFLUIegbeAFWQG
 oue2RQYT9w3Ch9MjHPlF80d7+kumlsNMxdRcFp2gCaZ4O5ae5p95yJx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

MSM8996, similarly to SDM660 has two DWC3 controllers: one for SS and
another one for HS operation. Allow just specifying the HS interrupt
in the latter case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index aca20aa8f504..beaeba47a150 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -394,7 +394,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8953-dwc3
-              - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
               - qcom,sm6115-dwc3
     then:
@@ -411,6 +410,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8996-dwc3
               - qcom,sdm660-dwc3
     then:
       properties:

-- 
2.41.0

