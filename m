Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EF4A07
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m+3Evi6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiIOtSzb/QTcndLyJ6tXRIamFwDJugN8ByhuyTwmFxN0yFy+2He3y0DClXEY2d319p++K5G1SzEjeeNtQFEppNDIvfanIno0LoJ9eKN//QnM/9OcRGZUevcU3hFasyHkky41+BMGd4nilQGbekztlHDWyW3UVepNszak3V4xZ+X8j1I7mudichLdv/ehtbFoMr6oEGOxVyN5RMJ6IA+BLOwXt6vdoTXPBe46w9sR04ISjRhGgVGjmdFtIu8Joa0jrjudswGtMDZkUSqr0Ma1rakNNjk+VvANjH5gz4eiXJoOQP7tOfINHCZB2bHusxHSZ87fmQlDjvyRYkaCEPgyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVuBz5UGJwLlgVW6aIwGqw0ZHiVwJx53H1KSFCMe6rY=;
 b=QpDMp8tqsgsuDlGf80sPfFkPlIcy6FPVKvqQxupRj1qCYdyeYekNzQO84kPyJ4k5tipBWTjawhy/0tf9iE6loHjte609MxPWpJhX0kxaM57pSgc12Z6MgslwlQMd5xC/YNQ0Z+yluoep2F89qQ4XXNIOhmjOwW1mJ58sY+4rBh0OvGfermnSkzIeBPxORBznCoQfElXDet7lWV+9auxvJMjli1OkYVN6GwWmohnx2WbKKqwT5GTtrqNT1ODv7WhMbeXs7PJN2r3H+2F0PwJIB3M8x8juyM44UnlW8kMfOMCcZtf2ajfMfq2GQ6DHPzhT3lQb3t3Xs5CXzfEqZSfUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVuBz5UGJwLlgVW6aIwGqw0ZHiVwJx53H1KSFCMe6rY=;
 b=m+3Evi6QGMa2M0LDc/NGujW9Hb/9taBeWYIiqLhBEma3Y+Oc/HEFQaDy842tDEwiNyrh07xTMgmfZCPiKV93mudSoQWkuTQk+C4xXXqq+3TWt4rMtMTbKRL1V1zJzPc4Ng0tJogctoIet7xeYQ/ERz+2GuNSiz238nAWCwoceotJuflAD5JrM5ralwJszqNnfkZ4/FPdhpJUGsjwOV5vZl2tYAZ2vw8WuW6yXVnGg3I+AkhqtSTKK0W5ZIFjVWtoD6ojkkqcVqPboXQhQknWPpjI6qLa5ugAOWOL1OyTJynKsM0VAxATmKolbqk+dXPRt1tQjfumVZCvqcWsbpc/dw==
Received: from CH0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:610:cc::16)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 02:13:51 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:610:cc:cafe::bb) by CH0PR03CA0071.outlook.office365.com
 (2603:10b6:610:cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 02:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 02:13:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 18:13:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 18:13:49 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 18:13:48 -0800
Date: Mon, 4 Dec 2023 18:13:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 10/19] iommu/arm-smmu-v3: Compute the STE only once
 for each master
Message-ID: <ZW6HWwkxY4N/gaTr@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <10-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b14c8a-1fe9-4bd7-8015-08dbf537d26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+qk6IRslRhwvJjHt1CgOMH8ps2GPWRpDtAkMLgzwQOo3oGgLnkb3bm8AIpZDQUGueLNE25a65qjR9V8aRuMGJGWMKr8ZDE1vO8GeKcPgBZOuW5OZqdrHMiT9qEiExZ08cpbePUac1DVR69JesWzbyxUY6PuGi8uu6UZuASmwHSyKuMBnHcOODCw/5tFCJfbwwS45BSBPdx25D5NBz0aJczMTy+gJilIsMVw19Oi1899fRNJVV0DDxNuuF0wR56TT+2DpeUxqvY8vA5RaZMlWZ4Q5JI3PxInauSkRfR0ZM/1xEZCUzsFHItp4SydFWRKE7nxZWIvRdYk6saqUAz2oHQrlRAEQMkK45Qaqwz45hHj+xP79CgfdRb5dTlu5cMOXe95RPyRBv5L+jGV9kUlE6MwaeiRwYDz04cfgg+tkgv90cFPLBogLjzCRSJPCQJm+pfE2KVGrwLXMGNAfEiWaC6CidUPtJtI8goDOdPkeshXIh4UAn1kvMV463udufitNuMY9KVgqiIWNk0hFdNfI20Vcr/o8RYWPG3kae6IUVGj/CC6ipLTsA6AIC/Am0AeKR/UlTzoYKkb5mjK2i31YOQIQ4uNSabWrFUb9YThxVM6VLIsJSmDHgaGtBN0lQ1LqsMMuSvnsqX1keazntt8DtxaFfdl4Q5BMCwmQWoAiwZx09s1gP3EUwEu3RJ5YTAmkkkuOm+r4sjLADTTxosDOz+NGYrMn2c2n9k+01/gEXXcyKoSmlcBIu4TH8PivQnpl
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(426003)(478600001)(9686003)(26005)(336012)(316002)(7636003)(54906003)(6636002)(70586007)(70206006)(55016003)(86362001)(41300700001)(8676002)(6862004)(4326008)(8936002)(36860700001)(40480700001)(4744005)(2906002)(5660300002)(82740400003)(356005)(47076005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 02:13:50.3917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b14c8a-1fe9-4bd7-8015-08dbf537d26b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835

On Mon, Nov 13, 2023 at 01:53:17PM -0400, Jason Gunthorpe wrote:
> Currently arm_smmu_install_ste_for_dev() iterates over every SID and
> computes from scratch an identical STE. Every SID should have the same STE
> contents. Turn this inside out so that the STE is supplied by the caller
> and arm_smmu_install_ste_for_dev() simply installs it to every SID.
> 
> This is possible now that the STE generation does not inform what sequence
> should be used to program it.
> 
> This allows splitting the STE calculation up according to the call site,
> which following patches will make use of, and removes the confusing NULL
> domain special case that only supported arm_smmu_detach_dev().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
