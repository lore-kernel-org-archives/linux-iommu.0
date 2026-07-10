Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC89443
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657742; cv=fail; b=rcKHXpQUNq2Do948bii2mZAhFS+IqwI9JSR5tJVI9BphpSbWhsZH35n4JVguWzotbI4qCwT+0GPcMV0lalmOxSVMIKaw5waFEob9+8BM3VRfQYPmkOuNIvmZ+NSj/Z9s+scVPie3zqzdWR7kzn/7u8jLP8MNLydmZ4RcHjsPZUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657742; c=relaxed/simple;
	bh=Sxyudc3LxGPgzXUyAcMLxqHH7mAQ/wDFB5HZ/8xwLvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKS3GsOUYaTfpXtqhpp0nYuqp1AquAPufhZVUPvuKTGI2HQI1q4Gm6xlROsoNYSK1uUvtlACHp0HJV4DtVXxQWjST/2KHvMdj6xD0GW5xv2ORmmBCnG5csWZbgigyVsYPKbvAtGC/XlZcMBEV3iUK2EiObxey35w/UuacfwENG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+uASLgL; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+uASLgL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQZ1rHHrrIpKKuJiQOjgbW1tqgEoYx5LUnpjDxmF0ji7K0LyoE8n7dvll/6Xyk624tBqrOOQdvaNps8fQY5tVKaKNxMgMyhJ9uF8mNqHjbBTya9TD+iGSorbwM6m3X8vREqlU6V8iWvtDp8pHqkizfuikf7fhEjMJvJuDav5pJpqOh2I3jwootFiLmULjTtERF7yK+lKTTtafXq3I2ECytrgHn6WSnzQBQKzYr1BOdJc4Snyd26wwiL9eMgsFLQRq5PJqD0qxWLdyODByKzqFQ68K1LLndpGO24tJS/owOmks0MMd86x1thsWN7F8LkJy+IeUQntuzCh8EdkJ55kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u2ElYSauUpMNbKzKFiQDxnwpA61Tu+6qMRfxU58IjA=;
 b=ShhWTt3u8kasotgNLyhQPdR16LI6KRoqJTqoxjTuajJH9egzOU0ra5UQ4pDwS95HNxHdUCRp16ZfBewCwSMDApb7Unf+OPT+KNZhZSmHJ6z082FYxUvuOfzH3Y67vIXf9t1RgXTBsz9mORdF/8LMx6GH4ahEohvrbsU9uG9QGhQiNjToh+uxKF5Y3e8x0tG0uAnV7kJA84/wR5IFnuvE0FTIlwe9axxTB82r136zeBjsU7g9O3j8KtzVI6JDXm7kU1kfcM7ue7QywLQvD6VOn4cI2b4lutBrIXi1tgSXZH+PvwJb0pSmSpwuNzL7ofiizY0mC1J8PPQoQ4Sm7RAOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u2ElYSauUpMNbKzKFiQDxnwpA61Tu+6qMRfxU58IjA=;
 b=t+uASLgL+XZu+9rguNC5gMtSkFu/mM65Q1MfHPducSUb3ym+3zEJUQb1nFEJ8x18e2p4t5T6KmUwr/5a50NwExWqYCrFow+Xwd80QDp/MDWQ48fDLmFztvi5zay4ZrcG36BHN82iECB572Cpcrn+RITt6ly2CGVm2MfWWIRrfpbpJYVS5DpNMkKYfD6lg3dPhgIGruY+MlFF1IqrwRi0E+9k9zYIJvSJpEYzkPl1ZA5a67qK65zsNjufroyb2NbfCEpGUUib1d5Kkl03YypORknRkSKZ/pZUmlFVgS3WYM+JdE9+4gDThs8WEtwqzlVKuEIvjY5mpBdFzp10JvprPw==
Received: from PH7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:510:339::12)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 10 Jul
 2026 04:28:54 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::43) by PH7PR03CA0011.outlook.office365.com
 (2603:10b6:510:339::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 04:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 04:28:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 9 Jul
 2026 21:28:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Jul 2026 21:28:48 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 21:28:47 -0700
Date: Thu, 9 Jul 2026 21:28:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
Message-ID: <alB0/RXGUtoyXggd@nvidia.com>
References: <20260709095613.831769-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709095613.831769-1-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 42da1221-500e-41cb-2d48-08dede3bc02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ag5tMAOuLiwurBFZOqMOJoBCREl2noD825gcfpppaN3QNNVujh4zpDfROny+O/8SKxXcthNTRC3UxXqXNtqvpdGfwfzGqD3Jc1vdILe8FY1agdj3+zo7qx0WyndIZR2s4/+x73h7sgPDogC0bvvhIWAUVcevLIrASQ80etxDD9js5Y2R+X5jo/+ooB51dQPkCq6yX6FmUSTSDu7o9IyeuKe8DFQ25faz5PdTUVQQC+DsbUGpy22z6CrxDMWA42dOC8CgzBxI0pncy9SCTnWIITqd6rtunNQgYTPIIj5RYf7vEbLCN9fj/XkEE4UuWTK8r/1vNoSyNwcbwWJQMO6ldjbo6P5VVl9W3SUQzRZDqPcZtwgnIXCyCoPvinATdVW4D5eOra8mbbN0qBFsa9w83b/BJ6cBO4BrKfG8zdvZlrjYe5PH6zRDCjNj5IbJkacc65IIF1aQdSQqSFjOpnDJwLXTaABkQAIrih6qqxjZFuryrZoNuL59ZyimGoii+3hnhK1gp28UjCyohGUJuu4E9Y90hMjWWc80KUtUwL1keeDkFGR09dDdCAPUlEzdscVQ70wGq0BTIx9esjbcdtj+hCW2/2UCkamBqLakC7wK07bHGKimP4Xy9q7QtAgpWkT1/x/a4a3WdiKoZtVd2KMD+aOwRGpOxbKnKtRsFlTsXWucNr/Dhh5Xt8s8F8Ic7aLEcdx9c8KjgkB7urL+eeC88A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uQvIOysm0jXdbAvTCQe3DCSOUw3jD05e9bvacsxJxw6WSuTgJD30UuPm4tca5C33qZH1yN8B3Rba7K9M741jZbQcYCLNt+PSBOFF+4MZjwJbD/VLThUO/hj8/ehRhDjqE4QL/D+UVa7ZfucE/4nFP1LejPhRNwrxA9ofh/I2u81XcO6WOgW3/jXhyGCq8FFgAtQf/2apGPwLGkzsHfiCQroE3iLDMYizhciq2v+U/nPx+Rtw+qmp+So2M6X1mGhPwoMD3r7/fE5O4YwK4AZvD8WSD/UuxqlG6fK1fVm3VQXKbstjV3WNwihpLbzbl19sMgXMJrf0xqPfhw295RjdVEQQPdd+2NFa/XtjZvr/epmUbhn+Eo7I25fEpfiSqc/dZRDZkkSrxyHLaNm5u8SwM6qTPYXZ8qWTLJ3mLYhOs9PNhEAJYxzWbrT2npx9sUTT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:28:54.0518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42da1221-500e-41cb-2d48-08dede3bc02d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647

On Thu, Jul 09, 2026 at 09:56:07AM +0000, Ashish Mhetre wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
> flushing the current batch with a CMD_SYNC before appending the
> new command:
> 
>   - The batch's pre-assigned cmdq does not support the new command.
>   - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
>     forces a SYNC at one entry before the batch is full.
> 
> Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
> so that adding another force-sync condition becomes a one-line
> addition. No functional change.

Patch is fine, but you're missing the cover-letter and changelogs.

Nicolin
