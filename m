Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F28820
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995417; cv=none; b=kfm7d25+JpvR01w7Ib8d1wH33AFTKpc7XIhJg0mRDsugxm8XMDZvKX4e3Ke1sOCGBMJbAGt6+utKmiBkow36HwoRGc8KgbQlXEOQf4UMDyHco73UeYwqwVOt4cWLWMFF9CCO6BZurx0ElLThJ0eG3lpLI9ixDulYyeOfgaL2buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995417; c=relaxed/simple;
	bh=CSKcMOdT3CJolGBsAOLmEiNUhMsDAP8WmobNMqgEh9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhbMy2rJXSt1YR7gkoFdi+Jf4XAVmodAmBIGyqgeTu1Qx7zBLDOmcSBkG1Rfj6fxiXJ7KWsBYXTXtCO7DrhbpYpKA1AzMjGfuo4hJrXtVeIFY1CiGBSf7uu8le+gL3omudhqUiMv38NMNDF5SYA6Y07Gdr2mLBf/VsFqaLg0Roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GiVEbpSU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GiVEbpSU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXP2q007613;
	Fri, 21 Jun 2024 18:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=K
	2lpA+S0eErle6GP6bB4bBKwYVC8XeIfws30/MLLehc=; b=GiVEbpSUU2ukl5zK4
	ri5+Uspr9e9tNFOOJI6qHBMgyoDImWeYgIRoJeoSQCiiJZL/GRDOHe6ZkSAAS1+6
	f/7kf0cISla6IeRY+76IwFUjy2FQjotxgNj0Kd8j2UXGNwQPOK5FhcsErjgXOTX+
	5OSHfCp1bOU6P5m9Kwtgx3og6GTAIoAmU+NcauCMagWGRMvBZY427fTQDChzV6rd
	20SQgp9opvdnpgr74Tn7ywIcNNt7zNRAe9m3b3QgvzBRXvXHAmY5iCvkwJ08BU5o
	uk15sMB6LZSWrvrswK+HaEJeMnED8fsV5Q5jkA77SM4+gXGV5jqQcXSX+WCLUvCr
	LP/jg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkd2av6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LIU699040090;
	Fri, 21 Jun 2024 18:43:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pp0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFX8032040;
	Fri, 21 Jun 2024 18:43:24 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-4;
	Fri, 21 Jun 2024 18:43:24 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 03/10] iommufd/selftest: Add tests for <= u8 bitmap sizes
Date: Fri, 21 Jun 2024 19:42:47 +0100
Message-Id: <20240621184254.45477-4-joao.m.martins@oracle.com>
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
 phishscore=0 spamscore=0 mlxlogscore=828 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-GUID: NCCGiPAo7g9Wceg0N-eOUkiW4g8lgiMu
X-Proofpoint-ORIG-GUID: NCCGiPAo7g9Wceg0N-eOUkiW4g8lgiMu

Add more tests for bitmaps smaller than or equal to an u8, though skip the
tests if the IOVA buffer size is smaller than the mock page size.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
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

