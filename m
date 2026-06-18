Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8ED403ACA4C
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769608; cv=none; b=gb3Tb4+44XgmuWP70Ed5V904QA7B51Sz6+Yv84zW8vdrSmB9kjTQ7E37NJLexNjqagAiN8g2iQQtWHRyvlbhh64WCWSw7KizwqTK3N0fxsBvF9JED9rMSS4fz3mxxnF4YbKtFcWfnyY9UO9YFqzw0lLK6okOSUdhZvw5P6CXa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769608; c=relaxed/simple;
	bh=qhqTlhNmOg8vSyRYZQcakEeel5znjMbKAhzTU73N1Gk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTO1iiXgSyvpq1kF0dIxLqTrb60SndHUYJFVQWyqLWzZy33bTWmWq1tBEwEBD/vxeph2WXdXUGN2GaRoqJud5ZuulRziSqNVM/vEqADbq6Hs+lAVAeeBSs9l0Q3BC4CicQIO+HHwOWT5FlnftXCLgEI0mo9lW9Iu8Ek2o62qS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=MDNDMRre; arc=none smtp.client-ip=111.202.115.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="MDNDMRre"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy
	<vdumpa@nvidia.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, Nate Watterson
	<nwatterson@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix VCMDQ indexing in tegra241_vintf0_handle_error
Date: Thu, 18 Jun 2026 15:59:45 +0800
Message-ID: <20260618075945.2217-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781769595;
	bh=jTDLB1azfarwF5n/5KTJzb1SYDTKLL2v2/t9vmMWvFU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=MDNDMRreDvxOTeIPpXBFfo8K9BpR69P+Sum2hHLZFAiFWIJ4cDubAu4l9YQczlECA
	 365yLLDM+91Wusj528f6z0CGu9KdVNpi2Lbb1sijjh9lXwkuNBoqUKxCcJ4zlUllpP
	 CfYRIU9Lb+tk0BKe2V4/Ms+PCOoV3tsYIY+kPgxfZKYFZe7L3b+DDEq3sx1eCt3OGj
	 bsdJ5/AxjB1Hjn7bP1I5LEMYhXhnm18kmj6XO6595R5xtlK/wgEP8UtINYbRBtBF6d
	 aJDv+4Jux7oUAQbtaEObmNkX8zqc+TznnQIgONeo75VQshaoab3rRzsNVNGJsnXTSE
	 hQ2baI8RBpkCQ==

From: Li RongQing <lirongqing@baidu.com>

In tegra241_vintf0_handle_error(), the driver loops through the
LVCMDQ_ERR_MAP_64(i) registers to detect and handle error flags for
each virtual command queue (VCMDQ).

However, the code erroneously uses the register-local bit offset
returned by __ffs64(map) directly as the global logical queue index
(lidx) into the vintf->lvcmdqs[] array. When 'i' is greater than 0
(i.e., handling queues 64 and above), this logic incorrectly targets
the queues in the first block (0-63) instead of the intended queues
(i * 64 + bit). This leads to handling errors on the wrong VCMDQ
structures and clearing the wrong hardware error status.

Fix this by properly decoupling the register-local bit offset from the
global array index. Use the local bit offset to clear the local map
snapshot, and use 'i * 64 + bit' to correctly index the global
vintf->lvcmdqs[] array.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 67be62a..33ec466 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -317,13 +317,14 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 		u64 map = readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
 
 		while (map) {
-			unsigned long lidx = __ffs64(map);
+			unsigned long bit = __ffs64(map);
+			unsigned long lidx = i * 64 + bit;
 			struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 			u32 gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
 
 			__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu, &vcmdq->cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
-			map &= ~BIT_ULL(lidx);
+			map &= ~BIT_ULL(bit);
 		}
 	}
 }
-- 
2.9.4

