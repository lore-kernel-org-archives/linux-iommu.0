Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30863D
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTYknutU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bweiaj1ys+t5yshl0c+46Lc6ehvnWRY9BocD5ToV6vwunAJxkbvnDmrpSbKCXUElStp+A3uq1tG4kD/vQnRUuF+Zca8rbKhqZCQdU8ZbjdxbgZGBf8FORxyz0WvuUvQCG/c8eJ0jyBCVHlhSUclmpMcRNg5azEtU2qsjWMUKreOFj6SeoZNQKYKNJ2vjIQlHkjahg8/0W52RYLpIw5BJ6pjcZQxcJoKDZFO2Z5mVSCpdFk3Rwzh5HzB8MoOs/JKBniGLc0g/XQcuEx3c5xbdwUjHMJxCaU10tJsdSJgrc/04VwREHmtRK2yMKiMgn4UAssX4ru8SaS8jnKdjXcCzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m6y6ArVBaB8AGvvq7UbUgQSOgh2a/5Kwh5gPXjWKBc=;
 b=M2G+kuttT2dlvqTI0Sf+A/QN3Iz1sjsXImEzQhsshxVCrmy6cBb987WoAgOzHEmo9tueZa1CrqAfsvbs9XgCrRDOBvs/B6wcP381ruC9rb+pLHtAEEtVmc2QDM2OynBrqLlGhXZ6ydPVG+2LuFdpkPtSnhJL1G/NEDH3TiwD+41mcmjMnqTDnA5yZzZ6t8gPbJoW2mZKKvAJtSqZRfmNBwjKYgUCyHl4bpGNOgZxeaFeVJs0PN/AX6A+TX45C8fc+h/2DE3u+/nvHIqoGMdDqSFEs0EwVvyo0yFKEN1MKwkteR7DETEQI+fcLiEY/hDmdZxoVJWUoL/HY8Wqq0WN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m6y6ArVBaB8AGvvq7UbUgQSOgh2a/5Kwh5gPXjWKBc=;
 b=NTYknutUaXZQIteEBieyQXhi4R5oPvtEDFV5MS5Wqk1nIxvY3STEjZ4k7H7LCZehHFA3BuDC+/3fBbkcWQy43bQyu+G5oSP5Pc7gYGASRRgaLlZ7PqzqRGQNJ+CjghN0UJ0hZZKXVDGLW1fDsWrI3lfiC2Nz+lJz0BbBz1uqnGnQLlDo/LXaCXvk4Ew8dg37tjLuu30hrdGNWJwfZg5axVHqHuR+HP7nLyqk9gKdofYdEeP6YarnAugNc2F/gsevGYl5ZjxM1FJzKLySSScVzEhtJgppr7vJ5JDF3jsAIdN/8PjhKBbI8SPk0Ef1aMh8ohD63YP/PshsJfS32zk2VQ==
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 00:44:47 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::ee) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Tue, 5 Dec 2023 00:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 00:44:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 16:44:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 16:44:33 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 16:44:32 -0800
Date: Mon, 4 Dec 2023 16:44:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <ZW5yb6xSkj5zP1Fd@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BL0PR12MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 91735602-8703-4256-7767-08dbf52b618e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/xmn7weQI/zyocI0Vjugudi2YQmApoy0LlVvg1pEXa7ltUt13egQ4B/5BFja8citcNKvK0Y5MU8XZ6/eayDdt7YfBymEkgbPsEQpZIE/aHVD1OCbqw7N92tU/LQt7kioHyU5PPoM7yAnq2YD8Yzh8bPhkcaW3htGaSGh3IOyC0NH488CyYlWHjMP50G/CM9aJtHl3mXrLzsU9epjusFXrVXYSZStEStOF7OnucCxaI+C+tsuqgT+oEOzEVGPpB8XYz0XUkQ3PMpzO7ZCAlWWRpKME/6QUOcbkCUitU95H05l90sA8sQbBo96kSXjyegubZ76DqTEJlJMs/HXV3RwhGWDgZ+OJHatK3Pv893OOpnu3Wz7SsnfM933kFQ/tH6ij7o2xhQXxL1Clgh7fCMNAnO9XgzS12pOWq6vYcpZGJb1YEVgwCs7WGxEdRA0BTlNc08fHX5aoE/KH4i5xxiFuqyevHKoxlIuFH+a1qtNX3HhvCAj44du0EB33bbN8Udasw4wS0hZafoJYKBqJEwgqg/UzBA1WqhTbRY7U2sPfNlpWEEUKsCWSlvf6MgYrm44nVtFAyV6clwDrST8B2DEk8yUme53jOsBGcCiawm5grQQqaXiqQbb/ZNvLozOkPKL4w/Hr78LKc9q0dRBWMU7QzLt4DLJnERTBO9AozlhRnGpto5efHkfX7f8AZm40cqETppfLju0EqOEZQezWoGKZay9lKaiTOEeRMDciZHLoKYsUwi7vf7cfZ+LW90bEePL
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(478600001)(40460700003)(86362001)(9686003)(70586007)(70206006)(6636002)(316002)(54906003)(8936002)(8676002)(6862004)(4326008)(47076005)(7636003)(356005)(55016003)(36860700001)(82740400003)(2906002)(40480700001)(41300700001)(5660300002)(426003)(33716001)(336012)(4744005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:44:47.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91735602-8703-4256-7767-08dbf52b618e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865

On Mon, Nov 13, 2023 at 01:53:08PM -0400, Jason Gunthorpe wrote:
> Instead of passing a naked __le16 * around to represent a STE wrap it in a
> "struct arm_smmu_ste" with an array of the correct size. This makes it
> much clearer which functions will comprise the "STE API".
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
