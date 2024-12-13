Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C32B2CF;
	Fri, 13 Dec 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102299; cv=none; b=g0OKbu4Brj/sAkKMG4GJxYKUWQpXfxSZnkvRZLPLo4Dii8Sa3AfU+0F8Auy8GZCfphbc2y/venFzmh1jtGOOoYZwUKcsYZtKxs6L07vWyEslnualxHWpqXWXxGT4eGowQT1RU5ZJYhhKc9ZykPIXuzJ5XD9FU7q7znev0S62bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102299; c=relaxed/simple;
	bh=GVFC5SrKhtuc2adKB/K5AW3iIzfKvM0v7aEevyucbnc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFzfppA1GJYW1TBQSsS5tyYNPhLpLe4yGUR89tsuqU86FevjNXnadBbGj1LEVJNMTLCAsi7a/whLGjMeOyi5MXFYYuoAYV7IcumI9npbO9GzEhfeZodZs3I/b7rXyMeshlz8vDVufA2hOVpwBwOwLqsYJRWOCRNE1vYay8SQ4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VChh+3A+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VChh+3A+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBi1B2018582;
	Fri, 13 Dec 2024 15:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EOkMa+jxJ9WlJ7NnYTowvk
	ud+UXVDdWfxJ01ubZtvlk=; b=VChh+3A+3g0mU5VjiI9dvsbRmZGkK6fkFCzgjG
	/djp1VUxDRPyt78dpHhq5711FMOO+Prjt5HEi/xIbme731BvOiCcIBlaJK2RcleB
	qWxVNVZdT59V9MxveyMv9EC8AzAfXDgbUm/aW5wWeJRxiKXJMUZ6Pzkv6ovCVML1
	ZIQuNGj1q2hmZ0xF/O3cxrDIKZjC5kWTswc7lBCe3x768RYPnpG6qo2CSwze14o+
	jzwZ4/cooc4xyYK24sNNlfbgFb1qk6yZgq4T0Dxk3HsRwt/26phBVV0DEYnxBWSA
	N4Xh8wJxJPMZmVXUUuWH5fevd7dS+VWP9mGZ+T8FkLGrCvDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0h80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:04:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDF4mMO014251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:04:48 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 07:04:46 -0800
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <jgg@ziepe.ca>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla
	<quic_charante@quicinc.com>
Subject: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
Date: Fri, 13 Dec 2024 20:34:15 +0530
Message-ID: <20241213150415.653821-1-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RPg2wSLhMcZdKqLrZm6DWVzwZUnUB2oR
X-Proofpoint-GUID: RPg2wSLhMcZdKqLrZm6DWVzwZUnUB2oR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

Race between smmu device probe and iommu device probe is resulting into
wrong DMA ops used for the device.

bus_iommu_probe(P1)                  of_iommu_configure(P2)
(from iommu_device_register)        (from insmod of a driver)
--------------------------         --------------------------
1) probe_iommu_group()
(Fills just dev->iommu_group
under iommu_probe_device_lock)
				2) iommu_probe_device():
				  (acquires the iommu_probe_device_lock,
				   but since dev->iommu_group is already
				   set, it just returns without
				   allocating the domain.)

				3) of_dma_configure_id()->
				   arch_setup_dma_ops() gets called for
				   this device, but returns with the
				   error message:
				   "Failed to set up IOMMU for device;
				    retaining platform DMA ops"

				4) device probe is succeeded where it
				   can now setup iommu mappings using
				   wrong ->dma_ops

5) domain will be allocated later
and fills iommu_group->domain.

Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.

This issue does exists on 6.6 because of commit f188056352bc ("iommu:
Avoid locking/unlocking for iommu_probe_device()") without which 2)
returns only after filling the domain under group->mutex, thus no issue.

With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
->iommu_dma_ops is removed altogether and iommu api are directly being
called under "use_dma_iommu(): return dev->dma_iommu". Again,
->dma_iommu flag is set only after domain allocation. So, If
there is a sufficient delay between steps 4) and 5), issue is still
exists but that seems very narrow to me.

I am thinking, setup of the domain before returning from step2) is the
way to fix this issue. Can you please help if you have any suggestions?

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f1029c0825e..61fc8145f378 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -561,19 +561,43 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
+	struct iommu_group *group;
 	int ret;
 
 	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, NULL);
 	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
-		return ret;
+		goto err_out;
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		ret = -ENODEV;
+		goto err_release;
+	}
+
+	mutex_lock(&group->mutex);
+	if (!group->default_domain) {
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
+			goto err_unlock;
+	}
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 
 	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
 	return 0;
+
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+err_release:
+	iommu_release_device(dev);
+err_out:
+	return ret;
 }
 
 static void __iommu_group_free_device(struct iommu_group *group,
-- 
2.34.1

