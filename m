Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76C63D
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKGfn3Uv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOS6KHg+jnVr4j83yoNL4gRqrNEsB0fcLy+nMgnOnLjV8ZXaz/E6YX6uVdMdaZ9m/6A75p9JjyIMOHHBSoOk9RDjQJhXXjKNg7aSf6CxSi6+zJMa1PFKs+B/vA+4a/GSLpIQMZwh1uHzHE9CHsd8vgyPPFgs0TgIVjNvuXJidN/d4u/NtEbEfEgM4MD26/8g5Np4sfoP6QGoVhQ0xpYlETJyqDjqhJPDo2fzqKHxnG2sR4s3LQFVk1gftvXAx4v+fNDLCrnXkQOEBi3JnFtJKT4Qyb7+CHToDReR8SWiWbGPKkrIoLALrVI0JpNvjE/nFzt7ygJGyjFox307x0qXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u0xZMq/KbmQzT0FT/sgEJNQlB73S4M26F+lgif8b+s=;
 b=hMjhE6e8++IXBxEHO1bfvJGsKvmbC0E5+7E/rrnqKPDNmsxt8+CTr8bm05aPDYTWokKRgl9lRNdyR7NFdij3YxbmR5yfLeqbqd8+dAsfl6IDxkM3bBY9FIShNigEblvuoWxt3EzTpMfqJDltDKay0a5cIwjnFzh/VIXALur608R94kVKCy6+66o7iMjTcI5P30w2ffyoMFBb7My2wzX4y4e6Uc86qY173a2vqpFpO2Nc7lEd+z3qiuFrn6tZFQltLogqeCxNBZWR5/ZOQrlS5Gk47xqRAcxI9w/aZ2ZIykACjdzcogZ0REqT7ZhhbXM/nT5gJvEu9d45tWTUVM8AMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u0xZMq/KbmQzT0FT/sgEJNQlB73S4M26F+lgif8b+s=;
 b=uKGfn3UviDeWlIt29VSgDQ2V0N6kMLS33fBOE03zV20ZHvavogDa4wnSBarjiknmiQT8RBqNqAQqeDUuNaZaPtApIN8EbKb77+PTHN3nqDNooEmrpsliRhJNHMPZipwPEWOEmHY+b5VvXjrWFWF4tX5BtbTa4SVhpcHJ186s5DNFClfjX2zQCXiM6OzSPHXwdp2Vb3wYKyhTi2i97EpUYGD6bTPCDIxGIti7AATluvJX6TjbI5A7tUMHO7YIAF2K7Ti09vsxuSiTk9wYog2C+QBOMrxL1DaHHUyb1E3NdFUXOjlccIm9iJjapVmRp7ZKuqHYmJP1TO35PzkDfH3Wvg==
Received: from MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 00:46:03 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::d8) by MN2PR08CA0026.outlook.office365.com
 (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 5 Dec 2023 00:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 00:46:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 16:45:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 16:45:51 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 16:45:50 -0800
Date: Mon, 4 Dec 2023 16:45:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 02/19] iommu/arm-smmu-v3: Master cannot be NULL in
 arm_smmu_write_strtab_ent()
Message-ID: <ZW5yvSwKDZtIFlNG@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 17658a8e-7ed4-4308-f6ef-08dbf52b8f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LtgTrYxK4a6KpU1WV/vxF1zeLphHHUAqUReNqhSHbY6rK5fSsw/49lys/MKBpx73XGjhbwximMiu2dnw7rpiNpjbgdY2PB5rbxmajRkHoNy+qnK6DKe8+UYJSD9xfcI3s/DodrTDIXihOU/ajyXcKEf0ObWarPWb0+omu/VO+s0OymQkzy8XT3CE1gzr+kqT6afEhtSnQYVNdHq0FmElSnqaMdBDQt8OOz12mEgGxrwoMkUC2HhgKgXG2WDuQWSgjKM59MHjsgpdCPi94mkNpjGri13st0QOx0fz8D71xrGKLOUdiJ8Upz1bJ7HEJAeDRhNqwn/e1HFLH6fpKtxiUB5Zz9yyNz3+2lVZouqnq2fY6ty927i6B3kW80ZSvtH5AzcScL0TxFhpkLLmP6P5drY3CJBuhU1ous7+aQhgXe1Zg8hXaVxd83TCFhAAkrzGbYQ4JUxsyEKbsut4iTi79caod48NaNv3lmMZUISMwWMnTCR50JoCAJVjLjfXsL0cdpstpPX7BLZ4swtHO2hAlJQCBrAoig4Uf3WRP4shfLYXyAgXMDE2t6vI5sc8lNKD+g7wSW7URlaP96PvbruZWSbeHF7WB6797t4lnFkhpkIKmOeIN7RD2+viEcUIYlF2zjDk2Edfwv8H4k+mD+IIH5As156PPG5KRy2iawDwM7Miuf3OFqz0hZlxcCyyuT2ThDdMSjSrpuaMpANUZxrOkAS2sdOAVCfoPtbnUIRjJ9wruIirT7+RqSMTB5ziOFv4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(54906003)(6636002)(70586007)(70206006)(4326008)(6862004)(8676002)(8936002)(316002)(478600001)(40460700003)(5660300002)(41300700001)(33716001)(558084003)(2906002)(86362001)(40480700001)(356005)(82740400003)(426003)(47076005)(336012)(26005)(7636003)(55016003)(36860700001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:46:03.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17658a8e-7ed4-4308-f6ef-08dbf52b8f22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

On Mon, Nov 13, 2023 at 01:53:09PM -0400, Jason Gunthorpe wrote:
> The only caller is arm_smmu_install_ste_for_dev() which never has a NULL
> master. Remove the confusing if.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
