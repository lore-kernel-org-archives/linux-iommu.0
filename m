Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F02C3255
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133505; cv=fail; b=Fhldqwb9ZaaQZWAKY8/gRdU7J2nnr9nIZea7zfZfvxqGr9GPbIo0N0z8hoK69fjVQu/xiSQ1XvH6nDXAD/ujx7uucGRPpcSLjugSybZ7xGXUNHMDm37tfrQQoFfWeVnzxgnfIGEiFS8BGKmhRmffVmCccuJie6OB9fVqc+gfJ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133505; c=relaxed/simple;
	bh=T8LhyZMoVaB47eOZBUSri4E6lQtSo5rG/TYYVFI2d+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8znlocXS8yqkqoZhmd6l3MF4MKa7e8oT+J8QCnwYMhUnaObC8FxTYXuDtJe1TwSpZz0ATwcEJXaDL0pyAyBQrdRhC0+ArZmC3ZFH+coU5JGDip98uAByzZDItUgCszAta3RilC3yHbXStp2ZHr7QAGUDtEx9xgaPoXPke4E3do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WB5aI7IW; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WB5aI7IW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIfVA6OwwaxIvt2rhuze8YZkHPRo/rqjcphPUpS/zm2O+a7HyP6U55zeHIAAtrST3W5vSdPn7GJhaGQhqoyn8mlHS8g+3qGtyCwy1mc8tc6AUP40ZE7MmLN8SHivyHbyyx8h2Rd3272EqqkflE7Ar0RhoOW/0J9Drl4ncyKOf8oUgzK17iYPYNwx+FLZ3PFwBqCEOhbspumjKT72OHSF2xYHuut5qtCxS0Tw6tmM7Y1xAxp31b7vz0o4dFBZiOcuO5H6P397ailZXDmLnTJ8DJh81AcwvgiGn8H7zXGp6hq7RiafHh7nOu/eLL4JhfsBZ4y2J+9efMySVwrdBGUtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/no5EvcFgM/2w7sdeL6Ig5Tk4flc6agoNbLe5VZ8WiM=;
 b=XedaIyogVxTCUXR2oMaA9BkjYDEsi3VkjlQihMRucoc6c2UpfMMy+N2dGSIvMk7wz23HgwLAkeg2JdnmxG3XpIsOYgbnH2RoWu5DV3UWrFltyMf3chblHCIi5GRdJ5KFi6Lfm76pBoqgTGRdYCC2jRHsWjyBTkupiTPuwaJs5zQjOrC1uWJLYjF7leLwdlDJ+iU+LPnnuVLii5GUbFG3v0BQnXq9TMI8d0EcFRgkV2DJCb2c1/tvEXMtthaVti7oHeJThMwZG/S1iWI6FTo4iTlggoSAsWdC80QDFSICVesVJycAU3Pzl1lX0UL5xFXfV9E6x3vmOQkxa0GiopoAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/no5EvcFgM/2w7sdeL6Ig5Tk4flc6agoNbLe5VZ8WiM=;
 b=WB5aI7IWzb9BOIBnFKbABPSjic4ZIOdt0+IwRghduAtPM8Zz8P/tfBhOnSobsAJknEIwBThCvefoEAUhIsIKbCupLOX2Jli8/FKWsDQ0AFFZOUyAXoD7a/B3SmcBD5PnVwc3lcD+WT/JkpIEsRzi9qg0ykQbbnuOuRJ5RnI59urrOeXUn2JzM0ICc61M0+N5nPCHz/TI5cD6S3F1BGLESz5Zxlnzz8ts/jUcw51IyrOBuuGuvFbR91AyP5ZWXe+o5CJXtE84suXaIzfHxpAgKtfED/ozhDHk32G19wgctZTpZoXGQ+3da6KDZ7JhnHRKwNbapnibct63h7FwWU67cA==
