Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD5F1AE046
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960453; cv=fail; b=ki8hgvpPTMiLhuYiVp19Z3oNoLUjIO9KtdtE/yGjhctWqeFfl616BtaWSobXwHpbstVFE5MUugGZx2TvOpv0c4gxvTOmKA3O5wwZbIPUFpLB/ewIXl2UBj6E0OxD7uPvx5qZU+af5/Qo0Qmjr/FFhZlTjhb/myD9LtUutztoCOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960453; c=relaxed/simple;
	bh=AJXU+Ig0YerRVfezT9+DsNiTNjP8ReG4HMxe1cTXPJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FEAEygHSjHxOCSWPkr1Ad+2SARezru4KMq/uNTG3H/6y4dXpLEnyy7tRjWZIC1CsEAvT3cS+0pu6Gbx2+a7ePLcO2+Zx4eZHTZeJV2cqty0a5RAogbELy+kJqwvzq7pcL4G/3b8eWqcZkR4ZiAtmKKnMv1UFqfETkxK9mEwXnzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnAR5UoS; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnAR5UoS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3maw/CRC/VYq4T9opG+IHH5SwGaeBIqR1p28XFh8lO+a7BuEFH3tKKRkm1y0JvRjHFkaIZVRux/JABhjzJlktigvN+e5saCbytq7zS2y+G+dyn6OWWZUTzC17yjEShjuuCX1ST//WT8Bl9xVpnxU7TW1lMUh1Sziso7gjMpKuQBPxZgozGB6BcB1BeGmoznOUOLQ61AaVb+havXextC8OBk6wodYzLPXJs0OXCv7B9QpS9q97aBl3KBAYsBuGax0LiMtpJ9lkwC+ybTpwptYNY3lAIyFFisp58r1dAPrC5IfSfOvqvwDjbrqaYzTTKJXhlNlmk88gmJKWzwZtJO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKLzXqWrmfLHMaKphm0V6DjM5T52lLvJICly3gnmYz4=;
 b=alEBvbdlG67oyuTGaFKs7yznDma6YvohDvmFHhjlKTUB/QLM4uR2gMt80qMTrvdC8cyDXVni+bV6yRHsPoNtwmAo/YclgV+UY2K3Coktt/gUJMpf0bByku9hHLuEr+ZhJeD87rv3jXkoFN4PwsXUeKnjzdPruBdsrVyzTeC0zZie7MJ6MWQhxk13lywJQ8LirhhJf+nhYaB2enAE5q2D8wanFhWMHOVtymTSym/LYvGebkfVDwaWYcT0sSykKSvwdJ+skbd5CcvVodU49LX4B/rOby8rcs+ww9QCAqxHxr3QeK+krdkbMw+2iYKfER4HeW/J+V06DUl4JKQOMfLmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKLzXqWrmfLHMaKphm0V6DjM5T52lLvJICly3gnmYz4=;
 b=EnAR5UoSnCPxdCqeeAVeUzafijjl2XiPkKy9BF7PJqyC+8vXAr3jF1SAgbhcoL9Up7anTUyuywlw45GKzXuWDrCu1uk2kgNreKocLQmvZgH9K8tUMZQBF3v5L7zU2M9eexMFvbYTETRnpomqtBarU8u8mGYH0xNUyd6Ub3kvmjHSqawqt27jfw27eJLGMZq9F//KS1x/blwA3JDVpIyWys5k10g1yaWV8zhbqhIPcDhqdpLIY1joNYBRHoRgCm/QuvqPRNG4jfBfKLNMoHTvQ+MDxWEeNKw/Yv1avp+xujmBjv6fdtGGsedceXsPGkfVBAbRJkvPqzcqH+PcOrSaig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 19:40:48 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 19:40:48 +0000
Date: Thu, 29 Aug 2024 16:40:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v2 5/5] iommu/amd: Use 128-bit cmpxchg in
 set_dte_irq_entry()
