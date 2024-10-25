Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE9176227
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861932; cv=none; b=WbbQ5ooHNZLugbBfWafQQtMcli21R0YSNLxUNTnIUhteCJa9xmwjBEtESKBM0OEEPjnuXqEnTkizeiZkPcLi0VN2pZQrR0T3J1XhxfyifoeMqpRNM03fXLlVZASn5luVUfVlxZHdUFm6oYUjZtGRP1gKT0GCUcsK+pJAPFzddkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861932; c=relaxed/simple;
	bh=t4oJbnmmzadftq5K1F09vqLM6QCaADn6CA60AZjhmlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WFP0YFQw6QLw3GMKoIfs8/3c6V3QKK+Oa7GGMevZmap1FNHckrvLdcusUQe8JJfAOnmwQyDBU7tQIDkILV5k4jVvKRuARXK9IkwrKDqXDEqKZ7oC+81B0IRwKp8GV/7ivGTOW95g9vjWCoTEjChwOz4tVcactr0NNU7kMqCAyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QLpPiuiq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLpPiuiq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTdPa000565;
	Fri, 25 Oct 2024 13:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=rHaQASGr7hrJRJISAPPlTKAPUk7cHiKZrek2bqLZ1tM=; b=
	QLpPiuiqdF61szAVdsPzlrVNmnUwSf0wctH57DbBvQJKv9eUL/S+3Yt0jrz49Ciz
	6/LzBdMFT9YA2ajrI8CzxY7/7OFlFoZTCvUQEC1VIlKTMIxbM15wZba8zW4Dlcgr
	y+83+fIPq5Wat7p7tjs7q/UnUskAIB4mCZC3vcm+avba1TaegogeDxaRbqkmztBN
	RqH424WE1z5yb8tAnLF3XkJgMNzNSFpDPnl7LMcWOvJUF7aHF7gmGap3sEbj6H6d
	LJ2AsGMzldeBbmNAE1wO+JHx7SUGtNGZuwBHjKuoYrodAThVqmHcaqo+0ixTI16m
	LdqdFQ1LWmXEy0ozkR8eeA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qmwdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxnNO016399;
	Fri, 25 Oct 2024 13:12:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Ro000657;
	Fri, 25 Oct 2024 13:12:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-7;
	Fri, 25 Oct 2024 13:12:05 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Date: Fri, 25 Oct 2024 06:11:56 -0700
Message-Id: <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250102
X-Proofpoint-ORIG-GUID: xgcYWuFZTclBpcoE8sRwO_K-YM5Qp2dw
X-Proofpoint-GUID: xgcYWuFZTclBpcoE8sRwO_K-YM5Qp2dw
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
Repin at small page granularity, and fill the batch from folios.  Expand
folios to upages for the iopt_pages_fill path.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/io_pagetable.h |   5 ++
 drivers/iommu/iommufd/pages.c        | 128 ++++++++++++++++++++++++++++++-----
 2 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 8e48266..5ac4eed 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -177,6 +177,7 @@ enum {
 
 enum iopt_address_type {
 	IOPT_ADDRESS_USER = 0,
+	IOPT_ADDRESS_FILE = 1,
 };
 
 /*
@@ -202,6 +203,10 @@ struct iopt_pages {
 	enum iopt_address_type type;
 	union {
 		void __user *uptr;		/* IOPT_ADDRESS_USER */
+		struct {			/* IOPT_ADDRESS_FILE */
+			struct file *file;
+			unsigned long start;
+		};
 	};
 	bool writable:1;
 	u8 account_mode;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index aa79504..5f371fa 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -752,19 +752,32 @@ struct pfn_reader_user {
 	 * neither
 	 */
 	int locked;
+
+	/* The following are only valid if file != NULL. */
+	struct file *file;
+	struct folio **ufolios;
+	size_t ufolios_len;
+	unsigned long ufolios_offset;
+	struct folio **ufolios_next;
 };
 
 static void pfn_reader_user_init(struct pfn_reader_user *user,
 				 struct iopt_pages *pages)
 {
 	user->upages = NULL;
+	user->upages_len = 0;
 	user->upages_start = 0;
 	user->upages_end = 0;
 	user->locked = -1;
-
 	user->gup_flags = FOLL_LONGTERM;
 	if (pages->writable)
 		user->gup_flags |= FOLL_WRITE;
+
+	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
+	user->ufolios = NULL;
+	user->ufolios_len = 0;
+	user->ufolios_next = NULL;
+	user->ufolios_offset = 0;
 }
 
 static void pfn_reader_user_destroy(struct pfn_reader_user *user,
@@ -773,13 +786,67 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 	if (user->locked != -1) {
 		if (user->locked)
 			mmap_read_unlock(pages->source_mm);
-		if (pages->source_mm != current->mm)
+		if (!user->file && pages->source_mm != current->mm)
 			mmput(pages->source_mm);
 		user->locked = -1;
 	}
 
 	kfree(user->upages);
 	user->upages = NULL;
+	kfree(user->ufolios);
+	user->ufolios = NULL;
+}
+
+static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
+			    unsigned long npages)
+{
+	unsigned long i;
+	unsigned long offset;
+	unsigned long npages_out = 0;
+	struct page **upages = user->upages;
+	unsigned long end = start + (npages << PAGE_SHIFT) - 1;
+	long nfolios = user->ufolios_len / sizeof(*user->ufolios);
+
+	/*
+	 * todo: memfd_pin_folios should return the last pinned offset so
+	 * we can compute npages pinned, and avoid looping over folios here
+	 * if upages == NULL.
+	 */
+	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
+				   nfolios, &offset);
+	if (nfolios <= 0)
+		return nfolios;
+
+	offset >>= PAGE_SHIFT;
+	user->ufolios_next = user->ufolios;
+	user->ufolios_offset = offset;
+
+	for (i = 0; i < nfolios; i++) {
+		struct folio *folio = user->ufolios[i];
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long npin = min(nr - offset, npages);
+
+		npages -= npin;
+		npages_out += npin;
+
+		if (upages) {
+			if (npin == 1) {
+				*upages++ = folio_page(folio, offset);
+			} else {
+				int rc = folio_add_pins(folio, npin - 1);
+
+				if (rc)
+					return rc;
+
+				while (npin--)
+					*upages++ = folio_page(folio, offset++);
+			}
+		}
+
+		offset = 0;
+	}
+
+	return npages_out;
 }
 
 static int pfn_reader_user_pin(struct pfn_reader_user *user,
@@ -788,7 +855,9 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			       unsigned long last_index)
 {
 	bool remote_mm = pages->source_mm != current->mm;
-	unsigned long npages;
+	unsigned long npages = last_index - start_index + 1;
+	unsigned long start;
+	unsigned long unum;
 	uintptr_t uptr;
 	long rc;
 
@@ -796,40 +865,50 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	    WARN_ON(last_index < start_index))
 		return -EINVAL;
 
