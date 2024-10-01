Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7BC36AF8
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762246; cv=none; b=CW4eHyV5JuLRsPg4dnwQovsN5gDm2NkBcn7iMFsHcRF6nxHyC1SDP4gd1y0WxrGq28/rZDbX7lY8g1ZE6N3tBgKGzX0FVj5BWSnRpF2AXfCZUa6vXVhTZyOvgzBaOAkZ10oI6dKyFgmpiyn+9wAt0f9h0jmhphO5mbryQC8YidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762246; c=relaxed/simple;
	bh=wURtk0+ETt/SBfDkjZewKyw4HeyFZtBkbpc/ZZTwHDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8YUwSVwd0VzEIZ6lLghEvdrtF+xidlW1OwsMMPEoJC5h3EIB8370hP1ZO6svWuZphhMSE/2w5GhEoG/YWvrhd3wVdXsiV8A6qjQQ1p+/ecPW4PJIHRfkhO4UhWefMjnV35h2372/rLYUFEVhTZyb1Btv8J0sjk7ptVTTKAZhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eyVoNyOc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eyVoNyOc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49110GGo023436;
	Tue, 1 Oct 2024 05:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=l8NHi5Dbyv4rp8gb+LVSw/Z7+qJoWd5is+WvTYL/xWI=; b=ey
	VoNyOcUAPwxKoKXu+DHdtoiI/nsn72uZRMTkX4kugntX1gDdeRDtQ/o1wPPNHTBK
	DZIAVrMiCeYDMjMg7S4aDAaJq1ja2MQ1PIMn7+estnh2x3Gm48Mtop2G9gN4hkSM
	Ii+w+3Mm5wI/o45YkSa+dZyaiPaKM/sY7kKxeXrlH3LxjnyOAYsok7ztLrQFh7Ep
	1HdIJ2+e2lIwhE3ELm3PQ7kCyUjH+mlpYZ0zsjA6OG/8RY66HbTs8oCy8N36X7Hh
	YUA0IdPnYBgnnrsYUQ4+82KunFg0BHchsWlGXeXo8gcHQnYJVliKSuRIlHrNd4EW
	ZF7MYsJDQSEQZc/vRQQA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xajff2cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 05:56:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4915uuuZ026101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 05:56:57 GMT
Received: from hu-pbrahma-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 22:56:52 -0700
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>,
        <jsnitsel@redhat.com>, <robdclark@chromium.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Pratyush Brahma
	<quic_pbrahma@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>
Subject: [PATCH] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Tue, 1 Oct 2024 11:26:33 +0530
Message-ID: <20241001055633.21062-1-quic_pbrahma@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HhDrH_lDxbp9AiQPWo-8IuI2O14j82zF
X-Proofpoint-ORIG-GUID: HhDrH_lDxbp9AiQPWo-8IuI2O14j82zF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=981
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010038

Null pointer dereference occurs due to a race between smmu
driver probe and client driver probe, when of_dma_configure()
for client is called after the iommu_device_register() for smmu driver
probe has executed but before the driver_bound() for smmu driver
has been called.

Following is how the race occurs:

T1:Smmu device probe		T2: Client device probe

really_probe()
arm_smmu_device_probe()
iommu_device_register()
					really_probe()
					platform_dma_configure()
					of_dma_configure()
					of_dma_configure_id()
					of_iommu_configure()
					iommu_probe_device()
					iommu_init_device()
					arm_smmu_probe_device()
					arm_smmu_get_by_fwnode()
						driver_find_device_by_fwnode()
						driver_find_device()
						next_device()
						klist_next()
							/* null ptr
							assigned to smmu */
					/* null ptr dereference
					while smmu->streamid_mask */
driver_bound()
	klist_add_tail()

When this null smmu pointer is dereferenced later in
arm_smmu_probe_device, the device crashes.

Fix this by deferring the probe of the client device
until the smmu device has bound to the arm smmu driver.

Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 723273440c21..1f2bafa92f1f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1437,6 +1437,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 			goto out_free;
 	} else {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+		if (!smmu)
+			return dev_err_probe(dev, -EPROBE_DEFER, "smmu dev has not bound yet\n");
 	}
 
 	ret = -EINVAL;
-- 
2.17.1

