Received: from sg-1-39.ptr.blmpb.com (sg-1-39.ptr.blmpb.com [118.26.132.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE635B652
	for <iommu@lists.linux.dev>; Tue,  5 Aug 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389097; cv=none; b=KQeTg2zHG0PLg6tTd+VK1qGb7yKpJw6PTCMYPIHBmbn0sMFTrV+InSunAsnVdOkEBAscUZTqHcyuuPOhbxsp97UlXEi3pYHABLPRKUcmuuISRYXOMlS0AcVd3udMYmDGZUCO78QKhudkZxFwiCd06v36WttvTV6tmnl7vOhgYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389097; c=relaxed/simple;
	bh=bA++dzmXc9zStBySJ35CM0F4lIfN36Koam3LxsbW69A=;
	h=Content-Type:Date:From:Subject:Message-Id:Mime-Version:Cc:To; b=aM5/iHxcUPCQrBQ/A+Uv2aC3vmr3zHBug/KTCnkonBvZhlqHtG7fkXkT+rsxZ3tDzoL7tmEpK7IMY7xwFFo7+BM2BL0ct4WnTjwV3WjUUc99tgI9Fi0ytfW7OP065iFiBmbn5bQYnwuCM56qzqtRrRce4Sl4WA5bNBFirJl07Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=eOlhwhHo; arc=none smtp.client-ip=118.26.132.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="eOlhwhHo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754389072;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EWKh/6dZIglI4fJ1iIweOgozO4ucjLIZAOOQ2PsOGzc=;
 b=eOlhwhHoPO5IBQyQIFRLTkXvGQ8+90am7CYZ4hRhF4gb+JMOZiKFAXZd9bg8Yj0jWvm5xm
 dQh8TT2HIDJaAQhCDDM9O/NDajYGAaGelIOHr3dOEtvh65zx3NUROsivz/KWZZ3srKQIrc
 X9OitQ4KVBUbLzu+zQMGNQl58kv8mvwVPjToDam1oOxs1JS+Rje1VNuMWh9fVFT5tmq8tg
 8I4QPMTEiVe3kDelIb1V/Jyxaa6PaUz0q1aubsQ+ATOkQxaMhBYRskBenoPHJmBVgpdRYW
 6niNcqsoUT55E7wx9DBh7pJThYWYbUqMyaICA/PHQ/FOf6AvrBTVOMmtbUQshQ==
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 05 Aug 2025 18:17:49 +0800
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Aug 2025 18:17:41 +0800
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+26891da4e+9fc49a+lists.linux.dev+huangxianliang@lanxincomputing.com>
From: "Huang XianLiang" <huangxianliang@lanxincomputing.com>
Subject: [PATCH] iommu/riscv: check pte null pointer before use
Message-Id: <20250805101741.30819-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Huang XianLiang <huangxianliang@lanxincomputing.com>
Cc: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
To: <tjeznach@rivosinc.com>

The riscv_iommu_pte_fetch can return NULL when the provided iova is not
yet mapped, the caller should check if the returned pointer is NULL or
not, but riscv_iommu_iova_to_phys missed this, which will then lead to
a kernel panic.

This commit just check the pointer before using it to avoid the bug.
Now, when iova_to_phys is called with an unmapped iova, the kernel will
not crash here.

Signed-off-by: Huang XianLiang <huangxianliang@lanxincomputing.com>
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
