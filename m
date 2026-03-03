Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D017480331
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550295; cv=fail; b=ghQBqw/Q1b1AQuUBU43zTK6tJweAAzBCgYDll516kNSeKFP+bkAlGTVQ3juxIJkSiAQ8foRNAJvmPRRxUqGwfFc02LnU4JBXwmMmMIC6mjPW2o1nyvQ4TksjHOanr2c4TvkDIwHq7KfsydKzdGAeliDLWgIf2gugowCHs9bzZ6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550295; c=relaxed/simple;
	bh=D6yzRwQXh4RViOhLp0rYuNK7Ur5t1DossoQsRbYsSRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/l6W2tNzpEnDUEh35HsAQHV6ITwO0QzGht1bTz90tCTR45pCG/5aLuV9RiJo7AyV0e9dDqp7Y/HAeqjH4SsToyrC01QCDolz8jdaLly0kpxhsyrlhWZN9w3XRH92vuwH8g28XIaac11hTlwotxfP456L2IOQHspUad0lSN83QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZaD20UfX; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZaD20UfX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iml5XzzhLlWzLry+7F6g1gvAN3aaVlX0cRmii/vR99XPitVST7APCRLORGKr+dyk43WlDQOVSTWDFL4dmSmFeQMrksGryiban5jkxq5RAiFqTHaBJDwyOxlf73OhsDkoAK7IFGtWSq/DDI8fBjTKTAKcO3jmqb9syb9LUDqILktgmdUlZHWvhPSypuCORdz1UC5ceHk+Jh6z1Qnk1V1vuRR9RGC/mC2O5BkS4aj5OdbxUw97+5VScdCNqjFFZPLsoeRMTw+BpJwyUL/jhrXk5PA4JI5lle3mgO5wRbOuDss4CNQURgVdtUVsq3JRWHasYgPQJk1DvAQECr8cz8YRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOFOMNIKz5ysbIIfryMoAGZJl3WPg+pGIlxWOuQNbS8=;
 b=wUfBU8Be/vGB+pKust9bfw5XDXNJi3BdHjsMlFXRj0WHxkulEX4tdV/tYRSyN1sC9RYZsQLBok6gRc0TqPtl8YhdtblIoo6sny+IwpnObBh0kPMLwNQvznf2F5bRH+W+cl8aK3PZ6QcvWWOLMnA6PpSUKPXDIgTWeG4h6rcBjkoUQy/FEtqXAMHcic1zcvg1ljtVn4DQllAGWo7+2i3X0pn53d+yZInAwk+HlvA68qNZWivc3tIRWtaaz6s/sSkLbGXIMp+0Qi+QedHGpnDYwHM8J0gnhc1KFjkZVCCviod5ojwlYWdgT9agIy4nMJH60hGPC0XVf1FDVA5ewOLFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOFOMNIKz5ysbIIfryMoAGZJl3WPg+pGIlxWOuQNbS8=;
 b=ZaD20UfXAaT+TM5xEC3imhQjLNn7RPsZ7RoNvTORDhUXhJnC+/B1VZuAvOT2mulYmJfrBhtWLYP7grBfJBDyCszrar7EUPxMYxCN2ynf5KXRTFO015hOAC9ZKz0EWCrxsyVs+2JAqSsK6hzOupEaDv0PfOKRwxUDf+7lBTEW5kOPCXMJshX06KpvM8ju2jPUOK/mIIZ1EcGZrI+qEoq24hPK3wOsxWznqzuBZdWqI/xQAjL7M6P/hZ0DUIeZ6Sq7tr2y7jZaRPugegBg3XjFWi0By7N06NztZsOBDkQEGsCSGfBAyTLQ2LyM8L1JUFeDJtO1c/X1UczH07Q51ejtvw==
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:04:45 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::82) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 15:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 15:04:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 07:04:15 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 07:04:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
	<kjaju@nvidia.com>
