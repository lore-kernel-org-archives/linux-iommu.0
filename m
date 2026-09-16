Received: from va-2-18.ptr.blmpb.com (va-2-18.ptr.blmpb.com [209.127.231.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7B4EBAD6
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558056; cv=none; b=dd+KUekUFSDEo0iFcYgkRkbmnBz/qBml/jYQdSPaqI0SMLOdXbIMxl4zwEz4B6BP8imekTZeycNvwb+2D8ZcWCmVQT94aXhsBvsszEefPv2oEyMsMc92doStg79AIlrYbfUtjaP35EHTNmKM+U8/z2wUU7nUwTev2DYxmseLrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558056; c=relaxed/simple;
	bh=IrZ4eVbsv4PQUJh9c4N50MRJH3scpRZ/iALwIoF1FlI=;
	h=To:Message-Id:Mime-Version:Subject:Content-Type:Cc:From:Date; b=RBwgwWCeKNB0VMVn+jmqqRDNUg23P0jnAStzCCsmbd4j8GsZ+az+xezvtmpWNwqD5heipN6IhnpZLlbLRc+sRxmNmgI4rR7ZxVSocaYfPsq1bqjjZQXaToGrIAmAm2tJcF6jZGgVPx9WT4339JZj5mIQ2/NUBtGMHRni8K1XCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=MEyxarDw; arc=none smtp.client-ip=209.127.231.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="MEyxarDw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1789558043;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=5oXZlKLbyfic0rzx6a7/Yewkbeu2GdtKNRT5PP9pZY8=;
 b=MEyxarDwrIfJi/4/gg2GaFdPsuap3xFVYmHUNCovj/ACzXTg1WV8bJHeppdHibbSLrqLGQ
 zSwb1ZYKs0PMPwAaZj8z7K7HU8HurWI373/Gw4svSIrYibP/u9wQNYvyhmCxQwGy0OJ0G2
 znA/8+daMIU82E8LRCE7rSIGSOXVFcvsb9geuXvPEW4bt1/+KTM/ZSd3C/j3gNDOROhk/8
 Re7oBl/mCiNTsh5jS7OXKlPUPbDPo9KB/Y/E1BhTv4i6RYTkJh0lVelHKXKIjxYH0XlKMc
 Icny+Ze+AuOQVzgLm5Ot5YL3Q0KwNxwXFS6GXn0SKgwo55YedGYU/WvONiVJXg==
Content-Transfer-Encoding: 7bit
To: <sunilvl@ventanamicro.com>
Message-Id: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: [PATCH] riscv: iommu: ask for ACS to be enabled
X-Lms-Return-Path: <lba+26aaa7d19+ce394c+lists.linux.dev+xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Cc: <rafael@kernel.org>, <lenb@kernel.org>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, 
	<tjeznach@rivosinc.com>, <luxu.kernel@bytedance.com>, 
	<guoren@linux.alibaba.com>, <jgg@nvidia.com>, 
	<xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
X-Mailer: git-send-email 2.53.0
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Date: Wed, 16 Sep 2026 19:25:45 +0800
Received: from lanxin-ThinkBook-16-G5-IRH ([123.120.5.129]) by smtp.feishu.cn with ESMTP; Wed, 16 Sep 2026 19:27:20 +0800

Make sure ACS will be enabled during PCI probe

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 drivers/acpi/riscv/rimt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index e4538fa6c2c8..30d2d0211d5e 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -525,4 +525,5 @@ void __init riscv_acpi_rimt_init(void)
 
 		return;
 	}
+	pci_request_acs();
 }
-- 
2.53.0
