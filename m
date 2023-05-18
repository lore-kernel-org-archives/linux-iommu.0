Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C31D2BD
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 20:49:33 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIwpfg018288;
	Thu, 18 May 2023 20:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=w0o6G0yQRdrkGIcIUpsgd4Lt8hKCCSm8IByMw8BYHjA=;
 b=NCXglvP4UsVZqjzl6W1YewcTzFcrM/60QBvdjh6NJG5kfGVlAh98ICeRsIneCj4K9Azi
 O3jZCZ9WfsE9lwVt1MrBxm5iWSHkf6qhe7eTXMKSkVKPWxgEJIbGVeOyT4UlqT3INqVw
 oB+ueQxJze6tuG7TJpC5Q3AMg/7AXnw/TiIbbJmcBzats3VyLII6CANiP1Fv1AhGWYnv
 8YAYmapw6K3fRU03lAG//3jLDSyqW96FqjANLXCs5MGrYC3dArEmXgtNiOM43MPHDV+N
 7RE+uwZVnBpRDfb3ZG/po6yoqXfwTGcN1PQOeH4DswqEDH1skXYfuvDckdWlErWh29+w nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kds9bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:49:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IKXqwo032130;
	Thu, 18 May 2023 20:49:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10dafvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:49:20 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IKlE3X033533;
	Thu, 18 May 2023 20:49:19 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-172-172.vpn.oracle.com [10.175.172.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10dae46-24;
	Thu, 18 May 2023 20:49:19 +0000
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
Subject: [PATCH RFCv2 23/24] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Date: Thu, 18 May 2023 21:46:49 +0100
Message-Id: <20230518204650.14541-24-joao.m.martins@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=878 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180171
X-Proofpoint-GUID: f0-uzCHn62GNlAOgiAgJSOIt59HUOCq-
X-Proofpoint-ORIG-GUID: f0-uzCHn62GNlAOgiAgJSOIt59HUOCq-

Dirty tracking will always be enabled with DBM=1 modifier enabled
by default.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2cde14003469..bf0aac333725 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2787,6 +2787,27 @@ static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
 	return ret;
 }
 
+static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
+				       bool enabled)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (!ops) {
+		pr_err_once("io-pgtable don't support dirty tracking\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Always enabled and the dirty bitmap is cleared prior to
+	 * set_dirty_tracking().
+	 */
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2916,6 +2937,7 @@ static struct iommu_ops arm_smmu_ops = {
 		.enable_nesting		= arm_smmu_enable_nesting,
 		.free			= arm_smmu_domain_free,
 		.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
+		.set_dirty_tracking     = arm_smmu_set_dirty_tracking,
 	}
 };
 
-- 
2.17.2

