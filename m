Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CF36D9E0;
	Thu, 23 Apr 2026 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971703; cv=fail; b=oL1malF6jJNO3BSJZwFatuQlBO6okYc47XGv/1uCmZrFzxETlTs80NK9eU2OYfZAOCH7ezGPu5A/EvSono8OjXoocUb8w67oVWh5ZE25Mp/iDfu59vZS5hAgUQJZIVCvpc2TNpjwsIG2kGZpJCA397poEa6jHEABowP68IurbXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971703; c=relaxed/simple;
	bh=URNOVtlni7CEPjYLwfBeOYO+HZJnDT7qnunzRUutuwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rssm/lBfujA01xr81uAQFA76KkfFwzEDZkEgXuYM/wIdzP0wqDpxJ5nPWJbzPXWZYodplJ7GCGemHKqaQ5jrth5ZYJ0UPX6XAZmeSzkisEtn1Ga1K8MtYeaB911bNwt5JFIh+KpJdgXB3TD/WDvNeloDplQ/iY1WBRkmKXXxWFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=juTtGkyr; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="juTtGkyr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZjngUonZU4wckRr4sHnAZxiPfMzucCcJdxsbG4Af3EniU5ZlVvG6EsrR+Vc7qhtOxGYkzAbJY5zZIkdOC/536c4E2YTgKhzNF47sCYRVSXkPHNvyyRMfKYGiOrlxQlmX+jVm5m3ZYZUhILVViKUC6KX1p8dijOL9uLk2BANpd6iDkhcwTWPJKT0I0gGDpeAdENFFtZRnMif3IhTPfr45ANDYFDOD9LlOncQgXRqVFReDeupKXI5PEwZxZ5QQFExV+gYZM5QsOPfof77l+61Py7KBZsVG0bvkLmQc+jQ5IYfab5454ZnSJ82+WdoxNU9Eq8K3OmEKIkrl62w6BMfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+CZTeY+7FF6O4WNynzkXoA2FgGMV8OrK+LyhVB1xC8=;
 b=sdfXo1nHX4FQJycPMqgMhVCB90H08H4aRY8KIvaIRUC5dGFA7KoeHCV5O/vO0un0ZHvIhjpr3ML82cWIYDo1s1b0uXO6ZDhzly6vKP95lt13uBhuP5FjiD67Ez7WWl3k8AO1+I58kLN+IN8+dby5FIcZB0eUDKcaiRLpv9PRcOl5kZblKKh+JrGkKy+DUBH7j5lkJrbr+kHBkNWnfTG5D5/odwz2MfcFolhgj+Iv2VpsRowORzzX2JDuAHSTw5/vgJe+owPHprUkqi11AmNw369/PUX4+vKiu1hnNTyzO1SuQRUBIqiL/RTVueZykf5AleyfcAZWtEIMkSxHubqVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+CZTeY+7FF6O4WNynzkXoA2FgGMV8OrK+LyhVB1xC8=;
 b=juTtGkyrgm5ol0UW29DFIn4UwHusqjo45qvS8OqGRNzylb/mYyKYPbG/dKAxR6iPT2mFjSz2gN+HAKpYnOJw+fvmfGV0u9gurScSKolZyD3JKEGmYOjLJTK9X9Gsf2hrnbAtzCKUJiqU5ATIjrJRM7PBntrGuutMA7o1cE8aQuusBBT1Cqa3ZCWNv5GqVm2HGVWKynwE7kq7OQQWvKZ9BSY822ZHrWscSItri1Xiw4qe9TlZgWmxEj2c88gSnuNquc7gS4teGv7bFyzN4aWNF9PS2Y5vg2ebHNLmurjQO9mtLvMGQQPXi76AlhlakI+evw5RdBwek52DNTjVZpzPpg==
Received: from SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 19:14:53 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::c9) by SN7P220CA0024.outlook.office365.com
 (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 19:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 19:14:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 12:14:41 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 12:14:35 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <saket.dumbre@intel.com>,
	<lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@kernel.org>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <jgg@ziepe.ca>, <nicolinc@nvidia.com>,
	<praan@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<sagar.tv@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <acpica-devel@lists.linux.dev>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V1 0/3] ACPI/IORT: Honor Root Complex PASID descriptors on SMMUv3
