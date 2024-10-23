Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A63FF1
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688498; cv=fail; b=QMPK7lSfwpRpMs3k0o8FOGNTbCylstXMgDLeM2G0BeGUwfol/mgEG6yb0FYePkLslEDOcivqupET/7phOOeaz6AdfhHRq4eqGR6ljdR66hmtCLGQuGtadnXyFGu5hw/LOhgnWL4T3l9NTjK7IUZEKfQaJkG0qZEEQJsNqzXgGKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688498; c=relaxed/simple;
	bh=9jaEZPJmsXJbcBMWuK+R7cmYzqMmgHd3qfvQZbHEE8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKTaZp03vQERmtMZpih+iJOSvVN+J3Olz6QQMQl1VE4RV1tcoB791p8arspra+jhJhZq2uckfSn5uuynAwf1thqjB5mI0WlbkI6FfJ3TZgo3cbu+Fc53lTrqRP/JsBpcjmQyjTP8RyqSrIXpewjiFK0KKV0KdQ8ccn2jSOBaxfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ds4HWZD/; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ds4HWZD/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B62LCIN/I7inZTPNrdIzzecgfN7TRsrPEdDTiv1IviLDCUGF/piB3r4S1uAYiwoEQ+fkwgSC0t071z4YMD4T19QtAbM4T0P2t9Dw3CWmhtkCkXoKf7seBTZLNwCisWYUQseLkNTycJfFLLyWfbpabemONOywM7G7cCyvlfiqSlhJRYfbQ19TRIQJ6ttoMQMvuF1g/pcIJpRkd8AweSsrYXBXEQh1tP/n4Pn7AIs701CYRJ5Rzef794Rnr7IIqz/HF7Vej23vlS5Sv2umVtYVfobaqDsQkmU55GsdDulVl2Pqdse8Ffdy/5imv1GPue9x54tIWuHOT5u/hDPDfKYIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lZcCN/kzHZhMtR8dcdyx64WQ+SbabRNeUPUMVAYMxU=;
 b=gtUbMaZMrmDrBIYVuGgw9oTYjvzHvVo2gAfHAGBRdAe8wky+F0zvAIG45gQaiAsKGgFNn1Dyw7M/QNJMFRRod8xm+0Z2PsJDJGj6kTjytH0RscZFU91g/KanznVJ1BtDPtpzlSk9SbcEWG9dIiS5CZRpeV3N8f7hEdRAqOuYQ1W7UYYzpLu+VOiwpSCoiTHsEF9uijWo7eRZiBP/SFoAPkSl2v5BzSj7XJ8yqVmdjyGXS6qil03kHMDXq12QpFJr3tLHn8ftx6Vklwxu7TgYZ5ekp0AjdQbbu5RlTCF91jzZEs8AiHAifWezBR6TiHfFjbnkWCybxHM4fsZ0RxpO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lZcCN/kzHZhMtR8dcdyx64WQ+SbabRNeUPUMVAYMxU=;
 b=ds4HWZD/L7FCZKAO+D4EL43am1wlaa+0USUVj4AFzJHSSporDAzGr2kjna7/cesCIXGPOl84eOIt60F7VOZ8qslCHq38c3S9lo360wahTYpIFj244olhkztfpPMTtAN7rO73AguoRzPs7DdPdGsVh61waRPKdpuFZQyxVsZ9EnMRHk9giI3yhAqDdtb9kWJorNAkOftYXoAm9SQKdIK9BoAuIyR+nKdYQBIgfsQH/qB+p7pvdIKP6ZDAxz7dz7dRbajyhwKb9yFyegsikWUJroFdfPjlJcTO3uGamE+IozTJgh0/25C5N5lsnIrB7WLRgtc+meVt4moldxMEdbnzUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Wed, 23 Oct
 2024 13:01:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:01:32 +0000
