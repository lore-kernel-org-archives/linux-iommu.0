Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EC13D604
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381503; cv=fail; b=SaAlb6UxgVzuRsGrvQmV65uAvrJnEjfpIiA/sPx/4hSE2o74zIdHLnYSgFHAx2ik9+fJJsdNDTF4FuYAAp8VgQXeK+o5VUeTgI0VZJAhTYZ6LUY+hN5J/ydK7UdVuHUsBVWFKuwt2UprBtcbdp0fTyE3qtGMxsuCOo3gRtVxhoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381503; c=relaxed/simple;
	bh=Ww8hAAw4ythowpxc/IsgruypBQyYe+tnMsY6B3eFbQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XAVJe4OO+Zlg2H7hea51MN6/xdy9XI3mAvh0BbRPzz90eFMMG/GMk6mW9DBs2RXXlcLhSh5iqZuk/85gWtZJU93as7bZskbhx6nTKLFGmy6cBxqpu4RYvCi7ZvoohtnTYeo+dLIrzmOrorIJcWM6/7X3fc5lZcDuQchBs+qx0Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cskbf2S0; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cskbf2S0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI794Ywnd47bs+HN1cOe5onDO0t++PR/ubzkI9Lq5Q5+WcxX5+4pEBvRNnvnAP6lJz8gfUx3XCkFkV+VAToE+5R1aVuG1BIWkSVc3lRsgsRbGs/XV3RxejBE5cCbXR4WbEElL2dKDG3LI/Spvh8aR0B3vHaWXtPP7CxMcS7phkSYROx24rnU3Mqf3TfOlELMcpbQGTjyzpbKL6823zHso/SRKNaJN0ygEE80kcOhRI5FY2yQUDN9DVQ3UlXU3rvMZcZoK4+y4MmEHISMs3IQBZ4RSpqO9tJuUVaN9975miKKMNdKjxlV/9USDgIoWDd7aBzcg5kYCxtufGhC7S8jAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytjRVCJGmEWiJ8tttasD6EebycRy/zYXxP9w7rJ1BFQ=;
 b=EpKKqALMfeNUozuQCEMBkzXKGW16PeO1L+gMbRnX8vaw54L5XvUbhQs+gZkwiPmBAjTSY1IXJd7kgSovWbOkajqqi2ayRqBlHH+mXXyD2VYNOzh7nd/2BiX77SsCQcko9ClYX996vUZDA2yvPDSVU0aFyVRXLXqJo1SZA+FJf8J8Yo7Cc2/R5vPvVSdqGadXa4pIbrh18Ead9hLvM9WxisTZNu/RMA4Yx2qvI74o6B3jLqzDBN7cuxbOMScjyoTcPfFaVyRSrPHvSo94wAShi8t8SUNTRxrhFrqHE8zH1korXBFBIKlhB3zZv2w+IwWZNiQCj5BoiyjdPvfXHa7W6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytjRVCJGmEWiJ8tttasD6EebycRy/zYXxP9w7rJ1BFQ=;
 b=cskbf2S0lEImiavuSwFFJ+xYFPAj+6qTND678zxdvUldiLsQBJN2/uWfCnvWZlY7APaDEuhyp6QaBTAboFPvmtTtPvyRElsbRxM6hWM1sF8Tj9BCSwztxps383YpCPfWuuzLlNRlUXtrD7S5P931cwnzZsXaXRLlFc5GxeWaZPP7MQMZlEQOd7Tpn2ptY96TBdegAUkz81AiAKt94/8UDx0VnzsHl4/puDMVRXecszk1M4O0My/yjFFxeX2Jit2MhiAkkeB1OTAV50d8H3etL1t7t56Yb4G+oquK86pHqmuo9uJC/ZsCpd1oN4hw5jrJnqjwXO9GQT88SrRIxyIu7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 12:38:17 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 12:38:17 +0000
