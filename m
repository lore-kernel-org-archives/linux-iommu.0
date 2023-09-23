Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628037A
	for <iommu@lists.linux.dev>; Sat, 23 Sep 2023 01:28:46 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38N1PX5k010635;
	Sat, 23 Sep 2023 01:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=jjNepFrB2iDoHHLQPn9/hllgS3XKbfnBCLqj1zrcOco=;
 b=2X3YSEZdIrHK+iK/xqqyQUaCwhpYUIm3tMftcoDq3W5+C7aqOnHx3ug+7XI5z5DBHmVV
 bpQJxt4fRmhNEKHnDf8sJ8c9tX3NWO+bw/1c82mrlxGxCifIbs0S3DRo8yV3yd5p61yL
 ymm5lEDtQRBLt1vcKkQsVwDGAZS2QQ3rhK6NHdVnwVRrfn1DRBZOQIu+QVBZ6R3k8BsS
 G2x/ZmyzEpaas19SMy/h/Vc+gHO/nnvHS9E0eNCMPzq2hRXG+U9ujEfXOxhjCNSNBVCZ
 o8s6GtIpagFux4B4dD/4jASkolozwcHbjVUSAkZ9R7qoQ1h+pRUHQxIH+DREMCMerQv/ 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt1k2ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Sep 2023 01:28:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MNcwFp007638;
	Sat, 23 Sep 2023 01:28:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhdhqws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Sep 2023 01:28:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38N1R3hW040930;
	Sat, 23 Sep 2023 01:28:29 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-187-199.vpn.oracle.com [10.175.187.199])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t8uhdhq78-19;
	Sat, 23 Sep 2023 01:28:05 +0000
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
Subject: [PATCH v3 18/19] iommu/amd: Print access/dirty bits if supported
Date: Sat, 23 Sep 2023 02:25:10 +0100
Message-Id: <20230923012511.10379-19-joao.m.martins@oracle.com>
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
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309230012
X-Proofpoint-GUID: cioUImnwFi2pCGKs7GHsDfzaMsY_R-RL
X-Proofpoint-ORIG-GUID: cioUImnwFi2pCGKs7GHsDfzaMsY_R-RL

Print the feature, much like other kernel-supported features.

One can still probe its actual hw support via sysfs, regardless
of what the kernel does.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/amd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 45efb7e5d725..b091a3d10819 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2208,6 +2208,10 @@ static void print_iommu_info(void)
 
 			if (iommu->features & FEATURE_GAM_VAPIC)
 				pr_cont(" GA_vAPIC");
+			if (iommu->features & FEATURE_HASUP)
+				pr_cont(" HASup");
+			if (iommu->features & FEATURE_HDSUP)
+				pr_cont(" HDSup");
 
 			if (iommu->features & FEATURE_SNP)
 				pr_cont(" SNP");
-- 
2.17.2

