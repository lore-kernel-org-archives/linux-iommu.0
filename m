Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8861EF956
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067714; cv=none; b=btedkQqeK83HgLqbRLo5fo7G1SFRHBCGKV0BH4mLVhV0p5OBQgAXD1zA49ytr+Tfeha6XAQTMpWpMmDboKodJB1WqNG320ru7etSUB31R/J3ZancWYRHpTkNZMAjxN4MrFog1HMsdd3nZwsyvEkICMnjoo+HViO3wzJzNPj0x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067714; c=relaxed/simple;
	bh=hcsJjKHqocOcj/h//SKZxHleg1XAMHX4W4blWh/FO1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mHIU0xSmucEbofLgYoQcxMK0v98jFvwuJjB80nrUxqao2AHyDhJEUn7MuyjvDAMcxalceThbLRdIJeNtgerwxp89cJAAyaFpjbnhR3J400dqP6lntmfrI6diPQYDFnNYrYeb9LeGcUc6etIHVW6u0FMw0QGBIs79StquoISd9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KAsF12sI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KAsF12sI"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfdYl027793;
	Fri, 4 Oct 2024 18:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=wQyhyK/O9rqX46o+SCp/sTpY7215bH6WbtXLXzhhZig=; b=
	KAsF12sIXu9qEpui9aqriS63QVRtbGqeOpD4wcBKu6jIXghZyy5dLXEUl/XlvaYj
	05A4l4LCJDCx2aImMXMoFFenNAucmZaHrJ6AubjFTrEw03J6SeyDLOxnxdYqj4AT
	ns08QrADRoPDzIFkiIGLb5SpYTAD8X/elT4KZ44eu0q3YBkSjtMVoqqi50DwqLTa
	U6yteEN1XHh9nlWAz7dv1WhDJukAokOIOaMtUsbkNp4Z9vIlqpL70ZMlzfkdjm87
	sNMWHmSt2rzNIsKngR0pk7WuQF2bOe8z0FdWXhyY7BsWvRTZD/S0EBEr+q2H46JY
	dU8rf3Rr7zTwo8Iv5ITdVA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422049291h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494HFEWo038116;
	Fri, 4 Oct 2024 18:48:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLaC029789;
	Fri, 4 Oct 2024 18:48:28 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-9;
	Fri, 04 Oct 2024 18:48:28 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 8/9] iommufd: optimize file mapping
Date: Fri,  4 Oct 2024 11:48:19 -0700
Message-Id: <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: n6V0pOJFI1G_ORMwhhEx70tcMOK-6M7I
X-Proofpoint-ORIG-GUID: n6V0pOJFI1G_ORMwhhEx70tcMOK-6M7I
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

When filling a batch, avoid the intermediate step of expanding folios
into upages[] in pin_memfd_pages, via the new helper functions
batch_from_folios_huge and batch_add_pfn_num.

However, we must still expand to upages for the iopt_pages_fill path.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 146 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2db2b06..b57c2b9 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -347,25 +347,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 		kfree(batch->pfns);
 }
 
