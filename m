Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343863;
	b=yv3iOa5qStFsZQZqP152PppkYXk7k0hS1CqIv5SnCd/2sYOltO3CYT/9DurMZkqCBnxq
	 9MTKi40kjeN3sDzb8HXj160m9D6tiYD///pQRTJ1HsR0Q+8ePI9OV5TqbCaMHA8QWBx/W
	 q+Xa8FdQ6klzvq22jU1wu7rztUAQiTgfBhTffiYVA8NkiFWBQ1clFDwZavDpzO/OgGZjT
	 bx8pxPgWRSCTbBg9/2A3hME51GLjvKzFXXEO86G5JqIY6fnIDuC9BLGaxc5HxepDs5MY1
	 oyqdf+PZSbGH0Ek5nNtR8f1sXgPH+PMqnqyfVPCFrJH0GggfmUIfxOyuRa4WgRaGvyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343863;
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
	bh=ZjRcaCGEZwoZZG05aJ6Tc7pePKKhmq1U6eCOWb3X94I=;
	b=p/MM9HamQvefdxZScpNuXzzinL5bKh1o5+6V0mn+Ooe9t2Biy9lu1HK4rcsNHxS9TXfK
	 QfCv2KZmRbATV+27/ObsAOeqKCwoO61gIjzPSzd7UfIWOWY4gBw0vfErMOyGV/jEs+C7/
	 GCSZIPMGi6Dart4fUeyi1ft3cdymqbrnjmyzJKjSCFuFCPvBRaScyLjHqiVRb8KHjJyJR
	 V+aeGLUsKh+wFauWtGxUCvNWloL7YsqzGJwouRmx1dfVItzKOukU/2/Gi3C2SoKlLFskx
	 MP17DIBBTFX+sK+CRGnANPXj6rTuBEkd71GPVBV90TmnUJGeDjdgTbMMicgLY9JnEVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ANtDY8nv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.5
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3B60A2634;
	Tue, 10 Nov 2026 20:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB3B60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ANtDY8nv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om5hkIGcko8Bz1/MjyBqaNFwGVg+XVTulWcP4KjiXitXLbO2wNExeZkjDj/XeoGZXLHtjdQoowPnCCsVGKWPtwT2Dsf3oqDF2NNIOatD4WE5i8CTHHndGpNqH9FkRHx4TdTBXxTsVGBRcRaelHNhvFesY5eUEb7OdEAg8VJZjOWyfoO/OrbyqSSMS7kJCicv0i/Fhs1iju5a5hyw5Prx4Km9OV1fC8WKIaSy8/5IZscRBKyKbxwrY5C3Qesgs55h+r9N9pKhOM0UyeruX0TTyUXcUbkwjTHI1HwLnxqrBmXkwIVVOQtxPRLYq9LK5+l42S6SFot5gFtIM3fgEIWpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjRcaCGEZwoZZG05aJ6Tc7pePKKhmq1U6eCOWb3X94I=;
 b=eUtR85tK51QtRS8mvR9ol1NWj9l0XGbuVOseX2/sJLWh0zC0wWpxGpwNxfXNQ7KO6/u9AzF6xM0p9n3JpDqU2CrQvw0xDv3yLyKyM8FdCQeAJPXHL/2sJgcKuYseWOIDGOvBcqnr3EGOmHpv7L6pyNdq167yc0XQDt30aA/Hy+qJCBQaqbfQKHXkFQghu5bPP0ZWCegaPzeQzSOqtEcli5hPYnV5z8flWEtKB7u3XAU434i6zMVgoNOfC4Gyy9aeYtu3xgZPNdimZG6SL8hJNmcpGnOz+8N5k3xB2afSmeMTae57nlg8wd+o+Qg6HZwCxiUIGyUt96Vxpnbxo84KqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjRcaCGEZwoZZG05aJ6Tc7pePKKhmq1U6eCOWb3X94I=;
 b=ANtDY8nvVHqzWG++1GrlQwyxdpAvdpxzRop3LfyIMaRGBSsQOgIc6w1rYI1MtxBaU74mX3vDr+2PzvZ7kHixhzAD7KlwG1pMPWrsajZynBHqiHWab5khS54zErOyzCP8P99FsnMPguTIxS0OB6X/yqNwxj3Ao6xC6yULaQW5w/Pz63lJLWlbbX6Uth2CFzhfzYBxZk+C0Eq14T1VoiUoS4W1lYJ6g+E0ZCFNh6kNQBY0WJ4fKwMT2HT562NdgOFf37LaMRbTpiQDnx6tmm9/M8aBoQDzuEIppzm+nWmDb2OGlqBvLQKhJKsKYshU0jVdn2Sq5/i7Jc1AZRyiieg/Eg==
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 20:50:53 +0000
Received: from SJ1PEPF000037B9.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::ae) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037B9.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 20:50:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:33 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:32 -0800
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
Subject: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential IOMMUs
Date: Tue, 10 Nov 2026 12:50:10 -0800
Message-ID: <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B9:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: b89b7d45-e95f-4596-ee10-08df3f6c4fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|82310400026|1800799024|36860700016|261102123227099003|56012099006|261021135927099003|5023799004|11063799006|261021121427099003|261021123027099003|261022105027099003|261022113327099003|261026140227099003|261009223027099003|261022075727099003|261026121527099003|261028144727099003|22082099003|20052099010|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7bUrbiiI8bC0w5V0WY0pVloogyQTHacq9/GeCixXXTrG3BmxjLHB23Q6Q3IqgDkMsJjK/cnZfXNE7PMA0cz+wbd7C15ZdqmOIH9/kxkUqgpAXG6PPAYENcF+qalSg8P7jONnvOMvYKKrajJdkmV/waUgd8b0kMB+cdFmT4gqxG7LAxGsWSvIUflSBOecU8HSafRCIfPeMkSFiP5GrnZQOv5RW9xKMSaC2C8aRyMwu2LteE0eQKQWsrj+WQd4WPBqf+CJKPBnNow+IKojK8O3fD9p+gp7QxU/5PdkVP1XGVVpGe2sh3mPv/BqL/iQ9JwFd11Vu8frcEJoYDxGmpKZZhqpY3AFBM6H09A6qwG0h2+gxLq6GjZ+Q1mxUPGobdjPp01u6gFdZAhBgRyFLjDRm2FZ3yEIoZ3MwJRVaC3QfjPPDS6bDnWXAnsyy29J/DpPDvjK+n08rZ8VN7AyJ0Iiv9ETduQIRq9W0woH/M9T8iNhejy7SVwlwVcAPu8KC8YYgQkLeajT2zRjemrABnDN6RxvZWkjj1KZiX234OabWYwxGlFe3sY2M0Ig1JqJEhvfWvhQdxpxHOUzRv+9bA6Wz4cqIMke0rcBu7xEtONSUOnVPVy/aGGt3A36RE192FfZ0j/qYQKtM8K7x8qK3lIEqNQOTWr/Gzb4U/KL7z174fKF3UoAsC8BbBMacOOtPfj1BrjavGlmFLViJTcCfi8o9g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261102123227099003)(56012099006)(261021135927099003)(5023799004)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261022113327099003)(261026140227099003)(261009223027099003)(261022075727099003)(261026121527099003)(261028144727099003)(22082099003)(20052099010)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WUnLkmuT6Xlw9IkZmjGKKr8ArUaLS6OZBjGPVwlIGydHzsYdCRlwVkhRkX5I2BUV2vwP92UaLoXgnhS2JRjpD8QZi6jxQW4RomJpjJrJrwt7+tiKu8y0PYB4/HniHaQx8eefYBH/sq+FH1YuZb/V6PKqD48rzxvIvUmYybUjIMjQl64qGiIOvDEtS98S9QMi26Pm2OHYDUtC0HFUFm0riOg/yRN/YcIyx/f5B9q4eqVt5+RMSJFW6n82wgqvH/Isq3Wlk7qmUYzKc/dzduSU3fq72b1ytdK/Nh2lcYy3rx5QSwoLiyo2nG+N9G0hNh8vwncZCAAe2FsIn0bZjh+B10c/rNqe6k5hbUR1lni7QYNjQqmAB10fqF88ExTMgQxDd86XBM/Ht6EUvxvs+dXJLo4Unm8DzZj7lVdeAjwp5F9L3AGgAdEgEVuAW0hhmZbe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:53.5703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89b7d45-e95f-4596-ee10-08df3f6c4fb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4

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

