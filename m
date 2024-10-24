Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C71EABDF
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783565; cv=none; b=nGHTwUfWZTaQBC68sRafE61MUM9ICouqy/iOCEFVETJs35QEKQjmGLwwiDKeM4kmO5u9iiPN5oAe/Jw9ynbzVH07rm6fsRmZ34UkoNqszm+6a+2f1X/rCPv8JXH8KBPcQEBBJy2nQC2oYkSetX+bTlo4M8Td6t3TrcRmtCBMBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783565; c=relaxed/simple;
	bh=TTyZE7cD+6LmWJbQYQ3sl2pRvwOV1aLgyJbN+gWa2rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TGirHCU15vAj7Nd3oP5X4kje/Bc2V62lYJ44Ys9f4SVm3L8BHHWzvvXObCr2LFVHZ5tmxykf2J68fVNTp0VoUMPUbQGuabvyio6K3VJymgFfpgHjyiQruiaKEuU2LQaN58u0VncZ41btBWeHzkA5Wggv0jBL4App+RdEoAyOsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HbtrLA4i; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HbtrLA4i"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1biE005159;
	Thu, 24 Oct 2024 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=nJQigAuZJp8Bc8lzlC4a+Co8HtxvnB8rIYYcTct4WsM=; b=
	HbtrLA4iNdHd3xJ9F1pzCpvfoNKLspQd95IdoDVWTsqiHXRuIr6ciBX8vkxgmVxZ
	Jne9haxHTW+/JpSvJ+w/GSAK4/mWFzWHaSnW9GMFdWATWRnovy8HZgaMCVzQgn0h
	RzSQub8ensCgGlPcLqZ063uyRRh0aGlJMT9zCSN8ptud//2MTei5Ij+unk15r5PS
	gsw4vkHgk5JCexx7iMraS4HIZx6Nj06tPxX4kSqA3Je0D6uiyCZSVhjU9zJAzutE
	yb1J7ZAdVSWOiEVYwkBde/+Q0OTJ48oelXCHe0RlH/oTKpsQUqOp+y0sXFOM+9WM
	pvVy7YTjYvcdZT1U0D+QJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asjx16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:26:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OEiSpd027484;
	Thu, 24 Oct 2024 15:26:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh4g0tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:26:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49OFNFXB038314;
	Thu, 24 Oct 2024 15:25:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emh4g0jc-6;
	Thu, 24 Oct 2024 15:25:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 5/9] iommufd: folio subroutines
Date: Thu, 24 Oct 2024 08:25:50 -0700
Message-Id: <1729783554-56916-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240126
X-Proofpoint-GUID: XJU2wanh8eBq7Mj19yDwWHurMu7KGE_U
X-Proofpoint-ORIG-GUID: XJU2wanh8eBq7Mj19yDwWHurMu7KGE_U
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

