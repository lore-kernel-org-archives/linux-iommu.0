Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67726B973
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994455; cv=fail; b=nP01PMR54tb6XRbe6viuLCpxSSAOMBpubX5yN7W4NymnpT6U+lQB/lDB9nKvdqDWkptyvIgg86t0efBw52s51uff5CpVwSpoi4Y06BjeE7t4v3c2PHOpEw6wGt1KEMrEXDHJqr1tMJM2OcL2Sve/1XAS89nX0Hebd+wKb45Gjs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994455; c=relaxed/simple;
	bh=WBoqD0QACgIOZqGCl/dL0y/skt+zjZ/A7XNAnZx5Bt4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiswBezSLfAllLdXCM8plLeZIyKA+Oh3CW2KndftNNuJwL+l8oXVRDKNpX0nWJ813DOdnbpQmdw3ilJil6FtvmsTdLkyFWIXTPXrBqc6x0SOU0RnuDpxs43G/cUCyaIHMG0ArqnqrSffKRLw3mYDjl4kGVRFgXWzOymrTrUggF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VyAoRvU0; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VyAoRvU0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDa3wm7PWL07ya0/jkTBdMDPEdugUAcFhcM6YNMitrG5cZpEths3FGTg6xKcgmVGXJznoM0MQPlKa6W02CCxW9jH1Gx8LbkFVZlMYjM4ohLU1zjU4qdkaBA0EHcLij7i7/9VU3edFWDO1ImNhb+BCMxdTaFOEtIikDL7dmfkxHw1hKqYE3CMLAyDdH9aizUsOVdFYH5MwoQsyv+5Ix5RaPAFrHUrJ3FRrr1E7N4u+gzt+UdiN+uurDascgF5aGMotnntrUPRfB9xF1tnM0FUV8I9ZX9k+J8XRMUrLwJ87JdfSBwVVOQ35eKc+RSrQPJTA0rsPfyJaIlL9md5sftEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hLNyO1bqDGOGV20/0yRxrLNEmB7HFf9ACWIq7dIA2E=;
 b=IS9nLlrNBl+sytIDbfoGg7RogDhNYvpTfZef8O0r1OnQFO6IAFdXgUZe9LCKRmNdS1yXydkMbTXqpcGtXosakLZYelUG9LESEAvNv7nmpm73TZPCmtCKwxnR4pxVqgxJ+cuZjFrC9FpT8jtjPlCCoWU7z//V+mmWR3ZbHkEhn/C3RO1nAtmVQilxgSojC0A81K82qhernIRX/0I3O1qTFir3jpbOXPSS+JW6m6CT8rGdOaPKJXKfQEvDRk1cbYAXG8IQNz0M9biHnILHzGqmDnSeJ41aubj/ZNT2avWK8kZBXTfSYscJJgChmlLEfYXYI86ZL8uC4dHodzQv+3Abjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hLNyO1bqDGOGV20/0yRxrLNEmB7HFf9ACWIq7dIA2E=;
 b=VyAoRvU05YpcZRlCveVmnjmAGYKubZEhm8rd5DaRvvl/jN4D/EhTo25sl+hGawhUQbAnMa4zKBRGshJax6y6TO58cTt/s3/TWGpmbLJtRlRbfn94CScLBqKvWsgXVCG0wV9AXsqxt0yhn/nBjhBGt21TF8bzVppYYtT4tvKmrwFnq4Gqxl4IAGs0lLgSi8XfMyjrUz2FRSyk1s2RomlAR1YGfRXlRbPkoBBPHfUClcXp/q7KOYJ8itvnfTNk6VibQ8bH/NRVhR0FDSe3qU968XGtAnAlHx+PrXG812cc4iuzNGf/pHZ8KOvS++RAcCVzNze5NOJmXJOAZPVScbV/bg==
Received: from SA1P222CA0143.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::19)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 18:54:07 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::60) by SA1P222CA0143.outlook.office365.com
 (2603:10b6:806:3c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 18:54:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:53:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:53:44 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 11:53:44 -0700
Date: Thu, 28 May 2026 11:53:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 06/11] iommu/arm-smmu-v3: Handle gerror during suspend
Message-ID: <ahiPNqKhC186BHPl@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-7-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-7-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: d96049bb-45c9-4324-572d-08debcea7f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|4143699003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UHPehXuiws2GKUTDFDosJTIwY1Q80mXYJdVg71N9s4RPTP0Llmvlztw8o8DGmXYjKsnTIYYX6q0Z7B9jcceVgW4S/JMuqknjzyHiGVZGDcy+UJnvpbTqoHH1iYbXcvSdXVyW+xpmN9ApZe7sJzjFP0fjZts0/VoA2r4wHLJsMLtI2T6EtRdJj8LQKe8Qc1RpX0r3Tzl0pODUDe/oSEuu2lReYUTKbHgq+wIeJZX3Bn2N7C3AnBimn0WsBmZL37rmlBYprWLj7VU4tybZWa+84Hunjysd8AGhQWywCgXwKiGLBILDJC7L0ZwcLheHBb6/4GOgYDmd4829xdaZR8TRIBZD3AOmSxxuW0CRhmTGC8ZDKK8jWUUQXvxFjW4nkXRIy6sSjk9/vI8fudBhMwlAuf1a+oOzi4HkToPiKIqK5H0fVlCMFLLUxhJfjBs9ihyF/6hst+vh0zIJRPDr0LTXEK0bNTEqrZHJUkLnUNIg6rVCdwZKqsDz8hG0UwFdcl+sLdUImm1UtUiqVN1NlNTw7JLnl1JvQ7rY2IUgkIyjqKS3HM8Po490cOxFQwfYRIYyo1Gq1+9q6eO8TYU0lCfDWB3yjdoux5zT5XKSUOctKLXdQ53a9wCeuakxrkiy0D2zYtYGq1rQCf3UDadT9tjgfZWlx5xDUxlMVbNJsFgM6G1rK++xPMLm35WetJJyQ/sr6T93d+679UlZT4HmGY7OjNBRH38fzl9XbyizTcx8T7I=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/SoaD04gCkoiPU1oVqOO1k8Zta1ZhX1onZ9cR+tnHCcJ9Wf8N72bOyEidgXa6mBqGwjyIIySLRcsVsV5NNF4SoA3B7iAZRoTBPigRfHryyI69JHB8KxIeId/ZdVuQv0BOk2j2Hc/5Oil3MHsry2OQbDRw7KRt8LZji2bv5mZzJSRh5OA3uh+6obw6xyDkMFr2w1lbfWbz/yDL7oFJIjD6uKpGM6cqxicBvmcGLH+DN830LSwi8IMcHey06e5kbh1A+pyP+lD6FCpLKTggIDoi9/4m3pPq3fj4cGrYLfLAZWvwU59fSTbPitGQHJqDtNx4NWWaaqbkuH411FY97GLwVbDSmfI9lA0X0bN88BOiCXL7ll6GbHyj3/2lEZgn2Jpu6oAdQm2g1uNzwEQUIG9faUTvRMiJwAGssc8GKnF+XVmZDwZ3nxsZexN7mo3ol9z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:54:07.0895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96049bb-45c9-4324-572d-08debcea7f01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

On Wed, May 27, 2026 at 10:14:02PM +0000, Pranjal Shrivastava wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 93cee32f6c99..191b5b5b805c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2257,10 +2257,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>  
>  static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
>  
> -static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> +static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)

We don't need a lock because the new caller would disable the IRQ.

Yet, maybe add a line of comments:
/* Lockless; must ensure that there are no concurrent callers */

Otherwise,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
