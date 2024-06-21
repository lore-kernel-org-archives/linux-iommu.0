Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81ED17B410
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995433; cv=none; b=MddKnBsrnn0QxrKJGjTCNoSBgJQD1T281ycukWZlEbZknyAIa8BoJZ7A0mlyEasYOlwOtWRAxJ2Ochm4mlllXTM5C3i2bZb6f1HxEWR4uKYrsN0imBinSg03qCJukISchDQOzr7T/7swA61GG1VbIqT9tiXVjPa+6tyo6navM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995433; c=relaxed/simple;
	bh=rbdotP36X2E22aaxtzRsnAWEMDOOAOOInrLlBZkV0qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcBVdlCrDB1koIYmoJ6mAxP4WfVjn1oBlI0SPRbPY5CKN6O+Pf5N+ZM8lRkDrapoHqec51mesyo6yQLAQWPco0O/Cbc3Np9NjR4kp7YhHClTnIFDmLCFXlJHM+/d5I8n3sKn/YviSrEK+8nLvuFr1ASVla7Hl+dHWiHmdXQAT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fDdsk0ru; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fDdsk0ru"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXZ4s010397;
	Fri, 21 Jun 2024 18:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=i
	QgBQW5xtlQKc0HhTxUCH1puZecfvu/4R2QBTrYK2YA=; b=fDdsk0ruIlOFlA3u1
	WN6Gq5licqv97yLsqbUoJvIh2H8NlkNs9S4b6GzMhDRN/oYz1MUjzweKCa43e4tZ
	kkJp6NG5FSJ4C/xsce7DY92ZLgytxviR67bE+tkbp2WtoTDL1idYkkwsDwYbvEXa
	OFRke/pdCCsbARWN6/6ioBCds3F3pzMb3md0MllUm2J/0pNFeXc01BdaJs2dKTWf
	TnSS9cwCzvcN2ZS/B0gLpq4qgFgICpdsO6/4v+X+BacZ5QKzKW5tRYTC1Q+MQZN2
	LktX9job+19m0eKFMWm6JAxWg2gj6nhI9EFlThXGuLOVsIYXHCelDzrt0z98LCDW
	HJhJw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkttcmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LHtvET039746;
	Fri, 21 Jun 2024 18:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pp7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFXI032040;
	Fri, 21 Jun 2024 18:43:39 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-9;
	Fri, 21 Jun 2024 18:43:38 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 08/10] iommufd/iova_bitmap: Consolidate iova_bitmap_set exit conditionals
Date: Fri, 21 Jun 2024 19:42:52 +0100
Message-Id: <20240621184254.45477-9-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-1-joao.m.martins@oracle.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_10,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=841 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-GUID: zb-KuA6bsqbcaNCDB2TfQCmLX2BdGZMg
X-Proofpoint-ORIG-GUID: zb-KuA6bsqbcaNCDB2TfQCmLX2BdGZMg

There's no need to have two conditionals when they are closely tied
together. Move the setting of bitmap::set_ahead_length after it checks for
::pages array out of bounds access.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index b94636b7977e..be97bb464f6b 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -465,18 +465,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 					 last_bit - cur_bit + 1);
 		void *kaddr;
 
-		if (unlikely(page_idx > last_page_idx))
+		if (unlikely(page_idx > last_page_idx)) {
+			unsigned long left =
+				((last_bit - cur_bit + 1) << mapped->pgshift);
+
+			bitmap->set_ahead_length = left;
 			break;
+		}
 
 		kaddr = kmap_local_page(mapped->pages[page_idx]);
 		bitmap_set(kaddr, offset, nbits);
 		kunmap_local(kaddr);
 		cur_bit += nbits;
 	} while (cur_bit <= last_bit);
-
-	if (unlikely(cur_bit <= last_bit)) {
-		bitmap->set_ahead_length =
-			((last_bit - cur_bit + 1) << bitmap->mapped.pgshift);
-	}
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_set, IOMMUFD);
-- 
2.17.2

