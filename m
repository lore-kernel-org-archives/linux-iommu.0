Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507743D4F7
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550293; cv=fail; b=JeKtChzwc8vN8NMSlDpIAQ+5u7Dg2Wnqrn+AaCh9lc0BOzz3igW4bNARXyhu6DLiytB0dI4xsZOR2DrmB+vpdQhpj5d78mBF1Qh6tn03bu9qhkO9bPKOHVTPmdAxfZKRs+QTVGUOjJdhcVFWlbqWxbHVoxUx1V0Xa2pZPjQ+fYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550293; c=relaxed/simple;
	bh=BNLvb0mKKYSfnVPfhTArPD0diWgHL7C0nZ8s4lNfQow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvQsU60zQEt3wZIbaRhapGcxRswyX4/c6QhoLppk8OuS+LvVLgLUmIV5Gy/76G5tRfAkcJPm0oNeC5mDP8ZdQqHwFMH8wVywHQ8/V6IKrfVHXpNugZV0SGyGSvI0jACPi/Sq1rVGdVmkwwqkOav5Y57TPKJ+1LVmhPGJCoIM3Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pf6xHI+E; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pf6xHI+E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv2wEwt0TKnUHeD4fDCmIBCxFBHTuxHtoTN8unNk6sxsvO8hw92dtMEYO4EjJWvQx2t6VJ6gd5u448FxEe0NAOnaAXRfaanyuv5SUC06DLdG24olZ4QvggUxtLAkOjkej7STzHuhiUUoSvs1mC0rkQG4maNJgVcZO0wy/wogR3exLlx6Rd6zaF8HbNqzSvrbSxxkejgbiUkQFVV3YLslurXNtM/e9EWDNYkxm6aT+qJ4y4Yp5elYvfKUJgmY31o05I7T6n5+DNYCG4SSnwJQuewuoBvsAYpz9qCRiZz8zFpySim73QXT6TBmGjT66yImZUtBRHW+UUXMcNc5KkBEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVwpuds9aRQqsefS+/gLjIDxQezrnMBRg4Tkx7TSQPM=;
 b=Cxqf+kfLCISrrfaOcFcuv/TmTqqVqd9/RzEnTiyRivqCmc2EY0p2/s8nHM04gEZnbyxa2moc5f7y6we3H8ttsd2Cz7jz/3McwGA0zbtnJwtUXXvW2s0QAFzVIfBeZt1K472iKbEfv5SwIETVNHy8+3bhCia43TE0FJdmgneOpuLjom4XaviWBWdFF3eCuur5sZoBVQq4OfIaeWAGpw4yGQDipC08SB+MKCsTlpa5y5zFOqAIR2H7JguGbiMcr1ryn+u7PyK6g71LzAcKShd/1URZwgkXnCVUiHRpdpeJw6FhsnjYo5WAphkZzKqdjyp6rZNea7mXHg9SU8oT33MRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVwpuds9aRQqsefS+/gLjIDxQezrnMBRg4Tkx7TSQPM=;
 b=Pf6xHI+ExY3tzP52U6D3wbfSG5a2X0zDcL3gmr7Ir/1FbZ076hhDCPm8Fo3UqVMJBYgQ2UWukgCKVlzIpSIAX9fSDLmkAuMoTJNpls+a41+/kbhP6dWCj84JyH84XibGObM5lM0L8SXedSMelfL+xeL8nXtlvFNlTRY0I3iCFGRRub1xk2hm4gTlhPyBqWBheNHQY2vPhwmfBWZjrwoAjMqx/dJ5YXIt/8pG6rWkgYCcLpbBf5YGvVinTavBepXKZcama4TNvcd7GA+5XN+cflLevuuWFZPGYo20SA/grXT+nBhdhuV4JnqgvrC3g/kcknyi+YO/YapiMTO8+WBA1g==
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:04:47 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4c) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 15:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 15:04:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 07:04:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 07:04:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
	<kjaju@nvidia.com>
