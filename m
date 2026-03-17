Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424E288D2
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746241; cv=fail; b=CKZZTQW87QYlIf4HKMsriFWZm/RIyVy4wya+y3azwrRM+kjt0p4izFzAdw7ArCstj2cxme9ZUnfNIC7e0MapC+Wj+rqlMPKMBlgLWUHiV0rhqSzzZxZtK2q0nIJhIsJLNnS4Bp7qtDhzM50YRBaLsVvEfaxthwHn0S3sBfUZV9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746241; c=relaxed/simple;
	bh=43rsgpy9CkQin0oD03hXNv8aKsyyubBB83t2X/iHXMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R0UrZYJilxn8aJJjvOXcSy72npjD9Kq+AF0QYZjV58pgQsOA8au8YKjkzqR6qiRgb+Yzmu3Xmsb2huvTlOSOm+sU301ABuXaXYllq1FFvlxwFFpOwdLfefIIaZBocTGsgGMBgqvx/vVmYfmzrZlwx9oTAV7EWiyZjxX4aUl5Gh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ch7E/zxr; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ch7E/zxr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asoOMIn7equMm3PeN6Xo6hpWfatK2P4+Gtn1CdWZEQoYEDQ2AehvlBEdIkvvHWoSUPh92RYCT4rYwVma/DlT4q81ynYBvfD3FXzxZjOGLlOCPXDi/Qyqo4A626Xgy6Rp2wgZE851XEuwi6M68V1tQB+LmZH8fsSQJpnVrylrLBwlGecgQTCinA7Yttr/VnRL/Zw9NVcRmsYOp2/ktk+ywTukcLDGo6DoFbI8C6ix0eFwm6vPVLPjpLrJ07W8rV8Saq+ctIkNzx3MF3rXKgSWs4T7eOrQYZptSiC2UgAu53JHj/bxyrTCK+qcol18oxEzpvPZN2rlQlMraAjwk+Qu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KsBg+59PlvnoFYDwaO2PpK/Knsfo3wz9OjGcGLkPYw=;
 b=AWb4U1SyM7vESbzKNesu+6rRXNv1HkiqqRUktU6KTd7fbfr+fB1Vrshjsocw7DVCc72Iq1kst9VYvG5//KfgZStQoMBy5vtpILnKx7qAvPVj+zFhRaWbbnUy+9MtKwJyY5H55l5JZrqZqIGY11bBO2p5KZ2uZTxsZGKII2AalkadjixEiTwUAShduFi/rkDKv6tNR5j3KcaubmK8Y1+zQKWmg8erLjlITBRSTbTrN99IGCBTYfayl0VrbaKu5XJ93hTc2kUBWikoT4Epy0FpjILMRFChEcaEDglwW2rM02Oxk7uX8Z+qhJvkj3Hw29hDgOhM9o1q66zfGf5CvlZMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KsBg+59PlvnoFYDwaO2PpK/Knsfo3wz9OjGcGLkPYw=;
 b=ch7E/zxrpMFOAW39VoIHXXFj3LFTwkEC7FN3raTefKU4IZy5r8W3870ZwZi3IU78aJ08zmrWtFZ7VLcuVSCtqHzlgFd7zKu8daB0NT++ZAq2KG+KtmggWHNg4fBMM2yimnX9+K46CMtfBIcjRNiUoeIQGL/rK19Ux1ZMMOsaC2gYKAk3K65diC9Pj/mUw5TKmhjupzw779T9iN85LtVi0GvidijO/XBISdn4GMgjBVC/D4HlGr1OOzPH0Y+Y6k8G2S0aO0D3GReHq53hd7AvUoamXWaedny0+J9XhiLUl6NXAdzK0c+PZxGoaQdoQFMLj6fWG0M9CfxaAKRpF7yg/g==
Received: from BL1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:256::17)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 11:17:15 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::c3) by BL1PR13CA0012.outlook.office365.com
 (2603:10b6:208:256::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 11:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:17:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 04:16:57 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 04:16:54 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<skhawaja@google.com>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 0/2] iommu: Report effective PCIe ATS support status
