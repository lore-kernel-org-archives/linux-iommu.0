Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070D39D3FD;
	Thu, 10 Sep 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011262; cv=fail; b=JWNV2uvp4OS55MmFY3kDEvl8v1ezVrgqxsPpy6qLLCujqjeLpmm2hpFP0afpjWIQhN/foHgM2A14CYA0xe/1ARkzFZBPJhcgWzvkk/mjZw9f59yhVtwOsGd3xACoNzygZNogoWFYVZ8OB8YHwjp3qRmfI+UjmCCyl18MafixBHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011262; c=relaxed/simple;
	bh=9X/PapRwZpoPR3V/cF6qxk/b5Z9X/paKwBy3ov0Yv8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bj3WNQldJ7jV/u+OoehWWr2Jdocp+3wByTvccL7vFV/Pq8uArEWguaxqB7kGQZN0rWw6O9qme/1XGk4Gy3v+1pP7qV7PbxJdEiaim65O9nOpnxPt/z0FvEKW3fafzrALoR5/T3rEUp/XD8T6ZjnHNUZabZ0u7r9zi7pptwV+REU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdThOaJ7; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdThOaJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy1mcxE61G6tl4AnaiK3rfYIjPv0vi/Z6rl1b4Ly9NU6M3MuCEeQZH3fuZxzvIbTq83nmWEAFVrzeP54lExP7QwotI0U4D6WF8wbUNaVszjPDCmREQ87AC3Y9tQ5TSMiB/HrZR5oz48FGM4z8Py1PoQVLzAB/3csN6KosYLLZQYjLqr2xb7hVwqiK9vmao1GAh32DMFakNGZO/UJSmlof901KAAoFdVl0gzK1Uc8ZY4aXKeFBU/syfQBRtDmr3wr/rwROgmG+iPKI4oSP5Ncu0qfI3JICZR0Uzk50qECiSp98p1AZEFuf+rXRT4+NsqQXocLs3MuReUEYxkWtYUBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtGtelJAbdbNc9nzl+zRVd6KutyRojRkukHiI5YGsKw=;
 b=nUWME080Je8hK5Jsu29X7ZPZ6k6gD3q1l0G2ru1aCqJ569W1yReWo4Jdz5sco4NL3VsMzYBhHqqIaF1c9T0omdGgOUu/6KL3iQ4DzVTs18Y0hsClcPJ5YNd3WTNy66+AZKzSjqkAXns445klqJmWKKb/ZCAdR8OdwBDtEtTw7qxVWtECT5ZESTVYuDp/HzZQEadZbMLA2pnMXVDKbHd3zNKR6/F0IX89fQtY1vwXmsyDA93m24yFt9Dmh1F/SG6u3ZUZ4o8GG4EEWwq6V6westsdwaQjd+stUbCE/FHg96rbH0srnRJ4MRe/ICi4u+B313kPHxpABYqDnDW3UE9WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtGtelJAbdbNc9nzl+zRVd6KutyRojRkukHiI5YGsKw=;
 b=fdThOaJ7M50hi/qiVSDP6X7mOrF+pYoRNfVzPYDRhM76jaxho5rsod4e8NKcfjEwdzQwOAbysy3zv7kT29YocTjL2wi9W0pVq90JRSOCj6dcfoJTjYMdQn0IZO96bfg++FWqqH1Bivedf/pWeKwnqFYNxeryeAHzhDPw+fZqpKh6BzssRTZNXEUkfxF2FoFYRh3d77D5RGBqtegbi/9+DYyU2FCo8H6cXrShr6y3J+BUG2hd4J/aSqw5HO8tkuT0SXZ0L6YmnK9Wy31HOT3EM7o1i8haaMBPambiyxqB7K7o0MVA2wjzf5Ntb2rYSDd50LlQhKiVbYRPwMQ5KTKj6w==
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 03:34:03 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::31) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Thu, 10
 Sep 2026 03:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:33:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:33:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:33:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [PATCH v1 0/8] iommu/arm-smmu-v3: Support guest-level Realm VSMMU (Part-1)
