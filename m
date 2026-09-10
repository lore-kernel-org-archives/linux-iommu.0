Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B6242D67;
	Thu, 10 Sep 2026 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014252; cv=fail; b=m89zRFVcksPga5GV140rRUSTD0Z68ADfUbt17pSr7KXnAJi4hx8w6YTxnBFBxoohvNdXGsbKQ8grgCHDrBDVCn8LJ5gFCq2nRWpySC3N5kdn24TbDBkLRyPLuHHvSoa3Po/Ew3+9Arbztr6akbjCVzNCk5zItqaMxD45SrYHVqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014252; c=relaxed/simple;
	bh=dj0iXWPCsodIPPxibSA0ZiQs6p/B0Jma0FM54ecQHx4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN5Z2vlJwUsAmbw4yJvjIkeIeReUjyYM7/afW9CkxDSFIDvOQwo6uRWBTr+YuC5IL3hdRO/V3n8SR1xN6JQjHGGwLzCeXPlX3dMf5TgYxbSWiVHYxiHRBhNoyaMrj21v+u9KM/WIKBIG1JdD5K+JsI975+d8WTraOTFhoxFcZDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJlUmYCP; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJlUmYCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtLinWauMWcVYQtt7CsNQJFC6MAveP4w7UOl0OaGSIvTrq0qFLlHH13WuzOzXs1GWdrqFOZ79VpW1tvVHncfyYvLGWBR1qMJCvcavhKtAL8f4Zn0aak49gLrXmACm6ZndRpf4yEGM3ikyvoz1mfWQc8GjdXvBcmntVWgzObK2gTmB6NFYccB7uYiGjBOSSH9zHM+Nl0acxIjWZ8yRaCjrCz03iJzRWBr6ROgE6WmPPpUZYZymUcXN7hHiXaBlOlAi+WK5if3ubI9owyFv1chX9K0Prs0iRtblPGcG8ovMyQpUtX3/aR6AMVDv/WEvbfp03qpDojwJpPZn9ItF4NnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpbah0L05eiHmHOtHjK+Nv7fX2cEcb14L0k+7z5InzE=;
 b=f46DfiIU4TROv1ln2PotB/s2ft+MNWxlBWMMuOi446aX1YSA4TxBgLzV8N/5OsK8rENIjsmln6DVMW+18tTzzujmiWPriMi34wWPp8F828s/hhOWq4rceetd9ZaKLZPJfF2MvFnarn+YwoezBG2fA+iwufEvkB3VysO6kMwvRTrsd3Mj2W1yaI3IvhCUnhOVQ34gsSH7s+1OtgWk9z/vivPuHvupOS2Nku01UcmQbKrhZfxkDZL+LidmtmLLdOAEhsugZZlF0SfMb6WfmJ+kUyfqS6PZ6Pbace6c45mXtOm91RRdZNFpFoXzbBiXXEZkFKIhdoFmWjjF01U3LS0ARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpbah0L05eiHmHOtHjK+Nv7fX2cEcb14L0k+7z5InzE=;
 b=AJlUmYCPxxiLrjMyTysSA+DC0ozTDnYjKdCj7iftKBYpmmTpSgwU1AoJ8bPNmbZJv1uineSwCl5xnosomU+AOfuKHSqfPMalPTArUFX0KQBvxbG6rvdxnjk2oBbmH4qDqAfd8oaX+Mh8FcowahY0YBwvTAcSNtSM3dzuSkq/04h9TJ78UwOJbbZrjIpVAcXEpve9mPZKdVqWzbSGK3YxpN0KOBHP6QTKj4E3cMg+QjlqRExMROjbm+K3ete7HguJBLaum+rRJLI857n+AwyEk6SpUXxcWnYTrehTTFAPEE5HV6L+u90YNBaM7ZEcyfbqblg/GPk8E6mWGqMZsjxFgw==
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 04:24:00 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::3a) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 04:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 04:23:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 21:23:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 21:23:44 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 21:23:36 -0700
Date: Wed, 9 Sep 2026 21:23:34 -0700
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
Subject: Re: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm
 VSMMU via RSI commands
