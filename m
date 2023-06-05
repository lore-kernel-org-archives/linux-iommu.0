Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDC22601
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 16:29:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355EnxhX029435;
	Mon, 5 Jun 2023 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Um0jXPmzfz8X6AlUexSS8hFBMbgin25gC7YTQI7fI5k=;
 b=OsJxfc/WiYkHAfJnLxEYhpiwai3dewUlK57T7ld2+ZLakcaBUNqYtn/MqilWE809ktcS
 Wejn2IvfaPaBmHI8Zx0ydvB9mzWIKHz/LU/PYjWnPXDNVrgAqJUyZPTM4XXIvqSTjWiZ
 JK1QBx3zssghSl+iNVi4WOjPvCf0Lq5oCl6OSx9w9NShsp+sMiBZH8Z0dU41+GhtX/fk
 aE+oyF2ZQi71qjAV0Hp8ja3lv4CTSZoWadVa2gmPjGHezb47PPxwwRMgbzKsHDaQ61ja
 2HAU202rLbw2YpDWkw6Qhu0QUcEIw9oMOSDDCNgN4xHwdd2kERwVCHXTvJJKm1lwss9v Tw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyxtdm7js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jun 2023 16:29:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 355GTLYO030415;
	Mon, 5 Jun 2023 16:29:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkkq42k-1;
	Mon, 05 Jun 2023 16:29:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355GTKB7030358;
	Mon, 5 Jun 2023 16:29:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 355GTJrY030350;
	Mon, 05 Jun 2023 16:29:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
	id 938A85F1F; Mon,  5 Jun 2023 21:59:20 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, mani@kernel.org,
        robimarko@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 09/10] arm64: dts: qcom: Enable the QUPv3 UART console for SDX75
Date: Mon,  5 Jun 2023 21:59:16 +0530
Message-Id: <1685982557-28326-10-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c0d7Rc81nBMCymIXBxjh4hJB0TviOA_x
X-Proofpoint-ORIG-GUID: c0d7Rc81nBMCymIXBxjh4hJB0TviOA_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=727 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050142
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Enable the debug uart console for the SDX75 IDP board.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75-idp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
index 1e08f25..cbe5cdf 100644
--- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -11,8 +11,23 @@
 	model = "Qualcomm Technologies, Inc. SDX75 IDP";
 	compatible = "qcom,sdx75-idp", "qcom,sdx75";
 
+	aliases {
+		serial0 = &uart1;
+	};
+};
+
+&chosen {
+	stdout-path = "serial0:115200n8";
+};
+
+&qupv3_id_0 {
+	status = "okay";
 };
 
 &tlmm {
 	gpio-reserved-ranges = <110 6>;
 };
+
+&uart1 {
+	status = "okay";
+};
-- 
2.7.4

