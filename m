Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F80233937
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147470; cv=fail; b=aalj5MwYr6LS/3EM7yXpNtuVx5GxbsgH+V74tUXfjDJArONo7RuGpD6MqSw5zHuI4PW8SXEWH4oEmD2KfpUf8EExzav94MSHLCCKUwUFREERaqHupfpiGscs/CUrqJYsTzubXyRBLBeAEFa9qUjBpRAeEbNwpqoErhXD10QE6LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147470; c=relaxed/simple;
	bh=0NGCQjCLyUY3YwR2oLB2UCote4Pm5O9uT0Vuln2JFdM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlB8hhr9LvHFTf/PWmVNB7X5sEQAzVCu0QdZxfTlU4NPIVSMFswEGuTyDu+CfoiLlk+5+yCDpM6z6LieLJYuGBp6prt91SKvdV2QUTPfSgxGxSqBVgELmaDT9qcMKH0wTrx6lGNPz2J0CGU4i8xNqoj396i+kJhc3myliHAmbYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qN3aNKGv; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qN3aNKGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0iiPLpCrgqF3XQSCOuOB3E53pGatQoyL3aqNvjw/aKfwsdL4OOCfG1b4kGTWIKNsHNwSvAwpCR26mk4vKfB9BHIHT00rLHKeho2u+Gg8Z9qgZ4DYKfBBgW5DLBL7FYHdN131n2GMbARbcW8bCR9EmMgkOkLWPblSV7ai1GCv6AhqcMR52X1KFbFISe5HGDsFic+0E3RF94x86y0hkLbssNdwu/8DMYnuRnk7k0EV+EP9esgKGfaJOdLEmBthPx1DsQGJe/D0DnKoYAY1FhXOOm/2Ycg3Vbqqzn4g18RaLrf3NCUmyEiR9FWwgIOlZ87Ar1JKn25ZH/MKGVMPzNYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaPqsnevYHfyxj/8LHZ7XcH7CTej6Jr8t12ZOKmhuI4=;
 b=y8KTOOu6uTEMYK/eKQYadifevbBrfvsPdyS8V8sYnPv5ub8FV/c6A8YERssUximFPsGIgPdZO6kfGTkjx4EVenLkju3I2wkwk4+AxtGQybTnr8buv1swdu8ltwJxm8AaMsMCBQGXokdHUNnQu+MqyJ2tdwyCnUFeUQmnRHYZ1AOEyd95ppXNzs+9VTZuBqe+u6EPmC2zSGd3x7oR9wZXjNfNcjqXxOnl+2gcdaGsA1ijo7tV4DiU+1FefwYEutXezbSmRMSU4mxgh4Hnv60KuQp8spOVzxLbz8RDe/aPjg2qzq7coPPuEYmZWsqR6EEcX/YjemCBzhrrekyv/XZvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaPqsnevYHfyxj/8LHZ7XcH7CTej6Jr8t12ZOKmhuI4=;
 b=qN3aNKGvEdqssrBVCrzTroukEARu4pXJqtgc50EynhJ2X5Lu3hZ+eSmtzEK2cq2k/fH1greywpXdn2qBsaLPXJhnymvkSJdUWjqC+JsgPLw4ksNBP/FcRkJDKNsSH/Fz3jH6G43QjfxKzsfVdOspQqz6JaPKu94zgs77tffXHjvQxraHKxtUsB+O9FLUEU/Y8zFrnvBl9HmOkbLcWx7mtJUNfL7vF2lZRsdejUJOofFPMEYO4RTaSHAkmX7s7+FoyI00zg8nXciMqWw+sG68BdMsuRAgKz5Tcun40gV5eQmhTKrEo+UzAIGFzg90jTgTPqIEL9Y/YKTfrOoW4YAgRQ==
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 20:30:51 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::4a) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 20:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 20:30:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 15 Jul
 2026 13:30:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Jul 2026 13:30:25 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Jul 2026 13:30:22 -0700
