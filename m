Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297E23B0
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LFfn1/Ak"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PONqnUsYkUENTI5yCjBN4CAHo4Hl25XfhnpeoTrq/ZSZkoJqLSJJVTTct1NS7CsUkWnV3K+qZeZCVHppXH9Y/wQ57qWIeQ7bi1OZi86mfsSd1BO1KMyEV1nGBdsUCr4eX9t0FeBzI7wUi/inSSbLrE7lPWVTNcKI81g60YfdmoSjOle2f/Jl2Tg23OC4YWXdLaJwcfEixKJ3svnQMBFEAfit1TC0Sl0ZtucyAAJ+WY8JMdErPgShVG13mwGvBb38MMqzU1uTmJw2Kz0kUzHFNmxcNrDNWwBpg+G5dpzsOE0eaK8ULHvXjrfMQQJA5tlkyYMBKiIFmdvmQifT2H335w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C5k6Ykok6mT2poZM9+oi33anmHcyg1erQp5MgyNujQ=;
 b=SyQWHB9EvKeDRB+NnF/u3mAX01R/HOPsh/96dPTlMr/yxq2IiH7QwlFntTv0PFE3eQQ/jlNlGyAVD5WI70HP78aQ9IdfHZlvChRIZnAFDpyYmhXp5q5RrC0yl9eUKfF+B4/jofQZNVF/oc5GNMmKkd57mRieFyqvbIQ9m5TY9vkBBG+ol0ab63mRBqjjKyb04PfPHL3fQpuPq5+P8Yv2n2hxvVbwMvCaA1IKQbxsmNgkYzKP7377is7sZfkyJ50cGslpjf53FHgkMBa9nHiKSY0WDN68GaKXVUIYmuBlF7zxhEBss7mMLCFbiJaejwWdE0tp6aiO40Rw2TEVJ427JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C5k6Ykok6mT2poZM9+oi33anmHcyg1erQp5MgyNujQ=;
 b=LFfn1/AkRwwJAJUuzkPvRU5gbmnXW6DFlPA5A4bOMHNWdmdjMuo3dU0G1QUJJCaIePiQEfk3TnNOCFxB78cStlJ78ob/IXzBu+2WztJRpNqZL0rDvkTqNj116Z/QBbF7xgafxspCcr7eRpZE+u2mce6jokr6HMExWJDiuOIXwJxUCbS8xA/B/P3BwvVakL2DzcwCAtLPw28yhYqbmSNoIrYS7cSw/nXtq3Jev3eGjJvYfq6rixywPiF9/FSUBw4qPlThxCZ8gxWMa9UVZYd8aPjlTySpYSAwY2K+968NwzUWi7Y4VyDFmcc10Co/rrKI7G1rTUDKmLAgE4Zq5cbzyg==
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 01:44:11 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::8f) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Tue, 5 Dec 2023 01:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 01:44:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:44:01 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 17:44:01 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 17:44:00 -0800
Date: Mon, 4 Dec 2023 17:43:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 05/19] iommu/arm-smmu-v3: Consolidate the STE
 generation for abort/bypass
Message-ID: <ZW6AX3z/C9bA/ZiG@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <5-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: d321b10e-cf40-4629-2c0d-08dbf533ad12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/zl5osxC9DOsTgSeyjYVggG3641JWxFqK8I3/fb9rzwzrvkI/Ki6SkI0LT8trEAvUJPTRFXRlj4pm3T07zTQOOS6Xo5jL5qUZcPQSZgnocqF9wILK0ncJmFrryub+6mJU+qkeqR+b8/lg9eOQxNSv0rCnrzUZsf10ulJQdlEqKbOjFPp2nTyPqehDd+/9lwTpcN0IgzDVgQihXvVljUwT6xtbrlPvGin9/PU8H8N7g3EibBaAkwR2gY92847h/KolHnj+1hkgI/Urgr9f/T3VXmSrwZ7mWGydKciu1BTPeNmGFaRFXWhYl2kmpsRTBPHwKOzqjl1IfMJhri8SJjKraMb/HuoVAbLhSXizkA4ydpJowX5I0CGmtN848Y6I6spzfP8jUQYWDoBGzvUghYLXUs5HS7Y7UFKByQIej4migtEu0SMtqw7MgAnF0oMMDtZYJ3txP1W3PdO+bb983JPP4N28OGeK9p2ArQoou5jIWhmxw7yVRRk5gJGcppGwqHNL+bL1jLPjnHk+xpksHHIiuUDgooPzkZ46c7eHJlA4dWNecKb9F4+U5W3tCNP+mKfVhxvPz9VT7GnJjJ1DlqZ/4FbPnLdxITZkTtgYsZPX+ENZarWo0zS5/rgxJHvS1awz9gej4QlmrqV7Q8XLfVVFsl1W3ewPsDJr4I0fw3SS45mFJHw/dDtt4OVuWm61a7nUDnQkjLfGtrGTAMq1h9Ecigmty4wScQzJmvET2Xn93Pjdu7luOjow/kDOAM1Tmm
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(54906003)(70586007)(70206006)(6636002)(316002)(478600001)(40460700003)(4744005)(5660300002)(41300700001)(2906002)(33716001)(86362001)(6862004)(8676002)(4326008)(8936002)(36860700001)(40480700001)(47076005)(7636003)(55016003)(356005)(26005)(426003)(82740400003)(336012)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:44:09.7438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d321b10e-cf40-4629-2c0d-08dbf533ad12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

On Mon, Nov 13, 2023 at 01:53:12PM -0400, Jason Gunthorpe wrote:
> This allows writing the flow of arm_smmu_write_strtab_ent() around abort
> and bypass domains more naturally.
> 
> Note that the core code no longer supplies NULL domains, though there is
> still a flow in the driver that end up in arm_smmu_write_strtab_ent() with
> NULL. A later patch will remove it.
> 
> Remove the duplicate calculation of the STE in arm_smmu_init_bypass_stes()
> and remove the force parameter. arm_smmu_rmr_install_bypass_ste() can now
> simply invoke arm_smmu_make_bypass_ste() directly.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
