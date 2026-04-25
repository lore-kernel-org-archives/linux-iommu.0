Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218C1FA859
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079769; cv=fail; b=USbuVsWDaiZqc2hLlG3IFpHwYFwMe4N5z4Qoj/t70DcKIsNP4G8kxMco3U1v4ntgI39AHEnLp/jhFlmITbAMUdp+L/r7b4I8BUGQ/WyOoC8gF5yXh/eiQQv8evkUfBovtaWggWUmjIBHquQ6z06bjaVrJak2oyumDAk7+awZaP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079769; c=relaxed/simple;
	bh=Q/Upq/NBUFA7CyGXlGDdxEdAuUmuDpqiY0vOZNfYDiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwaMP9Qncp7yyti+YaKgrrY53yOJBkgg47QRM8QuO/OKlTLIUVUvFgQU2Kk4imgLA4oP9odwd5ahey4SMsiHYCNq/egWAtBVAC/ZW2PKokV+6j2DvLpdNiLXr1/ev/jPq1HUgAbSpkr43/mQGmSB0nLaKMwiCvr6JLUMXSPUb0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JeY7qeGd; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeY7qeGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFhUsQyRnyjdRrTQJ4Kkxg46y6pW3djQyMmsFHp8IQYsdcAdofcKg5VgWxPwZG4vJZRykEvi+A903ovowIzKCXoxsEdPF1NWAFkuJ6t2VED4NWJvZdk5rk/m9qVJM40IEchCln6GAvulFaeveBcMuf9aFbML1aNFSY0Mod8Er0r9jH15XXL64qODprwjvLVCLWeuW8EZ1kIWlUSPi9OgaCORRN2RzSUYWnkBOFtEIGTJCTWLMAhGf7jk0IcWnUzxmfdThRDvwRST4zHx0G8Tj9y1E9QTpaxl9AdoOlttyP+qxUebCyPEtc7kQV7xlXg/juxVmq+zxIOyvw3RpUuvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbmpEawizC9VwEeS1vY+d6XCSx6x6dpdNknXoI633d0=;
 b=cTxLt/DnXaz8QyO3fKz1vE6ute8kXIey7Xt7GUC/FQM/BV9AwGmqGTYmDjr+GAuIelwfK2vcQwY6C7Cx+TUhYfBQ/WgykabWu0Nwco6khMbRIZGq7JrbQE1i8jSYXx1OKNUI1Gbxkt81Vg54PVVAuX8pyVKgxZRJwjUD3FZ2zDXl3ZP/qvD7hxRyHGE14E+Vn3XMu7COe7FhuHCAXTRLDD8tg6ra8hNpO+cDzHUee39h5CZNb9Nd4bngS2VbAaYXwAZ6VUMfumvObsQbtJRyyX5X0gWskZpHL0YwLg4hEcE34sv5FAMnlG1TYVL/PcSNA2OVJWRXFypdMZ7HdnvZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbmpEawizC9VwEeS1vY+d6XCSx6x6dpdNknXoI633d0=;
 b=JeY7qeGdy88SQHU+isn/0hWKb1XzfmqxWr8wNKh6Z09veIcnDSmfbS1JKwkMR/9PFwSlETktzTovGV+lWg8+e1uyKxtkf109uphlovdltxkMoKq0thkouJ2RyltdpNI7+3C3DDqBFg4Jta/okUG3mSaq/2JW0so+B2M4lPC6/hwJOAydTugDwmUGnV7vJlNXAo01mBQBsT1QOEcFJvvWZSXoV5R7pM5Tl4YAYyP4s0xaSZEYuaJTTVYJfLyXEZ+msDjDHgJ732sl/9R71XAOf/PAY344ihSQrT8T5K5BldYx7waRSpUFZ53y9ChJY93GwUTYhif+qqb7pg3G/MP8Nw==
Received: from CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::15)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Sat, 25 Apr
 2026 01:16:00 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::94) by CH5P222CA0001.outlook.office365.com
 (2603:10b6:610:1ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 8/8] iommu: Warn on premature unblock during DMA aliased sibling reset
