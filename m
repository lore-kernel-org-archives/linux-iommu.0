Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6719E73
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:24:54 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fa08687246so4695101e87.1
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883092; x=1690475092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apFUalLZyQqWq0aQwYgxypM+yPAfzDeJRJiPTT9OzgQ=;
        b=gPQ+01eM8GOGBERecL3B/NIxhQbrVmrrFXxYZiCCONOF7/F61cH5oZ4S7PViK0H9X3
         yXr/dkivL6tpoBinlyPIzXzeVhamwTu8Oo4+oDsjDo9mxhFy9Kp7iTj9zqBShJlvW5Sr
         3XZeOtU4fWRTMlxkBRNd1kkaaCf27QvN1bclNG3WoJmKIpIgQhZ03uKOPZvd7hIT0PGY
         azP7RD8WQQxDUWPpOCyYB/heKlw/sQWav43VkZQQ4ykMqIbGoZPA/wnM17Ra7uPnIX5m
         nrtp2FldB8AQvrSjYItV9pKqMHKA5lejbTU0yr8PwlU1APcwlIwpaSCeeMY7VuNPD0vN
         kayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883092; x=1690475092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apFUalLZyQqWq0aQwYgxypM+yPAfzDeJRJiPTT9OzgQ=;
        b=ONrn8Ixta/acbgec3ttd0Uokdjf7wAQ9iXqwPLclUQfkvV2Ice5Z6YxxdRBXVrzTlY
         wtcf4IusPvYkBghM1F5F3gnr9HhTlaV6Ujj9v6J2JKbIi1+7zq1HZUo+SP7oLyXF3v0s
         JT0jAn91a5evKzyeQReJsJaNLjbe+6iKMqbQ4OCswcrH4wWJmcujfagLlb8JN0kJG3fT
         JwpUDO08ZV4rBNLQ0LIkBeM5rpEPLzIpGNQSAyYylFyiikXu1YVmOButfygvtr1dB86L
         Ll0HNL9V6eL6F+FE3aKwmydLK00723NDWbvY2oTHVtrV2dy1yrm7zxJvG8YsbKVPKb2c
         vd9w==
X-Gm-Message-State: AC+VfDzhyBFlNDEpfCMEOwi4cq73kMbPrbN/5Ivj9quFog8bb6Ftb8nw
	fOF/rKwp2bfhAAUYhfuLa1qNOQ==
X-Google-Smtp-Source: ACHHUZ4atKHp3LY0BnQtuVG83sCZJ0bHCYAJTWN9stucrksa1utFdi1jhZ+5jdferRA74CWyuyxYjw==
X-Received: by 2002:a05:6512:234a:b0:4f9:607a:6508 with SMTP id p10-20020a056512234a00b004f9607a6508mr11552003lfu.50.1687883092611;
        Tue, 27 Jun 2023 09:24:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:52 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:22 +0200
Subject: [PATCH 06/11] dt-bindings: mfd: qcom,spmi-pmic: Reference pm8916
 wcd analog codec schema
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=878;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lErWU6dobB0XeId/RGdHSYC+Fh+f5HQU6i/ZQfWoHV4=;
 b=UL8UOKYocMxpJYoe0YJwzMhvxXtghVykIHjdlEGq50CZhtl1LLZ8LZLlN2lH90cJbYWcbYJLO
 QV9/CGe0uXSAFNUnoT8wQU4pN1dR03bjwZsdsXFzKbUyEu8A3n7SbpX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Now that it's been converted to YAML, reference the PM8916 wcd codec
schema.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index f473b2d820bc..b5ec8cecab6a 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -128,7 +128,7 @@ patternProperties:
 
   "^audio-codec@[0-9a-f]+$":
     type: object
-    additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
+    $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
 
   "^charger@[0-9a-f]+$":
     type: object

-- 
2.41.0

