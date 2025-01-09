Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86A21764D
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436439; cv=fail; b=AwFhjZxxYBJfq3hFxOpMB2BsdYQI33sczkP3tATWfRR2KL7ErEDRqQcLmC1gox3e39LunNWOx43/obGiimXTSObPAReyC956vv67mICypAhArkPf2e5G+7mKJxjHjU3Y6vp8Ute5zbhaiayWBgZACGUZ4Q+PZLWggd8g59PiUeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436439; c=relaxed/simple;
	bh=JrZ0t7MUx0o0B21ThVaI6qMqXB+yRlUh/EwZOOwhoTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3RX0aMrSZ6dK466L1JqoTwPyZ/+8vKSAeRNN5HlnHStbaHKdmuMM4/jFQP1IVCeZaZ1MEsdgiHZvHKuXxbuqwXuS9WabFU/2SW1ZlEq9YtuXU4gobwtS+w5bY0CIk0O5icQwdN+IhERakbk4ZY25pamFuLzmVJgXeeOWfH9hFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+mljeZt; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+mljeZt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz/kIVS7exhF8YitHG5Dq6g74H3+/JjFXATSUlTTDZWiIfUz3Ik1y+0d59n4toI9kIj9g4iBX+RP8/cXtoQcBIBM6y1cOvNSn2Q3Kf3edsQkx5wSXPysr6Wipv3dQHFydsdX8goMq8ZtDLWqolGg8Mb4YHFH1B5m0MJKqiUIkgTaqFuSZEaq0egQ8zNXI5Kw21+79F2LUocgcMX5yMazaVYMNOuugAgqQ8Eh3cVgSU4o54Wxbb8tyoULmvOmTyl8LTEsjzvZ/PfMAPxw1JPJWuJAcSwZKw5B+iydWCJkG4dqjM4aFYjF81NCX2zEnmwHBQTnpOVLpJVhfIQ/+nqOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNILIJGKIfm7rdeBGe519qDITq4dt8Mw/7Zmqo/gb/k=;
 b=LfJ8D/K/ZkDBGrY0tQlzjoPNEEHjBI9mdJVYWhT/UlOsry6KRSNFbX3YJALqEiui5LWQKXig646afCpFXfmqzNbHRxM5djjkwqz8iTGkrgiHd07C8vtZBrtP7bSvBgjXJfcQch5XRdhY+Pd12gGpAPjOP4bwu60s3PsFQ1Mkk5qAOWO5PV74tk25y92QA9LC/lAkHvzcC8pm3EvyNrwMNnooIehqO4v/FcpAggfHiLhg8H6E/jvccfVQ1ZtfyQKNKaAuZy1/MfIIFxB2wPSB2AV/GS+2dCr5e0hpm8Dj7FM7x3jhO+FVOeSniSUyUbwTxC2m6DoJAdbRgF1V/mPa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNILIJGKIfm7rdeBGe519qDITq4dt8Mw/7Zmqo/gb/k=;
 b=a+mljeZt4jsqvdn2qMZ0793Ppiga0IHpqUzlo03lkFY1Y81yVQD6YiHhhRds8+azWxjLeX+DC2OaMUdUn4b5tAUJ7sBoNOJ5ro3ZnXw8ojJ2ALDxxxTh7iyMfuU8vUDVHFcQjKfCmgqXltplx9Z9BlnSt9q4NW8eJ4gnGF8UNEef4XKlJfMTz3kZU8Exqi6Iti90xPK6LvNL+lZiqPVOq/zlke4CXp8sN7cNP6WoGnX2iNUiLJHW4Wf0p0cCwJUNxXsqiFLP7sKeb9ZdtHUNY3+aiqJ2sP6MwqB1FZtkLpYeHDcBW18S9JEp36Dc0ywlq2kZCTGm4Rqb+B2nAc1hzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 15:27:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 15:27:14 +0000
