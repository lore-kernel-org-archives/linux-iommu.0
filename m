Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEBA426407
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434720; cv=fail; b=YqU62AGNfwSrvMi9e9tj3UC2IlkaVUM8TY3cMYQj09BWbhsxGB7ULyk5KySHKrwoCGi8DBEnhHjAivivzwDvDAmKGkDZ4xO6SKNHYzzMO4N5/gFb///+aBzH1nGYPEtx5kzis/67BWPR3F+CWz7gegcsW6nQlWp6/KsrO7gI5oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434720; c=relaxed/simple;
	bh=rYIP/PHF3Wu8B755Q1sLoEfxPXv36BE5Rm7l6u/9exw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nsFX2AfL+v+e7jzwcq/c5qp467dU2UDAH4qKCdfDNki0O/hxvjUSxCiGo63P1gG1lN8Th+AdMeeSEritnqODBk87QKU5+BVReKh726zvpHO98cg/IVZD+45vWfRcAec5Hivx5AK3F3cabk/0Eo7LassORv0nVX6EcfeLVqmBij0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FEjuUuYd; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FEjuUuYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txLJ9mODdBgAe82TO13qRRcd4gVdPxEvpDRqR02C3sd5zObes5lH+rC8WXvU2tvP4bBaxZA7wthmgYizif6MclEMH8rJszMJ+eA7qqWPC9LWurA9QsmoqMZY/5cqDq+Xv5XnNoEDiZ4SaWN6UXtBpbqQMAEwX7pi68XntQfuEmcL496JVR9mjEQRc12eOBWbVdVti+7Dqd3oy2Btel0xNKdgsTgPdiQiAja9H2H2T5ywxgPirzTV6pcfsd6aw6AZ3HE/EdN+n4K4X2NvD5Miayd5U+dTpFh9UJsE8kfYVf9ljYQOte/owbOZ2CdFEaaaASxPVINraXMmnfoFwdmPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oxvFzLN/2inHZPWZ2Q399GN3sCs5hYTF9r/vfcJKJs=;
 b=iBi5gVvasdzef8Y44lJ+bGHQEieVO62sFnG2RI9+uXKJBkajPzZXgFlIU6AZO76pWKlcd5DQuBG1otO3QIZ1d0CX2eESFZmqnGhe84HgcbODfs47HRq26cqAW3kc0qIY1BfpJEKHDaUoOwnghG3nurJqfFGHLBC9UZx/6y1XMNYB/5amoLC4nwEJinZ0cnU88mcRQ80QzOkBBEd3OFNMV2cp/s7OpeMuOWkuPaX/JLHAvabHwE4Go3wd85+fjSi2uMQgg6Sg9QLS9246Q9buado61Bu7raX072jmjIGhCOT/n5ftpymRfuYRvF9P8WFaSnqGfKHw7NP/jJW9btPm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oxvFzLN/2inHZPWZ2Q399GN3sCs5hYTF9r/vfcJKJs=;
 b=FEjuUuYd42DHTRSQvsg4TmpTArQrFVzZW+hZiFd9KSEkuKCOEvY0TtWx7h2ycyABw1jkZmBrW3p87Ki/wMhPHlK/ZBDKQvzU+WvckR63KaDyVC4Cz8Fk4c6/fkikEtVV6nizf7FN9E07a00HcTCgEY0qo+EJE5TOqHOuPpXMpUfOS4Q9jNHmQT7wLADRglGN0+GIU3mAMti2nEha4iORCqLnBflzPri4nysh5jXKsdFlY2G1+9VFVUJDcPkRPbwnWSl1MWs65vNdohJ6DPGzVg4vcU7xxic06oan/cQQZm6nPUHVOV3T5Kwx4E+3JZK8GsIXkqbF1ovmrjPL8wC2Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:31:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:31:50 +0000
Date: Tue, 7 Jul 2026 11:31:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 16/22] iommu/amd: Introduce IOMMUFD vDevice support
 for AMD
