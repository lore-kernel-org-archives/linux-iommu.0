Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290B134CB
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 20:48:31 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx6tA032295;
	Thu, 18 May 2023 20:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=u/U+v7/5wsTNvcp+fP9iSCgVpBo4DhTF0KBqbtAIEYw=;
 b=b/PTmdv9ds5Ta5bI71gznMbo2WN9/pa1fm8aEkzTN1tZUqrTw+2mmiMHLnsyXd+bU2Y6
 ALwhuTI4X5Z2sWeKcdNTBZRRM4uEznmABau4p83HFHx5hhNphD8btK9RZ2O0c97VEmNt
 TcLFKrWVXkcu2UBXHjMKFNruvPJl2c/uK4UdHx9eqQMBTddk+rIhq+GO6VeRwyRDluUy
 LGcut1ik2F0NcblkEV3a3+SMJEXM/8485gIZ7AYHnkJSIrnJjk4PnXqGMCVRdgle14Cr
 1RGaEKHFD8t3V/P1/pJRwngm4K8zScT3xymzZAhB7cqz5eoF93OmvOGa2fplfs7b/hG/ fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkux92kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:48:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IJPApp032227;
	Thu, 18 May 2023 20:48:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10daex1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:48:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IKlE33033533;
	Thu, 18 May 2023 20:48:15 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-172-172.vpn.oracle.com [10.175.172.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10dae46-9;
	Thu, 18 May 2023 20:48:15 +0000
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
Subject: [PATCH RFCv2 08/24] iommufd: Dirty tracking data support
Date: Thu, 18 May 2023 21:46:34 +0100
Message-Id: <20230518204650.14541-9-joao.m.martins@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=814 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180171
X-Proofpoint-ORIG-GUID: CPJOkXA26O1RcAo3BX73B8FXQx7xEGrE
X-Proofpoint-GUID: CPJOkXA26O1RcAo3BX73B8FXQx7xEGrE

Add an IO pagetable API iopt_read_and_clear_dirty_data() that performs the
reading of dirty IOPTEs for a given IOVA range and then copying back to
userspace bitmap.

Underneath it uses the IOMMU domain kernel API which will read the dirty
bits, as well as atomically clearing the IOPTE dirty bit and flushing the
IOTLB at the end. The IOVA bitmaps usage takes care of the iteration of the
bitmaps user pages efficiently and without copies.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 70 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 14 +++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 21052f64f956..187626e5f2bc 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <uapi/linux/iommufd.h>
 
 #include "io_pagetable.h"
 #include "double_span.h"
@@ -412,6 +413,75 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 	return 0;
 }
 
+struct iova_bitmap_fn_arg {
+	struct iommu_domain *domain;
+	struct iommu_dirty_bitmap *dirty;
+};
+
+static int __iommu_read_and_clear_dirty(struct iova_bitmap *bitmap,
+					unsigned long iova, size_t length,
+					void *opaque)
+{
+	struct iova_bitmap_fn_arg *arg = opaque;
+	struct iommu_domain *domain = arg->domain;
+	const struct iommu_domain_ops *ops = domain->ops;
+	struct iommu_dirty_bitmap *dirty = arg->dirty;
+
+	return ops->read_and_clear_dirty(domain, iova, length, 0, dirty);
+}
+
+static int iommu_read_and_clear_dirty(struct iommu_domain *domain,
+				      unsigned long flags,
+				      struct iommufd_dirty_data *bitmap)
+{
+	const struct iommu_domain_ops *ops = domain->ops;
+	struct iommu_iotlb_gather gather;
+	struct iommu_dirty_bitmap dirty;
+	struct iova_bitmap_fn_arg arg;
+	struct iova_bitmap *iter;
+	int ret = 0;
+
+	if (!ops || !ops->read_and_clear_dirty)
+		return -EOPNOTSUPP;
+
+	iter = iova_bitmap_alloc(bitmap->iova, bitmap->length,
+			     bitmap->page_size, bitmap->data);
+	if (IS_ERR(iter))
+		return -ENOMEM;
+
+	iommu_dirty_bitmap_init(&dirty, iter, &gather);
+
+	arg.domain = domain;
+	arg.dirty = &dirty;
+	iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
+
+	iommu_iotlb_sync(domain, &gather);
+	iova_bitmap_free(iter);
+
+	return ret;
+}
+
+int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
+				   struct iommu_domain *domain,
+				   unsigned long flags,
+				   struct iommufd_dirty_data *bitmap)
+{
+	unsigned long last_iova, iova = bitmap->iova;
+	unsigned long length = bitmap->length;
+	int ret = -EOPNOTSUPP;
+
+	if ((iova & (iopt->iova_alignment - 1)))
+		return -EINVAL;
+
+	if (check_add_overflow(iova, length - 1, &last_iova))
+		return -EOVERFLOW;
+
+	down_read(&iopt->iova_rwsem);
+	ret = iommu_read_and_clear_dirty(domain, flags, bitmap);
+	up_read(&iopt->iova_rwsem);
+	return ret;
+}
+
 int iopt_get_pages(struct io_pagetable *iopt, unsigned long iova,
 		   unsigned long length, struct list_head *pages_list)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2552eb44d83a..2259b15340e4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -8,6 +8,8 @@
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 #include <linux/uaccess.h>
+#include <linux/iommu.h>
+#include <linux/iova_bitmap.h>
 
 struct iommu_domain;
 struct iommu_group;
@@ -70,6 +72,18 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 		    unsigned long length, unsigned long *unmapped);
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
 
+struct iommufd_dirty_data {
+	unsigned long iova;
+	unsigned long length;
+	unsigned long page_size;
+	unsigned long long *data;
+};
+
+int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
+				   struct iommu_domain *domain,
+				   unsigned long flags,
+				   struct iommufd_dirty_data *bitmap);
+
 void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 				 unsigned long length);
 int iopt_table_add_domain(struct io_pagetable *iopt,
-- 
2.17.2

