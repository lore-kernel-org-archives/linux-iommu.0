Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB6188934;
	Thu,  5 Sep 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565041; cv=none; b=JtnNNDyb+a1kqFkP7I1x50l5UU5yCt+NQ+aDN+j7oY1ILM2LwZ7+q991r6PNbLL77aG8Wkt64w90PjGMfLxdhukG7B2PChPZkJxpbbb18ag1uVRYTpGeA3zmJqBt0q6z6c5TV174OrbfEvHMp1GeSp683K/ZwSGs9E3XfVyRHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565041; c=relaxed/simple;
	bh=ZrVcEc8zgGxM2VbRT/vnCy4mz7nN9z945ULrr2MH/9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t/6NnBVM9IUqGLGrPGLr5G901fNsx4J0QweH1T0MK/0RGPatMb55W9uYHEA5PtTwIgPq8aYbrrQg/skgxMOoAz/+ZBmjlg+PmPY/Diu026+bZZTEFkLEEPnNyXFz/W6S/mElYkQHDgPkqt/A4IewEoWU+dBwDI6OlwERkB7qiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LnpTTPwL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LnpTTPwL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IPrIb021683;
	Thu, 5 Sep 2024 19:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6EVLbfF+xgNWv99XJIp75X
	GbIfaB2lG5Jv+ZnKb1JUY=; b=LnpTTPwLgvQWMUval5sm5QNck3b+YaKjTr1pPD
	cappOWiq6X88S64BJCfLpSUSLonhnRQh/7ErWP1lH4OArzgSb0gnuL9tKFdUFjeU
	EkTdtnthYuBxaHvqNx5FbgngEauk/5xZFy3pwRqTOoEa6ECsFU9UkPu15LxstWD1
	NBaAkcn2NcWvROo61CRQiAJNMCnP+qK+4JHvfWRIF0NJqMDF+9xtdcfJov2WZMGZ
	ePADtuMOHoWOY3IeZuYtp9jRe4yyBVWvZDXPOkgeBcDQIcSBT7pHhJX351HETvm5
	NQeLSJlXfZaVLcCZVhiu/zWwA5JbdxhILoTi8ZjHybhh4umA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhws04k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 19:37:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485Jb8aV024675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 19:37:08 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 12:37:05 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <will@kernel.org>, <joro@8bytes.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>, Nikunj Kela <quic_nkela@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: arm-smmu: document the support on SA8255p
Date: Thu, 5 Sep 2024 12:36:56 -0700
Message-ID: <20240905193656.3785537-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: GnigdQtiJ8CnozZJbWArhMUfAdnn9Tz5
X-Proofpoint-GUID: GnigdQtiJ8CnozZJbWArhMUfAdnn9Tz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_15,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=968 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409050146

Add compatible for smmu representing support on SA8255p.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---

Changes in v3:
	- Removed the patch from original series[1]

Changes in v2:
	- Added Reviewed-by tag

[1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 280b4e49f219..3353c2d37841 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8255p-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
@@ -84,6 +85,7 @@ properties:
         items:
           - enum:
               - qcom,qcm2290-smmu-500
+              - qcom,sa8255p-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
@@ -553,6 +555,7 @@ allOf:
               - marvell,ap806-smmu-500
               - nvidia,smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8255p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
-- 
2.34.1

