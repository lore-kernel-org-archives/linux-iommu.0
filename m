Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CB1EF09D
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067707; cv=none; b=KMJoI3xhEaIEF4Jlhg6n32k2QRNz8GxhGqRJuEE5QpjJg2eoP64Lk3+uNnda/3/jVz0XOESmVl42Rz1pbGBRZPP7Dx2f6a2HBy/DG8Z7g1Hi3+QmmRcIgSnPUj6gKZ+2GKhd1ovPcYlVMKziVJSmKKSDfIBcdQCTG+eqkT+7k5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067707; c=relaxed/simple;
	bh=kul78alzB3B+gAktzEsX893mxzxsp0h7DAERN8ykjmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pCKEzuvEqD86nI+xj2BE/WDyqifXJkAfGwK5Ohu2itq+ywGq9Ax7fI97Hqy4Uvxbqs6hd6jsFNe8P0Hi8IG6dwjNLHwhI7VHBEIbJYfYugqvdUWVxI7tb81L9gp4fKyx5KtL/rq9gNFRgpuoN2a0B8gHcb7hi7phGcMVieW9XY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VMtb/n2b; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VMtb/n2b"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Hfedl027838;
	Fri, 4 Oct 2024 18:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=4I2ONSOQ4huCzfq4U4a9gK8HWJKb7OxJvCXP2ZZJshE=; b=
	VMtb/n2bXE+9LpEx/1eV+PELYNto7G9TPcEtdtC/p8klGOlyEndWCJwQ9F4p0eUZ
	xJvDNYT6Hy7p+45H6oX4Q+3WcuOGNiqcT2WnucZTJHHnfsYpp+kWg7yLuGhqlrsu
	4AkWedqecHyZssjpyjD6TWUzdXmLQ3Mlqbnn9lqNqVVfUXymDNt5taS1NaGk4zAE
	WQQ/dBIe946dta2TwqveYtSHHOLCUAsTU/PSm2NMF8VFAyoVX4nKGWx41lG7NEuA
	UYxQBJh3Kv1JmVk/6nakT0ywiTrYyUecVW2ujeAu//ajKPouiY9pBMg/nkOVtcND
	3RN2Oj3oCOSbjNx9zAPY1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220492919-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H5B6E038110;
	Fri, 4 Oct 2024 18:48:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLZw029789;
	Fri, 4 Oct 2024 18:48:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-2;
	Fri, 04 Oct 2024 18:48:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 1/9] mm/gup: folio_add_pins
Date: Fri,  4 Oct 2024 11:48:12 -0700
Message-Id: <1728067700-32092-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040129
X-Proofpoint-GUID: OEBlUqZ6m8ZK5w65tkx15Dd0kpaSS2zN
X-Proofpoint-ORIG-GUID: OEBlUqZ6m8ZK5w65tkx15Dd0kpaSS2zN
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Export a function that adds pins to an already-pinned huge-page folio.
This allows any range of small pages within the folio to be unpinned later.
For example, pages pinned via memfd_pin_folios and modified by
folio_add_pins could be unpinned via unpin_user_page(s).

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 13bff7c..70d5293 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2521,6 +2521,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		      struct folio **folios, unsigned int max_folios,
 		      pgoff_t *offset);
+int folio_add_pins(struct folio *folio, unsigned int pins);
 
 int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
diff --git a/mm/gup.c b/mm/gup.c
index fcd602b..11c5f27 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3733,3 +3733,27 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(memfd_pin_folios);
+
+/**
+ * folio_add_pins() - add pins to an already-pinned folio
+ * @folio: the folio to add more pins to
+ * @pins: number of pins to add
+ *
+ * Try to add more pins to an already-pinned folio. The semantics
+ * of the pin (e.g., FOLL_WRITE) follow any existing pin and cannot
+ * be changed.
+ *
+ * This function is helpful when having obtained a pin on a large folio
+ * using memfd_pin_folios(), but wanting to logically unpin parts
+ * (e.g., individual pages) of the folio later, for example, using
+ * unpin_user_page_range_dirty_lock().
+ *
+ * This is not the right interface to initially pin a folio.
+ */
+int folio_add_pins(struct folio *folio, unsigned int pins)
+{
+	VM_WARN_ON_ONCE(!folio_maybe_dma_pinned(folio));
+
+	return try_grab_folio(folio, pins, FOLL_PIN);
+}
+EXPORT_SYMBOL_GPL(folio_add_pins);
-- 
1.8.3.1

