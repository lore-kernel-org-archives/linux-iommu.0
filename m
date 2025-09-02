Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92030EF62
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819546; cv=fail; b=lq7aXoshV1EccgFa1iVtOAhP7xKFi7PzUIiU9LjcfUL6w35TRM6nZRtpdj8tcQqpN7tfzbc3J23W50KEgNmTrgah1ZWS17XN6Ve+MhmasInqIsPov7Ohgj1zcr0nwDC6yUTB2e+jKYl6ALu+ZjZUzgmkwGlJtchcBeezmRgXv/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819546; c=relaxed/simple;
	bh=Iz3OCjcG3IDDxm9xqpQMtethG6afffZCIVqymgHVHn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HSjCneFZa/MDq4MCgsiudpL3YYinFHZDbXEOfAmj6NjWoGXnRxR6YfeZfANczkmYVCJqEaEHkVrEEXw9m2bc2wqgNwTybf3nnvbLaCPC+kSTLR/bJu4wNscWKUl06+fP00oJGoyyDEfKLMBWHDjs1C7FaNEkmyvlugiiJmZjf9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A29eqFoO; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A29eqFoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2tYQ7lUQRwRR7dAItNf6pOHMFS3Ch4lwT2aaWHH6yYf+S38Q9I4Wf3fizeRnVmKYk/UrkuO/bnAclGDJc2rfKilXNVL8tH5Ze760BhNyLOMBTT0lGkDZjuTJt2Ndap4yOQ41Z54doSRmyLku1FoHjzY7EPwRjJgF0BYro+p4IopoUbwNKqPuYt7OPQ97FwO6W01QPQAo6Yhe1F8brzHMGnpzGTzl5KP3weTixYvli5vxhDoYkLQa5UjAqs7tXj+OxSUA1m14G12mGY0E0t0+INvNOuL8usES8iuPF8scOR4MexCPJskGH3s+o3yqDhSuqv3V6TaAKYIOc1q6qc+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm9J2fpjyGrg228twKdlmIZvEZbV3o2e0NCGXhga6+c=;
 b=zJRtjRFFmKclUHwiU8LP27tQEGneZgrlt25YCxLApYIPa5wqiOJ1+JfZQ2GgsRV9CYZs/sKSsscmZfOIjg6Zm5JBYvLVEb9zsOrHKi9n/vsZRxumpfl7yR6k0T3E1RMMZAHyTVTX+jTYH0iOz8+q5f4Af/EdM0rBvfdlTKJ5mQN/MyEEX+KLZdUECfWuAWq/U7jdWJWEkqW/bNr67Tz/XeZ3/9UlB12SWzN6nNZtt1kOGsCLo5xqxFMF2FVh9c06vxVX4h15/hWKBBqZXtWsmVbVYgFCCJ/ZVVAaoXMXxdvKht8+V6Whr5t5fFhVLSigLuvKoD9EL/LeuunfqBYY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm9J2fpjyGrg228twKdlmIZvEZbV3o2e0NCGXhga6+c=;
 b=A29eqFoOEVH94Yy/I5IE7Un5R7tNaPSybFGvIMWS31vbdFrzRM4Tj0T/wiaKkTx/HgVHN7Cqlwo+ReMMb4lSXp30g9g3vGzwoUGW+s48pFKg3IE//9lF4NnQbdQ1jQDbyQOrmGHP+Mb7Lff1NdAL5QGHSeYrunn/lVDJjB0K/iZt3fmROB11s0cbEO9fA06WJHUBnSAZjBYRynmosTW7FWcqSUdoFldRf64h5YGNG9X3NmR7W1aVShe7JFsNHt6E0uuFrm4kiqiwHtEjrGNvcaIrNKu1Ge8Q+RmctQWmrkTLqpx0Lrjqe0tuuYnXgu+R0TOkKi+ke//fu3Xir84Msg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:25:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:25:41 +0000
