Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E91E495
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319171; cv=none; b=K1+NEiqIyMNCpO1e3p6rKypblJayt510rd1r9Q3wE68+hFLsjsuYkWu0Kg332bfW+7DQ8JdrbX/zJrzgLdtZZHMhJtr4H6OlfGi4Zgwqlm9ehQMGUV4mxV0e77a4oK7zTl6bXTV3Q6HygmMmvRpSwFJnzqUC+9f7is7i94bGZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319171; c=relaxed/simple;
	bh=geZMEAK1godolnnemHDQ/1lnY35MI5LR6x7rPzpg5lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=coIs9zvTZWck66uecIUqxmnhwMXGdnga0dpK11dgTtuzdEcO1A2m/9bYiBC82J3GYa+G5kmY9rxAkjGztO/TR8Qu/UrRgV4pc/g9anKd6i+nPREOKkur0SzG7xrSkQOt/usyFV7y2C9YJnHkY7vfoMuE8Fxs0QgIIBL+fckNU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GRjCyU20; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GRjCyU20"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EAbL1t028080;
	Sat, 14 Sep 2024 13:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=R23pF5K+u630iTo6S/6a6wwf2XlTCvjkP/LUtBsYPzE=; b=
	GRjCyU20IxvUsTliscfLiqZJKUfzBcoti+HnXjoH9RGwJLHIG3Ggovh9fw74onrv
	2EH4dOJIdgwZrluyVxBn87ye6eUse7fJh1WFqnqqJheSPvixKCkuWZ7xik+2HnRV
	Z5/xSV6cxJL0D7Db9pvYZfMwqzYgdVI+8egu51kkCXxbn+v86JczEyo0H3cATnCM
	uVIYIrjn+5T0TjDVcVFlQ35Kx3HBMUzOXX651LZCAg/74B5RG/X9dm5FsBQfURe3
	nGgmXNO2+CCuJx07qvOs3aTwBlMm0rPMn3atd4KnjU9axoJrz+gZAH8ROHB5C2Bv
	r2dGCNCDNDPGtFIA2ZND7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfge52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E8d9bA019210;
	Sat, 14 Sep 2024 13:06:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jT024307;
	Sat, 14 Sep 2024 13:06:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-9;
	Sat, 14 Sep 2024 13:06:06 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 8/9] iommufd: replace upages_len
Date: Sat, 14 Sep 2024 06:05:57 -0700
Message-Id: <1726319158-283074-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: vMrV10ktdyJb6KrBtlYpS7D0IKASmHc3
X-Proofpoint-ORIG-GUID: vMrV10ktdyJb6KrBtlYpS7D0IKASmHc3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Replace the byte length upages_len with the element count upages_num.
This simplifies a subsequent patch that needs element count.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 4cb532e..f6c7c90 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -694,7 +694,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
 /* pfn_reader_user is just the pin_user_pages() path */
 struct pfn_reader_user {
 	struct page **upages;
-	size_t upages_len;
+	unsigned long upages_num;
 	struct file *file;
 	unsigned long upages_start;
 	unsigned long upages_end;
@@ -783,6 +783,7 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 {
 	bool remote_mm = pages->source_mm != current->mm;
 	unsigned long npages, start;
+	size_t len;
 	uintptr_t uptr;
 	long rc;
 
@@ -792,11 +793,11 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 
 	if (!user->upages) {
 		/* All undone in pfn_reader_destroy() */
-		user->upages_len =
-			(last_index - start_index + 1) * sizeof(*user->upages);
-		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
+		len = (last_index - start_index + 1) * sizeof(*user->upages);
+		user->upages = temp_kmalloc(&len, NULL, 0);
 		if (!user->upages)
 			return -ENOMEM;
+		user->upages_num = len / sizeof(*user->upages);
 	}
 
 	if (!user->file && user->locked == -1) {
@@ -813,7 +814,7 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	}
 
 	npages = min_t(unsigned long, last_index - start_index + 1,
-		       user->upages_len / sizeof(*user->upages));
+		       user->upages_num);
 
 	if (iommufd_should_fail())
 		return -EFAULT;
@@ -1756,7 +1757,7 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
 	lockdep_assert_held(&pages->mutex);
 
 	pfn_reader_user_init(&user, pages);
-	user.upages_len = (last_index - start_index + 1) * sizeof(*out_pages);
+	user.upages_num = last_index - start_index + 1;
 	interval_tree_for_each_double_span(&span, &pages->access_itree,
 					   &pages->domains_itree, start_index,
 					   last_index) {
-- 
1.8.3.1

