Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E7257D;
	Tue,  9 Jul 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532399; cv=none; b=OrJqfFepwN33wAx8HcR67tP6i302Oh+851EmApIYVKdbyru5NXf9KjmoicZlgaHHwSLculA+y+pWu0UmLwvqP5Yoknrzy4aZxGuWyrcjvzU5jFwM/PM3bEnjaliTtqxkrDB2q3mB458WTPWpJdqcpfVOCJK8JrqMy/h12fzNeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532399; c=relaxed/simple;
	bh=pEqZPA3brG0X1DeQ/hKoP5t8PhQXhaH4bJOO1sjrisE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZfdUu7ydn68IHFK5gKUbig4JlRLf+IV80KuF9ZEriovyoKvUedSG7zQX6EZaxGf4bariCWmI43JUlNhy6IAIROsVxYPD0bV3nL2maCJII3tzRaiZbs3m9ljYZTaZZ4bMY0XQga3OiyZriILsAVs6QlFQ1pftgyw6AG2OxRz7j0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dOVs2VD/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dOVs2VD/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BjxWn002542;
	Tue, 9 Jul 2024 13:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UuAQd3i9NQXtfqcRgoA4dr
	2GW+khV0gNyh9TparQ09w=; b=dOVs2VD/uVETPCgHBRpEZg5aMO1/2yQAisYBgY
	uzzJpyvYjgaCVR0NQ2Zrbu+yXnYjqzKZHMETGaz0q6v/9zhCRVaZUkubgAcFZQvi
	yA46/EtrpPXK1wPdxubvWuVTm9xQUpxWhbZzP5RvPQYgKWUzTCDaAeV8ZlhwVLiC
	ueeoh4A8/fn2UI3uQsV97pDsXRBGtUiQSdSu4s6bOwY6+5sVgbm5Zn/ITP+JhmLe
	5PL7yR2Piak00CheINC1yC6dWnvPP3U2IBJ3qXKWKdN78L2/qAhulYi0F5UehBlg
	FOQX3232+huaBz+C0eP9Y/eK1QvJ1AOtSHIRMCA+nmS0gDnA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8xfwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:39:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469DdjEq019159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 13:39:45 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 06:39:39 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 9 Jul 2024 21:39:29 +0800
Subject: [PATCH v2] dt-bindings: arm-smmu: Document QCS9100 SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-document_qcs9100_smmu_compatible-v2-1-599161b7d5c8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJA9jWYC/zXNQQ6DIBRF0a0YxsV8sFbsqPtoDKGI+pMKCmjaG
 PdeNOnwvMG7GwnGownknm3EmxUDOpvALxnRg7K9odgmEw78ChXUtHV6GY2NctahZgAyjOMitRs
 nFfH1NlSU/FapVhcCapJuJm86/JyJZ5M8YIjOf8/iyo71f14AL0UJOWcVBxCU0XlBLaOxfafs4
 wBanacWafZ9/wGa9Y2RvAAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720532379; l=2893;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=pEqZPA3brG0X1DeQ/hKoP5t8PhQXhaH4bJOO1sjrisE=;
 b=ojdpUaq84qQ4Nt8snyVyOEvJQ6I+ui21dEczpz0lfFvORhtIViE4VTJViQPG/FuD/Dz6OF5N+
 /N2ysU+YHcMAGcJk8mea2ggQxlNC6P1Q7F8UihpCW7myNBZDY5uKqBk
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O_oSWRkSF8T_POK6t7yNNlWlNVMHVcgK
X-Proofpoint-GUID: O_oSWRkSF8T_POK6t7yNNlWlNVMHVcgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_03,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=850 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090087

Document the SMMU on the QCS9100 platform.
QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
platform use non-SCMI resource. In the future, the SA8775p platform will
move to use SCMI resources and it will have new sa8775p-related device
tree. Consequently, introduce "qcom,qcs9100-smmu-500" to describe
non-SCMI based SMMU.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Introduce support for the QCS9100 SoC device tree (DTSI) and the
QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
While the QCS9100 platform is still in the early design stage, the
QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
mounts the QCS9100 SoC instead of the SA8775p SoC.

The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
all the compatible strings will be updated from "SA8775p" to "QCS9100".
The QCS9100 device tree patches will be pushed after all the device tree
bindings and device driver patches are reviewed.

The final dtsi will like:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/

The detailed cover letter reference:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
---
Changes in v2:
  - Split huge patch series into different patch series according to
    subsytems
  - Update patch commit message

prevous disscussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 5c130cf06a21..82b7e1d40ce0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -36,6 +36,7 @@ properties:
         items:
           - enum:
               - qcom,qcm2290-smmu-500
+              - qcom,qcs9100-smmu-500
               - qcom,qdu1000-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
@@ -84,6 +85,7 @@ properties:
         items:
           - enum:
               - qcom,qcm2290-smmu-500
+              - qcom,qcs9100-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8280xp-smmu-500
@@ -385,6 +387,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs9100-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8280xp-smmu-500

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-document_qcs9100_smmu_compatible-85267adc3809

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>

