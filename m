Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AB1632F9
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861930; cv=none; b=DMCOCWCzStXFS+xM7ws1v+joubIXQjCHIlYmRFRK82GXUmcj529GzEFuLBiM1FYfa9P59TdDFOmUAzlztCVElLHVbrWtvIX41YrVaIuMk/tnFBN+0yRFNxFP6lKRFPQ/dL9/Yarvy52hNm11FpEysfn7jZ7/7WCa7xmth5TYWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861930; c=relaxed/simple;
	bh=TTyZE7cD+6LmWJbQYQ3sl2pRvwOV1aLgyJbN+gWa2rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=liiocB3qG5qvnQAEkcUcHV6IMOLHikQLj/JlyCzot1ogF/E6SaLEnmkGPjY9Mp9/fSjvCJABHoQo92QT/eTj2LGsi5s/aMRbhlIzKlMzBYEsOnltQhiEwtot/p6tW5iBK7XnuV1AQrQoQ8RlvS2caVberUHs8bBsCQ79UMhUZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dBzc3wae; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBzc3wae"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCU0Cl032351;
	Fri, 25 Oct 2024 13:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=nJQigAuZJp8Bc8lzlC4a+Co8HtxvnB8rIYYcTct4WsM=; b=
	dBzc3waeVeXlnvsBIudTwF0l3dHnwlITuqjFL2AtXR7TzHhdkJgw3PC5kaTlQ6p4
	ECI1OfTJamIHYXqkzfv4vP7DlpmpBd831XguUcVnYjsYCS1915+fn8ky6AjPH8+e
	rrZCkNrZoTHDFc6U8GXoFENZqp03VozGaDCszhH+JQoxjvq645veQdizXQusaMcM
	PLgEBOIcG/0+U0uGsXn2gbIQmu2mNDA3MGktDIYbRNEJ+tHWeK6Zia4JY7w5FeVt
	52dnbE/8WMlwts5q1GFcYncfLofUVhMjEoTn116sycgdZV7MWTmPht3dAElk2FC8
	skQxviLHVX8FZHhHE64mRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvwt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxokC016413;
	Fri, 25 Oct 2024 13:12:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Rm000657;
	Fri, 25 Oct 2024 13:12:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-6;
	Fri, 25 Oct 2024 13:12:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 5/9] iommufd: folio subroutines
Date: Fri, 25 Oct 2024 06:11:55 -0700
Message-Id: <1729861919-234514-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: NLI7ZoC4RpebRTEieUo7Fye13lAKQqit
X-Proofpoint-ORIG-GUID: NLI7ZoC4RpebRTEieUo7Fye13lAKQqit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add subroutines for copying folios to a batch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/pages.c | 77 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9097b25..aa79504 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -346,27 +346,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 		kfree(batch->pfns);
 }
 
-/* true if the pfn was added, false otherwise */
-static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
+			      u32 nr)
 {
 	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
+	unsigned int end = batch->end;
 
-	if (batch->end &&
-	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
-	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
-		batch->npfns[batch->end - 1]++;
-		batch->total_pfns++;
-		return true;
-	}
-	if (batch->end == batch->array_size)
+	if (end && pfn == batch->pfns[end - 1] + batch->npfns[end - 1] &&
+	    nr <= MAX_NPFNS - batch->npfns[end - 1]) {
+		batch->npfns[end - 1] += nr;
+	} else if (end < batch->array_size) {
+		batch->pfns[end] = pfn;
+		batch->npfns[end] = nr;
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

