Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D27BA3F
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138432; cv=fail; b=lUby5EdggJNIo8quO7AECD669Yast8+qUM8nwuHzY2veHVw8L1lbRZI4P5TScJE+OfgarP45MKZdZx6TLoSsE80WnZ0PzsZl1GwQHB+HhsKx6G3T69iyRc13eBj2o6pqf53wIB9ss2BcIcHuMQuAJf2ODycngsI7xPyNUIicByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138432; c=relaxed/simple;
	bh=DY2qKrJVIy6SwNj9HXCu8zjS1AYirnUZbnlB6G6BVuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KxKs/u2bSwPKP3jbAiD+gcC2ui+NgIsPnZneGnvjSqGLbfW5dDAJswqffODLG8NHaRJVdYbRWU/Etbdk8HiQZhcfbS7d5GX5MVrixUe57ruGSHlnQcjkK7q3CMISVZxtwLuJLck1/LwW9xUGnxXgQX3EQJO5BkefImWxUABp/4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTlwrqql; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTlwrqql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuBREzZdBIAE98qqhoWDgpOLyJS7RQJGPdUvUK7gWyGF4wWmKh6QagwmaGjW2yoTOOj8PMb/O64z5DHta//jVEoBhSF+5w9smfPj4iW5a0d9LIs8NvlNkrId9pTsnSLNYrROYaltstxg1g8t0/aeFz7YcY2NNOyd/94H3HwHZOC8R1WXGquwBI8sBNycLdFq8zJpuMhvvxAa/kQI3Q97e/iRGoH68uIX5GLKp7H9G9NXLGWLknyNohRDbymbolwEoyQr6MyA0vlI0Jrfh3cC9isEEyeF9igltN3liBjCeQou5o8JAARWeylL1emnOgZqZftIXJx4itOYgk4zyLO55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBA/XOy/llyvjojKdIQ71kQgBCU6PhE/iSQPnd0VagY=;
 b=a6Amfj4fI4EujaL4VnhUxKZpL4S98lMb9ZZbQRiryYrIABiN3di/B1hkr2wkj1olyka2RzfkplxitUbzFMBBPYKtX+UCgS+J22cLIaSN6WfeS7Kmzc8zWP6yuBfE6LQMOdhrPweasvZWVrTYq6wZ4LeAhOsZ6ndcEaikBaaUwUSj66k/dw8upki8TP9Pjkg/Io6beYBIEBVxCNN5LCct+lMs/gPn6WoRL6weoC22h8bD2ZwmD9+s6DOhVcgE3xKGo5Zz+5S/bOrQCQeGsLgFXssoXsOWfdvB0NzdknVbYz2hTc3W8yPiu7vorohq1bsmjl903CLFh/q4fLUzoAdJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBA/XOy/llyvjojKdIQ71kQgBCU6PhE/iSQPnd0VagY=;
 b=DTlwrqqlTwxtpPH8hJgbbC3jIEnUpLkeKDCxXzc87PiGBDN472Hsl7Xw3aqLeD6rKR515b+ltFMeSi8WKvr3wk5yEy5Dfw3KOyYk+CcSCh0usCSz1YrGlzGhIQfBxOIdEWGIO+KCnns+/HBDdwluL3kt73YU6kJpsGYCEbuK7328viJI2KG0w6rPpN9/UwATOX9dQtAqXrDo8SbLQwkaubX/3MDgwzMi8Qx5IKbwNlmE6OOlglb4YO5UFR4EjS/yKes/f7D5Kqb3MQ5nvt9sTi+1XuZnFRSNz5RTKPArDQPTawq3bv4QVK2O8I2UAqPyajXyHFBm6/bX4QEfEmRBtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 23:20:25 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 23:20:25 +0000
