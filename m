Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF88BE0
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1q3c3JI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsYP+BulMZc/Fo7mze4DKzEHdVO2XUh2Q4BczsNs/85MDkQ0RsE9DlueoCKWXkRNtY+vE0faz17ReyuKrZEa8nTvKkOrxGz4rZdpTqTEGXsQTL4C7GUbQ1/GS3n9nG33lXQnVEuhsXqXJdN4tPPfzCG5P4SGLtD4q1AeMPEkfZNIxM81mgnE54l+mors9e34pQEzw5dL0F13Gq66TiGkXu7sEzqeQ7o5hrvyNRHN39YcNLpBSFcPQQG6Pz6exfrO37lknghgJaBokf7QW+VNrcTAZSePUEwBwWV/it0uPwjGUcPONoc/yql4wYIDmfUMvndUSlQ39ebRAGhcV5OjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH2a42tRzjvRp5LZMcnkfcvOpKZq5CY5i9UbR6wW920=;
 b=YByU+BbJ9ACxJkzQxUmSg7x92HqP1Q+Uoz10PKT6YR2iHl94Diokxvzvbn88skJbXFaucl8XtUqPsBNW//H9Z13POGCdD/EowzUTbJiJsmx1WuI2OXCIrFtTtPqxYXFyUUG2EiUzFcYuFw07idr+qz9c65cgO/0i8m6DDvlNkjbKjxZ77RV7LDqyWn/qLjFWqb5mjiiOsEGoIxoMjXZGmqguV/iZGWNBFSHVXMCqFUq9/jrqbnb9tYb4ZMAW6bf/47AT4j4jhOo4NTBNnrH2j1gx5wkkVZqrQ6aUoqQ3S9H1e7ve2L15qmcmU8tAH6tL22Z/6M1i/UmVoWBO7Hys4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH2a42tRzjvRp5LZMcnkfcvOpKZq5CY5i9UbR6wW920=;
 b=C1q3c3JIHvm4J3lOm/9U0ghhziaAZIACD+vOWL33uLYqHKxBb76c2e2oChWvYuiTrB55J/FA7jz8AV/MdXD0k/Z6R9PXASB8voBGMdAMAc3+lRNq+hIKPt71vWkibR5pGzLzdoS85rd3U5N7lXHwSuRTQrPGb+BceJHJd9vZs0DskObdlO+vyfqq3zVESkh4KZNotUdmZXx//3wukBJfGUErMeObJBJGP4Ca+0GMNahexrvtgnylcNgZW389Rxx1Tali5zMcuGwELZu/2c9wvpqyqScmd3o46AKjn//MyBGLCBvWFDLm4GKtuEFGXAdgtpDQXyk6isQ+5FGRq9qWyw==
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 04:08:11 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::33) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 04:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 04:08:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:07:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:07:48 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 20:07:48 -0800
Date: Mon, 4 Dec 2023 20:07:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Use the identity/blocked
 domain during release
Message-ID: <ZW6iEnsgseEJkHE1@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <17-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <17-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 705bc7eb-2583-46db-5cd4-08dbf547cb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YGafhxgmsGDzgBKI7hDQk5xHHQcOzL+wob4RO97PZJWgKCWfTZVT0kiyEi6PoXOs8QKQMEYRXd6Rt1+6vH1Dirh3M7QUD3J4p39zBey+ViYdOwoE27ZZaTFOGM8LVXpZn7S2OUxu5pIfudKfKH63W55GAxTYtM5dJXZm+DCuo8GIViBZgCRCYZyOpcpP39Gq47BeZJ2peqLk34fXxK0XrVK+E9zr6hP2uYkYhSJTdftV84hHahvJjqxrM8q8etv2Ug534G+kvzCiY+hP/BFvTpRPrRB0O+VklIqoM6KtlnUi6+5OtbJHen0JS1plpeb1rIYIOmH5tN114zbqkhRUdG2wb0hN+FCnksS0KEjbFvhz4QhWsd+/Kl5n3WpujOxvINVZReDnnqgfBz8R2b2FdHiiCaX5YE1Hl2SAcZ9wIOYrlVcRL+5nQdmgbPmkPYhebBj+Yt/ZQXiZeoyv5/Iy3DMstZjjnFczHIr805UAu+oSqmJeJoB+2+58lLMK6o6Bvmes5+rJpWjiIYTP3VAJod3Yb9ub508XDEzlmKXgmCXt8t76RBhVbfSifpb2B7WTu0d0q5DxIXOVBxATG/SNGI2zXqTn8/Oe5GDPjedaB5lZcYt6FUItxs/ZAFzxGvwLtOGyYNWKF3GxlQ28+UKG0meBVL9emXuwjsJXWR6NsK/w1Jfv8GK1iUp2Wgsn1DOruC4U19+mFeASx2ock9x9RDt00XhYTr/7c68fQmFZfX8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(478600001)(40460700003)(86362001)(9686003)(70206006)(6636002)(316002)(54906003)(70586007)(8936002)(8676002)(4326008)(6862004)(47076005)(7636003)(55016003)(356005)(36860700001)(83380400001)(82740400003)(2906002)(40480700001)(41300700001)(558084003)(5660300002)(15650500001)(426003)(33716001)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:08:10.4271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705bc7eb-2583-46db-5cd4-08dbf547cb5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

On Mon, Nov 13, 2023 at 01:53:24PM -0400, Jason Gunthorpe wrote:
> Consolidate some more core by having release call
> arm_smmu_attach_dev_identity/blocked() instead of open coding this.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
