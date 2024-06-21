Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11C8820
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995413; cv=none; b=G9vW6Yi40xLOh0mzTJbFEp0Mtoffd3ipVrhD2qrO81pORHtmhMzr1qHDK2mpLJcLGdn2nRhjgivQpOsWYT28mG/oMn48BBT9xKg3rt2C4FMzScGpFeHC4AxydNU6ln0OW8cgrKx1PhbbexxqcdmXliAv+bCvNDKCdI3PLqofOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995413; c=relaxed/simple;
	bh=WH5QvxwEp6RVnQFU+2ANmQIBMJgDW76jZD86q2cFUG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7b/GZhKkrOCmFSDCAf7JHFYjrR9L2xc+2nK1glVNfQrhsH3J14ojIrmCPlkMU+sMxF3a+KPK1TbZ9u0gWcHsCQl6DbcS6khpYURhe9rVYwo/FKCi+6pvd99wzKRpn7+LNiqh/3UhszwFID/Hl1sTwjnV9CZNBbXJjmvIJw7lqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T61pHuPL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T61pHuPL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXbiY016937;
	Fri, 21 Jun 2024 18:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=L
	kMujcnDN1C0+PZG7HIp2XEzGFd7Vnqxueza7ViPP4A=; b=T61pHuPL63sgKaYe1
	0qvSwMZI6sxB8YZ7hwQWxe/9ei7CYzcZTpAhvF///EHvlWZX3OV19vDSXv2f/WFb
	JSwib6gfvyaf8vYFPilcrWItZtEdzmEZVSyqRHhm3HE8A8oAKRiv5yDHEn463O1d
	0eGbGYX886oI4flmgKqu0uoRznWb0sqjiYMwtgdwN6pjSe57bCEMBgc7FUh3YqDc
	L8AWGn8MOfOHULH+ryg/MIqW2jATKJ4Pc6288VPNHh2uyNhWvtdNDWzPuGoB4Igi
	u3xfL58k0B8gCZN+ZMWvnMRk+heomxTYw0xalD1ny/DOiEbyTr1AZ3KjulKHhIAp
	h4mNQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgtcmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LIgbg6040172;
	Fri, 21 Jun 2024 18:43:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pnyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFX6032040;
	Fri, 21 Jun 2024 18:43:21 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-3;
	Fri, 21 Jun 2024 18:43:21 +0000
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
Subject: [PATCH v1 02/10] iommufd/selftest: Fix iommufd_test_dirty() to handle <u8 bitmaps
Date: Fri, 21 Jun 2024 19:42:46 +0100
Message-Id: <20240621184254.45477-3-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-1-joao.m.martins@oracle.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_10,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-GUID: iI-_EyXYtHHPs4touQCGAT4x1qqBDXh0
X-Proofpoint-ORIG-GUID: iI-_EyXYtHHPs4touQCGAT4x1qqBDXh0

The calculation returns 0 if it sets less than the number of bits per
byte. For calculating memory allocation from bits, lets round it up to
one byte.

Reported-by: Matt Ochs <mochs@nvidia.com>
Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
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

