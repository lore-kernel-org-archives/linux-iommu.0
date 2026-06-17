Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268F134CF
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654996; cv=fail; b=LVrq3Gmsc0gNt7nv/+SdtJXQTLCugtnx4zyVqPPJVl6i5j0lZyWPwmvBTwCKdW1a9P8iCjC1CR+J19mU4eWh17f/GQOaswSLGgRtYLzVzwFnzRstFgN958TmkOiUjyjxbgxyC/pFp3O0EohSuqN7r2qdsyuETro85UJmaYtSd7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654996; c=relaxed/simple;
	bh=l9YwXXQHZ2/V7sWUuQs8iGG8CAWekzGEc4+phRr+UaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y2aYuTJT2kDm1OXhyAY90P5Eun4MiXlhQyojJzyyb5BTqm1cHsJ6OzFiYGNpKjQXPO/PhC7fCdn20Em9HchgVE61v/czURtDGWVz3LlR6E9HWEmkRk5M9Oe67xk9lDUkDBcXXdLt5+e9bp25hPKIqk84cfhYYidCRhlz0iZn41o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hULknxYP; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hULknxYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5J9+JFGhC9D0IbQKjqasd4BbDIENRALDKFVoq6x6NDTmdFGVEzGtTxR2lAJBKnVv0YXPhTmE6ez7uCc7MUJ5V9xB1xpNTqAMBbeJZWmmY8ADfl8eM2ozCws6l3jO+PTQWAObP3hZeR7oouZowJ7spoGTxVjizddnkh6AmdZ8qRNgUEpMe6dfVhLWh6QglTaanhvR2dxID//LPgLZi8nRAKcywUHWh5SBMtBpJNoQPxL2FvBWfmBLdILaxr/O1OVCu2v1d7B6XVQetQAb02ht0QpJFmHikBTHwVfFrUi7aMIPWMlp1dtgT+3pJD/Gi8J9Z6nYeiWFvgXmvSH0syqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/anycA9CUOAT7tKg6HK+Af2cW6hAxNh6Qpbo9dmZtww=;
 b=TG8/o9i3QrpS/1DhqfgzGO05TjJECJCxDTULpYOrGb068eOQlDVuozlcIgh41D8TE2U9R6D760Lek9z2isetRNK0g4JqgUJCt0Uc55/OpsPpz838FQIptwois0pY5vBZBbWFQoRVABiEjAofiZ4z5+s0042vS5sLNo93I/jBL2dsnbT8sW7G/ybR05TbtJGiEaRYQV9LLtz5VGwU3wLFN1K/7Mj37X10GwKo6U3E+GCmyRKAdVcG5Vp6sxg0+xKsrRlLVq5uSYeqrJWFleXd5eUipF3z7cp2YIv7XJTaN40yTfjOIdcaxnvmb00Jc7JrOyPqd7krulMU/jvD0WCtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/anycA9CUOAT7tKg6HK+Af2cW6hAxNh6Qpbo9dmZtww=;
 b=hULknxYPvXK16bKdsKQOAQ3F88cbd/A/IyU6vdd6cCdhWArT5aM1CllwuDJAiaz0tRnWMiYDHQpjWvmPdPSMcRhCAL0MfqHR7+UHt7xfLz1l2s/CiDVQV60eOrYRuxA5A4zruA7xJ6ptxv+d1OVzAlM9re5ZXu7H3KLzmJNOT+r4cNaDBM3uZQvZXIrrtlCzgxXvL3oNDBDBmonUgRBcZ0rnHeSk1bRP2dIzc3VV3IkLarJw/Gz4C5QOr0UfuMwho4mCNPwSn8GXARYSthEnJMax0wTba+sXu+iOpYFihWvj7ZkTwlw1vxFWysz/ct9hI4SKt5yyAV7FMO+aRZB5ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPF6407DD448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 00:09:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 00:09:50 +0000
Date: Tue, 16 Jun 2026 21:09:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260617000948.GA3577711@nvidia.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-2-jacob.pan@linux.microsoft.com>
 <ajGvfqjkZ3I1E-hA@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajGvfqjkZ3I1E-hA@google.com>