-/* true if the pfn was added, false otherwise */
-static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+/* returns the number of pfn's added */
+static int batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
+			     unsigned long nr)
 {
-	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
+	const unsigned long MAX_NPFNS = type_max(typeof(*batch->npfns));
+	unsigned long pfn_end, npfn_end;
+	unsigned long n = 0;
 
-	if (batch->end &&
-	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
-	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
-		batch->npfns[batch->end - 1]++;
-		batch->total_pfns++;
-		return true;
+	if (batch->end) {
+		npfn_end = batch->npfns[batch->end - 1];
+		pfn_end = batch->pfns[batch->end - 1];
+
+		if (pfn == pfn_end + npfn_end && npfn_end < MAX_NPFNS) {
+			n = min_t(unsigned long, MAX_NPFNS - npfn_end, nr);
+			batch->npfns[batch->end - 1] += n;
+			batch->total_pfns += n;
+			if (nr == n)
+				return n;
+			nr -= n;
+		}
 	}
 	if (batch->end == batch->array_size)
-		return false;
-	batch->total_pfns++;
+		return n;
+	nr = min_t(unsigned long, MAX_NPFNS, nr);
+	batch->total_pfns += nr;
 	batch->pfns[batch->end] = pfn;
-	batch->npfns[batch->end] = 1;
+	batch->npfns[batch->end] = nr;
 	batch->end++;
-	return true;
+	return n + nr;
+}
+
+/* true if the pfn was added, false otherwise */
+static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+{
+	return batch_add_pfn_num(batch, pfn, 1) == 1;
 }
 
 /*
@@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
 			break;
 }
 
+static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
+			      size_t npages)
+{
+	struct folio **end = folios + npages;
+
+	for (; folios != end; folios++)
+		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
+			break;
+}
+
+static void batch_from_folios_huge(struct pfn_batch *batch,
+				   struct folio ***folios_p,
+				   unsigned long *offset_p,
+				   unsigned long npages)
+{
+	unsigned long nr, n, pfn, i = 0;
+	struct folio *folio, **folios = *folios_p;
+	unsigned long offset = *offset_p;
+
+	while (npages) {
+		folio = folios[i++];
+		nr = folio_nr_pages(folio) - offset;
+		nr = min_t(unsigned long, nr, npages);
+		while (nr) {
+			pfn = page_to_pfn(folio_page(folio, offset));
+			n = batch_add_pfn_num(batch, pfn, nr);
+			if (n == 0) {
+				*folios_p = folios + i - 1;
+				*offset_p = offset;
+				return;
+			}
+			npages -= n;
+			nr -= n;
+			offset += n;
+		}
+		offset = 0;
+	}
+}
+
+static void folios_unpin_partial(struct folio **folios, unsigned long offset,
+				 unsigned long npages)
+{
+	unsigned long nr, i = 0;
+	struct folio *folio;
+	struct page *page;
+
+	while (npages) {
+		folio = folios[i++];
+		nr = folio_nr_pages(folio);
+		if (offset == 0 && nr < npages) {
+			unpin_folio(folio);
+		} else {
+			nr = min_t(unsigned long, npages, nr - offset);
+			page = folio_page(folio, offset);
+			unpin_user_page_range_dirty_lock(page, nr, false);
+			offset = 0;
+		}
+		npages -= nr;
+	}
+}
+
 static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
 			unsigned int first_page_off, size_t npages)
 {
@@ -709,6 +786,9 @@ struct pfn_reader_user {
 	struct file *file;
 	struct folio **ufolios;
 	unsigned long ufolios_len;
+	unsigned long ufolios_offset;
+	struct folio **ufolios_next;
+	bool ufolios_huge;
 };
 
 static void pfn_reader_user_init(struct pfn_reader_user *user,
@@ -726,6 +806,9 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
 	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
 	user->ufolios = NULL;
 	user->ufolios_len = 0;
+	user->ufolios_huge = false;
+	user->ufolios_next = NULL;
+	user->ufolios_offset = 0;
 }
 
 static void pfn_reader_user_destroy(struct pfn_reader_user *user,
@@ -763,6 +846,8 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 		return nfolios;
 
 	offset >>= PAGE_SHIFT;
+	user->ufolios_next = user->ufolios;
+	user->ufolios_offset = offset;
 	npages_out = 0;
 
 	for (i = 0; i < nfolios; i++) {
@@ -774,8 +859,11 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 			if (rc)
 				return rc;
 		}
-		for (j = offset; j < offset + npin; j++)
-			*upages++ = folio_page(folio, j);
+		if (nr > 1)
+			user->ufolios_huge = true;
+		if (upages)
+			for (j = offset; j < offset + npin; j++)
+				*upages++ = folio_page(folio, j);
 		npages -= npin;
 		npages_out += npin;
 		offset = 0;
@@ -799,7 +887,7 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	    WARN_ON(last_index < start_index))
 		return -EINVAL;
 
-	if (!user->upages) {
+	if (!user->file && !user->upages) {
 		/* All undone in pfn_reader_destroy() */
 		user->upages_len = npages * sizeof(*user->upages);
 		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
@@ -812,11 +900,6 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 		user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
 		if (!user->ufolios)
 			return -ENOMEM;
-
-		/* Bail for now.  Be more robust when we optimize for folios. */
-		if (user->ufolios_len / sizeof(*user->ufolios) <
-		    user->upages_len / sizeof(*user->upages))
-			return -ENOMEM;
 	}
 
 	if (user->locked == -1) {
@@ -1087,7 +1170,16 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 
 	npages = user->upages_end - start_index;
 	start_index -= user->upages_start;
-	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
+
+	if (!user->file)
+		batch_from_pages(&pfns->batch, user->upages + start_index,
+				 npages);
+	else if (!user->ufolios_huge)
+		batch_from_folios(&pfns->batch, user->ufolios + start_index,
+				  npages);
+	else
+		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
+				       &user->ufolios_offset, npages);
 	return 0;
 }
 
@@ -1169,7 +1261,15 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
 
 		npages = user->upages_end - pfns->batch_end_index;
 		start_index = pfns->batch_end_index - user->upages_start;
-		unpin_user_pages(user->upages + start_index, npages);
+
+		if (!user->file)
+			unpin_user_pages(user->upages + start_index, npages);
+		else if (!user->ufolios_huge)
+			unpin_folios(user->ufolios + start_index, npages);
+		else
+			folios_unpin_partial(user->ufolios_next,
+					     user->ufolios_offset, npages);
+
 		iopt_pages_sub_npinned(pages, npages);
 		user->upages_end = pfns->batch_end_index;
 	}
-- 
1.8.3.1

