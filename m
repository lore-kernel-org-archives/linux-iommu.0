Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF333F9
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lla6WtQS"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U3enXs021209;
	Mon, 30 Oct 2023 11:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=rttKBWqpX7zu7N0f+6G/qvbhXxWhLCkzpLo7fUoZ84A=;
 b=lla6WtQSamSnP5/rnxd3hLItlCTAX/t6KBdOFBn0mRLB0o05fR1RE+WbJsWHUVdTdiA4
 r6gzU32mTZeK91aG+U1dTZMiEKoqw0ihw1M7u++MtvwFgi0HWCBcNXE3E9JhTHIntz7I
 Cc5C+IqE+p9mxzwsgSFJjSLtjPY1qFLzNkPSgWuKMf3SWuBYY30FHPISiamnQWLIh1Jq
 spNYhQfsWrXV476H6C7IpZ1UHybjHpEtIMyWfyPWN1jNh9Gc4kl5vo+2oTkOq+NqptLl
 yKFAY8zvG/HKsooL79lC+/tX5YglhwlaT6V/XMUxW4nvIQaSpPWfiXv1O7KIKhZ0yceK Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b2fe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Oct 2023 11:35:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UBY4Vu034812;
	Mon, 30 Oct 2023 11:35:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr47203-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Oct 2023 11:35:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UBZURt015840;
	Mon, 30 Oct 2023 11:35:30 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-164-93.vpn.oracle.com [10.175.164.93])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3u0rr471xs-1;
	Mon, 30 Oct 2023 11:35:30 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com
Subject: [PATCH] iommufd/selftest: Fix page-size check in iommufd_test_dirty()
Date: Mon, 30 Oct 2023 11:34:46 +0000
Message-Id: <20231030113446.7056-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300088
X-Proofpoint-GUID: Ro0GdybZh1VQeAcuaYE-so3l_T0fjEZc
X-Proofpoint-ORIG-GUID: Ro0GdybZh1VQeAcuaYE-so3l_T0fjEZc

iommufd_test_dirty()/IOMMU_TEST_OP_DIRTY sets the dirty bits in the mock
domain implementation that the userspace side validates against what it
obtains via the UAPI.

However in introducing iommufd_test_dirty() it forgot to validate page_size
being 0 leading to two possible divide-by-zero problems: one at the
beginning when calculating @max and while calculating the IOVA in the
XArray PFN tracking list.

While at it, validate the length to require non-zero value as well, as we
can't be allocating a 0-sized bitmap.

Reported-by: syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-iommu/00000000000005f6aa0608b9220f@google.com/
Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
This applies against iommufd for-next, but on the other hand it could also be
squashed in the commit in the Fixes: tag. Both should apply cleanly.
---
 drivers/iommu/iommufd/selftest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 6684ab4cdc7a..a11d29f368ff 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1195,14 +1195,15 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 			      unsigned long page_size, void __user *uptr,
 			      u32 flags)
 {
-	unsigned long bitmap_size, i, max = length / page_size;
+	unsigned long bitmap_size, i, max;
 	struct iommu_test_cmd *cmd = ucmd->cmd;
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
 	int rc, count = 0;
 	void *tmp;
 
-	if (iova % page_size || length % page_size || !uptr)
+	if (!page_size || !length || iova % page_size || length % page_size ||
+	    !uptr)
 		return -EINVAL;
 
 	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
@@ -1214,6 +1215,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 		goto out_put;
 	}
 
+	max = length / page_size;
 	bitmap_size = max / BITS_PER_BYTE;
 
 	tmp = kvzalloc(bitmap_size, GFP_KERNEL_ACCOUNT);
-- 
2.17.2

