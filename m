Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F2261B9F;
	Fri, 17 Oct 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731942; cv=fail; b=WmXyhhEedrp0mgFwa0wKtAvqUif8bBBt64+Hr1pl9nMhrITDEyTVJtDafDKZrlMrfGrYzEyJi293i1+OoP7a4aVFCa72lU/ebeHvyHuk0a3ZTTMVveq12KSGvX5mmk3PDenKGThSttb23qSV6jria+G6s/YFeY57t3E48lT3Pro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731942; c=relaxed/simple;
	bh=YGqwRnPXXkBDQdm2W+vKCZrg8OEGl68m5NXePWtpKSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiM0yH7nP9JbtnRVSiIqJB6iY/i9wLehEcYmVfYZZy/bTfoHKo3gDF7OfAmV6fm4wiqx12FI47t6JzI6xM7LvfODOAI9Ui6XFwWPoXc4/PSKCreGJnqqNZ5YP6PxOj8hSXfKDGl5hpazQX2I+RYF5lRxSeJEkdFfVMVm641iGno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LUiqEcl7; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LUiqEcl7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH1savcuk+thmgrwrdWbAGW+ifX/bS36j+VUDZ1DMRlOBkLLYeTed0ay3zz/3mcN9oRKKv81ClOQPh9UwzkSpDaXswFdF/5aYbnxjQxHnvKQP6Sc36MFsYrOdqr5TfQheHFp3RVhas2gmOQyLkhrX1R+tssiFiELndeUwPbSK6B45WkQXQK7nmU8kE8fTmxPwFF+ZCwtIXSmEezTYi5FVpduepSnf+yd2fDBeIZs5Xt29Kcu1JyE3Z6+qr8E2/MAvLg5+hl/6jhfX23KBCeLGHKQoyjGukGIg8ASlnhNAWkLhfngKAGLt8QkPmdkhxXf1V4r60aC6M6/Q7f0DWH34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77crYBTpyQpWVi9KV8oYHSGXMPQcPlgTIH2r+NN3ORw=;
 b=HL7jJ44XVtl07R9vRvPvY0YW6drxkJFd5/ue8wvomAq9UJazDxZmQJBcgjO/qFT2UGa8x4Z1pCTlmLMzCwNyV2aruSd4udRcBApQjy/DT450ODhGpCvasrTFRKVIY4yPAl3YF88Wkjq38u5/nqH7A/Rye1Az0+I6S8Hq05qxE0zBX5b4HYPNem41M8z2ksaoFdyQ8kelLvmHdkSpyxYnb865QwdwA4fXtMF6kuWNqwRLsNUN/M6iqzQ2wdI6/5kCGHVc7177oD0k++Z8c5KqVeUIGtVx2nhOfWD5AJgDflFuYp0229X0BJgQw4UkdwzB/LHn1NmU4inAsgZaLspBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77crYBTpyQpWVi9KV8oYHSGXMPQcPlgTIH2r+NN3ORw=;
 b=LUiqEcl7guW098Ag1v04mK4XXqmkUE/E+5WImfEOvS4iFdqPSX1egc9YSRn504kmOluk6gWZI+Z3ALDaz4BeDGRPIhwlDLM58X3gfY2vehvZYG2LNBfs8EPTm/1DBa2M5b/nTD1jcNRB41CSxrKGDaeDy+7vcH+PS9Ow0CqLIL+D1e6Tv53qhx8ttVaTMn9dbex+x6pUa26YqDtEJA9lZe7XFNffdkAAYB7LP7PmyC6PCers/cgsORoMqU2JoFqG5noa8Kz3mP04kiwY2PmIk57yH9VboeAmATaMm+ExC0axnCt/5Fz6W36XqAOetXv3YyIxPdCYLMEqdEl30mXESA==
