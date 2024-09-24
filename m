Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEE1AB500
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190351; cv=none; b=YChS0muHCcTHV7NcdKZM2u/+S0bGcmg+BUY+BzURp2wf68hEWDKms55AvWeApEIhzuyhQqSBdqMJ+Z7G/5/3tneQb3CYggYaQ4xXF3eaqR7f8vSFgNZZ27+TM32Lvfr2VEKVfDqtnqk4n9//FoYVcoc6E1ku1nW/L+YwBdUxt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190351; c=relaxed/simple;
	bh=fc8Qe4GE3hsglQAZUoAUOqQVsx/n/ao5qCBP02XDFZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OQDMQJwpuEBFmIiUDAgT5yJN3zs5BI2fgFnb/GfNLzOMt13fdbW6b2LfbRH+HjyZ2BwzUBa2wuc3ofW3lxLV51wJGggQ/n+9GCGoC8oSduK1JgDhDSActCeXTfbTNwIrgD82w1Om70mxQTGJx1UxZJCdn94uopjMv22eye091ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZmwhRUOE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZmwhRUOE"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQeME032467;
	Tue, 24 Sep 2024 15:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=3dvgeNhO/vQu0d9zfCBDRjDffBZj8kgS9Wf3fU9T3NM=; b=
	ZmwhRUOEJpRfxK/LJkUjHWontQDANfjRJKs8XF1HTG/N6IEBjXJtyrX6xQkIv8M+
	2v6yO+flfvCJ5eII7erfJIoOF3lz8eiqIYzAHwRKFYeX729gWv9pQZ27io1I4qT3
	GT/qKCPJrIWK3z6r1/LdGmshx79PjSUwc8zAT9cz+pX582o47BhLKyKO8tJQtUFr
	WMLV1edgCm138YsuMxe3nqhRbcG3I3fGIqr4kLCM1Roy4AUVVdQ0pDOtoTjGumE8
	HydC7fCrPcDlwN5QYRYJf2pvenyPPydNWLS2rO2t9tib7tNq3hzJJX66p1a3dBpR
	jgRR343cfWirofyz/LWDgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7qcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEUquh005409;
	Tue, 24 Sep 2024 15:05:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cr6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLP027122;
	Tue, 24 Sep 2024 15:05:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-8;
	Tue, 24 Sep 2024 15:05:46 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 7/9] iommufd: pfn reader local variables
Date: Tue, 24 Sep 2024 08:05:36 -0700
Message-Id: <1727190338-385692-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240108
X-Proofpoint-GUID: 5XUlTpOY3SL69ragjY_15Kr7418jFPeY
X-Proofpoint-ORIG-GUID: 5XUlTpOY3SL69ragjY_15Kr7418jFPeY
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
index 9d31df4..6e11189 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1043,6 +1043,8 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
+	struct pfn_reader_user *user = &pfns->user;
+	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
 
@@ -1080,10 +1082,9 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
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
 
@@ -1157,16 +1158,17 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
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

