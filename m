Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF3139F
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049178; cv=none; b=J9dQXFOR0e2srcm9fhWurud6ehEyFJe7O3y26t1zP4T7hLiGTKRxNBdeDCMB6yQvnvQsi+zUKe0zPINiOJHk15+Lp65OIIjR1TEYzFQETFV4UP5M6qBLq0wlajgvgL9KIWdPZpG+9Ev43IOdN6XJTnGiHFynAKVfHfiSoEuNk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049178; c=relaxed/simple;
	bh=JUguHETqDOP1NC6kHcDcEM/JVS6Ow91MUipMFCyoUnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEmOFyRgiEWAZqRyvlTKUis8unIk08tlHo8YGeGpqU/QfXKcq//VnmmBGzbPnRru22iMFAAyuZq+0utWXG2lP0nIz6qZ1f0r4BaXkSyPqdI17PLpVOr9T1duxiRiJYkkzQGQSF8h3bATDzQXrOIucC/svhm1ff9HQCJK8f9h/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lkhQVpDq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lkhQVpDq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715049167; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qTEkl+KBoQB5V/RVkcEJU2StJ0o4KM0JoH9OvRriiec=;
	b=lkhQVpDqmSPK+D3RB/I41PRt8zUORN4yWu79HVB2BPzmQQoBm1v3gs1F2V0Z/k/T8xqDHzIzf/V/Ou5+IR8B16XUjzl2JP0oGPeBXTD3EbG9UKFz5cVIPlC7ITGsTSV/aF+0VM2rqjNvVA6+1g/CmH53Rrebm2PrAbECwM6emFg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=llfl@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6-XnSs_1715049164;
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0W6-XnSs_1715049164)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 10:32:46 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/amd: Fix sysfs leak in iommu init
Date: Tue,  7 May 2024 10:32:15 +0800
Message-ID: <4d516a6500ea0760e13cc19e2b14e663aa333518.1715048443.git.llfl@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the iommu initialization, iommu_init_pci() adds sysfs nodes.
However, these nodes aren't remove in free_iommu_resources() subsequently.

Fixes: ad8694bac410 ("iommu/amd: Move AMD IOMMU driver into subdirectory")
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
---
 drivers/iommu/amd/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..624ea2549f64 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1678,8 +1678,15 @@ static void __init free_pci_segments(void)
 	}
 }
 
+static void __init free_sysfs(struct amd_iommu *iommu)
+{
+	if (iommu->iommu.dev)
+		iommu_device_sysfs_remove(&iommu->iommu);
+}
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	free_sysfs(iommu);
 	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
-- 
2.43.0