Date: Fri, 10 Oct 2025 20:20:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 15/15] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20251010232024.GP3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-16-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-16-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:c0::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 68631a98-83e8-4ab7-414d-08de085397bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Pyr85O6HjY9fC6oe3PLqR1F+eM2vJj6dFMagD5v6cTsgS4U5Ha+zTKLJpxq?=
 =?us-ascii?Q?YtjFcgjBKhvAvpLqvHwV0nmW+C4W/IEMKYUxxejgqKqKTCK8WZKurSvW10Ss?=
 =?us-ascii?Q?+y9lqwBTHGERoqrarX9T91AtPCtYW6QtUrO3T7V1mCsTRpSz46ObnGw/UaC6?=
 =?us-ascii?Q?cD7R0t1WwRh4PRtBycJUBQnZxx21hmsIRI8Q8mxyMpxQBPqmikP+b81nrRey?=
 =?us-ascii?Q?TMRirUjRuf9xfYrfPlQLU8eSBpZG3/WZW9JFwmuvjlyMcKOUbaxRcxbA1V0S?=
 =?us-ascii?Q?+GyTDH8T+goN2FhrgCsx+RuJEIqG0XZGp6nqdcGIIfNp2wIN2+UynxZqTOY/?=
 =?us-ascii?Q?Toqs1reDYloo2zO4bLyaay78iwWmdy58x2WIyPszmLcaXm8CmdAAs/zGeZH/?=
 =?us-ascii?Q?Mknf4iepsTUgyDU0ObC1LmwlY8MUT8WceZ0ywCg6Y4rqJKWYvCEEl225jAXo?=
 =?us-ascii?Q?6WqlJgzK9fVBc1uVTZVo4LYTV9qg/ht4eN3xCluEvDbvedq+Tsp9fninoRXL?=
 =?us-ascii?Q?67e2xuwn+SVX6byJtx7T2MkwkybJN+VwKryHKkVw7art9LdWCmKWx4dR98xc?=
 =?us-ascii?Q?O3llcC8Cl+92SyElyR1qpvGKnTQbCre+o9EREnKcO04DJLPvkCTZIF2alRRq?=
 =?us-ascii?Q?vuLqUngTEwTUfqkkDQYAfDJC3CXRbYNkvPo5jov3iwSH8uZK6o8yw5ARWpzC?=
 =?us-ascii?Q?uLmpkE6GaSzUdOnBMISPyqtTvkQdcYYdpx2Dl79kuEB/M+vJMGuukWa2hrd+?=
 =?us-ascii?Q?OqLCcksovZvYVEL+QNgRthRnQBBUAu2ysVNmVmSzzkzZ2OyT/ZDM7myFY6ig?=
 =?us-ascii?Q?Fts3XFsGh1SnR5qJtRIGLzqbwgySwALydh7voDd1l0wV/bdf1b58R2dXCvbO?=
 =?us-ascii?Q?QuMahuZl1CchBb2GgTqA1rkNLv+v1M+ldhw1ho2hJ15Bcf2PsvRTITCWrXGv?=
 =?us-ascii?Q?fjDhjL16oyyvog/i+4O0MRDrTwutyrjPH1iD1y6lAx3SJ5mJ9oIDLz/jVtar?=
 =?us-ascii?Q?MI64tmXUJe6PfdauCLGEtA8qkpr0/nCG6AzwmpVfqp83H1HuUpX2i9npVVwp?=
 =?us-ascii?Q?Vx9y2KwZC/xmAOpwLeEnO0Tm6kpH6rVvgA35NGVc+4wvqGd7IUPWQgcWuYUT?=
 =?us-ascii?Q?UWKq5eShn65J9m2R2y05u6fAvPJ8SI27DDwcj1uovw4TEet96TzPJEFQ8iOc?=
 =?us-ascii?Q?Jv7pacIUiC90OotmeXlndlCVB33qGJD5ZbHU04AdNHfIt6p0J7EW8EjdbZiD?=
 =?us-ascii?Q?TRfEydvh7lsaCgSKOVaZmQkB3PvKRbZbjIzaUEtNyA0KZDujI6VU1JKze/hB?=
 =?us-ascii?Q?NSe8BCZ4EfY8xFfi+9srJM/ru5iZY/tDpk4aP5kUNKimA764LqdPr5qSffza?=
 =?us-ascii?Q?cQFWjQffspmXvSTMnI5ruykhWftRH+JVI7akayygcHRqCIym2jW3p8lrDqT4?=
 =?us-ascii?Q?91tQGw0jl6NG3iCGdddB3PN8zXy8Xe9V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTcGw25WylZtKtgK3CwaMglAPEzI6/qPcNx0uBwvGzMoEeCFiIbToL53voTD?=
 =?us-ascii?Q?qltM/EKHj9CG/+nzJ0iwsE7Hb62GsQElbBVWZ+Ab5UOCvCcnAcSEER83Mrgl?=
 =?us-ascii?Q?XJnuBiSI1OmadEEVA+m/rvb89W+Wf8lOSn313jOmzNwNsY2A+RXAFYAkfOQ9?=
 =?us-ascii?Q?LM1RysxK4n3KVPs0P+xzgCFyTbF1xW1Z8Y9jckxwEBFk7CabhG9OjaRQ+k1R?=
 =?us-ascii?Q?XTFvfwfY0le2fkQu9jYxeCSmErVcme9jfgRg/miqi/xKXhM1PdvwqE6qcUmL?=
 =?us-ascii?Q?NO1L+VDeGyUnVrNstVMhVij/Y4DSOxIkIZHgJx2r3ONtFd3WciuEE9+YpLKq?=
 =?us-ascii?Q?XJMO/Z38EbYnQ/33s7UsdE3BOBMAkQLRYhV6i2iAqGPGZTqPeJwrZy72CBzh?=
 =?us-ascii?Q?17UvCVy0i1YEmK5zy+GLUUgzR58owo/2eSa06rTuVsdKIaZ6ZNB/mT/iUTiI?=
 =?us-ascii?Q?w5pF/fHDmH2FdR7oByo7TFG7hMP1seCkSiD1KvErOF+hey7NLFSQIilIA+7g?=
 =?us-ascii?Q?iSpEfQFNlP/CsNBzWnD64jle+obPcaK63Eah/hy1ZtS3AddlN+JRY6gaKO6O?=
 =?us-ascii?Q?W9ms6rSUIr20Lytrm/PjrGCxiKu9NR5epNbjDbRA6rufxmFFd54x6QdqQRs4?=
 =?us-ascii?Q?Zd4ZfOFGrkdclcfxJgbYFOSFl6hjSKNduwzbBXwoDJwgPbWRa+7C8oqMipGP?=
 =?us-ascii?Q?5pD0rsUnznNAt9CxbsFlZryZpN7L3U7I5LFoOaiRWsS0qqFVsUOuIu0BvPIC?=
 =?us-ascii?Q?n0Q+Fa6/rMFoh8u4Pf90EDuqnbhqX6EyTJQ74aTlc1Dv8U4ZP2fHwR4Xo6Om?=
 =?us-ascii?Q?JwsibWlZw8wPBY9srw+956NBxrum8IkIVgnwNdmtSK7qKmqpgjA00dvhIQso?=
 =?us-ascii?Q?OdNlKDpkuVov+LBO3X3718XsYbbDCPaWXIIKoUB+BwofbDFZ9yBfaFVWdl+N?=
 =?us-ascii?Q?PWu/zDOx7q9O327kA3yDPXeQdsEPH1eJHVeaGZBmTZQ2GUIZtXGEY918P46F?=
 =?us-ascii?Q?I+orj7Y8yj9oRGJ9cmFAR9KF+XVEjpHUzrpAplFtc91r3gYOUHpE5rcgkxsc?=
 =?us-ascii?Q?BjfpG4w+AqNzm+zAUzrYrnLuQ3hGsgjgIUs7QJEr5ct/JTl6pMVTCCSObMvT?=
 =?us-ascii?Q?PrdWBlBUtYHOJN6JHFB8gbz9yAAuDOwcPWLb2fIE3T9ZnE6YKOjMipiMuMAa?=
 =?us-ascii?Q?jkHkjnnYyjmP4vTL0wSbE79cFTl5i8qge+ZpgD+n7Oq+bbZTMA7mpU+cEN4G?=
 =?us-ascii?Q?HQCgz5AfceibSgAokZC2BplRRGYIplcw5CdZqh1cOlSXuqXqySque0sb31tr?=
 =?us-ascii?Q?tmigUs8w8Z3ANdqolpBgA9uUff55PTT1AaAL9GYlZNmUoyyccvvhYEIT91Xg?=
 =?us-ascii?Q?dnw23b5f+VPH/LZl46OGdXNUCvRaAkoX/vZOB0g2cySypfYopKbq7haTwMMx?=
 =?us-ascii?Q?VFAJWYgSBKwMPILbySp6qdqrtSS3TZ/h7Unmg4YPUA3q5pn5R50n2ueh5oRf?=
 =?us-ascii?Q?85dqpyXNn3kNdyZIgaiGg65MEMinbytIoX66M7+fbH6aywYc9z8HM2F4tLG7?=
 =?us-ascii?Q?jq/jo6Ar4oUq6lzOZtU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68631a98-83e8-4ab7-414d-08de085397bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 23:20:25.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V3AsdjV0cF8HzyNjdtxs5MnJpULGgjlUybes3QPIJP5QfGBX2QQAy5fNaa9Z2qN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867

