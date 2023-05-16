Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013EA20
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 00:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cleXUEsVes/SDSb/BzMDrLtHWdl/s/drztb3FugII5BGCKRPM75U+B/kke/UWDYw6p1bbxBRVcXzqH17Lik0l/MC2bYWVz73NFNMOnrg9FijALqUOWCJUjXbbe4jTW7uJVq0/59Tjgjshx6CgAC1vHPOe8E+frJmSLmZ7Rk8L9nS4zjv84Aozlqd3Rwat/+ZXAr7Kva0Uxv6H1PP2XLiZBHDgeCm7bJ78hDTlbYDSJkLYbElFE6RhANf9Ij4x/XvJRBmdhHOIWNu4cN5fEMKHL0V2mKCxYtGXttKhfn7S+MBu37myZFXWNsHlKdYqv8ajJzVyK7t4F+/lWhKCSorhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7xORKPV1aqsDuGUC6EALeJQfebwVNBdZnWkjJIVCnU=;
 b=KQtvMkU97l4ieWp/CeYm500Zr0nR5OdR4jl5nVCtKyaoQKDbhCgweH9wzKLBnWbdQ+5HsE04VroLwF6V7pdy2F+as0Q79TC+hD2/qvq8ZYQqCqiQbmhtvuL2MTOvwrIu709E+hUnL45L6eYNa0wHmMkzHqu8SjEBDxzrwFQNqCmpliE0zMT57xMC2uBxqNWzIWJXl73w+Hs4crflscZHjCj6UPDcerr39hA/AD+Sr/rfB3BmmSeb+Dr0zgwM+yMM7TuLgzlHlsoTfgC9dqYQnv+zWKf62gutE1v4YStWHOsPUsh6cylNYMhhmvbENDHq/ehpAUQvp9p7rXEOv6nlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7xORKPV1aqsDuGUC6EALeJQfebwVNBdZnWkjJIVCnU=;
 b=fCG4jUk22eLldMWJGuADP/Vsyk2nvSKeFulU5U1fAZ642qOMvvSHbwmu5D+PS5RFSK+M9n3MwfJHJv/AeWMNAbeOX5EL3DTmOEb6VJhQUYvtthwSv3dp8Xdb+lJz8TMnYcYPLxPLhb8n+ryqaGe3RYocSNcLCdJCYbL1f1Znpq3IX6CyHrOzOraDsl6FUtTq8FEw3Y9M5+MniXQeqNsdXhmrTvrMn8ApZNCWsf5XqcICctJfqZdYeKRl/y+QPiiEjJhPkpbaSsqGXiCRHKmhxmfefT4a2pKZQBA2cHSRnKoOv7OjgROzxDcIk6YrtIZTa0CB6ype06rA3C0Iq8BMag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 00:27:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 00:27:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] Remove iommu_group_remove_device() from fsl