Date: Wed, 9 Sep 2026 20:32:43 -0700
Message-ID: <cover.1789010941.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4591ba-c0fb-4e17-f3ba-08df0eec5c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|10067099003|6133799003|3023799007|20052099010|18002099003|56012099006|5023799004|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	s3dHaMH9Ym13PqZxt6pzIa7JLw9wzZdrPyP1bucDoqJBJOJ/kNZroqc4Ym3s/dPIbXzaxRypad4GifkF8RBJbaAPPR2GzEmN8KWsIUSPtGbBFSgYhFR0IKS0M+3xxwD4Ie28WmpsAhIpR8PpqlZHsrlA4FP4cFUAjp9w0TmdLIpfNVvsDpzeQwi3dz21jxYOsnuDrVTu+iqnwzxF5iLcymXyKtTmzfrjtjhfugJEE7Z3j/AL+1Pij8ZHsJhpIEMmbvxWG/fqUtgA/BYs5n3HfIZkOgRXsDTBwXPjahF0nU0eMHnK+39cEVRI/ZgvftB5a4FybBJ+IEYnXaC0LmOYOW0QR8g4cUzPWtEQSJWO3kmDQVBagAh1cWrlyA2GNB4ApTwFvsFCgH+ElMS8VR+TJ0lnnX8RUr5IxS1vMsvEWUPqnkm7r41qYudfZ9wzlWrprCNp9pBdycBaOGIlt9mqmNBJJOZdQ2S5cPYqYExvpGUYYHf67bPLLYdgzxIEZQihlqwE6WWlXqzrDgUXdAcPK289C6HVo5yVDvAEv7dfgTcvdc9o+pl2UVGcNieM5p9A+LDRVodexEf68hMUqpdor+jwbRc7J6YVp7059TqOdAywl3lAzax3DH1XZ+ilhx3BfFry4CYLNekalCxgzhyTXmOzJByB3LTsJw/Ahk5ITZgXbxTq62J+i0dlZTTkUXvf8r9p5y/PUBV0MD4oAY2bLw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(3023799007)(20052099010)(18002099003)(56012099006)(5023799004)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FRdtTU2xduUh6ACaIAxfMHP+F8Ee2jEXC2cyK+cAfsl/gnMfIB1VSyqPh/HU8zPtOxkdq+EyQ00EzqdFtsouSG1CMtsD/VCauT51L0VWTUZDSKdY5W7FnjcKWb8TGyCqgeaGbGrRzNTwWDbV02Hh2IRjWBPqv9yzKWU1mXWAoSQzlOPMYBcCvwRRFEjtCUXRMwJpGZFcvy5DXzx9ZqYdVqaFZdmI6LCt7SYc64yjfNdOdaFbgYrGDBMfEAr/ax2jZTGko2+7KTYeYF/9jPHmLr8vsq7J9nAcelq3xBHXU+hrCVPu1PA2OMC+Dc6+rOuf5N5xb4WnL0AAkyf6riv7REq9wgZaaFr2XK6013XEZAr9mOUfpMmF7RYQWfwosAlxlqHYxceQC6sibobZxzvLP8yjVhkKRzwaKin3r2rf1lw4K7b4fQh2CJjp7+ZnLpOX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:03.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4591ba-c0fb-4e17-f3ba-08df0eec5c40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

[ PATCH-1 in this series is a provisional cherry-pick from Aneesh's series
  that moves the RSI layer out of arch/arm64, per Will's request. I added
  it here to base the entire series on a public commit ID so that Sashiko
  can start its job. So, I kept it as-is mostly, with Jason's review tag. ]

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
https://github.com/nicolinc/iommufd/commits/smmuv3_realm_guest_p1-v1

Future work
===========

Part 2 will add the T=1 transition after validation through:

  - TSM, whose guest-side interface remains under discussion
  - RMM, using the Arm-specific RSI VDEV command

For a multi-device IOMMU group, the first device accepted into T=1 claims
the group. Part 2 will reject T=1 for every other member.

The current RSI binding validation returns one VSID, so part 2 must reject
a firmware specification containing multiple SIDs upon the T=1 transition.

Aneesh Kumar K.V (Arm) (1):
  firmware: arm_rmm: Move RSI support out of arch/arm64

Nicolin Chen (7):
  firmware: arm_rmm: Add VSMMU commands and fields
  dma-mapping: Let a device declare that it reaches private memory
  dma-mapping: Keep DMA memory private for capable devices
  iommu: Let a driver mark an IOMMU as confidential
  iommu: Introduce TDISP T=0 state for confidential IOMMUs
  iommu: Park TDISP T=0 devices in the blocking domain
  iommu/arm-smmu-v3: Probe a guest-level Realm VSMMU via RSI commands

 arch/arm64/Kconfig                            |  1 +
 drivers/firmware/Kconfig                      |  1 +
 drivers/firmware/arm_rmm/Kconfig              | 18 ++++
 drivers/virt/coco/arm-cca-guest/Kconfig       |  2 +-
 arch/arm64/kernel/Makefile                    |  2 +-
 drivers/firmware/Makefile                     |  1 +
 drivers/firmware/arm_rmm/Makefile             |  2 +
 drivers/iommu/Makefile                        |  3 +
 arch/arm64/include/asm/io.h                   |  2 +-
 arch/arm64/include/asm/mem_encrypt.h          |  2 +-
 arch/arm64/include/asm/pgtable-prot.h         |  2 +-
 arch/arm64/include/asm/rsi.h                  | 70 -------------
 drivers/iommu/iommu-priv.h                    | 19 ++++
 .../linux/arm-rsi-cmds.h                      | 99 ++++++++++++++++++-
 .../linux/arm-smccc-rsi.h                     | 26 ++++-
 include/linux/device.h                        |  4 +
 include/linux/dma-direct.h                    |  7 +-
 include/linux/dma-mapping.h                   |  4 +
 include/linux/iommu.h                         | 14 +++
 arch/arm64/kernel/setup.c                     |  2 +-
 arch/arm64/mm/init.c                          |  3 +-
 .../kernel => drivers/firmware/arm_rmm}/rsi.c |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 55 +++++++++++
 drivers/iommu/iommu-cc.c                      | 57 +++++++++++
 drivers/iommu/iommu.c                         | 86 +++++++++++++++-
 .../virt/coco/arm-cca-guest/arm-cca-guest.c   |  5 +-
 kernel/dma/direct.c                           | 16 +--
 kernel/dma/mapping.c                          | 23 ++++-
 kernel/dma/swiotlb.c                          |  2 +-
 29 files changed, 427 insertions(+), 103 deletions(-)
 create mode 100644 drivers/firmware/arm_rmm/Kconfig
 create mode 100644 drivers/firmware/arm_rmm/Makefile
 delete mode 100644 arch/arm64/include/asm/rsi.h
 rename arch/arm64/include/asm/rsi_cmds.h => include/linux/arm-rsi-cmds.h (64%)
 rename arch/arm64/include/asm/rsi_smc.h => include/linux/arm-smccc-rsi.h (90%)
 rename {arch/arm64/kernel => drivers/firmware/arm_rmm}/rsi.c (99%)
 create mode 100644 drivers/iommu/iommu-cc.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

