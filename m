Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2E1C7B68
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642041; cv=fail; b=DkLlMirIYQvTXAbyF8+u1xh2KRY6+yyYm+NdzR3ED+Hfkwivwq19IQexFXvEXP8PQ1f2TKnZ8ljAzF1O8ig5TKIVSG6SZItjc4vc+5xZBA8kCN4+0dd84OCBoaL4b33HoWAdt3EQeRd010XL4CJ3qMqt9cvo03Bdb/gBfZyqKXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642041; c=relaxed/simple;
	bh=YS7wWyAjRnOFOxSYa0voTYYz8B9JVagtmsnIAYHLQ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owEFl5V0XDOejPuJX/Zz1J949p7FBAe9CsB2w2u3wh6P0T8xHfDJpsvV1AR8Za40ND3OgdTvhv6+iv/HFJe2wKbAY27KDshVcH2nWsDJCt+kqXH/IMtWth0JveGrUfJQLYqsObij9SPPh/9aEcO9CVfBJeFqH7sH9HcK3JgG8dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pD4GJi65; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pD4GJi65"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj0GU2cUeAxBJx+74UoKRHe4RZYaACbuajRZT0RT1P2l0bYbKMd931KURN4Rlsxo3u9ZiOB8HZ+O899WbkiCmFf68kGGVsgnxAQHhcIRUT0sWfSiOwlEcAYkWwYlWlPFeGZ02UEPCPYRAkQBt3H3mmDRmmudESiuC5/E6AWZi2uSw8mFVfeNGrw762JuwnS2Xk+unGGMUB0cGh/SxyiN7I/b6bQO/+GX6pNK+9YKfm995KfVUQxd6ca9ZpASuThHNUrZpQ/w111k8mkOmBG82Wnm/eIl4Vta9xz0EPWoDlL20JpoZ380CJEmZpigB/9t3hwYSPnznyaQlBqnwvY+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgpYRRimDKV14/uhC01vVslLXU8LvTSkotOm9aQHt/o=;
 b=tYGAwnWh3xj/fILI1lwiphbu+CknD7fQ8PvzQ9HPsauvQXvRwZqJdBoq6Jpa5uj8Ly3/rjbcpduxSwvix7sHvwPPvC3CSzYK8qBhwQ39t9E3T+uZkQuUhB/Yf7W8kzEQhbfadEjaGlmike6fFRZ/8DamQPHTg/o9lEZFdie1pHcPxk5g/cEU2uvshR3ohA1kQYxFGt+5nFrtGNxGRN7mt15b0j+nZ/Zd5LbECj0V0Luk2G+9olYC4Kk0uP5UUEfJLg7VUOdzOF9HZHZiET+6KurKFpGA0+uR6n7T7w4C6xM21XM40DEHJqY3ovIrTOOu8E6gsSL1DDRdYzG/GmHtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgpYRRimDKV14/uhC01vVslLXU8LvTSkotOm9aQHt/o=;
 b=pD4GJi65qB2nLaqMgmkoEP+xJKtJnWV7iVBRZQ0Ty2jHSrF4tDdqGPKaqc6M2wpcHMPcB96p6YkJuVXvYUcPpa9pEjNdFFe9FmZYLZgomlrJpRUboKZEqGPU71graAd3wC+fZBXoVXL4j3DZkYHLXDxEWdHwU+X2n3aRo1Ni8gZSpNREaRgCrRFmgArfVLKhBe5SoidjO9SZ8TlWBfWD1fE4+6380YdM2R8NMMIVaUSb/Unt77mXbaq0S+2NilTl8pLATkMfF18wdeRDBhywpJI/5rIaseA+3srsGs6quw7IxxpFdETzohNV+DPx/jy52G95D2lgu1LFF0U8qqI0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 17:00:35 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 17:00:35 +0000