Message-ID: <20260707143148.GD220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-17-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-17-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:408:112::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d1ab76-f255-4cde-ab9f-08dedc347b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	A32VjiAVfcj0CUm8e2SKqAq4KPj3f/Hw2A6L0GUiwcs1grrZ3kPjS4Tm7KLu5n6t2DrfP9vvEZqrXLwaIvwV8uQH+2JB/SkqhjgunLKqbHfT4pNgvk1m56+FfM8zwsPiK5Wf6IV2OcKi5nmVo4rMo6BGpt3PfLqK4KMOHAXT9kha/DUxXaq1kX3kogP491AnphyP2hCtxT8MAU1u7mpr6pq6wXMQHyU55VVukEUoJvde9GiBfBhx3DVQAPUlTCTBFl0Kb0UhSUzyQhQm3J9/j5fDURWD0B1B0SBwqMJf5f1vbNTpWxJvzgnPSC3WqE20rbHqPia3M+SoMX03N/acnOrH+KRyZL5g5V0ONIWAIfMQJjq2tD70XjOO1fPD7BF15FgnvK8FCOTYqDo2rOCxXO7At8MqBY1gVxqRPqoNk1FcysgcacZTi3UvEbzK1pYr+MngTi+3X3SPCNf6zMRLsYm2eMxER4d0O30MVcDWjxuI65NN2k7gKsNcZzvgd0lY+MFUmxcBjcWB8LNeoskQZokc2W4mLsuZloS6zVV+oEi4K8CWQM8SEGpleIThpks3t2PHVS8AUh0vxvf5zp0nrUIzNScD9aIIEQKgY/SOu4P+vDitTSukOO/l/d6FhzI+huKTRHxfGK9WAANt7lONMR3OyB5RmUi7r+Nkc0XfAJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H8t7Fr56PH20t/MP/pnoelTAPuH5etdR6vNtRD161ZyYRBRPHfMLP5HbKBEA?=
 =?us-ascii?Q?ZA3DYgyuqxB9C+In6IesOg0tkw1XAyXXJP3PdvqKdveahb/CLVMbU1KZYqPL?=
 =?us-ascii?Q?ZKjCLwQYiF5NQewd1Cm2nm4fxID9NUnGYzjWXvQVwdGbRCM17QBR4fwW+dZA?=
 =?us-ascii?Q?ahRbZSsQgnqGVaM2eKXEk/3s92bBDCoZhjqGUj0HR9FalObZf+eQfEhiB+Fs?=
 =?us-ascii?Q?GQozkk1bKP47/Va494cbZpR136RDAcrm+QUswL+yBQfQ6HzhFlVdWtAO4oFf?=
 =?us-ascii?Q?Kgdr1X4gt25qymYc7uuEK8XtdzEVOhqIL3jbHMhFqvLtcW9CL0qMgMIqbu/d?=
 =?us-ascii?Q?0kIODFPW2zSffVhjRrDqRClx14vUEouLS4OkxnSifNSH3E8fPLazj/lNoRf5?=
 =?us-ascii?Q?+bKdQpuL308YrmmH6H2RyL+cdKrkjGYDRw39crotqVbnvFvEbooZ4G/Oc+0r?=
 =?us-ascii?Q?4naWHYFStDoxzt03SxwhsXaGvqjOdL7spSBKgGdM8m/7fobANHKYlF27RW4W?=
 =?us-ascii?Q?w9hdMvkaV6VcUYoqpNoB0QWImp9TTVrFHNGK9XT37gd/6NsPPmwHAQpj+lLc?=
 =?us-ascii?Q?b/UAd5o2vBgzHpjlljM+MpsOFdqxtmBOZM0njhbW4xcEUu8JGf/9V8ysJajH?=
 =?us-ascii?Q?btlmjA6VbtL0vQ0xGrMEVGgq+RNCN1smP7xeqsFMOWTG4C8y9y6PFSIClPu3?=
 =?us-ascii?Q?Yz3ZFafzMb/HqJ4JXPDuxON/IWW86JPGNzAsMZ4K2Yf0rHM26j9IHvFkfgOW?=
 =?us-ascii?Q?CXJiRHUJ0I1n/rYtojDPErmvAgcV3KbtYvMm7DuVY7SYDHkhDHCTJIEndFzC?=
 =?us-ascii?Q?ppwUcDUm+DQ8xsSgcLjmlakKXawLR614XhlJ4/lU6I68O7IbXiUKCffDaj2K?=
 =?us-ascii?Q?Vh0lCeWe/CgC5nIks8V76QPkJbMYGQtQvGCUVDmF5th+6eV/jvPJ+P+0nh/+?=
 =?us-ascii?Q?k6MQ4aCvvjice2MN/2J19q+YxUq9QsVc9Ryf8W4QbMm3qllDaBUZKFVs21S3?=
 =?us-ascii?Q?36phk0ej2hNSB+kLeEvm7JSCCYpvUT9bWVJlf0erirbY7ddhGw5D3J9CAhUV?=
 =?us-ascii?Q?xpXXccr1/xWCRqPvNrIG/o3PZVEEhX0l9qLw5OEVpXjCSM6qwtFo8j3fUxsU?=
 =?us-ascii?Q?1HFB6IVQEgtiGCP9sYWfGK5fVmvu0xf8VFwD4rjbD61wC3HSKLgx1tQISVLa?=
 =?us-ascii?Q?gzSwSHc8fEZ+ibHZr23G2psHGvBvFU0HIu5gkoO1UwhSDsJYt3fky3tDW/qA?=
 =?us-ascii?Q?5q7xR+/SRpdHJ8LjE6qjp89UjtjKQEdB7w7bCAP6W9qag75j2qNPL7pdiRkW?=
 =?us-ascii?Q?kACwyPWkl5gHAM1rbo43CI9KTgc9a1Fek4fDaK3HzkMSZ8EBMcVwCOyZZTOu?=
 =?us-ascii?Q?hvCkkKJnpdhXms69jqNRkExM2kdJpQST4RyoIr098Rdd35ro59LG+1qNHvCH?=
 =?us-ascii?Q?4zX9+U+YemOPVCbcGCL443862ny780CxMMy7eIRbijzUVHQxqrp/nJXvqdtQ?=
 =?us-ascii?Q?Eyj9FWGFk2tRU5DX1DaiURfAO917LJqadITfj8EuUXtySOLg+4lFlI9/nmCZ?=
 =?us-ascii?Q?XhOKamAKxvcWwdV8r/1xHJpXSPoIhLXPJPmFc4zDX5wh0+qB5+uSaOOgJPoG?=
 =?us-ascii?Q?+3aaw/6fLrGhyLRpdgGZYgOi/N2DmnnUe9/0m2n8YLUuZKIVW8YSQXbTw+GN?=
 =?us-ascii?Q?x5eltecJQq9quoMQUGfiAiR9GnmTB5qjNicT1lk25/2YjxcK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d1ab76-f255-4cde-ab9f-08dedc347b3c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:31:50.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeoG4IvOl60PvIXT+/+C05c5usjzX0s/GITkOJorLtW6QzUkugdTKeQmX5w2Orxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

