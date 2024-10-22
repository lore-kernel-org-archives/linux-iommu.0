Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E2153BE4
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630845; cv=none; b=X1ulNH5ZjdvkT9XmdR7RTTD89mhBxquvaevG2rwFzBEf8zDpYV+PbXOQq//CI3H2jPDya4PyHBMuckwJfVyTgwscRTmzb1ZmVrueYcFXpMHJwb83FM6pVEPJDgknmK/r/Jsuq5GkhGPlERejtuH70E2OI2ffC7dc4ol3xboAs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630845; c=relaxed/simple;
	bh=975ZlWrtltl9tmjelYdfVdmVkrY/EgswLs1eBXVDGI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D1P4f925iUS6SSD+a9eoPnvWumaGaJMd7JnlMCLZ3QR7m74kqJi0D8dD7XqeTwP6vZZL2FVrJ0GV9ssaHGKIxZQpLK4BSxdMtWQV7r08tNIQKlqTygPv8Wt1HL3Dm5iXDyIn3Vop5tWtr3LNrm4ugUwbxHX40CRYYPGrYqr3Vbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RYkTrAIh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RYkTrAIh"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqLn5009702;
	Tue, 22 Oct 2024 21:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=LzaKpkZYRJZsQLdeV5e4KMjA+eBDzDZi/X3sdKgMo4c=; b=
	RYkTrAIhm9ovT8XaW3Mnc8y8NuCh5uHoFdCpjhiNtbwORE8lS3u99w07JRzhWYRZ
	tLquyIrcG/Wx53DLqHGdDK3qtOiEA6rKZAPfw5ouoTFHYlANiT9BkDHBID2gzZti
	E08Lvn39XeSdyCPTzLw4zGoxB0q2C8XrTHXprdwxDsgm4xLwcTGO6LciDm+LEShV
	qBjsJuKfSaiCEFGQj3VJY9WEpHvEyR2Qw5ORgyd9/I7H8RlBcV5O5aSYDcJF9ZZN
	jDlxRCguUBYOHiFT2xh48kO5nXb0K+Dt3LD+kjT3kR9+5mdpG3TjO9X+WkwrNQIk
	7RF88OJDr8Rj7hFxnEWxEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5456s6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJpfIF012058;
	Tue, 22 Oct 2024 21:00:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781aak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEc016716;
	Tue, 22 Oct 2024 21:00:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-2;
	Tue, 22 Oct 2024 21:00:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 1/9] mm/gup: folio_add_pins
Date: Tue, 22 Oct 2024 14:00:30 -0700
Message-Id: <1729630838-24586-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220135
X-Proofpoint-ORIG-GUID: OiFEb4A-bpf2lw-smiPmmNM76HGYmffr
X-Proofpoint-GUID: OiFEb4A-bpf2lw-smiPmmNM76HGYmffr
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
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2..f9de33a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2524,6 +2524,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		      struct folio **folios, unsigned int max_folios,
 		      pgoff_t *offset);
+int folio_add_pins(struct folio *folio, unsigned int pins);
 
 int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
diff --git a/mm/gup.c b/mm/gup.c
index a82890b..4ac3e567 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3717,3 +3717,27 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
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

