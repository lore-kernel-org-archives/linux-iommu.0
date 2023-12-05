Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E76A327
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGJ6haux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc4NMN2zHiLpjnPMcVziQILbXliNO1TcvDnYlXVY4UXaD1eh50NrhgFlccmaFW4ZWS7+tTfF64Hqn/bb8kEnpaex4iTwqOTiqyZcXq73QsTUWWmimRY5iEM3kX7CA2I0nA5RLVUMSA8mEzGjswHHcPaxexIOwOTOvN6LxHNASNTsMoHBm+LyqM+ytPfMXsWl2IxXzDbp+CyNk9taDbMm8ELjS0cEAVzS1mWX9/Wa1MAZgz36sxFGdCE2hvI7ScLrr9FTJj8s+c97+XK6+RrvPVAW0yPVSlto9OgiB9OHKJt1PXHrI+nH8AsNBPcJuJejvgX0mFPEBIgUR9Xarc2ClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/cw2+XdS6i2Jct4RIAKaTmL9UmP0xJAEKSsiveZDx0=;
 b=gS4SFhJdRt0RP47torehf5s5wmUThV8ehvOK+bPTZSxOM0iJfHGsQM8uSEPDRO9IxnBzINJh1iaqOkIlbMr9HL2+r3TlCz+aJDQaSCI0DnKgZ64yxBpxHnhdoLc2KTcFE8FoxdZwL6lo6WVjZ/DMYfHHwi51b/+WWXnpMwlrYAbF77wZbNgC8BctTTDWQafrM6u/+n9b+vRW3IDHsJfxjyMM8I1SCAUmnBmejNdkru12h8B6iLk6lQ9TjgV+jnnXoepQJVmb8tWpVhXcz+31J1S6wciWKhRT4MCzx+qLbtrss2CgispgTbmyzF9eiTZk8E41O0DCs6Jnse4BjvUniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/cw2+XdS6i2Jct4RIAKaTmL9UmP0xJAEKSsiveZDx0=;
 b=fGJ6hauxKKGdGFX7iUmu0f2fFxtBunGyl1G6lGU1a0Rp1YhmAcc+kpcXK4pyMjtJbOKz48wvH6cc0nlYwgJD86vAbeJDK4ahp1zSyrcZJ3h0HouSCtjZk7vEDvfRY/vyZoRJ+49Mn27/njyHNtV8OHnLPpi3obY3CnZ1iSTsprzNTsJXJGV3MRiJtKmlHi+DjAR0Cg7hajv1zSo7r1hP/Ycc1WgF70SXAMxRwUYCf4aB3u8okDY9LS7Sow/9txj2qdE1mUqp/RTdeXb2etu6UMRQn0RxkMg728N3d9zmyc2apUXjJrpEjLIHChJ6HkhPMqa2IkCZQyg0rCqjyXVwgA==
Received: from CY8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::17)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:47:15 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::e2) by CY8P220CA0031.outlook.office365.com
 (2603:10b6:930:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Tue, 5 Dec 2023 17:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 17:47:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 09:47:09 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 5 Dec 2023 09:47:09 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 09:47:08 -0800
Date: Tue, 5 Dec 2023 09:47:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Michael Shavit <mshavit@google.com>
Subject: Re: [PATCH v2 01/27] iommu/arm-smmu-v3: Check that the RID domain is
 S1 in SVA
Message-ID: <ZW9iGyHkrMmxAyvB@Asurada-Nvidia>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <1-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0493a5-74bf-40d4-7c38-08dbf5ba3826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uB4djdnnS/7qukNuAhn8Y61/rBg1RyMys6Y/APj2+nmc4FlylUbSw+dlXoKm1gw7Vc/4SXac4tmd5SM9c8iGa+sVKGrswzikjxsMOJVpfiSTZlsCb9C5FFxvz9b+mv1bMa7z4NMO+7huL63VBHNpYn62R/hx7m6qaJskX78OnYiEmNEVZyS+iXl34LOVxGdmWi9vKm6cQlaoHo8a9RAPT7XlWoH5canlzTP0ls4tZvWDG90DEQHwodF+UInEP5VzfmjXdEqo/us5vFIvj6vq/n+Vn39HZJ6Tauwg5it1tQm63jEcn3Xh2ZtMhX0zdlGc/0x/n7L5cpAKOe65xePkwBJKPeMpwsRvoOb3BaZmBUKE/5Rd4p+g+znP82s4ZyVhh/aiifnEsz7zAg2pl36lwZL6OsuFYxdfTVKcieVwhwFwig72acS/9izoLwb49FP9qQkmm24Ar6vgX05/SccJiTDLHMNwkjQOD8LoZ1i560/gpf5p9HSdo7TLAR8xQIOl/fHqQXgfghm+Lv4Gvq1HLRaOPqyVzjblh2LopWInHq01Exezxkde6unkhx2uYxg7Hp9uWRdZzWfOOR8Tn5HLcEpbX/5zp3FQoAd1Gd+Y4fmzlWqUMiNloq7VuR893ETP4FsqkOI4Jjx9d1+K30Kl2VDphZETDnmo7pfiqGrcVQFOVNwtLFne/MBir6WzSo0NaDBTBoyz5Hnz3lqP4tH4EcgQ7J3BVMr40ucAxGn565owX5h5vc24eBq0sxkL7+0N
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(426003)(478600001)(9686003)(26005)(336012)(316002)(7636003)(54906003)(6636002)(70206006)(55016003)(86362001)(8936002)(41300700001)(6862004)(4326008)(70586007)(8676002)(36860700001)(40480700001)(4744005)(2906002)(5660300002)(82740400003)(356005)(47076005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:47:15.6888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0493a5-74bf-40d4-7c38-08dbf5ba3826
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

On Wed, Nov 01, 2023 at 08:36:19PM -0300, Jason Gunthorpe wrote:
> This code only works if the RID domain is a S1 domain and has already
> installed the cdtable.
> 
> Add a to_smmu_domain_safe() which does a robust conversion from
> struct iommu_domain to the struct arm_smmu_domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
