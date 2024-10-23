Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D71DFEF
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689901; cv=fail; b=F9ybWHD5+z8j3tVH9ckc1SKijanUmb2ObkAGKiUm/ezs8A5ZtIZw0OZI0y5xOxLcYU7Oyy+a7l23G/UxDoJGURJ5e/rQaOdqUCE31J/8u9h6m4n8l9gmwy0CkV7E4Bd4V4vP2AKsag7I7kxGIkijCSODr+pI4Oqisu4QE+XnhBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689901; c=relaxed/simple;
	bh=04c6i0l4t5jt7jBepnskaRJnh3cjSVJZQOALLD6iS0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c9wnD6zNeaUzM8qpSAKqQq7BipQEhbFtHGh4SlGF52NFVRBKpR4Vbt20Xec7VTd/yEWbrSJDG6ZmL6jGM1dOKjTjpMedxQd6JROi4IrQZkOp9ZsZuA0CT7L4gfH+gSrEAhASOVabu4mIt15r6haVi19myeaztuC0+wwBKxTCx+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvgj8uJD; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvgj8uJD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG8ZpRVVuMBy+qRKxXKhsqldjIe6X/cLrH3KfsNYRerlv2SM5a5LzYhyWBoMYYPPkZFQerDjfcq9BGfdUGmQHEmJPnVcuHOyUkTudEXT/nGRI46Z4Phk+kHb6WarEURdNEXVSgMdqhE2owqCGhDAaHHdyq5bsQvpZAXgFgH22vUwhuf9yhTTG5249/IF7za1j4ILwHTmr2LkDhH4M0/kOhZuVn8pDTS3rrcPT9fSiB85wF9Mw8MyRht2hPhcs4/73qrHZWwBwMi4RMtIaVpBH/8OhKhisp4BYDaMKhySKYi1XVlmd4eWcBe4ZMngL3RWl+dIoyyN+k9UV5CCz+Q3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myS+D8dPRdNYiai9KZj5kG2nSCe7UoBA3fXRYMQwAqk=;
 b=C23sp7G22VV+DuejTD08VDnMtNMycce7W7HQ++JjVleEvHVJmai9yYOkDV79SVnizSdVxTwLLHLbvnXpJs242BjRwn66JinEUGZnrQIlk3JEs/wcC+9W0EF+WDETqufbOvHXNLInuQqpy1QzBzSUujiA30Z6ihCxUJPuKU7OZh9DVcp3biLoKGpi8ybQ1rPKQQY+nKXdQeiqw6wDB4Bx3zBpy3vtU/wldDOMra1Qyri/KatDMTzN3/0ab11UN/H14OcTr44EZ+8lk1vCHcHI45eCfxJ9pM9FVrH5zhJutqc/86BcIKxneHF04FgKAAcObQKi5TitTiOlfqGkgKWKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myS+D8dPRdNYiai9KZj5kG2nSCe7UoBA3fXRYMQwAqk=;
 b=rvgj8uJDYK2ef6VCydWlVe1ZMgXNK459FbmrndNIGB7ksrHBUsDW9+ptbP+F+ZjNcr6NKZg+DYmnCntilTGdUOCbHqWX6UPNG5MzJrh59Ebb4gkhXHxJVMD0lRSCNpQOirbkpz+gITnZFKrSHvBcVHgoUQ5epIbV5i7zTwwVXmHdQprewqpZZ7KN7AYdZcaqVAxf3ojgRIzT8A8bBL3hbXLNz139UNqceRCxWrBiqLFuUJvniKQTrQmApQbc3k01i3m/mUTRQk+J3TxaZ6yryNgJw53pLcvCo3p26EWbx057wzA3Vsx/qildfHJDQbOwvTbwMmEHelKHDyFj0Ko1Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 13:24:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:24:54 +0000
