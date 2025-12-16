Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96F18AE3
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918048; cv=fail; b=LLYYzAsEbyYVwYDs6m/f/pQfZDSztcHZBnOduO7/eW+Mo4FlqRkM8OETEcKSsZtY/N7tla0Iwz9C7wr+FoIMCdIMSoIfJE+rcfaEx0OazFPvYaw3vjma7qS/MmcP4O/dVAIRvtgZAWRDOXvRLV75aL/nX6PbosOrZ33ut2GDrco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918048; c=relaxed/simple;
	bh=/UAz3vAqVnQnNGz+sW71+Grv37F+RFOIP3g1RrYawI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GymoiPqp6GbaSPVdyDJptLZf7UW5MmjrJWmMsxAgrXQI9HGJCFhRF3B7kyw9PFEfVulnIqw82mbzLhL1IqzvAogXS8Bs93wRFi99fNW+f3mkaMjtMkI2vFsMWv5C7k/sgDhLQ5d3q7RqYu5xIODPfFgzg8/SXb3/jl2dupqzpds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0wjLNDL; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0wjLNDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTrgeirwT1rdHcy0tY4xEOOvY/1XBQzub1HUAYei94BLxBz5KzJ1DtZPSUWMdLypKzleVRntRJoP1Wlzx2I29WgGkhHWRJLJm1rPHeKn71o7F0G3QIoVtakMfBpAa/8l0pi7CNFSx9Fo6zhD/YysaOTPTQm5UGoF1E9xlvXkwOj/uNZYE726mmyhLE9bkepQVQQ7P3CeDDvxJ7wI7zxW8HOoeWAvGzz8iQQlpWWKfJ7GYZPILuXeGST6fWlzQpfHhiSzK3YOm9KTtjGYH3pZ78Dak8wpJvaw1aBfVA021E3mQK4d5q3+6faHwhZSdR9MqW1BfAvR6xhqZzHFQFRr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z6IR4UK0Q8fFDpN7EclItAZP+fdGlpjl0uVZ0qII3Y=;
 b=Pboa3Wv5dx+1/IOzZxniYDLbUC9r+c10nmPrI1jh+8d61Z6+2wZAjH6BHGrSjDumjKBt8DEe2vTYyA7q/9z5h51K+cXnMUeG7FvwLnY6iPT91PvNwYCnJO0pBX8tceZ8azCGI274+9fNlCZcxzyKtUZQRA+GLCat2PUPsg29fwedfsQ8H8tPyzWZj81RIGY7p8Z2gAYQtNea/m+ybTdlbtv9bdHt/4cwClh4acucoR3iw8K4+zYyDPXFki0VdfNQmxRPb0WhdjH9dylF6DKC4Pz1yXQKHb+2sVUttA2bI63jq6SB8iYzLOqCqbm8OCdc9BFIrnYakX9bsQjdKKGEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z6IR4UK0Q8fFDpN7EclItAZP+fdGlpjl0uVZ0qII3Y=;
 b=J0wjLNDLru5wwnAW4qkZeuJOVVRBOWDSBvwajyHoS0gHmOzsz53nOHygb1JGR+LADhrqkTCD7wdoNXFy717Cf0YeI4VQqygwQ/Mu6vE75PsWN5vhrgeYt2ERNbJCuMIoTOdM98LwuCX5TZqBR9RR3nWDdnZfkwGIDv40IwXp1yI3SbL9aAj9uGjMo6IeZZ3Nw/ESdpWt3BhXthdnfdaR23xkK8K7nKczVCU23ciV7J15UXHeHD0wYpB4tRFxSczynkziqy9ZB6xDQmGIpdrRENstyMiaKKT4r0/QHMb8+v5pMZIOX4WLhFWgjxGkFwIID9X9JD47yhRLAsUQxr0juQ==
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 20:47:22 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::83) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 20:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 20:47:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 12:47:02 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 12:47:01 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 12:47:00 -0800
Date: Tue, 16 Dec 2025 12:46:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Mostafa Saleh <smostafa@google.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aUHFQ1Ep2x4/vdk/@Asurada-Nvidia>
References: <cover.1765334526.git.nicolinc@nvidia.com>
 <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
 <aT87A1ur4htPjM5T@google.com>
 <20251216000952.GA6079@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251216000952.GA6079@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fdc1ab-abc4-433d-43da-08de3ce44fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?orBnuFvYtsHsPMuz3ZiiwNie5h4QoZtctNqeYWf04VXTip5UF4iv+vFdc+1U?=
 =?us-ascii?Q?0GGfr8ylJMC8TzXI5C+DWiP7VdcIt44tFcxeo4wQlJVq1ybcUwe1PIVNSfwI?=
 =?us-ascii?Q?FfeS20izM7t/YAExA72aJW2jHcscBgeO6MPfzjlvsTx5WMpsSgPMSO+jPVYa?=
 =?us-ascii?Q?T2SUUVxvpinJkdZ82CBT43A9iEp3sHSYceqRIQDX6PRnQ/CJZPNTXJmO65f+?=
 =?us-ascii?Q?z4w+V4kTpM8d+kVND639qAM2pMPomWXuVOIb7jVHEDm+2BS35FKou2dDBQnl?=
 =?us-ascii?Q?yUf9003iQo9F8thYRWyTpdElvAgvxcMPLEqdHVtjI82ZBPoha5zvllHYhZ2f?=
 =?us-ascii?Q?noxMHxRmmM4oySjrIwlt8EQ7rVR8N8jQRCHAAYo1TyfWvB3ALA+/s6ji0q7V?=
 =?us-ascii?Q?XK3X6NdcVXP7F522I2RStlLXOmE2rm5p/aPGU50apBjKsp7C+OjOfXzcMkts?=
 =?us-ascii?Q?NJaenuTfR4tLrzyuUYE4BNKHO8zxxUb1MFbHCumUxiaUOIq08JnqyFl4W1zA?=
 =?us-ascii?Q?AfjTFDRzB4EfA2EcVTHxeHjibXDhHemqco+JoMMyBJtRWkeNNrcemLPKBCum?=
 =?us-ascii?Q?waR1qTnHHx+xePKvIQK3C2BNK8FUAQpd4jampGwkKqsIs+jYu4UMjsmhyK76?=
 =?us-ascii?Q?4H8igCggCGTA7t/0unYR56adUb6iAdSkNDOYsE40M+wQbu4kKPZOKFuZl1nV?=
 =?us-ascii?Q?zOEzMCzr9emMSZWtbA0MLqrobnY2VoldjMLjBrXW51W3jnCSy2cWHNsqHT9a?=
 =?us-ascii?Q?ypAE/DaEjseLq8ZCFkYac7HS6iArzk4LycJ2o99i5OnqIjuGtDJOlDqR+2/+?=
 =?us-ascii?Q?AURgjYDgPOOX+vS/SuzcnDoVcrgbW9Gl4xhIO4cceX+6J9o1Gcr0BCK8lR7x?=
 =?us-ascii?Q?NM1RgfNCjZxA6b8sOQLvDvscJJPK/7uflROCx/+a0hIoQqKuaO2Ea7mvwF4x?=
 =?us-ascii?Q?UHlBBmaZ9TYMYeXtbxBXdoymbxIKrOFA7LKgq13smgs9guWT78RzRcgYuIWm?=
 =?us-ascii?Q?56leEUyoxMPKPuDpMmyLWJDnJ0iQr9RSHtZB7q1hvaen0D7ZjjPbZoqwXQzL?=
 =?us-ascii?Q?jGgOEgBYhAU+21rWCm6yG4AeZVNFgl92eKFUNWjtCbv+QrTkbNKYHYYy5xj1?=
 =?us-ascii?Q?b94qc/eIZe4/Zl0Aylee8amfFkl5ecM+VfZLUj2eqzC2FpMBK3w4yny/CpDS?=
 =?us-ascii?Q?gklG8aiRzBxvtmkyC+MHsq9eC2sYVX/Adza7YjEXsNtbBGpoSj4rCXSm92+y?=
 =?us-ascii?Q?LpX/Frg38RWKAXCmF8Ws0FhepH0+c98uydqwr9HHr6JJFXr2fFGX/c/OG04Z?=
 =?us-ascii?Q?rfx6JVN40VLgpW+S9YFYRPkGqKPaDcLUfcE5dlk8g2aNFtgytJxZ83ErCyZT?=
 =?us-ascii?Q?HGt0gamh0YljHnSqjUu159TWMg2Ztoai2t0SR5ps2xuqH7w/mKXpri2LgeSk?=
 =?us-ascii?Q?m78876p0SMK33leM5HkjzwTslK5YdfUY2s51SHc0ZFXVqUTVRDrlt6pbEcLv?=
 =?us-ascii?Q?E7+u9Jy/hnqpwtSKFdyufyf5Xfh+4mPkyrvQIWZa25DbE0tLlC0m4IgdAaOy?=
 =?us-ascii?Q?gOxSdq1aWnMnnINMxRo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 20:47:21.8995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fdc1ab-abc4-433d-43da-08de3ce44fb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981

On Mon, Dec 15, 2025 at 08:09:52PM -0400, Jason Gunthorpe wrote:
> On Sun, Dec 14, 2025 at 10:32:35PM +0000, Mostafa Saleh wrote:
> > However, this approach makes it a bit explicit which bits are ignored, if we
> > keep this logic, I think changing the name of get_ignored() might help, to
> > something as "get_allowed_break()" or "get_update_safe()"?
> 
> update_safe sounds good to me

I have renamed the op and changed entry_set to void. I'll send v4
later today.

Thanks
Nicolin
