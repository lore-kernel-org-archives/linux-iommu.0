Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0861B4F17
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190866; cv=none; b=jCl7490Pe1BpoZ55Z6ulL8+o1p6cWcfqkOwMr5ZO4ACL0VwAvHhJ+DOjmOnfUULQJ2hjsW4ro3BVvMAHbAN1Y86CGcaLzYLDdW5J6HucnNUlurdAuyxrr2gI7wjdcBfUCijhtawqxM3AIhjECAcveLgsQRQemxmRa4Kz7UZTQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190866; c=relaxed/simple;
	bh=OEL4HT5sC2BxLM0g9PVJMTQVwKeAJ0fimaT3B+Ajef0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GI9X30i5o44abPhmBwCBBQlT87yotMhOJWmnmMiaSjubyCGJa9OGxSOF8s4FsTNNFwGWsycE9JEwha0MKCoIGDqG94ewWDFoixIHUV3xS3CUADsAuHBxEUCBOvgijl26+NjA5gB+m3pcOt2KSqaAaJTEs3RLfROva3FoDpSJCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WBWOMMAQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WBWOMMAQ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506HtkV8025391;
	Mon, 6 Jan 2025 19:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=0liTRWyhVck4jq+EeCoZWqVP1uYPs
	DbpBW2G++gpXU4=; b=WBWOMMAQEHUCRg3HFGvW+cHAMt6C3dvxV2iGYmhJpKlmd
	lGyV58depH/MAYRY6P7/JmnSbqG8Kox0O0XsanAGgG+DXEmBXUcYbyuChf5VrDEU
	uBbqk4TPup10emhk9w6tKK2prKSTFvP4N2o/dqklMYj5+kT+0hZqmLLfowAUx/97
	kkz18BnrRg8svsVdhB2J7401UDoropSwhWws5G6NV58Hv9MZC3s/srHdxI0O9LQM
	yjQuilognazUA8GAK6xm2P41E0HX7FSpsf9gkzRSEvWlicy851mo8e4M/L8tS7Bc
	iiT2bUHaSa5uLk6CTahTQOG0WCt5XNNslMeT8YVug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb38c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 19:14:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506IQPdW010284;
	Mon, 6 Jan 2025 19:14:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue7dgnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 19:14:17 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 506JEFMU012384;
	Mon, 6 Jan 2025 19:14:15 GMT
Received: from alaljime-dev-e4flex-vm.osdevelopmeniad.oraclevcn.com (alaljime-dev-e4flex-vm.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.106])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43xue7dgma-1;
	Mon, 06 Jan 2025 19:14:14 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        will@kernel.org, jgg@nvidia.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating Host Page Table Root
Date: Mon,  6 Jan 2025 19:14:13 +0000
Message-Id: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060168
X-Proofpoint-GUID: KiGL8WKeWUYLmf8zgLKJvm8hlp-XS9ZU
X-Proofpoint-ORIG-GUID: KiGL8WKeWUYLmf8zgLKJvm8hlp-XS9ZU

When updating the page table root field on the DTE, avoid overwriting any
bits that are already set. The earlier call to make_clear_dte() writes
default values that all DTEs must have set (currently DTE[V]), and those
must be preserved.

Currently this doesn't cause problems since the page table root update is
the first field that is set after make_clear_dte() is called, and
DTE_FLAG_V is set again later along with the permission bits (IR/IW).
Remove this redundant assignment too.

Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 20177e18eb0d..a8c17b602c95 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	make_clear_dte(dev_data, dte, &new);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] = iommu_virt_to_phys(domain->iop.root);
+		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
 
 	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
 
 	/*
 	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.

base-commit: 1f37ef785d54b27e304c189038697a845259408a
-- 
2.39.3

