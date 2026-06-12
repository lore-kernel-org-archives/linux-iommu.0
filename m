Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350E23395F
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226953; cv=fail; b=CkUo7TLwh9+O0vkIKeaOk+iiTS6g20XZ2UR47+iI1DQlPdEs7kIaxbCPtEZ4ROYFsYGeNXGxlbHGO4ouWrrrWuEhj40Ouzni+moAyqEDa+GLd30sQRYSUIQKxVud0UD+IAm343uUF02jlWVgtAYOl2WOMvNVwwbvRe7aVjVn/Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226953; c=relaxed/simple;
	bh=ObnHdG0WmKX5o05Fm047j+b1gSIGlObWBCaZSHpYzow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnWfeS6y7SdvoskAUXOydjo+5YYI0MiT71+ggsrAXsJXrrwaBHsaU6wDedaNZT3kXehs4Iu4catIJjeDIxvZ4Nd2SMhyUN5UNMq3ZPp8+Iv0hfcaSGWW9z7VCETQ47QsScdBiEYRv+Re7Um4DMOoMBKH5fTTfMbVtLWq2YsTPdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVbvdoJu; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVbvdoJu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmG3ZThJysWQyXfb1+CqTLotfFN4HBds+gTRM/vvSpiyj7np2Z2K0Wga0Y/KkhqUbKYdOXPyWq2FJtnN7zpMhaBaYBtwBdz0UVXRHrUDXkzl/BH+OMliLHaKnK8Tn1UED49aIWIYGXRhJeDovBTz1AdIakLYXPJlbAff2lXZw9MSGr3gq5o1EDGffYg0UT0mq/TuNwhl4GPzO8GWG/CT9SYO2rlSHOn22dWTtwAGSheBeLjuH2jaEnua7lwZzna7pGerIRJpHc6I3m5iU68P2a2h0n+jnthqDroMOQTBuu4wW2eRsbb5pX9JQlXapo8h19cZcB+lObBL6a4yvtIEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPGVEufbrB/qEFzX77GPu/92Ova1BiUYa25cj4Hszqg=;
 b=E+/0cMolfEalUKZcdy5BrQJemSPQ4bnYkPJlfeX/4Nh9wB87d6Jp1w2LqlcNFKyH64sXT31s5h4+s/dus0XCIqp2oqbVfCAqwQesCAQM8JwXEI2w57MgQGWLoWwGELmmebcLWgGaTuDPGng7nF7vd85SP+ijTq4DfxaB8Fd1lOKQHGOzWLC9L86vZoNK9MmiUxe34DLAanlFwX+jRIApuFN49nYoA6C+M9inB6kntdcp0lvJxSqyvs7WFp7H1CCqwvcEDny+xqQYf7ar5WmX5nJFhn1RvvcGPTIx3W8WpSp+UkDHr/YUp+vqNOxDl63N1A1VnDr5KA9/vAxZqvfoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPGVEufbrB/qEFzX77GPu/92Ova1BiUYa25cj4Hszqg=;
 b=pVbvdoJu+KnGOf7KvtlmHCWCrRCw84rhzS2vffvPGqwHahbHb8glihbliVXvy1p7sO/61EQFUzG39iq0LitykCdiokDssFFY/KJr7VaRDByHIvDS1zh/Xj/HhHRYCXc7LpeYL9uK+EUNQSDjICbIMefMDwMHV5CyOOoOjcDJ0pe3k8tvWRr3kvuFrPPzpLCH1Lg5blLPJvS/OTiYlcu+xe8rXCQeZ35u17exlzHNn3SGD/ziRh/yyBdXy02mWQJtNzOUt9/mq12qWjd6UYVHLruZUowKE9s6Kidb38jNrEwCvq4hH+EIfmkZeBLML96SLTz6GsGZ9D2oWIITHkYu3w==
