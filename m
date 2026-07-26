Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FC27EC7C
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053957; cv=fail; b=eOVx2q8lvUFX9EDOHctEobfSd39BWL2pHsLH+X7hKNyKMqwBq7Ke7yzMljZ1n0zdzjdR5tvHxk+l1YdTR6MDI0DCyjutSdiPr8pjzefR/gvBIQ6ATBdXagAZ166MZv6I94QefwXoCU5MnMfiG2SMLpXt8rHB5FbxKs4LZjURDHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053957; c=relaxed/simple;
	bh=Ugw+maYRKUDy5PPcWCTkMYozYlkkkCFOieUZIv/64Ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ltnT4+VyHzQjeFFw3kodyr7/e6tBTLbMVSA8uU06uwMbASJ8EUj4ARkk7+ftFeAmeUcIZwxEJtVm8OtKrd+I29qYevuu2zXx4pWimiTI+aDW9Ami6I563m6QgOexPVbncjxG1NSrhXbmW88ZujVXUN/Kf44bPSLY7VGZRRdQ5TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxcXhdkh; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxcXhdkh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeTNn+e9+KQzhpTb9uYGu6mX/EF0Cd0UfXkL9IXRJ4HoPoPBDicrLpewobhjf7+8H9cTukGG9YoHnrfbpL3E+MfBEMfGRbPdgj0WPffvQE9qHFI8C66lOcdf5Qo15Pt7nHM/cmLXwQZA4QzpBFIlaYxZ0BAgH7k+zg97Q35u+SSS3SfBSBC21wLVhAQUxmeQDXPwS1Zr98yOJMLNot9kDq3Gsk369eJHBl/AtRtUH1V4FkAwA9/f9/oQdpOJb61+AC7+AATWlRFuUzTzRn5oUTHw9kL8cnJMK8k6uljJ4DQAFPBf2RqQRLOTjeYizDx1/+sS/6nFh5qZ1dihD+/W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIc5I4IThCdLBVGIY4s9nLQUthPRuZ5LmFwzht0Dni0=;
 b=ZSG1UykCEboE0ymdS4vW7ZCs4LgbVT3n3zUAERq4ISCD7RxteaoPCZOD/xeMTKbSMIMwacXRfUi/pTKaDySOYv1PnlUouC36o6B2h2nChQPg5QQoNLhNGGMGOJXRzbzt84yfHWnOZSNbwYx6nWa5gljCmKkn1orlBBELGLTb3+PSv8aPMteu3DZRDVfGMjMO64DURbDJaQ23Z7URely/9V+qMgFdHFrYcKUMwT7+lrub577KsiMKqO93tZOEpqAo/0o3c8k9WmF7cKjDadoiBgIZrl3jtlwzOmW5824RTcg1Te9XBJltZ+Rb7ohcsqYrww2MxrePHRNNGPKgxDCvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIc5I4IThCdLBVGIY4s9nLQUthPRuZ5LmFwzht0Dni0=;
 b=NxcXhdkhOVNJeRlrj8iRJTyAlDrRU0QjSkPdNLdDO3WR9UsU/sDRE6I+2brRi9mrud7W1ftCslxjidrODI9pGfpoxVpATFcToLGSAmlwfI2E7c9ttTpwM4JPrYm3kOvTdvSXZN58OjUSXWZfKbnQeQUR3bFrhuF4J5VSdpePGd/xDvu7A6s/OTsXrDidLP1Sx0TRIT4WtlAlCX+Endc09DdXzxe9bNPv2KIUg092OQZ/FDNuT/sVRqtCPimQlIUHFNzCZsxC1SZ1ar8doe4ZV5w08aCDks+xtyGytBSP5BBJW/s2JExR4uKFQK84DEo2aW5ANOYpquFBzFqUqogDng==
Received: from MW4PR04CA0184.namprd04.prod.outlook.com (2603:10b6:303:86::9)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 08:19:10 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::1a) by MW4PR04CA0184.outlook.office365.com
 (2603:10b6:303:86::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Sun,
 26 Jul 2026 08:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Sun, 26 Jul 2026 08:19:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 26 Jul
 2026 01:19:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Jul 2026 01:19:06 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 26 Jul 2026 01:19:06 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v9 0/4] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Sun, 26 Jul 2026 08:19:00 +0000
