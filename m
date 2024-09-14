Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580B1CE70E
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319172; cv=none; b=mEcro1ybN+2jffzFCsVWi7grwAZZjYeUddbVrr7uYcYeY8CZniG0kZYWKmKJGcRH7jP9abFKweE50cEooZeJHv9/GbFpd/CJfxJYkxcy1rXOjExDFCg1c5zG3g2roku+cuaRO5r1mZIoyar8UaciUm5BYEkJ4y8xd6rlCOYB4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319172; c=relaxed/simple;
	bh=RkziL61plPKF1IdbirkiSdHEGD0wwN6CCMD13T4Oe6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FWbW/DeGJz2+gJHGfjruupWkqIYl5UKd0HA+JwVHhFOQlD4SvYcuiVbFhXoPbu7H6+OBJHK6BUqeIeIILaPF7MZWRZkSWQ4MSDRhbjC9IRXWnmiSle9HJ8oqJtIKnWga0O13EnSuuuKsGPiRSxPzwOAhB9KTapa7pPYbWGkzMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WuTYMZGq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WuTYMZGq"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EABgL3006251;
	Sat, 14 Sep 2024 13:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=8UN9+a0fWD/20nExV11zPYmvVq+hgCI6my9g8E0Pt5M=; b=
	WuTYMZGqdmlamaoeIbpyHDcEKIH5S/5t81xW8Mbzm+2HYop3NHlipKrP3sTzI58I
	6zSkcEO7D53CTwJSzfSxhd+A59q9RFRCd4GSN9s5l6gL93HHaN2+i5sh/bKLU05Y
	ZHcoVazS1A07tkKalPIACenPX923hkNKnAWKpu37kJ0c+gSjdBrfeigaddgWdcf/
	vJ87Dcsh1IMHPlXMqY74Vjlucv+Oq1kyCPaGmqzS1B5YqvIWYlgdHjB0JcSC3U1H
	2QvMnJaTBgKHx/VWnIrw9oCovLbpUZVNCQgD7PzYBpxT2y4n6thBA1Q8dBzEtmxS
	8IJEhhowYQKCx605szxbuQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdgdru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E9NrV1019203;
	Sat, 14 Sep 2024 13:06:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jV024307;
	Sat, 14 Sep 2024 13:06:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-10;
	Sat, 14 Sep 2024 13:06:07 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 9/9] iommufd: optimize file mapping
Date: Sat, 14 Sep 2024 06:05:58 -0700
Message-Id: <1726319158-283074-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140092
X-Proofpoint-GUID: QkmGnj5PEvNB8Vsf_g_SMT_QXkKwDsJ3
X-Proofpoint-ORIG-GUID: QkmGnj5PEvNB8Vsf_g_SMT_QXkKwDsJ3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Avoid expanding a huge folio into multiple upages[] in pin_memfd_pages by
adding a page count nupages[i] for each upages[i].  Provide the function
batch_from_pages_num to efficiently add counted pages to a pfn_batch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 75 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index f6c7c90..5cc0d57 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -347,26 +347,34 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 }
 
 /* true if the pfn was added, false otherwise */
-static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
+			      unsigned long nr)
 {
 	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
+	unsigned long max_npfns = MAX_NPFNS - nr;
 
 	if (batch->end &&
 	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
-	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
-		batch->npfns[batch->end - 1]++;
-		batch->total_pfns++;
+	    batch->npfns[batch->end - 1] <= max_npfns) {
+		batch->npfns[batch->end - 1] += nr;
+		batch->total_pfns += nr;
 		return true;
 	}
 	if (batch->end == batch->array_size)
 		return false;
-	batch->total_pfns++;
+	batch->total_pfns += nr;
 	batch->pfns[batch->end] = pfn;
-	batch->npfns[batch->end] = 1;
+	batch->npfns[batch->end] = nr;
 	batch->end++;
 	return true;
 }
 
+/* true if the pfn was added, false otherwise */
+static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+{
+	return batch_add_pfn_num(batch, pfn, 1);
+}
+
 /*
  * Fill the batch with pfns from the domain. When the batch is full, or it
  * reaches last_index, the function will return. The caller should use
@@ -622,6 +630,20 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
 			break;
 }
 
+static void batch_from_pages_num(struct pfn_batch *batch, struct page **pages,
+				 u32 *npages,
+				 size_t total_pages)
+{
+	unsigned long num;
+
+	while (total_pages) {
+		num = min_t(unsigned long, *npages++, total_pages);
+		if (!batch_add_pfn_num(batch, page_to_pfn(*pages++), num))
+			break;
+		total_pages -= num;
+	}
+}
+
 static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
 			unsigned int first_page_off, size_t npages)
 {
@@ -695,6 +717,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
 struct pfn_reader_user {
 	struct page **upages;
 	unsigned long upages_num;
+	u32 *nupages;
 	struct file *file;
 	unsigned long upages_start;
 	unsigned long upages_end;
@@ -714,6 +737,7 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
 	user->upages_end = 0;
 	user->locked = -1;
 	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
+	user->nupages = NULL;
 
 	user->gup_flags = FOLL_LONGTERM;
 	if (pages->writable)
@@ -733,6 +757,8 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 
 	kfree(user->upages);
 	user->upages = NULL;
+	kfree(user->nupages);
+	user->nupages = NULL;
 }
 
 static long pin_memfd_pages(struct pfn_reader_user *user,
@@ -764,8 +790,13 @@ static long pin_memfd_pages(struct pfn_reader_user *user,
 			nr = folio_nr_pages(folio);
 			npin = min(nr - pgoff, npages);
 			repin_folio_unhugely(folio, npin);
-			for (j = pgoff; j < pgoff + npin; j++)
-				user->upages[k++] = folio_page(folio, j);
+			if (user->nupages) {
+				user->upages[k] = &folio->page;
+				user->nupages[k++] = npin;
+			} else {
+				for (j = pgoff; j < pgoff + npin; j++, k++)
+					user->upages[k] = folio_page(folio, j);
+			}
 			npages -= npin;
 			start += npin << PAGE_SHIFT;
 			pgoff = 0;
@@ -798,6 +829,17 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 		if (!user->upages)
 			return -ENOMEM;
 		user->upages_num = len / sizeof(*user->upages);
+
+		if (user->file) {
+			len = user->upages_num * sizeof(*user->nupages);
+			user->nupages = temp_kmalloc(&len, NULL, 0);
+			if (!user->nupages ||
+			    len != user->upages_num * sizeof(*user->nupages)) {
+				kfree(user->upages);
+				user->upages = NULL;
+				/* nupages is optional.  proceed without it. */
+			}
+		}
 	}
 
 	if (!user->file && user->locked == -1) {
@@ -1025,6 +1067,7 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
+	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
 
@@ -1062,10 +1105,18 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 			return rc;
 	}
 
-	batch_from_pages(&pfns->batch,
-			 pfns->user.upages +
-				 (start_index - pfns->user.upages_start),
-			 pfns->user.upages_end - start_index);
+	npages = pfns->user.upages_end - start_index;
+	start_index -= pfns->user.upages_start;
+
+	if (pfns->user.nupages)
+		batch_from_pages_num(&pfns->batch,
+				     pfns->user.upages + start_index,
+				     pfns->user.nupages + start_index,
+				     npages);
+	else
+		batch_from_pages(&pfns->batch,
+				 pfns->user.upages + start_index,
+				 npages);
 	return 0;
 }
 
-- 
1.8.3.1

