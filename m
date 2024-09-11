Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D137E583;
	Wed, 11 Sep 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039172; cv=none; b=DWrMjsSm/wUorAKRt5DdYWYxuAsU4tnT8Cu2VhJy1Qy0/Lp4l+hAsaWND/6VX0KurUbLrK8NRNIyTZxYXpr0HpkzaLVFLM0PwDi++9WslGBDsFdOntKkediM44Lec2+ZaMdxsA48ctirZsr82sVerRTq/DQN700OP4KFs6eKcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039172; c=relaxed/simple;
	bh=6nJHCvuSeKfYgR+c3gFWZ9xqe7kVNcM/ylb6evPokUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HrDrPxbsIG/O4IQz5YfXuz20nY60reNdVuJucYX2pwZUlIlwFhnSm/eD8OPb8MSOFF6aue90cqdIVqN6PNCQYB9Rrera7zpq/Mmxce0TiMZVVuWBRCNlyqGN0egfidVF5B6WE/XSut1S5dPNi50N2G8Eb2T2gaduiZtjh1fB3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tr0YPNVV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tr0YPNVV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B40iJ2019866;
	Wed, 11 Sep 2024 07:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OvyV2pptz2V8Zxp3XagmP/
	XnZRiX1AExeyCxbeYAsdk=; b=Tr0YPNVVNlS24ccQWr+Re4q9BcXkjiVclj4FjY
	9Bkg/OXIxmpJMD6AV2nnIzG5h72rFSTv+Cq46WPu3djfyeacD7zw8aJHNXtq3dV5
	cKQG2N7SfyaO/Isaia9LZk+7NF3G5FKcakPBl/DWEtpVSwOSY6Q5N8VJxsElyk2Q
	lKM/dO7v+KLAI/OZognOSX3p2wPUuaEE8mE+7PRVocxeOIWYRGbBTCZ4ehBtKxwC
	pgDAgzdCGDcH8AIz2w2NoU/dOWR3vrk2/xkzxsEGQZjAO01kZwuJ/4i1Zj0Ma1/0
	R6NqTDzWk8lq3KeZ18u/P8PVbNIXuuSP08HCo3QmwhDGEAaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5a0qe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 07:19:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B7JDsB011037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 07:19:13 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Sep 2024 00:19:09 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 11 Sep 2024 15:18:54 +0800
Subject: [PATCH v2] dt-bindings: arm-smmu: Add compatible for QCS8300 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240911-qcs8300_smmu_binding-v2-1-f53dd9c047ba@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF1E4WYC/z2Nyw6CMBBFf4XM2popj2hd+R+GkDptYRIp0gLRE
 P7dSozLc5J77grRBrYRLtkKwS4cefAJ8kMG1GnfWsEmMeSYl6ikFCPFc4HYxL6fmzt7w74VylF
 VVg4VFQhp+gzW8WvP3urEHcdpCO/9ZZFf+wti+Q+y54n1ozFTZLFIgcKg1Uo7Q4in6zgzsacjD
 T3U27Z9AMTiFNG6AAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <quic_tengfan@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <quic_tengfan@quicinc.com>,
        Zhenhua Huang
	<quic_zhenhuah@quicinc.com>,
        Jingyi Wang <quic_jingyw@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726039149; l=1583;
 i=quic_jingyw@quicinc.com; s=20240910; h=from:subject:message-id;
 bh=5iT9XBBm4MX1s4p0OKxkZw5uiAeYhuvFO5Tl6RLIvpA=;
 b=8yaMsiriaRHRAbp0vphHEQpZIgoJwvlmmhrra4Vt2e4z1/l1Zq1donJY8AGHHSYXRPO6JP/zK
 81jIU1ITy0UBBhgq/0n9wTliwt56pfVimdvXI9zqNvsx6q7RN6lMhXg
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=ZRP1KgWMhlXXWlSYLoO7TSfwKgt6ke8hw5xWcSY+wLQ=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7sX-Gom7MdvxFAyDdrM4IAPs9vC4DTWM
X-Proofpoint-ORIG-GUID: 7sX-Gom7MdvxFAyDdrM4IAPs9vC4DTWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=862 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110054

From: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Qualcomm QCS8300 SoC includes apps smmu that implements arm,mmu-500, which
is used to translate device-visible virtual addresses to physical
addresses. Add compatible for it.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
Changes in v2:
- decoupled from the original series.
- Link to v1: https://lore.kernel.org/r/20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 280b4e49f219..a848ad2a2106 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -36,6 +36,7 @@ properties:
         items:
           - enum:
               - qcom,qcm2290-smmu-500
+              - qcom,qcs8300-smmu-500
               - qcom,qdu1000-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
@@ -552,6 +553,7 @@ allOf:
               - cavium,smmu-v2
               - marvell,ap806-smmu-500
               - nvidia,smmu-500
+              - qcom,qcs8300-smmu-500
               - qcom,qdu1000-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sdm670-smmu-500

---
base-commit: 100cc857359b5d731407d1038f7e76cd0e871d94
change-id: 20240911-qcs8300_smmu_binding-9fc545f09c30

Best regards,
-- 
Jingyi Wang <quic_jingyw@quicinc.com>

