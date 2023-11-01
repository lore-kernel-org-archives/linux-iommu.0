Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574656AA5
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QAOpCZva"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A167FBa020921;
	Wed, 1 Nov 2023 08:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=k1Re8VxmaE+1U/WnoIwTJGtW8BEZm/Vip5onsT835yo=;
 b=QAOpCZvaPJlWbh5vCMe9BxeS3lfuK9ip47nlSQXlunyuM1U5OjZCfUaKKqpqA0w3rvBb
 dmFtKbUBQyVQWDtVBWlS17uc5yvqaSpfie6d4JU9gsRXHbKwrBbe2GlzBm3TY2Jfm2tg
 SbuXLFX3RrHiBTmHBnxHtz6R7OMSHjbCY4VIF4cYc3M2rqF/HNcOnks1p9/m1rzq3G79
 g9hN6wn4eL5wJ2sTgHc+JrCLm4yOQMOKWgMNfRuH4cMeGTcmc/WpB0RfgfIsdvxBR2/I
 D9idgkQu6PH8vgMsqNccqbGVpQgMqq/MIY3+Hr0Oq0hHVNppC3n5aT8aUTK4Dlrnhx6E Hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u30xeb8ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Nov 2023 08:05:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A185H1x008615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 Nov 2023 08:05:19 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 1 Nov 2023 01:05:15 -0700
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <jgg@ziepe.ca>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <quic_tingweiz@quicinc.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [RFC PATCH 1/1] iommu: Fix one concurrency issue happens on non-iommu binding device
Date: Wed, 1 Nov 2023 16:05:02 +0800
Message-ID: <1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com>
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
X-Proofpoint-GUID: _67YCWWv0T6Ki9B7MP6sTqTWSWo2DmV_
X-Proofpoint-ORIG-GUID: _67YCWWv0T6Ki9B7MP6sTqTWSWo2DmV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_05,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=731 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010067

Thread (1)
During SMMU probe:
iommu_device_register
        bus_iommu_probe
                probe_iommu_group for all devices in bus
                        _probe_iommu_device
(non-iommu binding device)	first allocate dev->iommu then free

Thread (2)
client device probing:
dma_configure
        of_iommu_configure
                get dev->iommu->fwspec and call fwspec->ops

There may be a time window that dev->iommu allocated even for non iommu
binding device in thread (1). It would be possible thread (2) meet Use-
after-free errors at that window.

Fix it by closing the time window, set dev->iommu only once
ops->probe_device successfully.
Previous discussion details:
https://lore.kernel.org/linux-arm-kernel/20231017163337.GE282036@ziepe.ca/T/#mee0d7bdc375541934a571ae69f43b9660f8e7312

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
Hi Jason, Robin,
Shall we first address non-iommu binding device crash with below patch? It's
seen a lot especially when smmu probing and other driver probing at same time.
Although it doesn't comprehensively fixes race with of_xlate VS probe, it
indeed solves issue for non-iommu binding device.

 drivers/iommu/iommu.c | 42 +++++++++++++++++++++++++++++-------------
 include/linux/iommu.h |  5 +----
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f17a111..88ce802 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -386,6 +386,17 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
 }
 
+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+	struct dev_iommu *dev_iommu;
+
+	dev_iommu = dev_iommu_get(dev);
+	if (WARN_ON(!dev_iommu))
+		return;
+
+	dev->iommu->priv = priv;
+}
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
@@ -393,23 +404,26 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 {
 	struct iommu_device *iommu_dev;
+	struct dev_iommu *dev_iommu;
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
-		goto err_free;
-	}
+	if (!try_module_get(ops->owner))
+		return -EINVAL;
 
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
 	}
-	dev->iommu->iommu_dev = iommu_dev;
+
+	dev_iommu = dev_iommu_get(dev);
+	if (WARN_ON(!dev_iommu)) {
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	dev_iommu->iommu_dev = iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
@@ -424,9 +438,9 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	}
 	dev->iommu_group = group;
 
-	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	dev_iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 	if (ops->is_attach_deferred)
-		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+		dev_iommu->attach_deferred = ops->is_attach_deferred(dev);
 	return 0;
 
 err_unlink:
@@ -436,9 +450,11 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		ops->release_device(dev);
 err_module_put:
 	module_put(ops->owner);
-err_free:
-	dev->iommu->iommu_dev = NULL;
-	dev_iommu_free(dev);
+	/*
+	 * If probe_device allocated a dev->iommu and things failed later
+	 * we just leave it. We don't yet have robust locking, there
+	 * could be concurrent users.
+	 */
 	return ret;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 73e58df..62e9c86 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -840,10 +840,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 		return NULL;
 }
 
-static inline void dev_iommu_priv_set(struct device *dev, void *priv)
-{
-	dev->iommu->priv = priv;
-}
+void dev_iommu_priv_set(struct device *dev, void *priv);
 
 int iommu_probe_device(struct device *dev);
 
-- 
2.7.4

