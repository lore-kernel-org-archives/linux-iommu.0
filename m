Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931A6FB0
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftJ2qhzg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izuVejLmoZsZbdnvMxjsdMmaTCJx5WAmc8CQi9lAHjEYOkGSVLWMaizh459FWFGiaxTgwDBPFR4IfZmqpA0Deh4DON6Mp6oTp9e6GSMjkPTiFiJMxq1qHMUKgD9d4kQn4dFnh1NzG+jJvysPFb2vMcAgNLGYekGwiMBlriPaqoVjzfBbWgyyZU7KmxuqQH8/TSkr/5ZOn5/YXLyEws9k+qxRNn+jeRYpCfRHl3TQTXQ8EpdK7N++VzKvpq8pny1ntYqf6rmOInW2fJ0IWPO3ekbJPBKTpzxl6jOjPBpCVk0y/ov9stqoh/iqzWbkQ7V4MFKLWdvxgQOxQ/VUNRgQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9UzI5l6eNq7QScSJiGDqfreqA+F+aeCdGF25CpFiDg=;
 b=no5zNabNLZ7Hvazr08fI08eDZWt6FsNGexzo8RCnLbz8Vi/YS7AjZm/hUMZeZxBq7d8uBsR0DLOBX7HK6cMC4BFYIOCKog2RnJX/Dn3D8KznerpH9RXVz+2WBsxlUo7l3o/d78QXGCwldFugcy/CFD7Lyh2ZKELxxDQqs57mypi5WHjbpXiFVv3LYK0Zr51ESsdZCIxQ47i6Cy1FWxgIhCz35g2hisGaVlGuFHqVcq1HPBM7b0KJEkbsVRd14Ub/exWBtz5oP/1lB06oMmEVvmYWdQnDi7Fqfp9YkurSBpHUgBISakzeTa0Lswvl/AZ1NbEFc6xWp+aQu+EnX36AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9UzI5l6eNq7QScSJiGDqfreqA+F+aeCdGF25CpFiDg=;
 b=ftJ2qhzgPZmyR9LDx56bJROrw7SIGmeCfNQDMF+Leg1+nvUPIdtZzJ5Hy7QETHKhUSTr96H0EPN/a4820zj65zQZyadjl5SSXRNX42kL/lJ/0ob5HOa8IG03p38ktJu5fYLCBizdK9DGgomezJ8HENDu7k+mj3aKNLKYWyCIBqVcHynO5lTcGjHwdXcYnU/o9054FhUnhTfMKPNO5Mdn6ok5+eM3Wh18tq8aQHlx7WrsWs1E1F8cafDdpAR3D9YDTaX+pUEuerVdTibbKYbNnbXggErY9IQgMeOFRxBRXg+ZGCeTxW/1W2gKhAqHTtEXaX3srTK9M+fBVLESiKGILw==
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 04:05:59 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::30) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Tue, 5 Dec 2023 04:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 04:05:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:05:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:05:40 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 20:05:40 -0800
Date: Mon, 4 Dec 2023 20:05:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 16/19] iommu/arm-smmu-v3: Add a global static BLOCKED
 domain
Message-ID: <ZW6hkodzHPqXkLCL@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <16-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: cd325a63-22e7-4f56-17b2-08dbf5477d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	df2HLvxW570Q9mTJ3sFToCk3a8nxyoLxuKWHjGcQ+N2WekVTprO6NDulX+XJ7u0Humy8K0KiQOKFGTDGXfqEYFT2c3BxYngh3RYC73w3ImYe4vvmP2qx9jhlfAT5Du6tovU7IMFdctQjpW28nXhuHxUmaAOdBmqmQXvRTYxvyOKlOifzMb2LMoA9lgJ18YusLDLEKSk7QvAQ9txYKt9Ymoo71nO7vOXw/QiLHozX+43t2HlRtszZjfkVBaIUH03OrEMwESujic9Q1mCg98275O4e/gC0JsF69DzM8ibTwm8oGcvn75SbjfQ8OYV0su5A/HqQAaezpHZ7wxyPKDj96MU/cD4tnnfR42P0yiHgnvgcMn7LE5wzyxBJTEZGBYWlp17pRU+T88V5xK3KaAdjEBwO1bzQmjWcU5w5LsCM/XtzIN85auKGZadSqMw65D9d0gwp4eP4N6K0cxjidDsNXZxSaXHc0j827pXD2eLAeaAm3ut8vmkrbDME/p38grmRbxOwC1VE6E3LXZ0sKYK/PGzRhYiKKhuOzq14YAjA+2KISxQLO0zkDrZAa18psaBINHNrYMq4ExvpWHV1GAMnrslpVCp+a/iLlzGm0L+011JUYJh8XzgNF+KkH9zJGotDFRJ+5YAhWvl8W0CHi/2+hO+cbDTzGO97sxDP600aL7qFkB59NXh5Kvi/XafcZXO86WebKSTSCzdyo5AHfFIpoG0+ahC7iAt+v0q/jNgzmRM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(2906002)(36860700001)(86362001)(558084003)(33716001)(356005)(7636003)(41300700001)(82740400003)(47076005)(26005)(478600001)(9686003)(8936002)(8676002)(6862004)(4326008)(70586007)(70206006)(54906003)(336012)(426003)(6636002)(316002)(40480700001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:05:59.2943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd325a63-22e7-4f56-17b2-08dbf5477d32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

On Mon, Nov 13, 2023 at 01:53:23PM -0400, Jason Gunthorpe wrote:
> Using the same design as the IDENTITY domain install an
> STRTAB_STE_0_CFG_ABORT STE.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
