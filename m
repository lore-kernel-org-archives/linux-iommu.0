Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908081AB534
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190352; cv=none; b=AQX9t2wP8dznLMGMluoLtIuoIKHC9aAIsNDPlc8+R8ySw8BSIsazTvjFweOlUBEuti3Dqfk1C9S7sv5m8CvjGtgkmSo91JRyS3o+5bSBrenxL6K4og+IhtgibnqPdH0RCUd03yG3OU4/CyPg3KlCf/w2QEYMQ+14nDPAeKWUtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190352; c=relaxed/simple;
	bh=ay5b5bTmD/uzF8zoC0aXiFPNP9m1YxbA6mwWvaNvd3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gvASf4yle2u/Gjxvyt5vCqv0v+qVHyYpQVsNkTdut63HqQ1Opi5G5/1CEhyokRniDlweNy6N81TAn5Wea0VJBDXQLGUSXH6JNDUnxOeUPI/wsebRkq7bt5/Qh0TBXE8uuDnziqf/KIn/349Zgr04YQ7Ln+8b0Z3EYRBexxnIJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/yRM5Ca; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/yRM5Ca"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQYQ2032407;
	Tue, 24 Sep 2024 15:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=3UYSe8p2zykF8ajuveIPmLtNtSs/V2ei7G5gLLuDrBE=; b=
	B/yRM5Ca5VhRB3eEd5LbmhvkTAYsI6fNyfJoJZKzvLEpTOeRgNjNOo+/ATob3ZAf
	gHjJNZXmWHUa8Lt/svxuZ42eZAwm5tTjjA0yiNw8RGrq1EK/rtjQqBXbR91qfKKG
	xEwm0tqEVgeHBurjXFc7Hf/d3bd612q1rsU9cC+/gLMaQpllyxvEh51vrwAPhW/t
	tgZXXR22LZ/mqVsgxmiIma3YHiBU8MgkRl9pOn4dHGU9tcSS+tL0zFW/iNg3TkI0
	/V3rKNNeeEuvuftojXWgk7KgxHoVTkTHTlVAVPhcBpqqPYkXrSQc8mdc0ws7lmco
	f6CSx6afJUEfeFPI9ur6eQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7qcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48ODpI7T004679;
	Tue, 24 Sep 2024 15:05:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cr7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLR027122;
	Tue, 24 Sep 2024 15:05:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-9;
	Tue, 24 Sep 2024 15:05:47 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 8/9] iommufd: optimize file mapping
Date: Tue, 24 Sep 2024 08:05:37 -0700
Message-Id: <1727190338-385692-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240108
X-Proofpoint-GUID: uyTtJdKYWb5tQfjinEZRvcl3Y0r8upDB
X-Proofpoint-ORIG-GUID: uyTtJdKYWb5tQfjinEZRvcl3Y0r8upDB
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

When filling a batch, avoid the intermediate step of expanding folios into
upages[] in pin_memfd_pages, via the new helper functions batch_from_folios
and batch_add_pfn_num.

However, we must still expand to upages for the iopt_pages_fill path.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 129 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 6e11189..8aeccb3 100644
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
@@ -622,6 +630,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
 			break;
 }
 