A PCI reset does not move a T=0 device out of the blocking domain. So the
IOMMU driver does not disable ATS before the reset and does not enable it
after. Instead, call the T=0 helpers from pci_dev_reset_iommu_prepare() and
pci_dev_reset_iommu_done().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/Makefile     |  3 ++
 drivers/iommu/iommu-priv.h | 19 ++++++++++++
 include/linux/iommu.h      |  4 +++
 drivers/iommu/iommu-cc.c   | 63 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      | 30 ++++++++++++++++--
 5 files changed, 117 insertions(+), 2 deletions(-)
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
index 0000000000000..096d0922141e7
--- /dev/null
+++ b/drivers/iommu/iommu-cc.c
@@ -0,0 +1,63 @@
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
+	/*
+	 * This runs only inside a confidential guest, where each assigned PCI
+	 * function shows up as a standalone device. The guest has no knowledge
+	 * of the granule that translates the T=0 DMA. The minimum STU is safe
+	 * for any granule.
+	 */
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
index ba98a0bb800a5..a7464e155e55a 100644
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
@@ -4087,6 +4100,15 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 		}
 	}
 
+	/*
+	 * A T=0 device stays in the blocking domain while the core keeps ATS on
+	 * for it. So the attach above does not disable ATS. Disable it here, as
+	 * the note above recommends. pci_dev_reset_iommu_done() will enable it
+	 * again.
+	 */
+	if (iommu_using_t0_stream(&pdev->dev))
+		iommu_tdisp_exit_t0(&pdev->dev);
+
 	/*
 	 * Update gdev->blocked upon the domain change, as it is used to return
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
@@ -4213,6 +4235,10 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 					      group->blocking_domain));
 	}
 
+	/* Enable ATS again for a T=0 device after the reset */
+	if (iommu_using_t0_stream(&pdev->dev))
+		iommu_tdisp_enter_t0(&pdev->dev);
+
 	/*
 	 * Update gdev->blocked upon the domain change, as it is used to return
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
-- 
2.43.0