On Mon, Jun 29, 2026 at 03:35:29PM +0000, Suravee Suthikulpanit wrote:
> @@ -388,6 +388,11 @@
>  #define DTE_GPT_LEVEL_SHIFT	54
>  #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
>  
> +/* vIOMMU bit fields */
> +#define DTE_VIOMMU_EN_SHIFT		15
> +#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
> +#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
> +
>  #define GCR3_VALID		0x01ULL
>  
>  /* DTE[128:179] | DTE[184:191] */
> @@ -895,6 +900,9 @@ struct iommu_dev_data {
>  	bool defer_attach;
>  
>  	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
> +
> +	u16 gid;			/* Guest ID */
> +	u16 gDevId;			/* Guest Device ID */
>  };

?

I don't expect this information to ever be stored in a dev_data? why
is it needed here? You should be able to reach the viommu from any
places that would need it.

> @@ -227,6 +227,18 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
>  
>  	/* Guest paging mode */
>  	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
> +
> +	/* vImuEn */
> +	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
> +
> +	/* GDeviceID */
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK,
> +				   dev_data->gDevId);
> +
> +	/* GuestID */
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK,
> +				   dev_data->gid);
> +
>  }

Like here, the iommu_domain should have a path to the viommu if it is
in fact a viommu based nested domain, and only in that case should the
DTE gain the gid/gdevid.

Jason
