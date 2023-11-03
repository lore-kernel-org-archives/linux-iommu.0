Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D91872
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZfZ3FKYt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODJByuFUgbHrKhsSOtFyjris0Lw10jfOYGc1fyuT6VLBc2w/FZQqLKtf09sxMjIDTJjuTL6+UxUJQRUEzvDrNB3yOqlPsW4LTPSgdKUE7H9PkHA8aMJO6q36l98EqDTaP6iZdluAc4OEkF/TNqqrhLVlTQG/5vfnWi5H6y/Ovo2Mk2+fiil0IpTeu5FZkE4papQ3p5NpEV8ml6miTPOt14eDgvXAaWRYipMhvprOqBqZUYsPpUNujOVVGnw62QmeXreC+FZTe4qZP2D+9pTluVtaWnwM6qk3ATTxAQhEoJFQrfU73hYQUxqB99ErTD5XuJrIjIUTYRNu5ruUF07HoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec3Mj3pQfEnjQZWRaQiboafW5Ied/I7MHZwVwwCvx7M=;
 b=nUPaoeZMN5nvdTy636R13mbI21LtJCL5ol5i6bjAMwUasEnKNBH3LMQOmm1Iw989ISEIxO/JUNyQ4MuoZaXc5WDBHo2TFwZSF1VVgmZxL4WOzQIUy4oiuNr8asaquCXvBtYaEYgaAZqPyeX4/QljG/PZl57PIUw8XYxyP1YShSZgCPciHLRtBzJKKDfYJ3GaZW5VonaO7vcPO3fgXLIyVxqHDm6a4EaFU8Eq25kJpagPMynXbKuXAawD+qqymSldo4xpFL9b0g5/5XAs2ERKTK93WDKaGNX9lKSnyQ2e8CvJQucl0jRaYxCpECv7az7+WWGxw2NREoClZQzl1qNw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec3Mj3pQfEnjQZWRaQiboafW5Ied/I7MHZwVwwCvx7M=;
 b=ZfZ3FKYtgWWy3Endyczf2CP1OyRbTh5A/91sW7DEdgnokYidqJv9pKzeTGkIN0si0fZNZM5qJlMYGGCEaaFC5ZN9i9FJ2cthcPUHZkn9dYqBD+vbZXqKuaFKuwgda2CE19lF2nwWq0aEL7jyrXqDKONWdylr6cCt6Ybs6LPDvwGoaX1CpYB6DioBx9UCI4pQyNt8iktuQlYg13XPUuhMC64wq8DxEWtS/rNrJOYx5DB6KNre0pbdpUtc5xlSbestubxfSntX9S+YA6pUANjoJhZgdvJOo393LhnaRDIsyXyoFPZ7vMmYuz3lci1MeyO9mqo8zvwbbV26TOcvOQNWHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 18:45:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:45:03 +0000
Date: Fri, 3 Nov 2023 15:45:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 08/13] iommu/amd: Consolidate
 amd_iommu_domain_flush_complete() call
