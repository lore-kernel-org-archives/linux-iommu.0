Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08ED286B6
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZT06jHjD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akUOlp0kC4MUEY5t6zAAW1uFN5VBLJEPbv8Hp43PQS+f2gj9zCH+ey/9d0GnTuisRjOMFEOnOVXWu3GKErhFgWUzDyaBs0U+znYKRSBl94CW5Jn0lrERZnGVCbP/Xpi7sR2PQfidhbW8JhY62RPLcCsw1nf/T5PyYkL5S1NfC6qJh/GJ1xhQird9JG9QbjCirsAlXo25x3F+CDjs/h1VHBC+PZ6sHVvhS/nQjeT17cTIfnns8OnUOI1PQ7xeTgbYYMZ/cw28JG3LsZkw83bfn+ZtcOdpWH0+IIralt2ONj4moBVpLZJJrhfOuvj/EeRDYW/TDIKmiplHCSm9/AaKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0ujTYf+Hvdgyrm11lsi/1TTXw+oNqTJ+CJ4fq4hSfI=;
 b=Y036bfBj7/e0vJPUSutPWLStO/hxiSFcaOXNlWUPxTJdU6CIQkERXlkvUU29Fhd5Xo2nxdN2+Vkbz7MCY68oxUocdb8SiKIH0QP6e0YrpdqlVx3nuShMEddAtGApopOQv+74/eIcZIvpxoh2o8zTk3qTa8yysIGzZGL1f7R7NxXP0cx0cXr+wLn5V5LmNc0Jsn8rBA57elGEgVGgrekUcu6hJj6fDrsSGYnrrE6c7RXvdUdwNW4ngYP6AEI3GmdZh82fHImESEijxBJzqkzMvvEf6nhf1cE2epoDxtHjjDhW6uC3wXC7KYjN8rcGQauo7sS1tku3zsLVRnjcCyziEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0ujTYf+Hvdgyrm11lsi/1TTXw+oNqTJ+CJ4fq4hSfI=;
 b=ZT06jHjDbns93jYd0Ypl81d07vvK4E/WvB4ztCgLg5lSNO4N2lWt4qzu7axAw1YnJeRzgvJgmJykKrRKSiWy2XPlKMyUSMr+S+vCUcVzteKc4JpJHI7+wUcnt9fhCDOvbnFtaAI/rnC0aZGthEpqGtoMolowym5k5C84tmYLpgdk+8H9sIcegqpDAbr2jZ2lLZEyfE119ZneVUhsAu+3i1aG0eWOLIEFQqL/Izt/CXP1Orebw7KRXQAkkyQiX8A9ZLbDC05vPOM2VCfhCocsN0afZnq3b/0zP+krlwZ+4gWcQbPExF7HVOlu4VZwYVtnOPeQrlAOROA80O8O4Ti6pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:32:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:32:51 +0000
Date: Wed, 13 Dec 2023 09:32:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Message-ID: <20231213133251.GB3259566@nvidia.com>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132651.GA29569@willie-the-truck>
 <20231212140307.GD3014157@nvidia.com>
 <20231212141023.GA29699@willie-the-truck>
 <20231213132700.GC31729@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213132700.GC31729@willie-the-truck>
