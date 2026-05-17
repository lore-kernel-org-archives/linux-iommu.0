Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF870830
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979071; cv=none; b=bXBd8V91LaTD2t4rt5cvLMQ9FkMTM3lauHo5M9w9wgCHBPM2b1rNaq0xOLjI5MrYZSVq0yCrWAtwd+FOBlNeooSXy200G50YfdrDs2RTsX62EZJe/8nDY37joInS5Eg92yJtzh1X6+A3FiIw6C2nj4taRtUVRbmoMGLCyVffkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979071; c=relaxed/simple;
	bh=vQpgsGOnfqedl0TX87U4zMzvFFz0UDB4jJoZMLdhGxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oebDROjCSNZI1un7GiMyJW04/XdsI5DyQj4y6+IbKcElLBAuZg32lCbIRyhEoMgi0qq54/Alri5B6HH7uU6kUoLsBFqGE4ByoHbgMhXna5fHA0IyiOr/hdQ/V2ORH30zXDSqsSHs+RmXBzfE4eJb+nYxIpyW9iNipznxRkoTl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ffb7RcNf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ffb7RcNf"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC9F120B7166;
	Sat, 16 May 2026 17:50:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC9F120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778979059;
	bh=mCKUQ4PV+b6oGP9aITiW6m4Z4aNfJIHGPjXpLn1su+c=;
	h=From:To:Cc:Subject:Date:From;
	b=Ffb7RcNfkHey8LR+idMAEG98d+2zqhimWD7OPoj93CKiXPumPfhItYXAtzeJLGDEc
	 bR+w89A5rQ/LDdBH3eqOWjzuxlsnaFZiKfcOgCjd8gdyaMA75+hBCrPvsKgrJNSHT1
	 rLAp9byCJ+t4VrcmMwSHJ7B0XMPXHsfw5K0wjxj4=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	robin.clark@oss.qualcomm.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	stable@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: pass smmu->dev to report_iommu_fault
Date: Sat, 16 May 2026 17:50:52 -0700
Message-ID: <20260517005052.3783378-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

report_iommu_fault() passes the dev argument to trace_io_page_fault(),
which dereferences it via dev_name() and dev_driver_string(). Passing
NULL causes a kernel crash when the io_page_fault tracepoint is
enabled.

In arm-smmu.c, 'commit f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")'
replaced a dev_err_ratelimited() call that correctly used smmu->dev with
report_iommu_fault() but passed NULL instead.
In arm-smmu-qcom-debug.c, 'commit d374555ef993 ("iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845")'
introduced two report_iommu_fault() calls also with NULL.

Pass smmu->dev to all three call sites.

Fixes: f8f934c180f629bb ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")
Fixes: d374555ef993433f ("iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-4.6
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 4 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 65e0ef6539fe7..8eb9f7831de07 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -399,7 +399,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 		return IRQ_NONE;
 
 	if (list_empty(&tbu_list)) {
-		ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
+		ret = report_iommu_fault(&smmu_domain->domain, smmu->dev, cfi.iova,
 					 cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 		if (ret == -ENOSYS)
@@ -417,7 +417,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 
 	phys_soft = ops->iova_to_phys(ops, cfi.iova);
 
-	tmp = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
+	tmp = report_iommu_fault(&smmu_domain->domain, smmu->dev, cfi.iova,
 				 cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 	if (!tmp || tmp == -EBUSY) {
 		ret = IRQ_HANDLED;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206eb3e..92d8fa2100adb 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -467,7 +467,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
-	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
+	ret = report_iommu_fault(&smmu_domain->domain, smmu->dev, cfi.iova,
 		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 	if (ret == -ENOSYS && __ratelimit(&rs))
-- 
2.43.0

