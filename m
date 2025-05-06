Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135662ECFFE
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746500468; cv=none; b=aafnzZ86TXiJuQ4k3HrJDsfAqaQ62uOCzKr2OdNQ6dVezoAFi0xOGKXIDe5b0G/9Q+AJeyOAStWwKBjOCYju942DfrYh1FMMMZP502Ir0h4sI1ojdPRB/cYEWLrzSnpOUC8AHXAJVJjqmYd5EUnVvwsUVauLHEhMYGJrpimoxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746500468; c=relaxed/simple;
	bh=YSXb+HAe5RzNl6xB9OxpaEV5fxxjpxEx4rsX6iAMgMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToPanrclYmjn4yZsVGNtjVvAv0FmoAdRs82sBD4r3SzZeDNJ6ZsAXkRgy2QUddd6bD/b0Aypdon6zVWP7xF760XWoPQGhR4+b/WXtSg/57ozgSMEhVCRiSOdXw5U7irJRC5M+oD0GSyLxQqPA+UXlmxeJwN3WHHGC/i42vCIPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zs32S0gftzyVKW;
	Tue,  6 May 2025 10:56:48 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id E7AC21800B1;
	Tue,  6 May 2025 11:01:02 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 11:01:02 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <baohua@kernel.org>, <xiaqinxin@huawei.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 1/4] dma-mapping: benchmark: Add padding to ensure uABI remained consistent
Date: Tue, 6 May 2025 11:00:57 +0800
Message-ID: <20250506030100.394376-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250506030100.394376-1-xiaqinxin@huawei.com>
References: <20250506030100.394376-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Fix a problem about commit (8ddde07a3d285a0f3cec, "dma-mapping:benchmark:
extract a common header file for map_benchmark definition") accidentally
removed that padding, which has completely broken the ABIs.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 62674c83bde4..2ac2fe52f248 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -27,5 +27,6 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76];     /* For future use */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
-- 
2.33.0