Subject: [PATCH 2/2] iommufd: Report ATS not supported status via IOMMU_GET_HW_INFO
Date: Tue, 3 Mar 2026 15:03:48 +0000
Message-ID: <20260303150348.233997-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303150348.233997-1-skolothumtho@nvidia.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 844b287c-d64a-4e89-46f9-08de793635ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	YA9DEsIzzDqOtSrvVX6TZ6CohmmAAOr46RM+2hOTLefjEZ6ibF4u7ZIbq4aNLBhhpfgFq5PkL2UGsaAtNgsEw6hljoYdPd/Wq/NjKhizTPuaOcoDJnpVu/KuA72NhofBfpNC4tQ+jkw02aZIGmkeUD14Hk60goSa4ErE80mo9h7IT84Zcl86s0ns3J3KhO+vk9lai1jKtPdXe4R6A2faCR6SFOHpvxuT5AijvTUGjKBrwPvLu2SUAkAphRpyjUElYOT7yi5w6dGQ8MY7ObQsw4jVxJlujmHQZoA+eZ6Hauv5sN6qMZtu4CP+6fp+y1aoUQmxGc+uwm5KhE9fZ96rQwZ0laEcOuOKfvTs4JNTTITAVj3hSoSIVh9m7afNwx+4ICosV3ez40h2F9X6KUobNAvzdWNA4wpEDBVht4o7X/4FfvsQln6HwapeRefpMfNot8yudeYJr/oVaGN8dXgtG2JVRMlC9F4P8XitpxpsrfHGxsymiC2QuAPO0dV7TfOEOsjorKItvC+H9N1KHCBvEzYjw0/Ejj+FSFqPD35QdAOsDkztcIF9+pelTn1PECzf8AuDXLzkEX3dWUCACz0t6pT1iGWD0Ifm1tsbiTJB02qUkIbcolQm8jE5x56ycSiV/rN5o6rcs8kAlWe2MMIvEaJGCnXiYGhrZg8P3M8fSPxaZmPssT7o5VYeFWFlAaSpwZgYdZ5CQw+ZDweXYnkQxQDyDafLvNWQNFZTfpWNAT0VbW9F8gmMcjAyQOWbcej3ChO69neBriSw6pOBgPKPpL4bi9mPFEnZDFUCCR8wNJaRh638z+lS0BJavRt2Dai5Nokojv1P4brDGYO9DqKQcg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TuCMfDA/TvJzQoa13rI3DeNhfosnY9fHWuuoaZuOhhq1g3OyRaUHwxktaPeywTTiMgNJ4fC9Ubh3JZv8yn1QiVcrT+RF/UZDD3ekg7M4y1XZDvzD0gH9bYO1bhf1d8uzgNJf9SFgmAAeZShkOZICZKvas+qEdYBmdG3A23PocHenMLRbOkdEzTA7a538G1eqSJmupUgRt0BzxbL3a37oFJlczXBh8OPxIDCPNZ//dS2zM7TrSTQfHJJdY31oI18G3OApFtjOpVY8MbX7sbrtUvLVNosirjqiuRiKzV32zmh2neNzdO0ONbgZILWjXy2jjy2FyCkCLyfve4juJUCP+yYz22QhyPJEkQ7/BuFUdaym4xNfMjGDDVnKu4IQyFLHAUh3hIA+2C2wPDdnhZEEFYFHm3HL2RbDbewSY31p2PCx98GbIPwg35Yjsg7CWaLD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:04:46.7462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844b287c-d64a-4e89-46f9-08de793635ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

If the IOMMU driver reports that ATS is not supported for a device, set
the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED flag in the returned hardware
capabilities.

When this flag is set, ATS is not supported and not used for the device.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 3 +++
 drivers/iommu/iommufd/device.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dafbc552d37..d85a2d3e1b40 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -695,11 +695,14 @@ enum iommu_hw_info_type {
  * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
  *                               when the struct
  *                               iommu_hw_info::out_max_pasid_log2 is zero.
+ * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported and not used on
+ *                                      this device.
  */
 enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
 	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
 	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
+	IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED = 1 << 3,
 };
 
 /**
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 344d620cdecc..2e98818806c0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1624,6 +1624,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
 
+	if (device_iommu_capable(idev->dev, IOMMU_CAP_PCI_ATS_NOT_SUPPORTED))
+		cmd->out_capabilities |= IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED;
+
 	cmd->out_max_pasid_log2 = 0;
 	/*
 	 * Currently, all iommu drivers enable PASID in the probe_device()
-- 
2.43.0

