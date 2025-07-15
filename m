Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759201A23AF
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585585; cv=fail; b=WEjQKPYXQm3PvHVDOkcyAfEXI+wP4PWu1P2uhRUgEKGeshTPt1ZYPk1d4EoT8Gq7aY7211FmmXUgzlbe/v4FCRBlPMSgFrPlM3Cw6Iq1HCzj292j61e/WGRrD1nwHK+BIgWFJ1Ajymh7Zg/Dngwad5vaNlxojTsSzSMszS/bGE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585585; c=relaxed/simple;
	bh=T+Ziw4VAUXme3tnOsEpAHulDs/I2i/SBr8CbBRN/e6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p37fan90YkybbS9mqdelsctJZqLYx85O5DEkVcOmVfqWjMzjf6dPfUiEyGUwnm0YjN7cTFO2tiM3wBcoHOO3MsWiYZ07o1Lu1/lqc6DhbVli+cqDdrjpsU89Z3pGchkO7jwVzK9XL+jDTZmgPSNJCggjmvB/wvBbo68ryvibi+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qVnrp/y4; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qVnrp/y4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKBd+vsNoUjQuTwSrMil1XSh9/YYWhve0I1ia/3TFqoNMCI/5P8ibpy1LA/Q30CDRR4ZGnK+Q8f8gSB3X31U0pTd7P47TZY8mXQRRXNlDnU6vH/fhyQXdNXbWtXZkF+rDPfz12qokxRydSVBgkmrR7KKnnhTluzrKH2bn6rgCcjDUqEXJFK5ahf+7hs2UjUIsPZION9j3lhnevW+2mk8lr9mQq0OCs1XAiJXri0dPDZkzM6T2Wg3GWB3Gp8QjI8fae/lakW0jX+fh15OTEvaAGS+6oKdp1Wob65GvHW5j2L0j9zIZYasMvekbSnoq28If1SH3Fp96/5G0Mc6YEbXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poqz7mwFcwZ4+5jqvTQlxtdx9ekEotiNuZVeJ3m3j24=;
 b=uBvwOAfgAexb46vzECLyvn61LnafB5CieXFMjZUtul2/tksQBXt7TgJJwGm88fMyLjdtsbIajP/yb5gBZt4QDt27xki3QpmU2VPfErAiqfBfzJYUoGD8sBZtrVqw8OLfo7EM4/UVMTHHM+oAASZFDoeIhSiAVq1LG+HEax/LiKbvHGtdPlNjq1ht0iEeDZpN3Fss3sCXyUaimqYGD2tLv4vnvuAm2XbmNl1jgT8t+pmo1SoJ3FstiOKruJLBgEKikEr5Yv3noHHObEIqOHF1Y4PSgnVN1AOFyIn1BGEBLPDPyxBNlkUzAg//VqSejxPl/xjsL6Ph5rwNrhZDY11K5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poqz7mwFcwZ4+5jqvTQlxtdx9ekEotiNuZVeJ3m3j24=;
 b=qVnrp/y4lnznC5p4Ay2cq4j3/faXKvv6m8jMGO6A7dIWpdKAbmAs2CIzyRTp9tI5R40EpINi9y9FUPjBlcBpPEwgzjJW7TAtJUawyooRvoWd7XQWwonk87PZfpelizfvAa0uRyZaWaSVXc6qYz0l24fQYKsblcloE86+YKtUA6UwsD8InNzuL6cxFLTqudEbvaMBUD9mjMiH+2JyIVz8uScZ3jlg4AoNOcot+tD/9Agu0OlxE6cONpUxrcFcncV4v8V59ZjKJTiBjC2PXKZD9ml2RkzassXhlmtAXZsS+AkizcHzl3jVnMhcAK7vCbYbtDykzbPaPUo14gvpi+gKsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:19:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 13:19:41 +0000