Message-ID: <20260726081904.1408859-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf80c54-b665-4f65-0c1c-08deeaee919d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	oOGlsR1WqhgtP+CEuzAtldLc8YsanncLLBpiIsVqc/xGBCv5IcjomBaz2Z0TIIMY5SbqT/ww/fcApPxTQIAytD8mxLZc8EacMdPyjbQVaaMOqIQoMuVxrM5ao5Q9hc56YD6oR0n24AYw2S/6DXHPFKLl97+SfZSHYMOZUXGnDUB0BhBJWX/HdLAjsKQ5oo7/+3LTwYIP5e1W9He1WHwDMOT1GPNQq8abzBGChGbHWDTRW9Zoj+vBkwf4vde/x9+0jJKvnEFn+0azuGX8xf7yoJajxCIt1qGb7kivUtj1P7EKPkK3R7vGtqC7oya+iPK/E8Jktdx/sKbModuxq4Ew7lMejK/WBugJbRZBdoJU+L0Sg/VguRn9RaXehXfQEytzFFzRYD2iATJTZ4t3QEdGNls338Rza8q3WYhiPc3yTMPsf0qQ3tWd7OcolZ4+pgbB0RcSSSRBUGjiV5P0AK1NyMScKxOZIth6oMlASLMQX8Dg8y5dWFUiKYrAAV/49vUG4skiVe0OLSlntN2FxeZRMSBlwz5TD9HTXY4sOqO0gnGfRajvZ1XmnxKWGLZntOt5g/Rc0zhCjtS15tKuME6WUVGufmju9/7y4h6QvfjVnoPDPqwpt9XlukKogdu4XcEHj4zGt8V3coB0HjthYwYg1PB/sa67v+cs9cHW51JKAZ24AAQ/9Y48X/xww+a+hEY+MDDLsfYIhqs4PhSiRhUcUQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U8OqNF2axVty8EBrwMM2U+JkCWbbGXHKMT9J+9cb2bMeT/MuWGNL5CWrKlY4C/+AAlg8aGsqLjqx5QK2nJTM2t3itosMaWYl9HulKAiFLQNCAaaPtmG2se1ovSPdgjBmSIbavT5rqXrpqzVUSezo98+mmvNu6YukrdbVF6IY9Gu8N06dmczsZ3iqH5NxahnNemb1Cc/ktINH3PLJ08ZumKTAx/rGoxQ8cHVW8ZQn41q86tpGqCoNKu2XnRWaRsO/DrFUvVA0ld1H6tFPXgpIR1LmybWzQasDw0on13ZGHQtvh4eBoemSQnkEP3+xxlzpeCyMGS1uAvLCNVXymRG9yMHUIlIUIjo8OZM+jV5hst1RQP/kS7xHSBhQNx9nMyxBlNNnbES14Izg2a0s9KfE7I0G4W0LxFXTP6TWSL6lUOGgSiyeLJST90g2AjI/pa7P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 08:19:09.7092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf80c54-b665-4f65-0c1c-08deeaee919d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice.
The second issue must execute only after the first issue's CMD_SYNC
has completed, giving the sequence:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must not be doubled.

The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
cannot be detected from hardware ID. Tegra264 is device-tree-only
(no ACPI/IORT support), so detection is purely by compatible string.

This series is structured so each step is reviewable in isolation:

 1/4 Refactor the existing CMDQ batch force-sync conditions into
     arm_smmu_cmdq_batch_force_sync(). No functional change.
     Authored by Nicolin Chen.

 2/4 Add the static key, command classifier, CMDQ submission wrapper,
     and batch force-sync condition without enabling the workaround.

 3/4 Report the erratum to user space through
     IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI and submit
     user-provided invalidations through the raw CMDQ helper so the
     host does not apply the workaround a second time.

 4/4 Enable the workaround for "nvidia,tegra264-smmu" and document
     T264-SMMU-3 in silicon-errata.rst.

The series applies cleanly on linux-next/master (base-commit below).

