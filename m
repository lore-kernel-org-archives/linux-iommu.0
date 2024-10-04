Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152291EF92A
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067710; cv=none; b=in5TyMuiSDP/lLjhYvLDVKFN80C5wL2J3NuKjJrZzWwwQ6LPihMB59uYHMK0PDfzx6dyy/rYkaESMBcZ3gpvM4ewL6IuEA3mFC38cYc619DcZcGSobsjw0ExCmebhP//kpM2xnxSsxLltF4VwDt6JEG1+ojehVyICVvmAPR5jFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067710; c=relaxed/simple;
	bh=PkaQ7XDc8Qyy8EV2dT1ktjBqxjx8M/GxbPN7OlqhFFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UrUMYWArfprZM9iYYNPOJ9d6GeIL3urPJ3y/tSCoN9CySXRXAHFQwUHf+CRd8b3oHupLrZaVYNf6J/w337BAWBVCnwwAdUDzOfpT4ygSxl+mf1AZ++S/CkgTkaRsLdogQl+SxrmWwnCyvQm5n4/7DPzym5R5kKTQfua1DBlsmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sme/KhRT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sme/KhRT"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfeWk027821;
	Fri, 4 Oct 2024 18:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=gv2FVlKdvf22UQzmrrpppQKzJXS9I7Da7h2GouaQqIo=; b=
	Sme/KhRTSdhCe6PiRxz+viUZSDR1BeUTxdl7LJbM9ocaegDhai7GziEhlXstzuXb
	YLGTc/VpvlbGwWfBNJVovsrWgUhyn1e6twA2rYPExOSTWZpkXBueGUTVK0NzSI7K
	M6MOKr/cbhvPIeLPoyzZTEELaUDNVVo9EFL+jAAn+DOWWDYJ3QWQIpO54/63lbu9
	H6EsEXzhPEjfVSqvcD1MKZWita9BD3KN1vC03VhHZ2LZcFK+rNdh6iWBzhWlrRw2
	fDmJiRUYP8zz2Zu3OBxHitDmF7oG97ek5N3gjxsEyr7piae1gxjAjUmziiWIVgRa
	3hHEOsx8UcRo3euFQlW9Yw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422049291d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494HC22x038181;
	Fri, 4 Oct 2024 18:48:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:25 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLa4029789;
	Fri, 4 Oct 2024 18:48:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-5;
	Fri, 04 Oct 2024 18:48:25 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 4/9] iommufd: pfn reader for file mappings
Date: Fri,  4 Oct 2024 11:48:15 -0700
Message-Id: <1728067700-32092-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: nMGhQ72BxDYhOtw7m435DsEljs70LKg1
X-Proofpoint-ORIG-GUID: nMGhQ72BxDYhOtw7m435DsEljs70LKg1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
Repin at small page granularity and unpack pages into upages[] to mesh
with the existing code paths.  This is sub-optimal but simple, and will be
optimized in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 ++
 drivers/iommu/iommufd/pages.c        | 91 +++++++++++++++++++++++++++++++-----
 2 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 7c4a338..3a28f46 100644
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
index 5419795..bb60af1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -703,19 +703,28 @@ struct pfn_reader_user {
 	 * neither
 	 */
 	int locked;
+
+	/* The following are only valid if file != NULL. */
+	struct file *file;
+	struct folio **ufolios;
+	unsigned long ufolios_len;
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
 }
 
 static void pfn_reader_user_destroy(struct pfn_reader_user *user,
@@ -731,6 +740,47 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 
 	kfree(user->upages);
 	user->upages = NULL;
+	kfree(user->ufolios);
+	user->ufolios = NULL;
+}
+
+static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
+			    unsigned long npages)
+{
+	unsigned long end, nr, i, j, npin, offset, npages_out;
+	long nfolios;
+	int rc;
+	struct folio *folio;
+	struct page **upages = user->upages;
+
+	nfolios = user->ufolios_len / sizeof(*user->ufolios);
+	end = start + (npages << PAGE_SHIFT) - 1;
+
+	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
+				   nfolios, &offset);
+	if (nfolios <= 0)
+		return nfolios;
+
+	offset >>= PAGE_SHIFT;
+	npages_out = 0;
+
+	for (i = 0; i < nfolios; i++) {
+		folio = user->ufolios[i];
+		nr = folio_nr_pages(folio);
+		npin = min(nr - offset, npages);
+		if (npin > 1) {
+			rc = folio_add_pins(folio, npin - 1);
+			if (rc)
+				return rc;
+		}
+		for (j = offset; j < offset + npin; j++)
+			*upages++ = folio_page(folio, j);
+		npages -= npin;
+		npages_out += npin;
+		offset = 0;
+	}
+
+	return npages_out;
 }
 
 static int pfn_reader_user_pin(struct pfn_reader_user *user,
@@ -739,7 +789,8 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			       unsigned long last_index)
 {
 	bool remote_mm = pages->source_mm != current->mm;
-	unsigned long npages;
+	unsigned long npages = last_index - start_index + 1;
+	unsigned long start, unum;
 	uintptr_t uptr;
 	long rc;
 
@@ -749,38 +800,53 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 
 	if (!user->upages) {
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
+
+		/* Bail for now.  Be more robust when we optimize for folios. */
+		if (user->ufolios_len / sizeof(*user->ufolios) <
+		    user->upages_len / sizeof(*user->upages))
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
@@ -838,7 +904,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 		mmap_read_unlock(pages->source_mm);
 		user->locked = 0;
 		/* If we had the lock then we also have a get */
-	} else if ((!user || !user->upages) &&
+
+	} else if ((!user || (!user->upages && !user->ufolios)) &&
 		   pages->source_mm != current->mm) {
 		if (!mmget_not_zero(pages->source_mm))
 			return -EINVAL;
-- 
1.8.3.1

