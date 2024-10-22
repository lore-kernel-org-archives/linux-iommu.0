Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD916F826
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630848; cv=none; b=oUBL0uYnKeti81RmM5WQk+eNOj0BmUCwomG5S7PbrE0op7dsXI3bOFsBrXGnHfn52CCnAeaEhE0PunZAkNOgtE/DzCa8oJN0fiu5YHbhLAQlHoWPk6k27DkT5Bl3vYx9JZSBHtIRsWhfp+//5UdwEC8iTXS7WN5O72av9MczPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630848; c=relaxed/simple;
	bh=wABA7hudD/k+N/0uab4sVqj02sOtd1k4iXGrszveTPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U9zQi141NFG6AqJynFRsKzQ63uhL0qdykVM4Dgu+4WHdG0JpeTNOfI1XodrK6PX/AEQN/oMVeeGTNRmKfLypXheMXo6Y4UveeVHI0swAimE4N5h1hZl7Qo+2g2DHo8hSaBNWgqhUbUebHwAfwEMmSDyv/L2Ho1/kTXiaFkeZ/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gqaL0o0t; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gqaL0o0t"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqXVa006142;
	Tue, 22 Oct 2024 21:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=cQ5JFG8y9rdmZ+nR2s/ZnFPH62wjigHR02s+46Y4hwo=; b=
	gqaL0o0tMolTtLIjXjCF+XD1RUoVO2Ieff8FkVBKcK6xA4vCUgphdB2fK9/N3jjO
	/NbxJlsWWYdgQmYGGpqMQK2pZQc1DzvuZi+MPSdQ/8WcO6MQfdwYBswcyAdSBVvM
	hvodX1BNt/fudP1NUV6Fj8pHans26WVwE9nLddUJYOrk3GIz9m4SpzBelfgiHXyq
	4ZDc/Y+iWRcKCCoNzWJ7u+8ms+LJalhwv4Va2eDOY4MoFzuVMU0iFLwFrqemyXbY
	oji7R6HNbVq8b6iby4EzN+Fw45RcbFMzA3tgbqGsy3dKyF8w/3l+E3wSKdbSFn3Q
	PO/EhSbYsoQP7S4tKB8C+A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qepsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJlMOL012005;
	Tue, 22 Oct 2024 21:00:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781afu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEi016716;
	Tue, 22 Oct 2024 21:00:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-5;
	Tue, 22 Oct 2024 21:00:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 4/9] iommufd: pfn reader local variables
Date: Tue, 22 Oct 2024 14:00:33 -0700
Message-Id: <1729630838-24586-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: pJOtRfIGycSX4r8WwWYuyU69VdE-x_M8
X-Proofpoint-GUID: pJOtRfIGycSX4r8WwWYuyU69VdE-x_M8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add local variables for common sub-expressions needed by a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index aa69c97..0cf5b65 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -978,6 +978,8 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
+	struct pfn_reader_user *user = &pfns->user;
+	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
 
@@ -1015,10 +1017,9 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 			return rc;
 	}
 
-	batch_from_pages(&pfns->batch,
-			 pfns->user.upages +
-				 (start_index - pfns->user.upages_start),
-			 pfns->user.upages_end - start_index);
+	npages = user->upages_end - start_index;
+	start_index -= user->upages_start;
+	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
 	return 0;
 }
 
@@ -1092,16 +1093,18 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 static void pfn_reader_release_pins(struct pfn_reader *pfns)
 {
 	struct iopt_pages *pages = pfns->pages;
+	struct pfn_reader_user *user = &pfns->user;
 
-	if (pfns->user.upages_end > pfns->batch_end_index) {
-		size_t npages = pfns->user.upages_end - pfns->batch_end_index;
-
+	if (user->upages_end > pfns->batch_end_index) {
 		/* Any pages not transferred to the batch are just unpinned */
-		unpin_user_pages(pfns->user.upages + (pfns->batch_end_index -
-						      pfns->user.upages_start),
-				 npages);
+
+		unsigned long npages = user->upages_end - pfns->batch_end_index;
+		unsigned long start_index = pfns->batch_end_index -
+					    user->upages_start;
+
+		unpin_user_pages(user->upages + start_index, npages);
 		iopt_pages_sub_npinned(pages, npages);
-		pfns->user.upages_end = pfns->batch_end_index;
+		user->upages_end = pfns->batch_end_index;
 	}
 	if (pfns->batch_start_index != pfns->batch_end_index) {
 		pfn_reader_unpin(pfns);
-- 
1.8.3.1

