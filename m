Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCF3A759C
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320709; cv=fail; b=TBjr5EWJyQjvEl1WcA6ljFFMtn5nvTwH+Zw/OrMjSR9DyNq5lacOJqJ9gajpuVwjFvb4AGQqvd1o/xg4a0Rgv625SqsBf5zDD9xRjZoBojq+gYlOlc2JqmSoMG5F+87EXwAypMJs7OmTBdZ6SLhHEbG4+iT8K1iqEYA6iAUDrHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320709; c=relaxed/simple;
	bh=5qyHEC6XMCba0zJWOC0LnDiMZx4D8T+Ah/rNhJSFt1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rM0SkN5bVi0lDCQ5Ofb+TidlcWvSeVKg3yOlnc0SiSObrLjx93pDUiCeGZ+yXgr+Zd4IVibWcu4opNsspx/CqfMuD4iJtcWAwiP2EkhoFvBCNjglgcosR9ZVetENwPpNT5T/v4UTNRDLFa6QyDcbf+onZ1+ZxFAvnMHz0AlbPCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUDkVcde; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUDkVcde"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+d8r/qToFCMdJq2Td7j0jkD+W6ONSQNIKtZOgSPLbQ66yk6aHUzqF6c0J8JZgfhoevm5lD5ALmlg1vUZ/IenthIogYDlEV8pV5XycPHmwZgCuKvpUgoV3McKUZEzoSa6m13PPk62v66bq8fZTxwaXfUUf01Xj/9cCk5q7baQlrO9z1AL6i95LGSCfSR+2puhzET3b3JQhY/k4VY+yBKCGuu/o+uVAvvqBxhZlsV/fONHBQCbR5IwEtK5N+QR+3rqxNkJSxNldpWAjaCtxm+0BM424Vb4Bijv+Y5F4hsWudHG5Cdih/vsbt1i+/Mu1B5M/hGPatIkrv3YFCq9KdojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjKXgL8nsysHsOD8U5iJxfsR7w+Nl5mqWV2eVp9Exr8=;
 b=MY4x/LlCO9QgVNluCpzCsyZSCJiN/s+Sji2oG+wPdnIhc7MnH4EtyvmMEgHPAZ9ZMqx1JGc33E7UHkkcke5ldhHkj6cROvRqNxAypi0ZZ47m5dlwzoylvN9K6LrTFuIMZjlpTcbYxMsx/3Ae/jHvE3hQyaXoup6m++bHcR+GU9MvRaenedeTyGc7uJjPIYBo1LfJYArwkaSQ6FsodsPwtXTM/2PrjRaytbOXllQsW17/SUcOBBxIFti/91lAFoiZEYSooqmkoGAHeI89KzCOYUurKB1s4nxBiCT/muw55ECslrAZhRolrKT0uHGvT4yYH/96O3QYn9BL/t01PtSmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjKXgL8nsysHsOD8U5iJxfsR7w+Nl5mqWV2eVp9Exr8=;
 b=kUDkVcde0hbsXZxblPGDPxbx17jJVun0XeHttsFxJcS+qDNFhDdPPCbvZfSiknt/L8XAwkAjt5EILvRNno+9/H/OIXHhsCGbficHkRX3aWvbEiSZz7NVna+vhY2sPBXG4CmJihRl+WAOV0bZ3oB94tIs7qn46EUB0t6DIBO3CdavEyDUeEE6R7/kRsLj/0qAFtWqUIxTNb+RLNSoRYNc1YrzYgnr3K65mHPMjd+bIWbKfCvXtYOwLU3M9Zo01bibkBj73Jg4sZ0aXtB5c6pMDz5gPlRcc6a2oGz52o5x5ZfRFjSFAeFkkOlIWiwG4SzlXigY7QczI4nLTM81nFsqtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:31:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:31:42 +0000
Date: Mon, 1 Jun 2026 10:31:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 18/26] iommu/amd: Add translation DTE and VFctrl
 TransDevID helpers
