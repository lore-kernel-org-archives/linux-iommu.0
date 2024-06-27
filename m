Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A513DDDF
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486095; cv=none; b=MUiz6oP1wTpRtAnLHPN/F/1FjfxcDnE0wNgX9hXqwww3Odrm46y6vaj+qTfHiEWUovydzyG8tKoWKkWhSHXU4EHo3KuvhYtcF1zRcjt41pxq5P9WIt+nbKYu8HUlu9xQ1XzP4VAkux8S5Z/VVfWND4scCkbj9dcrY4MLJHJM47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486095; c=relaxed/simple;
	bh=dLE4p/DCxYih/8D4DSwAB7T9XC5kJCKjC+xwqRdDj/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyTiKQXJ8TmCWjHsgvPvLTDFp1CvBwdOLShXGw1Ytguq5WCWMQe243/85pRmHgmz11BYAzoEk2N5H3s/Md58wN4iZWFCzxl96llIBamJHD2GgC0RbELn2h17sbRmKaNMAUVvkXRw5iWFG0jYsvF7joFBCKzOpFiaOmhgCr5G03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=anO3McAf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="anO3McAf"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tU34028895;
	Thu, 27 Jun 2024 11:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=r
	FI2NukYUAbY8n6Z5cs5bJf2GfqUd/c0OGYTGFWW0Uk=; b=anO3McAfoIhX2fDlo
	5pUPtVOQr1cTrVXwUVCmYczW955Dyaqu4hPgNqGph9KgWOdGlLuxgspaxhicBiFb
	A/aGNcazydILogGFQQknbcMQTxFUSlZt7dVH1vGnC/3pm3upz0QNsuATzg9P1PD9
	B9PSJOa0d3jlNvKNnrlZzayCDK+W4t1Ep3Vl58yfktgtPmJU6ZKwxYMs55qNmIWc
	Qx3GQ5xxJylFruF3awpn6Ezz9/EiIgPcUx99tCozoo5U1LUFffcy+RWhWkj+X8gT
	cBRe1RzTzlvD1+ZgZv/9W8lloHYVgXLHIV/u3mIaC0IlWAjHmhsjPuQvFFQru1cZ
	/WBLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t5th4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9ZJ2a023396;
	Thu, 27 Jun 2024 11:01:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grv9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KN5025281;
	Thu, 27 Jun 2024 11:01:25 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-3;
	Thu, 27 Jun 2024 11:01:25 +0000
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
Subject: [PATCH v2 02/11] iommufd/selftest: Fix iommufd_test_dirty() to handle <u8 bitmaps
Date: Thu, 27 Jun 2024 12:00:56 +0100
Message-Id: <20240627110105.62325-3-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: Du2QuLKXPLJLJAK3ynz0r_VMamUlnxIL
X-Proofpoint-ORIG-GUID: Du2QuLKXPLJLJAK3ynz0r_VMamUlnxIL

The calculation returns 0 if it sets less than the number of bits per
byte. For calculating memory allocation from bits, lets round it up to
one byte.

Reported-by: Matt Ochs <mochs@nvidia.com>
Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 97ce62602e66..fea60db05c9f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1356,7 +1356,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	}
 
 	max = length / page_size;
-	bitmap_size = max / BITS_PER_BYTE;
+	bitmap_size = DIV_ROUND_UP(max, BITS_PER_BYTE);
 
 	tmp = kvzalloc(bitmap_size, GFP_KERNEL_ACCOUNT);
 	if (!tmp) {
-- 
2.17.2