Date: Thu, 9 Jan 2025 11:27:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Message-ID: <20250109152713.GB5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8c8a51-f7c1-4b8d-adca-08dd30c2182c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oyGYIe/atEbYVAlqlkdZuU8v6dSTddzAlcjKCiaWK3N6hkZKzKRwI6DLlYOI?=
 =?us-ascii?Q?jFW2J9CE7fIFgTByAK5Fg3Pr4nuj0Fzl7/IE/RT8HVCgcnU420tp14YyulZh?=
 =?us-ascii?Q?YR88IqhzgSMYx0YxoqE5OTsEVYDp33+iEIOhBzKLxPIN5pq2MVw2fyRyJd3x?=
 =?us-ascii?Q?Zcu0RJFLWG0CC8L4UIoP+lq88ruPwbqmi/dfi1sREtby15eS0nJz+BLN2gJo?=
 =?us-ascii?Q?iUyHGZ3EkF7drfE32by2MiH9LgpEOcS427elL4IKNvyxQHkQcbqwuoScugn6?=
 =?us-ascii?Q?vTSPh3OQd2tfWQFe7aYjSKMKrRkKcT0Qcge1n3tOXOHc3h0iGRn+pVzYNbVm?=
 =?us-ascii?Q?SFmsIn7LytpnqoT6x7huGk0W8KJfpLOFg4YGrU2Vd4nzBmmT5lH6stSfDUvN?=
 =?us-ascii?Q?gOK381yfUNpq5vHlfYDmMRUHQBgKggV/WtKSeviPwJML0mZwNlYFPh402swO?=
 =?us-ascii?Q?3SmN16xuSSn+4Czubs342O7BmwBH23CCnCWcyV/uSQYrsWIyiK2StUjEdwny?=
 =?us-ascii?Q?IOZUqSip/BzX5ziMXsSWrT6MwvXdsBdE8tSL5XfEjf6XV3NxiOSMkFH0vdaO?=
 =?us-ascii?Q?x0Y55BR+iN41UG/RxB4hbLNmHzDhJY565K/9VR13AzkLgwuim6r1AVfBvRem?=
 =?us-ascii?Q?ckllg4YRM/oTcDdjTcfCrhblbZyfnHIfiE41mIhzAUKNSgPEKr97zthCJ6vm?=
 =?us-ascii?Q?TSuFgXKZ/usU9mT7uhByHjufbnKHmsEIr/I5Y3zlOTuclV5CDJYFHpHADMvN?=
 =?us-ascii?Q?l8DpTYeF4CLkRLZYz0ayJVWRb/vORdvngjLnTiOAcyTYHVy2AEQQU9zyzNlV?=
 =?us-ascii?Q?ZvvVmSZD0JMd8ajjjnnVgr01EbB2aAOCbUZw2wR07YM3WKSQfRjd3X5ZRvld?=
 =?us-ascii?Q?R+sMpl39OHcyYv7/Lc9rbLvR4sXiB15CKckcT4EFvLfjYzexWnFyiXkKHTtU?=
 =?us-ascii?Q?EHTsU/+sW4jdh79gWpJvEKK+ITzmCl5NnHpCKGfFT+5Bb2L93J9mZfz5F+5o?=
 =?us-ascii?Q?hNWExqAocW0neVxcHWG2pixs2rlGPeUdKQfMRjpNbgxyhXna7jmhx8m+JL4K?=
 =?us-ascii?Q?1s7Lm1rvRR0Ziq258OfD1lwKILqJuZXz+VimQH9aoCq2G+PDeqTovt+fEbHx?=
 =?us-ascii?Q?eE0t3B7Vv57hPRMo+2xxOfUfdD3ZaDcaHBNgQ4sSkoyjmrFhVJYO9rw7/YrK?=
 =?us-ascii?Q?/kYnstGTMWXTSX2na7/eju0NgYjJrsgNzAJzlhiXtU6QqOfupXY+KFfdo31K?=
 =?us-ascii?Q?+QYz0k1zUdRaPDxqc1tkOxdR9MlwIgicXsx/bNoQ556KzDm0xkyj6pONon5P?=
 =?us-ascii?Q?h+i7jEQ5rZNGDhSClcUlalXealiXLQ7reidGFiL9+ZELZry9qVXIZeDCtqMp?=
 =?us-ascii?Q?Uk2c2HTF1koD4PBnrrkAN4zxlA7H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43S3GTR2DSBajLkloH12Mh/HZq84JxsAZhLNrG7tlxOVh2dd8I7SZOmeNhr3?=
 =?us-ascii?Q?XqU/sgTcjsro1/cK59hiXNUeQXN6GSVxCo/bFb5fl/0IgMLioBtcWvtdgtMR?=
 =?us-ascii?Q?BZNXoXDAvDI8GqybsRlKsDBD8ZblDYcXm2v6PT3Tch2uDzI/KgyYzWkZdUYr?=
 =?us-ascii?Q?co98z42EQ/+qoaLHOWgoDKi4O/i7KcGBFbYmRn/he+5AEywcItd9CMX4EhtB?=
 =?us-ascii?Q?odXLmJfsJyqXAnv847NQkn7qS3v13it/KXWGRtfj7LxuOTMSn5xalkwwp3L0?=
 =?us-ascii?Q?6lKkB4gvye9kIsPdCYM7px5Fzyq62IfSl7PSArDbU8Zia2dOyMUBFMPk3q5T?=
 =?us-ascii?Q?ZVceUlsx/FZMu7UBPAg5yDAyzAARUpdCD+cbWMfJn7/ZmUDQ7cwSkaEB81Lh?=
 =?us-ascii?Q?eqfsNn0wE9qcz9+MfKBumPK367kXeQv7kBec2xifTDmSY0dY3GqKpdHILHlg?=
 =?us-ascii?Q?4bPD0CX8FfwWgNrXZmX9HFhtXGu+cuy/H+dX3goq/OY5XpfZ+tSLOCTbdbsI?=
 =?us-ascii?Q?18MvOVmZ8cKSHruBo89rcvRrOLJApcOvA8n6GUX+uLYq4ObJPdO2CzChifQA?=
 =?us-ascii?Q?egfWDhlJ3CVD80sU4fCA/W3/R1eJdT8KhubB6Nvemac0+Q4xLRz6yupUlzYK?=
 =?us-ascii?Q?lm18goIuugsiQ0+dKlGdq9bjx8v+FQgAwERBtUVU4G4H6AwXMnz8pB80l6WR?=
 =?us-ascii?Q?LTV/AThoDd0RguaHCMQ4OzROCWmZL/+xyQlF8fnQpQRqg+v53+Tk2CxnFJOz?=
 =?us-ascii?Q?u7CyPxySXeowdRD3ZVvXENpdOwrSNMiXMfv2guG3Dyi9yAqQ1IZFj//GMuvd?=
 =?us-ascii?Q?nnc715T5kJJk372TkqBVkK9g8h+2hUwAvpkRQcEvPrnp7TXotPVYoZpQEAu0?=
 =?us-ascii?Q?q032Tsk8Yr1qzMBNxzfNiAWSJYLRsLnNXwkIRrceduKPOIhIccCUCwKfQCzB?=
 =?us-ascii?Q?JCXPBibr8mMlZmpyzZdoG8iq5295WGLlO4W1VlcJ/EIxdvGIh845YSiWtO5Z?=
 =?us-ascii?Q?oCLq8T76WhUIa3e4f7d91kwZI0bFKLa3w0rdldzl9Tmaf58nj1jOjYT+Y2hY?=
 =?us-ascii?Q?woa75CYhll1xDumZP1ysyXvvWza7mAXqSzxWPMQB6hyj2P1YtiY2C5JIXU09?=
 =?us-ascii?Q?O2hozZTPCg/HDNoN+h6Tz3oP5tCJBM44CmY5+fic/saXwCyq8MYgkGdfqLd2?=
 =?us-ascii?Q?Gd3wMFOD05PaREOVtXxlK8WY0URJGf16ZQ9U1nv/XpSlL7NWw7OnMs5jvKBu?=
 =?us-ascii?Q?ids0AE8eme0ez4ZTvX2ZtjPyxlHdoPAWEf+01z9nk/rIrTxMr1mKkVsMbbYL?=
 =?us-ascii?Q?sN4QnCSk00S76kpQjhHmVQqutdNU4A7yEZSLN41hc/AG9SEVrhzufbXqjpu4?=
 =?us-ascii?Q?+v7rDQqDYKbVnVGPZ8R6kN5qxvP66ECKzSojjqq5eDOFtMp/wScGanXgyHL6?=
 =?us-ascii?Q?WiwKIv8U/eSNjOuqklS8nprt8U4RudxWmWbA3E7w7Csw9VhiAKjhyQMLStSS?=
 =?us-ascii?Q?blx55VTsCknMQjYq4qdljkNh4wyzZy1t6YH/VYuRzueHJUX+2jrMQv63KUSv?=
 =?us-ascii?Q?MtEZyWiVGTVQGWaxYwnI9ZtOEKu8zFRfNk1bQX21?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c8a51-f7c1-4b8d-adca-08dd30c2182c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:27:14.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBD/ZOnyq2TR0U4DsaLgTSO1oyJc2+PsRQqhbXVbv82bCrAL4RSVDj1cGd94csL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074

On Mon, Dec 23, 2024 at 10:51:50AM +0800, Baolu Lu wrote:
> > @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
> >   	struct dmar_domain *domain;
> >   	int ret;
> > -	if (!nested_supported(iommu) || flags)
> > +	if (!nested_supported(iommu) || flags & ~IOMMU_HWPT_ALLOC_PASID)
> >   		return ERR_PTR(-EOPNOTSUPP);
> >   	/* Must be nested domain */
> 
> It's better to abort and fail a domain allocation when
> IOMMU_HWPT_ALLOC_PASID is set but the iommu lacks pasid support?

With multi-instances of iommus in the system you still want to succeed
creating a PASID capable domain even on instances that don't support
PASID since it may end up being used on an other instances too.

Jason