Subject: [PATCH 0/2] iommu: Report effective PCIe ATS support status
Date: Tue, 3 Mar 2026 15:03:46 +0000
Message-ID: <20260303150348.233997-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 73637745-9759-4d3f-2bf1-08de7936345c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	3/EG0A4RCmFhbxSyKSmmninVkhyeALet4eYVN68oBVwuo94lUuJRbHJyQoXhBu2RLdcVYkzXmRvmo+xe+vYnsyw47lRpQ7IWb2yh3KuBwUUH5oTsodXtypkFLfhu0g6gOmKJpD9tu65DrlZIcMJdw4bnvCmJnbxC+3Uyf4rt8XtHWYBfcQ+O6H9m1XUL5vnnBI+JBsIa+MruvEWrKsmiU7Q2BoKDmSVUHqhYrQSENUNF3CTDakUdb1vGc5OWEFE/Fagp/SsZsUjF8y1efJCNlSAkhsfpQClUblq07zxoBrexFJankWzWIlKzWmGeadA6kvEmU2OBmuOe72wocn078CNTp3idfjKtO327EKvNrFjH+Mwvq0gpufiC6WWDqlUKskI7trqBVFHJ8x44GOEg1R+4LiWyKHC2Y8Us68FVeA9jRDhUY2OuYcy4NyW7NRvCakUWYqm1R9NoMZIaUbzHDSD9R4GBwKD0jwNTWJWE+PGJ+vEGY+9e2ekApDHMj11Y8pOJhnIknw1AcPEZVb7Bh+GoErUO25GLmEqi64y4ocytAv5Pc4fh1T0V319yRyVTcayyWxVU7dMqTJHQDvYfdlFK3TrEWfvty4bfKZJI5pfDPZmlquhUwAK+p9Zubg+TBVE18kDFNZaWAvjTh3QO3M9FmvYOBzC/57PQ9OpDleMk+IKfODlt75KmKJVT0vWmgBWFXEXG696vko3OPA19m+sgYhOxS/HpqGsJJGx+kuexGVK1HLgtyw6aWb1Xxc1w+Go3z6AlWlpj2dP1xCFZzBduNqAdhIzEQeGdI3D2NhmNGCYeLPuc6/5H5vgTWnRszzKwvIqKcBlnZ466rtN06g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	szjDAMMyeqm9u38kvIIsShXkk/2pXK9zmYotoLY5BVPKmEQUxtknS5wZLhRXLTrGToCBv5uRDoUoFn0DvcNGSUlgZxOGLTFPzdt/M81u767OaucAkLUjXxh31mZ87vXMf7erAyZV5FvUMpocX6Bwa+ozFHdd4Wm5FAObxQT4ifW9l8VwQ8Xe8RI3BWVsJWXwG87cKBaQBJ5lg8B1n9pJ7C5wR2qM87g7Skc5xHiyOqt653OBvyKWizofg6E8oLZoI24lIjcl0aBO4kaB2cZfAcV9PUP2pzV1sAQ9ar7l2wg7Id54o3Emc3k16ozwCW2kS4o04NNlMMXLHgy85vtKhrk9SmAEvwAgGuDRzREchM0hD/AEKlQb/2LYvTG/qd7WssxyuXpAEVvKq5NE7OidYObI9CXmZ0XMseSiSrVqYScquBLu6mh+Wfs6InC5584w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:04:44.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73637745-9759-4d3f-2bf1-08de7936345c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

PCIe ATS may be disabled by platform firmware, root complex limitations,
or host kernel policy, even when a device advertises the ATS capability
in its PCI config space.

Userspace currently cannot determine whether ATS is effectively supported
for a device. This may lead to incorrect assumptions when ATS appears
present in PCI config space but is disabled by the platform, e.g., in use
cases such as VFIO device pass-through.

This series introduces IOMMU_CAP_PCI_ATS_NOT_SUPPORTED to allow drivers to
report when ATS is not supported for a device, and extends iommufd to
expose this information via IOMMU_GET_HW_INFO.

The negative capability is chosen for backward compatibility: on older
kernels the flag will be absent and userspace will retain the existing
behaviour (i.e. assume ATS is usable if advertised).

Please see the related QEMU discussion for SMMUv3 accelerator use case
here[0].

Please take a look and let me know.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com/

Shameer Kolothum (2):
  iommu: Add device ATS not supported capability
  iommufd: Report ATS not supported status via IOMMU_GET_HW_INFO

 include/linux/iommu.h                       | 2 ++
 include/uapi/linux/iommufd.h                | 3 +++
 drivers/iommu/amd/iommu.c                   | 6 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 drivers/iommu/intel/iommu.c                 | 2 ++
 drivers/iommu/iommufd/device.c              | 3 +++
 6 files changed, 19 insertions(+)

-- 
2.43.0

