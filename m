Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71D39CCFD;
	Thu, 10 Sep 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011281; cv=fail; b=K6eCvBkQaA7LqU/ZywbtqWRQylAAUR3PiEPX08UvAQLPPE5Qe+PTqP5gjxZ5usn0f90QyA2q2jsA9KFid+zt5avMW3oDgWmRRtlgnn6cozujikinAHnbHwQR2zTD5CARybB2zduo+lsJLPvsn79KGtJrpX6kFJoyrOJPGVg0bTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011281; c=relaxed/simple;
	bh=KHDVozucmfDd3Sh/0+v2fj6tdwSkpE5oK+qTr/12QIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx3nyf0qLxCZm+N2tWENTxEuz9m0lRX0sYXjPU6ElffBY4jw5qZScuYK0r90lfdbNvATDc215VvWCgF9wdxjusSCBOJ59tTSvDB5Su0uLlot95D2DVBRZJUb61ZjZ+koS+vVjgLxOVOFcxP5+pWNJhbIFNOBL6zQcYS9SicwFdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E4urgNsm; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E4urgNsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqX6OsSzzfVpCsRQ5zXpKUd0YvFU2HjyFdgugNtgTGSgsI290407z/NAsMhD6a+6NrmreJ3pHyVpjTbYNu8i4KFmeedOXMemUmOKHoMmbmyrdr9RydGhObiBjPGAfGmbdKEI0NS6XY7XZ5iicOi9B5BwIjqqSZHiC6oPMNvOBFBrK++sT9DUsf4QipJtjb9AsYceRBLNZD5WUXyMhJo8P4C+ln9btEUHFt5saQd32ptSFmpdWClLl+EIsQOd0E3ayoGL3BziHznK1IMAPnN8j2kQqU16+G1Bm14zsI3Pr3WVW58U8gNmzhwxnJT8ySJrf8aEqJZojOBWRnKoO33YRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DyR2tD/EpvmkH5l4JyfBoAKAadlLV7F1+oGCIOV//Y=;
 b=s2Sc6143GJZsbGQZrSsWHs2VEfYqt2t0zu2HHGPo/dKxqhi7PE0pGyiFJcH42LqHd50+D1wUkxVV05hKEn3zlnOLHzeKxkU+mnOh+WvF2fpovEg+PbAzG1M98tWslTg9Ee1SUXa074vrTPlgkV1XHCuJEE8MIIov2uQUdxT1dBq+1yhHJfn7T76JAzXi26EhEiup07olJK5SMDgYlSrRNjD4TOxMk9nwS3hQ/2It6vLobBEvOU2bzhA2VaGzjX0C3g3Lld8BKr4YxhTjMFtHeruzjTpAVM4mbOWd/Ywu7zHGStYq+koFmelr+OPxWAsfIPodO0cxhLEeIqCUjsRXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DyR2tD/EpvmkH5l4JyfBoAKAadlLV7F1+oGCIOV//Y=;
 b=E4urgNsms4xXxg5PQ6eG9tCdFKgBFa0QgI1DIuvQ+g1C7iSJTJEqT/mconbYajo1EmMS8+6f8HmOh2OZRMISo12FQdBJneboyqPpRn8bko52J+rvWmDIgg1KRa2aP+zLf+shOmheGAJ8MXi0onYdPfgCGFqOh2Vhes81ZoRzosJVWb9lhpRabeWzWHTqr2FeCgJz7xNO3819urJH7PS3obh4VjHR0zaHkwzNztGJJiLxRylvxrYhsIDTUbYNGqaOQDcUvRDUw+9LzA+satRV4P+4yMcKgVf6YAD5T8KZHbB8OgbeuAI7ou76bPd4vHoBvRGW0MmiUWyey+kMKw7lbg==
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 03:34:26 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::83) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 03:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:34:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [PATCH v1 6/8] iommu: Introduce TDISP T=0 state for confidential IOMMUs
Date: Wed, 9 Sep 2026 20:32:49 -0700
Message-ID: <0421799346a09bf7f32727330ca1044de05f46ba.1789010941.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789010941.git.nicolinc@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e35d5e-fd6e-4a79-f853-08df0eec6985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|6133799003|22082099003|20052099010|18002099003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	WeW1IMv1PS9S8kVpZBeD3PbmM1NeMIIHJgfQ0B+6GvwmnGSDlyUbtA/YiEC5wdr+fQH/cjO3Mf6BQLPBeJw/34xI0wwLi8rtwS+Dg3HewAb/dtLqqSouk7ebv4dzyo5FIl0gQfhZrlS1aaURPmbHBBgaXDBV2j16uUaGVa0LpodYxl9LC+NZFEyfZV9WdWR/qTCyjrrcLf77ceG1KONmQkAPNqrwtFO3iYeIbt8Sqxyf4hHs5vVyf6/OqWhOmIGYb57UjPRtcFSypo3fSTTeuFdBgyWG//7FnbMK3iJHHDsQJyx5OTXvrj8iPF9i73P53YnLZsiONmQ8xFsBRemnXK+Ke8k8/oAflisxEAgzrDc9Xy1Dm3guR5FSbclkxznkZnc0P6e9uNLGHB8CFMsFLdCL18hjNgMdFvdnWEt2d7/u3v78fy0c/6TzZKavR3GQIyKcY3SxNeDsRU0r4AwaikqdNc14vzMKfZWvwV2gSS/bXZYvsIYawSl+ht26ZDUvkQ2CatceN8MxDmRnXFiYpOFBSVQWTXymLMy8+ySrm9q3odKYBXnp/WUi6VXt3TM/FnOL0IETOMAFdEQluQ0+Z8qn/2kNZGrn+Fiz/Z7d7vL7X+vj9taHkRcAz6O3ddJW51meYD9OosTSB6Pgml7Lvkm89K12lpe0NI15gEP8z8lPpp/xo2Ukw6uyl/tsRMSj/BTaYlb+uPhduM7MKfhrKg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(22082099003)(20052099010)(18002099003)(5023799004)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tjm7W6rZ7JoUZhUHKLs05wTqgqeN0uqSvMFuplbfbu/Ue2rhpvb4NPXuOSE9nSrbCGW8dHQYn83Odg9ABJTRKPly0zQFHJjFWIeVN/3a4nbmS1HeqM0LfpPKCo4wUOR4k3hqdXP7qWpqH9R4ddiNIo/9ce0o9AO8W6mHzxVIR7FM6bgkN1YJMLTh3V4qLZkTTRL5Tub/C/K7soWd3S+J0hqEOmPUiDy1ixg0RgbYGlPM2N9mwNMPy5wSGjFoZFrQgVZk0CNEDmrZ7Ms8gX2t7kW2m91j5t/zcdvIdgKTMnRnPFNw95x2iBmMwdD680Lpv28OEF52oVLYfoXqwthEscO9Kcz6CVTY9R/pgXf0V4sN23GQ5yNvg+WK9BXoy5g1rHTnu8QyRszmWQCjUfF0Ia9PzMQhnx37zekwnWpe2ARgPB6x6MZv41gR2TlFfjG1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:25.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e35d5e-fd6e-4a79-f853-08df0eec6985
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