Message-ID: <20240829194046.GL3773488@nvidia.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829180726.5022-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:408:fc::34) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: ab47b52b-0111-4ea5-1cb1-08dcc8627b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ltbxb0Aw6r8Enz5Aw1XdP9OZ4YLZSN6rnZEQNvYMxwxtYqXGPP2D75y+Sf9?=
 =?us-ascii?Q?ReO7TVf9IsaD0EZtcO5abYzVY+0U0AZm2uqB1nIS+lK6FCNl9NS3aZkXbl4m?=
 =?us-ascii?Q?E5BHoXhDtrL0c0xUoIewW8cOVamHgwVkP/yASwBtJjA0g09n0RB4X98mXIZk?=
 =?us-ascii?Q?ffKYcZcAT1aS1LeFtHvSe26z/lhb7ZhUMy1C4RAqH6HEwZQeVlAXrd0p0POW?=
 =?us-ascii?Q?4uJ5cdqAHF5GmumN6ly/0+PlhNnkGmdCEXTyKlJ4M6DHKfObCDZKlBLbH14d?=
 =?us-ascii?Q?HyJ8HFX2+C4/CjP6kYDfiS6wEBzfb8x2QgHdA9nME2i3LZCRyTDN6G29dCXB?=
 =?us-ascii?Q?5F/QcijhmqxdCmlLCeyzeuu4BI26YgHeFs9Tp9tg9XP88EAKV7dDdVnzzB6R?=
 =?us-ascii?Q?8cz1FlTIS/EMqJe5iyUzLrFjX5ELI4DbnKNGOFaRpTzjrSqe9COZk2eRsO0x?=
 =?us-ascii?Q?lGWQuvwiLjylRAsLyIUwuoPf7gMHoVZdaZn8oPqPmDgJxdoadxfsrm8VKAyU?=
 =?us-ascii?Q?gbRlcQWXJ0Wp++ar/wtsGRq0LDNK/dbPkCn7m/i8LtQoK/gxjd8SnbKQBTxk?=
 =?us-ascii?Q?IvBsSWPXgi59U1oF3bqqsrOHWVc4Ydofimq/AOotZ940VNS9y5hwDW2cpZC7?=
 =?us-ascii?Q?W0D6r37trvmVNt8bo3I4yiCmKKq/p5w5boTnO6mjlSwAun5kAvv+KjAgToAU?=
 =?us-ascii?Q?eNg/re/yxhBmm1KbBmI2hEvZ1JW73WsLfGpx7v9Jlp1It2ZJFNKqpZ1B7J7A?=
 =?us-ascii?Q?mvvFG45FXB6WZPXUql42TI78q5Z0/5znk8vDl0IFbnb+W1HHNKHkeH2dkeqz?=
 =?us-ascii?Q?4PlbHslLpGz6YoiDqkK6LyahJrdwFWwInTkDXNej8pW+Bwgu/f88iANMJInK?=
 =?us-ascii?Q?7FvWlHMLD0EmeNU/U9vtUU63jR64TVjnJueTmCqfczCu0yEyU71qa+00549W?=
 =?us-ascii?Q?yr8JUevLMzJgF7fEyWOB7WERJYiJMXyeOR18tKOkGlNbA2KnbjWmHf/0Dmfp?=
 =?us-ascii?Q?y5C4DBIh9+QShvWsALkSQoLGW/M6tT5fC1mvymdYnyNfKWgvbxMTQNCJrI+G?=
 =?us-ascii?Q?iiWSv2lPhkxkwh8XD5KywdvK06rzCqgtqVA1wj5FDyG7mrl96taSgBvICDFH?=
 =?us-ascii?Q?y5POBMEnGWtLYkyjNuzRao8xPWitlIpeEOq/g9gkIaXdAk7CFoEeXzNnVA6F?=
 =?us-ascii?Q?1ipPjRh4X9dE7HYYzfAIoJ8iduxTJa9dHDsxWGy3BXsiPro1AvWJCFXyjt1L?=
 =?us-ascii?Q?FTd2T0x049fkW4olf8XVivyhvYbaVU1DRI09ExQSPr+orPatLiMCJO0Eogu9?=
 =?us-ascii?Q?t2QQZWXXit5rdV8A6XbfJWJOuYbC/JynqHO7UxdmWN5NtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5TuAtD9gaxbMgZYptFg2jm96MG+a1ROrHbdENBoKtrIXpGI3JHhMHSwT8zb?=
 =?us-ascii?Q?UBBcWDLvTSpo3n7N9OlbOErhZLrV5YS+lh1shFhlq9/S18S8R1lUJ+ZLDsjE?=
 =?us-ascii?Q?XAyF80aMSGQAmaBi7SJZZwU/TPJXgUjAi8SggZvMi0abcCh7M9KPiFYZ9UG9?=
 =?us-ascii?Q?JKynI2kGPdwPNkkWXDVpkuiwRGMQeAwmd1HLeEUqkExS3nvheKemuJqa9koo?=
 =?us-ascii?Q?/a7YDWN1fQu7x9xBJ8QnlvccmYhm502rmXQi6LDV/04yb6M4+tEJKF88hEnP?=
 =?us-ascii?Q?r3wiqZ1Rq1OQ5+rL19gDLVlLBZOCAKz7iDA2Jn0auUWS05F6gCGJcI1cyLxE?=
 =?us-ascii?Q?hVDKdcP/ds0U0lMSOclOU3LaLM7hU5n1RqJSNkP/niz5jXpnxWkWpRE+aLqN?=
 =?us-ascii?Q?M7koCKTLQi56XUqOPR+BuxUw0oXAQ7z6zi8OjsKyjMClAvkDIHcaNWYtdM7B?=
 =?us-ascii?Q?32hfsHoPuOU5s0Vf3zMAs3U1uaoAc6PqeQoCYkEiRQv3ZfJsjBT3A5MPfFEs?=
 =?us-ascii?Q?52rFZTJyqLuhyDQeW7+S2YORHBz34lK8Ayp5Vqu3VyrsL5rh0LcmCArnIKFP?=
 =?us-ascii?Q?bt2EsosyqzbP3mHZfK2ZmDsv/puSSXKJ4G/bWZ6pqSEBy5KlAtBVFdeF2TP8?=
 =?us-ascii?Q?pWztBbj+BzXxTccZChhI8PvxAR9WQgdK/BiDpnAvoIHDFkb2Fo8H1Zmj6WwZ?=
 =?us-ascii?Q?7jK1Np6qU0B9/Oty7N7DMBIqnJphB7YwqNr0s/Zbopiucsyw1GeuNpLhXupO?=
 =?us-ascii?Q?7cLjDucGkz0C5vCSI3dGMrDvVGxCHI2bqV9iQTz0cWZqekoRJdxQrjv8Ww9y?=
 =?us-ascii?Q?+RSM4hWOnnfgLsvnklpdW7XM+A/j2n65FC2V+w4ftFg8KJxV1P+sA2TxWuCD?=
 =?us-ascii?Q?HTp+n51ndlHy/ljj7ijs0HVY0npYVzZSZYBuPFg92WUr+vydzLW8HpF+r286?=
 =?us-ascii?Q?qCs6ypIEdM7EnaiFqSEN0zVaQev89tx0u4upEyH632yWiBsfNesSBrRLPnEN?=
 =?us-ascii?Q?ANNFIR55IXAHriMwiuOsDMpTPEtXHoEQi83k/xLtodVhfRbdmeyT7KCRW2Uv?=
 =?us-ascii?Q?D2/yBJf5rA+oDmEfFK8ShjV51RYhqjNOdinVufvvV/c7dMksOd1gTBrNDoRd?=
 =?us-ascii?Q?I9eJ+IA+i/WfRFYhSFKefnUjT+02N/rUY8tiH86d40Gj1s8J+XaaFtBoWuWm?=
 =?us-ascii?Q?h45jHld2Bk8a4PsKpCvFrWNOG6mKYl9YejKTo0KjmtO4g99zu7K6p3xeGjWe?=
 =?us-ascii?Q?KPqThv0TONNdTnyxw/EdKUEDeW4Js8rxDPFlNzCTjdvh3djPBQrEEpQRxrhF?=
 =?us-ascii?Q?R8PPrYzqw89EryvJKjwe2gKl4xNtFT7AFElAtXTd46MXtMYGM8CkFQB5RLIN?=
 =?us-ascii?Q?6OQPRnF9mxEopZfPySbVWD8negLiUpctxQFKIebULBjla4p9BjVd9qLV7w8F?=
 =?us-ascii?Q?fPHD4uHZG+VuFQale9MC4gnH+dO+d6Tbbs7PmPtJDe+t/2/tBOF+vKYjeXtk?=
 =?us-ascii?Q?XuOkssNw05Nt5mDVKqOpksfcQ06apAxq15HlAx5hvSzRHWSofkc3w+T60Z/R?=
 =?us-ascii?Q?f7t4932LPTS8C9U7EUqdJ6IQoTK2QomljRqbmHIW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab47b52b-0111-4ea5-1cb1-08dcc8627b9c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 19:40:48.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iUz/BUf9WwY9t2685YvpPbG/emvZVIW0ah8r57lEtDAZRfEdNeHnYTTXIOWAWJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