Received: from CH0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:610:e5::24)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 20:12:18 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::d) by CH0PR03CA0259.outlook.office365.com
 (2603:10b6:610:e5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 20:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 20:12:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 17 Oct
 2025 13:12:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 13:12:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 13:12:03 -0700
Date: Fri, 17 Oct 2025 13:12:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: kernel test robot <lkp@intel.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <oe-kbuild-all@lists.linux.dev>,
	<jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aPKjEvxCJoRhzU7K@Asurada-Nvidia>
References: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
 <202510172156.WHU485ad-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202510172156.WHU485ad-lkp@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c04a5b-3e78-421e-ac3e-08de0db97892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSUbwoXwsoIf15yj7yzHHZX7UJwkLuA17+Dsr4YwZUP+7dWsUpI6a3l++aBU?=
 =?us-ascii?Q?2cDvsUn90Dag9OXKbeXplnel8hTYcMHGqCD2GvQby3HrW6Ou4XgwKT2+F4+Q?=
 =?us-ascii?Q?ej+phtEssFCehLzo5MmF4zTU0hr9cKZlHy6EMxaWXD27Fat2s+h2fG0VjmB9?=
 =?us-ascii?Q?etDABlRwkgH4SEpPggwq2ivR67gTn6SpHWW1atg58fMAglHIba3bcIeN6VeI?=
 =?us-ascii?Q?pQhTechXcJNwOJVJZNEddS0aqp6TiBT9+oUUjw72kIr4ZD7Rqpwu/FvkH6dU?=
 =?us-ascii?Q?w1ISgZbaVPExEirQCMI0gTG53nwgvFUloaQlJOJBcXqRl0QCVYx6t/1o+FXz?=
 =?us-ascii?Q?lNbkHGR0vNRU40g7U/E3TJ6Any1INoZQMyAfhIwyuHA3ExKuDt/XojlhFBC8?=
 =?us-ascii?Q?aI+XyTdyicKexz5aauMEdSIIYO/SQz9bpMpmMy/9h0A/wYVN0/Dp2Yqi6YpR?=
 =?us-ascii?Q?pZOHuUimnl02X8iDOq7RjMWRe0j+NA8CtyMY0RfwUUPeylO+OcNNFviT2khe?=
 =?us-ascii?Q?6jcHri9ZbUitX79x1ZP4bOnjR1/f1Hgs+d3Q1xAzmOTIQyWk/VoYpRvg7vVZ?=
 =?us-ascii?Q?z55JpDV2LdOwpN+962+mAj2TgNhS3AdQtxKGQXGHJz7XdwrjNCVLzezzpPmi?=
 =?us-ascii?Q?hIFSX5TUZYOMLC9MvHEV1k1CDDHovocWO+DLQdRSIx4142xglTpt//gUS20s?=
 =?us-ascii?Q?pT9hmK+l/d9Ql9eIo6niBwLS2FsUJKiEwLrGhyahr6A88CQ61fs3WEHDaoWQ?=
 =?us-ascii?Q?3Dc4V/T++qUY9C6baQ2JUiw49Bw4hTmI1dapFjZxv6TkM6GpqsE6+xdsvrfp?=
 =?us-ascii?Q?b8lCE8mVUhM69hWnTkMnZMs6ZDp7uGTxcOoKf4RDqaVtqz/SbdmtO+aqLoe7?=
 =?us-ascii?Q?YyVqr1ZdvjXIrHF3iLn4SUsj+8eKgQ9OS1B62//d/EYLDqpM8j4kljxlFr9z?=
 =?us-ascii?Q?PxW9vsOFNllpumhLjf2tlaJkcSRrU1p4BTkvQJe8cW0A/QHYSonMbMditED0?=
 =?us-ascii?Q?E4/iAH9pxojKg93z1KMwqe5PKrN+/U0o2xG9CnKFcSgRBViVVnFZ+FCa2S8R?=
 =?us-ascii?Q?5mskVj6+/rPOvulp9J81tAXHCgc77zGOeCt2200nAtV8Egd/A0TVswdrUyc+?=
 =?us-ascii?Q?y/zqJ2MVlABX3JOZjwcFxwTrqyd5O36b1GKZ/GKccj9/cpsxHlAIr/ApbEpb?=
 =?us-ascii?Q?mBQcCKKv7eD89eElrIA0rVBf4UawdahUqmp5p/MkQ8Wnt8VGnvxKPt4dAHbw?=
 =?us-ascii?Q?b0iVsEyGsawJiIdtB528kxLN6WHANtjSG1RtkD874JRpgEsRAKPrkSs0wvIj?=
 =?us-ascii?Q?ltjHWcZS3gbKrDSEi/FGKIsBrQZUunye9fOcFKnA1R3q4BmH0w/YWaHHbnio?=
 =?us-ascii?Q?EO8yvJK0tG9wjgtshl359EYVkn/q74Mc0Sb6iXyrpioUCzmmq9exXHYAdHaG?=
 =?us-ascii?Q?foiUL7e3ivkCrBtcDBIKGxdtYIQ3HZQHCduSdOenExaE7+sojHg7A6y4Czz2?=
 =?us-ascii?Q?J9pYlnHhJtzm6F6zEIPNmTLfoqAowU/mZwbfdszvPFKe6+wiCWMRNGWa+jlZ?=
 =?us-ascii?Q?fH+EaOcSFJvXCV2m2Sc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:12:17.4574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c04a5b-3e78-421e-ac3e-08de0db97892
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

On Fri, Oct 17, 2025 at 09:47:07PM +0800, kernel test robot wrote:
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c: note: in included file:
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     expected struct callback_head *head
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     got struct callback_head [noderef] __rcu *
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: cast removes address space '__rcu' of expression
...
>   1045	
>   1046	static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
>   1047	{
> > 1048		kfree_rcu(smmu_domain->invs, rcu);

Looks like it should be:
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
-       kfree_rcu(smmu_domain->invs, rcu);
+       struct arm_smmu_invs *invs = rcu_dereference(smmu_domain->invs);
+
+       kfree_rcu(invs, rcu);
        kfree(smmu_domain);
 }

Will fix.

Thanks
Nicolin
