Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596800;
	b=ezUqvHstn3vvWw6s18Fg976j2nfzbjYKT46Qtkqwe4UmAx5swGb2S1IdFtVe+pioSNJP
	 hL77xNAaNKLTnCct6ZTbeXq2HXe+VCRxt8HGdlBHOAJLmPhWiU20/9AAoqXVhVndiJ38A
	 fBBsfrea3oLXbGabS7/qIj/3dSmvuEeSEWT/AF2vD2M/ZBAH/v7bT+4PSva8alSkWFcTk
	 C7IbakKk/cCkXyxkGUV/6BmRj+SHDtHD6zqc3RRtM6QCx+qM3+JmIZRuLKkw3OrmkB7Zm
	 6PMUpw/kR9Obs2uJC8pThFQTomqu1OeOyDH3x2feunVCxL55ue0ONOYOOawEGHEOzyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596800;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LBG5s1VSKYzqXWiNc+3c1gkT3N0GiOH23m3IubHkj38=;
	b=kdxD7RQzCZTFdyfEDuxM2qCOZrRezzXjt1ZcKrwJYsBPxkzNO8LeSK6d+ipItZlsh8xl
	 GrNd1Ptn1UtmBj47dd148nTyRvoEabYEdAKYqpWI5tWgMlh8xTRzDKhqo4PiytqhAPrwj
	 XfsaGCGk2enU6cGy1oLQPa6ildYxTky3vAx8NRCCfxe/HaZZcws1uF9qZd2ZMvVNEjQ7d
	 EbuQQxHA4kH5bkKiPPVxMunMkWW7VJTmz2Mn/Ppl6Q0VtbWyHGxsSJ4MKt7ZTNMORTLSD
	 AuztvgmTQajFkRJ+VAb07kfu84HT83tP7Ev+3TXK0AqJvDnkMHLz4JIhQyQbUmLbZsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="p/BIbOQx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AA606A32C
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4AA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p/BIbOQx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3gWi6sup31lMpgEINpW+g3yzikuypwJ94hp+9jFhdZRKhAnt6nvqDGSa5N3oI8vPu04/aXpUxi1mll65n0eZrEv0edk6RNpm3koGAQLuXH8+TH3t7qeQnVnhGCwyUgJ00/c+mGbr/d+6jhgLXtoJu8pUtn/RexVR8lLYgOuH5v05ltJ2rcWXOsI57eqdyHtYVV5QLugqXjzVtdMgfl/7w+uONh9oB+dpWTpmTgqHh/OQyVFN3WiaCgxvyN+ZBtyAWlFcWnIEwsTFt4bUp6+nyM0nDTyrOBABTOO1nRT4jKiWxTTGdiVcTZEpg6t8eut1rs53oqzRfDXWqpq+Fz2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBG5s1VSKYzqXWiNc+3c1gkT3N0GiOH23m3IubHkj38=;
 b=EnrJIe5iABDcCfqdeG9b5Obywhm+z6L0Ou6w8P+YFPfykm016PPv81/dQcXN9dvKYxH1dTjayrPIdco2/IrCEOb11nDoVljBN8qmb4Bt22jyKz3F3UV6A4Vulxf6/D5qMZg0vg3c5TvaGIN3+QpSmna7mvm+JXOnFqXAeuEEXxY3cKBvB/91n+qfDne0+F0afcfyD3/vQ7aXZLBJHftY89QP9k2k2VBHvVpeOFb1c1+3pk6e0W/2zDcw+pGD02q+Ye0sgut6a9qHtgFU8Cm4RAaVnr10VtJpvYH6cEDygTxhBsCYhkbKMQREG610SvMEevl486vKkuVhxZloJVgd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBG5s1VSKYzqXWiNc+3c1gkT3N0GiOH23m3IubHkj38=;
 b=p/BIbOQxJv5NlX9Y6J8ltIcTjtiPNTTTVv2BY7/droIDqnGtWCFqp2/Fjtj0T9jyfrHbSS8kxw+/FPOFIRWzdAjTVwhwii7QVVvOT0E9AEeF+2rgRW9Pw4z6EB4QLcvYbnMRvAu/koHezV4/rl/O5pNBIbjcSfAzy/fpcUoKyKs3ba66BVT7b1HNIeZOv1y9B9pBTojRGQytqg2oaqsckaN53UJ3NO+u/OwboTTTFfN/ypfRD71ktW5dC1hW8iYaX+elO3XWkbK2WtOvv/jjD7v/XV1+DqkGyPF3GVo9CT1/l85sKxduznpoY/E/Of7OAvXys6deFZ1JO+l4FN8NhA==
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:52 +0000
Received: from BY1PEPF00026964.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::5c) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 05:19:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026964.mail.protection.outlook.com (10.167.244.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 07/12] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Date: Sun, 1 Nov 2026 21:19:15 -0800
Message-ID: <80c5c0b0805609138d6ed85126f11c8b5689a257.1793593923.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793593923.git.nicolinc@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026964:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: bc34a24f-e278-4379-0f62-08df38a0ebe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261022113327099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|5023799004|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	iSSgeGSjuh54SIl0fyO599aSp+oC+l5JhJjTTVNKgUwAbOBAlaix+VbOf3Ymk3ygItJSLJVDZI2RHRBoZo73GIAbFmbZRI2uoKN6TeshIjdSy3g+zkNoXI1yOXObX5UqtwIqXvKUPMhDxwkS6wTpMi/B9A68X1kTUsPAlPNWvRF9ugQ0cMfloGmfodUPodB4QlujrAdTIUkYRqrHPhzPSnTcKfXOLcKo7Sl/NBbdE9iWkzzG+fSabIv1/p2UVS/UisavnM6LKoZUOeUkvyi8ogK0JVJTFWHKEjfbiLCVYNPNYBP/bO8mj/I+4chB18Cld8mWNGiIzsURpCUKWQWWRmpk7AcHBPiqkPgPi54DgNelzRqiubfTIhPU9ZTsoh1F/FXTSunjJRPPBqOyqQ2yap7Umdc5JvGvii1EShoM4xU3NS+uBW6UEGjlDWNpH+8yw/R4ttigSA+O05zMbBYF65KOTXtGq08ebpzHdVoE2+BcjLeZ6ZgspOv1FYLQcW3LcxzSze4X/VcepZo6iQitH+mhlatrryxT+ixyVB2zR4V2ELgzAQ752W2W6v6MWs5qmGi70IUYJAwX1KbsR084T0QFMDThGADaEqtRsp5+AZqQJRLLPDmiY6MjmCsKATzER4WKqfFYphlyJZeQkW3YwavBX3ZP/yUE2m17L/49XIVppeRoCMe2ku8nakagCvm0QAXVFWQOXZPVouaaMipFtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022113327099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(5023799004)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5cwdEwPt7t6bsPH3nvGKUa1PKK+64T//ZR6p5Diq+g3sdBmmtPSni7r5EvjWCySdRupPw4+R/J/fM1fSC2YLKvlhf0aNu+zkiWG1c8Rvoq6wr2cevafqdZa1tQGVTR7K+b/oHIpBHSGLLEO+GPieCEio6TsM/AKMrmv3dJ9vJRWBaTjwncuGyKGMPipHKlEMD0x6rZnJ6inEhmQ2QBEVKkOokn21nqDrRgSZmTsQ++iNP+gYuYFIHd9yHNNl1xP5tCvTyUIwV92aXf9W+97q9NOOA49WqzKj5RwXpb7apl/wdsrXhhST99dsD/GjsLkVQd9lwMoDAOL0fpj6fjvtrexTTZP78e5KZTPOXTTgL1hyh/BbbbgRAs/InT0uzMDQL6xfqyNwPtHnCNVST/JzKxR3Murot4Znt3UN7fdADehKp/oQtMpeAGhwBWL+qFSj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:51.3075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc34a24f-e278-4379-0f62-08df38a0ebe8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026964.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
in-flight DMAs reusing the crashed kernel's page tables until the endpoint
device drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adoption functions that memremap the
stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
some basic validations against the values read from the registers. If tests
fail, it means the stream table cannot be trusted, so toss it entirely. To
avoid OOM due to a potentially corrupted stream table, the memremap for l2
tables is done lazily on the kdump kernel's demand.

