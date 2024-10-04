Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6E1EF953
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067713; cv=none; b=Z03U4h+EThC2x1rs3u6ay4DRnNcefnfkkb2qNusf1+JiiHsE6YG1AzWbuA5pXYXrk1a1kKFVIFsaPbp8WqWYomvWbgkiVoM742VRIgCNukoQ1KdAueImhbEkNFjXIny4mfm1r2hby9norW4tp5R1a3s+6RbIBG20ETqTiIAHSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067713; c=relaxed/simple;
	bh=CA+3xnhJpXRUtDGgfo9Xc8yZdpQCAGHjMeYCD8RTg6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aIs55Oxch4uIa2Z3O7rwnSf1kdyU94o97+HXivnU6mBwGI62WbxceLpS8cE6+CgYkzBiPZfAx/bC4M4/FU1La/4rgBNj9BmrG7DbTcytvu6Q5mnSadBsXLc4vyoEfDxl/SCfd+yFgc5lWAKru5gY4D10YTxE3LVolHbWr2mDeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jkrMoyHh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jkrMoyHh"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfbBf027555;
	Fri, 4 Oct 2024 18:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=IO24gykYlm7ZrNILnbXuiwgsO1+K1JkSobOjaALhhwQ=; b=
	jkrMoyHhwi60oIG6AA2gOB97GLuwR3JVWq6LWA6Cz76jkWjTbOHjMxW1gf6tYkzK
	QWKxYA6qUrBkt97TkkdILy1+eOKF+7u2Pd4rnXJo/kSNb3WSl30mgyezMEmqIqLh
	kuukOKCAGWECHpWWgGBtKzpgxY0zs380AViNHbiQpGQLCvINxC4N9ZEi5lOWMPtz
	H+2NLeEatraiOpbW9+CUygyhe9IumMdeKWFVmsJNyBdUvMGMSA80qrIHQSUge8j0
	EFNDswo7ywBcF9nQc6ieE8PhRXwjsOUzNoOwrrk7XpHBTfYOvjwAD7Vnp7rdM25E
	xQEwq8tTaYKCH8k5xPaQnw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204ftac6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494GvrXP038239;
	Fri, 4 Oct 2024 18:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLaA029789;
	Fri, 4 Oct 2024 18:48:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-8;
	Fri, 04 Oct 2024 18:48:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 7/9] iommufd: pfn reader local variables
Date: Fri,  4 Oct 2024 11:48:18 -0700
Message-Id: <1728067700-32092-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040129
X-Proofpoint-GUID: VoKHFF9qbaMVcz0gFx1h8ALt2dUVh4g6
X-Proofpoint-ORIG-GUID: VoKHFF9qbaMVcz0gFx1h8ALt2dUVh4g6
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add local variables for common sub-expressions needed by a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 8030226..2db2b06 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1046,6 +1046,8 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
+	struct pfn_reader_user *user = &pfns->user;
+	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
 
@@ -1083,10 +1085,9 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
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
 
@@ -1160,16 +1161,17 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 static void pfn_reader_release_pins(struct pfn_reader *pfns)
 {
 	struct iopt_pages *pages = pfns->pages;
+	struct pfn_reader_user *user = &pfns->user;
+	unsigned long npages, start_index;
 
-	if (pfns->user.upages_end > pfns->batch_end_index) {
-		size_t npages = pfns->user.upages_end - pfns->batch_end_index;
-
+	if (user->upages_end > pfns->batch_end_index) {
 		/* Any pages not transferred to the batch are just unpinned */
-		unpin_user_pages(pfns->user.upages + (pfns->batch_end_index -
-						      pfns->user.upages_start),
-				 npages);
+
+		npages = user->upages_end - pfns->batch_end_index;
+		start_index = pfns->batch_end_index - user->upages_start;
+		unpin_user_pages(user->upages + start_index, npages);
 		iopt_pages_sub_npinned(pages, npages);
-		pfns->user.upages_end = pfns->batch_end_index;
+		user->upages_end = pfns->batch_end_index;
 	}
 	if (pfns->batch_start_index != pfns->batch_end_index) {
 		pfn_reader_unpin(pfns);
-- 
1.8.3.1

