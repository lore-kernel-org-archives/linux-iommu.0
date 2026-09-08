Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E33A5449;
	Tue,  8 Sep 2026 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908139; cv=fail; b=jEEm1Tb5z+QRd2FdWrIK5a6lQYBQHL95/zAM5jx/6Evp+pDO6eo6noJgjLZ65155EOG2NjhwsSM03CYStO4KcP+RlfMCqlhsSq6QWqv6jQ0PXMJxudmwjOaYGonm1snehim7bWMrv/GCoEhLY2h/jEGg6nwQGbKsaUXavXFNltE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908139; c=relaxed/simple;
	bh=nqowp5NIoXXkwUk530wtOwlV8iwoXb5n0FlSNIih7bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFwdUfpEaB+iCOlVEeJs4kBpB17FDIA9+PTfM1mhOvktpD+ctKp8nTOS5jCplJ0Xrytnf8Zc14Ifi0tyjt6A/MDfgRJiy24fMECZduVrkBoXG+Gvc3xuhutijAmWLN/sRz23xEm3BIeoFbZENzs3np7aNDAU4y0oGZKunZ+KdLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0AUJkB8; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0AUJkB8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syV/DDqM4IChDItVs+UOmcftrx+NAnoFfOXQnTptuXtdtwtCBy/dAnLKP+ATjNvxG/DCoRMR2Xq2tezo9tiRI3boMxZJ5WyRXsL7H4rpDh68ddivvQfNVh8JQ+jKJmFK6UJgg/u444Pw7nhgUfElNTyOCtnECh5P+jqXURQEWI51cAbrkejVvpur2iWbwZxaX+LE4w7crqozhl8NQC448TMWJkldNqMtTT0mIn3w+ieRwhSTACVzXm1bYgbmnupU54QJtKSgV7MK+Y0QRqB65ThCvtp+PkAYj3MGe4xtOcnXQTFGQpFL/EyIorkHepZN3/P2frmq/95fCUXNNZRMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW9cBw+Km9TQxV23acpsXgx7qKC2O7bLEhjojxcjEoQ=;
 b=mV5ixwCDdYy5KCCqlGt+uwCatEex1FfZ+XAEtaQfU0js9RUyqK0SCu0a2ee8x6bWz1C9CYh9xR7KGEWw52Ef7x41u/EDKe6XXps8Ta3GNyi0j/e5fgFMVMTBXdvR2G+/x6o+chKvjrq8KvxCxLN6yzJnKxJQWrWwnPI1O7WjYE8nrDOU3zhMkoaeyyizDYvA7zowUN8fBMHE2e3k/l1fQQaZN3AS/ebw/X0NwaQ84X3+ogktUpHFjDBRfPz19gpXgCYFAmyBhGbcLwQA9mfy14HQ36c61d3ni1YeKKlzo7KjGqeFMr+5YA50S9k4iDGn2a/1Gz0ORn3gHxojV/7SBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW9cBw+Km9TQxV23acpsXgx7qKC2O7bLEhjojxcjEoQ=;
 b=a0AUJkB8BNIWDLhb7DXFRChJJzGv/G4pHpAarMkLyKwnAWO83U7AcZbdmefZ0KCYXDt3PS1VvIt1+A/NOxb/1ZYn/zArqjx6akHLIkdKpV0UAQ6H5Tnwx1oZexgEXX9pLXAMvXutxlEBam1JbrLnvS9e1gkBL1glw5iRIV+ZWX5l+mHAtQbj3KaVLmb0ILz7lPUDDJa8ShTNojlY/AfNRyAkBU4JjV4y8ic6pw1AzedRSlgpdLSHIR16zVnXIJjHSGpW3miA1VUR+7oabNIWelDcJSxeCJe2vpyR9waWlN1UCwfEJ83dAqFTuAripIY8jBOqiCxFCG3T+V44CNCJng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 22:55:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 22:55:32 +0000
Date: Tue, 8 Sep 2026 19:55:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v10 07/15] platform-msi: Introduce
 platform_device_msi_rewrite()
Message-ID: <20260908225531.GD2779763@nvidia.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-8-praan@google.com>
 <87se3j1qgu.ffs@fw13>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87se3j1qgu.ffs@fw13>
