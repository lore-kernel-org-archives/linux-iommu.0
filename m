Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81C1CEE88
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319168; cv=none; b=OVV+wJMz17FGQHemzGfPOiVRJ3rIstQSJznexAW4xphR8o/tgO1KsJ60xWN+2MHN3jnTlRNUVfek39Q1zPiwZbsaITIfiVZMcMYhfVUZuUirzHTxVAeWv9Bj2GASHq9qd/J1HwmVQcbUSAv+fugZWCp9kINjf9XUdJ5xGLKij0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319168; c=relaxed/simple;
	bh=/8lGIHJ/F9d+0vIMvXuYL4HFrxvmgZ1zswjwWd96wMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XgyJw34oWb2pkNr9pJMf0nRIJrY84QTX1H90o4NZZgWQLT6r8cwsILcxJny0uEA5DwJvKao2QIJ0IoNzogw9Ru1qHZdPRcjcxVz15x+yHyj5Qp0XmAA2tQ8UKcdzdx7PeK05tFz8/Wz9ZfnXvWCrAGqzklIY2VsWm7BkRUBDzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aKLkGIWd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aKLkGIWd"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EABZAT030793;
	Sat, 14 Sep 2024 13:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=NmhlYslk5PN172VLuYD4MZx6Hi8sfIdpJF2rx2U07qY=; b=
	aKLkGIWd+kwbzaxwMP3aDBqJd5XWOUTUtgv/FyUt7/DzcC3bDU+22U9Ko4WMtMjS
	onJjn1h0YNavNgmwNsofY1qgyIaHS8p2dEEruoYZNeVbufnhW5kUJma7//HMhyuk
	kYzkES4AGijsz5APp4/Dsoru6t13Nok+IVraxqoA1Nx/YSF4QH4/r8O3mJTZGvlR
	iMkaTZKhydovMSOCS++yWNR9QwHuI0CwH8GCO6WyCjwRrtDV81JbSA77A4/+8/1a
	l7UukF/+/XytCe1X2WJ3nWhEMIlBhHOPLgbID3k5Ih4gM9mDIqvJ/3AHO0T0W3rC
	Wba4tKiYOrnrgtpafnZvyg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjrdpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E9k5vf019233;
	Sat, 14 Sep 2024 13:06:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jL024307;
	Sat, 14 Sep 2024 13:06:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-5;
	Sat, 14 Sep 2024 13:06:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 4/9] iommufd: pfn reader for file mappings
Date: Sat, 14 Sep 2024 06:05:53 -0700
Message-Id: <1726319158-283074-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: S5oSArIvigXx8Q3BoZXspAhluLt_LaUh
X-Proofpoint-GUID: S5oSArIvigXx8Q3BoZXspAhluLt_LaUh
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
Repin at small page granularity and unpack pages into upages[] to mesh
with the existing code paths.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 ++++
 drivers/iommu/iommufd/pages.c        | 58 ++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

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
index 69822d4..065c28f 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -695,6 +695,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
 struct pfn_reader_user {
 	struct page **upages;
 	size_t upages_len;
+	struct file *file;
 	unsigned long upages_start;
 	unsigned long upages_end;
 	unsigned int gup_flags;
@@ -712,6 +713,7 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
 	user->upages_start = 0;
 	user->upages_end = 0;
 	user->locked = -1;
+	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
 
 	user->gup_flags = FOLL_LONGTERM;
 	if (pages->writable)
@@ -733,13 +735,54 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 	user->upages = NULL;
 }
 
+static long pin_memfd_pages(struct pfn_reader_user *user,
+			    unsigned long start,
+			    unsigned long npages)
+{
+	unsigned long end, nr, i, j, k, npin, nfolios, pgoff, max_folios;
+	unsigned long npages_orig = npages;
+	struct folio *folio;
+	size_t size = npages * sizeof(folio);
+	struct folio **folios = temp_kmalloc(&size, NULL, 0);
+
+	if (!folios)
+		return -ENOMEM;
+
+	k = 0;
+	max_folios = size / sizeof(folio);
+	end = start + (npages << PAGE_SHIFT) - 1;
+
+	while (npages > 0) {
+		nfolios = memfd_pin_folios(user->file, start, end,
+					   folios, max_folios, &pgoff);
+		if (nfolios <= 0)
+			return nfolios;
+
+		pgoff >>= PAGE_SHIFT;
+		for (i = 0; i < nfolios; i++) {
+			folio = folios[i];
+			nr = folio_nr_pages(folio);
+			npin = min(nr - pgoff, npages);
+			repin_folio_unhugely(folio, npin);
+			for (j = pgoff; j < pgoff + npin; j++)
+				user->upages[k++] = folio_page(folio, j);
+			npages -= npin;
+			start += npin << PAGE_SHIFT;
+			pgoff = 0;
+		}
+	}
+
+	kfree(folios);
+	return npages_orig;
+}
+
 static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			       struct iopt_pages *pages,
 			       unsigned long start_index,
 			       unsigned long last_index)
 {
 	bool remote_mm = pages->source_mm != current->mm;
-	unsigned long npages;
+	unsigned long npages, start;
 	uintptr_t uptr;
 	long rc;
 
@@ -756,7 +799,7 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			return -ENOMEM;
 	}
 
-	if (user->locked == -1) {
+	if (!user->file && user->locked == -1) {
 		/*
 		 * The majority of usages will run the map task within the mm
 		 * providing the pages, so we can optimize into
@@ -772,15 +815,18 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	npages = min_t(unsigned long, last_index - start_index + 1,
 		       user->upages_len / sizeof(*user->upages));
 
-
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

