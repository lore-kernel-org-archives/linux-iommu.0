Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343854;
	b=1HNgbpW8O3IDuOaCB+o4ZWgki9EsbIhZWbKVJqOjxcTn3hdjiVNEdympT5jzVKMza9KG
	 rcwKaYURFyfuoYZR0T8+C4s1a6CFIDE1C1hkky3+n0yBja/YYeLoNqn0jTKe0OFkBbey/
	 BoZCM8iMu9lM3W2IEJMDjojxR8pOW0HUqF4Mg/yIoAhK7hqPgEqHG9TGAcys1QY7pq5RT
	 8Ub4vKRlbSgwNR6qvO/vvpudScK1FnM1G0jqSAubaix5WkdNWRZRr1Vb6PwuKe+IL+7T6
	 f0idcoQIM5aWPgF4BwU6TXmCrX/nhyn1hu7xGQdfkDS/Vij7zpQaanC1/gMgs2IITpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343854;
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
	bh=FRTFWeewDBgH1eurIj8ck+ao1ks94VquPEB7S3gWvR8=;
	b=KDJnmmfQuf3eIwcnthQEx9SIDhLCXEvsBiWPPTTzn7vZgzfU+Dii+hPZAXE2Ehdmr9vh
	 vkwQa+fU3To6ksdkVcUWiy7VMy6LklnLsFMgnloh47uiu4JbpwQriKZ2UFfPmg/yHVQ6N
	 urjJF0sTyZc5f6VaICrRD+HXkHCg+mHI5KTwhjPtEFEZBi+aeb0f+/XdfZPxA1AuK82bA
	 QgX7oQcJUZv5JGBvNBRRsnpYhigFF1UPdAsR/tlXtMuxNDcUHTF/DLeX4PZ9TNucQYNRF
	 MBznqLFxE4vGfogUJ+TsG+nZCHs/ZzSZOJOpbZV3SvvWiObGOOreX8Lu690JaGASi8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=szVa7WTi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.30
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA32606A325;
	Tue, 10 Nov 2026 20:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA32606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=szVa7WTi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMEeMUK9c/+N1kuEUOj9S64tat4IowXV0HfFK5EN4BG4ZU8Lu5G98rAji90fq8ulsDdi97GVDyL+DCBNDhYkyZ1IUuWvsV+N6q0a45QLNUfy4i0Ap5F4FFBzGSg21FBbOC585o6aV6jxdVCHKHH5+mN5QZ1oT+cH/i0sHJfGoQks7SEX2hcAARvFPhuGz61RxisfDMirkwjvVCPRtzTeRz3R1wT6z+lXbqAUI2nK3WFmPXnIZlhXdaeJpUJU0Lg5uXtrRvpLvB98F7y7Ni3UT+vTytl9jkZM2P+DNNxoI40vW077eAbuVWdqHcxOdUPlEHRg0R+bzzkMVkqShEGzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRTFWeewDBgH1eurIj8ck+ao1ks94VquPEB7S3gWvR8=;
 b=l0J+6oiQvuXRRHxl7lk1GTvZSiCppi5A48LRilGVLBX5rnzxx4/V99QN/POx6H647W1lvxlWJA4yFSSYZ4POVYb+zXDFCtekH2NAznQRFe7UqZU/plMRMUihbL4UPOX5Yjy4ref5ebqrXgLSk8mwIBWDPx07BEDRY7eH/O2btcacQEYCsB25KcEMkEFTkXjU/j4T6ow1+TkToZ6ZChxRkpOSy6dO4+0wXDU4xQ/f9dmpo7kzcTgONMcX+RKM5qLf3VUs6Z+4s+Zl3B6B0HpSXRBH8Rs3fwAKi6HqOvBO2pUahaevzwpCjvarZSvawpGKprU9m/avXup6+5Npb3FNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRTFWeewDBgH1eurIj8ck+ao1ks94VquPEB7S3gWvR8=;
 b=szVa7WTigvpQAreY10gzxc7e4L6CF2vL8LxaMa7zl+ucr815R8whTzNSh6Fls+45Y5kXiBATk+0pz4BHfTPxutNm67Q5ztLMnX6OfSl/VVVoBPpJC4hX8DRhtD/GTYdXIxbMRhYydnbX4ZcO1dnbjphw11KRwOXJTVFvDa3ksDE1FPfo4Q8MS+TzYSXaVWq//JE8Sb1uFDB+XvGG+RFBNOKKykq6A/aO4xNhQd48gal841XtUbCGP6cCW8b6Fmecv3QPHhrnyrkdrGmMkV4Bcx/Ui/qxSoJUPFWTy792dvV01l9wqoq2Kj8FwDu/KVsh3HD3LtBZg03R7BowPr1Ggw==
