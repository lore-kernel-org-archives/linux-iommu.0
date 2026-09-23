Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023F361953
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128254; cv=none; b=JD7tjTk4k631llClmWjshDhxP+LBpNwpl8DJZCmmeeNuxPqhfgm1J+CBOUNTRwfb3rRLe8M87xuhLQ4pTQXwlxxJnw9/YGSFQ4y4wLumKN8ui0bEmFywg4a5vOMAtg8yEDGJ79e79Z2SbvjOg03DQrOR0BBXgCdJu97vLhTTBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128254; c=relaxed/simple;
	bh=OwBa6xGvfl7idKdaXvc7TVtZKDhmNSCK1vcoHvvXPP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hk0AVFUg3MyvEtJuVTpA2KsQQcSGK/zJYibd4CET4N7qU+iHkQlDf8+DXgUwcIXXLNFzNH9XwUoZYVPkndp89N34ICeiKZsT8PlK3UqvRR4O7J89YfLLrAnsrrB5lepfEiQV1BWMULEUBxR9+PyDN2Vhs+pLUlTeBKcfoQDo2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LTXAls5C; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LTXAls5C"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ecb22f1b;
	Wed, 23 Sep 2026 09:50:45 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] iommu/vt-d: release IRQ vector after request failure
Date: Wed, 23 Sep 2026 09:50:39 +0800
Message-Id: <20260923015039.1884067-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cbf54aa503a1kunm70634b72b0f7f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE4YVhofGEkYTk5DSEsaGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LTXAls5CjRoUF8hxynE36n2EnX0gN/EfGNgeISNKl9aOK/UX4GElttYBikzqqqt/N8eOBx9SrESA+0ojgwe4GoCS6YGg94e20fH9/ao7TZtGqyXI63M5XMUmWd6EGAHjhdJLgsMuJ6oWamcuWhHEPVyfhxpQgKlc2x4hTdrYR3E=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=UjfQwllVPeSsMmKu1Wr1AVRaxMNq/L5K8NDTvYarh+Y=;
	h=date:mime-version:subject:message-id:from;

When request_irq() fails, iommu->irq remains set, so later teardown
attempts to free an IRQ that was never registered.

Release the reserved vector and clear iommu->irq on the failure path.

The failure path was reproduced with an x86_64 kernel under QEMU using a
q35 machine and an Intel IOMMU with interrupt remapping enabled. A
test-only failure injection makes request_irq() return -EBUSY after
dmar_alloc_hwirq() assigns a vector, then attempts to allocate the same
vector again.

On the unfixed kernel, the failed request leaves iommu->irq set and the
second allocation returns -EEXIST. With this change, iommu->irq is cleared
and the second allocation reuses the vector. The failure is deliberately
injected to exercise this error path and is not expected during normal
QEMU operation.

Fixes: 34742db8eaf9 ("iommu/vt-d: Refine the interfaces to create IRQ for DMAR unit")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iommu/intel/dmar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08c..d479e70c5 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2098,8 +2098,11 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	}
 
 	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
-	if (ret)
+	if (ret) {
 		pr_err("Can't request irq\n");
+		dmar_free_hwirq(iommu->irq);
+		iommu->irq = 0;
+	}
 	return ret;
 }
 
-- 
2.34.1
