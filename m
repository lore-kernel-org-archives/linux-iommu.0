Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857821632E2
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861926; cv=none; b=mRFPhuUISzhoXMrBDqqvMDPYny7+3/yYQemd5kJqypsFZuPqzTI9eXbO92NJQTUEIJpkv8m7usUbrWy1ojL4/eoOT9IyDzLyXUPdj+JS3xwhkZbnyuMBnrcIVcCmnkze8+bUfA48nJ98h9XY39l5/sAmOhws7RrQIwO5l0UhAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861926; c=relaxed/simple;
	bh=975ZlWrtltl9tmjelYdfVdmVkrY/EgswLs1eBXVDGI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aJVWM0AuL86087Ri5xeqFeLQtFrVvcyFE9FU8HJIViTPYH92OqT6trwBVlcDLCbPk1A93tu9vcNDAa0DSL+sqN4Rs1VtwMrG6jY5a0wUfMZhOWEKHVqbghZcUtSzeQMncrgD0mIWQD+EsMzn3Rly8VtjWVE3+U6wKj4fi6pjBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XB8RTaEj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XB8RTaEj"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTf72032212;
	Fri, 25 Oct 2024 13:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=LzaKpkZYRJZsQLdeV5e4KMjA+eBDzDZi/X3sdKgMo4c=; b=
	XB8RTaEj/hRd1Nwkz85gDt7k+Yqb7H3tLBvHUeCxEs++vuVKa/CFa39rzXi/23rR
	2P7UCXw7WiJHExV/yb0Slf365CHcOZSVgyV2NNdBP8Ipzw6lZnsMgferLvFIgH/D
	KbtXUelUS7WGuMmIRfvKeTNWTkJhdxPs7GE+vixfKr4WqZGaXeOeW6kKH2Sc0m30
	EmS2bBeqFAX4fY94sTdGGw+6jAM9w6VNgoMsfCG8+0V8XGmyZxZIwudd5pFW0yNt
	kbI7aRETRVBukQ+vrut2TZ3YJVWN5enLfIrsb6Sr1/JLCUK4siSrezbsL5EqeY9q
	ANgK2+KPtWy76QgO5fopsQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvwsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxqZi016733;
	Fri, 25 Oct 2024 13:12:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Re000657;
	Fri, 25 Oct 2024 13:12:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-2;
	Fri, 25 Oct 2024 13:12:01 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 1/9] mm/gup: folio_add_pins
Date: Fri, 25 Oct 2024 06:11:51 -0700
Message-Id: <1729861919-234514-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: B-UNO4H_27FhryA8OqA_ssbXDTW-rTJi
X-Proofpoint-ORIG-GUID: B-UNO4H_27FhryA8OqA_ssbXDTW-rTJi
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