X-ClientProxiedBy: YT4P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 69411748-77ed-42a0-82f0-08decc04bf7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5yKOXp5L5xXsZpA91guL9sM/XKTBPz04Y/1MTT8g2sJcuXN4+BB51z7Wi5+tFXdxFFIHxo3SQiUJDEBvW9kqE29AFoDK2r7Ul1a81H188hL8JiHSVa5h8RbEWqRmYrgYzb2hCalrx5ZEb4FLxHcsyvpxCnoPziN73CcAgwk7c+tGJBN09DkhmUahgPQnkB27zkcRJPk6/d5tVQM4gfUHof2gGzyyVmJZXJBSNwl5VhVBz5QLeUlBhm36aI7xXKTyboH2rtGKLetkl+gwBkOvnu3LMzq2LN0NzQSrSN2JjBaOtj+/mfpZNS+TydzoeGZ3sqTKsx7TMipKPxCmyiG5QUi1iJbtDwDDWipYc0ZwU4So7u77HMSyI1ZEP29HykBlqI8eMWURSEUcsPMqiPLxqmCGvsCcUdQqCYaDp3qzxNEvN+zSkn8bLQPw1+keg8FrlLqCoIYRo6swneIT6cuaIA6EgQUkcSHGIgK253GlHFyHD08jjBMwAXmVwTqbzNy+EQlsJU8UqrQBuf2cCjqFp0KV+smWUoAg5pw1cYcOHb7cCbX+6V9TQT92XPOG5oV1Gex+g/igwI9YnFshnof2UowEwLEqyTG46yI72c2vDxev3UlOUMLc+JTHM/zqISxmNFy6O9Z8OP7mPdf9Ksf8g+w5axKwAy38giesst6SGv5RAql+QrxvYSxxvJzCwn2B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6pEVXJmTTSSF5Dy58m0rQOtXif4LOERIvvWpg9wPO+zU8IJZ2KyCTSkb+c5?=
 =?us-ascii?Q?lVKi7XMDxUROf/TTWsmNcAtKn80XeeDbxgGOLMtXEuVdDFAANIYuHVf3d0O/?=
 =?us-ascii?Q?9ad3lxwk6fo7g7YcRz6J2YLk0AoWZ+GV+aPC3/weNoDLQftThEnllpd3A6mH?=
 =?us-ascii?Q?KUPBZ8dtDjLGGBTS/IhdUUzJg9eYkDy8i5Ek57OKFKTBxr/izmcd5p8vKhWu?=
 =?us-ascii?Q?7NtCvQxEsuwzYO+y8eH3snW8UB+NpnlnQyzZRu4d5u1GE9PNDMX7mR6T4WLc?=
 =?us-ascii?Q?hpZmoAaTAhHgoWblX8EZ+hkSFnxZuQCnyuZGepEAOyBqA48jtk5ARq89JfYe?=
 =?us-ascii?Q?FhcM/wk9c5a2mKDzm7tscO+NDhYArUUMQGkrf4lQKKkCfHFT6ox0pHbGESE1?=
 =?us-ascii?Q?QXnwMyqMU87L0eYqhn1ueMqIzAO3LC2W17wICAud8I4ZHf9nEVqZfsSv2a/Z?=
 =?us-ascii?Q?ZARXcO3Vf/2R1aOX70n9ZYH5IoWd0s1yjJYkSPsid6dykkZ98Kp7UXeZIiSl?=
 =?us-ascii?Q?fg7tt/8cqa5i5T2LAYHoOyvuD9o5iltvk9WNhbyALdgFbyrEi2pP4rvI1loV?=
 =?us-ascii?Q?l6xN5I9MoV/k385Pxpu6jfJwHUzLD7CMrePzOrX5PDxa/XKyw5XXRQUVrNwB?=
 =?us-ascii?Q?lNzG8O8hzACcHTHhKVKIJq0Oy9mDTR5fe3qM6zlcLvfhV2nLsSZxH9VPWX1o?=
 =?us-ascii?Q?DZjjAWHlUJJiSY6F1y+sUgwGeeqzuy3PA1ayfNKUhon9aK68n/Z/jXS44x2Q?=
 =?us-ascii?Q?L7iKYJfOOxnqYuwj6bnQ5UfvPIxF1otJDbNq7Mf41ydwI8LYkH6Q+q2AoTp4?=
 =?us-ascii?Q?B294fpdODFxqWoI7YWPNn41mNKzK/h1v0gavXpxH1OW8UfF3Hh1T+o6Z6PZP?=
 =?us-ascii?Q?B3r1b4VrAyDrItDfEsMtQLcoEwabSwLHpbc3mEewbLCyPz5hWbXx6yuBxml4?=
 =?us-ascii?Q?/GZ5yeZ+vzeRAx8T0iKOpNrAXpJamS18AfbY1of13vBkgxkEkgS8/iNrBfzy?=
 =?us-ascii?Q?dIYVCGKe90ns1g5qtk2LSZGR/RUqlO4sbC5T4swmw5L9aSTNxbzlruBWCPmK?=
 =?us-ascii?Q?/89nEdEy0otKivMSbTY4A+aUKPHUHcv5LRAA9Qoimy1qRwCZDNsUygy3PKP8?=
 =?us-ascii?Q?gKi2/No31bQ3jwyRQNPa7JSOeoDErbzwPMketiTZGbi4NoBX2MiemF3g9j0b?=
 =?us-ascii?Q?FTR4lNmQ9SVAGxf6SliabiA0VdSXS6BeWS2iMdS9EmkqXZJUtKyciDyfPSEx?=
 =?us-ascii?Q?1J+KjMmCAsktWD43CFVlk0OvptLN50Qk+aals6fqpjI3NUklHFehdCcRGoze?=
 =?us-ascii?Q?uOqfgxsbd3GaB1zwxy6mHRIBTKq3i5eUw2XAZtaNL4ng6FkTLDPHB6h34GAI?=
 =?us-ascii?Q?KRx5zD7W6q9aji7qssiUZNMa/NO2i/bKZzuTffbXV252qTos1qb6ePRn24Cc?=
 =?us-ascii?Q?tngUYdj4NnG6eeHCQYipJ6nNYqOd69TFIcA6btuoRDPVo+zAKLW9x+xl+TRe?=
 =?us-ascii?Q?sgaO0AiPKSb0bh5XUFqvV+QNjc8l9O9DyVl9CEwZJoeqUz6yr2Ozkal1Z1U0?=
 =?us-ascii?Q?i0UBJuHr8LDTyRTD/o2atDI8UEGboJ0G2bmVeZUXDxliF7y8ckIMNsHRsVTx?=
 =?us-ascii?Q?7Wh/t+Q66PwYttA1BQCb/hVb6iX3dBPdXOkY+5BjTYXCZrY/LazhtMQSJlY8?=
 =?us-ascii?Q?6d9lJoJIRPVVQz30VIHdG5Nm2N3U6z6V1yL8kjLyApJP17Jn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69411748-77ed-42a0-82f0-08decc04bf7d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 00:09:49.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9PvtzRaQ8BBbcZWyt9jam6Ca9Ss8Mv0mXErbNLwZ4hYT6f3xIGGHKPcjDpiPfqM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448

On Tue, Jun 16, 2026 at 08:18:06PM +0000, Pranjal Shrivastava wrote:
> > diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> > index 455bac0351f2..6c3bea83631b 100644
> > --- a/drivers/iommu/iommufd/Kconfig
> > +++ b/drivers/iommu/iommufd/Kconfig
> > @@ -16,6 +16,18 @@ config IOMMUFD
> >  	  If you don't know what to do here, say N.
> >  
> >  if IOMMUFD
> > +config IOMMUFD_NOIOMMU
> > +	bool
> > +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
> 
> Nit: Should we explicitly depend on 64BIT here?
> I see further in the patch we assume 64-bit addresses:
> 
> +	cfg.common.hw_max_vasz_lg2 = 64;
> +	cfg.common.hw_max_oasz_lg2 = 52;

That will work fine on 32 bit, it is how all the drivers are being setup.

Jason