On Thu, Oct 09, 2025 at 11:57:55PM +0000, Suravee Suthikulpanit wrote:
> Introduce set_dte_nested() to program guest translation settings in
> the host DTE when attaches the nested domain to a device.
> 
> In addition, introduce struct amd_iommu_viommu, which stores reference to
> the nest parent domain assigned during the call to struct
> iommu_ops.viommu_init(). Information in the nest parent domain is needed
> when setting up the DTE for nested translation.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  3 ++
>  drivers/iommu/amd/amd_iommu_types.h |  8 ++++
>  drivers/iommu/amd/iommu.c           |  8 ++--
>  drivers/iommu/amd/nested.c          | 66 +++++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index cfb63de7732a..98351b0cb9a0 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -190,6 +190,9 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
>  int amd_iommu_completion_wait(struct amd_iommu *iommu);
>  
>  /* DTE */
> +void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
> +			  struct protection_domain *domain, u16 domid,
> +			  struct dev_table_entry *new);
>  int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
>  void amd_iommu_update_dte256(struct amd_iommu *iommu,
>  			     struct iommu_dev_data *dev_data,
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a68b5c2fc0a2..683ee288c636 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -17,6 +17,7 @@
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
>  #include <linux/pci.h>
> +#include <linux/iommufd.h>
>  #include <linux/irqreturn.h>
>  #include <linux/io-pgtable.h>
>  
> @@ -420,6 +421,7 @@
>  #define DTE_FLAG_HAD	(3ULL << 7)
>  #define DTE_MODE_MASK	GENMASK_ULL(11, 9)
>  #define DTE_HOST_TRP	GENMASK_ULL(51, 12)
> +#define DTE_FLAG_PPR	BIT_ULL(52)
>  #define DTE_FLAG_GIOV	BIT_ULL(54)
>  #define DTE_FLAG_GV	BIT_ULL(55)
>  #define DTE_GLX		GENMASK_ULL(57, 56)
> @@ -590,6 +592,11 @@ struct pdom_iommu_info {
>  	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
>  };
>  
> +struct amd_iommu_viommu {
> +	struct iommufd_viommu core;
> +	struct protection_domain *parent; /* nest parent domain for this viommu */
> +};

This alone is not enough, the core code needs to allocate this
memory too. Make adding the viommu to be its own patch before adding
allocating the nested domain and move these hunks:

> @@ -607,6 +614,7 @@ struct nested_domain {
>  	struct iommu_domain domain; /* generic domain handle used by iommu core code */
>  	u16 id;	                    /* the domain id written to the device table */
>  	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
> +	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */

Into the nested domain allocation patch.

> @@ -2044,9 +2044,9 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
>  		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
>  }
>  
> -static void set_dte_v1(struct iommu_dev_data *dev_data,
> -		       struct protection_domain *domain, u16 domid,
> -		       struct dev_table_entry *new)
> +void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
> +			  struct protection_domain *domain, u16 domid,
> +			  struct dev_table_entry *new)
>  {

Give the function the right name in the patch that adds it?

> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 3307c925d3c1..ca3d3001c87f 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -63,6 +63,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  			      const struct iommu_user_data *user_data)
>  {
>  	int ret;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
>  	struct iommu_hwpt_amd_guest gdte;
>  	struct nested_domain *ndom;
>  
> @@ -85,6 +86,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  
>  	ndom->domain.ops = &nested_domain_ops;
>  	ndom->domain.type = IOMMU_DOMAIN_NESTED;
> +	ndom->viommu = aviommu;
>  	memcpy(&ndom->gdte, &gdte, sizeof(gdte));

These hunks to the nesting domain allocation patch

> +static void set_dte_nested(struct amd_iommu *iommu,
> +			   struct iommu_domain *dom,
> +			   struct iommu_dev_data *dev_data)
> +{
> +	struct protection_domain *parent;
> +	struct dev_table_entry new = {0};
> +	struct nested_domain *ndom = to_ndomain(dom);
> +	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
> +
> +	/*
> +	 * The nest parent domain is attached during the call to the
> +	 * struct iommu_ops.viommu_init(), which will be stored as part
> +	 * of the struct amd_iommu_viommu.parent.
> +	 */
> +	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
> +		return;
> +
> +	parent = ndom->viommu->parent;
> +	amd_iommu_make_clear_dte(dev_data, &new);
> +
> +	/*
> +	 * Use nested domain ID to program DTE.
> +	 * See amd_iommu_alloc_domain_nested().
> +	 */
> +	amd_iommu_set_dte_v1(dev_data, parent, ndom->id, &new);
> +
> +	/* Guest PPR */
> +	new.data[0] |= gdte->dte[0] & DTE_FLAG_PPR;
> +
> +	/* Guest translation stuff */
> +	new.data[0] |= gdte->dte[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV);
> +
> +	/* GCR3 table */
> +	new.data[0] |= gdte->dte[0] & DTE_GCR3_14_12;
> +	new.data[1] |= gdte->dte[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31);
> +
> +	/* Guest paging mode */
> +	new.data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
> +
> +	amd_iommu_update_dte256(iommu, dev_data, &new);
> +}

This looks good

> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	int ret = 0;
> +
> +	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
> +		return -EINVAL;
> +
> +	mutex_lock(&dev_data->mutex);
> +
> +	/* Update device table entry */
> +	set_dte_nested(iommu, dom, dev_data);
> +	amd_iommu_device_flush_dte(dev_data);
> +	amd_iommu_completion_wait(iommu);
> +
> +	mutex_unlock(&dev_data->mutex);

Where does the code record the ndom->id to push invalidates when the
S2 is changed? Seems like an important thing to be missing!

Shouldn't all this attach related stuff be in here too??

        ret = pdom_attach_iommu(iommu, domain);
        dev_data->domain = domain;

        spin_lock_irqsave(&domain->lock, flags);
        list_add(&dev_data->list, &domain->dev_list);
        spin_unlock_irqrestore(&domain->lock, flags);

At a bare minimum if the series is going to stop here then it must
also do correct invalidation for any S2 changes.

Given that, I'd suggest to also fix the domain id's with the xarray so
you don't have to redo the invalidation logic.

Jason
