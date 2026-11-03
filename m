Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677821;
	b=3hzYCS5PNvUpbzjPxLwVmIrg29xB9DTSH7xh0qlT3gfDEQ5Wp7/O7hgCitpXrByTcWws
	 FHVFDjrL2EyOkBUPuSKHN1LEkz/Q4q4HU7d8rlvSz2Z9XsvZprWt+dKRxIavtnqLQc95Z
	 c+7S9CoOz6EeUFeBTTj2OVPMst50PT+UcOIEyDzriizYXA5fPOjxi2Ek/yEn5lr+mCUjs
	 A+ao2828Ak5Egk5c8xF5DS9tcTCFBa/4+inXdFcdNoeBljNpmrY6fB2laaGD6Qx8a1E15
	 gfzofp04zqJvEp5C11WfY9dSXyri9E5B9XLsoyBi0bA2wrsJP7gBBpy9DbB5TnTqSZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677821;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XZH6oFvP49RsV7j35g75FI42yx8b63aHk4v1b2Ggjjg=;
	b=ukx3H1ayctCVyG6YgTcxA3LEWRG0motcjrHjMZLK62/ovN+Scsq3Oo6+q2Yn+5PmNTE5
	 EtZgbueD+mdIP7ZSZZ0t3RWjyiKyuWCfFvuF3WZAKdxN66Mj/TRlBmDyP44lWa/13/KhE
	 E87kF2GDWCDkxrfjUJqrF+KOUOps/7pGR2kvanXwAVw+7Fn1DWOgcEu84ZRsZNOOFBO4L
	 9qk8Dcuk/h9weA+bxj096/N5hvPAS5hTVrlBDGXMTxXh/CiNuWL/tKraKoXASjeTORENN
	 xxSAbZtm/U2x64CB/Uzkh/MW5G8DyhYs6QYyNBloGwm9cOfiq71R//5hus6CnIGg3Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="RHfcL/xg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.38
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A8606A33A;
	Tue,  3 Nov 2026 03:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6A8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RHfcL/xg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiLd5Y3LE/gst+0asMkh6hovHJtR1mm87UJz3zEl1IoG9jvhH5XUxFrlzCmGmcMXwrmtuOKADFyQ4ZDEL07jsXLC8FMb5e0WptgExZ2U4C8Aa1QHOes/ccaQi9nTmXSQIuHMLfbJL3AAyxVB7NvHVWA4lez8V8mDpgIpW7W07/QLK5ZuOgXWvUejqpIDOIHZuzSPqUSOqGSx1fB0B107QxUcRir8pgvT0o9BvqKgtIXFmXeLK0W5sqP6a7To13Wpd/PKFVTcOfjoRcU1jxmYYAhPh5inK5j+cw0UPsn/Y3Av8/DjTDxyesN09c2RXSgktQv3Qu5mmnqh/Ysi9XANUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZH6oFvP49RsV7j35g75FI42yx8b63aHk4v1b2Ggjjg=;
 b=zVlYnPT2zy9DyaC2MooMx7yRhL0YvvtCwQb7J5tb+2RmckVTw09UYuoPtH3mwxEF7LZiwTrYoYlnuW/puHkKG6NplkmHGheUVH4FtUiW88rtnTY82/otLQcGXP1QAxAYLLe78cJA5YDlFuANnquJ5Aj5voPypIyBzTM40BKYte4ArRy5hQJvwcY16JHLRKIkL+PuCXJs3NYTufyrFEj7faqNZfIhi274RSYOhsZHMbwmVfyHfqoQtFHWJIb8nX+Ky4wjXAMZmvktDzeLAh3MjcxMnAjBcF5U5YgdzZFW5fSDx8ho+r1CN83yPeSSrN5wrvjkZfnew2zFFSTN9s0y+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZH6oFvP49RsV7j35g75FI42yx8b63aHk4v1b2Ggjjg=;
 b=RHfcL/xgJeAp/F+bgwCbw0yDZIVSoEip63sMkKuYBuAVyAQo0tGeq2AiRAZl0q8dHdQNjsDgdQq9odZDAmefwf/onN71MC4NJYJef8Bilo2Eo9qhSvkY8jPcguT7HI9G+JDKK7TWtT8c6ru4C24kJGLlKysxJaaBEUnDiUdUUGIZZ8Wm0MRvUcsdaSZF8uJL0wrFRceILrh55gktC+kxWpEzqsT+Tb0z7iaIR/f9wWwFj+cpcaKF7rvc655u7RPQ4BoOU7ou/v7+ZQf0ut6g6kIBvCnVzjrRxuXCXmfp6BvSPhwNNIbmBEEAD6PIfmQ410Vvh5hgeA65j4sqpQoQ6A==
