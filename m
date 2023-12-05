Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B90CA57
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tbnm6HIM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP6uuTTeh6AOTAmJQccjmJakAhwTdsE8JWFomeBEx+C69m3UNP5bm/VIVuTJXpau2lXYYxMODtkieVFRKYVcVQ3iaPsPnnoj2a9yl7dn2OiRL8CNjwuye7lVlfxoHEU1KbziLyOMVlI/gTwh5Gof4hl9sFHAc0Ki9tA0RG6iGrxKvHkDHmtLpupUm/kcxqQ3f5FELQZi4m+7M1VD9h6R38QpopCEQ1ctTshYKrP4i5C2qCzgdtdRlPzyF0rdzcjJHCg2wpaiVfXqqBvpdr7ADo6KoUMuHZGKsOovYa/GBSLeoKupgwTquuZ/PXbH8JGIgW0EGsUOsCj94p2yNx0KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSpFoRGoZHNUVaoI2M59UNRIC9JEgC7JWY5EzqpOqoU=;
 b=jt7jgRJwRD3NbpWL3rSyh9Tp6jInO7pYL+9EdQk9dHe7cTS6Wk43eSY+pNzRBWp7e7upz67PYl2mueRryN6QgTn7sz/qIjDahqikdjQVLE54+WfbmS7lVPFWbXXK9SOQGcXPYFcdycMdux2AMFQZyo/Yb3Pf9XQ7FjD+Y74SPr0x7iRK1isETlWVo1H73UZdBIAJIt3+jPejxZkbpCTvsP5/E7sCZgSSwQf5NZ74t2fSAW40/EfCtAuFKzJ7B9XkQ16mYq0mq6UR6cCU15tWjWj3cadO1I6PxY+Ur1yyryLwgBg4bBWsRnkwWiaW7IaD51cYEED3q635fqSYzFIZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSpFoRGoZHNUVaoI2M59UNRIC9JEgC7JWY5EzqpOqoU=;
 b=Tbnm6HIMEvEoyrUH6H+7kZhLatxwH4mUlOdXknpQs0f2GpRQ6CzD8x3wjMNUOrPVnCCm8bE2n5vG617JgGGBl3dH1HPc+Jg1RnVbAzD5gm48KCmtFpJejq9iSd7vzgbD/LHgic36DqY9CmBWRPzQG6Nw+nwjsPwU3S/G23tsyQHl1goYJNcrdhnPab805YAH3hsF44hGYJJ9dG1Iiv3JjUv6jLAR75ldqG9XZcspffD3Dw7paVn2Yba4lzL+zJz9EM2pVwapZyETrOtI9RNikBf3UVKb6e0MRFZm6TtYvZGORBD1iwGsGo8I1XRGYchXZ2KcyIYi06+4PAUzngDeIA==
Received: from CY5P221CA0051.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::26) by
 DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 04:28:31 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::66) by CY5P221CA0051.outlook.office365.com
 (2603:10b6:930:4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 04:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 04:28:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:28:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 20:28:25 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 20:28:25 -0800
Date: Mon, 4 Dec 2023 20:28:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <ZW6m54yS2rpk65kE@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM6PR12MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: 147da2ba-e3d5-4c8e-3b4e-08dbf54aa206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pHw2Y7ODEaznRZU4L8ATfc+Yu5jK9tost350hHXnc+pfLGVv2srhYE5xCKiCxz3x54wzdNTIq6igQRA9M8GHOI00wnNpqLOuaBVxq5juKJF6pdYuDmM+9mA1eS8ZUxuNt/8liyzzltjBVRdP8ip8nEwfzGW0DqlTdRJaxf2WLhGReixxdrbM4PuHXC4KVvIobjytlRx/IVjrUvAiDGHVInfQtnVYRLmfqjBdLs5Q7z+3cEZbWZKOP9kKga3ojpKcM96h92bAH7viniV47p1epY4GBW/Mxpb6oSQpvLhQGxrMY9OAqwy8B0Wz5SkBbzBw7fRiP229x3KgL+ZRQoterEVTwq8O2ln5k2gPx2VOgZzBstLm+R0FlMlxzo9Mb0ePtRJhM++GMq8dbmClSKX+jwp2shQdsP6KW83ZYlfMbQ6AWcInsRvmhm+zZkUP7uMhC7h3VBFzzuUBRSME7opLl+D6fhOHQ0CC5SFVC0EVYF8AfF9yj5uYgiX40N1Zfp3RL6lxvtVMzxWeRIkh7jFdmJWZKdIICGpInQCvYDkZPJbXLB6tiPQGvTzO4TQkpo/KAJj+JCVNJv/3XzAoC5cN/hXNyW9z/nfraNKP5p9SImQtJIbhAJvGLR7GRA8KjTqLl4e2Wbp6Iud9H6HJsmkhzCrRrYd5Ny7yiMyQXHGVZyhEQAQieovU3eQMgkUPMq59UIWJnh4T4MYXMCsYCUQQZYyxfY1aJc3PBnNFdt0Wz7bwgDls4Oa8riHab8vHFWnF
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(54906003)(6636002)(316002)(86362001)(8936002)(8676002)(6862004)(4326008)(70586007)(478600001)(70206006)(41300700001)(5660300002)(2906002)(36860700001)(356005)(7636003)(47076005)(26005)(9686003)(83380400001)(82740400003)(426003)(336012)(33716001)(40480700001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:28:29.6822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147da2ba-e3d5-4c8e-3b4e-08dbf54aa206
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499

On Mon, Nov 13, 2023 at 01:53:22PM -0400, Jason Gunthorpe wrote:
> @@ -2592,13 +2578,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
>  						      NULL);
>  		break;
> -	case ARM_SMMU_DOMAIN_BYPASS:
> -		arm_smmu_make_bypass_ste(&target);
> -		arm_smmu_install_ste_for_dev(master, &target);
> -		if (master->cd_table.cdtab)
> -			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> -						      NULL);
> -		break;
>  	}
>  
>  	arm_smmu_enable_ats(master, smmu_domain);
> @@ -2614,6 +2593,60 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return ret;
>  }
>  
> +static int arm_smmu_attach_dev_ste(struct device *dev,
> +				   struct arm_smmu_ste *ste)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
> +	if (arm_smmu_master_sva_enabled(master))
> +		return -EBUSY;
> +
> +	/*
> +	 * Do not allow any ASID to be changed while are working on the STE,
> +	 * otherwise we could miss invalidations.
> +	 */
> +	mutex_lock(&arm_smmu_asid_lock);
> +
> +	/*
> +	 * The SMMU does not support enabling ATS with bypass/abort. When the
> +	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> +	 * and Translated transactions are denied as though ATS is disabled for
> +	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
> +	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> +	 */
> +	arm_smmu_detach_dev(master);
> +
> +	arm_smmu_install_ste_for_dev(master, ste);
> +	mutex_unlock(&arm_smmu_asid_lock);
> +
> +	/*
> +	 * This has to be done after removing the master from the
> +	 * arm_smmu_domain->devices to avoid races updating the same context
> +	 * descriptor from arm_smmu_share_asid().
> +	 */
> +	if (master->cd_table.cdtab)
> +		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
 
This arm_smmu_write_ctx_desc was previously within the asid lock
protection, yet now it's moved out of that?
