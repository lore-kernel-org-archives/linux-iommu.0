Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D36117
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 09:09:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J6FFWd027051;
	Fri, 19 May 2023 09:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=37fjXykXHh2BbT0SJTt8kyFq6d+NifX3IBh5wK3P9H8=;
 b=owUPAu2dvKUERGMO093T4bXogCmpzp1gD8tCvId7Q5D4Twi2HOFJcHE+UAVjRWLs96dj
 8wWIMxf7r4AhjJqjKzGN2fbF9XyRLPRNh9FrNkZPzA3mZQhWWUo5Gw/PtU2TrHQJGrZ7
 IVRatiH2yKGyZB5JekfwCb1+FvkB2rfnII1ttyDbVp7Ib+wMpocqykkDCu6mvLnPzbNs
 XkM2dGDe89EU9tnBWgj+Ik/VPGdCRXAa2k0b8/hVjzJl4sLPEMXvB8tWpaxWRZ0Yy0us
 N74jJREGaqqXZZahuK60AYmdOWC3x709utrVeOXMN0piHCzpRKFBxFCLkHDXOAtAe84g kQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnwk4gy90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 May 2023 09:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J98CEE030916;
	Fri, 19 May 2023 09:09:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qj3mm5591-1;
	Fri, 19 May 2023 09:09:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J99C9Q031608;
	Fri, 19 May 2023 09:09:14 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34J99D8d031636;
	Fri, 19 May 2023 09:09:14 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
	id 2B7DC5EB5; Fri, 19 May 2023 14:39:14 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 8/8] arm64: dts: qcom: Enable the QUPv3 UART console for SDX75
Date: Fri, 19 May 2023 14:39:10 +0530
Message-Id: <1684487350-30476-9-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pn2fq1MDc9yTIGJ2w2XxFJG8uQGwdy91
X-Proofpoint-ORIG-GUID: pn2fq1MDc9yTIGJ2w2XxFJG8uQGwdy91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=717 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190076
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
index e2e803b..e07c9e0 100644
--- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -12,8 +12,23 @@
 	compatible = "qcom,sdx75-idp", "qcom,sdx75";
 	qcom,board-id = <0x2010022 0x302>;
 
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

