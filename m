Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE5189F20
	for <iommu@lists.linux.dev>; Thu, 31 Jul 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931950; cv=none; b=LzaMeYOwD/hW1nqbatEbGYL8ZYdGis7NSYBOTFhzImqRifUyZmMimt1mSDlFfjAAt01iig6C2iX3nKNVW87YbiowA+XU3BcKrJ580zpmUroLW8Ihb5/ENFyzw9oUIjrNeRljuj/WpuWbI/nLN5DJ8rZ06HgdYvIu11LaAN+dmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931950; c=relaxed/simple;
	bh=cN1ZlwbbCqmJ13urYAh6MK999RuzzPbxeop+dhHmN2E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CSDjp8YSGk/sAdnoYe3AlUOXSTWXun2UutwYggqHJdBZXbgURrJiFt49wEJyG0opefwaerrWXnMlDSITimDRWREmBmeC7C19p+BQUhD0EMVpvtZI2GM+8bXj2hH136BXL7vermA9Z92MKcy0GTJCpEEATMds5f0A16jcC6NGNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1ba31eec6dbd11f0b29709d653e92f7d-20250731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1bef9395-f09e-4aa4-8528-cefe2e0d19d4,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:707c96dfc8fa45d302ad1c5696b7a62a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1ba31eec6dbd11f0b29709d653e92f7d-20250731
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 995350925; Thu, 31 Jul 2025 11:19:02 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	robin.clark@oss.qualcomm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] iommu: Fix macros coding style error
Date: Thu, 31 Jul 2025 11:18:59 +0800
Message-Id: <20250731031859.550632-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change just fix coding style, no function improve.

-Macros with complex values should be enclosed in parentheses

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/iommu/msm_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 43a61ba021a5..85f74b3c7a1f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -26,9 +26,9 @@
 #include "msm_iommu.h"
 
 #define MRC(reg, processor, op1, crn, crm, op2)				\
-__asm__ __volatile__ (							\
+(__asm__ __volatile__ (							\
 "   mrc   "   #processor "," #op1 ", %0,"  #crn "," #crm "," #op2 "\n"  \
-: "=r" (reg))
+: "=r" (reg)))
 
 /* bitmap of the page sizes currently supported */
 #define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
-- 
2.25.1