Date: Wed, 22 May 2024 09:38:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
	"zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Message-ID: <20240522123815.GV20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB52765EF502C246B4C344CE888CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765EF502C246B4C344CE888CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cc0216-5008-4d32-ff9a-08dc7a5c0e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wfaSrbdMTrOP2PaZ8B9ho83tglfCPeZrQKsEsq/JuWFdkC9+No0519bBq1J?=
 =?us-ascii?Q?rn4itIFWy4zoKZYkPEMT2P5oG9qGoVc708dtisEjCqYs0x64nbBuzyg8QWPm?=
 =?us-ascii?Q?DOMInGyZUNTmTaKgTmW7wyEKOQmR9xRzAS8P8qkVf1fb5zDeVR/4fVM9PqYB?=
 =?us-ascii?Q?tmSsJWNiPoBb/KLgdunaAo9pUc4BQd1g7/spKwmSKT+b02EFys18X4PxBmBo?=
 =?us-ascii?Q?UEeKPw1HB4HgP9/jRqLv3g6KGT/FvBbEMf7ouESEToP6dsVC5KNGtZV0Vb9j?=
 =?us-ascii?Q?y0RKGtKJ1wZi3y8S1sejaOKuzA8kKny0LA8g9oRaoYhO6oxiZjz306b65AlJ?=
 =?us-ascii?Q?StfGn2tvnwPUGEkOhs2hkt9dS9jWQ7mZezsIomew25osIa0lvaoNn1JNR8MG?=
 =?us-ascii?Q?+sPDuKpz5D5R3MCqhyyWu3Z+VZG6iPSzkaidK5Gbx124JsJ8xlDpqfbrBIro?=
 =?us-ascii?Q?MN4o87TfzM0jo4TRnDkW01ji1E1eUCF+oH9DXgA69jweN48ZDC/ae9rsqUNu?=
 =?us-ascii?Q?ujlOvAsIHPFYm5X2kB+P31aeTNqMXnf1sMdVJZo6YAd4JS7doBPzRgVi902J?=
 =?us-ascii?Q?A3Ohcy/hKJSLzbOj9ItKcm5o0GtL3tmMhmw6exlbQW51VI/EmKle6tDhdkjD?=
 =?us-ascii?Q?D2vDpWXKkFyBHyzb9qKonzrCWMkAlljBXb8xgczP/cpLQg52DVY78T22SCFl?=
 =?us-ascii?Q?retXDjfQmOWyfv8Pnt6kO4eK/KzNGVYafQh0xDyR5DLrSLLsSUEcPg0O7rVH?=
 =?us-ascii?Q?KttmCl9AItSkhtCyCKpey1pubPv8FJRdDY2yzmesDb0+O0nb3WbZXiYdaHPG?=
 =?us-ascii?Q?ZXCAWdl0HRPPUancr/z5aONAgqp2tb130NkhCiEM4QoAGxAGsJhaHLo1tfvU?=
 =?us-ascii?Q?CZRmM9vGLnW/maw9prMjl4nE/n+Zjl4myFj6x+VMfEz3l0i0K/CP6wuPD438?=
 =?us-ascii?Q?qD75Saj9qAvxQOBUcbg8Y19vXSaRkBFT4Rve1n6ze68wjaBeNwdjNYTrzkis?=
 =?us-ascii?Q?zYVllNJPEB3UOTWBuStehvbJUHWPGSgGDiPULfkAlv+CSiM2c4IUnAgKrTEu?=
 =?us-ascii?Q?0K5qKbJBEkGgnUBGuJoli4NgC/lqY0nX6WqZf10ECWPq2aEJwwBstF5LWgZv?=
 =?us-ascii?Q?tG+D/w9NlJkqPM31AZHqrkrYRQeQKFCSAlgkQ3JpKDLpeGJIwE2ZsOX1nhfo?=
 =?us-ascii?Q?6Cd76/Rv+XjZ3G3uxfJsVlwyyFcN8TDZIcVyvHCcE3o+Tcnloh16QD8eWQM8?=
 =?us-ascii?Q?EIXr5d+qaaQoEqF3LV+hrO9CqJ3tjFihRw1m5vL2VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdYil5Qa5SX2ZQyr8aynqpLJHcofyRJH7l0eVHnNFeoPkG1hHB94AXKmY3Wl?=
 =?us-ascii?Q?HY1i8bS5DqpciRxZPhQQJ0jmhs0gwp0OJHscQyp2ppXYWZafGW2rujGTpPUc?=
 =?us-ascii?Q?b2bg2apaBWj4Zdd1IkPiEqp9ozM/zuJ3RTZ9N9my1Uj2upwOyQqnh13Tu2Xw?=
 =?us-ascii?Q?LseZNk4OsojonymhWXH15eXU2echApcqsqTACycMrNzeRXc1pqOTzwNayF4Y?=
 =?us-ascii?Q?WeLcIUXsTK87zkZoX4J0Artu7FAHs0O97pjEcQMYUjZFFhX2uS9MEh+tdVK/?=
 =?us-ascii?Q?cNJj9FqQaIMThuv0vd0dh7RrErTSFyadz7e6zUx5oBeirYzcmcGlNHPqvFEM?=
 =?us-ascii?Q?dVQvg94qKW89Me/t7sBRToX7QCn+09CD2kOgduAqZ+5re1fG0nOOMQ2kSpDX?=
 =?us-ascii?Q?C+f/e2GEelOiEQM0Hs1/PSRYjume+4QboMKhFKJ7pQDmILKTd7sYcyZoQGW8?=
 =?us-ascii?Q?g67RsGutbG3rWUOXgoK2ILlrrL4qIk4UkdzH4JkxRCpeg0a3XrgxRYLs+kre?=
 =?us-ascii?Q?z5FcgIF3sAF9xoxaiES2AAg+hsgws/QOBq7jDE0OIh0cvisdA8YqiypuClkd?=
 =?us-ascii?Q?QgGJVdI1mfKV6mf/nKP0gwkZNH5t7Hp4MeIkczb/unYdpELDbvclTd818w4k?=
 =?us-ascii?Q?8TMRoH8dIKWYGvW+dMQ8d14HywWaAXGrRww1YSoNEm8V+An1Y/pHIf0omQlc?=
 =?us-ascii?Q?ipIkSztlZ8O3/9ud4BjzqqVg+1yAG3O3xmn12ivOS01LaibDVxK0xYm0JpUA?=
 =?us-ascii?Q?mvJw8A5I7C3Gfod1kt8sgcvcGSO5X3xCrdU0oF7uZ+x6g01pCyzfHAazflpn?=
 =?us-ascii?Q?X44zG/4bPcAR7RK1u2AHJ4uWoYp7T+qOWk4K18nerOF5xXl1TtyH7MY358ui?=
 =?us-ascii?Q?B57fu4K26W+ZsYa3WkSXoSPKoUAdB0HWPpNh6p5n4AGHV0vjSDJbIuvpw22w?=
 =?us-ascii?Q?4Saygil5d7KhNw0q5vrzs8kcyW+O/p0H/aZ6K6OsSnmNdzgks1UnB5D0TfaX?=
 =?us-ascii?Q?vKhR1p4rLZl3iuUXH8IFxNoscKk4bn66tGsI9c31g93NRMiApddfy3EtJMCu?=
 =?us-ascii?Q?qTbyL5N67xEfGGaIzVg5hGN5qBq2W5Ds3jDCSHIROcA8M/7a38wc9Ruud5i8?=
 =?us-ascii?Q?WWGNsfFURF9hFkSMmy3W4MSgnIdnumbIn77YRg6FErcbhJl9C/1Phnj5RUTZ?=
 =?us-ascii?Q?K3izRTg0r9r1Wu0dLfB6a9iVCC/4WBqqGUlgGnRwppYvs8sR5F/mH2/D6iL8?=
 =?us-ascii?Q?TZSjefec4XEB8cmggq1NJvNwOdL0WyiiC4wLHosqWImysqT7pMxpHGyxQQma?=
 =?us-ascii?Q?vqX3hgJwJNyg6Aigb3rW6Lqz8QIH3ouATFP3ZJKuyx9m5oEMAa+vfkhB16Mt?=
 =?us-ascii?Q?SjkNJBg04+kr3o1U8CHfiPUpFczYZ6wmOA851Au3XSeQPNGTjZipMr9gw4R+?=
 =?us-ascii?Q?5R/plUPAgFuTpsKZwyQ6N0/8DETrd3iqGKPEJdneRkSdowz493dBZmMjkQG2?=
 =?us-ascii?Q?k8j5ASEzxqAw2awqBCoRzZsHXxSKRBalEqbVkQx/VUotsncKuqJfWixhZoH4?=
 =?us-ascii?Q?dpt5wVxrSXNle3UbzWY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cc0216-5008-4d32-ff9a-08dc7a5c0e64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 12:38:17.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE5OMJh+AwNuStO9AdipJAIVZpSOFVDbQhP0wk9VEtlaDvHPsBaLZUAoh9ibjUVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On Wed, May 22, 2024 at 07:16:27AM +0000, Tian, Kevin wrote:

> >  	case ARM_SMMU_DOMAIN_S2:
> > -		ias = smmu->ias;
> > -		oas = smmu->oas;
> > +		pgtbl_cfg.ias = smmu->ias;
> > +		pgtbl_cfg.oas = smmu->oas;
> >  		fmt = ARM_64_LPAE_S2;
> >  		break;
> 
> so dirty-tracking is not supported by s2? what about nesting?

To be done later IIRC

> if this is desired then attempting to set dirty_tracking on a s2 domain
> should be rejected with an error.

Yes

Jason
