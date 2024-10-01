Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC719D894
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812497; cv=fail; b=byCUKIwSOEieLu/MqtjxC84mg6Jsp5Wg2X1bvnsQyXCoyBigDuBAIDBH9iH9dxi3iUoS1+QLO9CEX9c6hARNAo+yOwGc5T3itkG1M/tgRYp7ulFUQMYH9U8yDT5zh9fmCk5HYRjS8/6+xfWfnGkLZfiu+e7h9TJvb675Q6mInic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812497; c=relaxed/simple;
	bh=oyhZ3JLHvdvm3myPZBnbrNscfW6RAoBX/P16fOh6p7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1W/lpDJeFd3IcTs1rWeeoH+hvsOikWkUh2f8xmaTfsRIKt4YAu3041q4QOV8pQZrRHnWsLKFaAUiPV9nvawOYgfmdsm11JYXRfe36EDG563n0bj80wYisngpCXI/VXKc129/0kQ4VONZlwGkdWEpjkUbBSeLDOgH3VH8c00vp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxrZ9Y0q; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxrZ9Y0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEr+k1umzWJbIsU6SeNnHD9zHheCDBiKbXfpPZfPnmWEe4nNiyQNQnTzmLAOtpqsR5Rq4GfkP2SKpPLY5MBbDL+BBNTwYX6nfdk1JqJOoVjeSyNpzCHBrKZyk27DOzA7NOChUb28x0aJiHQ1Igx6JoisHuNhL2c/tXeAuy6yvME3JMqP2WK0vTGuLLHN51482KSRantRuqSSX+JFAyc/T5XF+79ZZoCAkUpxKmH/cFh76Xr7q7S+M2enY/fepIgebqsZrrMg4/aG0LofFdPqCr/ujdBUCOXoyyVZ+qqo6W594Yq8IpO8uxZT7wUYi9YCZUWJWqhKztPSHlY21ySxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah2gf+2/LmfQYx+2/FFQJWJpxJRhxe8sjFdVODl37S4=;
 b=gNCssmGkpdEWRuZSgn77vJ3WCvBSbtTKq5va8ZN2jcLuOSWJJs2XQe7REdcbMWhj96pbVfdCrZ14b+qYapXTtkpjZhIpGQ010DGt6OzJXLDhL9SCpG89wRxCy/ai6KLpCJ3ZwQoGdoiB3ptTA2deRj/2L3zdQoVJZt4dFHFKMbDq6ix2cGz9fQ9XUNeMdJL/owUceHAjIzazt3BzlfeN1WdtazOOVfjlDK4ow0wX3ztYibpT+lymbA98MvPl48wWunO8amk8z+i8+RhaSu5NF5fMxddwANzyfwWGi5OgYI2I6KnctkhsqoqOedkulg5kSYhzFmy8UqVNGEIbatwO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah2gf+2/LmfQYx+2/FFQJWJpxJRhxe8sjFdVODl37S4=;
 b=bxrZ9Y0q3l/j2oIT/VGKVNGMtkYU1NAtXeFDvZqTM6+1ep+Be9ApZAJTBW391vuDNkBksxOJTP6eJYGul3OT3f2gIT/qt2/vjO/HCHDDud4iplQfRdKF+IOQgL8QHEKsrxV2WJ0MrnAv+NCFD+3F+19PjHRc7s1xTugWvHkqCUhpEniDhuIIFtblYLjDn6IQgq7WS7rdcD2H7jiHfOAyoFtZNBP1V5eFJyuoBmA6AK8y6SAMebAy/cDFat/UTENNON7QH2QMpE9fdoUb5hfL0p7ld8VNT7HcOrtMmQqG3EAWC3KjGS+Kj73ZTRKfQPnN/0mD4uJGBdQo4uMyiENJpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 19:54:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 19:54:52 +0000
