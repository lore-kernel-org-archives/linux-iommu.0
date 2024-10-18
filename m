Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931A205AA9
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286867; cv=none; b=oGmYiHSEcILXbL950ClK6cFmZHpa0q5zusc1E4m/x9JdWPZYqQA1R31PkFaJm54bMvNtlilr5CEJVvFYO4FWE/NUlKRPR0rL34RqDUVFbuON0KfsaAol/1smfccTZWhx4Fa/BG1rk2p2+wS3BGEfuaZ0w9/ezlcLbQQI1vbhj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286867; c=relaxed/simple;
	bh=Ka1R5qA1YvU+f4Vk6PIF21saXSF3WYkk4g+ikctWeTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DzeO2U2TOPPiheMcE9zorPp8hi+YuLp9DizbnUSET7TuM3useRlT1sCqxSg3KRdojcxx7jJ2dS3Ac4tq6tzg07d4IC13I/KSDht9Nadgp2ji0spA/eZY03cWA7/DpNAw/3HBWNylkcPs46WHfgDn4zhF+a5wCByqB+Sj2l/o66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArI6TjS5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArI6TjS5"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBgtE028196;
	Fri, 18 Oct 2024 21:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=Dea6dhZsBtHTFS/14uNiSuENlTJ71mA2U7pc6fSwkaE=; b=
	ArI6TjS5gptx1IPXlNjf9+JN/85N4V26Zsg5jRx1yDIPD8Xv+tuSe2Vr+mpAKzwT
	OpT/+Y9YeQVRZhmdZYTXRKErJeUE84c2AkDFcfP0I8FB/m4PG38+R0lsylbAmtfo
	ST/wsvQNhAQNvod5vLQxKCaBTqxZOj0y7CZwxnFSpjbxUQMKWnEgZvlK1vovPzUZ
	ryB5cJxFAEH7RS5pUTDREh9QNxJ96xxtdR8jdiRVCmVCOsIxUWPvPkPSC4SkK2IY
	hDv8Yi9U0oY3ujrMIDtjk+eqNx+OGoo4O6rOFMKDDoNRbPff9adLOm6WdGVpZQ1c
	UhN8jOhM63KZMI3EahFKiA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnthrv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IL7YYH027164;
	Fri, 18 Oct 2024 21:27:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVj023093;
	Fri, 18 Oct 2024 21:27:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-6;
	Fri, 18 Oct 2024 21:27:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 5/9] iommufd: folio subroutines
Date: Fri, 18 Oct 2024 14:27:32 -0700
Message-Id: <1729286856-127844-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: agpl9sSrpqzdjTse4MWBoDuOiWt3IzHK
X-Proofpoint-GUID: agpl9sSrpqzdjTse4MWBoDuOiWt3IzHK
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add subroutines for copying folios to a batch and unpinning pages.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 93 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 0cf5b65..c9ca9e0 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -346,25 +346,40 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 		kfree(batch->pfns);
 }
 
-/* true if the pfn was added, false otherwise */
-static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+/* returns the number of pfn's added */
+static long batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
+			      unsigned long nr)
 {
-	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
+	const unsigned long MAX_NPFNS = type_max(typeof(*batch->npfns));
+	unsigned long n = 0;
 
-	if (batch->end &&
-	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
-	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
-		batch->npfns[batch->end - 1]++;
-		batch->total_pfns++;
-		return true;
+	if (batch->end) {
+		unsigned long npfn_end = batch->npfns[batch->end - 1];
+		unsigned long pfn_end = batch->pfns[batch->end - 1];
+
+		if (pfn == pfn_end + npfn_end && npfn_end < MAX_NPFNS) {
+			n = min_t(unsigned long, MAX_NPFNS - npfn_end, nr);
+			batch->npfns[batch->end - 1] += n;
+			batch->total_pfns += n;
+			if (nr == n)
+				return n;
+			nr -= n;
+		}
 	}
 	if (batch->end == batch->array_size)
-		return false;
-	batch->total_pfns++;
+		return n;
+	nr = min_t(unsigned long, MAX_NPFNS, nr);
+	batch->total_pfns += nr;
 	batch->pfns[batch->end] = pfn;
-	batch->npfns[batch->end] = 1;
+	batch->npfns[batch->end] = nr;
 	batch->end++;
-	return true;
+	return n + nr;
+}
+
+/* true if the pfn was added, false otherwise */
+static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
+{
+	return batch_add_pfn_num(batch, pfn, 1) == 1;
 }
 
 /*
@@ -622,6 +637,58 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
 			break;
 }
 
+static void batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
+			      unsigned long *offset_p, unsigned long npages)
+{
+	unsigned long offset = *offset_p;
+	struct folio **folios = *folios_p;
+
+	while (npages) {
+		unsigned long n;
+		struct folio *folio = *folios;
+		unsigned long nr = folio_nr_pages(folio) - offset;
+		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
+
+		nr = min(nr, npages);
+		n = batch_add_pfn_num(batch, pfn, nr);
+		npages -= n;
+
+		if (n == nr) {
+			folios++;
+			offset = 0;
+		} else if (n) {
+			offset += n;
+		} else {
+			break;
+		}
+	}
+
+	*folios_p = folios;
+	*offset_p = offset;
+}
+
+static void folios_unpin_partial(struct folio **folios, unsigned long offset,
+				 unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (npages) {
+		struct folio *folio = folios[i++];
+		unsigned long nr = folio_nr_pages(folio);
+
+		if (offset == 0 && nr < npages) {
+			unpin_folio(folio);
+		} else {
+			struct page *page = folio_page(folio, offset);
+
+			nr = min(npages, nr - offset);
+			unpin_user_page_range_dirty_lock(page, nr, false);
+			offset = 0;
+		}
+		npages -= nr;
+	}
+}
+
 static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
 			unsigned int first_page_off, size_t npages)
 {
-- 
1.8.3.1