Received: from CH0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::27)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 22:51:38 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::e3) by CH0P221CA0001.outlook.office365.com
 (2603:10b6:610:11c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend
 Transport; Sat, 21 Mar 2026 22:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 22:51:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Mar
 2026 15:51:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 21 Mar 2026 15:51:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 21 Mar 2026 15:51:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Do not continue in __arm_smmu_domain_inv_range()
Date: Sat, 21 Mar 2026 15:50:40 -0700
Message-ID: <20260321225041.11090-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321225041.11090-1-nicolinc@nvidia.com>
References: <20260321225041.11090-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: c250e136-dc1c-436d-015c-08de879c6992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|3613699012|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	g0uV3v1+cnKCbFz0siYoiGxzFvqjg+xVVRGP9ObjCqwsm8+J0oWmFsQSwTSIC4rldRCdMbT8tAn/GkTqWudmp+yLW53f9Fw3n6WfOVVHHQmArq+y/lThHGsorYsPnyEy3i/+Ik4WTIsvK8o+GsH5To49ICrycr1bBNKQxGmte/XQwouvqBUFWv+rmupVgdXRw/MRUkVd8Pt4ztjrVAx20NnZGl8dJK9PBC1MfZmfLaFDl831wnsJ/OYe1WrKIBt7uw0n1lVjWQYSnKJxxpwbYZLdZ4cLqIEGpi9sUht6EsbZLJLayjNHH+nhJ6+5DAtkyXYk8swc/4Z62/CP4xN6Bp+o6HMKLNT4WTzD35WlHhNOW+Ko7xZBQnTyVwG80cxCtZ8OEE1x6b/qxvXslEuyn1+y9NMaVk6sMBZErobC5YAAqbxHIRdVErfMmKa5LqpQ+VldOwQep/FQOXnEwzXZ1cfu1scl8pcZrODptW3qbdysyX2jKi2J4s58yO62sW/P9VsTfte1YfU4bJfWZ+Rqh5887AlbsUBwMylu1gN+ielM2UImsRM9WzcSIRON5nk2rBXtUNaH97f3baubQbaDPApv1R5E8Nrr7YT1Gp/h4tei61nvrjeitPFlqWq/+flB7V0SoNgfwMqD0niuJfO75f+LOD2WDyFIj2EGOGOZqNOWbIkYwGGojtojTK20/XsW0vBfvvbi23cViLK82SjAvNU26qQZ6M3SwnMS/88TsAy6gZPJHdRYTMeqrpLZeX/tCAQpSIAJ39BWWb8niyW1QWCS2HdCdQgXloAG0Wu/sd+kAx2kt2s2cSwi4ZFIBN6r9kyxevr6o8Wt1sQS4T11Pw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(3613699012)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ls37PX90UTN6NRgxNn0zIWgF1T+WAnQ6Dw3RWhyNDLpTwR7VV3//qtSMbF2Yh7kbUxHo+uhjmvtVajncnzkaBwksQBapMoT9ykZljpG2rNlGlgkBGhTBcP5vb0D7tbsm62R+BnRkmaFnnlRw+rOzNwf8NopPfTpRX8vHupKOxekbJR6Pa9T4cHNoy6C3wvO5t45RGLXIOKfhP1uGXFOUulpM6WliwnbdMNdakDqbSl2hG77GRSi9Plxn+fr9o2xGQttQqPus+OrlFqMkoEzIUPFRto/9u8YifS0e0BS2hDfV/yIOTbBywmlCHXPN7QkKyxYWdFWrJa9F+5oeYm5RWUgBGQELVbLQN+UmqBvhlMU1Oypc2/us1vYESQbGTNRljdIP1jerM9B0TSZ6Un4EbKOqdWsV3mNfCiaW9oikSSFBez9EvfEXF6Y18kUj7UMl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 22:51:38.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c250e136-dc1c-436d-015c-08de879c6992
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

The loop in the __arm_smmu_domain_inv_range() is a while loop, not a for
loop. So, using "continue" is wrong that would fail to move the needle.

Meanwhile, though the current command is skipped, the batch still has to
go through arm_smmu_invs_end_batch() to be issued accordingly.

Thus, use "break" to fix the issue.

Fixes: 587bb3e56a2c ("iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 01030ffd2fe23..c3c6987da9506 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2688,7 +2688,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		case INV_TYPE_S2_VMID_S1_CLEAR:
 			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
 			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
-				continue;
+				break;
 			cmd.tlbi.vmid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 			break;
@@ -2704,7 +2704,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 			break;
 		default:
 			WARN_ON_ONCE(1);
-			continue;
+			break;
 		}
 
 		/* Skip any trash entry in-between */
-- 
2.43.0

