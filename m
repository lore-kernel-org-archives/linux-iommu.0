Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31D1A08A0
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689381; cv=fail; b=m2AIriuQXWh9AQzb5F51gzEK07Vjq6ceNvlRyDwlQshJUqE3sEHya1dN20FIovl+r/qZj06XQnNMwf271zxhdSVwPD6TUr5d1nkNZXyUI5uXdb3n0192nrlI7uqRk4DrgIslOmJNIavgAao77WShhFkDN+AudwZOhRIOmEJOg2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689381; c=relaxed/simple;
	bh=ajmXi5JLeiHchCzdjrPdf2Idy1tC9aplgAGY8xYGP1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cufClvTSVT9eJOOvEul2VWCDe9kDhSvSh6v8OaWiMGnyjVYiGntfmMScxZOQnq5GcnjNsEz95jVYTjdsoa9vKwetJYliPckzFOFVSKPuumv8ZGkWc0sTu0V25VEQs0skD2pSZB29dAcE2mFZQDYlvbtYjZhVqyapG7HWzlnD/6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IwStRrIT; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IwStRrIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU9OQI65anQ2t1MU2rsqum18PXdMPmx4eUDVmlrdXFyOutqUlGdZaBfwlRcCbrluMR9TBbBrpgOK4hdCnulsafM8/n43y5cfTJWe6xaqPfLbj39yfPCfQ3LevydJ9lzfkgV9GCgqZG5CW4ARczuE0vT9xQZ38pirheeIwy7Ly03ciRz60BIurwL95S/nV46YB5S/PNgR/2XnYDN5V0aDMIv6H+3btmKvM27czNgBsh8goCYvihB0Gg6qXAnFywBVCm+usF4co+BQaUjlU2UiS0F8eKncGBtxf6J24P3/gSpodBBCjRA5qBEcZPLD8hXMd8zJ8GaJOxLWwCMQ6oixJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr8wI3lhLVXAa2ZRR3eUUanD2Roh8R1Vp+F8WHyv4jk=;
 b=Z4yJpizOdOcON1TJRe7H93yQY32qPsj0H++zmHiEhVi7Bihr3UvosflVTD/jPaB+Pua2xPzDdtn3Yseg4FvKxOCTLXlCvo7BCYDCR/M0AbeOZEvVtxqfuKqsn4zhCuU1QrUA2QT4fEqg7eFo2WNDIyhk0rWMKbrVTLtgc45sS8sR4FmCZelMnC6RxAri3LrNhnqO4PwkCYIiixas7t1Sk493d9kDH8Xcda52XbPkNZ50GBHI8mwX/kqNhS/CVsvjdNiD6rfTkJw1l5paiL8kskONEPynMjNeZUkKVIuyhk7icek/jlZwixEdfHaNgEnR6KK6kpNvgRyTKmfgdWN2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr8wI3lhLVXAa2ZRR3eUUanD2Roh8R1Vp+F8WHyv4jk=;
 b=IwStRrITpPGXII5yQajYsNz6mb2t0iINSrsYDgSrvL/X8aOa6+C2a45bXnTCBkXP23/FZ1wZwq7RtT/V/oPexr/7nus7fZgfCcaAYwaa+Rvl2VBjkez4nidNXsNczVCq1vQCNc2PP9SxPXmvdZwT11vYtzwC0SXdOId06Ls4cIRFA3nrnZrjQZulUx3doD73EJYq28VW/glo+OcgeiRIyjAeTvbca5ZaAbfdZLbnsbPLMNQo0bJQ2JiuiICa8a1qCi6mZIqKXNGfA9zg3V1vpiitz9RLEJeZdiJNr401q51QiZF4cPU3gJ7iRA/+tMfkX0wgcxDkgq5sAv9yTHhlyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:16:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:16:11 +0000
