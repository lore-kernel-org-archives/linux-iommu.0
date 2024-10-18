Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C169205AB4
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286868; cv=none; b=DSOtmarkjgzVwiuNDpZJ708P2PQcorjJylKY9Z86ns2+30YYMrROOcjDbkRMqueVpjtuF7GFxcRFoVpesuJayh9e8HDGMMQtHSIR2PpTeAmEiiVspHRbo9KEfQCNyY6oAsUwvyvWiLSpqVAoINbKfv/zxInOUd02cU7HoFUnHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286868; c=relaxed/simple;
	bh=7EdoV+n40/mjuYBwaXdcsARTeEWlyIhF7VUQrt5KL4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lD6yl5DIS/Ij3cLHPvlJIRiApESIK/zjX6PuIAPO1fg2WHvUoPQiGn8tihZKu5CrYmtc84Q6Yk5zSrCxUP1YjulxfrOfEBqYLYfsSr5XTJ6qR4HV/LRaTGp2s3/03S8B3L1j6a6JDEU26vX8ZWw7wMKLKAvMvP1zmfWraRx40Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YwnJ0Bpf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YwnJ0Bpf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBglG014724;
	Fri, 18 Oct 2024 21:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=Lf+asg64GqSaHbt8oWomnEQGLKQe46whHMFMexnRyUk=; b=
	YwnJ0BpfA+2VC1JGg5Q7mc9jG+3EhBz58zdPQsO10iB0HqAwUVNXedKu4f8RNsn9
	kNCGK+YP6+HTACgixMQ7i1i4vQqW9a19bwLa515bqPylZ7Re9qB1g/VJ7DgEOhGe
	csiNbDCzo/kR31SgTceYkIBtVRpQJBaCoWsxOIN/hyEMg13ufr6DBIh+Tdh0V3Nx
	tb6ZM60TkgxLdGKw/dhQGcM6ZXmhu7XrMycCDV+45F6DyO0XlVbkRmQkNKg5u1GB
	6+URkv4ysegqkz+ki1+woU6J/acK8KqiisiuOBRZlwFBgjaWnYzBpc/LqpS4U3YW
	UwhEv2NU18nuAWYHi2YO2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ashxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJZDiV027123;
	Fri, 18 Oct 2024 21:27:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVl023093;
	Fri, 18 Oct 2024 21:27:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-7;
	Fri, 18 Oct 2024 21:27:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 6/9] iommufd: pfn reader for file mappings
Date: Fri, 18 Oct 2024 14:27:33 -0700
Message-Id: <1729286856-127844-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180137
X-Proofpoint-GUID: ituDrecKnOTwZLMVEhXmNtNttnaHNi-W
X-Proofpoint-ORIG-GUID: ituDrecKnOTwZLMVEhXmNtNttnaHNi-W
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
Repin at small page granularity, and fill the batch from folios.  Expand
folios to upages for the iopt_pages_fill path.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.h |   5 ++
 drivers/iommu/iommufd/pages.c        | 111 ++++++++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 15 deletions(-)

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
index c9ca9e0..9c88b0d 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -770,19 +770,32 @@ struct pfn_reader_user {
 	 * neither
 	 */
 	int locked;
+
+	/* The following are only valid if file != NULL. */
+	struct file *file;
+	struct folio **ufolios;
+	unsigned long ufolios_len;
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
@@ -798,6 +811,50 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 
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
+	unsigned long j;
+	unsigned long offset;
+	unsigned long npages_out = 0;
+	struct page **upages = user->upages;
+	unsigned long end = start + (npages << PAGE_SHIFT) - 1;
+	long nfolios = user->ufolios_len / sizeof(*user->ufolios);
+
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
+		if (npin > 1) {
+			int rc = folio_add_pins(folio, npin - 1);
+
+			if (rc)
+				return rc;
+		}
+		if (upages)
+			for (j = offset; j < offset + npin; j++)
+				*upages++ = folio_page(folio, j);
+		npages -= npin;
+		npages_out += npin;
+		offset = 0;
+	}
+
+	return npages_out;
 }
 
 static int pfn_reader_user_pin(struct pfn_reader_user *user,
@@ -806,7 +863,9 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			       unsigned long last_index)
 {
 	bool remote_mm = pages->source_mm != current->mm;
-	unsigned long npages;
+	unsigned long npages = last_index - start_index + 1;
+	unsigned long start;
+	unsigned long unum;
 	uintptr_t uptr;
 	long rc;
 
@@ -814,40 +873,50 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
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
@@ -905,7 +974,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 		mmap_read_unlock(pages->source_mm);
 		user->locked = 0;
 		/* If we had the lock then we also have a get */
-	} else if ((!user || !user->upages) &&
+
+	} else if ((!user || (!user->upages && !user->ufolios)) &&
 		   pages->source_mm != current->mm) {
 		if (!mmget_not_zero(pages->source_mm))
 			return -EINVAL;
@@ -1086,7 +1156,13 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 
 	npages = user->upages_end - start_index;
 	start_index -= user->upages_start;
-	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
+
+	if (!user->file)
+		batch_from_pages(&pfns->batch, user->upages + start_index,
+				 npages);
+	else
+		batch_from_folios(&pfns->batch, &user->ufolios_next,
+				  &user->ufolios_offset, npages);
 	return 0;
 }
 
@@ -1169,7 +1245,12 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
 		unsigned long start_index = pfns->batch_end_index -
 					    user->upages_start;
 
-		unpin_user_pages(user->upages + start_index, npages);
+		if (!user->file)
+			unpin_user_pages(user->upages + start_index, npages);
+		else
+			folios_unpin_partial(user->ufolios_next,
+					     user->ufolios_offset, npages);
+
 		iopt_pages_sub_npinned(pages, npages);
 		user->upages_end = pfns->batch_end_index;
 	}
-- 
1.8.3.1