Date: Fri, 6 Sep 2024 14:00:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Message-ID: <20240906170034.GL1358970@nvidia.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906121308.5013-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:91::19) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ca6c71-8f83-4f3f-b752-08dcce956cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZpywsLEQslDIqlFaKAjBe+g+AfKxtaV47rB3DHFPKTk8Z3PdOzQ43lrJBjG?=
 =?us-ascii?Q?507+kYfeMef9C6u6/qIjxlYqghRX4+MalGdOYQ0wLptFVS1drLpHkfgZ9gke?=
 =?us-ascii?Q?H0lbMOL7V9XaO9maETiE/1bI7JQi4kUjRWgnZGBGcihsy9ku3axbvHqsaQbP?=
 =?us-ascii?Q?tkLGlI08iReKAPIvL26FhMSQ7Q3i7aRwTrQu/w2zUCn18jvhhhE/NCyLS29p?=
 =?us-ascii?Q?qf5xocrg7CzaZsddw3p1u5jOLQkrdl3TQIx2vP6XDS6fbmsZ+Zc0ojcAtdfl?=
 =?us-ascii?Q?zzmF78vR71kzGnItmBNOQ7GUzKL1fTDASYqANlzAq0+ZKqSnrCJug0Hf5GDN?=
 =?us-ascii?Q?ITtkPXQCj0lYqXPR98m8b1iGFNJoWw5o+NrcrisN/v+hM/bHm3nwwHGMSDR2?=
 =?us-ascii?Q?yEYx2hVEXAo1m9BNJgOfL1xGwWBp5xsJJdeqBeE4UmHTIfpEP6vJNDCex0q0?=
 =?us-ascii?Q?BSToAFLfW9Z8Tkf+2RDnc6o+zgc8sc5vgJpaYMMnAzgL+7c12ibI9PnaYDoR?=
 =?us-ascii?Q?B9bR1L9IqFNAaTae/B5G4dBVnv2gcOiZMSk61zy/HaI51N+9CZSNPtyqL9jz?=
 =?us-ascii?Q?9q5bMpmnYj2Ri3gklg6XUFvd47cGNdMwyASVevd44D3nbxl89wepbwKpmiAG?=
 =?us-ascii?Q?JmnrP4cqRCKu/KjEi/qxCvHa2Sjo1HYolgs44gBGcuPlN44bE63Z9zr75qOy?=
 =?us-ascii?Q?8F4HG4OHd4OXdVVdpyQvQ9eQSzBaqTxOk/Am1vNNt3veMoK/E8zriH+mhONa?=
 =?us-ascii?Q?Z8EOuO3MvKapHT8nhVaoC988QfrtcYma1hXs9ySy8AsPNUlziCbA8IlxU2Xk?=
 =?us-ascii?Q?hn5nrAvz2ENuxv/rmmWCG4lnqlJyejWqD36nqIVK391r5/EHf5ldZjguE3cG?=
 =?us-ascii?Q?7CBeEhnRmBH4kM+zjPen/TJpU5JZwRx/ArYIT2TTYn70JOzMe1Kgm/VoDM0P?=
 =?us-ascii?Q?5op0GXvt82A3alhP4jmDnQc4/FsZNef8iDIYabWn+P7HR0/LA+H5g7Er7LJA?=
 =?us-ascii?Q?4rNdlmpjUpFUfsfFQvmf/GimFd5OIWg05d3xXRlZNy9FEIKKcCa6IoU8jdJp?=
 =?us-ascii?Q?FYL456X8fKnirM0ZGfL0qU8bi2ItrROQEsqKPne194nXlSsMr7CFJg7RAy3b?=
 =?us-ascii?Q?q3YjpTt5JZTxqmBeePtKxBuBeXPLrPvxkuNsJZbh3NgQpcFBZDW2oMx6i1ss?=
 =?us-ascii?Q?KM9ShoiXX38QUFtjnWq4wfeUeoA9cBlvQEEZvoIc9TuPodm7r6Gpcf1Uy7T3?=
 =?us-ascii?Q?vB98kUb+ByWqfO8plt1uzF/k3V8zsmGE8XO6Uc1XVtxSURj5EIejRHdRQXj5?=
 =?us-ascii?Q?rYtcZpOylkXYXYXLzZKSDPlyXv72EdYxSyQ9hvuAMuYJRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27CBl9sFZfHiYEiffUa+4zRt1OJnt5D4G/Bt90Hp7iV+S9gPbn31ad3R+463?=
 =?us-ascii?Q?WmhTGQiGomIyNoLZeyO18LmHCk/+/k8DqCFiUAtz0zW6FJMVmXHWe2S7YQzk?=
 =?us-ascii?Q?QD/7MQaIDIkuyTIRiUeR23KTk141DkHsV7JES2fl+I8OuUYPICShCYJ7pAHC?=
 =?us-ascii?Q?p25AxB7XqRroMqlUdiu9emKf9214JBvfGg0Q0oYeSutvJ/6Q+xm/7Q4BI21J?=
 =?us-ascii?Q?uC/EpiJsbSruAmQ6vKnKsQDdeNJY42/qb4FUqazhofNnTmQOhoOkfhBYNSO3?=
 =?us-ascii?Q?IZIk6O+w5w1Uvm31L4JVcWUdFTZyjzowy9+kYxk7Nfhq5I+3YtQTmCUli0SE?=
 =?us-ascii?Q?9n+LLwEWwW7ZdJJrjdz/O/lgOmsYSyS2Vqb9p8A5r6Vs+nTSt/1GW90cexcQ?=
 =?us-ascii?Q?bUURLemRowZyFpsOQTuN0B0sVXtHsWTOcbg6cAK1dcDIK+xZ9djbxqKe09Da?=
 =?us-ascii?Q?RwDOaZVUMLokOeRJG9hGv+gxKAFLS0ZxGiPxRTNWUMSqWetE7rePt9Igo/P8?=
 =?us-ascii?Q?1QoEB8cioSJmJ/Nv4f9JC0jhSx4FaAzZz/VXw4gTxF+1w0MkNDPjFgnslUH/?=
 =?us-ascii?Q?5WeNXWLiojcUbke77LSdNPF6CYefZhRtYu6ztOXE1sdvREsrTf+pPMbb7oVE?=
 =?us-ascii?Q?+z12U/jec4XhxHRMm+1bOz/9gbmgfevwXbaBI8uVfQgm55kNhvHc8LwsanYT?=
 =?us-ascii?Q?Ar62lojYpG3F2utxh9+ExxS148qIxouo/lmdwgeZTke783uiXVOWfgg6toNF?=
 =?us-ascii?Q?JdmnKB84zfo9TmjqGEaSwiQkU78O1XuKUaivlHp/tgYhTNsfJTk9s+pHgnQT?=
 =?us-ascii?Q?gQHWkHxoYmXoDLfy1cTEdRsumAv4ssEZV2IAExyaQKk3mTvXhf4yhAUOHngk?=
 =?us-ascii?Q?1T2wZpPzCCZdJ/SddWd9UqtPHpKG3cti9YCkzDokUwh0nBYxURvzS3TRAD8X?=
 =?us-ascii?Q?g72eWmy5O9wfYPg9JCHAXUljWTMDsOVxvcGSWB/2ZGuHRIsGHhBT6Uo7zo+Z?=
 =?us-ascii?Q?E/Ixp7Gp2+S9sMQznLII5E6z1khzyNWRi0Wf+MAQUJP7+Jui+GLo4RX3sbHM?=
 =?us-ascii?Q?OZPnX0y1Y2/MnbzrQNEBtoKLsY4vtjdPZhFUgij27ZzR3tXu8E0hJQZ2YRrl?=
 =?us-ascii?Q?AFKmht7W34SDy6eitXKsI0N90KNlGTOSnM3vSHW3bUu/byXA3wk1usbd+dLH?=
 =?us-ascii?Q?GduffOgYJNMvNdYSsu4uGe9Ump4XKNO291zy3BKvq+wtnjdWJYsDg8ctoTAX?=
 =?us-ascii?Q?jx1EcpVUmwJmyt6tE8qVMjBQxK4koyEc12rtaGtqpUISPlGbqRA1Jh3WcnEL?=
 =?us-ascii?Q?CmKOMZV/i4Jf5Ae0Hw8jiRA4cpGpf2vyspbbvHfGrRnXmjjgiqXPjtXXbm3E?=
 =?us-ascii?Q?Xc7X1a+3sSPRR0wNZ1U/WY9WksmZnTVkcK1TU2Q4TM1sqW7Zcy8sqrpbA9II?=
 =?us-ascii?Q?Tz39xf3bHivOA0NAhmDrz2cghkHHFVDt14yCi5+ZatwgsCzSMzvkBoxojS4p?=
 =?us-ascii?Q?DPzK4UTj53gy5eAOlgVbplH4b7Wd0UEcLDlBHdaT3/R9SgO4+wGtQtvAx1Gu?=
 =?us-ascii?Q?gqxnkl4pz673aSHs2PX/CEOqqkPUJ8R1T/D6aYd6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ca6c71-8f83-4f3f-b752-08dcce956cf0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 17:00:35.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ltANL2AX/NXanxE5o95dMR7Ez03o4bJkSPeU5lAe1Eugs61vOOQ7phrflPaRKy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

