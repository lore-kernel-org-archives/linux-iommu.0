Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9941FBA
	for <iommu@lists.linux.dev>; Sat,  1 Oct 2022 03:06:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29130CPM013387;
	Sat, 1 Oct 2022 03:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RGpC6fmHRIxb19mjcXerenYDkDFpalYj3mMs42Rpy0g=;
 b=iOgA5ef2Kr8fxCxDvtwxZNAWFGWi6HCAiWfUCGylrGVkU1xi3YS8RzZrjfGmdqeXS7xn
 b40ZZgWMzq63/wxRQ1iKakKWZY+BaOXtSrFPGxGFz8wQr9o5k9/1QwwnzfDNxC57Fm0I
 Eu+AIzBvKPRASex0e2Nfuah8nhn/qAbZCAiWyqG1AtRx9iIze6yge3pExMc1AkRv/TID
 uU9PeHMjtf2gBnjhANPfgf2agSA5Z/uWP8plWbxefjDHbJrq76zpoRX7ca6z4AUjrm33
 u05AffzlZ//KGNqVgSdK9bHRGFDD4vM5/KagtOqAHbxsV6xRU7TLTUIGFxKxBetmVgyC 8Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwwfck4c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Oct 2022 03:06:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29136QcI004842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Oct 2022 03:06:26 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:26 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
Date: Fri, 30 Sep 2022 20:06:14 -0700
Message-ID: <20221001030615.29135-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030615.29135-1-quic_molvera@quicinc.com>
References: <20221001030615.29135-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 20pPW27O9Yx-nVzGjWWsGpGvRrolniGS
X-Proofpoint-ORIG-GUID: 20pPW27O9Yx-nVzGjWWsGpGvRrolniGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=783 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016

Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..681035b6e991 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -47,6 +47,8 @@ properties:
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
+              - qcom,qdu1000-smmu-500
+              - qcom,qru1000-smmu-500
           - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
-- 
2.37.3

