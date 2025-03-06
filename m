Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C625A652
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288001; cv=fail; b=mLpHbdQHVn7cyDKOA1JhdED60JW5X3SGxEuw3QSuwSL5eyGe/Hs8Wpf4RY99hsh+CL49CRnbJjCJ7kG859Jh/ba7Vq/G8Go0cMPh4SZopq65CprRv333I4HMTwQXWI0WIUc133TrNPLEf2/CrAyk1o/ECTkJgqs+uzq+fBI59Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288001; c=relaxed/simple;
	bh=DJArr5X6V4Bkdj82lJ7V4KOAvieVdv1qJpnX8erAmmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpoVGH2nd9AFPjRbp4xK1q1LVsI+9ZNRvEXPtQNSEEWR7nj5BDkJcRkLtblZ7YAbWH/IILyu5kSmLjyhRxlqUDT8Y12HjrICzY5AkkIUaPMw5jC5Ry3SOULXHC7Zs1sSzh59VR3with9PQbYYQwxwU+Btc+3eUzem+RXdJvNhos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ONJW5sNS; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ONJW5sNS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZpc3kDgXNuqfX7eIDbiFVeKEf5QQSBuAuQB5D3TVbNtAOrI/h6rPk/ZzpzKSRtu/qz3em4YCM7DwlIvLHvRd4/9ZjNtgOkpHuD9q0qrrqNmScO2qydhScDX4Jm+GG4DNvRh5DzZainL218k3QTLzyWS/51979pEn/WaMCHwx8bp0iJUg3Nj5jlWJ+Lyj3GFvYQ/CDEEHJQYz7rvWATlV2lhjcRpr66d1DF7oUA3122QisNqfq65rex6bM1dF5cgZ1pPcnNQetmHyUFTyN30X2PEmJ5oM19QnyGZl9RQLtW99mG+/wAskLsqaOmNjuG5a/G7BrBVb2h8qzm0hJDOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw9ShfJv3K4wClp1mGS2kgsud4TkSq5q/fc0ZVzXeJQ=;
 b=ABYmMW5/jpn5nc0C6c0QpMNdZYi2gnvc/ZPW8yMDOHH40J8iHgHBZPin4trqNROnyy8+YWpxl2ZZT6iyLy5SexYpv4mk+zVIVpCh6p46+gPP7N33CfzfZ//NQJTLxD+eWqZnW+w5J8Z5WMLfqTv9gyUOFeD8zQOlvhYKTJkKjUUV67tJfHAcOmOpykFZFeh/HGtj4hPEBeVU0D05c8pTvQ3oeIhL4EwIMJfD5n94SLqKMBD7R9sFSoo+ZR87tdb73M2GkbAHmy2mlDRVKk3CcDpw4XLZoQ/nWxv03w6kppfkYW4S6S8V/4jPcoi4sOStaR1WbZQD080kBPbQzQixFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw9ShfJv3K4wClp1mGS2kgsud4TkSq5q/fc0ZVzXeJQ=;
 b=ONJW5sNSUHazU3WxnVO3WFbOgqHPpSIvuy0EWPbWiMqao1kdxph/NCevOeEhw2m1CteW1FWzj8o4DbrxWRwrChiLrLPu1zFM0W1oBzpJ9Oa3tOEM3KTc4NR/ydAjnLC+JkBKamQN+FWsn165PfuyDfxe7LXEFvXVMD1O7GcNSVXTerG86HwzQdfiBmzUVM3jBPyHVlzJgDOkPBMXWVYWWlLqI26oETdSbvVN7sFWnWyqKj3dl83RGZp5SmkkrS1iiHdGj7RYGtQvdpW2ACDSci0bn83+JSh8zH2Yuo5B2ciMKqVoHx7F269fsB7qCWS7ajFcpcWAOtmaHjOb7oAVxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 19:06:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.019; Thu, 6 Mar 2025
 19:06:36 +0000
Date: Thu, 6 Mar 2025 15:06:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Message-ID: <20250306190634.GH354511@nvidia.com>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
 <77fcb453-d88e-413e-8637-c61aa73be376@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fcb453-d88e-413e-8637-c61aa73be376@intel.com>
