Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DA23776
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BPJBVjx0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3LbPNc017492;
	Fri, 3 Nov 2023 21:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=L1gf4SE0cotgosJUEiy6yyXLDrfDlqrR65MXeq9+/EQ=;
 b=BPJBVjx0r268tH9SosMFM3Ie/nSCZcenCqpMwSEh6+ItoexCwe9G0eAuU1Di9dqntwcQ
 HsyBGOcCRA4pi7m8ifS5pkZvTt1hBKlIYo7mKnJs0nC9t/pIHU2Vat3USAR276lzwwc4
 F/KomMfgqvMUPPLAmaE3G4yRLhawMOIlehZgn0ORJZ2m7a1PnKnZi9yEDNJgPShRB3rL
 tAAJCByBc+9p90HwaIaoiYTPco+9Noo295QS/nlD3wwWShemuJt/rfVD+k2c0e7oNcYh
 0RQZao36u2ij8pJFiOxqfRMOoFakPRbtP1MMgiBazE6ACc+aKPhrDTCCN0gbRPc26AgQ TA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4cw9ukym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Nov 2023 21:53:26 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3LrPMh027221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Nov 2023 21:53:25 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 14:53:20 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_saipraka@quicinc.com>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>,
        "Bibek
 Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH 0/3] iommu/arm-smmu: introduction of ACTLR implementation for Qualcomm SoCs
Date: Sat, 4 Nov 2023 03:21:21 +0530
Message-ID: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B1flFjoFBxgkLDveYWnb16GOolpjwtXn
X-Proofpoint-ORIG-GUID: B1flFjoFBxgkLDveYWnb16GOolpjwtXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=552 spamscore=0
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030185

This patch series consists of three parts and covers the following:

1. Introducing intital set of driver changes to implement ACTLR register
for custom prefetcher settings in Qualcomm SoCs.

2. Adding ACTLR data and implementation operations for SM8550.

3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
settings during reset and runtime suspend.

Link to discussion on RFC posted on ACTLR implementation:
https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/

Bibek Kumar Patro (3):
  iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
  iommu/arm-smmu: add ACTLR data and support for sm8550
  iommu/arm-smmu: re-enable context caching in smmu reset operation

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 143 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
 4 files changed, 146 insertions(+), 9 deletions(-)

--
2.17.1

