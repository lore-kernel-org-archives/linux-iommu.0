Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DED468B
	for <iommu@lists.linux.dev>; Fri, 14 Oct 2022 22:11:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EIEkIM025394;
	Fri, 14 Oct 2022 22:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=TJKmgContc5J9yP+bO3coRr7Klyhzh9MViymVPMsuWM=;
 b=TEECUlcbtC9E43gTZtDaqCMj0ZR5WZMSFIwkbgLdY8EPjN07Fn4ip1Syr2JPj73v99B/
 X9hXzKfUufdD5aCbTVtsJau6IxLJ9Bve8Rm3hw4c9jrXfUw0RSlIlLx3viNJ+Q6nx5dt
 9mThrlpkn7ASpi2ExQukmJGP5N8pPifR7pWRdZ/U4zInNdtvjOFlR9/L36DY36dKpkPO
 CSegHNwVRuji9ifX4BJQZLgEz11CL5nAnXiFs2ux8+R6Uhj+Y5ucDT+Ub6ik7WyIbayC
 9ayzG9z23+BuNVEbTTfxlv5uMPECioI8e9YOAU9aUrtCfrYDqGS+Hf7MlpPwpXKLSbIT hw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6mkdwmc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Oct 2022 22:11:13 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EMBCiE005979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Oct 2022 22:11:12 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:01 -0700
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
Subject: [PATCH v2 0/2] Add smmu support for QDU1000/QRU1000 SoCs
Date: Fri, 14 Oct 2022 15:10:49 -0700
Message-ID: <20221014221051.7434-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
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
X-Proofpoint-GUID: ePb0WeGlXDHEd2C5KzVDMP8x-3_z0M_6
X-Proofpoint-ORIG-GUID: ePb0WeGlXDHEd2C5KzVDMP8x-3_z0M_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=725 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140122

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


base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
-- 
2.38.0