Message-ID: <20260601133141.GA398533@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-19-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-19-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bc41ae-ce49-4bad-a760-08debfe21df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wd7dTKzZozzpyXEaMmk3j07fIZwGmin6+UJxSPbDOPL+bpgX7yw0z5dXfKA3AIATjyq6hAeksBi3irTLRe/QeT1U0r7HOY9ylqtqJ8L88EnqxaIw6QMH4ioz+2cpkor2NwGRI8zaDTI8dS3ux3AZN78eLaq4F3Vx8Pkov/9RXN+uxTl124gv7ae+aELroe6nm3fLcndmoGkaGgBs7HcUu71cOlUUr61AMaH2zyfUIJjrZxjEmP9MJ0FpJ7xHJtWyNVk8XWP8V6GW8Z3x/vT2OQ5eVNH62zcWkhLNJ0//4e87HmkbnzgzxccU19pYspystlM0wex1Y3eZvRtoE8lZ7lPBfzoW7SZoygdvCzznYfmxtsg9Md/BFydlhaD71jCz69cVxWn5mcENJHaSl3M4UcZLfFpmqwehz6WVNN5WYHtDG2FJlIZDtEk+djTRK7HmW3GOvS48reqCUXY3CHPR74jJxA7gC8ZdZU7F0seWqSwq+HNYG3TCx+LX01BvAVrWy5Giq0wL1HgyhgTkU3RY/n7cC/1WEtFRedhV/kGqB6Wh2sp4ySaj2hgXXGnGsc1cF5YgUqznvMj+mrBf9y2vxJgPbOJk8zhIiEDktyDE2xO+AQhn0QC96u4FKIXzcrExTO6uFdPuRXJ5+UHEb68iDRpSXVzQlH7TqKk9We5tqPt85S0XSdKruizT2kukOWk6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rahxqoHHYTTvMTi1jpE8qYR3XuQtLB6yUNB2Z6AekBiq3HjGzcv6/sr0gVRy?=
 =?us-ascii?Q?lUV8cOejAutNuXUV1AVFUf/wg6YmRQ2dnsg3rcdNMM4+XEeVLwWRQ+31tJmV?=
 =?us-ascii?Q?FjzUGAwgEG/ikHPIB59xavQE4/S0TwTzVxidAnqhmGYFPsRbO7qjdQ7L0ZvR?=
 =?us-ascii?Q?cw7EJkelywvGf2xxf4melCcU2WykOjHbPd/sE3bK1QCn3tN67qdYKnmzWncQ?=
 =?us-ascii?Q?werHVve8+xzmZ6yd1XP9obMYrlXnHYFEdX7clQaxFIXcJbulETxmNdsg3ELG?=
 =?us-ascii?Q?Ho9b/9L+TaFtabWplYElYngDvAtrLffDXYd4xap+l/uGrfZJxgzYCoXyVIng?=
 =?us-ascii?Q?ubAqa3+4XIdX3UJVni5blwFm4/9y4yvHyZH8wstyLJ7i76vHuJMZ44f/PUaB?=
 =?us-ascii?Q?ky/sdAQ6amhgZp6XNWlnG+MVYDL8X0eZOYS4sK1EuGeUmbAXfzxbsrfmXUvg?=
 =?us-ascii?Q?4P61QpAlG9l3sEb0m+ErMWYmSLkZcpui0yDpIz0yj1CjfQSXsdx+c0oBrgZ0?=
 =?us-ascii?Q?DjK1Ljv8BO8hCMVniRcrZnkJ6FNVr06j0HuAK7XtO9NcBYbMQBLYOLNlxgjQ?=
 =?us-ascii?Q?cUzqBuLOx2ZTjeZTtade08csQWGvuwAi8Hqz7RmzQG3upMk9xhqcgvfzSIsi?=
 =?us-ascii?Q?T80+v0XaY5pz+20zSWiZd7zuGqdxEMLcaOBLVE7smKmUIrtCEIxxT5gayxGU?=
 =?us-ascii?Q?IJ200y4Ba58FjgBJY7dhslHamKrGW+/BtK8LtZi8qMiK2Tn0TDN+XY4upv3O?=
 =?us-ascii?Q?SoADlHwh8NZANFvO9k6ClKeHx5ABPnO17LBH5HtPS4aUQ+jyn7C8P1wF6jSr?=
 =?us-ascii?Q?2dyGpWdn1hM9T64YrgizcW94HsBE00b3XQO8fz8HTNmuxgcQO0LVAPn50q+0?=
 =?us-ascii?Q?GdPBzzGprHzKkVEHjO4UjxEl6g0GuaE7HkLGpnEqyrOWIYRp5KVnxcp1FM88?=
 =?us-ascii?Q?Z3Tml51rDjTLb9MGsDTeAGfhlyaE2WeTqLvNuPtlgTHaeNR6bkJam6NIH5pJ?=
 =?us-ascii?Q?5LkyUHO83X6UmfvdT+KW2oAfuFdhT2OxgsMvnx7s2dGoKxCCd1wWZarrmXtx?=
 =?us-ascii?Q?GBBrIf/k2GsQ8EZJv6f9eIUcdFIya1bOZlzQgahWLimhKFI/lou5JVqxHpmV?=
 =?us-ascii?Q?Tiw7K1x1eC3O9R//m7WKinfS4gXGifCb6pH/GffxyqGzoRXZPsUe6DLj5ws7?=
 =?us-ascii?Q?KFVgrLRymai+aXpFCBGKBfZOyMxdI+97HqofZyl62Ty3k07A66uhPJOSRFPT?=
 =?us-ascii?Q?A6WcuAKIZAakYYLiXSUTAPxaO7yPO1SJZCv8ThGTyUoxWIkjtNWvtvZYVclX?=
 =?us-ascii?Q?zQI/OUDKDIY1RTsL01jG1+jdHM39FDu4/uMnzy/v+drYZXpx+aFzP9llhC0/?=
 =?us-ascii?Q?S0rSvETJYHBAS6+8MCrg4xJznzktHcp2fALaTG+7HPdwFNqZztmG9omWlLu2?=
 =?us-ascii?Q?kOgeOTj0Mrhkm3ZRfEmXDLM6PjZJDbIgbgM59rPKnJHpHQQcX/z9EIW1KKBK?=
 =?us-ascii?Q?dR03JkpyPal2Cb1mIXzQ3Yv4G5CHNIJC3BPk0ekQgFqWJFRXYMPqI5fQ6TtP?=
 =?us-ascii?Q?TxeVk7N1REITUobS6RQV3f+3U3xJPjKJp3DuUr6xMkhID8y/dDhybvV4WXGU?=
 =?us-ascii?Q?jgzdiF9FjaYPna3yyLEGW+wbhfzufma4OgY0MH7vp73TcPgZ+3VgViDjtWws?=
 =?us-ascii?Q?Nlg/MohfSkRsackbx3DvzGO4X2W1nw+fgfIU3PnCffxUIARq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc41ae-ce49-4bad-a760-08debfe21df8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:31:42.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5nyS6fYvpBA+qDsNNmb3VD7mUSR2L1RtVcqsr7XiCHBBU/Sg9/volXeIvu8jj6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726

On Thu, May 28, 2026 at 05:17:30AM +0000, Suravee Suthikulpanit wrote:

> +void amd_iommu_set_translate_dte(struct amd_iommu *iommu, u16 gid,
> +				 struct protection_domain *pdom,
> +				 u32 devid)
> +{
> +	u64 tmp0 = 0ULL, tmp1 = 0ULL;
> +	struct pt_iommu_amdv1_hw_info pt_info;
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +
> +	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
> +
> +	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x, host_pt_root=%#llx, mode=%#x\n",
> +		 __func__, gid, iommu->devid, devid, pt_info.host_pt_root, pt_info.mode);
> +
> +	/* Setup DTE for v1 page table at the offset specified by devid */
> +	tmp0 |=	FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
> +	tmp0 |= FIELD_PREP(DTE_MODE_MASK, pt_info.mode);
> +	tmp0 |= (DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV | DTE_FLAG_V);
> +	tmp1 |= FIELD_PREP(DTE_DOMID_MASK, pdom->id);
> +
> +	dev_table[devid].data[0] = tmp0;
> +	dev_table[devid].data[1] = tmp1;

Please stop editing DTEs in place.

This looks like it is writing some otherwise unused DTE, it should
fully initialize it and use the normal flow to write it.

Jason
