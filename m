Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7757CBE
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307345; cv=none; b=btPk7Mtg0a9ZbO6On8ElxMbEZzMmnVQZ/m4FocQDO/i3JbqzCyoyxhHWvQn2cIJ/eKvPEabnFDGXDFcfWFoxm+C+92Pna+cV7nlqyn0dFOBWm9rFEhN9/hD30RZOsEnMhs/rBEN8P9Zg986egBMwQRmudca1fzyIzEoMJdCQv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307345; c=relaxed/simple;
	bh=pk9rDW/8PJfyGVDRKhGR52fq86aLGSZWYWmwV6FRoZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6UIoUfPMkfw1DpGAl6X5Ip2VbBFWadiWDyjOtSv6dH+XBDxe0kVthek14k+R7jjc1GKgPMyL7zbU5AWrCLU8dUathmW1CUKlabEOcbO4bDtRRkVFlINRPbXrIqeYg0NlGFqk1m1wrSP0tayl8tUYvBkHdA24wagz5OiUF90DQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqCc45ytDzyR3C;
	Thu, 22 Aug 2024 14:15:16 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A4D81800D4;
	Thu, 22 Aug 2024 14:15:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 14:15:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] iommu/arm-smmu: Simplify with scoped for each OF child loop
Date: Thu, 22 Aug 2024 14:23:11 +0800
Message-ID: <20240822062311.3489924-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b98a7a598b89..18a4568f0aaa 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -764,14 +764,10 @@ static struct platform_driver qcom_iommu_ctx_driver = {
 
 static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 {
-	struct device_node *child;
-
-	for_each_child_of_node(qcom_iommu->dev->of_node, child) {
+	for_each_child_of_node_scoped(qcom_iommu->dev->of_node, child) {
 		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec") ||
-		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec")) {
-			of_node_put(child);
+		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec"))
 			return true;
-		}
 	}
 
 	return false;
-- 
2.34.1