Date: Tue, 1 Oct 2024 16:54:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 2/9] iommufd: generalize iopt_pages address
Message-ID: <20241001195450.GK1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN9PR03CA0735.namprd03.prod.outlook.com
 (2603:10b6:408:110::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c05ad0-84fc-46ca-ba3e-08dce252e9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xkpg4AVfyVN9MWZ/+8UtlmPwJj7LjbFH170Unn7kMrKRViRzn6lNmvNfOxaw?=
 =?us-ascii?Q?u471zOU2A1vwgvhylUCLmZCp9RzcZQX1ifMMRTHKd90zpvkQRml2OhCpYhKV?=
 =?us-ascii?Q?njy8K62yWQHia/ukzOu4/XhkzqXrba44ocFsTb1Ht3AfCWuBWIlAWfZCfSgP?=
 =?us-ascii?Q?N4mDebv8RPYHgb91kvemzi28pharjSXclpRo0GxDVAgEFqrmqJMZp4cfuZtE?=
 =?us-ascii?Q?j9h2g7jhRSrd0WlxidgCAKgIYXQxpr3ICCLbpCNzfxHiZCxpohBKatT3k35z?=
 =?us-ascii?Q?fJ+PV4NztWLHFK+5iBl3JmTAfYxDZzVX2deSxXuueyG/CoK0rmGEEsgCSWBP?=
 =?us-ascii?Q?AWXcwrizXv7S0BBI6OwSktPfAk4l5z/BRo01fZOPH+TiiSlfAUWP7EF4YACw?=
 =?us-ascii?Q?VoDm581aXZToZmE5ay/M0hwiMuFFUHgdKmM9oOEON2VLDpUoVysz4JlJYxiM?=
 =?us-ascii?Q?TSBQX2UxUpKr95GmxMyC1CljP3kjz6YLkZNhXuMOURJsSrwCxYq8oogZeSkt?=
 =?us-ascii?Q?ljyO44mZveL0bunzy3QoHtB53iY/SO1EMwb0JnGsI35oD6f6gud9g5FM2g4D?=
 =?us-ascii?Q?9Q1nQ+RrltyVqvpgewutHYPM06nHH8w8DLxfPo8hJmYCo26JWXnyFZrWS5WR?=
 =?us-ascii?Q?JWCR0Z18Oc+hZTyym0l3vAKlix5PPUHfkVh7/55whU1b7PGciqxT6vSzpK+e?=
 =?us-ascii?Q?oJ0XzPS/SWtCNd4x+IjNyvVLi/s/RB54cuweJ5i8W2Wluq0KV7Qu+cVKV4au?=
 =?us-ascii?Q?g18MODRkuty6pXNkFXubfBvnaCl9rYMXiO8PxSUuKlGgTIu/MfjJJ3nuk+Z2?=
 =?us-ascii?Q?TdYz7DE+3VEORKZtdtAi0W1KIVhTQBYMvbMssPKHhTXBCFrNC8YfVE60daad?=
 =?us-ascii?Q?BdX5TwyIxc/v8WUYplguksCnev5OuJaujkwY+cBfXS9Gr9fmdbqNsOguTJdh?=
 =?us-ascii?Q?nHhFRHcabbx3khAG1M2n9hg2leF22wbBlcak/ZNv1szKMc0KJD4K9M7kFPrd?=
 =?us-ascii?Q?K1dwEehgZNo4lsIS6R9FIlnpaOln1aJ6w96DBDEDEkxXHzPNIaxU1tWDLxsT?=
 =?us-ascii?Q?06M9R01N+i/1DvQ6/Y4iDWi89JrgjeWxGJheZZzPEaqHx14Q9gR78wqY44EW?=
 =?us-ascii?Q?1qlGQODHbFzq9LeUOgw14yRhnZMk6VPRMyv6h3R4TW/fH/Uyw+FAG0Pb2mLr?=
 =?us-ascii?Q?XD1WqpPnkjB+bbdkIrqL80nSyJWRXJr6DlgTOQp94pOiDze5fvuGw3ckJbnA?=
 =?us-ascii?Q?b9vHY1kttutrC9BZpN7ggMfEgcoUFLlTu31p8G+1D0yU61vfHLVwgHCFlDzR?=
 =?us-ascii?Q?gRE5GP6obqZgY09zP84AxOoLTvYMzwXPtp2p4t1zaU7nEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJEH283gCxcCEf22e5U/jG+Z6evOqyZlcyEMeSSsPyB3u3KHgsQmw8VJ0+Ke?=
 =?us-ascii?Q?QJknKECOlJ6JztQ00HLVkFPHr32dclHaJcdiMV5zAOfO+q6C9WugwqMcPXVr?=
 =?us-ascii?Q?AKZjgx8ajWnjt1iT/EdChQ4xWrYMEAOFDcYADM0XsS3Lcp26nL/g0sFQ+ky8?=
 =?us-ascii?Q?GdGyGTmjVuza8zp2+IBMVdQ2BZd6b8S+LD6CVRPi/Quw4OP6BnW9B657MqZD?=
 =?us-ascii?Q?wy8abylAOA+C3YNtI93IpMih3uTMxN/UtXewU1pye2Y62Gsj/Cbce+Wanat6?=
 =?us-ascii?Q?Sfan9jkjBZ0YTh3X5bxXd4UfVPiNAvrBJYr+r5/d87v6u3XNhzM9w78J+X/Q?=
 =?us-ascii?Q?Z+khmRPHMGG2oFdavLNUAU9l0FaXCzu+edH1ougNWaf7r7KwC0K02+7svz0Y?=
 =?us-ascii?Q?tlDRK7C/O7qxp/HwyaQCgYRj8hqmSScf+pwq9EfIuJ8nlI8mQ1FnqLLuSENv?=
 =?us-ascii?Q?UDTUY/zlu7uvl88nefkYJPTLOstCl6dnXt3CR2qdK/mj/S7NrxedCW4N7nte?=
 =?us-ascii?Q?hijUNrY7h+sHZ3hLhAia2SL2T9U0eR3Z0W+pHzpdfPdOKl58arDYMr77K09p?=
 =?us-ascii?Q?SmlXzxK4DrAdAvTol/xgRWr1rmkeqLiwN7TKUi56oKh8ypSZF/e2mDaiCv7t?=
 =?us-ascii?Q?15xS5g0Bh0tcBwET72rVTAd7Jx1DQdm84Uu00hs+WHyz2CEuDm/FGMd7tzU5?=
 =?us-ascii?Q?pAVoQ9yNtDsu4PqdYCcmE4wDd04IAfJGF3pU7BRogOruZn/oyj7P3Ud4PG82?=
 =?us-ascii?Q?ZPXWqPZ7yo0j3cX97AXMdNQiozTfZQGcnCqpZqSjvFkzOBNt9/Zky7KTHTCH?=
 =?us-ascii?Q?O6f7QhV9CYKNby4wIxWTjHxlp8r6svY1wymrE+A7q5H7UY7V/WeZu0OKAvqW?=
 =?us-ascii?Q?6CYywSndCwXUo+JqfEy0oYYRskiY1U73yCh2FpXE7EakSd2pnzCxjjVFgUsZ?=
 =?us-ascii?Q?mEc2g+t3o9hj5SrVlBbs7Of877Y5SjollioNZIooMDrGt8YmwgYpVc2dFLLe?=
 =?us-ascii?Q?8+5+s6K/KxtG+jU8zr3ZJEmzc16XO7LX92+7YVuWXIPrCDW8hOAfdgH8sNi/?=
 =?us-ascii?Q?K71+7HHBKAyuXOXIUpY1QYcRWwc+43Esaycms3CZJhrK0HF4rWkVqmpg3q6T?=
 =?us-ascii?Q?QSOBW+JLm/YfG9kFVQCzcfkqsXKfeRXNxwm20aKSCyHW2vZHtTyFZ1o25SoM?=
 =?us-ascii?Q?rdYfePFBYsrv9WYDBknNw0W5xw92m6jOocj3eKexa2d7jTwSlR/zk7wksVE+?=
 =?us-ascii?Q?PigTDUKxN1PL2ZBk7w8q0TjXUd282KlZamkxfCMN6fCZJlfs6x5SOSOYL7bh?=
 =?us-ascii?Q?iWJ/h1KpecJ0864TAwWop/UA/3FeMar0w5Xv4TKfKJw7wU6oa9IetMJ9Rl3D?=
 =?us-ascii?Q?GM+Kp0baR5z3MJt7jxApJ35lA0ox/qg5QEYIad6u5xVmTzglfjM9/pMV0msn?=
 =?us-ascii?Q?B8QHcWpf+kT47jUSEPFh0gXSZvpVyc+mpDbezGYvdv9YqiMqoEp8jgp/myZV?=
 =?us-ascii?Q?UqApHtGelwMI9FatxtunFQCHWmXS+Wzm30Ph5eu8oFQIO5aOkpTOkL2+nX6I?=
 =?us-ascii?Q?H2O23ivvUhf7f1pZ660=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c05ad0-84fc-46ca-ba3e-08dce252e9e9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:54:52.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDnqK9QGnHkQlN+7Qchabj6X5yQRMM0GEZV/pjDKZx6mD3ZELJgirwDHNP8h0ZVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

On Tue, Sep 24, 2024 at 08:05:31AM -0700, Steve Sistare wrote:
> The starting address in iopt_pages is currently a __user *uptr.  Generalize
> to allow other types of addresses.  Refactor iopt_alloc_pages and
> iopt_map_user_pages into address-type specific and common functions.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.c | 60 +++++++++++++++++++++++-------------
>  drivers/iommu/iommufd/io_pagetable.h | 13 ++++++--
>  drivers/iommu/iommufd/pages.c        | 30 +++++++++++++-----
>  3 files changed, 71 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
