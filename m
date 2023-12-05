Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F517F1
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Poh1syzp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLNtJMY5Z2JBZFrYYActc8SLjyL0icRdqBCPKeQo1b+0ORc3J1FO2gWM5bv6auqk9W6idAsTwz7pZs0bHVm6dsRZ2CnFUFQKpo59eTBR2bPLKvOIYFkuhiuPCJN2ki2RXKZSkZhWJPCdjMLEyqRXZqtlV6VPP2LZ3pXFLYyF1SBj81+OZLPZEXNqhryi6FKJpH4KbDWOKAzaFIy54KDHhnKXyvn+IrDzHIrTHWrbzPJkHsRWPmHbxlpqI50Sop57cZfKY4o32bhRf0WuqGx/f+zz3s3iKYGikNFAjbz1c4/RqjgHHtlnfp4agEaNhTbgDIOzayhCwSPqY4O+fkMm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJNXj0iMKLdbasd8swZZKMRx+FUhtN2l/USRYKMbEP4=;
 b=SwPNAgGURYZrDR8nr2x+OzcxwZ6abmk+cHjV4xQv42U9TYpbUzXXlQ5dNFUBvvf74LPUtcmbUWFp/YMJJUVV/vjZ+Mf3ebDmvJCRcSWPqqcq04XNbwz/rfsPkwNlTc7mIjlSgoysNfQKUIAopHtS6LstoPrIi18oq7XdRRWnv+XoR4aDqTBsrI1l5HAvGvRwegLPHnXJtXU4JzJeg2QALSAfCTFKtXQayGrQyaySiofdgfxl425MPnhXc3DO+qp1UTk0zwWlRZGwdI1kVPY76ZGiHiOHIxI3iWXEmOj9i5NcNTsSigsOzq6V0N8N/XYIVw7qnm71MhpCT4c1u6VW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJNXj0iMKLdbasd8swZZKMRx+FUhtN2l/USRYKMbEP4=;
 b=Poh1syzpgDCaW2MSF/GES8n1POguDxZMMFg01Q6YwiZf5ALjY8ADSuXXH2l1C83Zhw/xl7dlN63SoA2H1RjgbZeOPniiHo9Itx1qlrLhr/LmkcvGMCV5qNdpJOkFUL1qJOM9VsiwlTDa5BFylsgVGJlKu9d7Eg8rkEwmXcGuET37pLMO6FZ/kJVK4yDICGAsf96crUXzv9tcPj9QP6C4AYGNNYn6Anq1mVSziiFZWd6adG6vJZ77VbBQlkzjiFdAcF75CKJ9yO9gbU4d5v6S4syV7y148D9EB7dq9KZRmiIbJWR/+kis18X5QmBZyJ80RQQJu6yXXRB6sWVXP01jSg==
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 01:58:42 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::46) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Tue, 5 Dec 2023 01:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 01:58:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:58:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:58:27 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 17:58:26 -0800
Date: Mon, 4 Dec 2023 17:58:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 08/19] iommu/arm-smmu-v3: Build the whole STE in
 arm_smmu_make_s2_domain_ste()
Message-ID: <ZW6DwYWTH6IN2Fdm@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <8-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: dee67db6-bfcd-49fc-d69d-08dbf535b4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lReO682NPP8K9B8ZUznL0e7wGkET3naeNUYuosouO1fMQS2ATJM/tZqGfKbRqy7IoIU+SXjvJrWAGKLwQjdiv3zn080KWA1jV35vkkK7kz7a0TWNDpjcY5aiNZTanbmHdUKSX5IEhV7fQwv7BJ+z1f5lDqnieMhmRdjIIAkDcYMJrZzW/SNKBp+pq8KLP+PgfR30dq3QJ9aECH+TghLjhp3s8c9TVK1bmnInlcu0HSmGAyym3MQC8DlOurDrt4e5YFOzhd6j89Jba8+PHicmJ5qj501/JKx0Ej9DgxcgpeihTVU3IYBAVyRE/miEiigLuZxlymz7UqcwygeFaqsEbYjOlbNRkSveOEs7znDxoxPmftuNQ+g7yguYw6bqOEsGO+1H3+n9Z5prNd12inJ4qfEVBbhQ5ohvwASNIdNfjdLwxNBhx+Td7ARuGwPYemQLrAnoYORssIQLhN5+VbI6kgUNuXjeDbnLBKAhrf0czUqN/GKj2WNZgz1kCJ3b7RF486lGH/9DXfKeoMqAKfHyvzRJzzbPhqnTvk8cgnF0wcIj2HfLfr+O8QIxyOakANGYYPIUE4hBJrAniPRHg/oNbLHQVThc/CSbrPeQGx6uQp3Rl/lCz/LniWvGL4K7VBEjCwkr1kh5jPXiyM7UedkM0N+3N+t5q6csAdjXjaVO3L93YEGNzpVpAWaKsV7lpff99hv/ZNo3+WESHNE2yjZG0sqFM+PvXa0Y5qnNgJqh7NW7pM4kl6SPALC2bIpCaLkE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(54906003)(6636002)(70206006)(70586007)(316002)(41300700001)(33716001)(8936002)(4326008)(6862004)(8676002)(36860700001)(86362001)(5660300002)(2906002)(4744005)(47076005)(336012)(26005)(7636003)(426003)(478600001)(356005)(55016003)(40480700001)(82740400003)(40460700003)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:58:41.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee67db6-bfcd-49fc-d69d-08dbf535b4d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

On Mon, Nov 13, 2023 at 01:53:15PM -0400, Jason Gunthorpe wrote:
> Half the code was living in arm_smmu_domain_finalise_s2(), just move it
> here and take the values directly from the pgtbl_ops instead of storing
> copies.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
