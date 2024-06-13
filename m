Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054F12D203;
	Thu, 13 Jun 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307874; cv=none; b=i28bEkTz0KdDA0gADlM/SkO6CijSA2hq5kSw81lShUp5uuPLXpq4Qm4zYXfCpCMJ3ZakvIE2loRB/dSgU4PKuTJE1zzHyiCfv/PeV5/Zpyp69xlQ5awASe4rmYCnjkndT1++RQZ5SODOvjLgnRoMTMsqLeptrKh+LlNErVhLrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307874; c=relaxed/simple;
	bh=KKnENtOFfzWq7Cta8BnILeX+g2sXHNgkU21fCl2QK6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Vnve5oK4x+wMvnqBAnFEzp6ZEGy9m4pKe4FNYtPFdEq4xX9KP+x93hjrIGS1X7Ht2agk6J9qQUxddTMG773cTAI/jW488C2n6mjSq+4hi6kdmnhyv4NrKn7787AJBrGIToMPwO2XUlFPdadS4TTuy0LzeXD+JQJw8TrDRkbJwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m/2PQDJt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m/2PQDJt"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGMc8008219;
	Thu, 13 Jun 2024 19:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HnNm1gdtDKZ9IEeruyG/Kd
	EKveSE1/RzTpjO5vpnTeI=; b=m/2PQDJtH8L9yC2XLhTrNhDWoAFA71PgYxZEXQ
	Ksc7pLjAbMH465uFm3ys/J2iIXonTI7tEvOBOIxqTKNYP3XvG5brvDI93a2ls+7A
	aoaHg66PlsUK0xdaB4Nu3UG4Dz8QzDihvu5ZZ24j3XJoS61klF40J4H6YTK7KSvS
	2rdkh+FFQxa1pYiaLceCsF65D0PyKCOPk0IA/akmh5vvZQojIsN2sYa04IQhqf8c
	bNteIjWb1XaFRg00e+G99N7nSvmVpqpVq1knsm4Ym25OrWtKpSgyJj+YLaUPD5pM
	ZJsuRBxnlBTDTH9GumTCN0836XM+B6pZaely8ze1+zKs1ACA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q5821v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:44:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DJiJZX016419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:44:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 12:44:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 12:44:17 -0700
Subject: [PATCH] iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABBMa2YC/x3NzQqDMBAE4FeRPXfBaBDaVyk95GdbF5pYdmsQx
 Hc38TCHbw4zOygJk8Kj20GosPKSK8ytgzC7/CHkWA1DP9h+MiOmiE7SZDEKFxJFXlJaW3dFG8q
 IxozW3kOMwTuoYz+hN2/X0fNV7Z0SenE5zG3+y3ndMDn9k8BxnPjO+ViXAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IGjdS6aZAPw3l5LxvoVsknoC0qvZqfzm
X-Proofpoint-ORIG-GUID: IGjdS6aZAPw3l5LxvoVsknoC0qvZqfzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_12,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130141

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 315e487fd990..eea554dddaeb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -465,4 +465,5 @@ static struct kunit_suite arm_smmu_v3_test_module = {
 kunit_test_suites(&arm_smmu_v3_test_module);
 
 MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+MODULE_DESCRIPTION("KUnit tests for arm-smmu-v3 driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-113449cddcba