X-ClientProxiedBy: MN2PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:c0::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd077de-ee96-4b91-8358-08dbfbe00157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zyNIHk0Dac5WxG5u42oeIOB3c5Xj8B5cvCFxrLa69b/IkcM7T683r5wA2lltduZLwsnXn6GU3mPGojFjSqSvlHBQd8+ks4LQnpmEk6ciqSI0ONuy0MDmlkjjNA3nqUUNzexFFPBDWm/Itjls6YkyplCjcmnQnsNEu4fXixNx0fxYjJgMIaRch1cvvzHiO3H4hI8wXeI3t1iqieKFDcP3r8TSO0Hro+TPjHczgtSSaZIaCcFsRdISeQC9F2ZyeBSJIuufe7CCUre9wWXUXWjpSS4hbFbQdcVbwkkryMpM3q9tAGCwGzMqf+8zVcH/MqHSndIsljCErYpDY8hqXDbxNp0dIZdNPZQ/pBzGu7+YsqQnRlLGMec+px60FaawOavE2shzDCVNi+1aZDdtYH70UazTtWkchYoKj0F9RVKN6d7KxCzrXZsQRn9XTeH/5R5+ZiBfl+UyxOgrqsoSjnQZJIcadtlttNls2un+2IAXGSl/GHd8v2cYyB68mMvS2rWi4Cz5zGzdV5ophrKj1L9B0/QmaBVmgLfD+kdXoFqb3wv1U74+SUXnAl5dzeHGH2Hr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(107886003)(6506007)(1076003)(2616005)(38100700002)(6512007)(5660300002)(26005)(4326008)(8936002)(8676002)(41300700001)(2906002)(6486002)(478600001)(54906003)(316002)(6916009)(66476007)(66556008)(66946007)(36756003)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0IddgJa7wc2yub1TgSS+ZkU5lr+gkmOnQFpG3+odIBB07FPWgTs60xGbIFUW?=
 =?us-ascii?Q?gkRQ6neZSFXkuqBYR1sx1sPcaGOhUpVK+kbE6SjY7NG5WVaUzmXpX1j7KVlz?=
 =?us-ascii?Q?7WqTgZsEvwk5B5vyoPnNu1NgMW896IVuMum9f547uQ1ynikKvxBCyhSVIgtj?=
 =?us-ascii?Q?Kwymk+6nvYGlvmIdvlcuZvOcCBPrF/o0HQY0lwpSKjoLA2OhPmI4Njy5cGnT?=
 =?us-ascii?Q?CVQ6JjsKzz/MmTdDXiTe6ewe7L6KHc8JwpItRH+bY6PbkX5tNkJ6NNkJZy5U?=
 =?us-ascii?Q?6VH5gzWbITkcOjBzG73KSmAe6A5gutIxaW40kljsr9bXU7+wQ8EYHLDS+geE?=
 =?us-ascii?Q?cpWRiSGinQTyIecP8g9TVRiMpwx8PsNUH3yLA0AqJk0dT+AqTOWRRJ8mSJZT?=
 =?us-ascii?Q?HsfhE8hze18AhbyS00hledoMPtv+g5I+Aif4JkW6KT3BEKw/TGchnVtNoP+5?=
 =?us-ascii?Q?3ysYNa+NyOFduRx7Zp4zRlTVnpq+EQvF2rNm9umtbeayRXX2a8f2IJFyjZpg?=
 =?us-ascii?Q?0dIyBsNbTHWu+ecoXxrgBQKYhoHE4YACLbl/maYmLwxAC1IBeaDjiNbiRpNG?=
 =?us-ascii?Q?YllmA5YKbCWfzGyN81Ca+kEWFH6Wxv8ukGunTohPsupBp+7R9RKKlLq3ydoH?=
 =?us-ascii?Q?w63lE9jgkDU8hovNBEJuXerYM3OUMvIGY5B/cl+DUcWfCTRATG+zjYfthLSs?=
 =?us-ascii?Q?G1t3sUmVjxVLtlEK9QptO1zsKVC8rlrZ/tna4LPmfsshdackt3UpIcQKXHQt?=
 =?us-ascii?Q?p+6wtezdKfEbX7ZcbHOrpVseXFzhijEDVpPSfhIP+cL4nNmpirjCANbIVP71?=
 =?us-ascii?Q?GHEzkXeBhhYfbEI0FSUQ/y/3Zi5Vib2ymzbGmiV8JsH0BXFc0I3h8oPGHNOO?=
 =?us-ascii?Q?CZ9ttMQiJwzFw/ln9joscTeUtQVkOFjKYM8SCbkLJDgIaoWMoxNR72S263uv?=
 =?us-ascii?Q?kOxvEU65Jgw3JN9YLOuZLYXnqaHodB98DtJnF4y3nxU2NB17IPs6S6aFtVFE?=
 =?us-ascii?Q?QVSIlUXh0STohPXfsY2tZ9snLWDHEpo866hP8idv3Grs9hfD44wj8ws6JqHv?=
 =?us-ascii?Q?qA/oCtmLd5TsGWJvL7pOiI3+tOSykrHY6dzWsqrQN/vAlrpjphz1IUpRwT+C?=
 =?us-ascii?Q?V/7opeZ3NeIBuRFZcHijB1cpxzm8XyyjT9M810HaTh+5Yr9p0UOecMxoG2Bm?=
 =?us-ascii?Q?IitB8jyKdZNLFPv0RylHFNngJ0MGpmfwPzrPFyhMQaVfhFhu/mHVh7yoOqXx?=
 =?us-ascii?Q?Cg4u3pUl9wlKyxYFaIcaYhR5pAlo1i31NHlayDM5h4NOs1Vk8Mbspxq8ewyF?=
 =?us-ascii?Q?3LvUmkNzFwVhCgmA2mVbxSYqSnQC0wRRUDtv33e9yLfJymTqSHVdHLSCmT8I?=
 =?us-ascii?Q?IoXtV+Ya/OBNJLNSxDluzEqhDvxX88d2if5PclDpvSNT8koAkGSxdxDGya4/?=
 =?us-ascii?Q?XzkWPPn56pN7P2Ee9fX/q+12PBYSVkl0JWMwW75AVnL6nweAHnmlGkZ7Sb8c?=
 =?us-ascii?Q?F17beXg/icax5G/onIBOZCBEaZByosPIjU8uVO0D8CHZtKggMXtdo64KgBFe?=
 =?us-ascii?Q?dY77OTqcJVqcGjH2gAVZn7bpc/Pu6+o8Rrt3EKie?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd077de-ee96-4b91-8358-08dbfbe00157
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:32:51.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl6AHS0xFWDcA0KreRZv3B7SLyuPcP2seU3hPlcBINtqwhu1xO7AcFWTUYqdecIu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

On Wed, Dec 13, 2023 at 01:27:01PM +0000, Will Deacon wrote:
> On Tue, Dec 12, 2023 at 02:10:23PM +0000, Will Deacon wrote:
> > On Tue, Dec 12, 2023 at 10:03:07AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Dec 12, 2023 at 01:26:51PM +0000, Will Deacon wrote:
> > > > Why do we need to handle the 'dev && !cfg' case here, instead g
> > > > returning NULL?
> > > 
> > > dev && !cfg is impossible these days, so we can shuffle the if and
> > > then just crash on that case like the other drivers do.
> > 
> > Thanks, that would simplify it a little.
> 
> Folded in the diff below.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 536e47e3a65a..b0a6b367d8a2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -861,7 +861,6 @@ static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
>  
>  static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  {
> -	struct arm_smmu_master_cfg *cfg = NULL;
>  	struct arm_smmu_domain *smmu_domain;
>  
>  	/*
> @@ -876,13 +875,10 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  	mutex_init(&smmu_domain->init_mutex);
>  	spin_lock_init(&smmu_domain->cb_lock);
>  
> -	if (dev)
> -		cfg = dev_iommu_priv_get(dev);
> -	if (cfg) {
> -		int ret;
> +	if (dev) {
> +		struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
>  
> -		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
> -		if (ret) {
> +		if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
>  			kfree(smmu_domain);
>  			return NULL;
>  		}

Looks good, thanks

Jason