Changes since v8:
 - Split the iommufd changes into a separate patch, leaving the
   final patch to enable the workaround and document the erratum.
 - Make arm_smmu_erratum_cmd_needs_repeating() file-local and remove
   its unused declaration from arm-smmu-v3.h.
 - Restyle the SMMUv3 hw_info flag kdoc following enum iommufd_option.

Changes since v7:
 - Rework the nesting/iommufd handling to report the erratum to user
   space and stop repeating user-issued invalidations in the host.
 - Drop arm_vsmmu_can_batch_cmd() and its iommufd batching split.
   Expose __arm_smmu_cmdq_issue_cmdlist() and make
   arm_vsmmu_cache_invalidate() call it directly.
 - Add the UAPI flag and report it from arm_smmu_hw_info() through a
   new arm_smmu_erratum_repeat_tlbi_cfgi() accessor.
 - Carry Jason Gunthorpe's Reviewed-by on the first two patches and
   Nicolin Chen's Reviewed-by on the workaround infrastructure patch.

Changes since v6:
 - Add #include <linux/jump_label.h> now that the static key is
   defined in arm-smmu-v3.c.
 - Drop the unused smmu parameter from arm_vsmmu_can_batch_cmd().
 - Expand the arm_smmu_cmdq_batch_force_sync() comment to note that
   batches never mix CFGI/TLBI with other commands, so checking
   cmds[0] alone is enough.
 - Note that a guest kernel enabling CMDQV on Tegra264 must also apply
   this workaround, since guest-level VCMDQs issue commands directly
   to the hardware.

Changes since v5:
 - Move arm_smmu_erratum_cmd_needs_repeating() into arm-smmu-v3.c
   and make arm_smmu_erratum_repeat_tlbi_cfgi_key file-local static.
 - Add an inline erratum/workaround description at the static key,
   referenced from arm_smmu_cmdq_batch_force_sync().
 - Fix the misleading !n comment above
   arm_smmu_cmdq_issue_cmdlist(); keep the defensive !n guard.
 - Remove the unused smmu parameter from the predicate.

Changes since v4:
 - Drop ARM_SMMU_OPT_REPEAT_TLBI_CFGI: the option bit was set and read
   on the same "nvidia,tegra264-smmu" compatible as the static key.
 - Reorder the series so compatible-string detection lands last,
   after all workaround infrastructure exists.
 - Update the force-sync comment to reference the static key
   description.

Changes since v3:
 - Drop the cmds->num == 0 early-return so the refactor is
   truly "no functional change".
 - Rename ARM_SMMU_OPT_TLBI_TWICE to
   ARM_SMMU_OPT_REPEAT_TLBI_CFGI.
 - Rename arm_smmu_cmd_needs_tlbi_twice() to
   arm_smmu_erratum_cmd_needs_repeating().
 - Replace the explicit opcode switch with a range check.
 - Introduce arm_smmu_erratum_repeat_tlbi_cfgi_key.
 - Document the erratum in silicon-errata.rst.
 - Guard the repeat path against an empty cmdlist.

Changes since v2:
 - Split the changes into a reviewable and bisectable series.
 - Share the command classifier with the iommufd path.
 - Split iommufd batches at "needs repeating" transitions.
 - Document why detection uses DT instead of IIDR/ACPI.

Changes since v1:
 - Detect the erratum from the existing "nvidia,tegra264-smmu"
   compatible instead of adding a new property.
 - Centralise doubling at the CMDQ submission layer and apply it only
   to CFGI/TLBI, not ATC_INV.
 - Drop the binding/dtsi patches.

Ashish Mhetre (3):
  iommu/arm-smmu-v3: Add CFGI/TLBI-repeat workaround
  iommu/arm-smmu-v3-iommufd: Report CFGI/TLBI-repeat erratum
  iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264

Nicolin Chen (1):
  iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions

 Documentation/arch/arm64/silicon-errata.rst   |  2 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  7 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 89 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++
 include/uapi/linux/iommufd.h                  | 13 ++-
 5 files changed, 102 insertions(+), 14 deletions(-)

base-commit: 9eebf259d5352b87080d67758f483583d9e763d7
-- 
2.50.1

