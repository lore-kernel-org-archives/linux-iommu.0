Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA13134CB
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 20:47:53 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx5Gp025230;
	Thu, 18 May 2023 20:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=hnzbDzcuADQdXdX6l91Ma65MoXvbmxZbCuNBaDlEMLw=;
 b=dXr3iIexO3u2FVTW26XMXOk6lf0oxGWABRN0AJFiM/YpIDQ5FK7jBnhXUJje0ENN5OhC
 eQF0UqQ+tM0OySoP/hY7gASvwT9g1chBXUcKet6O22WPvquXnW4HWtxD3XSoHE3AdhqN
 ggCl+jvR15mIZtozYz6LktpO9BzOyx12/GqLC4e/CYPzRcRaUKhqWU5zgKnxo3I+Z7jg
 5/MtMwoiP42jtgsXyMwUsoMaWv2LkjoKeceBsvPHD/v7NMrcN+QX558qcVdLWc6yMKp+
 gKeS6ItFSxT8U21xQzB5ymZE62Q01Oqw2O/c1C6Bvz3NRtjGgRKkc2QbqTeQDMA/P4Ug /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc97ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:47:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IJFRxA032132;
	Thu, 18 May 2023 20:47:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10daeah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:47:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IKlE2r033533;
	Thu, 18 May 2023 20:47:27 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-172-172.vpn.oracle.com [10.175.172.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10dae46-4;
	Thu, 18 May 2023 20:47:27 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Yi Y Sun <yi.y.sun@intel.com>, Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFCv2 03/24] vfio: Move iova_bitmap into iommu core
Date: Thu, 18 May 2023 21:46:29 +0100
Message-Id: <20230518204650.14541-4-joao.m.martins@oracle.com>
In-Reply-To: <20230518204650.14541-1-joao.m.martins@oracle.com>
References: <20230518204650.14541-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=715 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180170
X-Proofpoint-ORIG-GUID: ebGehFK4xMnLwN1Mf4khudJ4ibTWxQUP
X-Proofpoint-GUID: ebGehFK4xMnLwN1Mf4khudJ4ibTWxQUP

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
index 57c3515af606..f9cc32a9810c 100644
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

