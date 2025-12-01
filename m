Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0A335571
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610221; cv=none; b=N8Q9rFX1zZ7R+bQrt4Al0NokzLDUvV+B1gwAzQeeyu4IoP2k31L52m/7vYQAFMmToA1ZiPdtiC9IbxskWoNCJ7epHlT4PhMhKTFEWs4d0OEEQnGmJbTFPBUBoT6zi/5wkpNE+5blr8LvEvU82SgIXI3WgBY48nHGO6Sk0H4giYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610221; c=relaxed/simple;
	bh=3JJCDxdlqwr5kvJp+p2EObs2W/VAt1Sh4v9N178dMhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO/PcizE2rtNerkb40m49hzjcUlVvodZhOYX+m2f0/I6JVLm5le5BrQX+vfXuy6hbdiCA7NsMCIuDD0SUPd4UeCYUD/34k+lAAOOlp2pGHj5qkzIsMx3X8nmTyWmjAwGliukFJqymnQekWhYHEp0V0JSNPRKNpf+/abJdX2E5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=REUAiGH/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="REUAiGH/"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F00D2065961;
	Mon,  1 Dec 2025 09:30:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F00D2065961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610217;
	bh=RWBe9UylVU+tcKbDr2C5pnuePxMqB34k4+OTgKl9wQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REUAiGH/5rj727FKcmHRSHw59fGQeGkT8/eWGrNKYklCDF+9gftTPUL/uDJUIp2He
	 MBsKKcugZXpR3iwcG6soIgzVbhoVzRxuq+gOSYvalIFauuLaukJv0QI4W6iuAf5+BD
	 x+GzLia9I5dkPy3RjJvP8RQemP1fW9guBMIh2oUQ=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 3/8] iommufd: Add a mock page table format for noiommu mode
Date: Mon,  1 Dec 2025 09:30:07 -0800
Message-Id: <20251201173012.18371-4-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dummy IOMMU driver for No-IOMMU mode needs a page table to store IOVA
to physical address mappings. Instead of inventing a new format, reuse the
generic IOMMU page table (iommupt) provided mock format where its
implementation modeled after AMD IOMMU v1 format, but generalized for
software-only use.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/generic_pt/fmt/Makefile        |  1 +
 drivers/iommu/generic_pt/fmt/iommu_noiommu.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h             |  5 +++++
 3 files changed, 16 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_noiommu.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 5a3379107999..59ea791c6383 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -2,6 +2,7 @@
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
+iommu_pt_fmt-$(CONFIG_NOIOMMU_MODE_IOMMU) += noiommu
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_X86_64) += x86_64
 
diff --git a/drivers/iommu/generic_pt/fmt/iommu_noiommu.c b/drivers/iommu/generic_pt/fmt/iommu_noiommu.c
new file mode 100644
index 000000000000..4991dff60b59
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_noiommu.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ * Copyright (c) 2025, Microsoft Corporation.
+ */
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT noiommu
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index fde7ccf007c5..d7f70eaeb37f 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -255,6 +255,11 @@ IOMMU_FORMAT(amdv1, amdpt);
 struct pt_iommu_amdv1_mock_hw_info;
 IOMMU_PROTOTYPES(amdv1_mock);
 
+#define pt_iommu_amdv1_noiommu pt_iommu_amdv1
+#define pt_iommu_amdv1_noiommu_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_noiommu_hw_info;
+IOMMU_PROTOTYPES(amdv1_noiommu);
+
 struct pt_iommu_x86_64_cfg {
 	struct pt_iommu_cfg common;
 };
-- 
2.34.1