Date: Wed, 23 Oct 2024 10:16:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V5 8/9] iommufd: file mappings for mdev
Message-ID: <20241023131610.GF864191@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-9-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB5276E04633A8E0A3F877FFAB8C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E04633A8E0A3F877FFAB8C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0058.namprd20.prod.outlook.com
 (2603:10b6:208:235::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d42eae2-3cc3-406e-e68b-08dcf364dcfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddeDwSerUwudSYGmTAcoHFBp7YK9SQJ+Sre5YMV840aYC62vUbIKV8f/NhTN?=
 =?us-ascii?Q?8AqSs0hdMnfVUvUzyatsmNrUeAtJ/HYvVV5IW1Rfj7O6JTMh2h/gzFi8OQbY?=
 =?us-ascii?Q?2BatzeKH0v3QU0cJWjT+ajQGw3KkVoNJ+OuUC7fnxJjelgCPcK8xlERtTCaM?=
 =?us-ascii?Q?W7Cdz/LyqVuxOfji4FDx8L6Yh1LrDWD8iXV688yYU6CbJ8CTCmko+/+3wqUc?=
 =?us-ascii?Q?vqn/W7UPhWCdIhWLmytc1cND2e+zx3v7rWDEMCQScjF7OXDnabku/ycoPQWs?=
 =?us-ascii?Q?6k+K6xR4f94IsBnX/TGSqOZ0xXSd/4HGmANbKBgtGk26ULRdaDp7cLdwgNtJ?=
 =?us-ascii?Q?xbzQ0TIFWxcv+8rgBIbxlkknZZj2/jlvSPquBudHlzejFdmxbcbtjCuKIrJr?=
 =?us-ascii?Q?izBtXEg97T5FWkCqWqboWisHZiPvboX5gzmBCHIOhomYRX95RjRmjtsSIAtY?=
 =?us-ascii?Q?UHgEk2FwBhHlgiKcF7RCXe4SjlA4UcbcTqXV/P0AM77LSQcHFEH5GVSCeQwB?=
 =?us-ascii?Q?4fVnpQOJ9Xb3mFWsNJM4xbDDU0Bcq7bvghNaer3AiUxMcG7bMQPfOTPXra4U?=
 =?us-ascii?Q?QJcDyv7ldzycxs53V4DPbMij3pu0QoZKFuhA0mMLVzRfuByoqhdJNPOiF4MW?=
 =?us-ascii?Q?JvBUAhhz4RAeJrcBFwuiRHEqPDYuSq1Y2b+BWYKP7nh/Y+iO/xy5THwJJfHJ?=
 =?us-ascii?Q?sVUfF+kamd27vLXMkz0Ob+bhr/eRdArenQS8Iuf9vzsduSJ8VBY+YPndDe1W?=
 =?us-ascii?Q?ehxn/fJhGoylKJkAfo8UfqQvtYTZkSvFC8xXH4xl5CRuru8wZzMTOGsn934e?=
 =?us-ascii?Q?GZCOmSNBcpgUgJ7EL04DKTgzfTxmGG7GvArod5cEt2ji1bwr1V5M1mDYcaCD?=
 =?us-ascii?Q?bUPDKPBX2i+0lVSAza4cGCCWMrb1pcg+KnqTNrYENH/uYssRfogS3JWb00K9?=
 =?us-ascii?Q?Pw5ud7uWkKASpIeCGwHj80lna8Pmn9J4vpr1vyTSskMAsWq7JbemmFoY5P2c?=
 =?us-ascii?Q?6nQMdU+WRAQcfsmex18gmFGaFqQhQ+rOaURu414V+bTAlbOPnis1BEtDBmsZ?=
 =?us-ascii?Q?1ThMFWGlcDd+bvCNvDmGNjKZEQNOlcEojQG1xlE+4Rfqf7ZsAeiYQCkEk4Hv?=
 =?us-ascii?Q?n9bGbMaoBIEG7VH6VHVwGi3Fzd0tZWze7lq7oxNqOMchpBzYistzbwS1NM0u?=
 =?us-ascii?Q?7pFhe332/rcvA9XZc3z5aqF1KzZVoIRaQsy2LH8xOfOUmhX0mL0+FaA8IMhu?=
 =?us-ascii?Q?+h8q2mPOmfO1AnGk/UqBAgN/1uhTbuUdKf57aupV0aIdcZx2w8TrlgXgKC5k?=
 =?us-ascii?Q?/r8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FeDoajqi1Mgp4y7dzoe9no1dmWAt1fxXKzSEW6I9FTMSL2+iMrxL8QD0Pizu?=
 =?us-ascii?Q?BXeiTXo6gOXvhKgZpQ/hiEmLaCvDSDfHHxaeDq6RsaNp10OKA7nbLeQilu0J?=
 =?us-ascii?Q?2WWe4yCaPXYXjo2N9tMOdq7PXpzov9I+7RDXLAvFuMs8QqfsJIQMSmLAYdNk?=
 =?us-ascii?Q?YRQyz1pd7Uu6s2iYzjBWYPANbyhURZ9EqfyUR6jZ/6zcFiAH3lZqjI0nzXwM?=
 =?us-ascii?Q?TZUkVudmqdPD4nWmiy2Zejx5+9VW/Wzz2SXgEEUiwT0doK3/beQOo3mpOFEq?=
 =?us-ascii?Q?oQNzBoJEfpVLamPyYZyAiTn692hYXgcSzhXQGe/XgmZ0vUm6Uzk5R/8DRwSh?=
 =?us-ascii?Q?6lLWwEwydi6lrent5DJulavU7YelQkPKCzGTYAgViyA7E6WEgJLmvGWjdbx1?=
 =?us-ascii?Q?sF2sSyBz9UiEM/qtf0hFL7+gkYDpYZHrKAYW8yV5evosCX1cYsvdkWWku3lU?=
 =?us-ascii?Q?3MS6djXgv8YQn95QayS70wqycDIbbdhWVK3VxuIImLbdL+TV6ojHkXA753e5?=
 =?us-ascii?Q?Icjslnn4IDTEdAVOB/yLLEmrxhYqVGpx8UXcW+4sZtfZZ8MET4+aCrAUTrnk?=
 =?us-ascii?Q?VmgJY4QYGBKu78RnaaIX/pUZtQglSYQE/qaaSE4u/FPGteIGOTuwjsTLER2r?=
 =?us-ascii?Q?U5mDwxYpPQ/i0thT3pyKGgnML061czbIs3pxP/Id+HZiXF8BRGCBPpZ3jnyu?=
 =?us-ascii?Q?2nQYrNnXYrxh+whwa/qxTfcVJowsEayoLOviBi9YDk1m9Giwsz8ObJx1k8+t?=
 =?us-ascii?Q?Gd9X3iQ0UNpocqEYAeuoxquudu0p9keUhUqmqzh7IJWwK6C7TMz6GPfdqiKM?=
 =?us-ascii?Q?6pMUkNDgE9/f245VBXQSxR6e6/KrZYLFiZbuogWh8fW8pWwDqgGRMhSZbU0y?=
 =?us-ascii?Q?CzlHcdx+c8IoN1q+5vGc+PKuwHhR4mYeT9/olBHh4xehZoO1zYUBVFNa8HO/?=
 =?us-ascii?Q?ujto9NnwP+0o1cz6mb8W3S0y/fFoCdxcRqT6M3suhkud8HNsAKInaKHHc3oi?=
 =?us-ascii?Q?UJhAVIW+NaFxjjM6vkujCrToAIIWPArBCTRaKREDe3R0xtfUhLSVpLyuGIUZ?=
 =?us-ascii?Q?rHqrBUFFkT+O1KQEdNGX6wmt9rXBs4HxWKo3/qbXhydH4wbGjIURKxk8f89P?=
 =?us-ascii?Q?ScVqEGitwuXdLlbwlm45QxyM8GCvqmosw7rAl8PWjaVfrMQaYMrxx8XO0RUq?=
 =?us-ascii?Q?/WlLu33iSZvIc9lhcuvEwbrKrKaFvHdZ4UPHp3ACVPUO6mDYpF5y3OA46bhQ?=
 =?us-ascii?Q?7t21mQw+VBd7oUoKwM28Ng2j7cWmJJccsFzwiUzAkBe2G7aq7b/64EaML1Vx?=
 =?us-ascii?Q?2uVyIU04rLnbnkNtLaRhRzwWTMGsonjQZvrE8yA9EE26UP9lmA9JbMIE0Q3J?=
 =?us-ascii?Q?/JfUXo3Z26mS8DpXyySTLC9rqbTzL92vKMkTR2YLnLT+vxNVGPfGFJPEc0WI?=
 =?us-ascii?Q?0QagXS3tjiN0QG7a/x3aHzZMhqb2MXyo8aMhLk4PBN7kdIPC5giWrO+mbUoI?=
 =?us-ascii?Q?xOhLZwP48y/6QAt8YOYWQq83r6eigsJTszfJs3wWDWDpVZPP43xfSthZk7jH?=
 =?us-ascii?Q?kXzj8e79xQaglUnrnA1OSdee4v9dDdNLqbMXftVD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d42eae2-3cc3-406e-e68b-08dcf364dcfd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:16:11.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM6ER7f6uYeEtY8s8UAxZPk14BEqwqA9JtpoC45fo5kGx40gZd3MKDfigRD51Qx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

On Wed, Oct 23, 2024 at 08:01:56AM +0000, Tian, Kevin wrote:
> > From: Steve Sistare <steven.sistare@oracle.com>
> > Sent: Wednesday, October 23, 2024 5:01 AM
> > 
> > @@ -1973,6 +1973,10 @@ static int iopt_pages_rw_page(struct iopt_pages
> > *pages, unsigned long index,
> >  	struct page *page = NULL;
> >  	int rc;
> > 
> > +	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> > +	    WARN_ON(pages->type != IOPT_ADDRESS_USER))
> > +		return -EINVAL;
> > +
>
> is this check necessary? if yes why is it only enabled in test?

This is the pattern for correctness assertions on performance paths

Jason
