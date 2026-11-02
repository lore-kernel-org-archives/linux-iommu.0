Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596789;
	b=IZVYdTTrmDNBpW8sNhzjPKVlhI6JG3fcNKFB5W+8I6PJRdnMCXO17LhaL2XYbfpTQGCT
	 Nq1N7t7owJn2pTF8iAtqLmVGp+ov8sVf/A3k1U9q6x7p9Lc0e3kCMkujOZrcUtJT1rwDU
	 1wukEjOqdAiNnFC8Xrz8zkzolg/uCBJQyIxiBWidJ5Jd5J8II17zaAqe2ozvV8qOKKMaO
	 jm87gobhxVOAIpxS/9CBjdxT3++2sV0JVf4MJ+ZSDDQqOTOz+IAjlL2eCx9QkcDC+EJG7
	 rkFYlhtAMVfWPIQoXZmi7PkL4urWVgA8l1f45AruOJab4kcSWhrkuumQBsW64fCuwVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596789;
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
	bh=GxgfM8y0jfesB6+9YgOAxMBVm/EVkTY73vdAnMeDp8M=;
	b=zIrIQSy7X8N3UB80X6hUlh0bO8S3cvsXgPT1BDlKtSNE72YtxWYxde5GYf0TpU54ff9O
	 45XSuUy3QQB+UaGZ38V0xmfNkcU1rAiknxGQaFYp8t+4FT7JDpEQrSHmj6qW5tfSB0TNa
	 QX0bxF+ushzmVDQowOug8Lo8bW81gLz5l/xSsZp/eX0zqDetGHVlmi/QzoN09Hl9bQS67
	 c+jeGq5plWnAYM9y1XMIwhhW6u4NJ/4JLd+8fTxegnTrvlrTniZnO96ylrGo6H4hZhjgH
	 hDH+uDPaAtSrV+xLyqWrtOU5ot4RC+PjNBRG51Ch6JJtmMVSmQ8RzpKm5EBNLPev/sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iGxBFluX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB82606A338
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB82606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iGxBFluX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvkba8FRF2i15JJNPmmEiBuEUK+66X9+jLel7uK97msFbxjRdy0mXKb57djDSRkqfSXAIPJ0Dk72RD2WzvXyIHo+bUHkLvZK3X0OU8Fhqlfe3CHHwxzcpqVYrkKCmMpqYuPvrHe0jgMCcoCJ0KbAfLoDcFyXTbaO/AWTWHO7Z+U2zS8/7ZzNLLFoipSwxMvz2rDwEAWxzGjbhaJAwzdEJYEse5rcHRuoBL3CiUT8+QMT3TwBZ54iCsZFwSxSvXb/FBwXBiwFsfrCbYQbnL81sfgUdWL3sTtbOtLzd+1ycOSZ6ImOs8P+WpETYxfsQKgw+fT416raN419aXKVR1BCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxgfM8y0jfesB6+9YgOAxMBVm/EVkTY73vdAnMeDp8M=;
 b=AsEDy7ocnz1rW/3Wz5wsq+dnNpQL62HtVu7chMNatI47NOVTi/rQpS77bthrJ3g8R9xEB5cNuRSXp7UZayh5b852Uv+WLHMVHt+KxooXpclyYjJm5++JndlWbyP9Dxm+SKKNMkMiye1ArnzvakQhZ9qIsLZY2NOLV8JdGwjsHN8Myo59o1J6tvkYkOD9irHogXphnE6Y0feSffhbS2X7QDlOp1XBsZ8E3CKixQqoqd5w3StMCZmYFH9gzIGyyyHm4gxQxH+cZGVkTSfb85YpvriUqPvsNZ1anGQ1OMXpHbUYJtPKShA9LZfX9dGKCjYuMhg8pZe87QTLWq8abxkGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxgfM8y0jfesB6+9YgOAxMBVm/EVkTY73vdAnMeDp8M=;
 b=iGxBFluXIswWQgp5eY6gevnIlbIGMWP8/1r3TWoQLZE+qx6TXahT1MfUQpB/QkjPHgtNcWPOnbQ4jE1TiRQVZlHoHzUs54K3KRXmnndWAThZMZwz6qjhPWiqv3ATXEEI7DYmWtOsLY07Z53HFISVzMvNKv/FJK4kEfEEzMQQ7En5HC1V1nvGxjUb7raOS+jEOaiJmv8aYUL6FHcsqKLs/NZN6H12UuMKA9exKHdAacVQRWzliETEXGqZPkvG8U0Ajg2KlaCi/MBPHtj7AFTwKydklIlmxs4LnDZKqx08Hmb3cR9XrjV5C9u119+h7IHAD4C/BnOF/JUV7ydNHlP0iA==
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:40 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::7f) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 05:19:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 00/12] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Sun, 1 Nov 2026 21:19:08 -0800
Message-ID: <cover.1793593923.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cef4036-2c4a-48bf-103c-08df38a0e52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|5023799004|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	m6SXz90pyzWTsNnxmGBlThdtjlMLeG5WAjISyUTsQIeRPzYYGPdFPScZuw1G7UUtHvGPJvepbmdjRx+Ya5lmjOB9KcjYTtXU8ne1We7Euvj9oMBjFXNCB4nyTCkWAkzW0W4w5cCiR6RofgQo+NZ9/zPhXFCZdrIp0KA+kc/p6MMv0PhhGNJ2ezEF1po3kHN0f6pRCNZTtWLAanqRVXDgLsBYqBHsYlu0uYUDL38I0MO38jZ9QKirk21747Wou0vr9sM80A7wqpAGPMfNWTfdteAse+bMxYg59m8GVBNTT5WbltAiqGIXoB/qyZNCXpXldumqh48yLuj+Mf2Aa0NPsSNtUqOvs23/cys9j8/3gPHt8j2+2HRHvodYeKtEMshEs+pHMrbtOK1rxVlohXaisQZd5WwsMXeNNOPAKBsOjCOT/UFsLjVBpWRM7eKGDwJO5V7UzkGtenbDe+egJqw0QCMzhQVcutq4cWJxcahIk7fIhzxZQlx4p/Olyl2xSmeB7YMs+pjI9OZmwtxYJgwi/W0kP3/EOHIzkpgxLc1OOwJTAOxzT641uGilDfjf0YmVb2xMyXskZYyEigmlq9LVJ71ICXEkgEVgFLIzg+efzIJDkBTtEqGuB6cY6eD0+4JVsbL3RCicSenHYPMbaJdHTWbaeRnva8glzdPjszJsQFSrcOyjogHYYW4Cje9NrhNtrFaeELfSMJVeds1GjzK/+Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(5023799004)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8vbznQIllEWUfsJnOl5eD7B5uNkWBrNr1jvMGd+eV7yZ04NdJ2n0WfFjZ1xaVzl9WYsPtAV5NZzTSjWwzL4uCSoBlGScki8pUM8OzS1rnxU5qfx2OdPS8mXxsCe4uLd8Zz8dI4j6D0Fd2BaY2h+MXvXxFC5QflyyEVoCPONrqx/gwR8smLdRHG9RUfByUX8JmXfkY9DelJuFu5OUeTfPUOsedjEGOIH6V+7xBpCKXBVe1iAoHKKAC8RPVJOwViLFoTv8hx3u7BAOJZQQbv8qsJ/Hh2uWMKmViXxt7TUv3bIS0GcOuxy6QUvLFx9fYQiASWDM/jbs2/8kM+q3My7Ryl9K2qn9AOkRo22c/yv7WVRhwHK9pzDNkI5SriuuQARDZjP7minOWrNdwhDfdg7jBoYo8CwszvcTnFdpqdP6BKm3WKwQCo8fKEb6YRx0tqTy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:40.0402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cef4036-2c4a-48bf-103c-08df38a0e52d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
flight DMA using the crashed kernel's page tables until the endpoint device
drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