TDISP devices have two independent DMA streams, T=1 and T=0. In several
platforms these streams terminate into different IOMMU environments with
different translation tables. For such platforms the IOMMU driver in Linux
handles exactly one of the streams. Typically we expect the T=1 stream to
be linked to the vIOMMU and the T=0 stream to simply be left as a no-iommu
identity configuration.

As the HW has these two different DMA translation environments, the iommu
subsystem must participate in switching between them. When the device uses
T=0, its T=1 vIOMMU path should be left in BLOCKING to disable it, and a
simplified "T=0 IDENTITY" mode is setup within the DMA API.

    [device: T=0] ===> [hypervisor] ===> [memory]
          |
          +-- (guest association) --> [confidential IOMMU: blocking DMA]

Setting the vIOMMU to BLOCKING also gives up its control of ATS, which is
now managed by the core code as part of simplified T=0 mode.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/Makefile     |  3 ++
 drivers/iommu/iommu-priv.h | 19 +++++++++++++
 include/linux/iommu.h      |  4 +++
 drivers/iommu/iommu-cc.c   | 57 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      | 17 ++++++++++--
 5 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-cc.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2f05725eaab18..dc91d4cf0ce11 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -6,6 +6,9 @@ obj-$(CONFIG_RISCV_IOMMU) += riscv/
 obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
 obj-$(CONFIG_HYPERV) += hyperv/
 obj-$(CONFIG_IOMMU_API) += iommu.o
+ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+obj-$(CONFIG_IOMMU_API) += iommu-cc.o
+endif
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc9..06e233ac4662f 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -8,6 +8,25 @@
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/msi.h>
 
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+void iommu_tdisp_enter_t0(struct device *dev);
+void iommu_tdisp_exit_t0(struct device *dev);
+#else
+static inline void iommu_tdisp_enter_t0(struct device *dev)
+{
+}
+
+static inline void iommu_tdisp_exit_t0(struct device *dev)
+{
+}
+#endif
+
+static inline bool iommu_using_t0_stream(struct device *dev)
+{
+	return dev->iommu->iommu_dev->confidential &&
+	       !dev->iommu->tdisp_t1;
+}
+
 static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 {
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd68532e7f3be..e3ed0dc538e0d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -871,6 +871,9 @@ struct iommu_fault_param {
  * @max_pasids:  number of PASIDs this device can consume
  * @attach_deferred: the dma domain attachment is deferred
  * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
+ * @tdisp_t1: device uses its confidential IOMMU's T=1 stream. A zero value
+ *            means T=0, where the T=1 stream remains blocked while the core
+ *            owns required DMA operations such as ATS.
  * @require_direct: device requires IOMMU_RESV_DIRECT regions
  * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
  *
@@ -886,6 +889,7 @@ struct dev_iommu {
 	u32				max_pasids;
 	u32				attach_deferred:1;
 	u32				pci_32bit_workaround:1;
+	u32				tdisp_t1:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
 };
diff --git a/drivers/iommu/iommu-cc.c b/drivers/iommu/iommu-cc.c
new file mode 100644
index 0000000000000..d107b39696a08
--- /dev/null
+++ b/drivers/iommu/iommu-cc.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TDISP devices can have separate T=0 and T=1 DMA streams that terminate in
+ * different IOMMU environments. The Linux IOMMU driver manages the T=1 stream
+ * while the T=0 stream uses the physical path.
+ *
+ *   [device: T=0] ===> [hypervisor] ===> [memory]
+ *       |
+ *       +-- (guest association) --> [confidential IOMMU: blocking DMA]
+ */
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+
+#include "iommu-priv.h"
+
+/**
+ * iommu_tdisp_enter_t0 - Prepare @dev while TDISP is T=0
+ * @dev: device entering TDISP T=0
+ *
+ * The IOMMU core invokes this helper for a device on a confidential IOMMU
+ * while TDISP is T=0. The device remains associated with its IOMMU while the
+ * core owns DMA operations required in this state. Enable ATS here when the
+ * device requires it, since the IOMMU driver does not operate ATS while in
+ * BLOCKED.
+ */
+void iommu_tdisp_enter_t0(struct device *dev)
+{
+	struct pci_dev *pdev;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	if (!pci_ats_required(pdev))
+		return;
+
+	ret = pci_enable_ats(pdev, PCI_ATS_MIN_STU);
+	if (ret)
+		dev_warn(dev, "cannot enable ATS while TDISP is T=0\n");
+}
+
+/**
+ * iommu_tdisp_exit_t0 - Undo iommu_tdisp_enter_t0()
+ * @dev: device leaving TDISP T=0
+ */
+void iommu_tdisp_exit_t0(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	if (pci_ats_required(pdev) && pdev->ats_enabled)
+		pci_disable_ats(pdev);
+}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index feff390727d13..7ac6569af6773 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -535,9 +535,17 @@ static int iommu_init_device(struct device *dev)
 	}
 	dev->iommu->iommu_dev = iommu_dev;
 
+	if (iommu_using_t0_stream(dev)) {
+		/*
+		 * After probe the iommu has to leave the T=1 stream in BLOCKING,
+		 * while the T=0 stream will go through the physical path.
+		 */
+		iommu_tdisp_enter_t0(dev);
+	}
+
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
-		goto err_release;
+		goto err_tdisp_t0;
 
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
@@ -555,7 +563,9 @@ static int iommu_init_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(iommu_dev, dev);
-err_release:
+err_tdisp_t0:
+	if (iommu_using_t0_stream(dev))
+		iommu_tdisp_exit_t0(dev);
 	if (ops->release_device)
 		ops->release_device(dev);
 err_module_put:
@@ -573,6 +583,9 @@ static void iommu_deinit_device(struct device *dev)
 
 	lockdep_assert_held(&group->mutex);
 
+	if (iommu_using_t0_stream(dev))
+		iommu_tdisp_exit_t0(dev);
+
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
 	/*
-- 
2.43.0

