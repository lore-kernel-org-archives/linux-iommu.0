Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D794197A9A
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646377; cv=fail; b=nszG4M4oHcWvSvIi0sso4y+uKr6CTITI+B1xN+99YYqqyL3oy7flv11H7apxp7Fafu9wibprcQPbFioho5sQWbxSIh+Sogfhu+PJ/YzBtCmeUkeshgurpmfkZ0yQuKAOjxBjopyVAqQwU7lBfX8on5re0SDQ3wh9nV49AIUJZSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646377; c=relaxed/simple;
	bh=D7uFhRAoWccYNy0yL8+xiODHI6QvmAnfkZtruB8JuM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dIFCpePebnIac/F+bPQP/1zr19hfemDQI0pgPGQF1Fk6LCcNaWmhnLO6OmqEPb4dBm9TFcOU++uC2KF0h3D3/VjUsLa9WWYssL1YQm7hWURH6mp0M7bdgMEPym4Ff2OG4ixMnfpXViMSiI7neluJER46wCTjtcdAiVO8F2elb2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hk0/1Jms; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hk0/1Jms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCZAbJhYg45BR5OPbyXOKR4fsV/sVSauuWTnXIEKGFOdhg0uP4zgyaCK6lZB32ALBdsbJ4GC6RChF4Ks8MJAd5V1XjJSolyAXysPX9LH9Upc+5yRiIatxR8oyD/p6hbVirwvPSTH8iBTq8cLkDgbytD3Hamiay4sa5+04Mf3zNchRJgIvtODIttmzIRu8uUozHEqWi100CqFRd294rGC7VYUq8ogMssehWpl+4D6mLQOitqySpoocIyTSNH5ZcVwXvEo9FNLhxOmPkKcR8nhGEnR2wMgBT03xun6fWfuKSZiU2wHbIMd/jiCJDF03SmDHYfvxjCjgVPFLeQmRgh1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkdtNaaRYF4FxUfKZPS9rineA5Kuy0hc3LHOhDHDArc=;
 b=yzAT+FUwM6niAI7uOR6Kuko0b+cG00jPMnxg2mfwZGv+7tmqkkRbUwgCwlOLSoGipuiKhPIIDHFa5a+QCqxs9AuSotxc7d7HRpODjTstXHnNiNJ+oaXxZL5bFcLySO+eYvMyP/EPH4Ds6sTsazEbbSO+tkSg6NX9AL4Tyk02qqeYAAzOx0U5tAXhWMrUu1CYAfwPEaikVhGg6NN/CycHy8mvRsOMdwbIUtdiYaiyKUNoHG3wtFeHxi9Njmci4WtmAjpm6iVFOHfRfvSe6Wjoh8z8pNpSSRPGFC9jIMqCA41SwtsM6Vo7kCE6CG4Rw83rVDfYqYFkkEz6A6QNCbULUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkdtNaaRYF4FxUfKZPS9rineA5Kuy0hc3LHOhDHDArc=;
 b=Hk0/1JmsssoarFl1KYMdtkZtjWl+mkJ+/XCSgL2DACdKwbODzsIGhoJdtLiYudjpsDTMwyoRq81SeV95GUm7NbBlZvavWIOvAC+A0NUz0aYv8ffDVI2q7NvfEEZTByQOy9scbbnY4szcDc950G8Blipc4q9kezUokGWzMW9KbZ9WzfqEsNVV1pUqAURUEuiqnPLbBJPhoZBPFMFaHJmqWfeTXgVrvLX7NsBe1FQryhH6VRCgh0M69icEEiFjqCn9aQYFnuhe8APtflelErkFPjixL2A12WMj2eiIaoDVqEuWUlCOaek6KinSs6jwXQ0KZ7K13t+TfegFfLglncCGDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 11:32:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 11:32:52 +0000