On Thu, Aug 29, 2024 at 06:07:26PM +0000, Suravee Suthikulpanit wrote:
> Interrupt-remapping-related fields are in the top 128-bit of the Device
> Table Entry (DTE), which should be updated using 128-bit write based on the
> AMD I/O Virtualization Techonology (IOMMU) Specification.
> 
> Therefore, modify set_dte_irq_entry() to use 128-bit cmpxchg. Also, use
> struct dev_data->dte_sem to synchronize DTE access.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a24986c2478b..4eb53bd40487 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3020,17 +3020,24 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
>  			      struct irq_remap_table *table)
>  {
> -	u64 dte;
> -	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	u128 new, old;
> +	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
> +	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
> +
> +	if (dev_data)
> +		down_write(&dev_data->dte_sem);
> +
> +	old = new = dte->data128[1];
> +	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
> +	new |= iommu_virt_to_phys(table->table);
> +	new |= DTE_IRQ_REMAP_INTCTL;
> +	new |= DTE_INTTABLEN;
> +	new |= DTE_IRQ_REMAP_ENABLE;
>  
> -	dte	= dev_table[devid].data[2];
> -	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
> -	dte	|= iommu_virt_to_phys(table->table);
> -	dte	|= DTE_IRQ_REMAP_INTCTL;
> -	dte	|= DTE_INTTABLEN;
> -	dte	|= DTE_IRQ_REMAP_ENABLE;
> +	WARN_ON(!try_cmpxchg128(&dte->data128[1], &old, new));

This probably doesn't need cmpxchg because it is only touching 64 bit
quanta [2], just a lock is good enough and avoids the "what to do if
cmpxchg fails" question.

> -	dev_table[devid].data[2] = dte;

But this should be 

  WRITE_ONCE(dev_table[devid].data[2], dte);

Beaucse it is writing to memory read back by HW.

Required for all the DTE touches everywhere.

Jason
