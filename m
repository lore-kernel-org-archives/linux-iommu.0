Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5936B07C
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657577; cv=fail; b=QIAGE0Tix23SWI63q6nxCi+amVCPuOcM5vTucgoHR1QBWUAUHBXUWzaOpIbK8Jwgbr/8xfUFaSMgvP1XCyB8t8wPIyW+jcxr7P/YZawiGuCPIq3lOtTb9A2SVWKvzKHSo4kN9cV+W6/RHNst9qfnStiXMOKFfG4OR0rQMK2ZYmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657577; c=relaxed/simple;
	bh=hghBdsiwaI6pe5Bpd01j5OnbWRdgs/MjoNYkYmkfUgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNQ/1liQVZL+9xrj1d+7imBIfGfuYr3QkrxJke96Bt4IjPhqivi5shXlvTOX4lGUY4/4p/FnHbhQEVoaVfoMVHEdvOupnNSnCdS14ZkLEVfaXERFb9Kf+/L7lUhJnDuh2KU9aW5zPlAvM/Nd7W/GThKBQ9QgxqpKurnhmaGm0bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjSxmyXt; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjSxmyXt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUveUNYU9Tj4+aJ4drZZtlvVTOZvrWOazigNpWSgJpA8ENSUQgpQqYzksyk+zBorK0I/hc1t7bk1uSaC0/49L1GnnBslgQNIyAujSN1QZBntxeA1Ol6ptHe+5yAFJYIFhdTlJedQasnI6aagFZOGazbPc0YYs3rx84qHCjFGHEbWXR2lVddt4pmj2weTNclfitgiFH9lN/PDwi/aCFejaPzMQ6Cams2Ph0vKH4phrk9z1IvDs9evuELSlLndz6a0+Bb4P/uBgZ2Kiz9+xJHsmAHP2ELnZHiRNDkDhH9KjRQ6wZ+il/w1+hDi3vP5QrCGfz7KQH6nqOnX9J7O96dRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVxCj6B4/M2PTspa9DBqCrG5/2JiJpmmRHwoKMmKbQU=;
 b=v3qBmQh7CKI9sXAz3FTCR1l/xB8CGYmS0BG79MSWN8q/eUdV7OYbdntJAAz1DkGIodi5e2qxE1sbDMfiuA4ojrx0v1j+pzA0qecClD8UEt/7nmBd4+obUjx2Kjz1y09t79JPGPlKIB5kBT2bC4cUFnQOIjhEXxjh3a4e+TnrZwnUXF15Q53iQ2Bm5T9Dq2mBlkjmOLGsz8QukhCrKdj31HChDkzfRGV8VNZwIpAX16gGEpi0zdMcUlT7ZJiHwyosbDlld4G3nmT4UZoyhWR2IZMbY/Br00E/ippoQyXMY3ef9Ss1EummoX04IQG7Y9IHjV9WDULiGApnk1XKNu7IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVxCj6B4/M2PTspa9DBqCrG5/2JiJpmmRHwoKMmKbQU=;
 b=jjSxmyXtnE1BAUhu/p8nIlD+iCfUBmofibG+WfkyXwRwhQGTxSp14c4OSeJjxHoBXqSb3LfSlkLtINvSPuNC1eAC1Fss/gBfNkAovaiw3P9yWP/B86Zbd7J1iR5JqU9usVMuw/PJ09eWEJTLStPKGxJM0whp4NxL63tTluweJemGw5D50LcMYA3mon/ROCdZVEKrQ1+yZgCmk3JiHrQFQRiEHm8P1w4veIfU2Q3rDdWaKUz/iAvNYekuj7v7mssL9EQyYvKgr95sa945K9J+6k6FkdKEmf6W53WvrnoPGHRW0U3zWqbBON6+COxi76+VTqVANcRAzP+FgXAs/NGXAA==