+static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
+			      unsigned long offset, unsigned long npages)
+{
+	unsigned long nr, pfn, i = 0;
+	struct folio *folio;
+
+	while (npages) {
+		folio = folios[i++];
+		nr = folio_nr_pages(folio) - offset;
+		nr = min_t(unsigned long, nr, npages);
+		pfn = page_to_pfn(folio_page(folio, offset));
+		batch_add_pfn_num(batch, pfn, nr);
+		offset = 0;
+		npages -= nr;
+	}
+}
+
+/*
+ * Return the folio containing the page which is @start_index pages beyond
+ * page number @offset in folios[0].  Return the index of that page in
+ * @offset_out.
+ */
+static struct folio **folios_start(struct folio **folios, unsigned long offset,
+				   unsigned long start_index,
+				   unsigned long *offset_out)
+{
+	unsigned long nr = folio_nr_pages(*folios);
+
+	while (offset + start_index > nr) {
+		start_index -= (nr - offset);
+		offset = 0;
+		folios++;
+		nr = folio_nr_pages(*folios);
+	}
+
+	*offset_out = offset + start_index;
+	return folios;
+}
+
+static void folios_unpin_partial(struct folio **folios, unsigned long offset,
+				 unsigned long npages)
+{
+	unsigned long nr, j, i = 0;
+	struct folio *folio;
+
+	while (npages) {
+		folio = folios[i++];
+		nr = folio_nr_pages(folio);
+		if (offset == 0 && nr < npages) {
+			unpin_folio(folio);
+		} else {
+			nr = min_t(unsigned long, npages, nr - offset);
+			for (j = 0; j < nr; j++)
+				unpin_user_page(folio_page(folio, offset + j));
+			offset = 0;
+		}
+		npages -= nr;
+	}
+
+}
+
 static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
 			unsigned int first_page_off, size_t npages)
 {
@@ -708,6 +777,8 @@ struct pfn_reader_user {
 	struct file *file;
 	struct folio **ufolios;
 	unsigned long ufolios_len;
+	unsigned long ufolios_offset;
+	bool ufolios_huge;
 };
 
 static void pfn_reader_user_init(struct pfn_reader_user *user,
@@ -725,6 +796,8 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
 	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
 	user->ufolios = NULL;
 	user->ufolios_len = 0;
+	user->ufolios_huge = 0;
+	user->ufolios_offset = 0;
 }
 
 static void pfn_reader_user_destroy(struct pfn_reader_user *user,
@@ -762,6 +835,7 @@ static long pin_memfd_pages(struct pfn_reader_user *user,
 		return nfolios;
 
 	offset >>= PAGE_SHIFT;
+	user->ufolios_offset = offset;
 	npages_out = 0;
 
 	for (i = 0; i < nfolios; i++) {
@@ -770,9 +844,11 @@ static long pin_memfd_pages(struct pfn_reader_user *user,
 		npin = min(nr - offset, npages);
 		if (nr > 1) {
 			folio_split_user_page_pin(folio, npin);
+			user->ufolios_huge = true;
 		}
-		for (j = offset; j < offset + npin; j++)
-			*upages++ = folio_page(folio, j);
+		if (upages)
+			for (j = offset; j < offset + npin; j++)
+				*upages++ = folio_page(folio, j);
 		npages -= npin;
 		npages_out += npin;
 		offset = 0;
@@ -796,7 +872,7 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	    WARN_ON(last_index < start_index))
 		return -EINVAL;
 
-	if (!user->upages) {
+	if (!user->file && !user->upages) {
 		/* All undone in pfn_reader_destroy() */
 		user->upages_len = npages * sizeof(*user->upages);
 		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
@@ -809,11 +885,6 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 		user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
 		if (!user->ufolios)
 			return -ENOMEM;
-
-		/* Bail for now.  Be more robust when we optimize for folios. */
-		if (user->ufolios_len / sizeof(*user->ufolios) <
-		    user->upages_len / sizeof(*user->upages))
-			return -ENOMEM;
 	}
 
 	if (!user->file && user->locked == -1) {
@@ -1045,6 +1116,8 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 	unsigned long start_index = pfns->batch_end_index;
 	struct pfn_reader_user *user = &pfns->user;
 	unsigned long npages;
+	unsigned long offset;
+	struct folio **folios;
 	struct iopt_area *area;
 	int rc;
 
@@ -1084,7 +1157,18 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 
 	npages = user->upages_end - start_index;
 	start_index -= user->upages_start;
-	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
+
+	if (!user->file) {
+		batch_from_pages(&pfns->batch, user->upages + start_index,
+				 npages);
+	} else if (!user->ufolios_huge) {
+		batch_from_folios(&pfns->batch, user->ufolios + start_index, 0,
+				  npages);
+	} else {
+		folios = folios_start(user->ufolios, user->ufolios_offset,
+				      start_index, &offset);
+		batch_from_folios(&pfns->batch, folios, offset, npages);
+	}
 	return 0;
 }
 
@@ -1160,13 +1244,26 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
 	struct iopt_pages *pages = pfns->pages;
 	struct pfn_reader_user *user = &pfns->user;
 	unsigned long npages, start_index;
+	unsigned long offset;
+	struct folio **folios;
 
 	if (user->upages_end > pfns->batch_end_index) {
 		/* Any pages not transferred to the batch are just unpinned */
 
 		npages = user->upages_end - pfns->batch_end_index;
 		start_index = pfns->batch_end_index - user->upages_start;
-		unpin_user_pages(user->upages + start_index, npages);
+
+		if (!user->file) {
+			unpin_user_pages(user->upages + start_index, npages);
+		} else if (!user->ufolios_huge) {
+			unpin_folios(user->ufolios + start_index, npages);
+		} else {
+			folios = folios_start(user->ufolios,
+					      user->ufolios_offset,
+					      start_index, &offset);
+			folios_unpin_partial(folios, offset, npages);
+		}
+
 		iopt_pages_sub_npinned(pages, npages);
 		user->upages_end = pfns->batch_end_index;
 	}
-- 
1.8.3.1