Date: Fri, 11 Oct 2024 08:32:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Message-ID: <20241011113226.GE3394334@nvidia.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:52d::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 123ec1d1-2710-4a1c-87e1-08dce9e862b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FP1uJBDr1AqnewxhKiJKtv1aJaE4wVsu3cTAZmR1kfh7paFA9GOQbf/MNguV?=
 =?us-ascii?Q?gL9XFSh09yXnG//28ZXhbTkAxbRAlxu5k/eyqWTEFPuinjfoXK7dqno12+Sk?=
 =?us-ascii?Q?ooaxX6QFl5SogisGTHWIOVuSL+MVILlQjoNlDF2jVEWQEfbDfReulU81PDPg?=
 =?us-ascii?Q?DgLrgYZzLJ8oesJ8sih9llSjp73Ne6QVjdWB7x9Hujh+g7Pi/5GTTEg2jpmj?=
 =?us-ascii?Q?tAzchN/u8Mu8TA5SpGyFPVnKLv65IBx4gSXdyrY79SvMUVRVyCRYAzRtCNOu?=
 =?us-ascii?Q?NZpVCWOZJ9/unOUE1+jDoY5gDSOUgjMqB334SCNzj/pY+ULsf0zWC7npk2i5?=
 =?us-ascii?Q?YP5fZB5+BhR9DnFCSogIQoPsdD9oVRRVvuol4SaCXBABMefuwD9vyFSWKEua?=
 =?us-ascii?Q?L0mFfTjTDelfldjZOy9/xmSGZie5NGQ1zTkmAVDydNWWHTQcHkdb5R6KfHvh?=
 =?us-ascii?Q?YuT5UpuyQbvOCEzALm+Ps7JV/0CERvjA0r4AZYBk/h2r081Sl/QpU3BhyaLx?=
 =?us-ascii?Q?hT0+5F40u2dSHFadn2TCNNLWyZeWtu4PyIA4S5D257i0l/SWDppL5PC7s6LX?=
 =?us-ascii?Q?C9C9oU73IKKWEQB+7TAZU6fUcHCu8frKb5a8pA+Xg1LjxaeY/TXP4wbz1/qi?=
 =?us-ascii?Q?t1ITBl4oJ78zrp3nSnlHktzq+uTzUX6ltlH+9BYfM/eZB2DxkjFE1VVkeP93?=
 =?us-ascii?Q?3huoSTmG8JSXXczXmGZH69alZ0bcFIOaYupoFspc+DOwtbzxi+bvzB8h7xJP?=
 =?us-ascii?Q?Trh95TZ/6Ak5j/WC33OZ3zoM+9NRoJ9eBVnRi40z8fEYaiuFmwnDQuZpnkJF?=
 =?us-ascii?Q?e9ZX8pU2a40a8qqclu8yd4ood0kImZ3AVoIaLHqTSHL9I0rvhYBfSBdSxQvR?=
 =?us-ascii?Q?QN/9wMWhFWTp7VY0mRVDURGF+b2AwaUKD3uEBXTK/mktwuibgQUXNKxl50Dl?=
 =?us-ascii?Q?aWcs1gSpW+CgXBlSofBa9ezj2Pd3MchRIdSNV8jk7UZr6zv5YRz4bCj3DZ19?=
 =?us-ascii?Q?qI1nh2cF8NTZJxzi1zZ7vUEkmOCkYIFvISPxMD8O+qlh32J86qIjrCU2RrD4?=
 =?us-ascii?Q?6hf5tY4RAST4smLJLj1Ff7A9Xclss4VgPtuBOiEgkyILcBNKlVD3uGcUkjOE?=
 =?us-ascii?Q?/oUxLud2r9YTVoWZLNrUBU7lEySIvtXEP9wAwGrW9g0V2FMa+q/mkwsfeDGQ?=
 =?us-ascii?Q?rEb5N+hY7/26doz9QKbaMOVarl7C7sBHQJFczXu9FyXL0sHHutLfG40ceY5h?=
 =?us-ascii?Q?gDxN4UPr827tS7hYXu9EMWjpPKl51gC/tr3IVZ7i2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ye/zSiHxzXJBLiK0BoxJ3Wg1oDk9tL1+C8DvB1dq/Fs5x8B2Nni4Jd2PoMZh?=
 =?us-ascii?Q?7yGNs3prKXsXsLO5xiYfRqinMxu1MFe/jqzcxqgiTuFbMfLec8syZBHZtSIV?=
 =?us-ascii?Q?EeNxqqY50jPey5Zx95DEV7ZpLoItpwVaQqvbW+K4jxSFffRGmLFnYBNxpU8h?=
 =?us-ascii?Q?siQeG3ROYZtGqzIRXCBsnMXBpum59Vx/VVnfvmD6MQRV0aot3n5Scy1ZYoUI?=
 =?us-ascii?Q?jRlica6m7AZTF5pT6O4kIqSFLh7++4Fxi6vWg/6O4CFcPx+jEdqyqdm4k/qq?=
 =?us-ascii?Q?HPNfaXFGNSPZ4fBrqs4vAQZlRHkNTymKutXMb4Nd6pOa2Y3KCTrvYcpHFh82?=
 =?us-ascii?Q?HZgE3F6mERmYu9lB+RJ7XFjxHFcONMESVOI6bUJLF/s/liEk+nGhi7SZej8o?=
 =?us-ascii?Q?tqdnWi+NZdfOv06/bYKG3+ApNUzXJcOsSDe5ucLH1lUFR+c9CR51iXKENRNQ?=
 =?us-ascii?Q?jkdH7tIN9o8UDYThOl1nQLagEA3m+e2TG0gsRYO0MNYllhrDfVaaKSSkdK2D?=
 =?us-ascii?Q?z4XsUdWJTPWRKfnHzCRkvby8jh8dDrytzKY8F1uMcQ7pAaIcvmIi4/8fqxmZ?=
 =?us-ascii?Q?NmBbM0hKu1C3Q7Wfu010eO7PafrJzmvhbEPpkxPOfvLyLUI7BYhlmTb3mRN4?=
 =?us-ascii?Q?nhzoEV7JHDyRnJNYrMmpj8gHTQMifpYCDgfHHQZk1Ea5NZrpJ82dxTetS1ap?=
 =?us-ascii?Q?UOZZ670SFQqEL7KbEzxnb2/xzuGXz2U93tYQyuzUepKgpk42MDvuDSVpGbZG?=
 =?us-ascii?Q?2wiCqxNf8+ps+PWlQAhO6HhzSDCshztjElMrFHwB0ZU6Z72UrlqykrCpwtbx?=
 =?us-ascii?Q?3d4ze9Bx6DzDcHuVfESGpJRqWowl9U2Mw3NpxSjkQ1CaGiSluQywFnl5pMl0?=
 =?us-ascii?Q?hOZBZHfZNiKj11VTTbZCETIR8HCFlogW1ZV3Ubip2n9xz33tB5YEJ6MVoZa6?=
 =?us-ascii?Q?rUTXePn5No0t2t609iHKm2yRmUkGzlh2q7LYB2YTCbvBqAI8JaPc9BgGcf4w?=
 =?us-ascii?Q?p20ryl2YK07kDS7Z+kJs1bQLzMWE+hnHd0qVBhUqeqBU48W1VVbJXUgeakYX?=
 =?us-ascii?Q?/yjIYNP9CMXB3FgJteaMabwFlsd6ldkniPd0gBISjIsBuFxa3AVcX0x9FOYa?=
 =?us-ascii?Q?c9uuY7n5lHMtH2gybm/7slzYIaTZvw3kVBTz7U4KBfGP8BnRAgS7Ik7tK5vb?=
 =?us-ascii?Q?lalFQstfifOqPerKEQ7ZdMsAWyI9Bza/fF/NWtf0Qhp1rAXUuTxVcagjJ3vJ?=
 =?us-ascii?Q?GQ41pZRaYLNME8k9p9Mv2KtQevi1Yqik8J4u3Vc4YlcmZg3cB7gLaPGvrOF/?=
 =?us-ascii?Q?1HJPfYrasRH9Z25c3W9w/MWZh6QxMU7HikR4B3f3VRiP0tgkrVjxWhpxCAa/?=
 =?us-ascii?Q?Ykz655TfGQozQUSgLK5TeMz99aqkBJuWWJzSQQjCqSNJ9U7avtIGFcxMn4OT?=
 =?us-ascii?Q?hwL++TNV3akPl45TdXamxxHW+akmHHKDSz9PezuiuotDtdA8C4Z6vvV7cl8A?=
 =?us-ascii?Q?5zVa5ilxtufg0vaWJEQracOMmkmeHq/pKYvvRd3Kk4gh9mLPHwPVgkQ5YfO3?=
 =?us-ascii?Q?aLZdkcaW7l107/pfqRU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123ec1d1-2710-4a1c-87e1-08dce9e862b2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:32:27.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx8O58YFoDWlxWRmVkDteJ63jBdCwmoNa68GIu2LVE79AsnEMKROFklSFDsTZe/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

On Fri, Oct 11, 2024 at 12:27:22PM +0800, Lu Baolu wrote:
> The domain_alloc_user ops should always allocate a guest-compatible page
> table unless specific allocation flags are specified.
> 
> Currently, IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_ALLOC_DIRTY_TRACKING
> require special handling, as both require hardware support for scalable
> mode and second-stage translation. In such cases, the driver should select
> a second-stage page table for the paging domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Maybe even for -rc/stable since it fixes uAPI?

Jason
