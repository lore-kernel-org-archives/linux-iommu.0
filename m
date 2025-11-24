Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7272673BA
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024102; cv=fail; b=HEuo7OxjUFcQDbdDBEKiZJbXBEZNXojg3J/UN6nszXNJ9BEwhcgitu4Gv3jz7r9fPYlep2exAO+AWKATZVC8H4OWjGPtgDYoTFm1P0jeR/01gNFD/ZoYB7wXqc6/ZHgJ5J4YcDlWBh2B1OQ5JxGg14CircP15fknwad1dO2mutA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024102; c=relaxed/simple;
	bh=GAD1L5/TJ32JSqDvhA6nWV9aZky+jj5yRAzgatKQWLg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMvYPcM2OpjIpxUDDtE9GKO3b7NsoFzoEOuoX93DwAdN5kxH0gtUQ4mtCo2rr5Y0dPGhrrMCjkg3grzSQhfadq6He6AiSa42DNnfPIWv3M7JgS4XrtkPCNpOpfWJEqVevzEoqArN/i83GTj4VxKmxnw7pgkI3yg1YKVavUKVZac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTC5gWG/; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTC5gWG/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8WVRgPuzIzL6lh4T011lEXi0ZOdb+2ZTptYiHJgCCsv+1yJQhNOkq9zc3ot0ftCm8W/jtwlNj9iCSUuKrJDDYVKg6YiyYJ75nRn9JNcUchJMRQuH++MHYOfN4SiX1PZ/zlx21+/bhcNMAdUvBoKJqbC8yTbiXq2rdXL4MWvrZeDwHJAv5bvwzO9dRr7wBjQU6iFhPA9tFX0HBctDL9+sXJo6vZ3HfF4oXEIcbYC7gNaT8fm0O18sfv9SXOmFnqB4xITcc1/Eh55OkLHf6r1vqgE81cHelCXtqOUw+Mm8ke6DPepRTR7mHwGTPbr0vWQYxASKEH7gqJi2wiQC0k6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVuSA1MEe25byhZRPl21B7PBxJ3HyHnoSfu+7Oa6oqk=;
 b=K5HGjD3ln5fgx0zOAdH3JeiKusN1gjn4lLxlWnNI2iTDAxRkHpsueLywYDkfohk5DCIQlVamZWqGPxrlCQqySJIzs2EsKezXahTSXlB/J2dCMwV4ViwtgcsHr8KjP/1rTB6IHyzl0/wRWUq3bkAzBYCeh3ru1sUad77jfseNQrpyQlElpCTS8GQSF9upn+MW4f5kGBaEP+f6WBik0hZEPnDm1nxdru4/vltzhu4tCFwWQTulrcnGRz1YVQGoLK11sjxaFQun880hHCfWw7prKL/cd93E2V/gP5GZAnqzTSGHn2zy9f9azA8iimFFav/rvzcwQTDsHPlwc5kmtjCy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVuSA1MEe25byhZRPl21B7PBxJ3HyHnoSfu+7Oa6oqk=;
 b=MTC5gWG/J7xUWLKoqG58T1LOLASlNskizDb1KYXyVz/aRraLb1IvsRfJwPqjAlteQq2BIFeZ/Af/m3kkXtlTS329elhAuycRqxesEPBKma+Gw3TAA58ps/7qoFMGroKgoThDvbJcmNcST5+/E40ccTBHppXuJ02O8m/931BPWjWe/cMkfDxcLg6BkkjR/ZF5tCnDwc98DhwH4VZANgIuktp8cCTWMP4p+liT7D3WvNXbcBd5BBe3781BxkfztkH8BO24kj/ncP3VtW1DUyPCYKDr07qpCyF8Dwnz645yo+VPGGwpFg/o3e8oRgvPqUbvSMcUKzhgk4kVQ8mOX+4fJw==
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:41:33 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::6f) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:41:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:41:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:41:17 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:41:16 -0800
Date: Mon, 24 Nov 2025 14:41:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aSTfC5WFoa6sJlBj@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>
 <aSTRRyTBh1nATwBa@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSTRRyTBh1nATwBa@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a83bbee-eadd-4a04-34fe-08de2baa9e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zFQC9v0kZ7pfjbPbRcWyMKWzsPeNQCJFQYOmi5mqqoLZVP6iGM39+0vqgi4?=
 =?us-ascii?Q?BLcDWHAIPL9STPj0W+hZnL5bVpYnVwZf4y0H4yIyxfJl3jyhYxL2Fm5weLZO?=
 =?us-ascii?Q?Xp6ZLGMFXSaOGPzXptUcjB6Bay5NAcH0xz3XNmdf7/fAr1lLq4/YSMx5sCLe?=
 =?us-ascii?Q?wyVXPpVVO/n/07ZpEVOcH6U8/LKGq2dO2bNMFiPDgIfTHRUTOO1hOdT88uOM?=
 =?us-ascii?Q?CaITCDJtd9fFSArz5K9o+B8Vg5EP4Q5ExXfr+YxakQr8BaTzjdybUF4BP4WE?=
 =?us-ascii?Q?eWVcKJ8uwYui2ayDzXl9hkBLnV32mltsuKeIriIRkXtXdVO5cf2ud9unkGcp?=
 =?us-ascii?Q?nzwxGAif7GqAj6iAMWeiQQbXnDGsf1NpaUHUbUmCgzvUzc3iPcXQcaZGCaYf?=
 =?us-ascii?Q?C/QcnN5o8XRilVWD4U5t9Lmpii+Q6UBu3b+B7D+tU0jCakeVjrY2wMhfgbkY?=
 =?us-ascii?Q?hxaBvIFFu6IggKb3HXH6tJnmgLBBX6wU/shHVUoZyfj2xfNyQo20UMerGLzB?=
 =?us-ascii?Q?mrb/rRqrXnLdude4Rr2CDrZGwCu+c30QRFSmeMx8cDp2CRCsoQSPj09wSl26?=
 =?us-ascii?Q?epB6SA5b0qpwYJgmjyl4cYJ1tij6Aut4JvZXNl9WJnT88B5fOqGPLe+nhHtp?=
 =?us-ascii?Q?cTQ2ofpq6yWmMjJcinU1doB4LhT9LHSvDxcwTv6SUs4cAOD5wBgDbUFk9Bel?=
 =?us-ascii?Q?UuSLOUqnKwH5KnyOyIxncBGPtLORc+6sswPSKs9x1LUCj5v5V2GhguK/xZwA?=
 =?us-ascii?Q?Ex/n1xFi+ojB8ddLhoT55AL5AqfaBhcG6yYNy+bii+WwUA6aGH9zusW4Af99?=
 =?us-ascii?Q?D9bDkScPxFXRYKDcRHXF8WgGc2Pu2jv9JBmKFaNKgwvBldBQsr9mNYbAr5P7?=
 =?us-ascii?Q?D328at0p1mzwCuhmwnyoRfXfUqffYMnFbVlQWBv5FPpSbVNLkQPpKCAn2Mjz?=
 =?us-ascii?Q?UWOoXqm30j5Qi85MjqaGSx/Nx71lt+P/+/6d70CAxhfj4dYN36lrPU6UH+Lp?=
 =?us-ascii?Q?IDFa05aoXzgtnqyusUorAPdMVfjt0+urEuU5Mq804REtZ1+n48LTsGw57MxB?=
 =?us-ascii?Q?U72zY9mQ0w4PDmndU6VQ+pOmcVdjgStz7e+V6vZTy450gZj8GfIfdpOHF+XX?=
 =?us-ascii?Q?sqAH/xUJ1X8NhqjWYsnS5+G/BOPdXReoHnbtFz1KmG7thz5Q26qyi3Rb/YAY?=
 =?us-ascii?Q?9bKtX5PgkHIbR0HXG6cdGRU8TbeicuuHcxulzqdI3HFCdqI9JaWeDFTe4bxU?=
 =?us-ascii?Q?s9Q6VXnPGEnaB1LRrovnyqx1fiXPOaLKaHTkHWf19tS8mh9hPMpPtf46d4KL?=
 =?us-ascii?Q?cLBu19zVOLLb3k1qivJybSegG386V2tk6hMheTouA/bkgnWWEnucu3pjLbmX?=
 =?us-ascii?Q?u+Uc4nhd72vUSG5fM+olo7jDNTnitecHgykhIxIW67oj6/gSgdn2At5Uopou?=
 =?us-ascii?Q?jk8PA+WO3H73TyYzHYdhSSNup7V+CRc7f7ItFYGjxPYtQtleAPpso8SUgpRL?=
 =?us-ascii?Q?orBFHznaPq5lagp374Eg1GJ0k+BEZkveq6CtkqfR6Zjjjdg01FJ/ERHzNVT3?=
 =?us-ascii?Q?PnsUg4UJ0YIxPrmvUM0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:41:33.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a83bbee-eadd-4a04-34fe-08de2baa9e71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

On Mon, Nov 24, 2025 at 09:42:31PM +0000, Will Deacon wrote:
> On Sat, Nov 08, 2025 at 12:08:04AM -0800, Nicolin Chen wrote:

> > +EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);
> 
> There's nothing really SMMU-specific about this data structure manipulation.
> Do you think we can abstract the invalidation array concept into a library
> which other IOMMU drivers could use too?

Yea, I am trying to shift to that at this moment, hopefully to
combine the iotlb tag (asid/vmid) allocation as well. We do see
it could be quite useful in AMD driver already.

And I will address the other remarks of yours.

Thanks
Nicolin
