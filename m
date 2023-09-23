Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B563B
	for <iommu@lists.linux.dev>; Sat, 23 Sep 2023 01:27:55 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38N0u540031656;
	Sat, 23 Sep 2023 01:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=7o4TYSJizOwaC2hTJRhxY20Y3XPMFkFDhzFDbPhBo44=;
 b=vn4YKVc7kWe8JKVTMNzUerTGL1vx8yPjpaHkiOhYPEkIb0/yatf3JkHBRBS9rJSg3QXB
 mSTIIePm8ygmBfbIe6zTUN3pF0lG0cK1RJjvuFXrRVB1YZP3VVNP74PIasQEjbmY5JKX
 qzG62/ePxh03udN0oH8mBjt3w3fsaa/VUKzwMAN76LXGROkpRItDaHJTH6H7GApMMj3X
 bJtwcZlGLB+ral23ZF9kyn9qx5MPTH7BoyWCwlLa41h8EXBgwKtrbPZ+tmqBpEI9pSIu
 mBwQO26AN4+nU8f8N00Mw91047J4J659eAXQcsZ+7hufW9COGHJ3Un4o1oMpHyUBgmn2 GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsv32u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Sep 2023 01:27:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38N0da99007740;
	Sat, 23 Sep 2023 01:27:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhdhqak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Sep 2023 01:27:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38N1R3h0040930;
	Sat, 23 Sep 2023 01:27:10 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-187-199.vpn.oracle.com [10.175.187.199])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t8uhdhq78-3;
	Sat, 23 Sep 2023 01:27:10 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Yi Y Sun <yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 02/19] vfio: Move iova_bitmap into iommu core
Date: Sat, 23 Sep 2023 02:24:54 +0100
Message-Id: <20230923012511.10379-3-joao.m.martins@oracle.com>
In-Reply-To: <20230923012511.10379-1-joao.m.martins@oracle.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=776 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309230011
X-Proofpoint-ORIG-GUID: muKvpEEFSPOvrNKgwbZYBZizqs7LKqhB
X-Proofpoint-GUID: muKvpEEFSPOvrNKgwbZYBZizqs7LKqhB

Both VFIO and IOMMUFD will need iova bitmap for storing dirties and walking
the user bitmaps, so move to the common dependency into IOMMU core. IOMMUFD
can't exactly host it given that VFIO dirty tracking can be used without
IOMMUFD.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/Makefile                | 1 +
 drivers/{vfio => iommu}/iova_bitmap.c | 0
 drivers/vfio/Makefile                 | 3 +--
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/{vfio => iommu}/iova_bitmap.c (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 769e43d780ce..9d9dfbd2dfc2 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
+obj-$(CONFIG_IOMMU_IOVA) += iova_bitmap.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/vfio/iova_bitmap.c b/drivers/iommu/iova_bitmap.c
similarity index 100%
rename from drivers/vfio/iova_bitmap.c
rename to drivers/iommu/iova_bitmap.c
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index c82ea032d352..68c05705200f 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VFIO) += vfio.o
 
-vfio-y += vfio_main.o \
-	  iova_bitmap.o
+vfio-y += vfio_main.o
 vfio-$(CONFIG_VFIO_DEVICE_CDEV) += device_cdev.o
 vfio-$(CONFIG_VFIO_GROUP) += group.o
 vfio-$(CONFIG_IOMMUFD) += iommufd.o
-- 
2.17.2