Date: Wed, 15 Jul 2026 13:30:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 0/6] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <alft3llhZ79t17j8@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <20260715201521.GL3775915@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715201521.GL3775915@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b74dad9-2e7a-4fae-5021-08dee2aff662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|7416014|376014|10067099003|13003099007|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/MNn6E/4fq0EWVAtOkIoiPwCLjpMlf6V6qIdL6ipQ1fcJKxxYIOWlHMEagkb6cwpj4LXAWQX43U3PwjYxh8pUfsfz0zjJ+nAUTbRjKIAbuTqLvDWhEOmJ2wQJvEITuWhqNF9aHz7A5UbIhW3VTWSpS/9+0QOz8G7U5/HyylcQaxVtVico8ywLNIjvPbGNLyeHeGw0aEh/RRpccAg5oZMP3PQb4xG+WipEwkj/p59jxrCNMeuXbZNrrGxRSPAziwILapdyqIlLgmJFGauahNxCfrXK0rY/UiEXogKLnwxqYHQs0+rdmBtiO40wHHO0/YnwKmOqgSl/uLMu7+VxMFT04u4UfPakERe6cYGeVnF8q/seM3UeFTuBmHoMOIp5ty6q6JLSuxH3CNmMSN7RK9shy5COyuPTl5kPN/wUnQKv13FC6PnPOC6DYEp+YwFNMPOdwatDCdomVUj2Z2bauHaeQ7aB+eq5W7oM078zynr0X5ygbaps8FprH+Ym0ajMChGmTP8MoqLkQs6qcswuiAv/Jsjq3+oTQwD2YAFDzEhmfpK5CS9aQQV7Cg4az8jETz43GG/wFstV6UoguGRJ1hU104AuFhumy8TZ9tGckeDwFRoEcysS4v5CbN8IAbhTnRttNSachFWGpF6H6yClnznJryGPDPcY5c3fq2yfb+NFftffTAQxsqvVtqHsO4zcdljNSmak7ZLYDzGe7lMCUhCFA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(376014)(10067099003)(13003099007)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	97Tv/BvNvxeVPd/ckvMzw376zE3pBOTyGJ8HvykHr7zDbVeBUBcoZJvDsCdXUxj0eOwVGkGPEb1RUL49luJd+79dzKHw5Nbg/NTyCGBydd21yRcEBC+mM9u2J8olg6PT0WljrghpD+WSMs6zsGY0kB8Wht1t9awAla2EeAULhTKn7T99/soDs7XD68AHo29AmvDrYcHgeCzG6rcNl/PmXWIDKniR56rzZmQXZYUhtKTWM/4w6lgr+7V6ZvDCBz2TwVRYeWZvRFT4Kzjqv1VIlbJEC/EuQ+DRxM9wQegD6rL3OPtCVwyWcT6VvXpZ721SVDTOX+rquBJtPwFH7uSAv3pRgf+dTk/zb2w3zui0jQc6t2ybZUfUETC6xeL5JKnqcsF70oO7XVCPJ3XIVi904exxicsb9JL/HgLa9K91ab9XvKL+cOjArG6M4JljEw17
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:30:51.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b74dad9-2e7a-4fae-5021-08dee2aff662
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

On Wed, Jul 15, 2026 at 05:15:21PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2026 at 11:48:46AM -0700, Nicolin Chen wrote:
> > Nicolin Chen (6):
> >   iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
> >   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
> >     commands
> >   iommufd: Iterate the cache invalidation array in the core
> >   iommufd/selftest: Convert cache invalidation mocks to the core array
> >     loop
> >   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
> >     array loop
> >   iommu/vt-d: Convert nested cache invalidation to the core array loop
> 
> I was tempted to take this through the iommufd tree, but Will, I think
> the first two ought to go to -stable through iommu ?
> 
> If you do that then maybe I'll pick up the rest

PATCH-5 touches arm-smmu-v3-iommufd. Merging via the iommufd tree
will conflict with the PATCH-2 in Ashish's series (via iommu):
https://lore.kernel.org/all/20260714104202.1664187-1-amhetre@nvidia.com/

Maybe it needs a shared branch; and then, Ashish can rebase?

Nicolin