Date: Fri, 24 Apr 2026 00:44:14 +0530
Message-ID: <20260423191417.2031652-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f33e373-f167-4368-80ed-08dea16c98f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S2FUjHmqRRJr3Xslw3yzLIqJ377x7UEkHAihw5bYj27g4+hmk+c+JggFMC6yzHOVGsQlc5v1o9GMNS3GXQl8m7GG3oj2jdVRiaRRpF4LR1DfwLoQ1MqHMmdQDTb4cwunKDqyP0wgSqn84e66ArjmyLnP96BsA8vy7VFaM+ppwmJmH09PtFJoxwrWTAnumj6KYTUngQreWdoFLnTWii4dDlrRv+pVSyFcfQLPCvTRs/MvKYsJ5U+Xob5P/9xb+Muumi/RRbK7CLsGf7+W4UuNUU0XOAkdoB8X4ntU99RoK1EIo1kzdz/odJFtvUD9Ink1jmrebMRyNuQE/hfcTLxpXNmZ0VvWpiEGqvy186Cc70Ma/omROuqyVDq2dLHZJm6gAQKVKNRHbeUI/b5jTnlwld1DcsvLwYYXMG2mz+UKqZ01zXWz/JBwYEk47lkA3d/2VGqux4jvYdtFpLcS1yjnn+reekJxtIqvtAZBtQpPDo6n3/qNEqfhIawuCsKIyG6GouER2GVfpNSrkbgJjFF4ugvgWbeKjEeVWdRHO8F8Io2oNEdwJIWXqjqeh9ieNsnGNOEp7FLigUZT+qESqTAoh322TRFNjDgxeEqwJx24UTj6+k45pLlrf2H/i4UGoG32+x2dHoAdm0TbmuOey5Xgg791MXh+d81UtPQ+MQDcH+Jy1jv+z+beuwMtppp6mVmplgyM2JvyPAdhqCGz9NpI2nQ6OTipiEpLx4uT079ff0O/SJCS8cJO7M3RJk7+qML/NDUdUKRSpt5Cb7ZIvolcEUqLfc4J1IyxECG79B42oYLoq6fC+g9esBvygNJA1oYL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bWQZZPcPzzXQzCa0JTWaX169jnNvEef6JUpqAfALcyzRS6lggv3K8BgFwkqNWNP/BVRXWkxsOi8vhkeuT0YoRiRza2t/H7a2mMtOUFMrSTJolgGSAb+jv9SroBRF54TTQj2EqMFhtQIky/1ZATMUOsltjc5Aguqgoe2d9Vo2ZjWOYgEU8oSweELaguX1+a41c3VgWkVnx04/IsCyIo9iN1vcdBpAKp+eojFlphqC+a+P4Sdc4vCim/FxWFsuvOpae/3f3+oYD92dMntTNm0gSDZ4v3BRlvNt1USgckmCKvPN2mzNmrW7aIXpQJ87UTdA8daPGsfOAhwXX6oAxYdFF6t78RAWkSY0Vcm0kNGiKcRtV4z8TMsHyM/asXXIQJVsnAqn9AJDjKm+VXIXrc0H8xgmUncWTWQUY6gVE79FrJR2hjS9DaOieS1fD3pV6cmF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:14:52.7054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f33e373-f167-4368-80ed-08dea16c98f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

Hi,
This series enhances Linux to read and honor the Root Complex (RC) PASID
descriptors introduced by IORT Issue E.c (ARM DEN 0049E.c, January 2022,
RC node revision 4):

  - PASID Capabilities at byte offset 33, bits[4:0] = Max PASID Width.
  - Flags at byte offset 36, bit 0 = "Root Complex supports PASID".

