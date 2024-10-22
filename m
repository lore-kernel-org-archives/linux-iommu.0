Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390956458;
	Tue, 22 Oct 2024 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556837; cv=none; b=OIetflVHzbzWjTxv2G4WIBJXpEt1TUuaVE+1OcK4qhAnNGR9OU3SupUGhlgo6ybhmgnf1VGrM6JO4DevVohfm+iNgLFd41jh7YvbZMg8h+D+o6H5iq8TBYs69V8IuZe1PyuqbNWLDnGn3+VJL1RzEHJ7wwUOFmwfkhPMToN+15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556837; c=relaxed/simple;
	bh=FUwOYCqb0UIvmCcIp5UgWEV3vFGgqExwTek6OSk1pJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqmA9GSCK3whDRFA7T83qap8sfUu0TPGK4hzvMhx71hYiKN+eMqWKIAep5FWxHtcgYg6nPT4ysaGng7YlV37y5EFmvCPcKEbU4FX0MrEL80PayoI4BL4n1NptsfjGjDdMUcGt2f7XQsVKZdffP4CkSjipCysmJrMGrWtLdu1md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iTUta9D1; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iTUta9D1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=t3cQdB5tT/CTlqWs31rOhZvN0HUT9n1StunejcJjhYk=; b=iTUta9D1KBjd+GaM
	xo3YiN4/n43NqnMa2j8gxfhxKV6265F536et3G0rtsFKB/dw2HZWC7CV0XozqFU6ElQpP6TqBGkNi
	u4nqie01Y7XNHX5qsGGSzvSAS7mYqwC6ii0bccWNwAs+yB/TON0D2sV9v0rkGznwyM14nSl8YbhUx
	wz+7xMsH/BzuNesa09AQudwDYl6V/oDFJRHkwdO4A0U485QWuWIQ2rnMljfeaVHVrdzqzPWLFcZyN
	q0P0LG8agKkwprLaKfrsWFBx9RNi2Yp8Xx7Vt3gVIKSkH3ieS6xDgxrDghJoNCffEI9fU5qXtW54T
	0g2Khs3tjQsu72aYYw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t32jn-00CeJr-2r;
	Tue, 22 Oct 2024 00:27:03 +0000
From: linux@treblig.org
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] iommu/vt-d: Remove unused dmar_msi_read
Date: Tue, 22 Oct 2024 01:27:02 +0100
Message-ID: <20241022002702.302728-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dmar_msi_read() has been unused since 2022 in
commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

Remove it.

(dmar_msi_write still exists and is used once).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/iommu/intel/dmar.c | 13 -------------
 include/linux/dmar.h       |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index eaf862e8dea1..7881d9e46622 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1895,19 +1895,6 @@ void dmar_msi_write(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-void dmar_msi_read(int irq, struct msi_msg *msg)
-{
-	struct intel_iommu *iommu = irq_get_handler_data(irq);
-	int reg = dmar_msi_reg(iommu, irq);
-	unsigned long flag;
-
-	raw_spin_lock_irqsave(&iommu->register_lock, flag);
-	msg->data = readl(iommu->reg + reg + 4);
-	msg->address_lo = readl(iommu->reg + reg + 8);
-	msg->address_hi = readl(iommu->reg + reg + 12);
-	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-}
-
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		u8 fault_reason, u32 pasid, u16 source_id,
 		unsigned long long addr)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 499bb2c63483..692b2b445761 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -292,7 +292,6 @@ static inline void dmar_copy_shared_irte(struct irte *dst, struct irte *src)
 struct irq_data;
 extern void dmar_msi_unmask(struct irq_data *data);
 extern void dmar_msi_mask(struct irq_data *data);
-extern void dmar_msi_read(int irq, struct msi_msg *msg);
 extern void dmar_msi_write(int irq, struct msi_msg *msg);
 extern int dmar_set_interrupt(struct intel_iommu *iommu);
 extern irqreturn_t dmar_fault(int irq, void *dev_id);
-- 
2.47.0

