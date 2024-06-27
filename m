Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703413DDDF
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486098; cv=none; b=u6u7LJQAgQ5IyJWi6j9w9+AabzMTyRp/tV4HArCRZUoYp3DUmLlfXZN7bEhjoBFA2ZKiGPUixZMzwwowi8H2nv8pFEX852AGgCvqWF4lZNp+9kN0lGkgdsohm13AQ4WZbL5+SHCbcGujvwlV2irLaM0wgdIiTbgxjb6VXw6KD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486098; c=relaxed/simple;
	bh=as/glt6MF/ARsQaAUvSMa6ATErfKdn21QI9yqJLTDO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQp7wUbNqlA4e/1+fJ1p/daFhfqtkSQOzxuKWNCkkQ4eL+LvZQEwOaAJLDwLvSsOSXIrh94uOzgKXa064i8szFq6g9iK3TxiIGLF4phP9VpxzPHbWGDqabnKURfUah1HqqquDsSsL2kxkMJoqFryJUgHOhXbMsfmbrtvDSQK/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HUP6S7yD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUP6S7yD"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tWqr006783;
	Thu, 27 Jun 2024 11:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=k
	/RB1PWP8j7dX1ufHb5fedb+p8AQ4aeuo1IvVNO+i/8=; b=HUP6S7yDS9Tc6fQM0
	iGGr7inTeUu4tWRq7iRcc0XbeF76CW1GfrA/mTUdroFQkQPgyFj1Cbj8inYUgvns
	LTBvcPHRcRYnM1+vOa9HBYNle+FdHk0fmobzR2arUfoo4pw/MFnoHIFyyBJ9sj5+
	x3jdrtdRy66zgunoYYxHoxSZ1mz1JE36/lJu9zN6naQ2q0xG2GLh71h/dnZtoQjL
	hWb1VGTClfX/lBaIK969oj8fzC6oPktNcNmrt8ltrknQJQQRUqz7VuGtfjW26LoL
	rnZ8Yj5I/0H67qkDnf8qyT4L4ZYBuWW9z1vi8akhtjEXesgQElabVBBuAqj1+zDS
	25Wjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb5t06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9kiia023310;
	Thu, 27 Jun 2024 11:01:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KN7025281;
	Thu, 27 Jun 2024 11:01:27 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-4;
	Thu, 27 Jun 2024 11:01:27 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Matt Ochs <mochs@nvidia.com>
Subject: [PATCH v2 03/11] iommufd/selftest: Add tests for <= u8 bitmap sizes
Date: Thu, 27 Jun 2024 12:00:57 +0100
Message-Id: <20240627110105.62325-4-joao.m.martins@oracle.com>
In-Reply-To: <20240627110105.62325-1-joao.m.martins@oracle.com>
References: <20240627110105.62325-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=815
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: wi7DPEaQplm_dbLaXcfvdC5CNav5SVCf
X-Proofpoint-ORIG-GUID: wi7DPEaQplm_dbLaXcfvdC5CNav5SVCf

Add more tests for bitmaps smaller than or equal to an u8, though skip the
tests if the IOVA buffer size is smaller than the mock page size.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 0b04d782a19f..61189215e1ab 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1727,6 +1727,12 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	void *vrc;
 	int rc;
 
+	if (variant->buffer_size < MOCK_PAGE_SIZE) {
+		SKIP(return,
+		     "Skipping buffer_size=%lu, less than MOCK_PAGE_SIZE=%lu",
+		     variant->buffer_size, MOCK_PAGE_SIZE);
+	}
+
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 
@@ -1779,6 +1785,18 @@ FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 	teardown_iommufd(self->fd, _metadata);
 }
 
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty8k)
+{
+	/* half of an u8 index bitmap */
+	.buffer_size = 8UL * 1024UL,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty16k)
+{
+	/* one u8 index bitmap */
+	.buffer_size = 16UL * 1024UL,
+};
+
 FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128k)
 {
 	/* one u32 index bitmap */
-- 
2.17.2