X-ClientProxiedBy: BL1P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 21802771-0d09-42f8-4213-08dd5ce20433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5ZiBAnXyB4zdAlL33XYmslDIFME1Bhx7ijV2JfRjdg4doN4P0FOkmWNyO8X?=
 =?us-ascii?Q?+sRW985NEeUny+gRDu50ZACXUkW0PbotepcyPF7S5kgzjizxpGZHPdrQJeLV?=
 =?us-ascii?Q?45Xlw13yw2Mu1SlFUoHxvzANtZsrHgtrxflSfqUweWh6qAAlXzzGjlGnY8TE?=
 =?us-ascii?Q?/JwpMBFtQj4ryofpJPjMv3jDJLlIFlj/SHEwuqGmE4X/rBmV+alEENxuiShH?=
 =?us-ascii?Q?RaY+MG5gRVzDle4o1DeD5Le0iN+blaghkHwLW6ZH9bY86OVSUSZ+P/sIaii7?=
 =?us-ascii?Q?6vvAuaEKWZwwAKb7KHGgYhajNAkVCZ1G1dKZBjcz7zmPOf8PP8iZbPJrwZRO?=
 =?us-ascii?Q?crfcDVYjlMq0hKUMAp3AtcsTHVFncEYQ6HS8N65qDioy9uwOpc44gILlDHJy?=
 =?us-ascii?Q?UntNyQWxxItbkaESiX+ndJTWpHh5PwXFXAor5bUsbwoZ5YoaQUuntOJy6dkx?=
 =?us-ascii?Q?nn41mvEbOLh4yt158UlpKEJEnRBYGpphv+3HJKk9AH9W3AVWqDmaCMNwM5BJ?=
 =?us-ascii?Q?juqWDOSoTqD6Z8q+rcxHMYyD4bDV83RJ4qOL/sHurI1NjLe3rzX33MbkuyHe?=
 =?us-ascii?Q?plakbiD4ZNQwSeNG6KxqMadWSyrjo+6CWjwstvl/gYYuupc8om6wfXY4HET5?=
 =?us-ascii?Q?q8BXQA+zEWxko+xzATRGSYqfZcnZBUExmY4bqEyNXQxZTVuMWX64RJLmSyda?=
 =?us-ascii?Q?G63afwzbrBQfrTe6Vs2aqKqpTwtrHDRQ5oXTZDjT38W4G78W4QrXkuyotUXs?=
 =?us-ascii?Q?Sh+4QjQDbbGzy9FJNAtnlqUnQi8CIFSJiLlRVZFVhWs0RO4PoV1tHmA3zPAg?=
 =?us-ascii?Q?euyhOztGOM4SoCG3K61bLHzk+Wyw6Y3/PPPG8ndhDj914Uxm7Kb4TZLrU1ax?=
 =?us-ascii?Q?sQZsu1cilFQ+uIuuj0NrgRuZ0RMBfp/0AUhlD3wiZSoxQYrQ1B+tGzlasfgF?=
 =?us-ascii?Q?yiYM0UQlJs4HAzRIWyecdX2x9rGA/PrSgbZkubqryvJUUP6M/uN3LRKVFyxz?=
 =?us-ascii?Q?PdYXBDXl+MwoUHyTsPPy70Tg/ulmCou4wDmSAqZSR+089N0Rh65FOfRfHA/4?=
 =?us-ascii?Q?1Y26bh5zhPBx5VCg3oVuCAC4SLdUaBaPDgTTaXimVLfhQ4LiKSxSlQvHs+XJ?=
 =?us-ascii?Q?CfC0d2OGHul75qV+B4A1zlEQCwtjruta7FOMthlKBlqox3tvtRV3xULe4qO6?=
 =?us-ascii?Q?ZR2qTp8vMeWfsuKnkNy5XDuqFbm0OSRcUAJoUpHe4aQyAe5WsIgMfCElCh17?=
 =?us-ascii?Q?qBRKoCklM9A7jQdz7MOqUj8Ku8F8Tl4hkuQQT+FxdLp5RPYFBt2BB2OMtRie?=
 =?us-ascii?Q?CuO1nHio5Szjztsfl1oFV0+o6QEMggY7UFgKfdteL5Dg8akaPCGBxDs+j5aG?=
 =?us-ascii?Q?rwERsPwKguUiGwc0L4EyHOZi5rhN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xL0SP5IuBwnB7yNiZaJglp2VQPoKHNvhD+L+W7WH/Sw4MUhD2ncNHPUFpHB?=
 =?us-ascii?Q?rL0gWo3qXq9uE0pvexMP/+LSrJRWE4LF9GOGDTeVSs480LkKbRa5S0A4occI?=
 =?us-ascii?Q?JIGvbQEIPF3WncQaQoA3eEei9f7UkELym9PkRyim0JZMFAkn+K2+PVS3lfgL?=
 =?us-ascii?Q?kKS1ebAZKrUzzFdfdh73lhQ3FepWYL+oGe282D+dzKz++HO1ebci0I6BazIW?=
 =?us-ascii?Q?QC4v5djxLQkUNXjz18rcbxxfcoFwV4s3FsEf4gX0bBSt0wcOAC+LgKr7wtMB?=
 =?us-ascii?Q?+b51+h/zpSY9iJlHiTdj9YXVC6eBBFN7ZXdVgKNYbyB1zJGZUlFxvBURN/XS?=
 =?us-ascii?Q?aKOC4CF6dgojFn5jIL6jnQIes2s6r29KLMNlGSWxHH1KzjE+aJIlEdeT+WgP?=
 =?us-ascii?Q?X5MIDBjdSdptQ7SQeMUwS839TCRlwqbjFfa7TQ1tETQujtYc/sZIhZNzBwWM?=
 =?us-ascii?Q?mTMiO2RxHhJEDfL2cGzaZ09JWoANuu5njxqJ8ia/QUhgrVxVkNa232uqivBI?=
 =?us-ascii?Q?fTj8nXusj7Z5o+yp4r7Xq43MR4yQCt/mZ7fMpUnoF2AskTY6J/CAKKQFv/lm?=
 =?us-ascii?Q?L0uqeZqhQR7hg0qFg/eBPNL9NCPOaq7lVaLQaZhmzBkGQQsql5cj6BsPeDeh?=
 =?us-ascii?Q?DrN/fwqpz8+TQuYuoG9FeTuzFrMLUVRqDCQpAMI7tfRKZW8Q56b2mQIw6HeN?=
 =?us-ascii?Q?JpA3BjEFUaR/meFN5wtqg6sTg7RHPN+fIsK045/pdMtZw1N0C2OL/6MQ8CVK?=
 =?us-ascii?Q?9gdGXkEbA43McciaXoOq+78MDEy0mv9U8aIQBrMG0gWTyOYFp3vkSoiOEX+Y?=
 =?us-ascii?Q?UKl1/1c0j9e4iHYYUqAw9w46anps7NlJfoTpzcqnvgFM2x6KV5EM1+atYwh9?=
 =?us-ascii?Q?5N2fGFm0hw2UfjY6DF3PwC/EfQzmCxIm4yyEfFJLY3zScYTqHCjdIAegvGpU?=
 =?us-ascii?Q?rb0dHM/zgpiQqmdDgdeH2rNNVn+Z7zkX0Eu/n68u572azrMPkeIM03LjSOsy?=
 =?us-ascii?Q?TgYp6U7EprNzDFcn5CVfmdstvJ8V6rKOXj7vlkQxMiCGcQi1sTdtCkaL8zjN?=
 =?us-ascii?Q?+YfhgfKYNOB5zOort11kODHQ4r3p0VEYu/Zewm9l/da5iymHVG1NhuTDJAU+?=
 =?us-ascii?Q?4X2OicLf8I9L32eQiVCERX/nqFsbhQfGmXoiLV0zl9QEvzyqdxpZf0dj6hev?=
 =?us-ascii?Q?dSO2jnmlsqJoVeApN+i3TVCG0aO38xhXVbK37TVey1ldyd009qxlUg02V+7T?=
 =?us-ascii?Q?dJR2uFT+1GZ+BUQ9ESXok4H05OvFbOqmSmPCaDz/7/94sYJE4U3amqYLomSl?=
 =?us-ascii?Q?DbkiaxZl0oXSyuik+Yf/kQjiPtNBCyW7wsJHscn80dBS2ZFmu5OQPcWg27HP?=
 =?us-ascii?Q?klykN9wvwmuCN5wAtjaYO7LLPvQ7VHidtFOxoq0/iZhqRWYQZ6S6IruU2y5r?=
 =?us-ascii?Q?Pe8nXe3qNMnN9a4JwK5cwEmKtlnwCL2IC3fzBx4+kTRVh3VKHzG/itlepf+W?=
 =?us-ascii?Q?sAy4q3NuFmJyn8N+RYhoLlnaaAsEMtxlZV6pez92sGImHvjg4n0cdZuqqVXU?=
 =?us-ascii?Q?ACVp54eh510UZwQOtXw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21802771-0d09-42f8-4213-08dd5ce20433
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:06:36.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey51Nayogj8dXo5+xfQMt5nxAAwZDhD1fnwMRb+gl/Vn62bThG6ZCP3JGC0iZGyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

On Thu, Mar 06, 2025 at 03:09:34PM +0800, Yi Liu wrote:
> +bool iommu_group_is_singular(struct iommu_group *group)
> +{
> +	bool res;
> +
> +	mutex_lock(&group->mutex);
> +	res = list_count_nodes(&group->devices) == 1;
> +	mutex_unlock(&group->mutex);
> +
> +	return res;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_group_is_singular, "IOMMUFD_INTERNAL");

I'm not so excited about something racy like this..

I still think this is a bit wrong, we only care about aliases, not
multi device groups.

Aliases are created here:

	if (pci_for_each_dma_alias(pdev, get_pci_alias_or_group, &data))
		return data.group;

And maybe in a few other places..

Can you tag the group that it has aliases in it directly during group
creation so there are no races?

I've long had a desire to more clearly separate the two cases of
groups:

 1) The HW cannot tell the different struct device sources on a per
    DMA basis
 2) There is a security intertwinement between the devices but they
    can all run separately in the IOMMU HW

Maybe it is not so hard?

Jason
