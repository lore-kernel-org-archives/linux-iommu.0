Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAE8F75
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CRkHjMR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCRZzwYV5sxSQyDU0oPNo1nOLqeavtVpox+Vv8W4LiTw+1HUr+Ql9zGGblzEGXNfqznIMyk5EHmQsrZnRwQdV9Au0ujgF5u/DnMRVgviT4zsEyRzyUooJ3WES8v90TxW10EvnsJjcoAGhDKZYdpXo0Y8hYtTAbLefIBughnoYlhKhKXtaVpOSUhV+PBUPcxaazv8jsySqHpc5Xg1YszvETSsR2L4oME2v+Uc5qaeYplaXrU4p/3yA5wRGu3VHAPp8A24R4Kcw/5Tij2wgUnHiDoV+g6ZjSDDHJeLAXUvOAMg4Fc+VKFTQEx+rciv7lt1GAES2Rk0OQrOviq3n6ynQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/d/+LNcrtMfgdanfzee+vLy3GWWDyN39kkV5NE/NKM=;
 b=Ld9wdJOalplDcGmDxE+mOWAyoJNKAsb9yAHAKKSUUs1+saSgs4ujo8I0gNdJuR7AD43iOvAf2fHWx7fMnZPvmsVSrCiKYd+zSwJU+v57/lSv8zhAXLJN2K8N6wfAzPvvkNkZrcH517hQyxOeFO0Z5LFVYtBIq5rptWA2YW5mfPCiX4IaEkf+L/xMOKNdiGtF9/BGqbgKcoYUi3NmfiUoQECiL24xev5erSQVxVPNi7K1Xv/6v/jzUPvUKFoC+nmksj0IBpE3tEHOMWCyFwLAL89QuEnFMibzs6nEBxHY/t0FvG6+1lkLhdYyiMmssleaPCHWdKeHCZqGi1yLoPTpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/d/+LNcrtMfgdanfzee+vLy3GWWDyN39kkV5NE/NKM=;
 b=CRkHjMR9+oO0OHfhXsjka9+oXZJXyhagqOcVVCGvdJYSw6M9ZBYWo3cjDPJjbc52FFm3b4P0x6CCcyT4kckE6lIeGKmPdtDnLnLjTUstmH1wZ3s2Ptt59t5A93mWmoOv1amhbXHEku/6Nly9ZU4oKd9oUIuUqrxL3IiERTkhcvxJ/V2eop8tolxQNKHWmAjIOdxq6WJZJcqS2Xb8hdImjUT1uy8JhuvA0+YXl+4vCR4YayMWdPDrUF0a+KJBK2tBk53SlROM/AUrjPXuV3CNgk/z8SVe7r7j0bYj1cRcr6hPYS7FMKZZnP9sBOsXauR/4rr/+Gfwcpfk+3TmLDkE4A==
Received: from CYXPR02CA0014.namprd02.prod.outlook.com (2603:10b6:930:cf::20)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 03:56:43 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::d) by CYXPR02CA0014.outlook.office365.com
 (2603:10b6:930:cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 03:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 03:56:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:56:33 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 19:56:32 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 19:56:32 -0800
Date: Mon, 4 Dec 2023 19:56:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 13/19] iommu/arm-smmu-v3: Pass smmu_domain to
 arm_enable/disable_ats()
Message-ID: <ZW6fbyD8VEq7u69/@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <13-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: b0aa54cd-d9b6-406a-dbc8-08dbf54631e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z/1HbvzhuOaTu2hb3m6aMq6J8sSGWlkoCiQ5E/FPkr8CZE6ATYpsKD2skQoyY3q5/fAWgp8CgfuXMCgxJ797Hq0VPPsZuD9i44ydYIfQach2jbHCcy6ARxIZRuPQxp6OEBe+I7QKwlKZxAA27t93qvRk6TxLKhNtTSO9WP2cfTPn5pWErWYd9LlaH5frHTdP+uiC7ZMqYXoUQ668Vr8Nqqsvf7Kc+7UyX03m9zJ5KrYvc7bOeRkymyZADEYpmMN6ZxklbDjBmK6G/lRDkoDciqzs3429Vta8XNOlzXu1+w1VNYOGPuwPRV4M7BGQHJRcZuN3wSLXp4OqazS/HKAZDjP2vc8O2HQBXtFVWJ00J6XGrnUPViWFy117+7PJKHj35xpT0OmxI2H+6AYFX7WQorDpMhX0ff99SAeSYBTr4DFxLpMNrMo24PQ+dsxk/noqlkJDPBiYzNSsArf6KODzCFEDOy3XxtyZ+ZfRzJNi5I64+2MI8C3Rg9FkymvA4usO66FyR0xpNi6eEFvX6Nx2ghwmkA6IxrMnq1K+wBxQmSDkX9M/gdMYLqSrgANM6P8Azli3atwiTjlu95gqnTMyow95jmiGHCn6196BtdDCvJVmhZtYRFKOStS+zLgc9R6/cq4VxHjPD3u6wDV7AAgJYwcppoPavX3RoNqZ5k46S5XevizNFWrx0X1xNx+5RdKMSsPCqQB0C498R4Q6tyOQ0GIBq/ODrrf1911oMiZwpcFnWn8Xw3hHQH6LQkEaqQq9
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(86362001)(558084003)(40460700003)(5660300002)(2906002)(41300700001)(33716001)(9686003)(40480700001)(82740400003)(26005)(426003)(336012)(55016003)(478600001)(356005)(47076005)(7636003)(36860700001)(8936002)(70586007)(54906003)(70206006)(6636002)(316002)(8676002)(4326008)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 03:56:43.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aa54cd-d9b6-406a-dbc8-08dbf54631e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023

On Mon, Nov 13, 2023 at 01:53:20PM -0400, Jason Gunthorpe wrote:
> The caller already has the domain, just pass it in. A following patch will
> remove master->domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
