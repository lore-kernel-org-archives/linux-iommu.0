Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB816F826
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630850; cv=none; b=Zp7Gv1fsScf0FtYi3c5hI0CWgCEmfcW6pcrte0x7R4ZxThcurVgdPXHGqmTugr6OjUVAMVse3WROf6axIqV0t8orv4QuCgWjspbFJyWIE/iSIUxGtLodImdkqkt2m6szepyVjLx6hZoxWPQWmrYkh3Im8XiAEyxsmjN1cn4ONGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630850; c=relaxed/simple;
	bh=515iWE+t61Z3DDKFLHiNj0Z/kf4odx6+Xy4Soh8Lk/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pcal4hDbF6jcAgDzdyyq8bI6WOShDtJ9O/1AUQ4rHBcbul65KwWzeXpBiXykNLc3z2vlARb5t7Yaw9zSdRJwKZmW+wkhpRgYZbhe2PwZsQ3DWQU3Z3mdvBzhofeFcuHWEQ2rvf+Q83bS5AZ36cnraAeyU5UVM+1S/ETxII0ttr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfqLGtMW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfqLGtMW"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqNL5028009;
	Tue, 22 Oct 2024 21:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=HyBRK3TuGn8VRX7ZhOx4uXHIp77NuBzwrI+tBRXi04E=; b=
	BfqLGtMWnO3mZZd6PDREnFMZucTb2LDeT3mBKbjNzS203VVmwBYowaQwIlkREcQG
	37wdJUQqrXTVpV2WDVPIMVIC7CelY1CdOjWfS5mou9uN0oZhja0t/sj8u1B70rYy
	tyJEE1pgX7mHIDjZ8vVuLkIbVHpD1a8nbSXtQWjR7JaDN6LhaVmLjopIU36ZBPHq
	8qCkyzZKNlYtccQmzF5acU+mjlXabsSHUDENTAxW0mcdEM/87UwAy37iaEfBTo8k
	IzdHkl1Kq5+6lI1dji7OsjVfIunbDqbwPYYX2hbDWGGcdIZ6bI13HvFXb5ERbLeu
	1iYGPWLVS9pV2uOnb/58kw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3du75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJF9Dv011981;
	Tue, 22 Oct 2024 21:00:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781ahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEk016716;
	Tue, 22 Oct 2024 21:00:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-6;
	Tue, 22 Oct 2024 21:00:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 5/9] iommufd: folio subroutines
Date: Tue, 22 Oct 2024 14:00:34 -0700
Message-Id: <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: JSZlWPK628J1kPDLfR5-YRQBM2-0feQw
X-Proofpoint-GUID: JSZlWPK628J1kPDLfR5-YRQBM2-0feQw
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add subroutines for copying folios to a batch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 79 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 0cf5b65..635b1fe 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -346,27 +346,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 		kfree(batch->pfns);
 }
 
-/* true if the pfn was added, false otherwise */
-static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
+			      unsigned long nr)
 {
-	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
+	const unsigned long MAX_NPFNS = type_max(typeof(*batch->npfns));
+	int i = batch->end;
 
-	if (batch->end &&
-	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
-	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
-		batch->npfns[batch->end - 1]++;
-		batch->total_pfns++;
-		return true;
-	}
-	if (batch->end == batch->array_size)
+	if (i && pfn == batch->pfns[i - 1] + batch->npfns[i - 1] &&
+	    nr <= MAX_NPFNS - batch->npfns[i - 1]) {
+		batch->npfns[i - 1] += nr;
+	} else if (i < batch->array_size) {
+		batch->pfns[i] = pfn;
+		batch->npfns[i] = nr;
+		batch->end++;
+	} else {
 		return false;
-	batch->total_pfns++;
-	batch->pfns[batch->end] = pfn;
-	batch->npfns[batch->end] = 1;
-	batch->end++;
+	}
+
+	batch->total_pfns += nr;
 	return true;
 }
 
+static void batch_remove_pfn_num(struct pfn_batch *batch, unsigned long nr)
+{
+	batch->npfns[batch->end - 1] -= nr;
+	if (batch->npfns[batch->end - 1] == 0)
+		batch->end--;
+	batch->total_pfns -= nr;
+}
+
+/* true if the pfn was added, false otherwise */
+static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+{
+	return batch_add_pfn_num(batch, pfn, 1);
+}
+
 /*
  * Fill the batch with pfns from the domain. When the batch is full, or it
  * reaches last_index, the function will return. The caller should use
@@ -622,6 +636,41 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
 			break;
 }
 
+static int batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
+			     unsigned long *offset_p, unsigned long npages)
+{
+	int rc = 0;
+	struct folio **folios = *folios_p;
+	unsigned long offset = *offset_p;
+
+	while (npages) {
+		struct folio *folio = *folios;
+		unsigned long nr = folio_nr_pages(folio) - offset;
+		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
+
+		nr = min(nr, npages);
+		npages -= nr;
+
+		if (!batch_add_pfn_num(batch, pfn, nr))
+			break;
+		if (nr > 1) {
+			rc = folio_add_pins(folio, nr - 1);
+			if (rc) {
+				batch_remove_pfn_num(batch, nr);
+				goto out;
+			}
+		}
+
+		folios++;
+		offset = 0;
+	}
+
+out:
+	*folios_p = folios;
+	*offset_p = offset;
+	return rc;
+}
+
 static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
 			unsigned int first_page_off, size_t npages)
 {
-- 
1.8.3.1

