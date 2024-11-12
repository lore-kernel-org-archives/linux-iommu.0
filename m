Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3511EBA19;
	Tue, 12 Nov 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371603; cv=none; b=KankFv/vR2LYmA1YhEmYXuLSWNEkWcgmZmvMOQzLfI9FZbl9hfZuO0uyjkVt7D8MHW24ZwpOWFJeFrlEtDEKw69QM1DVjpJLLtNpldO4HVcCnWLIIDZQIwYtrUd4ogRnfRznSK8ged1XyMKernNnuVp1O9v7dMKTafgFmbQNU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371603; c=relaxed/simple;
	bh=1V20m6WutqsenUT3QxI14EkCZxFfYVdNxuxW5vHrz5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPNSWk2GP91XDu3SwtVgMhRmZdayk4HHHpn+F8PEcOrW1RgbBOWVNBtJBxOXBklbPhAR5Mk1lCOE17r6QnwVQet1EgCruyQHBWqkAAXKQ73OWHMGRgw9ES/psA/EogV9B8InGdLf9NvgFPnynyO5zAAY9zwtzU4il6kaWLeLneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mht5CBp4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mht5CBp4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCOd9v004669;
	Tue, 12 Nov 2024 00:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nHCD7MrzIKXLGKUAWYVzqU
	7O/Rxc69UeBlTAwS4JxAs=; b=mht5CBp4JvufwzwD/5aQJIfEXXYurMQYlAlrSt
	BRS2gOau3o7N0SNSuqCvJ0b5fLl9PlCJDkhv1KAcIv/OunSzcQ+1jBGRqIov9PXv
	aec7KTJb8P1oVQvwotFuaIPHfbP04qk4AOMDxlipgDjqY1NdVf7f/JFpenxJmzbZ
	IWhNEong2BXw8OkgbeGapbbn2UzbZjU7QxPXWwA1imypuXeHpqKqlQ5uAE5Hu85w
	GBizTUSMBk7KSZzkflQNidqrm2HvAo7zIpVMCDfGVXM/JndbWZYxaS6Vttjoia5T
	hC+7yEfObRNCpjxqvDo+p7C7sIC+jcZG7VUMr1dOdX8tajvg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syy25mw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:33:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC0X9Z3001343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:33:09 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 16:33:08 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH v2] dt-bindings: arm-smmu: Document sm8750 SMMU
Date: Mon, 11 Nov 2024 16:32:17 -0800
Message-ID: <20241112003217.2806556-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2a-CffltxWMKfCCRC6LSwTLJHzBuusKc
X-Proofpoint-ORIG-GUID: 2a-CffltxWMKfCCRC6LSwTLJHzBuusKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120003

Document the sm8750 SMMU block.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
Changes in V3:
- added additional documentation for gpu and clocks
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index c1e11bc6b7a0..e4e067a2b778 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -61,6 +61,7 @@ properties:
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
               - qcom,sm8650-smmu-500
+              - qcom,sm8750-smmu-500
               - qcom,x1e80100-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
@@ -102,6 +103,7 @@ properties:
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
               - qcom,sm8650-smmu-500
+              - qcom,sm8750-smmu-500
               - qcom,x1e80100-smmu-500
           - const: qcom,adreno-smmu
           - const: qcom,smmu-500
@@ -550,6 +552,23 @@ allOf:
             - description: GPU SNoC bus clock
             - description: GPU AHB clock
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: qcom,sm8750-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: hlos
+        clocks:
+          items:
+            - description: HLOS vote clock
+
   # Disallow clocks for all other platforms with specific compatibles
   - if:
       properties:

base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
-- 
2.46.1