On Fri, Sep 06, 2024 at 12:13:05PM +0000, Suravee Suthikulpanit wrote:

> +static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
> +			  struct dev_table_entry *new)
> +{
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
> +	struct dev_table_entry old;
> +	u128 tmp;
> +
> +	lockdep_assert_held(&dev_data->dte_lock);
> +
> +	old.data128[0] = ptr->data128[0];
> +	old.data128[1] = ptr->data128[1];
> +
> +	tmp = cmpxchg128(&ptr->data128[1], old.data128[1], new->data128[1]);
> +	if (tmp == old.data128[1]) {
> +		if (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0])) {
> +			/* Restore hi 128-bit */
> +			cmpxchg128(&ptr->data128[1], new->data128[1], tmp);

Like I said before, you can't fix this. Just go fowards. Keeping an
old DTE will UAF things, that is much worse than just forcing a new
DTE and loosing some interrupt settings.

> @@ -243,13 +285,28 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
>  	if (!iommu)
>  		return 0;
>  
> -	amd_iommu_set_rlookup_table(iommu, alias);
> -	dev_table = get_dev_table(iommu);
> -	memcpy(dev_table[alias].data,
> -	       dev_table[devid].data,
> -	       sizeof(dev_table[alias].data));
> +	/* Get DTE for pdev */
> +	dev_data = dev_iommu_priv_get(&pdev->dev);
> +	if (!dev_data)
> +		return -EINVAL;
>  
> -	return 0;
> +	spin_lock(&dev_data->dte_lock);
> +	get_dte256(iommu, dev_data, &dte);
> +	spin_unlock(&dev_data->dte_lock);

You can't unlock after reading the DTE and the relock it to program
it. The interrupt data can have changed while unlocked.

Put the lock inside update_dte256() and force the interrupt bits
under the lock.

Something like this is what I'm expecting:

static void write_upper(struct dev_table_entry *ptr, struct dev_table_entry *new)
{
	struct dev_table_entry old;

	lockdep_assert_held(&dev_data->dte_lock);

	do {
		old->data128[1] = ptr->data128[1];
		new->data64[2] &= ~INTR_MASK;
		new->data64[2] |= old->data64[2] & INTR_MASK;
	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1],
				 new->data128[1]));
}

