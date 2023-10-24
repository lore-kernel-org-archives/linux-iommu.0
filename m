Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E7125DE
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0nIQUFfA"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCKHrD019973;
	Tue, 24 Oct 2023 13:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=tgIdOupujCqApwE/bn6n5glmGDks5E5LHs73PQjCuyc=;
 b=0nIQUFfA227zKHSXsdXcq76dXvIqoNTPiZTngX+4O8SAd2X/pGQ3Jv23HbOgelJpyFju
 BtCHhUMmHxzBnlBKdYeGQKaJ6vtB1VQlHBMF6YyVjNBrQb5BmZEBgIPw8v2rv2TeQH8w
 8/uQa4mhAfhiWvX57GcllbVgUBr9YQsTeBt3dBejs8sg5RWisTzyPznFdTd95fma7qMO
 zAee4O54OgMhz95723DX2I00Nnvns+CAtvcVRtRvRCRpt8/uvWAYw/x9f12g0tqsal8h
 DhGdIP/EJQoU8/RuZr4+vrmbfh2Nvc7Owzk+eWhryJ1uwAZWhboOW4pbWOu69nodE2BL Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbdhq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 13:51:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCxrhF034564;
	Tue, 24 Oct 2023 13:51:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53591w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 13:51:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ODpL8q030007;
	Tue, 24 Oct 2023 13:51:25 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-194-36.vpn.oracle.com [10.175.194.36])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv53591rr-2;
	Tue, 24 Oct 2023 13:51:25 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Yi Y Sun <yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 01/18] vfio/iova_bitmap: Export more API symbols
Date: Tue, 24 Oct 2023 14:50:52 +0100
Message-Id: <20231024135109.73787-2-joao.m.martins@oracle.com>
In-Reply-To: <20231024135109.73787-1-joao.m.martins@oracle.com>
References: <20231024135109.73787-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_14,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240118
X-Proofpoint-GUID: 2LzvlOdt3votCbYaFkIRhInHtLhVsIv1
X-Proofpoint-ORIG-GUID: 2LzvlOdt3votCbYaFkIRhInHtLhVsIv1

In preparation to move iova_bitmap into iommufd, export the rest of API
symbols that will be used in what could be used by modules, namely:

	iova_bitmap_alloc
	iova_bitmap_free
	iova_bitmap_for_each

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/iova_bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/iova_bitmap.c b/drivers/vfio/iova_bitmap.c
index 0848f920efb7..f54b56388e00 100644
--- a/drivers/vfio/iova_bitmap.c
+++ b/drivers/vfio/iova_bitmap.c
@@ -268,6 +268,7 @@ struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
 	iova_bitmap_free(bitmap);
 	return ERR_PTR(rc);
 }
+EXPORT_SYMBOL_GPL(iova_bitmap_alloc);
 
 /**
  * iova_bitmap_free() - Frees an IOVA bitmap object
@@ -289,6 +290,7 @@ void iova_bitmap_free(struct iova_bitmap *bitmap)
 
 	kfree(bitmap);
 }
+EXPORT_SYMBOL_GPL(iova_bitmap_free);
 
 /*
  * Returns the remaining bitmap indexes from mapped_total_index to process for
@@ -387,6 +389,7 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iova_bitmap_for_each);
 
 /**
  * iova_bitmap_set() - Records an IOVA range in bitmap
-- 
2.17.2