Received: from DS7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:3b8::28)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 01:15:46 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:3b8:cafe::3b) by DS7PR03CA0023.outlook.office365.com
 (2603:10b6:5:3b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Fri,
 12 Jun 2026 01:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 01:15:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:15:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 11 Jun 2026 18:15:26 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Jun 2026 18:15:25 -0700
Date: Thu, 11 Jun 2026 18:15:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Manage teardown with devm
Message-ID: <aitdrRk/3Y7TZdUm@nvidia.com>
References: <20260611084205.686559-1-skolothumtho@nvidia.com>
 <20260611084205.686559-2-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611084205.686559-2-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4359258e-e2d8-4c50-0d0d-08dec82021a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1t7uXyy/WyqRUIsyoOMrMsNQCXfk9C/adqAst68i9LMmJ/QgfVG4gePmaPFmxKSzLP3mNdZ9aiPpdhzyIVzJbfzT2+u7N0bBpU+AVbXkhjZnHNnmk+vN0AqRp+gpUQJuSwzoGorPfjRLVDBqVJg3ezV7cutIFH7mQCByhlhG20Pg3EYl/2NVNKqGUJcKPbUmamVkZzxNaSaqt3xXfy3aYQbGqsTnCxKpN4huE7tg5w13xPIougpnknYl0Vq0PTnF2OcHFbr3Ao68WGNSHxRf0gGlICthQpNRAYE34vognj/ZCcWijhjtSSm4PAc3wuRra2pTZPXC0Na0iIYcV7hi0BfKHuKgYppvDnCTTlT9or0Tpnda3r1X91R+Dgo1eP2MBDIsY47jW6hR9f0+qCpiYHBqgvc4pxjdxYe4VayByhjAuW8m834uspZpavvYk+xg+bmEQIqTWaoDGCRt/qYnpdogBYc4LXMXQDyECYzZ2ytm7kd2cfMo8MTWQNPuLxYAAx2QiqUpaK8E13z6Ne/4i/I8poPkL4wykbFQ6YATURwSUobBbHMoKwCPAKRh/77oAa7IICaNeDvfptmjvBuQjWP7V/he/zxJ1SZFkLNkSuj9L/P2mfTbxsvVKdG5lDsrDvlot0ccYqxwVmlX6iO0qDjp/Wf6hbV7jRri2OAZYs8abh+L4uZXQqRA+PcIszMJqOKJKQJIj7rjlKMMO1WH/UugVRT2RAttcJdKQYK3s9k=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wdX/L+zx5YgaMONNPSSxgtNSuS8FCBd6wpVJpxoSQEhCMEP1WZsurLv2pYZQeofP0/2856Z2jjZPtwzB/QmK+RnY2qKFrKR5kXNOoVsf3/EZvIdWwF9A4P0BUOVvKNQmCtvzHg6p5FtzcV9WuOnVdcRlUppTbq774lt5IQZFIl+s0imM9FMsmg20vyXMz1A81YTT0B+P3UjxIKh1Ul9ZWAG4YeG18lyCyzYLYpvzHArh93xbqjRKFqCBMWEQXF6TLnXTMZEfkrgQuYy3z0GkQa4WcyWeDMVAVGwBh2ZIiRb+dghpNUPqqN4DBNZehgCbMmV5QWBMAyJXBsCl3u7N3D8WDEx0vFwF5k29mtXMfeAaDa28gWM0+95gf5Inuh/TQYuUYT5Rtl0Ix9fpuzK68Gh0LWHz29R4QEZNabWZTDxBWmbr8OTJnSMYF/6UIqyF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:15:46.0327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4359258e-e2d8-4c50-0d0d-08dec82021a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On Thu, Jun 11, 2026 at 09:42:04AM +0100, Shameer Kolothum wrote:
> arm_smmu_device_remove() manually frees the IOPF queue, destroys the
> vmid_map and disables the device, while the IRQs and queues are devm
> managed. devm unwinds only after remove() returns, so the cleanup runs
> in the wrong order. The IOPF queue is freed before the event-queue IRQ
> whose handler uses it.
> 
> Manage all of it with devm so the unwind order is correct. Free the IOPF
> queue and vmid_map via devm actions, and disable the device from one
> registered after arm_smmu_device_reset().
> 
> This is also a prerequisite for fixing a Tegra241 CMDQV CMD_SYNC
> use-after-free in the subsequent patch.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Given that the PATCH-2 adds new code to arm_smmu_disable_action()
which is introduced here, should this patch also cc stable tree?

> +static void arm_smmu_free_iopf_action(void *data)
> +{
> +	iopf_queue_free(data);
> +}
> +
> +static void arm_smmu_destroy_vmid_map(void *data)
> +{
> +	ida_destroy(data);
> +}
[...]
> +static void arm_smmu_disable_action(void *data)
> +{
> +	arm_smmu_device_disable(data);
> +}

Jason prefers casting.

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
