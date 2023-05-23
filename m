Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891A15A4
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 01:05:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N0qCFD029898;
	Tue, 23 May 2023 01:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=kk+v2BXrM1HdfwQCv/50x3jHzLeUveWiQIgeamulje0=;
 b=mqjzwyilgNZm6NFZF93VBVDenn2EwXe5ku7JjHwCFmmhh1YaWv49jlFvcbDRYDvllOUj
 pwEYPc019E5sFZTIckWZzCFOl8uPBOH08ywLhapDsQxEMUX3HAxNa8RRCTdn1f5IGBHp
 JAO8agCDZDhWVx291oZu3rWP1qUhqUd7geNtQQcclS2JDyc1fImEN8W8M2eF8qPtivhh
 76rg4vr8GZI+EdHKOTPP6ILlVZxdQ5YxJcigZhnYm+h+fTHkozNTTXojSgGEj4vM/qDu
 mOIvNiyEVzgjJnvEIwLOHgT2l68L/lcPK3vfNKZkhDBtDF6NJ4ikqzTDqyc3al0DXY1+ sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkwmw6b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 May 2023 01:04:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N14lbS004543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 May 2023 01:04:47 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 May 2023 18:04:46 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: arm-smmu: Fix SC8280XP Adreno binding
Date: Mon, 22 May 2023 18:04:41 -0700
Message-ID: <20230523010441.63236-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: veIkmCiM05s-ynKUwcIx6ATgx98dA0Ea
X-Proofpoint-ORIG-GUID: veIkmCiM05s-ynKUwcIx6ATgx98dA0Ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_18,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=902 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230006

The qcom,sc8280xp-smmu-500 Adreno SMMU binding has clocks, so fix up the
binding to allow this.

Fixes: 38db6b41b2f4 ("dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ba677d401e24..6cb04f35642a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -80,6 +80,7 @@ properties:
         items:
           - enum:
               - qcom,sc7280-smmu-500
+              - qcom,sc8280xp-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -331,7 +332,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,sc7280-smmu-500
+            enum:
+              - qcom,sc7280-smmu-500
+              - qcom,sc8280xp-smmu-500
     then:
       properties:
         clock-names:
@@ -416,7 +419,6 @@ allOf:
               - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
-              - qcom,sc8280xp-smmu-500
               - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
-- 
2.39.2

