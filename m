Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7656748F
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4C0642021C;
	Thu, 22 Dec 2022 20:33:26 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
To: phone-devel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Lux Aliaga <they@mint.lgbt>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 3/4] arm64: dts: qcom: sm6125: Add apps_smmu with streamID to SDHCI 1/2 nodes
Date: Thu, 22 Dec 2022 20:32:53 +0100
Message-Id: <20221222193254.126925-4-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222193254.126925-1-marijn.suijten@somainline.org>
References: <20221222193254.126925-1-marijn.suijten@somainline.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling the APPS SMMU the mainline driver reconfigures the SMMU
from its bootloader configuration, losing the stream mapping for (among
which) the SDHCI hardware and breaking its ADMA feature.  This feature
can be disabled with:

    sdhci.debug_quirks=0x40

But it is of course desired to have this feature enabled and working
through the SMMU.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 347665c2067c..32dd172ea104 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -468,6 +468,7 @@ sdhc_1: mmc@4744000 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0x160 0x0>;
 
 			power-domains = <&rpmpd SM6125_VDDCX>;
 
@@ -494,6 +495,7 @@ sdhc_2: mmc@4784000 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0x180 0x0>;
 
 			pinctrl-0 = <&sdc2_on_state>;
 			pinctrl-1 = <&sdc2_off_state>;
-- 
2.39.0