Message-ID: <aqIwxldvOHWlNGRu@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 8622a8be-86b3-47af-3b3c-08df0ef35621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	+i4wPFj5cGmEckAhb82HfaZ0U2wR7LoMXv2UBB8KGaydHcVkXQCsrdDQHfhZby0wDmOGWcYz/vaID/yt2LGsa8WyRinztTzK/HelVhUOV+LctuDONR4DnqhGWC69+TstBHLQN5ckzwTb8rpp3vcUDUluhNvmT57yytK13V2tdJ2ELfhk43TXf5cyEJeVqwwtWHdO7axBqiiJAI7SX3RqSMewM5+iZH7AVGcGkY5gDbYrAPWH/BrvnzmggTYuHmnUOmUgFFWOvNgHY2N0E7nYyBmFE2o9oPohKWr99iCohUUx+IYMWpsYrR9eDT5n81/NBkq4zIhb+4+XroWwZxGxh3riblS+Zo8LR2k8EZzxTg2BMliYBRQ35RHtkwIqEXmog8qyZlP8Muq7qHm2/p23EZnX6rXAhfIlIHsmz/ftGT/3fM+1bFjx3+DClZBtDNmiYCzYP7YC1ziUbHMi79URnTMQq/w0DZPm9MkwkasW8y2ofFR5eammDkglXSYaeK2awINlmgVshxt9O9ZwbBZ97Hh7IOW8eZVjtqpmkY6tdoN2QuqqXtwDbq63/08G4u7O2huC7yLUeVucMhXu3A8xM1+sYnzbnGprpD6gX2RvI2BJWyo+uAtMlYPsw0DziOkMy4+vbZI1Gl9yrDqVQ2LHpU1fr5Ug7MT9AfTCdIrvPB93OMb89V8OQz1XTBfS/YnSRcKIP0OlhMVTXYES+xmAbA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LAbdey40vYp7bX9NRE3y0w4lP7WUfJHEyfHTe7IMjC9n9Ppte6FWrr7DERNYPVL1A3MoSvL2bjoj6xoTV1JZ2ZCmFo5aVe2kjGSlpdg+ymL5YNhqg2FxqYedTRjILTQ4+omnQS4qpguv7kzSG96ZAAZBP29pW/IQ0ci8QxvFh3232siXf/r03WFyNRWyQgwERRBEeImDdeHqbSBbNzoq5ed1QN8tuzkW3KBqN9u335VS7onkvwVq65+NsGvJJO4DUb59owdmoymTfpyQ3K881KHjmLl/hM42IUsT1hLQ0ewKPe+15mtkmoLJZd7WiXvnOqXNkyWcWsQuzGzU9pj3TK3GfPboZWq/W4+P7JV8+tKFISbd7UwDcKz7LQSOWw0yULs7rPxgwYch9FYub2uLpvAUHEZAdPtVzvaXwrQjlnXSGLLSsF1Npaee4qaP+I4Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:23:59.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8622a8be-86b3-47af-3b3c-08df0ef35621
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

On Wed, Sep 09, 2026 at 08:32:51PM -0700, Nicolin Chen wrote:
> @@ -5542,6 +5591,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  	ioaddr = res->start;
>  
> +	if (is_realm_world()) {
> +		ret = arm_smmu_probe_realm_vsmmu(smmu, res);
> +		if (ret)
> +			return ret;

Sashiko pointed out a new finding (didn't appear in my local runs)
that arm_smmu_impl_probe() would allow an untrusted hypervisor to
provide a malicious ACPI/DT table specifying a vendor extension.

I think it's valid, So, we likely need a guard, until impl has RMM
level support with additional RSI validation:

-	smmu = arm_smmu_impl_probe(smmu);
-	if (IS_ERR(smmu))
-		return PTR_ERR(smmu);
+	if (!is_realm_world()) {
+		smmu = arm_smmu_impl_probe(smmu);
+		if (IS_ERR(smmu))
+			return PTR_ERR(smmu);
+	}

Nicolin
