Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BA224C9
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7VkBX9K"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9StgE027181;
	Wed, 13 Dec 2023 11:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=mFa7+wZnRy8DezWqs2TWtFukUiLrknEYht2j11vwEQI=;
 b=Z7VkBX9Kp9KMSvBOM8UoEnTKH4b1RsQyEGFsiFP0xtts1NNu6P+6cIPR9KlNs1oCJvjg
 yp95QdfGi66FjjcH4sA6KFtXtdQTyDmF2HPdviZMAUYDHqwGBokOU6r0Ul+Bmn6jNZJy
 Wqj22nRblWG/KqTCOMyB4Zn8mHflkgeHYkjAh/0nALyzscPQY9oK5VwswGTTPmXXlVtG
 10+J9KVCvrf1g3GEdcsvucvJNjRqCOazK2bIheqSFsU7Qk+lzzsbQtsncnVrou510ZpK
 FJGPjgLi5dpocJTpnK7zIhu8ImrVWV/NcndFM9ajDOPBDOmTa9v6FJd3KQn+IRZHTSiR wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3p7wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 11:15:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDB8pgV012799;
	Wed, 13 Dec 2023 11:15:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep840j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 11:15:03 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDBF2Ib002232;
	Wed, 13 Dec 2023 11:15:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvep840fw-1;
	Wed, 13 Dec 2023 11:15:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
Date: Wed, 13 Dec 2023 03:14:50 -0800
Message-ID: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_03,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130081
X-Proofpoint-ORIG-GUID: 0m8zQ4kmDUFzs7rwrZVMGrzKT8O08beB
X-Proofpoint-GUID: 0m8zQ4kmDUFzs7rwrZVMGrzKT8O08beB

Free the handle when the domain allocation fails before unlocking and
returning.

Fixes: 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/iommu/iommu-sva.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 5175e8d85247..c3fc9201d0be 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -101,7 +101,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	domain = iommu_sva_domain_alloc(dev, mm);
 	if (!domain) {
 		ret = -ENOMEM;
-		goto out_unlock;
+		goto out_free_handle;
 	}
 
 	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
@@ -118,6 +118,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 out_free_domain:
 	iommu_domain_free(domain);
+out_free_handle:
 	kfree(handle);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
-- 
2.39.3