Date: Wed, 23 Oct 2024 10:01:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V5 5/9] iommufd: folio subroutines
Message-ID: <20241023130130.GC864191@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 82734081-0100-4b65-1bec-08dcf362d107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8LxgXreS+JukiXVd1IewoqCPK3pthkOYrzMiivxN6mTprKuiO4FUyR0kNU8d?=
 =?us-ascii?Q?W0uZ0zj9ujcmFilWQvc/j7wU5alLSrSnzXlQ1pncBFQG9iQK9sMTXYErm511?=
 =?us-ascii?Q?cQPsGObH2suOhhvUKw6q0gA8bM3yIhK2DdOIY2UhbXDZLQOqEPihxn7jw+4d?=
 =?us-ascii?Q?YUwX+tB2vMRXJc+BiDXsQdoNcbl+ezQtPcCD1ManHIc2uhmjSCDRUOmvgyar?=
 =?us-ascii?Q?XjtEFQH1sG/IOYGPKjqw/hkEcTv+a17nOvZaSOcdw3kUtlvq5wyscM2wv0q+?=
 =?us-ascii?Q?M+uWXPdIKpX9E9S871vqZSH9f/3M01pIUhFV943gpQ4lKSEmTgvTwshnhJm8?=
 =?us-ascii?Q?dw0CYoNcuR/jw7bmXMihO1u9tyluSeoPXy7XP+p3V5TW8D4aDGjFu375QHAI?=
 =?us-ascii?Q?Tbw/m46hLG565dVYApLbAoDsMP73gqV555MRqmDY7xqY1xkoX2NwWcay8lH8?=
 =?us-ascii?Q?AomWBPgQxAVjnDdxC0KyEbF3j+kO2t/Zjp2BgGwpTfD7hHzZlibD/HHd6p2P?=
 =?us-ascii?Q?O26mbsVjx40B17ZlOAht94BzhNBMPaXt3xwioLjmSPcASPT1bNNikDEoWBYG?=
 =?us-ascii?Q?w5OjlZNJeu65Yfbll4M8VXmcJog92ccPFr7WvGgkCZqruaL9pH2visi7Eg0r?=
 =?us-ascii?Q?HHBWjP7Gn/8kRpaeLBQO/UdYJ9Nir/1N4ANKJnnb51azY3s62Q9/UDLRvtcs?=
 =?us-ascii?Q?DbWiisUg7fGpELh1hrnbwg6f8u79sz9cQW0BNFxvSDvTJttbIWjobFHWwqQo?=
 =?us-ascii?Q?3WJmppFt6HHDxj26ZbAjm8HUIBJVqO0MFK8/2852kA+xm+MuDn96V8T0jToy?=
 =?us-ascii?Q?zmFyOu1N/ma6QTCXWXPujlptF4xGbjSEyGvPdszE4ctX5Vu5/NoNcqoWr/qZ?=
 =?us-ascii?Q?9uO8MNIZkTOT8q/b3E5299XW4YCCZXnwTYeDbJivCvEavN3Y5K3ZalwSgEvM?=
 =?us-ascii?Q?1ArmOBiHzNk5AEoma8OyhdwYBQXsaZXwHwRkVYgkZzSUPzi9N6FFMclk31UT?=
 =?us-ascii?Q?B4OcQWdrx6npWMRN4/zcZ9Y04X/gXOl1PAlnCYUTCSF9eBduVzZMPXiVT76o?=
 =?us-ascii?Q?FBmIpC3uqkd5dLujudwvk5Yo97b0nlFKZcm0My+orQtq6x0hypQqnlKsOnNO?=
 =?us-ascii?Q?Oz9d1KCOMxjKLRVFBkGCXKU5Bqmk0Qr31YQvu7bfe+TxV58SAE7K2UtHSyzW?=
 =?us-ascii?Q?qWkqQpzULp3YGjXdLFEM2Pl9tkXx7AhqxAZTkQh+LAMggSziAOFoNLR2/nnj?=
 =?us-ascii?Q?bcI2ai5cbTXdo/luXrnGp82UutajLQijpZTH+ZRl3DV0vh1RNMlZbAZ6v1Kl?=
 =?us-ascii?Q?tLk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l1WZLmxd5WQzYKLFQjfXzloD4eu6LhZP4iheZMTaaebZZ3+n/tcBQBvJdK/q?=
 =?us-ascii?Q?UX9s4ruZZDFBpvMY+Im4Ww0ZZ3DjcMs+vkUtBjGHwmaX5ImCBEAGfKnY5lba?=
 =?us-ascii?Q?8iyfWmi+UkOPi6yGpIL8UstwMCF+7ZKO/wSlzO76ChfUBdJpo9DzmL/Uqkvm?=
 =?us-ascii?Q?zsZRjuzRlL4RhbrKMva+VyznwP/92cXiZuRBOpqZIdImgI7Sa/G1K/wtJzvt?=
 =?us-ascii?Q?6nvsyEi51Tjhh8Fd7NtidclEtdRbq6aKJphEw8t/CkQ51+07flNJnJaoU5KZ?=
 =?us-ascii?Q?UUs6mpKyLkSHc3kDibB46S0TNEp6L4CgCjiin3Tpo5bbPzLkk9pnO27Z0j6s?=
 =?us-ascii?Q?IOutZ/5o14cc1rueJCXRIFiTb7VemXSeDZGVsevU5qKMGFdstxp2i3joqMaX?=
 =?us-ascii?Q?FfQS0XaTChpvs+z6zSgWgLPpVTemKXL8DZRmZifGNDHJfvNp8zVg7ZyJ5j+5?=
 =?us-ascii?Q?xOk5Sk74WiAXRw059Qp3nVaLAuHdLwJkVJAWsfpk+bxOu++8oUmx7aefhuJi?=
 =?us-ascii?Q?lw2Cvz5fqXWJ8ZVY3NHCbBCmBXSApl/OnEQ/5TTIao45I/NEBeyo4z3dk2+3?=
 =?us-ascii?Q?lsVOorapmbNToVut90beeX+hjKMzRQMIPmMRfjwSyfdj68MeY8i8JCTvo4lD?=
 =?us-ascii?Q?VIzKnY/0tU9lZNU1tseIuhobKOOqQaQVqXXg0wGap6CY6+FDHbG1HvGp1+Dq?=
 =?us-ascii?Q?2GhlqJuWijYWD6mAmvRCTcu62CefunykToqQ/Slmb/7GIxZeBKfF7J3hcCmP?=
 =?us-ascii?Q?kkSSDmRsuV5sei7D2cCBAQy0YzSJxhmFPG2w+OV5yNMVDWhPsEcewLJVLbSm?=
 =?us-ascii?Q?HqTihQFS2RHA+z1SZ9oDXd1aQaEpMKI8FUcGFPAG83KEdXwwupQUP2s3Nkzl?=
 =?us-ascii?Q?pQV92JgtKs6UXNW/aS7/DxBOcaEVpm8F41ZI4uyy9gOEyaKjWl2JgXRhCPMj?=
 =?us-ascii?Q?CHJe1N9jIv13HR5OdHDivwJWOgaqxTkmaB+LVQhL+wxRmuSty2lVJTG0viZ0?=
 =?us-ascii?Q?+nPqc4cWQH438CYUKjB4Sitizp+7wNG4wMuMFDDNqzOt/OBnCkDZRF00pX+n?=
 =?us-ascii?Q?gE7ZrYtbqWuEAzAAh6SQKpHpRtIrkIQC4AtAYEUH+xDzG+nhSjzRu+mML2/P?=
 =?us-ascii?Q?xgh5758JTXJEP2MsNsUGlISTpmvhfXkzq1u5TqJZoGZVDMd2iW8SqMNrHH/3?=
 =?us-ascii?Q?sBViKhqgNgvTzq6ljpQaWPZ1K/nOffFILiKiIenk/qSsEhq8nFXE9cA2Vlio?=
 =?us-ascii?Q?5EkesrazhiodUI6lW6HFRkA8QhRaz/qRUwiQPLjLmxMbScA68MeHupHrHJVp?=
 =?us-ascii?Q?cMteczwJXHkg+zzvoWBgWLd8q8NRXPFE8t7DdWXCPB8v7QOIAV3b1cxFMZOz?=
 =?us-ascii?Q?Z00gQQNAAzh4uGsi8OnaNol69tsuleWe4eYvygunKER5E1wLdFWzKII9G4E3?=
 =?us-ascii?Q?nywqQvp7C9/E+Is35qlBiereXK94pQyQnJ7uidWzmKCLnX+HNycGRHj4QxZx?=
 =?us-ascii?Q?lx7ZOzKeeXoyN5EKSRAaBj0/jRuYYAIz8XTA9ZNVffsCgQOs+YisO8GlgwwZ?=
 =?us-ascii?Q?/teSnbH4a3g+5ugLVWQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82734081-0100-4b65-1bec-08dcf362d107
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:01:32.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAZ6QQlnU9pTycw+bF0IubICcwYRWP5X4Pf/R6pbR8DO2yMjc6yq4J10mtuiHG7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

On Tue, Oct 22, 2024 at 02:00:34PM -0700, Steve Sistare wrote:
> Add subroutines for copying folios to a batch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/pages.c | 79 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 0cf5b65..635b1fe 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -346,27 +346,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
>  		kfree(batch->pfns);
>  }
>  
> -/* true if the pfn was added, false otherwise */
> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> +static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
> +			      unsigned long nr)

nr should be a u32 because that is iwhat npfns is

>  {
> -	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
> +	const unsigned long MAX_NPFNS = type_max(typeof(*batch->npfns));
> +	int i = batch->end;

unsigned int end = batch->end;

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
