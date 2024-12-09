Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E81A0737
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772369; cv=none; b=cHIIDL10GF4Pdx1B7aD5FT0JirDBRsymh6ttd/Uc6KBY9Bm8X7R2pc6SPW5C0xXxBkBILWWINZ5KC2UEMkwZuqsuKOvpq1rHzNbMojt4qg4/ZvVI43gadorqBSvMQk73uB7riKfdc3zrYUR9kEIuUi9ByghfWhBpm8Fpcg0CI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772369; c=relaxed/simple;
	bh=LPNkuOmebHNuBo/pC6lnaWGMiAhUES4i8Dyjjjq50mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMafjKa/p43O6IczWfLSz2bewxt48P/SXd/0TkqUp9Rmna0jPsz4mtbC0KPdTHAYeLDYwrBZ5akDTTuhY2S0Mq/l6kT8M9p2Pl77KjS1oiCcFRZeQtJsNBLauyvG0BO5hrlyfD1Sy1Q1eLGuOsRwn2YULNXX0WiSlgPH4r4Drgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9S/Trdl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9S/Trdl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9JBHF1024001;
	Mon, 9 Dec 2024 19:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FunvrjiwafodM2rLJ
	eOmhzOHrDQ5GsZcH0APQLk7yY8=; b=K9S/Trdl3Is20Lc7P73REHlus4ftIj1Am
	ULl4sH8MpE3ok19WtPrzH0iDl4oH5eeHiq/rgj3Ig7gllAfhjyGLb/u1u0wdvhK9
	xpxSAjWdIdQdFn+kzgYojRQUjp7aN9zDqD4bENK27mKXDb/Gn8fCNQdxpJnvFUt5
	f6uTDdsG995SCwLKRKhp2liDgkOgZ0g2PqnarVa8wdg2ow2KEBkrVCbpKJG0sOnC
	J97PKMU7VeDZQaitLRMMkNnfVA6kWsozSUM0Uk7MaYYRGN151n42T1wVefI8eDVN
	pQfPtktg6NSjVxHPukuKN2bRg46EjF5WB9umuxyheZ1PZ6asxB3pA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8k7nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:26:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HRcQc032727;
	Mon, 9 Dec 2024 19:26:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps89x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:26:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPxHg25428568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:26:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F8B58055;
	Mon,  9 Dec 2024 19:25:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3A458043;
	Mon,  9 Dec 2024 19:25:58 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:58 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 7/7] iommu/s390: allow larger region tables
Date: Mon,  9 Dec 2024 14:25:49 -0500
Message-ID: <20241209192549.107226-8-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192549.107226-1-mjrosato@linux.ibm.com>
References: <20241209192549.107226-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uCaPcHQf14DWuo35zKYXSM53Mm4iXKLh
X-Proofpoint-ORIG-GUID: uCaPcHQf14DWuo35zKYXSM53Mm4iXKLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=903
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090143

Extend the aperture calculation to consider sizes beyond the maximum
size of a region third table.  Attempt to always use the smallest
table size possible to avoid unnecessary extra steps during translation.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  1 +
 drivers/iommu/s390-iommu.c      | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index 8d8962e4fd58..d12e17201661 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -25,6 +25,7 @@ enum zpci_ioat_dtype {
 #define ZPCI_KEY			(PAGE_DEFAULT_KEY << 5)
 
 #define ZPCI_TABLE_SIZE_RT	(1UL << 42)
+#define ZPCI_TABLE_SIZE_RS	(1UL << 53)
 
 #define ZPCI_IOTA_STO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_ST)
 #define ZPCI_IOTA_RTTO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_RT)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 4924fe9faccb..c6b2bca881c3 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -953,12 +953,24 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 		goto out_sysfs;
 
 	zdev->start_dma = PAGE_ALIGN(zdev->start_dma);
-	aperture_size = min3(s390_iommu_aperture,
-			     ZPCI_TABLE_SIZE_RT - zdev->start_dma,
-			     zdev->end_dma - zdev->start_dma + 1);
+	aperture_size = min(s390_iommu_aperture,
+			    zdev->end_dma - zdev->start_dma + 1);
+	if (aperture_size <= (ZPCI_TABLE_SIZE_RT - zdev->start_dma)) {
+		zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
+		zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
+	} else if (aperture_size <= (ZPCI_TABLE_SIZE_RS - zdev->start_dma) &&
+		  (zdev->dtsm & ZPCI_IOTA_DT_RS)) {
+		zdev->origin_type = ZPCI_TABLE_TYPE_RSX;
+		zdev->max_table_size = ZPCI_TABLE_SIZE_RS - 1;
+	} else if (zdev->dtsm & ZPCI_IOTA_DT_RF) {
+		zdev->origin_type = ZPCI_TABLE_TYPE_RFX;
+		zdev->max_table_size = U64_MAX;
+	} else {
+		/* Assume RTX available */
+		zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
+		zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
+	}
 	zdev->end_dma = zdev->start_dma + aperture_size - 1;
-	zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
-	zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
 
 	return 0;
 
-- 
2.47.0

