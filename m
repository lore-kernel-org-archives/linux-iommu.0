Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4123C02
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 07:52:16 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E3SNtY014830;
	Tue, 14 Feb 2023 07:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9GrxfxA2VdNXLWeh0G5XtENwzF67JKm/LBLej8FHykE=;
 b=Z7+r46LDQh4SAKw5gdj2sUwsoxHFDAdWsNJ9Xrqpg6Nj2KzpQCpMoPunGU4jeKf6Yjnx
 Hz89mXC5ZhR/NRXlR5S2QcXAKGM73JoFXtY32kNOGWke9z8XreouxKUwvmjtEz1DYDns
 O9PW+uekD77puFzBsNNEuwqvE9d84QqM6JiZykM3jkLzORhRMvYBApbZWdSfClGRmsDy
 qtXf5lnsa7q4tB5xBu5XP9nkbWGoB3T8IZrNHCQDe2OUfW5mf7iEXsh+OBe6o5KyYeOo
 Z+aePvlIzA4XKdHIA4BGgz+R2YT0Bdu3fRUjjD1qby2lJ1UEEUG0mep19wkUDSfJtXcy oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsusbc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Feb 2023 07:03:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E73rTu025682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Feb 2023 07:03:53 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 23:03:52 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: Zhenhua Huang <quic_zhenhuah@quicinc.com>, <iommu@lists.linux.dev>
Subject: [PATCH] iommu: Fix potential concurrent free issue
Date: Tue, 14 Feb 2023 15:03:34 +0800
Message-ID: <1676358214-25732-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uhPWAQGkJ_zWEf5KeFeOM-JW4nQOj5lz
X-Proofpoint-ORIG-GUID: uhPWAQGkJ_zWEf5KeFeOM-JW4nQOj5lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_04,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302140057

Some cases in which probing with a non-iommu bind device,
we saw dev_iommu_free() called in the same time. Add checking
to avoid NULL dereference.

One path was with smmu driver probing:
[    0.538555][  T165]  dev_iommu_free+0xa0/0x198
[    0.538557][  T165]  __iommu_probe_device+0x244/0x2e4
[    0.538559][  T165]  probe_iommu_group+0x38/0x54
[    0.538561][  T165]  bus_iommu_probe+0x70/0x37c
[    0.538563][  T165]  bus_set_iommu+0xcc/0x1b8
[    0.538578][  T165]  arm_smmu_bus_init+0x38/0xd0 [arm_smmu]
[    0.538592][  T165]  arm_smmu_device_probe+0x630/0x6d8 [arm_smmu]
The other was with device itself probing:
[    0.529488][    T9]  __iommu_probe_device+0x244/0x354
[    0.529490][    T9]  iommu_probe_device+0x44/0x460
[    0.529492][    T9]  iommu_bus_notifier+0x44/0x160
[    0.529494][    T9]  device_add+0x9f0/0x12a0
[    0.529497][    T9]  of_platform_device_create_pdata+0xc8/0x168
[    0.529499][    T9]  of_platform_bus_create+0x1b0/0x254
[    0.529500][    T9]  of_platform_populate+0x9c/0x114
[    0.529502][    T9]  devm_of_platform_populate+0xb4/0x118
[    0.529507][    T9]  pmic_spmi_probe+0x108/0x140 [qcom_spmi_pmic]
[    0.529511][    T9]  spmi_drv_probe+0x70/0x140
[    0.529514][    T9]  really_probe+0x3f0/0x8dc
[    0.529515][    T9]  driver_probe_device+0x1b0/0x230
...

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 drivers/iommu/iommu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 42891e5..30f8d8f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -276,12 +276,18 @@ static void dev_iommu_free(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
 
-	dev->iommu = NULL;
-	if (param->fwspec) {
-		fwnode_handle_put(param->fwspec->iommu_fwnode);
-		kfree(param->fwspec);
+	if (!param)
+		return;
+
+	if (param == cmpxchg(&dev->iommu, param, NULL)) {
+		if (param->fwspec) {
+			fwnode_handle_put(param->fwspec->iommu_fwnode);
+			kfree(param->fwspec);
+		}
+		kfree(param);
+	} else {
+		return;
 	}
-	kfree(param);
 }
 
 static u32 dev_iommu_get_max_pasids(struct device *dev)
-- 
2.7.4