Date: Tue, 2 Sep 2025 10:25:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 8/8] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20250902132539.GL186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 709be5a0-7543-43fa-65c0-08ddea24363d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RnC4BJx15jCgQ3b+kwa3Sb/cuiUUeZY8TUv/tK3uDxP0GKTZ8508mZiSF/9D?=
 =?us-ascii?Q?xwg8KVTf0983rG4/Tl1elROh9stB7n3zrnFNiAJvQ+wGTWR9/Ukim5IbhfrN?=
 =?us-ascii?Q?BIhsXSiuQDvK+KFWLrUc4Tx8SV3UE7FK3zHkbDRrQXxIhbhBbMqB/qTsREMM?=
 =?us-ascii?Q?vg/ItLr2XnI0VjmQyby1gCfIpUUQcxH5XwXY5RD12oAQceTVVBT1tXYGWuFp?=
 =?us-ascii?Q?GK8uTU0LFiYvXuH5YRr3eJ9gWCqDon9paLpJq3bkZDrgz4fCDzY/RKovbN8V?=
 =?us-ascii?Q?IAGBrcAuSrSTLb5NW/In9Q4kmd23NUfqFr2lUTGYv9ZPgQGKCGQmutGKToEO?=
 =?us-ascii?Q?UaUh6ZixNmUwsK8yc/Hr3yPrXUOBzesjJOoaVP+hS2Yjs+plRhgu4aMYhgTB?=
 =?us-ascii?Q?Z/oS+qIlIsTJRGoPjoU0wYN1IvKk95Rw/FeF+Et9FnuW/hRggJqXVhce3xdP?=
 =?us-ascii?Q?ms/Dt26Iu8L/WeMLMqeqhsC67AZAbIRLVdMUll352x0wVpvYKLCZOUrkgpt3?=
 =?us-ascii?Q?Pb95pvOtLj8yOynGLIWmpsD3wDWpbybTDjMVK1sMpHTGboE7Odtvc/QzTR2y?=
 =?us-ascii?Q?QlNP7dFLcKGUT1jL3nJRqHyOphl4DcfyAV9omqJGTCxbj3jxeHTar4UEY/Fa?=
 =?us-ascii?Q?2xOOE+nWYaIhZuoiaNRE+ms7VFTLqdS3rt2vACAPvYeR3W+c/OluxarLMo6m?=
 =?us-ascii?Q?7d8coX2IA6XI+WapIDZXrIaB4Fl3wMYi6HkQmNS+DT6LnfHdvo376MgX8uuP?=
 =?us-ascii?Q?ttab1OUwdfj1rm8brLoJyJM9BldyI+QuUqD6t/bizbV2GivXvJYKWx2SaVBD?=
 =?us-ascii?Q?z3pL28Lsd/Gdpewrxi8hF+i6Lx8blpl43xow7CrZH22wFIoTUXsZRK6UHjU5?=
 =?us-ascii?Q?7KBUxuSMlufnHE+b6hXsPxZqMny7ier+6HOVLnIYRjvH+BKgRiCsxc0SMBL7?=
 =?us-ascii?Q?qUt99T6T+DAjxSidq/Gl88zlZV37trpGpgJJAs7lF4VfnFUacqRYpdMv9Hfl?=
 =?us-ascii?Q?U9jHcGp8RL8VMeMsdJGgxzjTwEE2hc1eDGnNyf50sI0n4xP3l4uMfy3vwDsC?=
 =?us-ascii?Q?nUHYndpji4dbz8VV2i+tXsAae1O9AhoepIRRqoGLD/0Yn7Z304QPl58l1Utx?=
 =?us-ascii?Q?azZkqwGjEusNPCZNbU1Nuedlj7qeyhNJmGh6GZeIBA5LVUXJhVY4c4v3SxE7?=
 =?us-ascii?Q?7qsHOGP1hZNCCqDu9xoF/Mn5M37hKtB4Imv5tObLOp24J2z02nufHtNCmh4H?=
 =?us-ascii?Q?Ns3L1ijTTrudsfmfNni+2wEj1XkQHJbXDwZRPH/mn9PkZOUYtnHdcfIVEKMX?=
 =?us-ascii?Q?e4hLlgspVHY7e8J9idLry3DhP4OpDStTwGRFB2xmnTWDd+dYzqGPQHCMP8Ho?=
 =?us-ascii?Q?VU/jsdGwzhdpkcybpPgKXjIn0ZW9liUjHerPRY5iT6ji2N9vjmNT7z105rpS?=
 =?us-ascii?Q?sxqNmLp2cH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfcwosYVXunDA9s4vbyTC7VKloR0jCIhqikKN6JPXOMeUO60qV7Bxvtun2+1?=
 =?us-ascii?Q?+69R+oSAGh1VNVMR6UNE3FHuXV8JJRdMIk+uizMhusNbkh4KRGuUAWFCDr7B?=
 =?us-ascii?Q?lbJk816vrk4wKh1LBTzuQzNqZIuYWRmABNMGRNv4gcmNYYuM8wzK4Otkr5NI?=
 =?us-ascii?Q?2sclTgGmUYQRgEbs4sZ0dFcYh6+9ciegh9ABVNGeCrhfJbrhoNFwVHww6QdP?=
 =?us-ascii?Q?BLuE6GoEqBkYZePvWC8nvaW4FfJW8uLJxBfliFsSfqKQatXdPV9M/PPcAjpy?=
 =?us-ascii?Q?a8qKy4QpYZup5tXjwNOm/5QIEUasHLqaD7F/75ziYlsAK/yOWJd9cCYL1tdo?=
 =?us-ascii?Q?j+VmPnlgYu2X+8W9dt7McvMoUtHf//cURVy2n/LN0o6USg5aDU7kf10HCHor?=
 =?us-ascii?Q?F17iE/ixA/Lt0tzX9rwfK7qMo0N4ihjU932bQT8pGjLCldyEObCfV4jJmekq?=
 =?us-ascii?Q?2EqB7blC1s/k+eu6CCpmWqQ9geHeKLlth969a/Y89Uk9IAoSfaxQpDJ72Gsb?=
 =?us-ascii?Q?MsAqr+kj/vtYqAkGetZSfuIHykOGbLPHpS1tKSfVU/WofvHjLdNb7ZycAp1Q?=
 =?us-ascii?Q?aN4lXTMN0g8SIdyodzyGaClxzaxZ12fkOKqxwe6Nc9f4TPUQLHmiTNUvVHWb?=
 =?us-ascii?Q?pS2K2I22q55dIgk5lzyqSG6iNjR3neXbq7k0wEe+eDy5JrFaXz81V9TS07V8?=
 =?us-ascii?Q?XHbDxv13HWH57KqoDnnBidIt+MHrfouUipBOpgesEExM2r0OF/Qw7xjg8+BZ?=
 =?us-ascii?Q?6EVTTIlEK4QMJ6HZbVmxT2CzNFHEfARvIwYzWJ3HsgLsk86pmmdRFB8/OZOR?=
 =?us-ascii?Q?PRdHjBlRjT6zhlxqy1N5YHJm+D2yLjipw5q2SE0LpBPD3AyWkgek5odHUerG?=
 =?us-ascii?Q?Coo5Y5DHmGn9GElc+cjWzazh4GLw7GItg84yRkqtTosxY+fxNHsgH4cZn+IJ?=
 =?us-ascii?Q?yaTIOiG7xAL6U7PVpr6mSdCXeBOHQ55JVvDxaw7I1Ls92EC5CQmkJDCgxiI+?=
 =?us-ascii?Q?BIrxDzFJWm12y7F1gvd1ZEpmOSN4f3XwOSbqehYJWSb3M2x8pVcjg9v4pqdR?=
 =?us-ascii?Q?w2Rkv6My6i7KwIwELJrzdaMpHHRcWys4KrMe19D4Qs/de+vrxBCdjr9cKML7?=
 =?us-ascii?Q?UU4VB1zb23f/726bjhFR6julSzhL3b3qTAVChudELCbY9X3KpoU/E9y7/8ES?=
 =?us-ascii?Q?rrPO84Aqn5QrFrQk+QcdM1ijTvaRs14oakUo27hxR5K/oVsu7kvukBVjKSxD?=
 =?us-ascii?Q?RfqGelIlFK7CcYIpRM+kG7Y4CD/wrqA1mgUg3UKwSouJ642nLCAncOm1kE4d?=
 =?us-ascii?Q?eu1G9yjlCpzk/PCp9WLUdSUDukAQ/V9LDu7MG4n9IhoqCpEBYbk+GQzgJue1?=
 =?us-ascii?Q?QqkdkIAurRdc7z9LrM/IkIWUejgjXFQjiUkexRoGcZycSw2BbZTzL2yoF9YL?=
 =?us-ascii?Q?31MeLUrAPEggSBHhfmEMhFzi/wWfuZmEwis/G9Tgo7zo/pho/bQY9AmoMQfb?=
 =?us-ascii?Q?Q7br7xazgRdH+Sd8wZM13z0Xd/wiOtrLmnChHgt/O73fGgcn9n0zat98uYwK?=
 =?us-ascii?Q?6D54oEBlvkOHEANqx0M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709be5a0-7543-43fa-65c0-08ddea24363d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:25:40.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raZukA/u2CO2iDWpGcAe2UqppRDQ2oMhz5Qx5EfVYwK+9zySG88HWR7VfBjh42R4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

