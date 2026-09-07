Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB008B67E
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754248; cv=fail; b=CtFEDWckZ2KOlW6j4rdCkhSR2rn5u3Bw+eEY7bCDC0REEtHJIHgOlX+aNxa0PSBqvfMBhBUp0J/TaO6ZSmEbfMLGhWlXgOL5dQ4YDBpvOsDsivqs2hJHC9sOnFWuGTc7OIQKeOlYfd6xGETF2uxnCk2qdf8cT1KloJkd3mZVilQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754248; c=relaxed/simple;
	bh=fPO/55aHH6yjYZoCz0JwaOayeeZyyUBV9y0m/HSV8zU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2TsqQ0E0nO+4SLpSYcy7r8TMinw7mcNV8djkCbFbX5T1eO0XImylxEbq3AvX05sB/DqCaR745JtZlaeKbgj9lDdKZpoXK9yWC39dA/IwUp5llEhs2/UXehB7Sz89c8kc3Jpqk1s4Ap3Bb90EKhLsUcM9jJDL87rQdRc/rAxr6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/XYY0ab; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/XYY0ab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr8dq4YaTEvudOWKin+XghaoA395x6vmbfO1PxPCNZ+4bAf+LqDyYPokzaut0osh/uFagEmyr+W68Y0sV40IgO8OL2UqJ2YJSPPQDO2SJNbliDZm4VfBsM5oMz4/77bdbyRbFiXXbIAw/a+LKp09GlugSthowgonf4mlF6DKTFybGtLkha+QGvxU9Jk/6FHchOvSAnQbtRAdGWdyXqem1fi2Ab/ePhLgaJaEsmKJ3R+q4D4RWt+z44YNiYTdVeTl4//dhTP/qqCXIY0K9p/MFJDRzd23ZwLvix0kYBgXYJ8q20nBsELC4yU2/dFcMy82U9SR/NBuw7khe7m8QJ8bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymfeC13bB0jZ3j5H9i7Maijlncr7FcYVMe+bu3KX9fE=;
 b=Xt6MW/MaUQY6SeCmNsIpLAJK8oO9FYJ+Jn1pf8u7yoN0fNykkofSFhP7XqB0qUiLVNunlNh4X54DiMFwBRS8VeHM1bd0MZAvrYFeirw3XkTaRzAh513qUnCTFLnKngaBKRnxgD7eXLeqduReI9PnlIRSQcxm4CuAhZAou7y58dodYAnygczPXbELEMvmoDfnuVDF4lzroJJh8z5/c6Mmfcq778KcS9aged2p8iAPJhrA17BX40tQouaVMoJ5OthdzkXjcjgNoUj3hcJSNOHiska7+mCtl6gFhYKSf/JEcEnsvYFUCrIrRPJ6Dgx8bQeARbK3bx58wZEU3Eqr4t7fPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymfeC13bB0jZ3j5H9i7Maijlncr7FcYVMe+bu3KX9fE=;
 b=H/XYY0ab2ePYXu+E1/cROHjMLAE20V2nccScBAV96Rx5Nx2Kkb70ugnHl6s1B/peQ5Gq+WmFi60PJNeMbhi2Tdt8jRTaU/vNXs0NRNTm8GPlq6weQzkdnwfGUujKphzXOYkT0kOB/TP4F3k2WOQkCG7pwWvoS4wboc8iC67Age6i88l7LhPxOjThnMn/oP1bAEiuWzJzw1d8d74FN0Aeimebkwrac5YjtQuAl01bHh1IlIzLDhyfwx0T2kfZf0Ek9VsgYXiZbiB2fgN3Des4cWrgNnGNwvEiIwIME1j8ha5pg+dE/dcupS7RUy10zXLTyUY2OGo6k8LgF9lbuTy3KQ==
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 04:10:41 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::2f) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Mon, 7
 Sep 2026 04:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 04:10:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 21:10:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 21:10:39 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 21:10:35 -0700
Date: Sun, 6 Sep 2026 21:10:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	"Thierry Reding" <thierry.reding@kernel.org>, Krishna Reddy
	<vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, Usama Arif
	<usama.arif@linux.dev>, <kernel-team@meta.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Default queue depths to one
 page in a kdump kernel
