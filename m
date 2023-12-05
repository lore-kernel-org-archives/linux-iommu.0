Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F6812
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZZqMkuM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMINjAHDnhEWyoKQXmeIVKfKqmV9eRLF88fuIizppWOTKem9eJd/ksi/ldF5B4VecMDc8iG98VMhBIZrIuwGhKZZJ46YnRuJZUFbQTjOcZ3ShfnD51ING8MHFiMXEw1feB/yRf59kH8wVp6BeeOAqng06zSAUGXXG4koyTYZjt7DZnZaeYZU5u43y4LSiRSJlUIjUUnjcGRNYQl5gGTd97wbKl/gQ1JlnP6Z+Aj/+dhQQQf37KqUIlg+b7BBKJeCh5VYjF18+1Kv9N2/bK7DYafYZqjrkymp2I0WEkp+nQ1g3TBr6ROgLCPmhQdSBgkmZzn0rwSSN931DpIZrBKeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r01bJroAvTg+68/BAMWsGNyLUShJ2APyoGFgfCin6PE=;
 b=bYPYXZ7marh7nkm0j8kwwMKawVk8Q/vLzDIlMSSgI0hbzLxMmWU/p+KGkLxahLnIBE3zZ+h2og4DfTc5i3x/hJL6n+ICdnd6yll6AOfp5pZ/lSwub5I1N1BjtlE/4R3txIyjoNoQfnCMFFAIdI/4GozejMXphpsEYiaTCUO6jiFaI1WEWL1ZX1nc7GPVUoCNWrBG+gXpBOojBDLh0vW7W9TcIxzn7ILdHF586eJ8kbPPXva6ckfuqXGSUX1YaWxivDbkOdZr+0n8DnUMG3W9DDbIUcad8TTAWoS9AQK5KHhrvoCf7oyNOSGHeYi7+j57/wHvxmydepcqk4mxHhRt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r01bJroAvTg+68/BAMWsGNyLUShJ2APyoGFgfCin6PE=;
 b=XZZqMkuMezXnJU7Qy2BALn2mQveKC3Yvc01rFAzfIm6ed2B26Rs9li/uZwCPqCtm6D+RUXUnG3B09bZM1jEXWL+GaMxRTKoqvcG3RX1T2gu3OvaLMOTI7yWHGFgl80w7brcCYbtu/wM0ahTZpbzUlXDFoUkFXQ3fKT1AYqdkDzdmX/d/BvpAywwFyVb2DdmNlgVJEg8EqrsvFNOSfGhSURbkc/mYNqtXPSKmfvTIp1sQQ7a4aVI+Vim+vtvzskP/1KcbCYRLaCAmeJRN5oS9zniiVRmKIODnwsEQ46VmrnpcQLwnw/qaVCetdU0AVMTFFCo6ysigKz910sL3D+7R8Q==
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 00:47:06 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::d1) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 00:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 00:47:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 16:46:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 16:46:52 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 16:46:51 -0800
Date: Mon, 4 Dec 2023 16:46:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 03/19] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Message-ID: <ZW5y+tRqmpddDNHT@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: cc16f9fb-3a90-4098-d20e-08dbf52bb49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZwwW6Jf3TiOH1gnbnrxUNztxyHB0QLZUBR+S8m2dxXlZ+/G+z81N/q8LlEXYzbb3sguw181NPdimcdaXYTbdDhVXWxrhuQ/EB9Q3NxoifbHVBEoPmh+G4cUPPI9tZ0qkLIywuRYPH39MhTdwpIjiTJEWt5aP1Tcnq4g+64zgVk7oNczgtENPhpGP13v4iUo5UyPR46NwKluQk41d1jOKEEXnPF8lB3xM1dZP1IUAq4fpFD6gmmHRMiCJX2S8Vtn20s8HfLrQEeAlvl6r7VsypJnSC9nz8bPK7DKM8WjVCyYCgcJV9zIpnulkexLXgb/rr8P6Q/ssFzBBPeTwQSCH/ujYxIY44arbaKlVRfR+BzcyhE7j3jIFUC2jiy74BInlmJhoTDspmpUZLyEg8SooUymlnDhxxOocZ1MyG5D7P1cf23UExe82+gLkdTPxBeVC22t2pcfbxijGjQ3vfk10tzq37m1JbMz7CAuj7G6BPN+UD5M5Em4n8N73kHGtKlQpWgCa77O7RneLitWuC8c0DYuUA+VWytEY9B0aofdkiClvkhVyIxT+KmcA+kVsmyc1tdPgIRjvUFA19hR0zxqyWhl9VU3vX7XPySHiFXuOqgGSof0Y2zAMvK2N/a7iDH6M2G0tnlJq483gfuva/colNlUYFXjBhhkGM6kTf8MR69pp/X4Vr6yR+ExZoJv0WLJfWeBZxwauaPV9yPl0gzHsClLq/P7/5F+QAy9mvfPaJCZdeUez/mxqG/B3g9Ye3fZedR6XHnIlPjgkWeZMZVFiLg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(70206006)(316002)(6636002)(478600001)(40460700003)(4744005)(5660300002)(41300700001)(2906002)(33716001)(86362001)(6862004)(4326008)(8936002)(8676002)(36860700001)(40480700001)(47076005)(356005)(7636003)(55016003)(26005)(426003)(82740400003)(336012)(9686003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:47:06.4266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc16f9fb-3a90-4098-d20e-08dbf52bb49f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380

On Mon, Nov 13, 2023 at 01:53:10PM -0400, Jason Gunthorpe wrote:
> Currently this is exactly the same as ARM_SMMU_DOMAIN_S2, so just remove
> it. The ongoing work to add nesting support through iommufd will do
> something a little different.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
