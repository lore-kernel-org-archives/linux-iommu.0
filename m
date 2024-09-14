Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284B1CE70E
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319166; cv=none; b=jK5lUjrLqXuAliVqMiKrBEAur/xriA/OtIV9SIi+lfQpm0Btyt5PE65H5FRzULaoJE3x7BXe+Rn1Zu3W9kke4SCW18RkanMk4N2F9LnZIu0U34EPK6fPmk/ofje9cjwUR5CvGeqPPXkXRQtO88rMS7hlUSEqNZ4Ba7egVb6nn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319166; c=relaxed/simple;
	bh=H64xXo2LafYMaDcSBrJqpVEAaScX8vZZzLoDd4ERNOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Uk1eiQg4VwxNDcUZsyjzg6N8hXnPll7n9bOELcK2aIY75pI897qBqUmHIgupW1Kb0vzyfMp59Vb38NRyHxB46009RtoCoj6MCx1dnOnbU4+CpMr2RrWeKX1lmt/NzR75GWuotOKLqkSTEgn4UfAmqfBN/vFL+k7FwKltnvVJJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f9xuZN5M; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9xuZN5M"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EABgL2006251;
	Sat, 14 Sep 2024 13:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=RXmCSMlA37skyc3uM+H9FNrKUcMBxrRXkAq4r41Ms0s=; b=
	f9xuZN5M3MTEbUXXd0z5F7RDTn6/grBnKtMV9iVUH55TiB1SglRBhK22V5sCkPJy
	pu4GL8jF+kxu+1nUW4x0fcZ9mQhafiR4azSENdlhlYkLOwJ1ac/q6uI9xeY/xIbK
	XDlDcdbkjizPP1ueyl7tpA7aFcTElXaKvJP6sWljs/T21a08oHoXuzrD6mSR60EW
	knQcD4zu5l9JTpGmdQXzHTfWZLHOcZmujpYy8273ygh72N/U/WD7rUzm/scQSCuX
	2PAb3GjvZ5npj0vOwQV/S1mi8dcImvQDW9qFLjRaWmTyVf/3DJcnbkt7Hr2Tu9yI
	saE3ON9OXp/OTZ/n4jzSSA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdgdrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E9V4MJ019241;
	Sat, 14 Sep 2024 13:06:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:01 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jF024307;
	Sat, 14 Sep 2024 13:06:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-2;
	Sat, 14 Sep 2024 13:06:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
Date: Sat, 14 Sep 2024 06:05:50 -0700
Message-Id: <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: ETdUPvuBCF95IUqL2grd7vrcBgaP_5Ih
X-Proofpoint-ORIG-GUID: ETdUPvuBCF95IUqL2grd7vrcBgaP_5Ih
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Export a function that repins a huge-page folio at small-page granularity.
This allows any range of small pages within the folio to be unpinned later.
For example, pages pinned via memfd_pin_folios and modified by
repin_folio_unhugely could be unpinned via unpin_user_page(s).

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1470736..ba8344f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2514,6 +2514,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		      struct folio **folios, unsigned int max_folios,
 		      pgoff_t *offset);
+void repin_folio_unhugely(struct folio *folio, unsigned long npin);
 
 int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
diff --git a/mm/gup.c b/mm/gup.c
index 947881ff..f8f3f2a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(memfd_pin_folios);
+
+/**
+ * repin_folio_unhugely() - repin a folio at small page granularity
+ * @folio: the folio to repin
+ * @npin:  the number of pages pinned in the folio
+ *
+ * Given a huge page folio that is already pinned, and the number of small
+ * pages that are pinned in it, adjust the pincount to reflect small-page
+ * granularity.  Each small page can later be unpinned individually.
+ */
+void repin_folio_unhugely(struct folio *folio, unsigned long npin)
+{
+	if (!folio_test_large(folio) || is_huge_zero_folio(folio) || npin == 1)
+		return;
+	atomic_add(npin - 1, &folio->_refcount);
+	atomic_add(npin - 1, &folio->_pincount);
+}
+EXPORT_SYMBOL_GPL(repin_folio_unhugely);
-- 
1.8.3.1