Message-ID: <ap45OJ4RFTLWCo4n@nvidia.com>
References: <20260902121724.3494954-1-kas@kernel.org>
 <20260902121724.3494954-3-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902121724.3494954-3-kas@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e727868-b4c9-4897-cd1b-08df0c95fb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Nsag2WuwvyzY6xYEY/eN66Umij70o8nlIXYmlJx9s3eg1PDxu5C/Iyb+f3c18fJB3zvoVKGV9NcIpzm8PVwykO3oOLp2UfCM879Y0552pB5KJmvRLNwQgRcwNniFuK/Jw0+/0gWcNcApEOVlYEHsp5oPWmtn4rDLWgzQPk8eR6Y456ajWxdPj1rQ1WE1qmoWEi+oTgWGVCVLn+8GxybijjsQWvxBtbSfx12SnJLBqa4NUIHIOeQq6EThlT4jJHWLGJ9j6hoiskUOUTzWFDN2Gx1lJElOAsnokaTe2JNk00rsT4iL9SCbhUFfd+VfUW4rqqPAo3oH1jKo8nvWcRsX/H0+3hjlA/+BAlPNWkzrtPzKIPXtt97mcKncHSbDe/fQs81Md7OELTj/n9cQKaFcnNeFjxZfSSV9rmUIhLESG4KOAERsxhkme+xSpJoLFVrr5VdKyJRIHkmt6Jg4OWSGZKFvbdq/O56iKUDjLx7lz6FmOGc3qsGsH0Tr3+p0H4s7YeQ2PMV32gAPqANckQ2HcGBZ9TD09J+HncVWezVVQZAZnbuxEhD6gg1nzkRe3UnMuBbCI+9/tXb2gkzVbjV91cWR0Fp8kDH0mQj9RQj3xYagsxkwTWKYuJfNVpihFuCXvB1O77gK7MJG6wbaiz95igr6OE148MpGAiv+GvTzlFlUKYXnvNGDlHFVBp6E8NQ
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nsqk4426HPCoRcQGvTm2G2elJ1GJCSgZTenVRYE+eGmO7HBemCgOhpJ+cM+xk9CwJ2v537Dzj1nptY99Sonxk8oZ6+5jgHOba0gNF9H7fkMgVzcpwlQbBWUKsL0UgvcYeCdKPigQBDVhqK3d4UYewMyjYBIFHULqDv3Zs5K2bBgzavEgeIB7/j42iRR+Dbgg9dVm0PCHqlM5EtTDu4pu+6JQqfnoukvBt86lBkhG5cWnyx18bIfg0FR3ZMatYvs9GCcyUPNKjIwUfAmbga5qfdPWGG1rC4H+uz6pCX70YO9DV5fO+o/l3W741On34/slOf6qdcB7/GRn78A6El/RAE3n9xc9lX9AngAdkziv0A2r4hTykx1pvPDMPvjKkgm3EMZPR1lAz+TOtBCs6Saw2MKWEN6a+5omo78+HjmcQc/8qW6egS1Dw95XUrQbEKJ5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 04:10:41.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e727868-b4c9-4897-cd1b-08df0c95fb3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

On Wed, Sep 02, 2026 at 01:17:24PM +0100, Kiryl Shutsemau (Meta) wrote:
> @@ -5208,10 +5216,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  		return -ENXIO;
>  	}
>  
> -	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_EVTQS, reg));
> -	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_PRIQS, reg));
> +	hw_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_EVTQS, reg));
> +	smmu->evtq.q.llq.max_n_shift =
> +		arm_smmu_queue_max_n_shift(hw_shift, EVTQ_ENT_SZ_SHIFT, 0);
> +
> +	hw_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_PRIQS, reg));
> +	smmu->priq.q.llq.max_n_shift =
> +		arm_smmu_queue_max_n_shift(hw_shift, PRIQ_ENT_SZ_SHIFT, 0);

And I think they read better with two small helpers like cmdq:

static inline u32 arm_smmu_evtq_max_n_shift(u32 ceiling)
{
	ceiling = min_t(u32, EVTQ_MAX_SZ_SHIFT, ceiling);

	return arm_smmu_queue_max_n_shift(ceiling, EVTQ_ENT_SZ_SHIFT, 0);
}

static inline u32 arm_smmu_priq_max_n_shift(u32 ceiling)
{
	ceiling = min_t(u32, PRIQ_MAX_SZ_SHIFT, ceiling);

	return arm_smmu_queue_max_n_shift(ceiling, PRIQ_ENT_SZ_SHIFT, 0);
}

Thanks
Nicolin
