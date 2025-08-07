Received: from va-1-19.ptr.blmpb.com (va-1-19.ptr.blmpb.com [209.127.230.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E9524F
	for <iommu@lists.linux.dev>; Thu,  7 Aug 2025 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534279; cv=none; b=ciQkSfueEFWWy7fe/DeloTEJQmHyBz/cQAc/HCjhLsxgCImeiPGmeHRRr6Yvku4xcYzZ7h7Mov0DuXpVtWg/1m6SiIbN/lUVH4bQSeLLHtl4Sj7dprpfribSgIxfzS/gSkkg/2Qasq+hzlyUEh3Hnq62Nr+A/Ve4HfQETkLl+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534279; c=relaxed/simple;
	bh=/rN/HmM3ZdTXW8EncKDZvcOeakQ8W9MXCc9EUMcxCxo=;
	h=Date:Message-Id:To:Cc:From:Subject:Mime-Version:Content-Type; b=e7jx6+68meDV9IStMfGoIPArub4UWjOpzXlHHK8yEyUg2QOLWQ1De2wMEGtSXI2QXgiAEV7ylHtvMFaSYgIG/oTfvJ+2FWoYIRV6NGNG7GsEzYN06FSRcVYzz7/O9QKxGc54v0VPTfX8pFv5wckOjBKM2dPMTGGDIAEZYNVkwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=QVOUtWvJ; arc=none smtp.client-ip=209.127.230.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="QVOUtWvJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754534227;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=tvpUwXpgi4bbfw65gWC7ncSTc2jcTFdcUIgVdaFTeCY=;
 b=QVOUtWvJyGPJ5k4E7xighwdtybqSJQioP8gY/XWRsVuSjrvt21VZ9kcwYKrQPpY7aSPacc
 OiT6eHf813urrPL8ddkclM2zIQY11+WloarM3UdVoaKFHmzNuUaBQxMnl6nsWpKVrJ6qbE
 RT0MbGZcilSeXzzJh55xIBWjUDbrizpEyRL0Vk3X1rRppjnCs5nFZzB12W50x6WEPZOfq/
 SLmTNdazFzFqV2z6ddjZugHWzaIjgtdC6NXjjLiLyKI1ZyRZ94fvu60rgbtJnC6svVm8eq
 BD4SAHpMH8AUnRZdFPg0sxp7O6XYVcJ6FIFBbdrHK7ls20AvazAl+crsBWogjw==
Date: Thu,  7 Aug 2025 10:35:57 +0800
Message-Id: <20250807023557.6482-1-huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
To: <tjeznach@rivosinc.com>
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
X-Lms-Return-Path: <lba+268941151+a476ad+lists.linux.dev+huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Thu, 07 Aug 2025 10:37:04 +0800
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Subject: [PATCH v2] iommu/riscv: check pte null pointer before use
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8

The riscv_iommu_pte_fetch can return NULL when the provided iova is not
yet mapped, the caller should check if the returned pointer is NULL or
not, but riscv_iommu_iova_to_phys missed this, which will then lead to
a kernel panic.

Check the pointer before using it to avoid the bug. Now, when
iova_to_phys is called with an unmapped iova, the kernel will not crash
here.

Changelog
---------
v2:
- Update change description
- Add "Fixes" tag

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
 drivers/iommu/riscv/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2d0d31ba2886..b0186faa0300 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	unsigned long *ptr;
 
 	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
-	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+	if (!ptr || _io_pte_none(*ptr) || !_io_pte_present(*ptr))
 		return 0;
 
 	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
-- 
2.34.1