Received: from BN0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:408:ec::25)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:50:10 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::48) by BN0PR04CA0110.outlook.office365.com
 (2603:10b6:408:ec::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 03:50:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 3 Nov 2026 03:50:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:49:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:49:56 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:49:55 -0800
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
Subject: [PATCH v2 0/7] iommu/arm-smmu-v3: Support guest-level Realm VSMMU (Part-1)
Date: Mon, 2 Nov 2026 19:49:43 -0800
Message-ID: <cover.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0021aba5-4385-4a33-1dce-08df395d8e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|261102123227099003|20052099010|18002099003|3023799007|13003099007|56012099006|261021135927099003|5023799004|11063799006|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	IB0YvhQbOJ3sOiBWdvfsKE3V3qI7yS1U75XJeaY3xoaj4mu3oI2YvxYRHpXJ3AnqZSrftrrYkxshA1wp/V1BgQ5832ezr9V48ogOiDS0A1z2bYz7QdvAVUqIKDquTpWh196WwUI7Sm/bpLuDlcivXYoygXXuuD+w7yOHjagqmULBPEY4CuOcsWEhQSlHIdqu88leaRtH9dYo3cCJDrl4PtFmhCqZooBvgDiAFuqdFoXS+ZrjHvJ101BA6WuSTflwFFmGojL3L9Nn6BPXo+R4/HB1xO67sMoH8MR1Q1MGqVTqIIHXCFdQS0YY20AkamijDBKJSG36lO5ibwG5G0xF7wpvGSPcgJr2yymU5E6eHxpRCL3N8lIzMQf7vVaIjku69/NU/e8IzB949EdhOGFC7FXCaUTkBktrmb0hH5y5h8V7skR695hvcFQ9R2Utq66r5mB7Fcnh/LfZRrmae4n/Y3RV04X1j7FJ1sRoNngBz+8n+O7Xn3ulc6WbbYbILKvaz7Hs9HAAUZ+bk9c1d2dtEtsxlp/0dO5XNxnlybeszrhfnWD9dgDTmGsw4YDd1pjEnj+N+lHaYw+dDf5KgbUprm/THagV2K1hKsBTLn4gqNLhsZC7DUJppiuJtt1xLWVApm1b8VwgDldWQti4pStLqvHJnwpKig9jbpdkzAE8hlkAhTnSca4037Ak+gioyX1syI+Ohl2nRkKZbHzD37/pEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(20052099010)(18002099003)(3023799007)(13003099007)(56012099006)(261021135927099003)(5023799004)(11063799006)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qgK2iaz9CfhBsrSL+XAdxuaI6fYb/zIE1Mk+ZoAMaZ8Ne3MRC1CAiw+ilx6gV2AQjIvZZwouAgcV5N6KoPZ3UCnoOdWXeJRHWEO1tDPmQV3DZ7Q4WbKhW16zkQ4zsFJhNuTB4ux9s/11GPwrB/hTTLZy5L1oWQFUxxiwUP8KzFtYzbgdo6OIyczS7eEtk84HOFG8ZeE+f8xrgnpv6FWE9qb7C4+IOS/WOtkbs1jTT1JHcoh0o+uG4Jum5kGYOij/KHypX10NoWSMyZJ3RAsLUiJ7EPjooBDJFCOTvQWEhwgAArqHvJOb68E4c/8LldnvgwQj6veONx6aBNHG7N1NGM6kxI7vkI1P5rBbmnNl0VTs8XA+dqj5dT+zuxDyOiPAHTb/QMvnGYEddxRS09XwffMSCvGD1rW7RqwCLNDNVh7wONCA9u/TjjR2ngkRym64
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:08.5779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0021aba5-4385-4a33-1dce-08df395d8e07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

This series prepares Realm guest IOMMU and DMA subsystems for devices that
are present but not yet inside the Realm trust boundary.

Inside a confidential guest, we expect that all the iommus are going to be
T=1 aware; there seems to be no interest in supporting IOMMUs that handle
T=0 only. This means they only work on devices that have been put into the
run state and issue T=1 transactions.

Today an iommu driver assumes it translates for every device behind it: it
probes the device, takes a translating default domain, and puts the DMA API
on its page tables. That assumption is wrong for T=0 devices, whose DMA the
hypervisor translates instead, so the mappings made by the guest are never
consulted and the device silently stops working.

To solve this problem, make TDISP T=0 the default for devices associated
with a confidential IOMMU. The tdisp_t1 flag records the future T=1 state.

While T=0, the device remains outside the Realm trust boundary. Its DMA is
translated by the host or hypervisor:

    [device: T=0] ===> [hypervisor] ===> [memory]
        |
        +-- (guest association) --> [confidential IOMMU: blocking DMA]

         Legend: ===> DMA path; --> guest topology and control

After reaching T=1, the device is inside the Realm trust boundary. Its DMA
may use the guest VSMMU after RMM binds the device to its virtual stream:

    [device] ===> [VSMMU: S1] ===> [RMM/PSMMU: S2 + DPT] ===> [memory]

As part 1 of Realm VSMMU support, implement enough core infrastructure to
manage a confidential vIOMMU:
 - Detect and mark it as confidential in the core iommu structures
 - Support devices in T=0 mode by keeping the DMA API in direct mode. The
   iommu is up and running, but parks such a device in its blocking domain
   and translates for nothing, as the core takes over what the device still
   needs, which today is ATS
 - Keep it parked: refuse a translating domain by every route in, whether
   through the default domain, sysfs, group attach or replace, or PASID

Part 1 only adds the helpers required for T=0 setup and teardown. It does
not add iommu_tdisp_enter_t1() until part 2 has a transition to perform.

Then implement SMMUv3 support:
 - Let a CPU-integrated IOMMU declare that its DMA can reach private
   memory, so coherent allocations and streaming mappings avoid the SWIOTLB
   shared pool
 - Identify a T=1 VSMMU using trusted RSI because firmware does not
   distinguish it from a normal T=0 SMMU
 - Validate the firmware MMIO range against RSI before activating the VSMMU
   and allocating its queues and tables from private memory

The series is on github:
https://github.com/nicolinc/iommufd/commits/smmuv3_realm_guest_p1-v2

Changelog
v2:
 * Rebase on v7.4-rc1
 * Drop Assisted-by tags
 * Drop Aneesh's firmware patch that was merged
 * Skip Tegra CMDQV implementation in the realm world
 * Use arm_smccc_1_2_smc() to zero inputs as RMM spec demands
 * Add missing iommu_using_t0_stream() check in iommu_dma_prepare_msi()
v1:
 https://lore.kernel.org/all/cover.1789010941.git.nicolinc@nvidia.com/

Future work
===========

Part 2 will add the T=1 transition after validation through:

  - TSM, whose guest-side interface remains under discussion
  - RMM, using the Arm-specific RSI VDEV command

For a multi-device IOMMU group, the first device accepted into T=1 claims
the group. Part 2 will reject T=1 for every other member.

The current RSI binding validation returns one VSID, so part 2 must reject
a firmware specification containing multiple SIDs upon the T=1 transition.

Nicolin Chen (7):
  firmware: arm_rmm: Add VSMMU commands and fields
  dma-mapping: Let a device declare that it reaches private memory
  dma-mapping: Keep DMA memory private for capable devices
  iommu: Let a driver mark an IOMMU as confidential
  iommu: Introduce TDISP T=0 state for confidential IOMMUs
  iommu: Park TDISP T=0 devices in the blocking domain
  iommu/arm-smmu-v3: Probe a guest-level Realm VSMMU via RSI commands

 drivers/iommu/Makefile                      |  3 +
 drivers/iommu/iommu-priv.h                  | 19 +++++
 include/linux/arm-rsi-cmds.h                | 29 +++++++
 include/linux/arm-smccc-rsi.h               | 20 +++++
 include/linux/device.h                      |  4 +
 include/linux/dma-direct.h                  |  7 +-
 include/linux/dma-mapping.h                 |  4 +
 include/linux/iommu.h                       | 14 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 64 ++++++++++++++-
 drivers/iommu/iommu-cc.c                    | 57 +++++++++++++
 drivers/iommu/iommu.c                       | 91 +++++++++++++++++++--
 kernel/dma/direct.c                         | 16 ++--
 kernel/dma/mapping.c                        | 23 +++++-
 kernel/dma/swiotlb.c                        |  2 +-
 14 files changed, 335 insertions(+), 18 deletions(-)
 create mode 100644 drivers/iommu/iommu-cc.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