static void write_lower(struct dev_table_entry *ptr, struct dev_table_entry *new)
{
	struct dev_table_entry old;

	do {
		old->data128[0] = ptr->data128[0];
	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0],
				 new->data128[0]));
}

static void update_dte256(struct amd_iommu *iommu,
			  struct iommu_dev_data *dev_data,
			  struct dev_table_entry *new)
{

	spin_lock(&dev_data->dte_lock);
	if (!(ptr->data64[0] & V)) {
		write_upper(ptr, new);
		/* NO FLUSH assume V=0 never cached */
		write_lower(ptr, new);
		/* FLUSH */
	} else if (!(new->data64[0] & V) {
		write_lower(ptr, new);
		/* FLUSH */
		write_upper(ptr, new);
		/* NO FLUSH assume V=0 never cached */
	} else {
		/* both are valid */
		if (FIELD_GET(ptr->data[2], GUEST_PAGING_MODE) ==
		    FIELD_GET(new->data[2], GUEST_PAGING_MODE)) {
			/* Upper doesn't change */
			write_upper(ptr, new);
			write_lower(ptr, new);
			/* FLUSH */
		else if (old has no guest page table) {
			write_upper(ptr, new);
			/* FLUSH */
			write_lower(ptr, new);
			/* FLUSH */
		else if (new has no guest page table) {
			write_lower(ptr, new);
			/* FLUSH */
			write_upper(ptr, new);
			/* FLUSH */
		} else {
			struct dev_table_entry clear = {};

			write_lower(ptr, &clear);
			/* FLUSH to set V=0 */
			write_upper(ptr, new);
			/* NO FLUSH assume V=0 never cached */
			write_lower(ptr, new);
			/* FLUSH */
		}
	}

	spin_unlock(&dev_data->dte_lock);
}

And it probably needs more logic to accomodate the VIOMMU valid bits
in the 2nd 128.

Jason