X-ClientProxiedBy: YT4PR01CA0502.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 10719f8c-f378-4c72-1bcc-08df0dfc498e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mE6T+Kvyd1zKdaOAuenwCz4Qw8iUWOyQ89+1BAfNvX7c60PgF/8Jv32H5XcCvdCKZBfjcgixIXDMhZinXfKtW0+mzk/J1eIkkP+Q9a7AYl+bZXuylRKoIgY+fumwLNvN3c94X23cvR19ZQJbWy50dlP17w74yq7kbpKu2jwM1bDZCm66ClX59uvDvCuMWoml0ecpIsQLCBnFrEqGjCLgVq90uQCAc+zAb71a+8puHGTdsoHk6DV5itEQCHZXzrx33DIYDr2PvCC7jkjOFO6Vv4GoR3Me0sYfKTAL6GfE4FAnqFKQR4vKvO+cOn8+v+BN5hPdOiVvfO6FkEG0aDi2KjFz9mw8c3fWYKfMj1UB96j/YQMyT9cULPHuLrjay+dXxMhOY+tDzOS+MFevabi2G5+lSOpVZF32x8iQJVoNRzNwYAm8wM8XCy0omGD1Wd3I1ADju0hQiaSqkkZ4QzW15VavaPw34829Y4wVDuZld1oHTZs15fayB07HOyW3F2TlPTK+AP85aB4xoz7B+Bc/PBGEsghDisz4sa41raV2p/ItUCjEu0ZQBmZqw2nV3m3mz/PtZddfqX+oIEy/Tj5n4muqYdflnMA+spuzhPzpcSWhkiItNJ8BZ4zEef6NkN96MuBwIeq0mwxISwSONIT8FiC2vxT7Andsjs5rBskPhi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4p2my+vb+DcjhO+8vGD82tp4tmOVRLZ59+xJobEQbJsNUm2qguvxWeJbKHt1?=
 =?us-ascii?Q?6kL9FPIakmJilcV8ZkhN3wf8VJCu6Ak6AuGp8JRNNiDTrMJgeDEBLnj2TZnO?=
 =?us-ascii?Q?N/IB4ERAZRiCh7tONvFQPaJF1wG3QVPN4PQLMzuVQZQ3+pq/mTNh8XDar6Jk?=
 =?us-ascii?Q?4FMgwzCcMM7tFNcrg3swXzj0y6V7pwQQur0BTQC1wr6QONMFHE3401iw+wpV?=
 =?us-ascii?Q?9Hmj3cdKvn3eRiJSKMkD5MRV9fKp2Fxchbde9wZTTZwXJwN7Jvhek9T/yKvM?=
 =?us-ascii?Q?xSEX+bwSXW3pGPhuB8G+UzhGMBJqPEouCMyWndPJuqnJM/CYApCLDlLCNgoM?=
 =?us-ascii?Q?GrHDBmBqTi85pV4934xdewznOoC85VsEct0Q9OYlWFy4TBcc0t1IEHTpoZ0D?=
 =?us-ascii?Q?SVZWeKR+Jj+YBz+v8QKBP/P+0YEMGE76oKViasMVmB6vrYTcqgBkDrt5HdjI?=
 =?us-ascii?Q?wKwPUYMJusud37ddZGtF4sav71rgcfCMeRHSnhDDR1kwW7niAbAAlQ/O00LT?=
 =?us-ascii?Q?70JQ0d9EbjHp1XjpJLh3jN8zCW+rm5AOrpSNEfXds5K+CcUPtV8bO9aSGHTM?=
 =?us-ascii?Q?1wmhtyGjgwos9OuLBcmX+9235SrlgF4GlTl5/WUgWdKQu+SQdUqiGgurCl1M?=
 =?us-ascii?Q?hwtNmacrquCfEnVdHbq+hVvQmuAfj7UdIKoJOhcFsST5mZyxg21j5h0biLEA?=
 =?us-ascii?Q?Mzero9V4ktJgnhmwQcj0dr+uGnoToEWPKf70DDhxuOlyvm4i9dNhpgeHdVam?=
 =?us-ascii?Q?Rqk9SO11lgxpFO0pxXtAXhTd+oVgQCj5723vE+cRlA0FNJ8EFoebuhmq1/wm?=
 =?us-ascii?Q?oN1Mkx+JNW0wagz8Hmcelu1vrybSxa1yeWV0j8dAGjYtAL1uRQs3hud+y4nc?=
 =?us-ascii?Q?0aBJ872VUS6QIGLNMPgBQF+u0cE1JrwD7U61LdX6VWwdAQ2SYlGpJR8R6xFt?=
 =?us-ascii?Q?iqzd3CYIFplf7gaLquJGIvwGHHM+X4g8CX2SvfHmaBlXtFgAFL0dMRMsCaiY?=
 =?us-ascii?Q?eUKVJTiW7lHTWC59GzS+4BctbMetDI97wP+daxRDWLsbW7T56S9/ahMO7qMX?=
 =?us-ascii?Q?DfVIf8B1sJ+5sKJdSyhKgrWZFukFLSFkU6wzJwRgpYjQJTokMBzTSUcZq2Ni?=
 =?us-ascii?Q?xj97xgs6jj62fH3WyOxRDod/1HNTxSecNsZyYRWamnb5psqFhevIlW3F9/mq?=
 =?us-ascii?Q?LVoGuOMLd6U6NQ9BEwyB+zDG2Qa1LoQo7Wv9xsoNIRCm/wpEpDCAW7SW7O5s?=
 =?us-ascii?Q?Z+VbKEhyWmTWnvpfjjXEOrokdvcFMqnT4lcoonfxfKGDuJzn6cpLNjgA+Lf0?=
 =?us-ascii?Q?jJQ9TYXIOohmEbsPXuLgcwoUs2mfS7jxIVboZmGVyNdxWZbYn28x4sf6RwtJ?=
 =?us-ascii?Q?F2vlqp14WcN3YfjqJzIAEg19hcx0xWQkwtlVBmitmKjHJtFk5NoJHw4TtK+q?=
 =?us-ascii?Q?UUPpQcP0bltouJiE/2CLZ7LR2Zw9LDd7yKC3A/fboup/1b5ktxKI7EMDT7pe?=
 =?us-ascii?Q?y4Ri28zgSTK+Z7l0hfpSFectuOpqRYtz4pYAfqUurn12z3RQzY46mBCqe9Wy?=
 =?us-ascii?Q?sLoBTdfjYZlyr9pKMuVFEKvWvVI0rUkN2LbLjEOZ0TlSh7hjFjoONuOeBdtq?=
 =?us-ascii?Q?6A3VC+/4rpmU2omgahGq774eXp1XHOMB79v7Ii9Sj5MhSi9sHDKW7BHVx+ks?=
 =?us-ascii?Q?9/0s2Cd8t5+5f0ZyCDivzhg9htSbsYuIi3f9kX55U2AOd6U5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10719f8c-f378-4c72-1bcc-08df0dfc498e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 22:55:32.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag6FPEdWL7gV0dzd6B1DWBmfSnPLa4w5w+E60GOn75E3BW6LN9vb1cv1ACrRkqpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099

On Tue, Sep 08, 2026 at 09:40:49PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 08 2026 at 17:17, Pranjal Shrivastava wrote:
> 
> ...
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason. You really should know better by now :(

I know better enough to have pointed out that an open coded version of
this in a driver should not be open coded in a driver and be made into
proper helper, so you can see it :)

> > +	desc = irq_get_msi_desc(irq);
> > +	if (!desc) {
> > +		dev_err(dev, "Failed to get MSI descriptor for irq %u\n", irq);
> > +		return;
> > +	}
> 
> Doing this without having the underlying interrupt descriptor locked is
> a recipe for an undebuggable disaster waiting to happen. It might be
> "safe" in the context you are calling it but it's absolutely not safe in
> general.

Which is why we are here, I was wondering if the open coded
implementation was even OK..

> @@ -1775,3 +1775,34 @@ bool msi_device_has_isolated_msi(struct
>  	return arch_is_isolated_msi();
>  }
>  EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
> +
> +void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid)
> +{

Wonderful!

Thanks,
Jason