Received: from BL1PR13CA0065.namprd13.prod.outlook.com (2603:10b6:208:2b8::10)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 04:26:09 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::94) by BL1PR13CA0065.outlook.office365.com
 (2603:10b6:208:2b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.4 via Frontend Transport; Fri, 10
 Jul 2026 04:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 04:26:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 21:26:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Jul 2026 21:26:00 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 21:25:58 -0700
Date: Thu, 9 Jul 2026 21:25:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
Message-ID: <alB0VfK5n3PsE8oK@nvidia.com>
References: <20260709095613.831769-1-amhetre@nvidia.com>
 <20260709095613.831769-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709095613.831769-3-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ee0889-b7a3-40f9-48a3-08dede3b5e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|11063799006|22082099003|18002099003|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	H2Ap6Zmc6D+PMXhAfcEQv9mPPaA2IbaqYGzP4TFvp+uLRZRQpslbSpx7ayypufdQh+Y/Ud0DrgLtp/OblrqN3Gwognl71CvwMc+LmOXkswqNG5I6Rghx5/OtcVcrFSOpF//FxdHFOYTeoDw1eQMJjRdFzHiFF+/iUG9zNkAuqW9xcIwJO9w9G4amxusAw/VhfeqjksLtXlRVJXUZ7EhOBrB7bwkJgMkiZB4+vXqxBrnnzcC1rqjxrmkVzT5jkAVnr6ZO2hVeLUWM9U7CuN56uL7zxd7++j+5EgrM54GabXt06gK2TmgYLjJvjEOIhv18pf0bxrdafv2mF1GfI8qqmcJCkk5GAB+WCArvkb3YshHxdwN/X4eMGgmIQcIcw870zX5x/mfc3lb5a7UhuxyCjpEvQW1Npj5RZHazSGhekNnGByFulWPt7rxIcLkpJzxYhf+GW3r3bF7g7pg2JwwTrgbXeFY/QTdXA5YAHJzleCFZJzr3AdqXn81IBW0Xz91qjIgVciEnokrwuYNVGGL7OMSCFpIf7QMkiyFdqUyQvFQkRVH8qb354s9Q+0Wv5F10/TWOkhEIbpege46j0++9M+HSr1u0ratAmg8KBMb0sOdu7qffNfIOvqnub+oVPtt3cJSA6XMzJjhkj7Gj2FAlxwURn0I0l8Zfr6tXhSFuKuUFmTLRsSdjcOADY6HbnNwM1Ofp7czpafsiqDre0ieUJw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	915jD9XmF21Szxof4IRwU38F+oHx7RaFlelq1d1FkzCCwVb79OebJ5QTPYGieLDAo5skUxckNJ4YOhyylIHnrjkQyP33E/hICWnSoj7HMQNO4uPTu9T7s1gLM46nP5QtbfRz4teK6RZrARb+gkJUsSkwxaFfDDllTLJxt2h+S0pXhQzvropgPvndbHrZtmcaYQTfavvXieLkQ20t7ePpiVVyChNEZhjJ8E5pSik6HISaLoPrQ4nmtJRn/WVuPkxNOQQVFVduf5zMc7XR+QFRyH1vuuh/4TAVLsB/+8qykEnoQdfH1WR4jd+OIPn4M3yPTniZCNSKAFYzavruoj7lG02IwvSIpLGr5NPCu1uFAzsbCoIv+cFEMAXUc4lqZ6gB/VB8I4eKVvIGF5jpgK9YTqsrYRVVCEThz6DPsKiuhZzmiRoG/7AUIW8oxUIVLsqA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:26:09.3002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee0889-b7a3-40f9-48a3-08dede3b5e00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165

On Thu, Jul 09, 2026 at 09:56:09AM +0000, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMU is affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice, and
> that infrastructure is already in place behind
> arm_smmu_erratum_repeat_tlbi_cfgi_key.
> 
> Neither IDR nor IIDR flags this Tegra264-specific bug, so hardware
> detection is not possible. Tegra264 is device-tree-only (no ACPI/IORT
> support) and already has a dedicated "nvidia,tegra264-smmu" compatible,
> so DT-probe is the only viable detection path.
> 
> Enable the workaround on instances matching the existing
> "nvidia,tegra264-smmu" compatible by calling static_branch_enable() on
> arm_smmu_erratum_repeat_tlbi_cfgi_key. Document the erratum in
> Documentation/arch/arm64/silicon-errata.rst.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko pointed out a concern at PATCH-3 regarding the static key:
https://sashiko.dev/#/patchset/20260709095613.831769-1-amhetre%40nvidia.com

It's a false positive. But perhaps we could fold in an inline note;
it'd belong to the missing description that I commented in PATCH-2.

Nicolin