-	if (!user->upages) {
+	if (!user->file && !user->upages) {
 		/* All undone in pfn_reader_destroy() */
-		user->upages_len =
-			(last_index - start_index + 1) * sizeof(*user->upages);
+		user->upages_len = npages * sizeof(*user->upages);
 		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
 		if (!user->upages)
 			return -ENOMEM;
 	}
 
+	if (user->file && !user->ufolios) {
+		user->ufolios_len = npages * sizeof(*user->ufolios);
+		user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
+		if (!user->ufolios)
+			return -ENOMEM;
+	}
+
 	if (user->locked == -1) {
 		/*
 		 * The majority of usages will run the map task within the mm
 		 * providing the pages, so we can optimize into
 		 * get_user_pages_fast()
 		 */
-		if (remote_mm) {
+		if (!user->file && remote_mm) {
 			if (!mmget_not_zero(pages->source_mm))
 				return -EFAULT;
 		}
 		user->locked = 0;
 	}
 
-	npages = min_t(unsigned long, last_index - start_index + 1,
-		       user->upages_len / sizeof(*user->upages));
-
+	unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
+			    user->upages_len / sizeof(*user->upages);
+	npages = min_t(unsigned long, npages, unum);
 
 	if (iommufd_should_fail())
 		return -EFAULT;
 
-	uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
-	if (!remote_mm)
+	if (user->file) {
+		start = pages->start + (start_index * PAGE_SIZE);
+		rc = pin_memfd_pages(user, start, npages);
+	} else if (!remote_mm) {
+		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
 		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
 					 user->upages);
-	else {
+	} else {
+		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
 		if (!user->locked) {
 			mmap_read_lock(pages->source_mm);
 			user->locked = 1;
@@ -887,7 +966,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 		mmap_read_unlock(pages->source_mm);
 		user->locked = 0;
 		/* If we had the lock then we also have a get */
-	} else if ((!user || !user->upages) &&
+
+	} else if ((!user || (!user->upages && !user->ufolios)) &&
 		   pages->source_mm != current->mm) {
 		if (!mmget_not_zero(pages->source_mm))
 			return -EINVAL;
@@ -1068,8 +1148,15 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 
 	npages = user->upages_end - start_index;
 	start_index -= user->upages_start;
-	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
-	return 0;
+	rc = 0;
+
+	if (!user->file)
+		batch_from_pages(&pfns->batch, user->upages + start_index,
+				 npages);
+	else
+		rc = batch_from_folios(&pfns->batch, &user->ufolios_next,
+				       &user->ufolios_offset, npages);
+	return rc;
 }
 
 static bool pfn_reader_done(struct pfn_reader *pfns)
@@ -1151,7 +1238,14 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
 		unsigned long start_index = pfns->batch_end_index -
 					    user->upages_start;
 
-		unpin_user_pages(user->upages + start_index, npages);
+		if (!user->file) {
+			unpin_user_pages(user->upages + start_index, npages);
+		} else {
+			long n = user->ufolios_len / sizeof(*user->ufolios);
+
+			unpin_folios(user->ufolios_next,
+				     user->ufolios + n - user->ufolios_next);
+		}
 		iopt_pages_sub_npinned(pages, npages);
 		user->upages_end = pfns->batch_end_index;
 	}
-- 
1.8.3.1

