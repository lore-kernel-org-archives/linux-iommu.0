Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66A4654B
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880915; cv=none; b=fNf4o6H0VZM6mFY95y7fyjbwhedHCPOcszfRYrN0vOT5ZB0dHyvyqY3ezQGvJwCiSYw8HsqNabaxxFuiphnIOAlsgfg+K9oOXsNq5DMYRSlYjrtJJx6TpO2T2FZIkPYr0UyJCyzjII1CqdVG9hR4BMkkMxVtA9gDrd+s/1/1ND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880915; c=relaxed/simple;
	bh=J3xNlJf2ILu9grrCygIkd30+kg/e7qW0pYmfgbTuIDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SC1MGWj2b4OvhgUyWooqQVYkp5iDJaK+Gfd+733X50EmBTkT34h9hyucAi4V9UELy0T7DqjpVyOWq8FIizSXp2RZl2N136aqcXH23L5BQ/IwKcyV5aQ9ZSvYeCBcbd/C3PXfxUdYcRmWkF6jpZBlrxYHIyg5bhxOBMdEY6LoJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=St3ZU5Aa; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="St3ZU5Aa"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQu5Q016549;
	Fri, 2 Feb 2024 13:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=8aCb01CzxNZQFvlKIUEgg/gN5ZPXIb0r5JY4fe+jsZs=;
 b=St3ZU5AaFpwFECQaR3yobSFik4TFYhjMm262AR3LRyYCv1HjyLSWuc3tIiaVqd/aWBEB
 6waa9nVqNZfvevE68cV5HCFUkQ67h437Eyn/HNMJc/ofgmrFVIYH7dKMpwcwusyNvVtd
 CXCRXr/w8aaxx/OCfDnjtMgY5gT1OfHELeoglg+Dhg6xfao/+IlJq1MKgF0d/pioz0UO
 sECnD92kFOERAQqNvtxq0543KJSYP/XndeZybHW6ZpcAwyw/0alHV94iy9+MsKrRjcn+
 JCxjlFIr6aLrlStm9+X/BCWbi6vXlk5/y00FwMWrZRexOfh0YmWXSz+6JJZw8VlF9j28 sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuqf6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BT9fu024701;
	Fri, 2 Feb 2024 13:35:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buf5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAn022185;
	Fri, 2 Feb 2024 13:35:03 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-5;
	Fri, 02 Feb 2024 13:35:03 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 4/9] iommufd/iova_bitmap: Handle recording beyond the mapped pages
Date: Fri,  2 Feb 2024 13:34:10 +0000
Message-Id: <20240202133415.23819-5-joao.m.martins@oracle.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-ORIG-GUID: uW1sUhlthy3erc5HclfRizjvMjLzzAFD
X-Proofpoint-GUID: uW1sUhlthy3erc5HclfRizjvMjLzzAFD

IOVA bitmap is a zerocopy scheme of recording dirty bits that iterate the
different bitmap user pages at chunks of maximum of PAGE_SIZE/sizeof(struct
page*) pages.

When the iterations are split up into 64G, the end of the range may be
broken up in a way that's aligned with a non base page PTE size. This leads
to only part of the huge page being recorded in the bitmap. Note that in
pratice this is only a problem for IOMMU dirty tracking i.e. when the
backing PTEs are in IOMMU hugepages and the bitmap is in base page
granularity. So far this not something that affects VF dirty trackers
(which reports and records at the same granularity).

To fix that, if there is a remainder of bits left to set in which the
current IOVA bitmap doesn't cover, make a copy of the bitmap structure and
iterate-and-set the rest of the bits remaining. Finally, when advancing the
iterator, skip all the bits that were set ahead.

Reported-by: Avihai Horon <avihaih@nvidia.com>
Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
Fixes: 421a511a293f ("iommu/amd: Access/Dirty bit support in IOPTEs")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 9d42ab51a6bb..b370e8ee8866 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -113,6 +113,9 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	/* length of the IOVA range set ahead the pinned pages */
+	unsigned long set_ahead_length;
 };
 
 /*
@@ -341,6 +344,32 @@ static bool iova_bitmap_done(struct iova_bitmap *bitmap)
 	return bitmap->mapped_base_index >= bitmap->mapped_total_index;
 }
 
+static int iova_bitmap_set_ahead(struct iova_bitmap *bitmap,
+				 size_t set_ahead_length)
+{
+	int ret = 0;
+
+	while (set_ahead_length > 0 && !iova_bitmap_done(bitmap)) {
+		unsigned long length = iova_bitmap_mapped_length(bitmap);
+		unsigned long iova = iova_bitmap_mapped_iova(bitmap);
+
+		ret = iova_bitmap_get(bitmap);
+		if (ret)
+			break;
+
+		length = min(length, set_ahead_length);
+		iova_bitmap_set(bitmap, iova, length);
+
+		set_ahead_length -= length;
+		bitmap->mapped_base_index +=
+			iova_bitmap_offset_to_index(bitmap, length - 1) + 1;
+		iova_bitmap_put(bitmap);
+	}
+
+	bitmap->set_ahead_length = 0;
+	return ret;
+}
+
 /*
  * Advances to the next range, releases the current pinned
  * pages and pins the next set of bitmap pages.
@@ -357,6 +386,15 @@ static int iova_bitmap_advance(struct iova_bitmap *bitmap)
 	if (iova_bitmap_done(bitmap))
 		return 0;
 
+	/* Iterate, set and skip any bits requested for next iteration */
+	if (bitmap->set_ahead_length) {
+		int ret;
+
+		ret = iova_bitmap_set_ahead(bitmap, bitmap->set_ahead_length);
+		if (ret)
+			return ret;
+	}
+
 	/* When advancing the index we pin the next set of bitmap pages */
 	return iova_bitmap_get(bitmap);
 }
@@ -426,5 +464,10 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 		kunmap_local(kaddr);
 		cur_bit += nbits;
 	} while (cur_bit <= last_bit);
+
+	if (unlikely(cur_bit <= last_bit)) {
+		bitmap->set_ahead_length =
+			((last_bit - cur_bit + 1) << bitmap->mapped.pgshift);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_set, IOMMUFD);
-- 
2.17.2

