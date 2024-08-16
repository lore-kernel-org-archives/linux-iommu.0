Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376E1C2339
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830230; cv=none; b=LXTtNY8EDAAyJIv5Z75+gRBpc1PT57lDcxRwWB6VruxJiI+ukVIMH22odOZYou4cID1h0D7uCzC3/KYvaF/qWJwT3/OvfjH7KlkK8AsHkulXrQnQ+gZiJiGpMUfhm5+LeOjUjLq+GxoUs3XSEeYg7eFvLk39xrQtwpAntm7cAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830230; c=relaxed/simple;
	bh=mHFWXWH2XJZ7DyZF+wnQZndtQQNwZgwY0yp0PurkmfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCkfYPqxdBuchAXwmOKqlUK9lSReMt3WylrFP7QIozU7vMZYaywSEfRS3jb6qhczaBHhPqAjNhKEf3x0D4GyNwHELkS4mQ7cImt/S5M65flptAJZ1DMAndBKTdNBg8eDy93StdRiikJriTtstQVDd4rA5TV9ECQbmgchjDnQm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SsJmWbs8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SsJmWbs8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GA8sPf012512;
	Fri, 16 Aug 2024 17:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	afnSYt7RfLIOTPjIpeitt+IjjSsPxDM7e8mtArSJG9A=; b=SsJmWbs8a0pljTnn
	PqCO7qqU5s4G21PnFWxC6TchVtp8JFA8GI1T77U44A38Jh4y3xD8214wJ/8oWwOr
	SAfcFeStf0XY/An4EYJBePcfqx53MCle8tNAjRfMg44j4WAWRIcyGCK9ARDq8c03
	SHIj6qGFJ6c2nOqbrLplJUTvM3FrwXTIHUHoqvQcHehO/ubZl1zt36MtCFZd11g1
	VF5KOLxur1ryqQxHtoQAQJJDC02ObxAYfCptG+WNWqMXXxMyLdc0+AVkPRkTDZH7
	w7AymPGmLvhvwb1yp0k9NRu97zEEVlH437dTJ4+NbKQbHYXeR0k76+KYU6Uq7vBC
	LSMtmA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4124rv91sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:43:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GHha9U012641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:43:36 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 10:43:31 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH v14 2/6] iommu/arm-smmu: refactor qcom_smmu structure to include single pointer
Date: Fri, 16 Aug 2024 23:12:55 +0530
Message-ID: <20240816174259.2056829-3-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816174259.2056829-1-quic_bibekkum@quicinc.com>
References: <20240816174259.2056829-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VZQz4VIctKm7XPwwNfiD3Hvi-dAEcADi
X-Proofpoint-ORIG-GUID: VZQz4VIctKm7XPwwNfiD3Hvi-dAEcADi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_12,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160124

qcom_smmu_match_data is static and constant so refactor qcom_smmu
to store single pointer to qcom_smmu_match_data instead of
replicating multiple child members of the same and handle the further
dereferences in the places that want them.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 548783f3f8e8..d03b2239baad 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -73,7 +73,7 @@ void qcom_smmu_tlb_sync_debug(struct arm_smmu_device *smmu)
 	if (__ratelimit(&rs)) {
 		dev_err(smmu->dev, "TLB sync timed out -- SMMU may be deadlocked\n");

-		cfg = qsmmu->cfg;
+		cfg = qsmmu->data->cfg;
 		if (!cfg)
 			return;

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 8ac1850b852f..90e831f1c0ec 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -509,7 +509,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 		return ERR_PTR(-ENOMEM);

 	qsmmu->smmu.impl = impl;
-	qsmmu->cfg = data->cfg;
+	qsmmu->data = data;

 	return &qsmmu->smmu;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 3c134d1a6277..b55cd3e3ae48 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -8,7 +8,7 @@

 struct qcom_smmu {
 	struct arm_smmu_device smmu;
-	const struct qcom_smmu_config *cfg;
+	const struct qcom_smmu_match_data *data;
 	bool bypass_quirk;
 	u8 bypass_cbndx;
 	u32 stall_enabled;
--
2.34.1

