Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3D83614372A
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501569; cv=none; b=JPVaRSwyreJTBqccbCxF40WQUtgb04fP7gPtqZznaJ+Zlav1xgnBsGz2YvYKHFhKmzqxc7vM2Wla3+XeT+5nmbdSXu1ZcqUurkO3x+CIoSqdaz5B47ccwNuOyh1p2jEuEI/Ok0QUFCLPORnSS+9xrPFpafaOFcL3lDbG3Eb1EgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501569; c=relaxed/simple;
	bh=p6de8ISvGtQYeLkdgHcT+UhUuBgzjaRIyC6F/0qCGvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIfVUq+O8wmi873r52HdmcqPM1i8r2y7qmaCqUg4KOGghcwCJoYbKs2cH213HEwpqHlwJDnT78V/gMVfqlG2pwNO0w9t4Ih2Sa8mEZBUluarE47EeG3+nQ/C2TKZoZOlsoQ0yqrtUsxQ3fGXf7/uSD61yzAPAmh8TKJqEGONDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A0ABB606E3AC4;
	Tue,  4 Jun 2024 19:45:54 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: Su Hui <suhui@nfschina.com>,
	tglx@linutronix.de,
	jiang.liu@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/amd: avoid possible wrong value of 'hwirq' in irq_remapping_alloc()
Date: Tue,  4 Jun 2024 19:45:23 +0800
Message-Id: <20240604114522.2630682-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'devid' is type of int, but 'irq_data->hwirq' is unsigned long.
When 'devid' >= 0xf000, hwirq will have a error value in 64 bit machine.
For example:
(unsigned long)((int)0xf000 << 16) = 0xfffffffff0000000
(unsigned long)((unsigned int)0xf000 << 16) = 0xf0000000

Add a cast to fix this problem.

Fixes: 7c71d306c97b ("irq_remapping/amd: Enhance AMD IR driver to support hierarchical irqdomains")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52d83730a22a..934738dfc8ea 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3506,7 +3506,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		}
 
 		data->iommu = iommu;
-		irq_data->hwirq = (devid << 16) + i;
+		irq_data->hwirq = ((irq_hw_number_t)devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
 		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
-- 
2.30.2

