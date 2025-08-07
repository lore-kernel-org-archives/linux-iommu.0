Received: from va-1-16.ptr.blmpb.com (va-1-16.ptr.blmpb.com [209.127.230.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555161E4AB
	for <iommu@lists.linux.dev>; Thu,  7 Aug 2025 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537636; cv=none; b=UbrNr3z+JzCUNknJuCh7oItC5fKf8tVnR2ITBiuFWIjtqlI4bINxr5/h+hq7cKy1qKbkT43rlXw0hVloTo962XGA2uYxrvK3zKsDZWWW5qZkCq1C+uVq8hY49aj2RmpKwoDGjgddO3YMVEO+Z8Qz5o4RtFH3Zl29V+FnpFWKLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537636; c=relaxed/simple;
	bh=hRea0IlzPQc+TJfL1Mi5sGTdqpcPUvPxWlNW9eL5ugw=;
	h=To:Cc:Subject:Message-Id:Mime-Version:From:Content-Type:Date; b=YCLfMtW6/dy4HwEOtXHU+M+SX0jkHF+sVc1BBLaUFAwH7atYKIhl+weoDFP3NtV51MsrBjllCcMhavog7ICpPCiTGHcJPNsch1iVyZxlin5PCNji+u9eANrKac+W2eXOdDwfFAWdfM2jkoW+z0oel0Gpf6sPRF6Vk3DMbA5/OOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=xOr2sX/L; arc=none smtp.client-ip=209.127.230.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="xOr2sX/L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754537583;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=xiMJCuJpfu6nMJUxvjNUYm7BQ48UmD6tw9atHX3Jh5o=;
 b=xOr2sX/L49NQuZgliY/hmBvgx78stHE0DNsz0zQHrIgBKfnvxmFbI96XjvQqIWIZhpZfWp
 ihvtsiyXBFf+kR30lTSOocqiTrMNMZ7EWflIfNRiplRiHW++KWVn8bzKCecKAVqCcCo+sh
 uQJibh92yw9NSaL0F7JsY6Yc3C9ZY/FX/GQBz3ugLTufAPCJYuXakKNNSE8y1zyQdiN94Z
 nBuOt8vOpF+ovNOOCLNtGSEbNxE44DRfv6VPqS/l+ZE7cnN9jafJmKxI97YIe0mlgC/TFv
 QgQE7550pp9yvEm2Nprost4hgTYFPgYZZU+Or7BNQe8ssaEvg40S+tt7Hq+ZVg==
To: <tjeznach@rivosinc.com>
Cc: <markus.elfring@web.de>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<huangxianliang@lanxincomputing.com>
Subject: [PATCH v2 RESEND] iommu/riscv: check pte null pointer before use
Message-Id: <20250807033252.1613-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Date: Thu,  7 Aug 2025 11:32:52 +0800
Content-Transfer-Encoding: 7bit
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Thu, 07 Aug 2025 11:33:01 +0800
X-Lms-Return-Path: <lba+268941e6d+cfd020+lists.linux.dev+huangxianliang@lanxincomputing.com>

The riscv_iommu_pte_fetch can return NULL when the provided iova is not
yet mapped, the caller should check if the returned pointer is NULL or
not, but riscv_iommu_iova_to_phys missed this, which will then lead to
a kernel panic.

Check the pointer before using it to avoid the bug. Now, when
iova_to_phys is called with an unmapped iova, the kernel will not crash
here.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>
---
Changelog
v2:
- Update change description
- Add "Fixes" tag

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
