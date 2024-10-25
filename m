Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD671632F8
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861929; cv=none; b=mCvWQhvD6uKM1NmNsCdctvUUVXNfBtA3RNOol4PJR6q4u0WmaAGB2sMPYSA+n/8oMKuBXQ9sZAsnzt+MNKqvv3PncHCj6oNmgeJdPKS3Q0oQEYN9eCyl+NClb+sxcbFZjpBiHKV1Dt6fh/d4z5d8R0MFH1blWIYg2/aNR0lAZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861929; c=relaxed/simple;
	bh=v6GMMDWXsMj4A03na8J4/4vq8yFX7vcSPTZ4fylTKss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o33I9P4HNd7+Z3vpnQL1WpktOeiWm+nwQQKCJj17dnV2eXkOdPp1jj4ixB+PLbTtp5juENABCMW9cFQ2Hck36X+l5xp33OzLFe67lgR8REv7/yl4kNFgEY0Ztp9AbH563/fd1H7fDdw6zSUFDSMGoyUICAURvaFFQj7H/0Ppt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VRvl/NOk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VRvl/NOk"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTfsO031388;
	Fri, 25 Oct 2024 13:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=R7s420SNALBLckW7JuSkp92R3RAOprAEfPDmZ1MMH0U=; b=
	VRvl/NOk3tC8RW/kqIp7VI7JuY0ucoy9ZKJCodIqZQYp6eeEHQwlApgmPdb4gBaZ
	id0m6vQR5YFQtCUy37ffi/IC8yT0WkZ29EPsQcbiPm+nAIq0aOnBJzq1dWGIuygy
	9Nk/VrVR/u9k47iZZXG7c/MndR0PpvtbK/n5eR5z08lWwIA0OOMu3wCHZOuCl0cz
	Zf2t66zfk2afREnSN6qlKdKlldHWjxz3zrFIHrfRBUmddpPxjx0JxsyhKjQXSfSi
	Iw6PhpTzjfOlVLQwMvrCjBY30YeXsIE1UeZDXXHK0mrJaKrrnYtIUqBi021hSUMI
	LL5Bl+v8GDYg9sHwawbCrg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asmxru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxoAR016444;
	Fri, 25 Oct 2024 13:12:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Rk000657;
	Fri, 25 Oct 2024 13:12:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-5;
	Fri, 25 Oct 2024 13:12:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 4/9] iommufd: pfn reader local variables
Date: Fri, 25 Oct 2024 06:11:54 -0700
Message-Id: <1729861919-234514-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: VFs3E4ZGgL77zG25oq4MgCpSP44yztUQ
X-Proofpoint-ORIG-GUID: VFs3E4ZGgL77zG25oq4MgCpSP44yztUQ
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add local variables for common sub-expressions needed by a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/pages.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 4206e90..9097b25 100644
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