Date: Wed, 23 Oct 2024 10:24:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V5 6/9] iommufd: pfn reader for file mappings
Message-ID: <20241023132453.GG864191@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729630838-24586-7-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7691c9-b613-4091-2336-08dcf36614fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Us3jQP0lIv5KuAt7nelN3OO4Q0gFNPmMJdYpAt4OcJMz8JWQJzABYmP2fjPE?=
 =?us-ascii?Q?MD9yUY1oew/Vn6QRTc4d5/MjgzDGcDDJAFjZfA1dcUukZRxbSfNNsZmYCqjW?=
 =?us-ascii?Q?wP/q97HvLfQlWX/vUUTLzVrXfiG0pRL89Z8QE5amZrb0Nv9rzXkxG7UTBvZZ?=
 =?us-ascii?Q?/kOq2s/lNjB9FEF5co1pafDtSilzDKvAlN/zfXKuicomHkkODBWKGnDiO8lV?=
 =?us-ascii?Q?Tt01qD4yw4YIYzSUc11aGQZCKdM4a/Mb5l5oIVMUULH/oJem2Jo86vNW9Vpc?=
 =?us-ascii?Q?0CehoVTuuZ/Vh3W6Yo5BrRAUeEXhmZ7qNlJxxMhI2fy+/ccgm9ai6KXAanqW?=
 =?us-ascii?Q?Dga50ZvzV6eeKvoC4kSqlyRivwgt42En0456Kjh8axPAZ7hwf6nbWz+hKUwu?=
 =?us-ascii?Q?nc6wJ8hdgAGyyAl+UDKQ2CYzRu29ZxrLrQr9yFS5frwK1bgTUG4cXjv0rTP8?=
 =?us-ascii?Q?m2Ah6cHd7LPW+HPzLc1T7IqLv3IOCLuT+zU8kT043pYa+n7Ul61jDzfV5CWE?=
 =?us-ascii?Q?jvBFYPsiNz70FKZ9jxux3UoDd3sbACHPD3cUKIGKbGHGOH5uIwlwx1zVzKfp?=
 =?us-ascii?Q?qmTorpXCTuwzcZfKjCsC8cNSBoHUlg1joHLqXt9oTX0ne1Iq0nO33aryHq16?=
 =?us-ascii?Q?h70cTSGLT6fdpGKqdxwR9rnDoQjwf6HaRfS6C2Kj4ZuMwRFaIgEbFFqsIv8H?=
 =?us-ascii?Q?z075Z1gD57XZGBX9yn62OYZeM4z/2SMHgguigTbnVd3t3xUakZUIZ9vBVnmN?=
 =?us-ascii?Q?s8Wnkn4sYBP030sAy/oWmz7kgre8ksvR4bS3a48Amlh1y74yo0tXBtgKne7p?=
 =?us-ascii?Q?q6MdTRWTfGXXxHm8wkWJDHPWN+/VqElkHi69dQ3epR1wn6h2za1p8p+x+OPg?=
 =?us-ascii?Q?Y5OMYJbXWrYzZLiQhJJ9YLi+RynKf54GtJLQBaPVwu1P0teEIU9alYujyFhM?=
 =?us-ascii?Q?ixFXecHus1CLbzgDekxEK4cV39FS23e1AklxPn+pn5OyX8OPhkhBsCoQP89M?=
 =?us-ascii?Q?4cOTMY4weMoYPkn0kS2XXCYoAypckjoxv/hAhmAO2/quF2jbMTi9slYhq6pf?=
 =?us-ascii?Q?flviSlULhSjUsG1q3j27IdrPv66ct92iZ29nULNQQ9ackO5pHOgLjo803bxN?=
 =?us-ascii?Q?H1JfMFjr2o4pqygPhwAVQLxpuhBHzxt41rfeigBfCpKhTOioL6dpZW/0VfqT?=
 =?us-ascii?Q?DKX7Wt4zwhepD6GYhSvwjJNNFY9b+0KQF+6/NL9QSubU3Rh+ixZKo3L8+sJ+?=
 =?us-ascii?Q?DCb79MtKc2BFs88/B8CuYF+JOWt20zESm2bOaSuZDT2OLmqFt4r6BdvETwkp?=
 =?us-ascii?Q?gRVz9+6GplRCSrPxgH/uUgA0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGlfs1dikoRr0Hoiw8jmCkxJ+u5W1QW2LzMvS6lpP3JJvWxt+AF0pdHh2Qj6?=
 =?us-ascii?Q?Gtb0Esw133tIDALxgevX5UoHqsaOwbx735j6n/jvfp8nU0vMn0+yx/5z15QG?=
 =?us-ascii?Q?n+NqWF8RrPDjWNed8YqrWJoQjYhUAgTd0Rt3nQAdl8/gzVgN9JBMn10egX/i?=
 =?us-ascii?Q?yEVCkSXLEVOOtAHlcEfNubglpFc4H0DzArwCij801Ym0v/MmWVpjcpk3QIrQ?=
 =?us-ascii?Q?S2QpLGMpao/J+DLrEU7WX6vusm2Kyqpxytgpl4r4a+hqIWliaTT7ezyl+7CD?=
 =?us-ascii?Q?Q5lpLmDkn2rBt0PCmNj8MMhMb9R5/jqrMdNWwj0/8yYFl21whYGW87DeJrKB?=
 =?us-ascii?Q?AWHxnu7heg+TIhsumitESP8Lwe/TNAKGbve/cjlVG+f+uO/LdWd2PvfuUU6B?=
 =?us-ascii?Q?VXRG3G43ob2ck/jxrAQ6ehIQXPNot9nn0Mzwi6Nvuekepk6xolo4NatH3pxK?=
 =?us-ascii?Q?1xKHWZveVJWMuivZaCaj2yobMw6BW82URqvIJwxhK+a4730XNcxc0A+2HAnB?=
 =?us-ascii?Q?413/t+mexVb0Oiad0vdUxjQxAzcw+Wrw4GalWljLGSWuA7Qq9XFqnHh7xXdL?=
 =?us-ascii?Q?yg2CXOxPf+iJUmIKCU2CmBxUOcZZfH0d/C/1/oLd84tAMeXpYz/hFdf5hxmv?=
 =?us-ascii?Q?xU4hEADslJIUnLpbyMIjtZST0tD99EVWqLLZmUEu2abEV11Gmb+PM2uQv/SQ?=
 =?us-ascii?Q?w1tdln9lj8VhwC//HcRxGoxfYWPzvzkn41/UOCQBRShwJia1SHmWUF+9Ms1T?=
 =?us-ascii?Q?wjW4usJsvtNij8UW46Z0UrlmpGAs59Nb4Q25Z21FCkcvtlXGy2fcftA9kt5D?=
 =?us-ascii?Q?xOAugCGPFCQS2cDRAr6ryuAKSbG2wfpsw4ud5Lu4FOqqzxKC6Rv2wrLjgvLW?=
 =?us-ascii?Q?i0mt1l8dMKXaP/2FH8nyoL/e6AuRB6wXV8zfi4vNvk1I0QK/OuUuDzlB4VIU?=
 =?us-ascii?Q?cjEB7aiv1imz9+cmlt6IYJQ2qs23ODNeUuUOK0pedxVuE4FMLyVL78zx6ltc?=
 =?us-ascii?Q?oGPuSttxCil98Z7mx2OB1w0Ofe/YCQZyK7UF0fmAWIskALjMvltURk2Jnv0x?=
 =?us-ascii?Q?qjAddgO2NwvL1k7jdOE47CLQucOBxferoCBLdheWb4Phg1uJwcOyJ+T9RTF9?=
 =?us-ascii?Q?bWTRKG5KKyyTAcZYo71lAjjUXCFzVh2ndxhPX1CZjI42oE8rN/QslTm+LXLU?=
 =?us-ascii?Q?LhefmNqxOYpxjHBT7jKKcsjHsB77nPDLfwdsRxpmaXb/asg+Z6huV77hGRcV?=
 =?us-ascii?Q?Cmo6KWZcU0TmKtcFqrdE/Sa3BezRh9cCpzSerx/IfuS6Qm6ebnwghmbfT3cp?=
 =?us-ascii?Q?W3PRNLu23z6m7KhRHl66N3g5tQ7a51ouCKeJFrodL6L/xzRzCB8U1kKfTsM3?=
 =?us-ascii?Q?0ebWBW+XzgKYZHePscrC6jTE39yHqu+ln0PkA/N4UjJU5Aw9AKgSIpybSyHU?=
 =?us-ascii?Q?iqBMwhv04ngHArTlKSFJUqik5yZhGJ2OCXq0rDLGJcAxfIAgCazFoECARMNF?=
 =?us-ascii?Q?C0iK63CDQyU3zk7rZCmiWiOeSoQH1JGN15j6sM/0OCwbarYcvM+EIQLTloxJ?=
 =?us-ascii?Q?v4Okk0yi3ilL5X+W6+9Dre8rIcPux7E0Jgkjbrva?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7691c9-b613-4091-2336-08dcf36614fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:24:54.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEGg0l129A1Hon7PMxSeGBOFt7yq0p9xtF9Hc+sTv/njyJZcuHUmqWDFrMN1nO87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

On Tue, Oct 22, 2024 at 02:00:35PM -0700, Steve Sistare wrote:
> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
> Repin at small page granularity, and fill the batch from folios.  Expand
> folios to upages for the iopt_pages_fill path.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h |   5 ++
>  drivers/iommu/iommufd/pages.c        | 128 ++++++++++++++++++++++++++++++-----
>  2 files changed, 116 insertions(+), 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