Date: Fri, 24 Apr 2026 18:15:27 -0700
Message-ID: <ea7199ab155d4d0d8c9afbaa23023690d7d8d4a7.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdee178-d542-4500-9c65-08dea268360e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TteiAkaxZ3/lYt2Onb2mIsb6UcvBq8fLesuhXi+crZv+gCyat+Er4E5dLLbbWvNEAoU21PTfsBb20V5aqsgfJOYgw/b+2SZMqDFWlIcPwtj5eTyLLOb0zZN9J8D1MsXJTK2OsBfonCF16tRwVUmqFjc0F44UXId66nhCra6TdAAPRm8lo4q9CIV5EidXiqo+mfrHSQsVOqT3VFAf0rOG1aKQj/zHr5dHYLvji4tLCu77NwlUgDPAwK0lzE4BhNm9+evR6ytq92bLuvAlWYs8mIkomTihEgY6pgQE4EFLhGkYmGn7pBkhrFzBVs7kG7nyoUsKby98xQQbTZpkF3BY4tNgSpp3Ki3Whoet1E9X8qTkqaNwv5r/rC/nMyNAObVWEiEQrqgK8UV+v6Dh1FzQnOsRSScKNEec4XMOIygiEPjs/AXxfYhqL7UZb+ifLuu0ditkYbb8nLNPtAnrDUv5OXh4m+B9dLnV44lGlp9shBBPTfqWAAiCWpr/XGD8NIPbaTj7k+ZvRdBMO6uMfMII9iOPmy1yOFNzHbaxs71hTfHSKS17s6V5w6tLRPhdQKKv/6jf8a0BBU3NhfjzfgN1EVjx4ueeHMmTYdOFj9Xfw9tGwFUBNuxBdNXRMMA2XTKTX6T0m6CNf2PrBX2zmjxLWTLt9c0ApmAjOcUY7zA2hi67T7mYqNkMz+Rk6o9l2mBlK7WxfkMn4RjLau8cmnCJEuPmKqkImojNyElIpVNJgDiyG4kZPvSG0GrNjsgIasC8AyNTIkcLWsNKwIzHpUgrDw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FsKPPtRbJjUYFYyjajwNUbAqugDXWSq+jt9OECkDfXaeCDaUjfHVH0Dz7SUg7LM1byQMyHGVqYE6W/+fYkjj/4SIoIe7cCnBqZlbCKxammQA2iT4+WpCdTA9oiqnGRxsnI1OTk5N69d6Op7lVZGIfdvlFqXTxF7mtIvJbKi8aesKElic9+QElL5TJCY+JPwhDbujawR3sZJ1FMOhbLV0yDCsXsqt6VBVelcWW+LGUvCEUZlVgfL5RhOa9m3P2qEW/aYYVe337lrwLYrnD6lBI4lHKJyGX3776m3k8yOLNmM0YZPqPy6v3LqRFTXDuPlBU19qxFwzJ4/nUHSJhg9q4zXWNzZHncuphPMGanzdFmXnkqMbF3Koy47LGFCq1nH7DtUrzfv0rYJckVHUX11fuhVKQMRH7N1nVtoOYeZRED9h5m8pNMisVGhZca2U1fpw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:59.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdee178-d542-4500-9c65-08dea268360e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

When two aliased siblings are in the same iommu_group, they might share the
same RID. The reset functions don't support this case, though it is unclear
whether there is a real case of having an ATS capable device on a PCI/PCI-X
bus.

Theoretically, however, if two aliased devices are resetting concurrently,
one might be unblocked prematurely in the middle of the reset by the other
sibling who completes the reset first.

This isn't a regression from this series but it's better to spit a warning,
so we can know if such use case is common enough for us to make subsequent
patches for its coverage.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f21d352a67f70..dd53cce12087c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4057,6 +4057,41 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 
+static int __group_device_cmp_dma_alias(struct pci_dev *dev, u16 alias,
+					void *data)
+{
+	return alias == *(u16 *)data;
+}
+
+static int group_device_cmp_dma_alias(struct pci_dev *dev, u16 alias,
+				      void *data)
+{
+	return pci_for_each_dma_alias(data, __group_device_cmp_dma_alias,
+				      &alias);
+}
+
+static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
+					      struct group_device *gdev)
+{
+	struct group_device *sibling;
+
+	lockdep_assert_held(&group->mutex);
+
+	if (!dev_is_pci(gdev->dev))
+		return false;
+
+	for_each_group_device(group, sibling) {
+		if (sibling == gdev || !sibling->blocked ||
+		    !dev_is_pci(sibling->dev))
+			continue;
+		if (pci_for_each_dma_alias(to_pci_dev(gdev->dev),
+					   group_device_cmp_dma_alias,
+					   to_pci_dev(sibling->dev)))
+			return true;
+	}
+	return false;
+}
+
 /**
  * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset is done
  * @pdev: PCI device that has finished a reset routine
@@ -4096,6 +4131,20 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
+	if (group_device_dma_alias_is_blocked(group, gdev)) {
+		/*
+		 * FIXME: DMA aliased devices share the same RID, which would be
+		 * convoluted to handle, as "gdev->blocked" is not sufficient:
+		 *  - "blocked" state is effectively shared across these devices
+		 *  - if the core skipped the blocking on the second device, the
+		 *    IOMMU driver's attachment state would diverge from the HW
+		 *    state
+		 * For now, just warn and see whether real ATS use cases hit it.
+		 */
+		pci_warn(pdev,
+			 "DMA-aliased sibling may be prematurely unblocked\n");
+	}
+
 	/*
 	 * Re-attach RID domain back to group->domain
 	 *
-- 
2.43.0

