Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677826;
	b=EM5EOdBOPXhYZ6mDB0vcgdLCcbgxUmeoXAB4keWxx/biXkx4HLSWjSz1itaV1kA+/9sQ
	 wvuyP+Vbkf3L/EmGkHuYq4fKRueiVTmFDYRVPeJNEjHlWOVwexTXl4g7fgsCN5leMkXa5
	 s1EyxGZAbtd7RpILs/RvrO8BjgSZU0zChRCAJWvEiVavf9CUh3eouCGbmPhoh4isAjrNx
	 aWLJMWlvQESI2GwbrkLyFEMiRgyEcWQP2gPto6OLSQyZtbqKaRXSZgeJ2tD5ire8ho0q+
	 HbaKj99/REzZSXVNQpwlpCA8DvLgvG8Z/VihHN0LA0eILvfWCSW32N1kQ+hgyFpC2tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677826;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yl7zPe1ruwFPAOznqJ6Jwcmw1Zk82FiThga5KgEyVe0=;
	b=A5mk5N6CmXdo9QHrKkf9WEoayZN4SxhX13rvktdoeQMGQjl5k6G/G70x6HU31pUVdhue
	 NA3QCi7Iohy/rxH0b8SZl86EAVZAwStGS5GsuAvKCcRwe5h/d+d/XiVN7+8IkuH6Dp5t5
	 nnytJT+qjv6WhzFDfaEwLzb1B7DJHTUtOTBfchONFntdOjphh5LgKYbcBvL/rXWywVu8i
	 35uyFxubsylRIZ6852Lzm6xWBUtd0WQX/TMEvKJe385h3WMa9q0mKY+LeJi/pw/Vv7VB9
	 w2e7cePmX98YlEp8G5q4NN4jVCqtCTa6F0S8vWwHrdavRW+KsPuOymWlJAC9Ub3JkaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aO0CRRhd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.71
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278D606A33D;
	Tue,  3 Nov 2026 03:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C278D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aO0CRRhd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKtWqYnPMzKzKjxmgfyQjL9FG414gpeGGWkrPPb3p9qyHZGTOuVnmAbI2A9rfEhDX+xM4d3HfFmFxRc7B7P26aCQGGFG77dWv6m7IWgIFvsrzjHQS+yo/1dUnn7KQ5y6rPoKbTKfRrDG7ZkP9QvEczVpkw/a1Lwf/h5sEkG1+cTgJXa35+yzJdzHOQlfSBeIzswQ7YBcgfzCvjQsanwf81Xg7RFBUXfzfVUmrfT1c6R6zItA1DFmNGk52+0a/885orwts1oJaFZpm+j0//NXA63hN4nxLSe7CKAKMx6mi+UlFuNBkAMXY8FW3vD+Po3xhwRmdXnOUS8l+m8Sm59CqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl7zPe1ruwFPAOznqJ6Jwcmw1Zk82FiThga5KgEyVe0=;
 b=ieygp49ytVPkAAJL3cdvzcHkco6kks9aFoue5GqHZmHYFuk7Hfy1jYHrc4OFBhz2FXVhPKvm+gjJoDUrgoeBTxtBC0AiLYrIjACHxhZeSdXVH1u5/XkEGkuUKPaktSDNk/b3GCLXjyVQo0LIH3wuy71rQPEEuPhnlQt3Ksfnn/O8rC5J1zNNPr/uwe2vdAftRM+mSt2UeEZPszgG7A1usclQ2TzGt3Liq8IXlzITAgG52qAuPVzjqQ+VdvdhuAhPumN9CqyJNrF1dO4U+JkAd4FvxwkH35WDUXa7fp8qdTipIwM+NVAFkcHKWgw7qFhgCIZ3i2DcMhUT+TOZyNXt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl7zPe1ruwFPAOznqJ6Jwcmw1Zk82FiThga5KgEyVe0=;
 b=aO0CRRhdGtmbPbdRx6Hll75i/13ZMRPM721cDNS45Brntms2vmM6aZppTh6wSZbqGDxF+fX8nPRx6f+mpRGABvhNSJfTT0lMft7L88OksPJDumyPVWHEGd7+XBZjdlWzLqzUWbnFLffslQA1RdWoJKP/1qsews4i0GWDlt8Y2/JtCNaRrcrnsZzY1HiZe0d+GVaYr4UgXRgbyu2Qdm8Gkw9fHKoin4+DnHmG3HGpX/msgJADRZm/OcZo/xhWkRfvr/AO6opS5hPSq2/uCQGp+G0Xv4SCIZ2NkE+VSfH4gwDm0yl5Swx5oANyjWSMOnFz+n9KJbIu4XU6GBQeHAX8Yw==
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 03:50:16 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::14) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 03:50:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 03:50:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:50:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	"Mostafa Saleh" <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 5/7] iommu: Introduce TDISP T=0 state for confidential IOMMUs
Date: Mon, 2 Nov 2026 19:49:48 -0800
Message-ID: <bf2811192de65fd804065189bfee09eb3e08111c.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793676742.git.nicolinc@nvidia.com>
References: <cover.1793676742.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e67078-08c9-471f-822e-08df395d929d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|10067099003|20052099010|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0GFkmH7lvqNBCsXOjrakSr6puFsWwqQycJb8dxq88oLLZk5Ug3IJSm8LjNaHhqqrpDKUeTU4ICpwI+ET6AyAZi/Ld1nu027tqvWJNq2FN+kfuGzuMKcOwX3kZbjEwChIYfswgOSCERovNgxfHisku86VfMHrJeqCO+Q73jH1n4l0nI/aUIVXugoZdzBD2Sc90h7FCp5KT7nCHrjiM75QBNvW60gnQUs8M9PAWDL2ZL/zBQD8dLdO7TtrN7V4mxoS0DZQV6NW1eB3Q0uRkgiE8xYBbNV9thfIPkDvAJ9pvdUFb8CXB8iwKDeFDrzEicIXw0eGB5o4E6fq/q8k+QpZkFcWAhOzWBo7Um9MsZtHmYENVVLoIjFXAJr/wWduk/k1HVt/XYtQPD9vZf2BBpQLovVXsIk+2r8IQiws8lYf1ie0/aucGg3kRmzMRtdrHB9HXJmxsWXIK41UVJBqjoHwSBtHZlx3msgGGFtFIOdlQK59kQPbhz+OPgLUm7GF7Ao+j3FYSyWUV2U4z9oxEsjjJEi0XQAnIJpCZBAZanxeqBtrjZkOp85EBcdsgpYAZc9Ssp0C0zEb1Dhdw+79Gi1Go0HRM4dqjH1zLHJkC0SKIM5u1qiLnbb40glEuRV+mXfdkP1FO6IzSAD5sv46nXA/IaFFeRQFlz1hIEH4YvZ03HQ9Au3TXxaLLMEOD7440Vm/fsZaDuHXysLBN+VbzAysSA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(20052099010)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FCA3bG2PWtRK5MHMcTLEVOlXduxp1f5oSbZ3uYLEbke9ePDwTRLmmTGaHYRaYjmpOFHYkPz+NG9IJNQF0ij3JK91W/3jt3xjmz9nxveiRMKsovVF7ifs8Tcq4h1eyXrSXcPT/wXJBHM+nsxpymnM8HWwqEcN3vUrkcs0rAFU7GvB8jI5UTZSxh0gx2KqiqXbp85ig7Jr68aluO3ioU0ynzjJiHYmuYSdqvBLehQx6VpvBoM/uWDECGd3Dmz968XsIkKgKskujioUlxwCGWxT2d85URoyDvYyVi9N48yQIiAkQUvmlUqwdDOeQpEvF7zCnhcL++bzT5FH4FTOTF2HIjvgIOU5mq1fUPR7YOL9beMf5BmSqNG2DmjzLg0xVTEHmgC819TgQ9n1sxZ5/EroX2mmP/Lewt3TnOiIMmudvHUI8U5d3KkOvgq8bRunlr1h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:16.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e67078-08c9-471f-822e-08df395d929d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

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
index 29a26d2a3af12..0fc48b5d3c406 100644
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
index 1f9f886b2c107..624466384b6e3 100644
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
index e8fb5ee59883e..1b5817a7d0be9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -873,6 +873,9 @@ struct iommu_fault_param {
  * @max_pasids:  number of PASIDs this device can consume
  * @attach_deferred: the dma domain attachment is deferred
  * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
+ * @tdisp_t1: device uses its confidential IOMMU's T=1 stream. A zero value
+ *            means T=0, where the T=1 stream remains blocked while the core
+ *            owns required DMA operations such as ATS.
  * @require_direct: device requires IOMMU_RESV_DIRECT regions
  * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
  *
@@ -888,6 +891,7 @@ struct dev_iommu {
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
index ba98a0bb800a5..38d0158045f57 100644
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

