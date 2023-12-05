Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99AC14B
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ph+bfloK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0KeBIh8kajsw3rQp0IAcN/hONdnlTJdz/+owa2+Bz9k3kqPBwFLBcsplZ03d0/ZuiPFu6wi1TORw99zVsUydJUXNMaGXawqpZEfpOyB2EFkMnZOGC23vcEHT19vXipE+iwCpwz0L71WfkiptdQ6A8wGjYshXMFMaBRrCcZ30uVJEgyIz6pFJP/E9q1aSwyj98dciH2zNXHw8X5h5PL6h4dZtquRYI7cUkXxinAQPH4hlLwFzVSKGwkDjz2tpCvCZRWc/+45a+0yeIyWsfuelDjF3F1HWmJcPGm1/4pxJlIQrvEsVSVMnPbXBvW34lt/TytMMlqe8pNgm++Q8y/tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mIhDalnj0Vv2uHdtDOfuAB3H+WHvtFRqmoxgV3ELSc=;
 b=exyhSba2fgnAkzhLdXimViCUEXaU95zQS7nesmrqagJ4OOtIhMFAQ8dECpoNpCXOD1V5k1jYYtDZBXwuHRzN+BOgoIbnxRaWh43emaPgwpP1wzyJ5v/xaRdxT74Q2YO8bloOeyjtGG4JVLs7xMq9w9TVEk3nWoRnOXdK60Dcy/y7DuU8wAJKzmVGK1pjIqVylISkwu9acHNx10/YkmHKwVigPiGwmkzJ8nWrN6Uu/neq5ntUaGgrjx/UklnFg9BYvP2N7RjHQGb9y4jwTRN/RLvHumHODFZdc9HCvEghuj459n4VJBUiK2uLOGTfQxBeillEl98IfhopeNvn1CmDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mIhDalnj0Vv2uHdtDOfuAB3H+WHvtFRqmoxgV3ELSc=;
 b=Ph+bfloKkSf5P1ZU8bVoPjVh9K9RK0bAeyafoDNquPgW5vs7Tj/THJ+jUxl0zXEJueE6KlTwzKagAmuj/HoAS8X/ag5rxZPghm8NRjS/J1AA3FmIzCYfqnLJGsTo5wSRXQPHzfri1i8TNx1UdxjC7ueWHKZiGiN/hZ7Ig5bm26XvMtVZ5TIpjux5WMShgybUH3i9MjjgSI/xRB5UXFdWl1zeWYnCUdIUDtbf4d9Y2ON2ct1ODHwAVy+TjTeI30IOiHYCh32gYkCVgpwi5gRPGHVSInXy49SCX+eHWo8AnSpVI9Il+Cv+bGATlwLig9y1E2xzug4HvHOgDU7RJh3HGA==
Received: from MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 03:54:33 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::63) by MN2PR20CA0064.outlook.office365.com
 (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Tue, 5 Dec 2023 03:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 03:54:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:54:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 19:54:18 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 19:54:18 -0800
Date: Mon, 4 Dec 2023 19:54:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 00/19] Update SMMUv3 to the modern iommu API (part 1/3)
Message-ID: <ZW6e6H4BGVWw7C9o@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: fd940f9b-8f47-4bb0-0384-08dbf545e443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	euJ9OZIpipV/sVg1FmezGciRhRe0hxyaxG4hP6S3nN03hmxSnLDarhphIA9Ztsp618JHor5pZEIs/AmyrOldMxpc6g5kynDb1Gpj6vjMVmHq8I7RsoI3lt+790e0QwnLxxvXVY4pmMfZuB0quxV4uxHDpTOwV8ojGScjZFjpOc7HLAJ/0pRrzdjCNbDzFS2NBvvuIjEdvMTHBh35zqXuwaRj9nIMnPFYep1EtO8pX/zDWhLdHdkWttvOXwds0rJ2+uj/ZaCFwsK/YSJsWUs0lbp6ngUyd+Cpz43LPQ1SeDNlbUt/W4JZIu0mGeJGHJBvj3MKs66eE4RbCEq2pGwe6g5ALQY/On9KuVXBz1/A53mxLsASWYqj46sRBU4nfO5e8bNAv7qbgnSzKds5tyL7s3YE4if2EzrW6f2eEUHbmxCzNCQ8A8cpFVvdq0N5fBYVp4stIgemqntFAax75WqkQK3N0dsnhZAK/kDhwsya5/la9e3isSUZownvCl8AzFgUkZFVywCG99kh6CaWCBlYkU8InDWz4xSRWV5AzjNDHXl/TtCsDdpmMhPbYeyRdbO5j0IDdyK9WPLDA4jaF9LLsESaJRfyQgKNlT/4qMYD4khiCwWXhvL8ZZBAUqRl2ilD5qpHE2dsPEF4ym7oSBCXjJLikMU3XjCCQ8xPg0QIvHJW/wvwgsypSPu4UYiigZCYUvPvpYQm5mlUp29LJgz3W0h4UEvYCVYfYOsqIh8AX0sAK+JR7R+2S3h1HkpDW5SJdojGN9gEVwLyUylXETiT3/yyc0Svx5lLgYAYndLTDGA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(70586007)(316002)(70206006)(6636002)(54906003)(40460700003)(966005)(2906002)(15650500001)(5660300002)(86362001)(33716001)(41300700001)(6862004)(4326008)(8936002)(8676002)(356005)(7636003)(82740400003)(9686003)(40480700001)(36860700001)(426003)(336012)(83380400001)(47076005)(26005)(55016003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 03:54:33.2327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd940f9b-8f47-4bb0-0384-08dbf545e443
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548

On Mon, Nov 13, 2023 at 01:53:07PM -0400, Jason Gunthorpe wrote:
 
> Overall this takes the approach of turning the STE/CD programming upside
> down where the CD/STE value is computed right at a driver callback
> function and then pushed down into programming logic. The programming
> logic hides the details of the required CD/STE tear-less update. This
> makes the CD/STE functions independent of the arm_smmu_domain which makes
> it fairly straightforward to untangle all the different call chains, and
> add news ones.
> 
> Further, this frees the arm_smmu_domain related logic from keeping track
> of what state the STE/CD is currently in so it can carefully sequence the
> correct update. There are many new update pairs that are subtly introduced
> as the work progresses.
> 
> The locking to support BTM via arm_smmu_asid_lock is a bit subtle right
> now and patches throughout this work adjust and tighten this so that it is
> clearer and doesn't get broken.
> 
> Once the lower STE layers no longer need to touch arm_smmu_domain we can
> isolate struct arm_smmu_domain to be only used for PAGING domains, audit
> all the to_smmu_domain() calls to be only in PAGING domain ops, and
> introduce the normal global static BLOCKED/IDENTITY domains using the new
> STE infrastructure. Part 2 will ultimately migrate SVA over to use
> arm_smmu_domain as well.
> 
> All parts are on github:
> 
>  https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

Ran sanity with part-1 alone, covering S1 Translate and SVA cases.

And ran more functional tests with part-2 and part-3 (nested) in
the repo above, covering host-level S1 Translate, S1DSS_BYPASS +
SVA, and guest VM (stage-2 alone, and stage-1+2 with S1DSS_SSID0
and S1DSS_BYPASS). These should test quite a list of combinations
against the STE updating algorithm.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
