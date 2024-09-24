Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD011A76DC
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190348; cv=none; b=IDfPy6oUmW9PcEM1pBen7okTLjgDpYHcp/jTGn9MR7CnKJnpaJRhBMlt42XVdM35q6NsHGJghJXhYLyy+9UfeBEl10S9ePG0NLx5DP6o+qAdrsnaath/LZ29jbVOV0hUnLpXITJhmPN2Cgk30RqIOfdZHmvJxW9bCYJO50TGaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190348; c=relaxed/simple;
	bh=KZjdyh5vGsENRZTQi5l+fWN5Z77sms7J//gpSKX8eaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fMdtC0DSj6sHv74EqklVP+KFePXKmww0cPIJM0KheIfv+uGD/n20Wg+r4QCs2M06P7PRLdpslQiRrM2R1WlQOrlcKr7vJcWyisPo43eROKOykDrZ7d/ZGz1j+ACG0wMlhJu4YoAfA3NX/lTPvznxHOzdY4fbOadg/s+9u5ANXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=affJKcPC; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="affJKcPC"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQVuu000936;
	Tue, 24 Sep 2024 15:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=/t31P1E4Uz7ZevOG1ek+rB10H3+IoxiB8gVISIwNPho=; b=
	affJKcPCip4gwyCK2YwlXTzopTZBiYwI9liLlfBl9YM52ifPdvB+NHY2WoaUIRBh
	NkX/7YbhJvSR0QvPEf10NWv/ls5k7kDQ+yEzefUdDA4iy6Qd2uUrwIDu9jrq6pov
	J3xkPrPf5cG8mHQx3/2gtoInbxhj5ls4S/TTIzOseJ/WEEwtXQRExx0aSf4lEv4s
	1gZ33FAeSqPVm2ERNoPsfH2ywE4D01wCLfwWr1sqew75xx+LzF71r8puZzZRF0Hl
	F8Be8Sa7KNC+u/iWJbdomJyVNbJqBxIUk+ofzJdUvTlhpYeZxF9ejxliP5Y8u7oL
	v7tYTX65V9rhucKFGDSHjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx359rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEDOZ1004790;
	Tue, 24 Sep 2024 15:05:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cr2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLH027122;
	Tue, 24 Sep 2024 15:05:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-4;
	Tue, 24 Sep 2024 15:05:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/9] iommufd: pfn reader for file mappings
Date: Tue, 24 Sep 2024 08:05:32 -0700
Message-Id: <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: NcLLzlPJJL-f8FVeMz-heBT2fJQbgVMT
X-Proofpoint-GUID: NcLLzlPJJL-f8FVeMz-heBT2fJQbgVMT
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
 drivers/iommu/iommufd/io_pagetable.h |  5 +++
 drivers/iommu/iommufd/pages.c        | 86 +++++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 11 deletions(-)

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
index 69822d4..df5ba4f 100644
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
@@ -731,6 +740,45 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 
 	kfree(user->upages);
 	user->upages = NULL;
+	kfree(user->ufolios);
+	user->ufolios = NULL;
+}
+
+static long pin_memfd_pages(struct pfn_reader_user *user,
+			    unsigned long start,
+			    unsigned long npages)
+{
+	unsigned long end, nr, i, j, npin, offset, npages_out;
+	long nfolios;
+	struct folio *folio;
+	struct page **upages = user->upages;
+
+	nfolios = user->ufolios_len / sizeof(*user->ufolios);
+	end = start + (npages << PAGE_SHIFT) - 1;
+
+	nfolios = memfd_pin_folios(user->file, start, end,
+				   user->ufolios, nfolios, &offset);
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
+		if (nr > 1) {
+			folio_split_user_page_pin(folio, npin);
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
@@ -739,7 +787,8 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			       unsigned long last_index)
 {
 	bool remote_mm = pages->source_mm != current->mm;
-	unsigned long npages;
+	unsigned long npages = last_index - start_index + 1;
+	unsigned long start, unum;
 	uintptr_t uptr;
 	long rc;
 
@@ -749,14 +798,25 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 
 	if (!user->upages) {
 		/* All undone in pfn_reader_destroy() */
-		user->upages_len =
-			(last_index - start_index + 1) * sizeof(*user->upages);
+		user->upages_len = npages * sizeof(*user->upages);
 		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
 		if (!user->upages)
 			return -ENOMEM;
 	}
 
-	if (user->locked == -1) {
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
+	if (!user->file && user->locked == -1) {
 		/*
 		 * The majority of usages will run the map task within the mm
 		 * providing the pages, so we can optimize into
@@ -769,18 +829,22 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
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
-- 
1.8.3.1