Both fields have been spec'd for over four years but are not consumed
anywhere in the tree. Worse, include/acpi/actbl2.h only covers the
PASID Capabilities field - the trailing "u8 reserved[]" flexible array
stops just before the Flags field at offset 36, so even firmware that
populates it cannot be read today. The existing ACPI_IORT_PRI_SUPPORTED,
ACPI_IORT_PASID_FWD_SUPPORTED and ACPI_IORT_PASID_MAX_WIDTH macros are
dead code, and ACPICA upstream has the same gap.

Today arm_smmu_enable_pasid() calls pci_enable_pasid() for any PCI
master with a PASID capability, regardless of whether the upstream RC
actually supports PASID and regardless of the RC's declared Max PASID
Width. On a platform whose RC cannot forward PASID to the SMMU, this
enables the PCIe PASID capability unnecessarily on the endpoint (the
traffic then gets dropped upstream) and sets a non-zero master->ssid_bits,
which complicates teardown ordering with ATS (see the comment block in
arm_smmu_probe_device() for that ordering constraint).

The series fixes this in three bite-sized patches, modeled on the
CANWBS support from commit 807404d66fcf ("ACPI/IORT: Support CANWBS
memory access flag"):

  Patch 1 (ACPICA): extend struct acpi_iort_root_complex to cover the
    offset-36 Flags field and add the ACPI_IORT_RC_PASID_SUPPORTED
    mask. With #pragma pack(1) already in effect for actbl2.h, this
    lands the new field at the spec-mandated absolute offset 36.

  Patch 2 (ACPI/IORT): add three static helpers that read the new RC
    PASID fields (guarded by node->revision >= 4 where appropriate),
    set two new iommu_fwspec flags from iort_iommu_configure_id(), and
    expose two device-facing wrappers so IOMMU drivers can clamp
    endpoint PASID widths without walking the IORT themselves. Stubs
    for !CONFIG_ACPI_IORT live in include/linux/acpi_iort.h.
      IOMMU_FWSPEC_PCI_RC_PASID      (bit 2): RC declares PASID support
      IOMMU_FWSPEC_PCI_RC_PASID_FWD  (bit 3): RC forwards PASID on
                                              translated transactions
  Patch 3 (arm-smmu-v3): consume the new fwspec flag and the new
    max-width helper in arm_smmu_enable_pasid(). If the RC explicitly
    declares no PASID support, skip pci_enable_pasid() silently.
    Otherwise clamp num_pasids by min(endpoint cap, 1 << RC width) and
    only proceed when the effective count is > 1.
    
Policy: all new gating is conditional on
iort_pci_rc_pasid_max_width_known(), i.e. the presence of an IORT RC
node at revision >= 4. Platforms booting with older IORT firmware (RC
node revision 0..3) see no behavioural change and continue to enable
PASID purely on the basis of the endpoint capability. This keeps the
series safe for platforms that ship pre-E.c tables.

Out of scope intentionally:
  - Wiring the new fwspec flags into Intel/AMD IOMMU drivers - IORT
    is ARM-only.
  - Consuming IOMMU_FWSPEC_PCI_RC_PASID_FWD in arm-smmu-v3 beyond the
    existing CD/STE programming. The fwspec flag is plumbed now so
    future work (e.g. gating PASID forwarding hints in STE.S1DSS) has
    the information available.
  - Exposing a "pasid-num-bits" software node property for PCI devices,
    parallel to what iort_named_component_init() already does for named
    components. The direct helper is simpler and avoids creating a
    software node per RC.

Thanks,
Vidya Sagar

Vidya Sagar (3):
  ACPICA: IORT: Add Root Complex PASID Flags field
  ACPI/IORT: Plumb Root Complex PASID descriptors into iommu_fwspec
  iommu/arm-smmu-v3: Honor IORT Root Complex PASID descriptors

 drivers/acpi/arm64/iort.c                   | 80 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++-
 include/acpi/actbl2.h                       |  6 +-
 include/linux/acpi_iort.h                   |  6 ++
 include/linux/iommu.h                       |  4 ++
 5 files changed, 118 insertions(+), 4 deletions(-)

-- 
2.25.1

