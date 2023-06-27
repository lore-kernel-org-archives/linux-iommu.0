Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7C182AB
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:24:42 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so14280e87.1
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883080; x=1690475080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ay5CzniySnwEMooKVt/XOy1z9VfFqB2Jhn8qIwDw2AU=;
        b=pc1ltOmRM0YZYgZOi+g3p1/3rAqT0Q/AYh4yLt+KniBs5IdXvrwjPGmMqK5YTbxCnB
         xFEa8f8eSouuMDsImmQbpOi4CFsZHRb8dMe/581qn6WRKlbvVBluGK+Y5MKQcgRs3jyK
         0+p5RGW7p3bRBXvPM8s4iuiQJNtshbGS/jLgyHx8cKj4ro3LcucpEI+do6hqQmszEKla
         wN0hmUFciYaVoom4FsMVkpXFEkOUNjvK0xP8Zh9+bG8iCLzLdr4pI/Dr2moQcBAR60HO
         6qEFUf332HQDNFd6rdGLwBoEPrVYnH8l5iQJgFvcgGbf1VwyQHndGiRD//DXcMCVcw7F
         lu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883080; x=1690475080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay5CzniySnwEMooKVt/XOy1z9VfFqB2Jhn8qIwDw2AU=;
        b=Zemw7QyHjacUl1KXl0hRO+dd3Gp6txRI4jW6iCa/30mYYrr0lRGIzxKZBOPTgZO9WI
         ccbEAtjPLrMh0IPHI6K+yWFJWrRytpMiYZAm8d9r2P7f6Vmx8sUhvIT3zjxzIIFXH/xw
         tOLaHWfD7RRmFYSLGzmSxDcfjfqQ+ZvAX8Ro9wNfPdUb/5/MD0pNZ6V2pbh/8K/GMRJ5
         t/P+a1bNxdLmnuDBg4ync76Yf6IziepCapRz7jA1DJP5E2g3eYgxf2IxxoT9DLNpOILi
         BAxQM8v1424wE63IgYN2rOLGVl/UzC+YSdJOes1+tPOgrcep2BhSuc59pMNmDMHUuSj+
         1LEw==
X-Gm-Message-State: AC+VfDxtg1lSu3vPmE88QBIe1OWyGlUcEWc0Rb98qz6HoSPzCSrJwPv3
	0lh5iv/JclZ8C77xkYzRa4k0cw==
X-Google-Smtp-Source: ACHHUZ49YzKh1xHFKDTfmdAfCT+y7MRWyFEMO2kfF9W5tFQkv+4/HgwK3Tei8g4VbO1JOR8V88J7fg==
X-Received: by 2002:a19:4354:0:b0:4f9:56b8:45e5 with SMTP id m20-20020a194354000000b004f956b845e5mr6207966lfj.25.1687883080136;
        Tue, 27 Jun 2023 09:24:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:39 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:17 +0200
Subject: [PATCH 01/11] arm64: dts: qcom: sc7180: Fix DSI0_PHY reg-names
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-1-6b4b6cd081e5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=941;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qMPr5ji7TxiW7p+3tmhmdQkl5/eI9UsztKpO6YmgD0s=;
 b=MbgNEkJ4ywd3Nj8Je7BLfi3S0Ws+2ZSlBsN3swV7U0MpdhsVAYIeNsR07In2pvGOe8Wu+U3MD
 PgOYyCpmXUMAqmmRQTd/MAr5w0NCcApsYpskUCP32H0enI9VrE0eLfz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Commit 2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI
nodes") broke reg-names, possibly with search-and-replace. Fix it.

Fixes: 2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 34eff97f8630..b9640574e73b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3120,8 +3120,8 @@ mdss_dsi0_phy: phy@ae94400 {
 				reg = <0 0x0ae94400 0 0x200>,
 				      <0 0x0ae94600 0 0x280>,
 				      <0 0x0ae94a00 0 0x1e0>;
-				reg-names = "dsi0_phy",
-					    "dsi0_phy_lane",
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
 					    "dsi_pll";
 
 				#clock-cells = <1>;

-- 
2.41.0

