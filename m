Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B65268C48
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403087; cv=none; b=faRwB/35XhTGM5/FC0xgSzwF5zCbAntY70A2FmRlc1dPxe6iQkobKdbVkbW/wZxsU0Ngjh0En8UxThfohY7WH2CWEAK3UVq27FMlAEnuvoG+83Jogj6hqtcHCygKL+E4oG/ChQLRLcQ2G3YkgMUh4GyUYY+yqouql5M3N6fE9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403087; c=relaxed/simple;
	bh=x7B9MnN6xpz37Iys3AovmgLR2oS5tnCU9+OgjSjXdhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIL5Nfh85pGaSpFECkhj2b+aCZ7m5PuhXjs+YRXQJg5Fu1/ca8ThZ8hwTWYaQA/Du+X7ug6dbILmQJiKXr97IoSKYmWe5y9+4pn7kSHUIiuTw3XpZBXMJeOLM5er8tLHkCllYCya9oCRtKkhEBEilwD2h1FnV4oDDMZx/gfya0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8NodISx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8NodISx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII4PL022916;
	Fri, 11 Apr 2025 20:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PQyazkUkM7A2DT0v2
	mq2AovAAjWaC5LljDabv03UP2U=; b=C8NodISx6u4e+I6R+ZWI7twpQ9dztzpge
	JYDutqcoRfbiyCNB2c9ew0OA7uewbsIFNIV5stA1OWUWXZrTV1gi428I7NwREL58
	qPSs7FZzOyA1xmnXDG230frJdYpbRkBB3pTieKRl1znLHlqG9yGNSf5qSp44FSN7
	+HpLVGzj9r5wdGo1eBArEiC80HZRE+kTloiTIlcrkvIRKi4OA0f8NdmzwBjkJT2Y
	9XeA8/5quaRuXpNaj0sxRLvxPY+fVvYKp3vG0Ve4HPvuA82dQoUa0VQcgKolUKGq
	rtecNqESmkZ42v6JRQKgypeNLHuS92BJirf7p/SEaq9/k2wqm8+vQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y78x0va2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHeZDp024577;
	Fri, 11 Apr 2025 20:24:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutvx66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BKOXTo27919098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 20:24:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD2C5805A;
	Fri, 11 Apr 2025 20:24:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0147F58051;
	Fri, 11 Apr 2025 20:24:35 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.105.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 20:24:34 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 1/5] iommu/s390: set appropriate IOTA region type
Date: Fri, 11 Apr 2025 16:24:29 -0400
Message-ID: <20250411202433.181683-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411202433.181683-1-mjrosato@linux.ibm.com>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f2UgZU-FSd_IIaL76mjJL0Lzw0zL6M2B
X-Proofpoint-ORIG-GUID: f2UgZU-FSd_IIaL76mjJL0Lzw0zL6M2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110127

When registering the I/O Translation Anchor, use the current table type
stored in the s390_domain to set the appropriate region type
indication.  For the moment, the table type will always be stored as
region third.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index e1c76e0f9c2b..cad032d4c9a6 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -31,6 +31,7 @@ struct s390_domain {
 	unsigned long		*dma_table;
 	spinlock_t		list_lock;
 	struct rcu_head		rcu;
+	u8			origin_type;
 };
 
 static struct iommu_domain blocking_domain;
@@ -345,6 +346,7 @@ static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
 	s390_domain->domain.geometry.force_aperture = true;
 	s390_domain->domain.geometry.aperture_start = 0;
 	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
+	s390_domain->origin_type = ZPCI_TABLE_TYPE_RTX;
 
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD_RCU(&s390_domain->devices);
@@ -381,6 +383,21 @@ static void zdev_s390_domain_update(struct zpci_dev *zdev,
 	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 }
 
+static u64 get_iota_region_flag(struct s390_domain *domain)
+{
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RTX:
+		return ZPCI_IOTA_RTTO_FLAG;
+	case ZPCI_TABLE_TYPE_RSX:
+		return ZPCI_IOTA_RSTO_FLAG;
+	case ZPCI_TABLE_TYPE_RFX:
+		return ZPCI_IOTA_RFTO_FLAG;
+	default:
+		WARN_ONCE(1, "Invalid IOMMU table (%x)\n", domain->origin_type);
+		return 0;
+	}
+}
+
 static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
 				      struct iommu_domain *domain, u8 *status)
 {
@@ -399,7 +416,7 @@ static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
 	default:
 		s390_domain = to_s390_domain(domain);
 		iota = virt_to_phys(s390_domain->dma_table) |
-		       ZPCI_IOTA_RTTO_FLAG;
+		       get_iota_region_flag(s390_domain);
 		rc = zpci_register_ioat(zdev, 0, zdev->start_dma,
 					zdev->end_dma, iota, status);
 	}
-- 
2.49.0