Date: Mon, 15 May 2023 21:27:07 -0300
Message-Id: <0-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 923e03ce-c7a1-416a-1809-08db55a449bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KO1E3AgazxZd98M44FrZ3+PikH8QVe1Zs0IDc5Ee+xfleJznd/GLllAxRgUYsme5W8qG6MZuJEwXBUTm1eya+2vh1VvQcUTqZWxbZXNnGvrwENhpSxEKOX2o7P6WSK0wMv+fEqR7qb8bB8h2/zhi5DvkD6R7SyebdevqcdZPk/U2ZZAkfXdRnKYfQ6qveVp3XNxAYX858gpENSx/fHBVCwBANDlrSbsEUWk2uG+eZVn3U4uKERytiZGaTyWNRA3s7rz5PcgxL7/7zgAF8pEcomCYxFhl2M4sVggmM4yvdw8e7SgENQHbRcWpzzJf+tD66ay8vE60gTbNOj4jJP3CJVk+3RplvVhMGPBQjMxHtGoakPCxkLuCCdlJJkwrwNzJ7df2VFQz9oiIEJ+9lgn5A6FMXF/UkeNa468QSMKgESrjqfo0OFSw4Q9ze90Xis9XuP5YJVcGi5zCl60jFRnMCw8gf+oHBvDCPbhQDBN/cCXse02/TyewdK6adpgO8jrz6Ioqb8qpp7on5zDwyuCSqr8V6tz+SmI8po8mx+kH2bxVsHCilmAGF1jf/ROCKk1qtNNN8jOv/fKq1Gk2IyuEogH+AfwN4CDK2jHuezlKbtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(66946007)(66476007)(66556008)(41300700001)(6666004)(6512007)(6506007)(6486002)(26005)(38100700002)(316002)(2616005)(5660300002)(4744005)(83380400001)(8936002)(8676002)(2906002)(478600001)(86362001)(110136005)(186003)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mh6jK2t+YFcGEecv+aysXd/gVUHD70fRiC0m9XhW46m1q1X5jhlIHyePoRT0?=
 =?us-ascii?Q?0lrwfdfb0tNx84SkMO3TNMoYHQe89Q86lx/zUte5wGcSLX2VJbJOxiH26gG3?=
 =?us-ascii?Q?6pxcFZqHjrx8O9mvzLrp84uS8MW6GI8eE++bDeQeGNtV1UtvowbivcKlnRoN?=
 =?us-ascii?Q?l+91fwWst5RT287hHUEK8Ryw+VoxsJDW9VzUDuf2JhguWpYQpBQFTDRSSqmg?=
 =?us-ascii?Q?YB+r8hkEw9dEIwn3Wxj9PfUguFmg00EzPJCF21X0mrbnQ4XFdHkE9TYlsS+k?=
 =?us-ascii?Q?YgedKNkZ+1FtBKlB+zFJ3o09IaXX/4Z0FIKEXueIBsbZGebpgUxWBCWCxnn6?=
 =?us-ascii?Q?KQeOXRum9JWt+ukUzwSrzWDagJHXUm3uB6H63WAbMu9ecyzy4WZOKmZQ+jo/?=
 =?us-ascii?Q?dRXhAouOPgBJ1yupPdPSrycscxjR/qleTZoTCr11dCMx3Kxn3d0DM5zK+Bp6?=
 =?us-ascii?Q?ql6QX42WOSphDDJcxefRqBRrr2dsKRUn1DWTOP9cDm4Y0XIpaLmzSWSEJh5a?=
 =?us-ascii?Q?mFBRMYVAqNrb62CviXQYuvz/xdSjq3aQujI/dQ0NWLCvoCWuQouhTXr2j/BP?=
 =?us-ascii?Q?D3xFbVBoUbZNRXIdl+pW4OQXarW3H1146fOQ10dDdidwVBKV52Q163PZMLX3?=
 =?us-ascii?Q?kXhipfgcYIpP3ZJ8mkKC/IC1kfMxjni2mwbvsv7C3lg1KMDfPSxwsD4EkOWu?=
 =?us-ascii?Q?QxE/QJqQ5H1zDiULzrAxVBIgmUOvKKLBQpKG3pytB4ysi0fyOaRE7+QofhTT?=
 =?us-ascii?Q?T9KU4QiyLz8SEkbZ+YaQN15/uv4eE5jlN/f0jYsx13Ip0l5ktliMyNEGWOCY?=
 =?us-ascii?Q?h+7cF3hiha1B3DuGkAOmFbZb4y45g8Nj4DDqa1HeHgRZ1g5a+groiOcZFaE0?=
 =?us-ascii?Q?rAfZyxsF55pzQHe2adhuCGUsaCw0iI5zql+vbJJt+6/vIuKapkjQSDhNXrYJ?=
 =?us-ascii?Q?9pL+K19BICmSCVV2s9tUsIx63N7GN5yaoZMko1XBgb3aDLCzUHHEe2qUZAMf?=
 =?us-ascii?Q?OVoekbHVBF1pg66QO5u5v1pd7qdsxvy3tQabB/QIm8/GtVSrVTYn9aPA3sGl?=
 =?us-ascii?Q?bgg4KoIoVaqeprcq3MWrKP8Ym9gWVcNA7k8GFsScoDMk52J7kS8G5o6jg7DA?=
 =?us-ascii?Q?NLKaHohcDr5NutqGhFota/BIyroxf4oLgQ0+EfQjtcY3swJ9QUhXzDtrS5Be?=
 =?us-ascii?Q?sboiNmg7R/RLH3iGD/7ZhAgqq9c+uKi+Ft+eTjpTB/1E9hvkBcDNrizznt6s?=
 =?us-ascii?Q?uC4CWaQiKpP2oBtMWS7ivKaBZGD7Le5GVvPV1vnWKS56x1gJTS0ifqiBOSBB?=
 =?us-ascii?Q?RP+tYnxa3jI0yecJNCyIZxRpZ52zuSHAs5GoTuzgR5POf3Ql2lXzLeJTnE4T?=
 =?us-ascii?Q?yo+8vta3XK1tKbP1tSQDDHJFYjJ4Zwr1LFoIwouqlYZ1xHijAQyRn4xUedEX?=
 =?us-ascii?Q?iRLfo5xpHsyqzSe3BIFWkOKkGDJW7OZkFoElHlByvRKSEyUPiNsBpbHZZyd4?=
 =?us-ascii?Q?IYvMl8SNlrcKy1nrHi+YXvkD2qnIY85FD3b1hfKW9X9G3SoMUCnVUUPAflQj?=
 =?us-ascii?Q?94gROLk2foNfO/RGkRQXE/FxPCV9olyGpxR+CWan?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923e03ce-c7a1-416a-1809-08db55a449bc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 00:27:10.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o5emfK1bCl8HgXiTnb/YHt0yTkW7nQeuVndU6Tr1ulR9ZiSIscTTBXdNhJnZCEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

With POWER SPAPR now having a real iommu driver and using the normal group
lifecycle stuff fixing FSL will leave only VFIO's no-iommu support as a
user for the iommu_group_add/remove_device() calls. This will help
simplify the understanding of what the core code should be doing for these
functions.

Fix FSL to not need to call iommu_group_remove_device() at all.

Jason Gunthorpe (2):
  iommu/fsl: Do not use iommu_group_remove_device() under
    ops->device_group()
  iommu/fsl: Always allocate a group for non-pci devices

 drivers/iommu/fsl_pamu_domain.c | 55 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 34 deletions(-)


base-commit: 1421774b874bfd5fd1b2b05b59b67c0c5e0d513e
-- 
2.40.1

