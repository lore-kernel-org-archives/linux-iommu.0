Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B5182AB
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:24:49 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso6364816e87.2
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883087; x=1690475087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCywy6cYyFYFI8kb//sHM+EK5WqBRRu8/iqRaDkQ84M=;
        b=XyWyHIoH2Ze407Yj6nB28IeDN1CDtgfv8AZnJhnbW2U++0ntJoYl3/QVHOKlr0ugmN
         o6vqww24W07lweLE9ksjl1AFLoMK4ShQBmEr1zNIq0EoyAnN9vej5YV2E951JkQg/mj6
         f2be8GMogkEAs23/fSmFJvgtXz/EWJRnx72oJgzg7t4GlH7aGGXtbYQyLDT7IEdCqSqo
         DVYVJAMNjin1r7Ia2V7ZXhY5pJcfcejnwajh9n3V0xWXb6BLAr6EsO0FSIo+81Lam1J+
         dX9zLDenkoPZH6PhWyeFQ7e6lwaX3pCRTuLZDTvb0GJrasYd9Ow7d4TVrxni4hfHa5GJ
         x6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883087; x=1690475087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCywy6cYyFYFI8kb//sHM+EK5WqBRRu8/iqRaDkQ84M=;
        b=KTvEwVMpc0SafVuDhBTRXxf6hgQovz50lDm1m73NH0qhqkUo2NUIe53nRlQKyOCnxi
         7Dw4q33m2W+vHHY0vOirF/Vramy1CWvSKmw2KUm0SopFmz3k8ebnW0bUgeVxLPDUI03G
         jH3n5UX9nMKN9OVh/ii950bTYfzz3R5w2UkKCNvA8vVr4qujK3nU8Dsi8rlybklLT3u+
         7Jcxft7HxGXwFC1616Aitpz93e0C0SJlQBZ0WwKPmzdnvuDhix2+MycctOKfgx6Vj3Z1
         TgCRDneKKvItRKydy1gfP+11kQKypyhP+3fk5Pp536sM2N9gKZpdoq+57pIXmxymy9O4
         ++aA==
X-Gm-Message-State: AC+VfDzemTDm3PqqRCYIBin+aY462uxuQI37/H+3bddQDOjioimvn2x2
	7V2P3PelhoRO6YEx04gFidTdpg==
X-Google-Smtp-Source: ACHHUZ6LwrqrxKXfB30IuTt/FkjnhAznIHKgmo2XPru91QszdrHpLXOaCrfYFLxXQmjHKGnPvCbFNA==
X-Received: by 2002:a19:4f52:0:b0:4f8:66e1:14e3 with SMTP id a18-20020a194f52000000b004f866e114e3mr15836081lfk.17.1687883087477;
        Tue, 27 Jun 2023 09:24:47 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:47 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:20 +0200
Subject: [PATCH 04/11] arm64: dts: qcom: apq8039-t2: Drop inexistent
 property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-4-6b4b6cd081e5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=689;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=apph7LSM6ElNjbIp4Sa6AEpFAvPu59qNl9eL4vnUenE=;
 b=LRBHRbniws8u4a1P+s6dSMgJ58xXojZSxnIPFilY8FRHxj7kwk+9c9/vrMndrQrYkMe6HLBA1
 qsSb3Hqz11BDWo/hVkufLbnuhTmhrQ/zLN4kTfHuIj/Obe2lz0rA+wR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

'pin-switch-delay-us' is not used anywhere in the mainline kernel.
Drop it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8039-t2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 43686bbd87f4..027d1da7e81d 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -374,7 +374,6 @@ &usb {
 	pinctrl-0 = <&pinctrl_otg_default>;
 	pinctrl-1 = <&pinctrl_otg_host>;
 	pinctrl-2 = <&pinctrl_otg_device>;
-	pin-switch-delay-us = <100000>;
 	usb-role-switch;
 	status = "okay";
 

-- 
2.41.0