On Wed, Aug 20, 2025 at 11:30:09AM +0000, Suravee Suthikulpanit wrote:
> @@ -2023,17 +2035,31 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
>  			       struct dev_table_entry *target)
>  {
>  	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	struct protection_domain *pdom = dev_data->domain;
>  	u64 gcr3;
>  
> -	if (!gcr3_info->gcr3_tbl)
> +	if (!has_gcr3_table(gcr3_info))
>  		return;
>  
> -	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
> +	/* We need to check host capability before setting the mode.  */
> +	if ((pdom->guest_paging_mode == PAGE_MODE_5_LEVEL) &&
> +	    (amd_iommu_gpt_level < PAGE_MODE_5_LEVEL)) {
> +		pr_err("Cannot support Guest paging mode=%#x (dom_id=%#x).\n",
> +		       pdom->guest_paging_mode, pdom->id);

Should be checked during allocation time

And again please don't mess up this function with nested DTEs.

The vDTE should be validated during creation or fail creation. I see
this is missing validation, every single bit in the vDTE needs to be
checked to be 0 or supported by the kernel.

The logic should simply take the vDTE and merge it with the host DTE
as a simple bitwise operation.

This is why I keep saying to fix the flow here so this can be written
properly, and don't mess with the gcr3_info.

> @@ -2293,7 +2326,8 @@ int __amd_iommu_attach_device(struct device *dev, struct protection_domain *doma
>  		goto out;
>  
>  	/* Setup GCR3 table */
> -	if (pdom_is_sva_capable(domain)) {
> +	if (!amd_iommu_domain_is_nested(domain) && pdom_is_sva_capable(domain)) {
> +		pr_warn("%s: Allocating guest page table\n", __func__);

??

> -const struct iommu_domain_ops nested_domain_ops = {
> -	.free = amd_iommu_domain_free,
> -};
> +const struct iommu_domain_ops nested_domain_ops;

Put stuff where it belongs when first adding it..

> +static inline u64 hwpt_to_gcr3_trp(u64 *dte)
> +{
> +	u64 gcr3;
> +
> +	gcr3  = (FIELD_GET(DTE_GCR3_14_12, dte[0]) << 12);
> +	gcr3 |= (FIELD_GET(DTE_GCR3_30_15, dte[1]) << 15);
> +	gcr3 |= (FIELD_GET(DTE_GCR3_51_31, dte[1]) << 31);
> +	return gcr3;
> +}
> +
> +static int nested_gcr3_update(struct protection_domain *pdom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct iommu_hwpt_amd_v2 *hwpt = &pdom->guest_hwpt;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev || !hwpt)
> +		return -EINVAL;
> +
> +	/* Note: Currently only support GCR3TRPMode with nested translation */
> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> +		return -EOPNOTSUPP;
> +
> +	if (FIELD_GET(DTE_GPT_LEVEL_MASK, hwpt->dte[2]) == GUEST_PGTABLE_5_LEVEL)
> +		pdom->guest_paging_mode = PAGE_MODE_5_LEVEL;
> +	else
> +		pdom->guest_paging_mode = PAGE_MODE_4_LEVEL;
> +
> +	dev_data->ppr = FIELD_GET(DTE_FLAG_PPR, hwpt->dte[0]);
> +	dev_data->gcr3_info.glx = FIELD_GET(DTE_FLAG_GLX, hwpt->dte[0]);
> +	dev_data->gcr3_info.giov = FIELD_GET(DTE_FLAG_GIOV, hwpt->dte[0]);
> +	dev_data->gcr3_info.trp_gpa = hwpt_to_gcr3_trp(hwpt->dte);
> +	/* Due to possible aliasing issue use nested domain ID */
> +	dev_data->gcr3_info.domid = pdom->id;
> +	pr_debug("%s: devid=%#x, domid=%#x, trp_gpa=%#llx, glx=%#x\n", __func__,
> +		 pci_dev_id(pdev),
> +		 dev_data->gcr3_info.domid,
> +		 dev_data->gcr3_info.trp_gpa,
> +		 dev_data->gcr3_info.glx);
> +
> +	return 0;
> +}

None of this logic is needed if the vDTE is treated bitwise.

> +static int amd_iommu_nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct protection_domain *pdom = to_pdomain(dom);
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (dev_data->domain == pdom)
> +		return 0;
> +
> +	ret = nested_gcr3_update(pdom, dev);
> +	if (ret)
> +		return ret;
> +
> +	if (dev_data->domain)
> +		amd_iommu_detach_device(dev);

I'm strongly against not supporting hitless vDTE update - this is part
of the HW spec, the VMM should implement it, not create problematic
bugs to deal with down the road. Everytime we let the VMM deviate from
the HW spec in undiscoverable ways it causes problems :(

Meaning you can't call detach_device, you have to support hitless
update of the DTE between different attachment types. You already did
the hard work of making update_dte256(), but the surrounding flows
still need fixing.

Jason