The new option will be set in a following change, once the device reset and
the RMR setup are reworked not to overwrite the adopted stream table, and
the crashed kernel's in-use ASIDs and VMIDs are reserved.

Keep all kdump functions and kexec helpers in a new arm-smmu-v3-kexec file,
which will be shared with the liveupdate series in the future.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |   3 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 387 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  21 +-
 5 files changed, 430 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89deea..9a7bebe16f395 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -109,6 +109,9 @@ config ARM_SMMU_V3_IOMMUFD
 
 	  Say Y here if you are doing development and testing on this feature.
 
+config ARM_SMMU_V3_KEXEC
+	def_bool CRASH_DUMP
+
 config ARM_SMMU_V3_KUNIT_TEST
 	tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66bb..89a27de8dd2f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index aef12d8de9f05..2bc774cfdf77b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -993,6 +993,7 @@ struct arm_smmu_device {
  * invalidated CONT
  */
 #define ARM_SMMU_OPT_FULL_CONT_RANGE_INV (1 << 6)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 7)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1321,6 +1322,26 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 }
 #endif /* CONFIG_TEGRA241_CMDQV */
 
+#ifdef CONFIG_CRASH_DUMP
+int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
+int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
+					    u32 sid, phys_addr_t base, u32 span,
+					    struct arm_smmu_strtab_l2 **l2table);
+#else /* CONFIG_CRASH_DUMP */
+static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+					phys_addr_t base, u32 span,
+					struct arm_smmu_strtab_l2 **l2table)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 struct arm_vsmmu {
 	struct iommufd_viommu core;
 	struct arm_smmu_device *smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
new file mode 100644
index 0000000000000..b15728b5b5b53
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#define dev_fmt(fmt) "kexec: " fmt
+
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "arm-smmu-v3.h"
+
+/*
+ * Common helpers for a kexec'd kernel to parse, validate, and walk through the
+ * previous kernel's SMMU table structures, shared by the kdump adoption and a
+ * future live-update restoration.
+ *
+ * The common helpers are read-only against the previous kernel's structures: a
+ * table that is not yet mapped by this kernel gets a transient memremap during
+ * a walk, followed by an immediate memunmap. They never allocate memory or take
+ * ownership of the previous kernel's tables; the callers make those decisions.
+ */
+
+/**
+ * arm_smmu_kexec_parse_strtab_2lvl() - Validate a 2-level stream table
+ * @smmu: SMMU device of this kernel
+ * @cfg_reg: STRTAB_BASE_CFG register value set by the previous kernel
+ * @base: stream table base address extracted from the STRTAB_BASE register
+ * @num_l1_ents: pointer to return the number of L1 entries
+ *
+ * Validate the 2-level stream table geometry in @cfg_reg and @base's alignment
+ * against this kernel's hardware limits.
+ *
+ * Return: 0 on success with @num_l1_ents set, or -EINVAL on a bad geometry
+ */
+static int arm_smmu_kexec_parse_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, phys_addr_t base,
+					    u32 *num_l1_ents)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	u32 num_ents;
+	size_t size;
+
+	if (log2size < split || log2size > smmu->sid_bits) {
+		dev_err(smmu->dev, "log2size %u out of range [%u, %u]\n",
+			log2size, split, smmu->sid_bits);
+		return -EINVAL;
+	}
+	if (split != STRTAB_SPLIT) {
+		dev_err(smmu->dev,
+			"unsupported STRTAB_SPLIT %u (expected %u)\n", split,
+			STRTAB_SPLIT);
+		return -EINVAL;
+	}
+
+	/*
+	 * Bound the entry count before the shift, as a log2size wider than what
+	 * this kernel itself supports would overflow it.
+	 */
+	if (log2size - split > ilog2(STRTAB_MAX_L1_ENTRIES)) {
+		dev_err(smmu->dev, "l1 entries 2^%u exceeds max %u\n",
+			log2size - split, STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	num_ents = 1U << (log2size - split);
+
+	size = num_ents * sizeof(struct arm_smmu_strtab_l1);
+	/*
+	 * According to spec (6.3.24), HW aligns the base down to the L1 table
+	 * size, i.e. min 64 bytes, so an unaligned base would make this kernel
+	 * read another table.
+	 */
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned l1 stream table base %pa\n",
+			&base);
+		return -EINVAL;
+	}
+
+	*num_l1_ents = num_ents;
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_parse_strtab_linear() - Validate a linear stream table
+ * @smmu: SMMU device of this kernel
+ * @cfg_reg: STRTAB_BASE_CFG register value set by the previous kernel
+ * @base: stream table base address extracted from the STRTAB_BASE register
+ * @num_ents: pointer to return the number of STEs
+ *
+ * Validate the linear stream table geometry in @cfg_reg and @base's alignment
+ * against this kernel's own limits.
+ *
+ * Return: 0 on success with @num_ents set, or -EINVAL on a bad geometry
+ */
+static int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, phys_addr_t base,
+					      u32 *num_ents)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	unsigned int max_log2size = smmu->sid_bits;
+	size_t size;
+
+	/* Cap the size at what this kernel itself would have allocated */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		max_log2size = min_t(
+			unsigned int, max_log2size,
+			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES));
+
+	/* num_ents is limited to a u32, so cap log2size at 31 */
+	max_log2size = min(max_log2size, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "unsupported log2size %u (> %u)\n", log2size,
+			max_log2size);
+		return -EINVAL;
+	}
+
+	size = (1U << log2size) * sizeof(struct arm_smmu_ste);
+	/*
+	 * According to spec (6.3.24), HW aligns the base down to the table size
+	 * and ignores the low bits, so an unaligned base would make this kernel
+	 * read a different table.
+	 */
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
+		return -EINVAL;
+	}
+
+	*num_ents = 1U << log2size;
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_check_strtab_l1_desc() - Check one stream table L1 descriptor
+ * @smmu: SMMU device of this kernel
+ * @base: L2 table address from the previous kernel's L1 descriptor
+ * @span: span field from the same L1 descriptor
+ * @idx: index of the L1 descriptor, for diagnostics
+ *
+ * Return: 1 if the descriptor is unused, 0 if it is valid, or -EINVAL if it is
+ * malformed
+ */
+static int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
+					       phys_addr_t base, u32 span,
+					       u32 idx)
+{
+	/* L1STD.L2Ptr is invalid */
+	if (!span)
+		return 1;
+
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev, "L1[%u] unsupported span %u (vs %u)\n", idx,
+			span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	/*
+	 * A valid descriptor never carries a null pointer. Also, HW aligns the
+	 * pointer down to the L2 table size, so an unaligned pointer would make
+	 * this kernel read a different table.
+	 */
+	if (!base || !IS_ALIGNED(base, sizeof(struct arm_smmu_strtab_l2))) {
+		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n", idx,
+			&base);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Helper functions of the kdump stream table adoption for ARM SMMUv3
+ *
+ * When the crashed kernel left the SMMU enabled with in-flight DMAs, the kdump
+ * kernel adopts the crashed kernel's stream tables, instead of doing a regular
+ * reset, to keep in-flight DMAs translating until the endpoint device drivers
+ * re-probe and quiesce their devices.
+ *
+ * Note:
+ *  - Adoption only starts on an SMMU that the crashed kernel left enabled, as a
+ *    disabled SMMU (CR0_SMMUEN=0) could hold meaningless register values.
+ *  - Values read from the crashed kernel's registers get structural validation
+ *    only (format, size, span, alignment, and ID range); the physical addresses
+ *    are not vetted, as the kdump kernel has no record of which pages held the
+ *    tables.
+ *  - A structural inconsistency at adoption time tosses the entire adoption and
+ *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
+ *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
+ *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
+ *    rejects that device alone, as its blast radius is bounded to the bus.
+ *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
+ *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
+ *    the real hardware. Callers of these functions are responsible for gating
+ *    ARM_SMMU_FEAT_COHERENCY once during the probe.
+ */
+
+int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
+					    u32 sid, phys_addr_t base, u32 span,
+					    struct arm_smmu_strtab_l2 **l2table)
+{
+	struct arm_smmu_strtab_l2 *table;
+	int ret;
+
+	/*
+	 * Recheck the L1 descriptor in case it has been overwritten since the
+	 * adopt. Reject this master's insert, as a panic or SMMU-disable would
+	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
+	 * would break all other SIDs in the same bus (PCI case). The corruption
+	 * blast radius is already bounded to that bus range.
+	 */
+	ret = arm_smmu_kexec_check_strtab_l1_desc(smmu, base, span,
+						  arm_smmu_strtab_l1_idx(sid));
+	if (ret)
+		return ret;
+
+	/*
+	 * This L2 table is mapped lazily per master; devres frees it at unbind,
+	 * as with the dmam_alloc_coherent() used for a fresh L2.
+	 */
+	table = devm_memremap(smmu->dev, base, sizeof(*table), MEMREMAP_WB);
+	if (IS_ERR(table)) {
+		dev_err(smmu->dev,
+			"failed to adopt l2 stream table for SID %u\n", sid);
+		return PTR_ERR(table);
+	}
+
+	*l2table = table;
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, phys_addr_t base)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_l1_ents;
+	size_t size;
+	int ret, i;
+
+	ret = arm_smmu_kexec_parse_strtab_2lvl(smmu, cfg_reg, base,
+					       &num_l1_ents);
+	if (ret)
+		return ret;
+
+	cfg->l2.num_l1_ents = num_l1_ents;
+
+	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	cfg->l2.l1tab = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->l2.l1tab)
+		return -ENOMEM;
+
+	cfg->l2.l2ptrs =
+		kcalloc(num_l1_ents, sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
+	if (!cfg->l2.l2ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		phys_addr_t l2_base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		ret = arm_smmu_kexec_check_strtab_l1_desc(smmu, l2_base, span,
+							  i);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * If the crashed kernel's l1 descriptors are deeply corrupted,
+		 * blindly memremapping every l2 table here could lead to OOM.
+		 *
+		 * Defer the l2 memremap to arm_smmu_init_l2_strtab(), so peak
+		 * memory is bounded by the kdump kernel's actual demand.
+		 */
+	}
+
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, phys_addr_t base)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_ents;
+	size_t size;
+	int ret;
+
+	ret = arm_smmu_kexec_parse_strtab_linear(smmu, cfg_reg, base,
+						 &num_ents);
+	if (ret)
+		return ret;
+
+	/*
+	 * We might end up with a num_ents != sid_bits, which is fine, since the
+	 * ARM_SMMU_OPT_KDUMP_ADOPT case bypasses arm_smmu_write_strtab().
+	 */
+	cfg->linear.num_ents = num_ents;
+
+	size = num_ents * sizeof(struct arm_smmu_ste);
+	cfg->linear.table = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->linear.table)
+		return -ENOMEM;
+	return 0;
+}
+
+static void arm_smmu_kdump_adopt_cleanup(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		kfree(cfg->l2.l2ptrs);
+		if (cfg->l2.l1tab)
+			memunmap(cfg->l2.l1tab);
+	} else {
+		if (cfg->linear.table)
+			memunmap(cfg->linear.table);
+	}
+}
+
+int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
+	u32 idr0 = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
+	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
+	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
+	int ret;
+
+	dev_dbg(smmu->dev, "attempting to adopt crashed kernel's stream table\n");
+
+	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
+		/*
+		 * Both kernels run on the same hardware, so it's impossible for
+		 * kdump kernel to see the support for linear stream table only.
+		 */
+		if (WARN_ON(FIELD_GET(IDR0_ST_LVL, idr0) != IDR0_ST_LVL_2LVL)) {
+			ret = -EINVAL;
+		} else {
+			smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
+							       base);
+		}
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/*
+		 * The kdump kernel need not match the crashed kernel. An older
+		 * crashed kernel that predates two-level stream table support
+		 * may have used a linear table on 2-level-capable hardware, so
+		 * enforce the same format here to match the adopted table.
+		 */
+		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
+		if (!ret)
+			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+	} else {
+		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err;
+	}
+
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
+				       smmu);
+	/* devm_add_action_or_reset ran the cleanup upon failure */
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	dev_warn(smmu->dev, "falling back to full reset after adoption failed\n");
+	/*
+	 * Undo either adoption's change to FEAT_2_LVL_STRTAB, so that the full
+	 * reset fallback uses the format that this kernel itself would choose.
+	 */
+	if (was_2lvl)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+	else
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
+	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
+	return ret;
+}
+#endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 18ba48464da0b..2c3d0378c39b3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2027,11 +2027,23 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	struct arm_smmu_strtab_l2 **l2table;
+	u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
 
-	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
+	l2table = &cfg->l2.l2ptrs[l1_idx];
 	if (*l2table)
 		return 0;
 
+	/* Deferred adoption of the crashed kernel's L2 table */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[l1_idx].l2ptr);
+		phys_addr_t base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (span)
+			return arm_smmu_kdump_adopt_deferred_l2_strtab(
+				smmu, sid, base, span, l2table);
+	}
+
 	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
 				       &l2ptr_dma, GFP_KERNEL);
 	if (!*l2table) {
@@ -2043,8 +2055,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_initial_stes((*l2table)->stes,
 				   ARRAY_SIZE((*l2table)->stes));
-	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
-				      l2ptr_dma);
+	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
 	return 0;
 }
 
@@ -4862,6 +4873,10 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    !arm_smmu_kdump_adopt_strtab(smmu))
+		return 0;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
-- 
2.43.0