Date: Tue, 15 Jul 2025 10:19:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 3/8] iommufd: Add a pre_destroy() op for objects
Message-ID: <20250715131939.GN2067380@nvidia.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-4-yilun.xu@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: c8efc0c2-69d1-4821-b431-08ddc3a24195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IGjErx9JTwX6jtwO/Ji4GEq3Xrt3isg8ia4WM09YDqbQ8E+6Cp/brY0J7tfI?=
 =?us-ascii?Q?JUOYKnB8lywaKFfoLIETnXwQeWXb76zPvk0aFTQybmb5fbVFR2+BpYAVjJOB?=
 =?us-ascii?Q?oKkVeWPxhgtsYatgmvc8JATnJK8DWkM1ms2yN7Y/8L8EQ5W5KoHn0GJAfRPm?=
 =?us-ascii?Q?U1Nnn0TJPJdQu6iLuGIqZhwixaJBsEQiNfHtBGEkKUmsVof6GFj32j8Lp7B7?=
 =?us-ascii?Q?8vsUWTBdhJsTVjxtj3Nfwp6l9+Fd952NUeSuB1SfOaHU33B3avcHrdclL4oi?=
 =?us-ascii?Q?iNlPaOnlKFv83eSHRWGIcrl3N4VwiF0KrOLfz52nAeFmgFGGoTr7KrUPYvfL?=
 =?us-ascii?Q?vh6eKbDNphoqPRIdRJKkElUYEkWYIADU98UvqgxqtdciiXZYGHNIkP3qjsQf?=
 =?us-ascii?Q?wF2KOA8D1uIVvjU5vYUZCPHzttXMv4LQmuodVF29xDNAswSENgbeYOFahK2a?=
 =?us-ascii?Q?pDvpDvYMBtlYq6mX+wnKLM9dKbQe7SiAml3GXXYHo9MTQVk/FYXXnOkbq8oU?=
 =?us-ascii?Q?7vMuipAqzM/XJHCRjkmPTIwNZvWze28sn3BnqZqWGlVFgVDJAirIaS/udq+7?=
 =?us-ascii?Q?oVpA7xtT0r047q6iO8ZxrJZuCZF2FGg6SwfO10hUTX2UVrvwsWhIHYBCVnh+?=
 =?us-ascii?Q?bez11BNiuH10CYX6ZNg7QX0KW4G5ozfF/JrasUtoz86iwVt44C5DoSKnT9Vg?=
 =?us-ascii?Q?+AIHbXkk0sBMLhuQBoSldxMrY167p7hy2pCdIE8gTQA721xQBAZRdnK4CHdP?=
 =?us-ascii?Q?FNQ9BhGyw6Cajq/2PfUGoBYs09pHJ8Igp25fZVyyWWezfDqfwaEPGJldCFfh?=
 =?us-ascii?Q?8wneXez8ulHEX9u5rEOx8ohf4f2sLD4zeVQvsWW5/SZM4qBUcZw7R1uj7JgC?=
 =?us-ascii?Q?W2Q0HLsw24Y0UOUn9aSOSyosPWZNpsBgVQN7YJgcmhTXKoYz5e0lf7HpIrQ0?=
 =?us-ascii?Q?xRQpom713LVdBExjWaTvEoa3nuOY7k1KfHX0kMcFzeH1qSAfkt8N1y4q/qCi?=
 =?us-ascii?Q?21RKdkfKalK2UNrhfcjydgzVrf0LsWO149IZysQtnf8GEK8rvbVdK5SfJBOn?=
 =?us-ascii?Q?di6RuLMHCH+Mwks4nKlY9g0heQDbdr0MlysVXolFIPR5P9ID1sq7cx/6GX1/?=
 =?us-ascii?Q?v6OfkuYGH3+rdPHdJ8ZJcu3gIrpvy0WfJP6jEY/RCqhLCpKdxByqfWrfQ6r6?=
 =?us-ascii?Q?M6OfO6w9COfdF5MZSbz3mmmjlE1JRF58OV2ueeJ7jTqE8AtjWPRvYB9tXxcA?=
 =?us-ascii?Q?FaL9k8jPonvfDR/3IDLBubg77s2gFQeRxEmYEvFouNmw6CU4qsO3mEjekHZ1?=
 =?us-ascii?Q?5srmAYryMMVLcmBX+6nrO+dvkCdAVwXU2qJaserpEUx4qhRIfA46iG8CxkK2?=
 =?us-ascii?Q?9YCvPhFnaIJo7QAUBqeE4dX4LmpbetpksOYX82icqkIf9kl1BvKeT9ZXc/t9?=
 =?us-ascii?Q?OhtL2EBJaok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZErArTiM2pZ7hmK1dnMvJgUdnAgYizaB7a3RDzPvXZGgfTU1/HahxLqUMdw6?=
 =?us-ascii?Q?qhYmUKKTZ9nLNoS60cWWpAvBm+jQYo9rafVCV3xrlA5/4DX2+JNfs6eikZKh?=
 =?us-ascii?Q?qqI+jb9n0kcHDVzJOhujWw0x3WxMFGJqMN2/S3/HNHC/WVLcE4+DulGXXXnc?=
 =?us-ascii?Q?zWwuSHNLL4q+3rZIgC2IisPQjkLD5FeFN/V4D+57ANafTjP+WWpJSdeaFMA4?=
 =?us-ascii?Q?8L0b3p9VfpGvrEkTT0Ta2GUFBYs9PGTprZXmp6CvcHU5vUghay/IvrhtUnGv?=
 =?us-ascii?Q?qysgmPqhzf7E1HbUDWiZJpAvcwSpc9O+DNc5A+MCY90wnUCqzh489xKyCB3+?=
 =?us-ascii?Q?H076Zlrk4u/626sDupN8nrB7B+7rDDrHxZQPWRW355/Fhu4MOpDbw25jKmfk?=
 =?us-ascii?Q?6+SBi7luQLtjYR6IeDQqIeNy0qH/6q7j8QW1i49lL2wpuqom3A2mhRiEqAvj?=
 =?us-ascii?Q?ncrElX+U/riOwmFNBCNIHUFqiZbY/Wx6J0B+7tINwtfDMnE7iaDAzn3KBSWn?=
 =?us-ascii?Q?Tt5Krj4CJJw/FPY93amlzamFpw2w11hcxQ0uw0KtQS6LG9BihkBHSwqvsHsj?=
 =?us-ascii?Q?ZfiYK2dnFhEvWYkXDY0sZaCMjkSoFdd4Vd6HxAwcqmlY2TaJWtEJcRr/Giky?=
 =?us-ascii?Q?J4z1ReYjQjdPTdFOVtbVy/u2BhAdwKv6eLi6pLkfLAc9kMYiwxAeQ3EBldCT?=
 =?us-ascii?Q?DodfVZGi/jumfTQsWV8ETEg0KfLtY2cg0d7qDD1zjXfa/Eo7r/8fBDpWHNxf?=
 =?us-ascii?Q?e/m9Qgl+kJ38JicFik+NvQXgq7Ih0TxrJ6fvlGltSGJMV+rPDLcYI/bnBLvt?=
 =?us-ascii?Q?zqrCTQsgqSIERsVZMQXI7DaC49fl3zeVkRoVcJHXpmNfehjufchL0uXUUfSt?=
 =?us-ascii?Q?DPq4m9BjKgPXow8n+M0rggNCbkMx07vCLylwlvmHw0Mnj02w8KJ2kAjBiQxk?=
 =?us-ascii?Q?Qx9xJVr8NloPsJVilEjeyk+7+trKPAhA0zzlZutALUQMwUQe4s1wTIwU4rVt?=
 =?us-ascii?Q?tt/hg8LpY0hic8iP4scvakWC0jHHPy4BwgO8rwVBO/txSjFz9ThjTS8R0oDX?=
 =?us-ascii?Q?FNNOdUyB2ZykOqJc9Xf9UO4XBpOIkLreyQNQXQQBrpiTRNa3+i1WjV7GS9HD?=
 =?us-ascii?Q?2CJDptpejWtf7sxjDRVrfQedxO+cz133CLNF9GB9Cjx10KqVdAj7qni7YMAy?=
 =?us-ascii?Q?tW0VXCruPkBo5tQp5516nAM6sdc2yAYM9i0zFNqEmAqNYyWIRKlT3NS6KYYT?=
 =?us-ascii?Q?LFvO5CzwU9M6Rs4MkCkiPUgbhCSY5oU5xtC8Axl3hKLy4jjCB0L7q/SLGOn/?=
 =?us-ascii?Q?RHukwCwNTBTdtLTPUpEIUSt9i/i0e7JYPm15YqYhpS6lx9d1OpT+jo0quR8N?=
 =?us-ascii?Q?iE5oBWcrjf+e2KUiGNRAzvhA83oE5nzA1iSTyLQehk05oCJGCcUlQV9727IQ?=
 =?us-ascii?Q?bVlay2qQDmMaP78grAbT7atp6Xa4zu0wEadY1E0tf3UedENrMJC5amOT4lnP?=
 =?us-ascii?Q?IF574JtvzrTqCG5dKAptcJbHYhZ0ckDoJqiT0OL/JvOqlZXJPJ5AqtYjgPDi?=
 =?us-ascii?Q?phdhByLiswEgu9hUjsb37jwKkst2mJfkSF264IAJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8efc0c2-69d1-4821-b431-08ddc3a24195
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:19:41.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z5AGanSUboTd8zQjgv9LML80KNidCIjMVzvuo1GyouUbMTQfArU8xkBGPSYRrEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

On Tue, Jul 15, 2025 at 02:32:40PM +0800, Xu Yilun wrote:
> Add a pre_destroy() op which gives objects a chance to clear their
> short term users references before destruction. This op is intended for
> external driver created objects (e.g. idev) which does deterministic
> destruction.
> 
> In order to manage the lifecycle of interrelated objects as well as the
> deterministic destruction (e.g. vdev can't outlive idev, and idev
> destruction can't fail), short term users references are allowed to
> live out of an ioctl execution. An immediate use case is, vdev holds
> idev's short term user reference until vdev destruction completes, idev
> leverages existing wait_shortterm mechanism to ensure it is destroyed
> after vdev.
> 
> This extended usage makes the referenced object unable to just wait for
> its reference gone. It needs to actively trigger the reference removal,
> as well as prevent new references before wait. Should implement these
> work in pre_destroy().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  struct iommufd_object_ops {
> +	void (*pre_destroy)(struct iommufd_object *obj);

I would capture the key points of the commit message in a comment
right here though..

Jason
