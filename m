Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF66118
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 09:09:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J7cfbd028020;
	Fri, 19 May 2023 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DQPs8BiKs6OLWEc2OAHfMViDYAdn8QVV6w92/iqL6ZU=;
 b=RgCdleiP8kHMAOE+hPLvz/SVvFKPsdyfTt8FR5w+q8YS4ioLytvPP+zgbXgf5nowBxx4
 QoZyd7h+yQAi003/smolNUS7GwnZpuMZ0JlIeqFdPj4UiJyFkZrQuDcthJQCtWAma3YJ
 YM3Vg/vnuWOo47i0EBhepAyd2zFSZZlfs0mDrcTfCV4OZMBGbvuv4gmJvvte9AlZ7Jro
 yuSXPKs1C8qzsSCYKE/lAP1VNoI/R0bvC4bkdf1VS8x856pcDjZDAzyGfNsJYtzgMYhW
 gpWkDHExlwn1YVsY2nFRxzZ/lFr7NLVpJr+508yLOSMlvVs5GZxdQ3CAdwDuevBX6Ykm gg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qned33512-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 May 2023 09:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J96w0Z030160;
	Fri, 19 May 2023 09:09:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qj3mm558x-1;
	Fri, 19 May 2023 09:09:14 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J99DLg031654;
	Fri, 19 May 2023 09:09:14 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34J99DX8031644;
	Fri, 19 May 2023 09:09:14 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
	id 811FF5EC7; Fri, 19 May 2023 14:39:13 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 7/8] arm64: dts: qcom: Add QUPv3 UART console node for SDX75
Date: Fri, 19 May 2023 14:39:09 +0530
Message-Id: <1684487350-30476-8-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gVb_Fwml5K2IV3gOoo7tfQJ4aW1gkMU_
X-Proofpoint-GUID: gVb_Fwml5K2IV3gOoo7tfQJ4aW1gkMU_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=831 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190076
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add the debug uart console node in devicetree.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index dbbd2f4..ca467f9 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -385,6 +385,34 @@
 			#power-domain-cells = <1>;
 		};
 
+		qupv3_id_0: geniqup@9c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x009c0000 0x0 0x2000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb",
+				      "s-ahb";
+			iommus = <&apps_smmu 0xe3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			uart1: serial@984000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x00984000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&qupv3_se1_2uart_tx_active>,
+					    <&qupv3_se1_2uart_rx_active>;
+				pinctrl-1 = <&qupv3_se1_2uart_sleep>;
+				pinctrl-names = "default",
+						"sleep";
+				status = "disabled";
+			};
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -413,6 +441,27 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
+
+			qupv3_se1_2uart_tx_active: qupv3-se1-2uart-tx-active-state {
+				pins = "gpio12";
+				function = "qup_se1_l2_mira";
+				drive-strength= <2>;
+				bias-disable;
+			};
+
+			qupv3_se1_2uart_rx_active: qupv3-se1-2uart-rx-active-state {
+				pins = "gpio13";
+				function = "qup_se1_l3_mira";
+				drive-strength= <2>;
+				bias-disable;
+			};
+
+			qupv3_se1_2uart_sleep: qupv3-se1-2uart-sleep-state {
+				pins = "gpio12", "gpio13";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
 		};
 
 		apps_smmu: iommu@15000000 {
-- 
2.7.4