Message-ID: <20231103184503.GH223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-9-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-9-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1PR13CA0336.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef18118-b32c-414d-b44f-08dbdc9cfe05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFE071O3pXsxyQUFGta7RYoEM545vLyQYyXpLIFFvx8gu9iu2z6BQDmxGbm+KW29fF3/fzpONYsjzoS+4XQLddmhuhmIaR0Qs2m82dwh4AVhQAnhAHLkXSv4Yq1KDug/hnAfsl0HDLTS/GKPSZcFy3UtOTKgljS6WPJON4A+UJXZdlyEa3Ku2DH4UgXiXDfHkCM+MUR4j4VvicbsHYyebK8IxorRyzZYK9r3BdOfH52t47JW1jrwqXWm6fjgYDJjv3T2S6Y+eMSpCmeNOEJqVX7ZTd0HfVg3aWMHmvkxJiIPbavU/0Wmav1WcHZj3+Fj5pd/wSOdOFH1grCG2JXCRzBFE17lZLv8iHi7ElP6l+rqI8YQnkbPwElIB7Dmc5/Y9C626pvOMAWQ97nkFrqHUy+7N4yX9FbzdNtAd+H5WKqVl62YSnsTBMCKVLSqvxuEsCLUxFACuZ3Tm3XCdAhOGrJj3uaqetcNrUrIsxV+O7Lk9UGDsyBeEfn0FygmIDgY4XDHwRUTDGOkzNbbLgxDlkY8dePUbBIejnT/OkV+6NzBwfjPnoFc38JvhUi7b+QAiz3TBrmyKK0c+FhedlyvBIRDuWTQlYj5K7O24W/KYpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(4744005)(36756003)(33656002)(26005)(86362001)(6512007)(1076003)(6506007)(38100700002)(83380400001)(6486002)(41300700001)(478600001)(2616005)(66476007)(66946007)(6916009)(316002)(66556008)(4326008)(8676002)(5660300002)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMINPmvYNAwhTkE1/svT6qN5UNz7IQhJPtxVTNkOW/4jGXzeYmAASOEkBDiY?=
 =?us-ascii?Q?kJpMVOeb8qTYOZ4vTfpGbUTWLumW4V3D/kAhqzh0gSauCFM2qdf9skUzS8Jl?=
 =?us-ascii?Q?jrjBtBhfyTcxKBxnwuXju4xEpDgUdSCtGiur+igu85cjqw5AQ09TRb2IAKsO?=
 =?us-ascii?Q?xWOBYHiFZ28OiDXro4uQZ2oulh8rSamYspLWkXkoOXnQLKCZpps0SW+/BvrR?=
 =?us-ascii?Q?Sdrqt4VRzfs3uukoPVpbP3znMxl55ue22byl2kAy37TGFZ18DbDemp9SDHrL?=
 =?us-ascii?Q?TO5c+mcp9U4Id+ew2+KAFhYzctP8KE/nCHVCYrF2qq6s47cCyYRA6WqC0jSl?=
 =?us-ascii?Q?kBg/ZP4esJC9nwD2V3iEwnNqTR6SpZMxMpldieVXmaVSqM1GFo3qoYWEyrXQ?=
 =?us-ascii?Q?OqF+gs/iXAH1sG5hkTOlRh5nRE5OaTxTYKM7stQJejwygkoz9GrPBvHAJZzw?=
 =?us-ascii?Q?Wa/cy86bfBVwf5UkhgGIA1ZLcU7CsPmWy/7Xb4ynPqIZlZg17eQX1tOMWawG?=
 =?us-ascii?Q?rjhOUegEhBIPBvW7hhFi7VTeWbbuFsragXNQQ2y5wzoY0gHfUsu+8WYVo/fG?=
 =?us-ascii?Q?eEIlCnwt4LUVVBuA8mx/yacAfesbCq9I9JtWv13PYAzQKO9rxymrPFdyJSD5?=
 =?us-ascii?Q?i4jOKc/iYWgZqCHWO1WhvDnHKo8M4kYY+ZNpj/IlV+fMnzwEpaKsSIR8zT/T?=
 =?us-ascii?Q?9+DWUrnge7Eqrhz4zrQ06uS9R65jKdQSysK43i9e93OoY3XrUPYgf5OxdK73?=
 =?us-ascii?Q?k9iVJ1S0XHwAioqEJ9Jd+I3QVnMhzaiPSU8CPD53pcMNPlfaQL9LbT2DExkv?=
 =?us-ascii?Q?fQ0+V9DZo0h7BzGI63CfQkajroXtLP+Mh+BDp0aPUet1pAoP10R6WWv1qArK?=
 =?us-ascii?Q?WZ55NsPy8m5silxF2MQlep/Jf62NthKq8nDzmcixkAsSxMAdxNoY6hQ47Fek?=
 =?us-ascii?Q?WaZMnqRCdGawMP9BtO8PVQnDAmrdLe+YP5GOzNUOr06IZMj9Cn8NoZSNCIkc?=
 =?us-ascii?Q?823LOpQO5ck+TEXvm+BQnaOBTQKETehJzF4eSFoAeoQ2ojmE0mquwCE+SE3J?=
 =?us-ascii?Q?3Bn67P+jPI1RvWDCB8JJghVNgNi8hxvwLQIUQoUR3ec17QiVU7WUUeYPepfD?=
 =?us-ascii?Q?m+zE1zFdtFnNh/TocUh4Tyi0I2TWczbXvcmPf0vItuf4oMD17Kr3FSlu0MLK?=
 =?us-ascii?Q?imv1Ef1tVuoaESbjFKW3QtU8Tts/rk1v3rItfCmhsPATA1IAgtfB5nOBIcZs?=
 =?us-ascii?Q?MPSLGefjTZz0mXixAAYaOcFHbxwbZIiILWMRooqsbn5/n/HIy6R37zynXBSz?=
 =?us-ascii?Q?W/TEgGpTvla/58sHncNB5GJL4F2kH9ukxo/bWYtUgKQ/v0+UrgdUnsvZv+Ly?=
 =?us-ascii?Q?IuGsJVxnpsBpTGigxX5SGJCD4oahGPBMAvTFO43BW/2V2ow/srDfQWoniU7h?=
 =?us-ascii?Q?vzv75kTEuagY73QZbsrMq13f9rgfXZ5xsq1KTYREm1DN3KCEYQVQjOb7Z/Rb?=
 =?us-ascii?Q?hwtpuqgKPZhJghvtbvO6XuNtYBV8ZpwPzrUxjAbrPQPskB8vRMRioCMEazjt?=
 =?us-ascii?Q?G5tj6jwTpjL8+F+efK5FMcUenUeOxBW4QqCNQcQa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef18118-b32c-414d-b44f-08dbdc9cfe05
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:45:03.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGW4sp9laANF5CHVjJ1uZMbInpSSuDM8oesoNy89LJ4u8dpzYwGrkezeXLIzqqhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

On Fri, Oct 06, 2023 at 10:16:19AM +0000, Vasant Hegde wrote:
> Call amd_iommu_domain_flush_complete() from domain_flush_pages().
> That way we can remove explicit call of amd_iommu_domain_flush_complete()
> from various places.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable.c |  1 -
>  drivers/iommu/amd/iommu.c      | 16 ++++++++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
