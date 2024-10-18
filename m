Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965A204F7F
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286866; cv=none; b=TjcZMSX2pkQm2Og9DQ0JYzPCbhn0DCnP5a3GrDLPAgCQfAi0PblDSiCziRi6srSw289cZo8myCBkXWBWl5vaMWSCDvikk5qW4RlspQkjXq1ssqwBmkdvZaEBrpYxEBC2OBXKglHtkVvYn6Uty7c9RFEQrE76jjxvLkcIqBuP2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286866; c=relaxed/simple;
	bh=wABA7hudD/k+N/0uab4sVqj02sOtd1k4iXGrszveTPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m4N3bcNM4K/3cF1eA1Vg+o/6c4yBneGV9szzpbW/bcOJIok5DWCJiD2JS+DPLASOu6LgQVQXYBHlPdiaAMxaBDNdAbWBgfEui8bbZOlq04cGjE+y5EZdTKLyG74AtqcCQtn191eupi8gEyxDLFKipx2aqZsDb+v2qMGBmf3BGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jG9eituT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jG9eituT"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBgaZ014711;
	Fri, 18 Oct 2024 21:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=cQ5JFG8y9rdmZ+nR2s/ZnFPH62wjigHR02s+46Y4hwo=; b=
	jG9eituTqP1phFqQl5c7Dd4pTspX7/hlAsvPT5IwCupAgfoy62uXVCa6+zPcR9MD
	Nd84ici/vyhMdYeE9oBCIi5HjxCMwapRDbjHcTKCg/yFOP4GF3SlgglWuebZMdvl
	pCdzUDNl5YoWRDJ5L5TYyN4HWEfNx9waraXrSfGr16oy+LQVocehxUHKcm0khaZ6
	pHSX5shvapfX6LX69TE7fzHFi4KzUKzTqEyNL/rf94Ki3/Duz3xpDp49A9NNrBjH
	SzWyWTpC/qh9iLZH92/V9BMfBrjHSzOCazc6IDXjxikndrjowI4JhcyKCHFiSw7m
	Lf4H3/7m62rVQYGh2ISPLg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ashxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IK3oJu027120;
	Fri, 18 Oct 2024 21:27:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVh023093;
	Fri, 18 Oct 2024 21:27:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-5;
	Fri, 18 Oct 2024 21:27:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 4/9] iommufd: pfn reader local variables
Date: Fri, 18 Oct 2024 14:27:31 -0700
Message-Id: <1729286856-127844-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: MDGmXhRGcedKFnm3o2cd7GW68d3BZ8h-
X-Proofpoint-ORIG-GUID: MDGmXhRGcedKFnm3o2cd7GW68d3BZ8h-
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