In this series:
 - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
 - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
 - Skip EVENTQ/PRIQ setup including interrupts and their handlers
 - Memremap the crashed kernel's stream tables into the kdump kernel [*]
 - Reserve the crashed kernel's in-use ASIDs and VMIDs, preventing any TLB
   aliasing with the kdump kernel's own domains
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.
Most of the new code is in arm-smmu-v3-kexec.c. A hidden ARM_SMMU_V3_KEXEC
config symbol (def_bool CRASH_DUMP) controls its build.

The common helpers parse and walk the crashed kernel's stream/CD tables and
reserve its in-use IDs. The kdump code is guarded by CONFIG_CRASH_DUMP. The
helpers can also support the proposed SMMUv3 Live Update work:
https://lore.kernel.org/all/20260929071950.2710070-1-praan@google.com/

[*] For verification reasons, this series only fixes coherent SMMUs.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that this series is no longer treated as a bug fix, since it has grown
fairly big and most of the kdump code now resides in a separate C file. For
folks interested in back-porting the change: a v6.12+ kernel (since commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg"))
would be still compatible with this series.

Patches here are assisted by LLM. v7.4-rc1 removed the requirement for the
per-patch tag. So, adding a side note here.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v12

Changelog
v12
 * Rebase on v7.4-rc1
 * Add Tested-by from Shuai
 * Drop "Assisted-by: LLM" tags
 * Add Reviewed-by from Jason and Mostafa
 * Add a core patch to fix old_domain for attach_deferred
 * Check IDR0.ST_LVL before adopting a 2-level stream table
 * Look up MSI index instead of swapping EVTQ/GERROR indexes
 * Reuse the L1 descriptor check for the deferred L2 adoption
v11
 https://lore.kernel.org/linux-iommu/cover.1791226953.git.nicolinc@nvidia.com/
 * Rebase on arm/smmu/updates branch
 * Add Tested-by from Breno and Cristian
 * Add Reviewed/Acked-by from Jason and Kiryl
 * Update commit messages and Assisted-by tags
 * New prep patch: swap EVTQ/GERROR MSI indexes
 * Skip EVTQ's CFG0 write and vector allocation
 * Merge arm-smmu-v3-kdump code into arm-smmu-v3-kexec
 * Fold patches accordingly as static functions require callers
v10
 https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/
 * Rebase on v7.3-rc1
 * Bound the 2-level entry count before the shift
 * Drop the vmid_map devres action that landed upstream
 * Validate the CD table base alignments during the scan
 * New prep patch: make the ASID space per SMMU instance
 * Gate the EVTQ/PRIQ on feature bits, so kdump skips both entirely
v9
 https://lore.kernel.org/all/cover.1784663183.git.nicolinc@nvidia.com/
 * Reject valid CD L1 descriptors carrying a null L2 pointer
 * Move the ida devres prep before the stream table adoption
 * Reject a 2-level CD table on hardware without FEAT_2_LVL_CDTAB
 * Cap the linear table log2size by sid_bits on 2-level capable HW
 * Add a hidden ARM_SMMU_V3_KEXEC config for Live Update to extend
 * Factor the table walkers and ID reservation into arm-smmu-v3-kexec.c
v8
 https://lore.kernel.org/all/cover.1783729633.git.nicolinc@nvidia.com/
 * Move the kdump code into a new arm-smmu-v3-kdump.c
 * Move the EVTQ/PRIQ patches to the front of the series
 * Prefix "kdump: " to prints via dev_fmt in the new file
 * Add a prep patch destroying the vmid_map ida via devres
 * Reject valid-span L1 descriptors with a null L2 pointer
 * Document notes/limitations at the top of arm-smmu-v3-kdump.c
 * Rename arm_smmu_kdump_adopt_l2_strtab() to a deferred variant
 * Add a new patch reserving the crashed kernel's ASIDs and VMIDs
 * Make arm_smmu_get_step_for_sid() a static inline in the header
 * Validate alignments of the adopted stream table base addresses
 * Retarget to the merge window; drop the Fixes and Cc-stable tags
 * Rename the kdump probe function to arm_smmu_device_kdump_probe()
 * Document that a disabled event queue discards new events silently
 * Add a common arm_smmu_is_attach_deferred() calling a kdump helper
 * Document that acking SFM_ERR is defined but does not exit the SFM
 * Document that CR0 queue enables can be cleared while SMMUEN is set
 * Clear only the CR0 queue enables in kdump reset, keeping other fields
v7
 https://lore.kernel.org/all/cover.1782799827.git.nicolinc@nvidia.com/
 * Rebase v7.2-rc1
 * Add Reviewed-by from Pranjal
 * Reword the linear stream table adoption comment
 * Use dev_dbg for the stream table adoption message
 * Document why the lazy L2 adoption uses devm_memremap()
 * Drop redundant FEAT_COHERENCY checks in the adopt functions
 * Use feature bit instead of STRTAB_BASE_CFG in adopt cleanup
 * Skip CR0_ATSCHK update in adopt mode to retain the crashed policy
 * Restore FEAT_2_LVL_STRTAB if the cleanup action fails to register
v6
 https://lore.kernel.org/all/cover.1779265413.git.nicolinc@nvidia.com/
 * Rebase v7.1-rc3
 * Add Reviewed-by from Jason
 * Replace dma_addr_t with phys_addr_t
 * Drop arm_smmu_kdump_phys_is_corrupted()
 * Skip threaded IRQ handlers for EVTQ and PRIQ
 * Bypass arm_smmu_rmr_install_bypass_ste() in kdump case
 * Drop devm_ for adopt-time allocations; set up cleanup function via
   devm_add_action_or_reset()
v5
 https://lore.kernel.org/all/cover.1778416609.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Kevin
 * Drop READ_ONCE on lazy-attach L1 read
 * Split "Skip EVTQ/PRIQ setup" into two patches
 * Tighten kdump probe comment and dev_warn message
 * Use MEM + BUSY in arm_smmu_kdump_phys_is_corrupted
v4
 https://lore.kernel.org/all/cover.1777446969.git.nicolinc@nvidia.com/
 * Rebase v7.1-rc1
 * s/arm_smmu_adopt/arm_smmu_kdump_adopt
 * Revert alloc/memremap/fmt on fallback
 * Reorder patches to avoid bisect regression
 * Use IRQ_NONE for spurious evtq/priq entries
 * Cap linear log2size by kdump's allocation bound
 * Defer clearing FEAT_2_LVL_STRTAB on linear adopt
 * Add arm_smmu_kdump_phys_is_corrupted() validation
 * Defer l2 stream table memremap till master inserts
 * Re-validate L1 desc on master insert with READ_ONCE
v3
 https://lore.kernel.org/all/cover.1777150307.git.nicolinc@nvidia.com/
 * s/OPT_KDUMP/OPT_KDUMP_ADOPT
 * Do not adopt if GERROR_SFM_ERR
 * Retain CR0_ATSCHK beside CR0_SMMUEN
 * Clear latched GERROR bits (e.g. CMDQ_ERR)
 * Assert ARM_SMMU_FEAT_COHERENCY in adopt functions
 * Add STE.Cfg check in arm_smmu_is_attach_deferred()
 * Fix validations on return codes from devm_memremap()
 * Sanitize crashed kernel register values in adopt functions
 * Drop unnecessary l2ptrs guard in arm_smmu_is_attach_deferred()
 * Don't enable PRIQ/EVTQ irqs and guard the irq functions for combined
   irq cases
v2
 https://lore.kernel.org/all/cover.1776286352.git.nicolinc@nvidia.com/
 * Add warning in non-coherent SMMU cases
 * Keep eventq/priq disabled vs. enabling-and-disabling-later
 * Check KDUMP option in the beginning of arm_smmu_device_reset()
 * Validate STRTAB format matches HW capability instead of forcing flags
v1:
 https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/

Nicolin Chen (12):
  iommu: Pass in NULL old_domain when attaching a deferred device
  iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
  iommu/arm-smmu-v3: Make the ASID space per SMMU instance
  iommu/arm-smmu-v3: Pack the MSI vectors of the used sources
  iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for the event queue
  iommu/arm-smmu-v3: Disable the EVTQ and the PRIQ in a kdump kernel
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
  iommu/arm-smmu-v3-kexec: Reserve crashed kernel's ASIDs and VMIDs
  iommu/arm-smmu-v3-kexec: Implement is_attach_deferred()
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/Kconfig                     |   3 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  61 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 735 ++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 287 +++++--
 drivers/iommu/iommu.c                         |   9 +-
 7 files changed, 1011 insertions(+), 91 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

