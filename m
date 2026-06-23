Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04763340286
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198817; cv=none; b=ad/AMDQL7hpWksfhw7J6YdHWlYj/3l4RKhTzBK1AOaz18V/6nGkAmQV5nul6a8oIoSk9zbLSAHPTiCTP0y4tK4NtUyJDiqqMAFsqoT6Q/nJJHEBksrWsMDALZx3QyEJ2XZ2KsgHdCK4SP4Re7m9t8P0J2VpODj9fMrSuPWai9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198817; c=relaxed/simple;
	bh=ll7sCeJdqnrLF1rrQ4sCH3LbuRxCyheWaYccMsi4nxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSqzk4G82MK291TZ4B8ITZnDAG3G781Z6pfPbEJf1StMm9ADe6bbVe/x6hDEFZHhwinH4J7V0Ptd/oEK3mRFsG9ZU/SStQBSV14uZMF8zHXecF9ZUf2t6Ycyx/oZR2RzG0vq7Z8vrLyk3b3QWeHVRVjvjWv5stdkbkt2Oq7e86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c6tNc/HP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c6tNc/HP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T5
	duRQLCA/bGKWwNVui3NRidvUDd3JmBN2G/gYGjz9A=; b=c6tNc/HPuqMUhEDXmf
	/VVWy7uRnqL2jjFAecWpsx6ALh02YXw6LIFvf8lp7aTWUbjmsAvXbVN+1tyRIOxn
	5lQqIPn8ZGa78IKop3ao8gw6Hm9p8gpgsc6SRhS5nZBsD8iGpZiimJNAz+zW6Nmh
	202+BVorehsvURByiLx3NEorE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCn5MjwMTpqH6DKFQ--.10651S2;
	Tue, 23 Jun 2026 15:12:50 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: robin.clark@oss.qualcomm.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jroedel@suse.de
Cc: iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] iommu/qcom: Remove sysfs device on probe failure path
Date: Tue, 23 Jun 2026 15:12:45 +0800
Message-Id: <20260623071245.1985938-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn5MjwMTpqH6DKFQ--.10651S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruF45AryDZFWrAr1kAr4xZwb_yoW8Jr45pa
	yUGFZIgrWUWF1rtFyUJ3Z7ZFy8KwsFva4S9r4fG3yYgw1UAryUKFyxtFySgr1rJFWDG3W3
	A3s3XryqvF15G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxRKxIGo6MfL+YQAA3K

In qcom_iommu_device_probe(), if iommu_device_register()
fails, the sysfs device created by iommu_device_sysfs_add()
is not released. Add a goto label to do the cleanup.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a1e8cf29f594..32efef69e72d 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -855,7 +855,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_pm_disable;
+		goto err_sysfs_remove;
 	}
 
 	if (qcom_iommu->local_base) {
@@ -866,6 +866,8 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&qcom_iommu->iommu);
 err_pm_disable:
 	pm_runtime_disable(dev);
 	return ret;
-- 
2.25.1

