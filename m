Received: from va-1-15.ptr.blmpb.com (va-1-15.ptr.blmpb.com [209.127.230.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346ECEAD7
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674634; cv=none; b=d5a/QBSo5qbzNMXBxGGAYioVnPHIHDoentGVmo1gG5JgvkEqEclE+bpxD5+8zp6Zu85hK/6Qnw+PlaNFs5IMSHz/es+12wSAmhozlPH/l0O30wYK+usqIWfBFHPbbXJw7Q0Ifq0ZRnEun2PtNuaostZzovFQYCs0HKylAfndh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674634; c=relaxed/simple;
	bh=2FatlzUiRJAMOJ1x6bR+ebEF2y9NwuQIqBshjOfdc14=;
	h=Subject:Message-Id:To:Date:Mime-Version:From:Content-Type:Cc; b=P7dPJ2XVmzD6o607pE/uoF1c+J/M3kudCukwNArYwTrCWBD9/FtcCwmgWAsS2RAzAtS9wQZz27fbwd23eCCt+zdezjV1y1Urkde+7Vfl6uq5dvVfeFpm8QEn4fKvV+Ikfj2YRwntioqZmIp+vRDslN7W21qSa98EUAdYkf4CJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=IgYdjih8; arc=none smtp.client-ip=209.127.230.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="IgYdjih8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755674578;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=kZxmK5a1KAqXLehUVFYamep8ylDTy8+Ik5zqiesTQDU=;
 b=IgYdjih8GFgXd6SQ7J2LREnUtlpk4CyEinPz89A6jfxoWT7MLKIPG5kLzwpvrZKgIWjkXZ
 XNr0/Cb4kMsDAP0Und0ltZhp36ebGxNWEiir+IMvZEFMbBEVLYiubafr7/5q6dM4e3sTH0
 EsTdik+gW3KTIQR9t2alMhzkTTudM8YybE52d0P0XCJ5dJaGLKrYa/gIBXDt45Tu19RcTT
 iOVISBM75NAR/PHSeJJ4ab0h7/ehCdA6EydL6My+SYGd0GjDIwQJw5xtkPTeMiwInJIrX0
 Ms/ogbfZTd07l67plJsZGscyYYAWgVkLlGr5SWolMyhTq91SCGSrPcUkkVGoww==
Subject: [PATCH v4] iommu/riscv: prevent NULL deref in iova_to_phys
Message-Id: <20250820072248.312-1-huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+268a577d0+25ded4+lists.linux.dev+huangxianliang@lanxincomputing.com>
To: <tjeznach@rivosinc.com>
Date: Wed, 20 Aug 2025 15:22:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 20 Aug 2025 15:22:55 +0800
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>

The riscv_iommu_pte_fetch() function returns either NULL for
unmapped/never-mapped iova, or a valid leaf pte pointer that requires no
further validation.

riscv_iommu_iova_to_phys() failed to handle NULL returns. Prevent null pointer
dereference in riscv_iommu_iova_to_phys(), and remove the pte validation.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
Changes
v4:
- Change the summary as Markus recommends

v3:
- Remove redundant pte validation in riscv_iommu_iova_to_phys
- Improve subject line to emphasize prevention

v2:
- Refine problem description
- Add "Fixes" tag
---
 drivers/iommu/riscv/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2d0d31ba2886..0eae2f4bdc5e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	unsigned long *ptr;
 
 	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
-	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+	if (!ptr)
 		return 0;
 
 	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
-- 
2.34.1