Date: Tue, 17 Mar 2026 11:16:01 +0000
Message-ID: <20260317111603.101456-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d0b1f1-c9fa-4910-6a83-08de8416be50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f9eHHxFo7cTBmnEUFTLq6ATpfsr+ol+Kky1UB9Se/j6Oj5PVk6UGbYvr/vldLuVjnCfFVnYujOap6fZQ4Ug3WUP+cwUKLZgokFEXTbmiMEkWseC8PKD+0OnWOZr/TfiDUuwnfL5wxJcoIbUCh597ivgRhTWmsV8NQ3bnyTg2eqmrLRvHTNjpTr7J889ORiZtq2DRBOQnD3iggBxdXwJf2b4VZVNWOnlzQL/d7zvN9uXZUS0KUqYniVn4Vl71COx6ZAAWtaxKDEqWfSbAoQL+SSfJhP7z7E+wj4cswnXA+QAQVXxvU1mfXZ3cDlNWyEj86xeEkDwMsBDB+zK1SaNPI6iAom/imRPiOCXkTmzTcqIcWSSbiqMy9eqew1pheFsxD+grUyqGz94A1H/WMpWrKhPwZkPiPDUSuj/Ny206DGYK99nCl8ZSHGV2GWW/SUmrasRz5Yfo+7RMt+WbZ4yuE/8nG/87o8cRNE6ck9vy+kuX7Gqp7Fzwdsf0L8deuYcE7AZ+A9F9/hP31UIQL4HBE6Oit9avIR99UcUU71S5prt3O5gk/973qOONmwLClQC/wEj75kMLLmEfzQcbPW/3PEIyaJER0gWP1kEAFgyKQ0zUOt/T/EQl9fB1mMbPRKc43gfcxZhOXamosw5URteJzIIPlLQdIumqpEyI2KHI+8+YXlvvcG3jeoE7kZa5q0l2fV8eS3BKR4UpGd0hjhgq+cMKBPbyDq66hmnnxOEXRfPRskgACU5ByEQJhm9BQdj2gsH1BLnjbLrJUQbSlfh9Tg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O1y8ApwEIClGTxeiP6VftU57XnPPjJMkNi54r+3W01oTlRYIOlbe01gtR6fFyhP6SAQ5ZcY/1G0yDk5XRpeOW8HB9fSwhGHVSdluiijXVZ7iCneNis+RCGvupbObsGCkiDyKuPqDty1e9ULCFEYNhYoT592vnq7MlYZPRxfXPaur4O2ETKspU2xfd6DD03ZXq+MVCPU4RHveC7luuKszJTGOyZhgbOfU+0ZeOLnyUyDsWkPXmSAv6xL1iiU1vOAMHzLaHWbvt/iq15Ygx4nI0YOzlHM+FFSA6E4ywY40TS15tkkOxN5agwYzwdBZrIdxq4ECRchpFwMcjCBLvVtGf1rFs5PEmoP5z5rIZtToxn8rkE3ef0sdMBSd5H4AeQ9aE1v+MPug+YeXKlcJ+IMtNKbCndBp96mUtR8y3ACJnMnysKa232Gq92WGAbDKuy8e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:17:14.8530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d0b1f1-c9fa-4910-6a83-08de8416be50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

Hi,

Changes from v1:
 https://lore.kernel.org/all/20260303150348.233997-1-skolothumtho@nvidia.com/
 - Addressed feedback and picked up R-by tags. Thanks!
 - Inverted flag to IOMMU_CAP_PCI_ATS_SUPPORTED for IOMMU drivers(patch #1).
 - Updated comments and commit messages to clarify the semantics.

---

PCIe ATS may be disabled by platform firmware, root complex limitations,
or host kernel policy, even when a device advertises the ATS capability
in its PCI config space.

Userspace currently cannot determine whether ATS is effectively supported
for a device. This may lead to incorrect assumptions when ATS appears
present in PCI config space but is disabled by the platform, e.g., in use
cases such as VFIO device pass-through.

This series introduces a new IOMMU capability, IOMMU_CAP_PCI_ATS_SUPPORTED,
to allow drivers to report the effective ATS decision for a device. It also
extends iommufd to expose this information via IOMMU_GET_HW_INFO.

For UAPI compatibility, the iommufd interface exposes this as a negative
capability, IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. On older kernels the flag
will be absent, and userspace will retain the existing behaviour (i.e.
assume ATS is usable if advertised via PCIe CAP).

Please see the related QEMU discussion for SMMUv3 accelerator use case
here[0].

Please take a look and let me know.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com/

Shameer Kolothum (2):
  iommu: Add device ATS supported capability
  iommufd: Report ATS not supported status via IOMMU_GET_HW_INFO

 include/linux/iommu.h                       | 2 ++
 include/uapi/linux/iommufd.h                | 4 ++++
 drivers/iommu/amd/iommu.c                   | 6 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 drivers/iommu/intel/iommu.c                 | 2 ++
 drivers/iommu/iommufd/device.c              | 4 ++++
 6 files changed, 21 insertions(+)

-- 
2.43.0

