Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7A1FBA
	for <iommu@lists.linux.dev>; Sat,  1 Oct 2022 03:06:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912xmRR016155;
	Sat, 1 Oct 2022 03:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=LvYX92iA8W5zIDxrKDV9ZXR8GDdN1lIFNID1nX8ILQs=;
 b=lwqhEqu4B+omkKFjwOL9EYSuSaXEhucWh8eyrKwgQGGL2x37damcLb5BXXYuvQAIWJVu
 1CuWd16n5nUNrVxPdUFmwOxv07OIgPIkKlrHXxPUDsJmRspJp9tlnFZi93ISjhZ1FuGY
 8vqjv37dx8gv0lzg+HMlXAM2HDI7b7//4sPZgYOYqmQgO591d8Agu9Sc/FRxuy3+gCP0
 Ytu9w45IDBY0CQlTg+R2E1lGQDk12aRTdFwLTtOajRcgbHzDAU41MhkNkAhAkzewsi4C
 KV9dmkArsN72AnLMWzA/FlhYVHf7jxLGa8fnMhrLOd9IuLovAj0MNX+qmzyOvbfQNOeB wg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxcjf81ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Oct 2022 03:06:27 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29136Qtb024716
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
Subject: [PATCH 0/2] Add smmu support for QDU1000/QRU1000 SoCs
Date: Fri, 30 Sep 2022 20:06:13 -0700
Message-ID: <20221001030615.29135-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
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
X-Proofpoint-GUID: 9LEDh4ixXCTjPxtSEnOquNscz1cUXDwu
X-Proofpoint-ORIG-GUID: 9LEDh4ixXCTjPxtSEnOquNscz1cUXDwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=728
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010016

This patchset adds smmu bindings and driver support for the QDU1000
and QRU1000 SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Melody Olvera (2):
  dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
  drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 2 ++
 2 files changed, 4 insertions(+)


base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
-- 
2.37.3

