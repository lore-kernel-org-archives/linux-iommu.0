Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864046426
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880909; cv=none; b=FZx3quloCz82XC5ATw9OEb2vrHMU1s8YxyhX+kT0/ltRewepEj9yO50zHuLRBtA7+QA4kbJUs+kkVx7I77H+Nfz6Nt+Lb4Sbo5c32hsQ1rlIK2TSKg3nrIwQd+sbbhZoPknP/aMPtYpKLrWANqIn0BQgGaddDdlFzfjNaItXfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880909; c=relaxed/simple;
	bh=hs2AmEL0wh4ke7z7ZsKxtJZDcPFgt1RsQSkAgChRtB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C25AlYbdmxCVRspC0kmGuxdR9orA0KeOC2AWWfDcPQDI3p3rrPiQd8dcN5tWSMOf9fieRQcxmC+miqvqzhEdtUAjw/l3uoha4sywYWYtDUEKn8gRGafitdr1hurSnmdIlhB7oWoeqs3qnLXtOcjCgF9Bu+UCnw6GvIyN5NE5yJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvboxsEY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvboxsEY"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQtt5012261;
	Fri, 2 Feb 2024 13:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=l4npwqjVxmnOCq4WdiIwR6Oe3cwKAZaoBgSbdQBL7lk=;
 b=hvboxsEYEGyQ1cIuxRgvwyZ0615kXl6AQz6a/D7NaswlUHAh2zNVtgJEefMrtVYpn417
 5iXvTr9LzmLqoRr5+Me+1hGGZrBN20yUvdnx86smU5cZ7zj3dtpPDlnWZlA/xt2ILEpC
 Wft2za7ArfVV6jEtYRxKvhkRuEIxfvKKtgI87JDDXkZ9AIe2QBa0hKDLoQOMSPl6QQrZ
 9L5qy5AOWRYCWTU9WZXqUvB62lhnnrnZiHmHFnSSZoDjo5NWyue84Xn/0QnVgwNNgBJ4
 8WsOTooXgrobLUBX2gHC5vhID7O0V+kcgSrSCGus9uGVa8V09jXcqanyYM8h1rXVT+5r Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv7mfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:34:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BT8xW024495;
	Fri, 2 Feb 2024 13:34:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buf0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:34:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAh022185;
	Fri, 2 Feb 2024 13:34:55 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-2;
	Fri, 02 Feb 2024 13:34:55 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 1/9] iommufd/iova_bitmap: Bounds check mapped::pages access
Date: Fri,  2 Feb 2024 13:34:07 +0000
Message-Id: <20240202133415.23819-2-joao.m.martins@oracle.com>
In-Reply-To: <20240202133415.23819-1-joao.m.martins@oracle.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=912 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-ORIG-GUID: 8_Xv9YoocJYKJuQfu9_HmEsj_YiUQm4P
X-Proofpoint-GUID: 8_Xv9YoocJYKJuQfu9_HmEsj_YiUQm4P

Dirty IOMMU hugepages on a base page page-size granularity can lead to an
attempt to set dirty pages in the bitmap beyond the limits that are pinned.

Bounds check the page index of the array we are trying to access is within
the limits before we kmap() and return otherwise.

While it is also a defensive check, this is also in preparation to defer
setting bits (outside the mapped range) to the next iteration(s) when the
pages become available.

Fixes: b058ea3ab5af ("vfio/iova_bitmap: refactor iova_bitmap_set() to better handle page boundaries")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 0a92c9eeaf7f..a3606b4c2229 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -409,6 +409,7 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 			mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
 	unsigned long last_bit = (((iova + length - 1) - mapped->iova) >>
 			mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
+	unsigned long last_page_idx = mapped->npages - 1;
 
 	do {
 		unsigned int page_idx = cur_bit / BITS_PER_PAGE;
@@ -417,6 +418,9 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 					 last_bit - cur_bit + 1);
 		void *kaddr;
 
+		if (unlikely(page_idx > last_page_idx))
+			break;
+
 		kaddr = kmap_local_page(mapped->pages[page_idx]);
 		bitmap_set(kaddr, offset, nbits);
 		kunmap_local(kaddr);
-- 
2.17.2

