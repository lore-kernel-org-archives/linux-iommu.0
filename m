Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59620EB
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 20:49:11 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx4mR032260;
	Thu, 18 May 2023 20:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=nSr+1XoQLx2Xe3M6TjCM5Ex2L+ELRf1SGpP6Wj+ieq8=;
 b=HB2l1AoR/Zvx2tyllH5b900dBv8C7QXOUuHcsHU8WKiuGuftVqBQNqseNQoeZabSmxBx
 GuuO+eZD/yPS3SYyw7xGLLxLFsWDviRsIbBElUFE83Cuuo6PsltDgJh4I16+YJq5FElp
 vdG/h2yak8i8iWIcQmvY0/cjPSzW1ZY6wxcpMbjORlOxoo5VsE543zUqDNzWAz1sYnoh
 Gz3L+WBUEmBuwOzoBb+TebPdKc3gkaBIND/fXmH0umvwfjlAe3ynEg/FunbJHgNBKlrQ
 w1RBqWrnn2e7imQE3nWxfllWTO6yTzeAU0twBJ1Zbv9hzl7YVWGYw1ikT2z0vre6OpIh gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkux92nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:48:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IKfQLF032131;
	Thu, 18 May 2023 20:48:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10dafjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 20:48:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IKlE3N033533;
	Thu, 18 May 2023 20:48:57 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-172-172.vpn.oracle.com [10.175.172.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10dae46-19;
	Thu, 18 May 2023 20:48:56 +0000
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
Subject: [PATCH RFCv2 18/24] iommu/amd: Print access/dirty bits if supported
Date: Thu, 18 May 2023 21:46:44 +0100
Message-Id: <20230518204650.14541-19-joao.m.martins@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180171
X-Proofpoint-ORIG-GUID: zNCrPmLGMZHZrwx0YhQB_vYuEgxrssT1
X-Proofpoint-GUID: zNCrPmLGMZHZrwx0YhQB_vYuEgxrssT1

Print the feature, much like other kernel-supported features.

One can still probe its actual hw support via sysfs, regardless
of what the kernel does.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/amd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 082f47e22c6e..102440316c4a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2151,6 +2151,10 @@ static void print_iommu_info(void)
 
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

