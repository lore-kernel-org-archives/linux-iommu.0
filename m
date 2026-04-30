Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24E2DA768
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567594; cv=none; b=n4+b4kqe+ZY9+Wq50YnUAu4Dfayh4ipIh0k23+H0+xfCp6W480RHP67jb1ytqy/+E4pCl7O2D9Z3NF1HE/g8kKSvvFXN26B70Bbc4ZPpH2vZDb8urEkv2kgVQWntTa8c2IWIak9o1O/7vzjHRPdftPMojVIFd8F/Ud+WOd4sZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567594; c=relaxed/simple;
	bh=vBZRA2uGIChcs+ndx9gspjN3QNgcLBXYaCL4wYQ6tSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apl6j2WdwvweYXfTMWU317e1jYQyQcHgefOQRw41Dyv15R0hlR6z0rYdFSmxFTdWCy4mT/zhjfVkwa4g0WFo3Jda89k+YQbjA1hoVoNP9nHCaAZA8Mwl+2b3bzc/RRk7nwwWvhE5c32pkcLotkGiBWtd43fkrwTYvGjH5+E+yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TSQ3z0/Z; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TSQ3z0/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5X
	ywz8beiXKigdPY0dCWJdyNA0g5/M/vRfZ/rmu5OqQ=; b=TSQ3z0/ZEnuWWFf/4c
	0XiCngqtAQjhzo/tqnl6h5Fzow9rZB016nU+D9QOe5+0U17a9KxktgeKkFD66N0Z
	KChJ5SVC1l2pNaFFNqqayyZDHtL5gy4OQbkOhECezS6yKNjjVEg6kY5vICxW7rpU
	Br095kZa5cQomfXvXoU3XBhPM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHWJ46h_NpWWQZCg--.13259S3;
	Fri, 01 May 2026 00:45:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/2] iommu/arm-smmu-qcom: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:45:44 +0800
Message-Id: <20260430164545.49637-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430164545.49637-1-18255117159@163.com>
References: <20260430164545.49637-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWJ46h_NpWWQZCg--.13259S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr1UAw15uF1UZF13Arb_yoWkJFXEy3
	W8A3Z7J3Wjy342vry0vrs3Zr90vaykurykWw4SgFyrAr15K395uws5ZF1kGw4xAF40kFyI
	g3sxWr1rZFy7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKiiSPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBtH6mnzhzsbHwAA3Q

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 65e0ef6539fe..99469c4ebac2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -208,8 +208,7 @@ static phys_addr_t qcom_tbu_trigger_atos(struct arm_smmu_domain *smmu_domain,
 
 	/* Set address and stream-id */
 	val = readq_relaxed(tbu->base + DEBUG_SID_HALT_REG);
-	val &= ~DEBUG_SID_HALT_SID;
-	val |= FIELD_PREP(DEBUG_SID_HALT_SID, sid);
+	FIELD_MODIFY(DEBUG_SID_HALT_SID, &val, sid);
 	writeq_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
 	writeq_relaxed(iova, tbu->base + DEBUG_VA_ADDR_REG);
 	val = FIELD_PREP(DEBUG_AXUSER_CDMID, DEBUG_AXUSER_CDMID_VAL);
-- 
2.34.1

