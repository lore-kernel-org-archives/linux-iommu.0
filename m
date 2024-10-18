Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72834205131
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286864; cv=none; b=jbV5vr6TUk90LXkEy7MN6+mEweROXmFPRhz9G/jeq/5w2XHXlrAvLJ3OduYb0hyJMteB6rNhmvyT2nbsb3aL8+V5sqJlnM2lQPCoMBu3jO7cqohy8+f4BmzJ4aHwaprD6606l12ad5KaG5OQw3LWGVChy51M2qzJ4PQZRPjqmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286864; c=relaxed/simple;
	bh=975ZlWrtltl9tmjelYdfVdmVkrY/EgswLs1eBXVDGI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mb/e2U2GFcyRSST/2e0RlaycSLYwC8zGesh9TgCL8plkdnslazz6LvVfXJY1HQ7ugLa+STYFrmbp7fzdFZ0nK67e+QxlEjuESdcmZnM17U89JGfTgUbrqRkKtuSs/dzb0TgCgUfNzO8ujPEeA+62h6bkd5EzTt7Zx9gMLmW7HIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nCIz+j8P; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCIz+j8P"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBhdw014731;
	Fri, 18 Oct 2024 21:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=LzaKpkZYRJZsQLdeV5e4KMjA+eBDzDZi/X3sdKgMo4c=; b=
	nCIz+j8PuavgCCbcEJuWIUttbqDVgT7kZE23um+AivNrHlB3+dUcdXKO+03+6m2Y
	CGhgi19z+Z+5pGr7ndLOKn6OlbLBXrjkD4XGL/VaDl3Jze1X3Tg/kXH27kB5B5GA
	nt+Zj2GO/5ZCD0Hdl9R24IEWjeY1VRA5eCvbbOI3g70e9ne0I8Es1polu3o5Myqg
	W9XzQvnc0LVyZGjIP4OGXd6KZgwLILXYRF1FRwFWeuAQDiyUq48+JAxWIxYiMNXQ
	jsN+Jn2IitUAwWNRMI+ockqDh/GpbgbjzmVCiuRMm/s/4FY1fCro5MfPiY9JbHsO
	2s0zG/h8tBzeGDH3Rwf/iA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ashxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJZDiR027123;
	Fri, 18 Oct 2024 21:27:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVb023093;
	Fri, 18 Oct 2024 21:27:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-2;
	Fri, 18 Oct 2024 21:27:38 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 1/9] mm/gup: folio_add_pins
Date: Fri, 18 Oct 2024 14:27:28 -0700
Message-Id: <1729286856-127844-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: fufgwvtkCjJWYvX5pXhhxUBQMsfWvIPw
X-Proofpoint-ORIG-GUID: fufgwvtkCjJWYvX5pXhhxUBQMsfWvIPw
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