Received: from PH8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:2cd::10)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:50:46 +0000
Received: from PH4PEPF0000B60A.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::99) by PH8PR07CA0021.outlook.office365.com
 (2603:10b6:510:2cd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B60A.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 10 Nov 2026 20:50:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:25 -0800
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
Subject: [PATCH v3 0/7] iommu/arm-smmu-v3: Support guest-level Realm VSMMU (Part-1)
Date: Tue, 10 Nov 2026 12:50:05 -0800
Message-ID: <cover.1794343501.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60A:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: b29b4554-1676-4256-5681-08df3f6c4ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|260925021311599003|260925022911599003|260925021911599003|11063799006|5023799004|261021135927099003|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261102123227099003|10067099003|20052099010|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1LcXFv0Zbfl3LP2qGKxjTObm3UuhwSn/lEeJ5W71Li438xnCmvb/nue19whS/j8sZnb0yfLdOXW21RXHRu1moxdk61cnMMTAhc8EuVT03UEEi+rX2P8ThtfYaC2tnx8Q4PJb7SS6G8zvyDJEfE8BwPwe4BdVz+lk7j1qUrbxSB1m2Gch9ETcZqcv3oYsr9UglthJL7CnBsZzEu5/vcoqLYalBkuHWRUphW/bpt2nJjMvxYASwho4ghk+HX3JThyGvpCYyY3USMi25DQIkbgRI7vrJpcvPvmBEPc9AtrAIlRXDA/XJkW5RqJ+iDTjNJ4hfrKNULDA5u4PlC1gu2wLzlQNM7il45oPHlwx0R+7zZu13ipDI6UMtvcvUtrJ9jOIAJ3bsARyTTKyS4yiqVSl9r8wqzm/zCAdWN9rItauDUUt2fnHmb4l0kA5xt/rO+f8kFN0cBhmxDUk8+4flOos0utO51m9ouVyB1vTjlD1h+XEg3HPqi7ondevWOZy13Hi/YIueHISt8uRqgK3bvegskLX+R0QNiKdjZ9mk+sb2MXF8OSMmIuo0YLZHNQXA2U9aVSe0P0XobGlZZjYHvoU460P4HkGtbxU0gg412PaYR3BLxMek9BMbwqaeMq6SH/LOiX1FwBOvF5vj8pADedn56fMmYy334s3433hIxlHu9eNTCn/1Ayh2GmyoA7tGTwQLrFvBVr2QyOtGEwr17jnQw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(5023799004)(261021135927099003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261102123227099003)(10067099003)(20052099010)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KLcO59aIWJKjxhPAa2efyRjYuywI1e8GeXTCUFXE6uH++MMA5pWTpyrVilMXisz1mOHfRR18aZ/BbPmUB/Kgjuctqci1qX1uBPPClY1nOsq8+jtXYXlQ9IT4YbpId1+c9OhDa2Xu6vuYO4cqpliuwYB/7gs6XqHT0kktW5+U1AZmvBEFZ78gGYzCeyx2HrU2vbcYd/vP2rzpP5AKlB7rNEUWYPeJcbrb9YZ1EFBG8XYjpoW84IIIXuR/m1RUSgm1v1HHqgBnlRIJBps0kb7lA0f+rSetx8i4DP8koUh4ww7e+za96AzJBfpKMH4X9oRIE7sMy82RHXbMh7AIGXx1JzqnuMgBjWlRSoAxxW09Zfn42gXeA+SmnS2Oign81jr7qjD1y3JmHOjGtzQYBHEfvuEFnBnCNVflXCAZURbZ2JzcVM3biAdH5ggW4hVDl3rn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:45.3822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29b4554-1676-4256-5681-08df3f6c4ad9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837

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
https://github.com/nicolinc/iommufd/commits/smmuv3_realm_guest_p1-v3

Changelog
v3:
 * Add Acked-by from Marek
 * Disable and enable ATS for T=0 devices across a PCI reset
 * Rename dma_require_decrypted() to dma_require_unencrypted()
 * Explain the minimum STU used to enable ATS while TDISP is T=0
v2:
 https://lore.kernel.org/all/cover.1793676742.git.nicolinc@nvidia.com/
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

 drivers/iommu/Makefile                      |   3 +
 drivers/iommu/iommu-priv.h                  |  19 ++++
 include/linux/arm-rsi-cmds.h                |  29 ++++++
 include/linux/arm-smccc-rsi.h               |  20 ++++
 include/linux/device.h                      |   4 +
 include/linux/dma-direct.h                  |   7 +-
 include/linux/dma-mapping.h                 |   4 +
 include/linux/iommu.h                       |  14 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  64 +++++++++++-
 drivers/iommu/iommu-cc.c                    |  63 ++++++++++++
 drivers/iommu/iommu.c                       | 104 +++++++++++++++++++-
 kernel/dma/direct.c                         |  21 ++--
 kernel/dma/mapping.c                        |  23 ++++-
 kernel/dma/swiotlb.c                        |   2 +-
 14 files changed, 357 insertions(+), 20 deletions(-)
 create mode 100644 drivers/iommu/iommu-cc.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

