Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0F241689
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220908; cv=fail; b=MuD5bf0waw4gzoxSHy0I1nh1vtUXU3M5QlABrLo+tTMS8tRoBGAEV8xIPKI0OMaevSUcU8FZrbeg7MBZHiX+PmVhrUlzPKDpeNAjLhTRtDq+kayEQgknf1bi3ocflaCI6XZNulY6YKgF3rqh8UMM0nL4ajBvmql7mv+IfBp/DBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220908; c=relaxed/simple;
	bh=4PQ2GbV2p07CYeaJLkR0lG76uc5m+P3sjCROpssnHSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0ZHptTmPysyWLPjTX+IEHnhL9r2USUqRpfnMCQExIwlnoX3etNfUDpZzCPeGGCwcwzBgduTyfD/S/mmZeUZk9u2mXAZ21ruTFoTEpdRgqm2u4r+TlidFP7Ex9DEex0myN9TMIFY0LAXB8mS7yvh0kPduM1scbpiSmg858+aM5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npvSq0+a; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npvSq0+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv1rAhyngBd3GSeV8fJlHRXDOc+60RjoCM2YKNL6a9683lwUcOHiTBmSZeTs+FZ5jfkWz0bUPYpjCIqb5JPDw4C3Z6tOrM/LA/gD5gd9EnovyS4f0aEoXBlqnOF9A3USMVSsiMsxO9Q/O1FqgEFK9OCYmMBlyhSJbyCRSM65b9suSE+fJN8iRlZTZZwHP5rKYnpkiizijaIztICreAgg7wWv4lBNqM6QCnX/v757QT/QzW2e15900zCefUXsLXYKbfw1peI+HD9pYtOFSgZZEIF8E3Qg3Mb0plS3ktF/EQ8Nt/6ND1/AMBHvhNzyZBUXOBj8Il8IHnbDnz1OIERzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRynE3I/ELT1hXL5o8pRk0G/AjPPzsx4dTOdLHUREzg=;
 b=NcQsMAyhvlVca9NSqcP0F9+wMMqRQa+QPGgaC7gTiG/h0tGoITeSjqB5pxtIRlvL63GuCKPCYOJwqWn7Nns0asJy9gDf/YvsoK4VF27ORrcI3KxlH2fkismFuP0QGBFl2atOU9FclDoRZ4A7/eVwfNk+d1faf6tUdwdc5BYJwQrp+aK5RynLQSXa0GvH2qS0VT7iWSfI6RnVFtF57DfKzq4JjGuTT0hzXakw7AKWJYrtlwSFnAz4oLQBt+xyuoxgHwvFNNZppja6YhS9WeFKZokMavHA8cNBne/RX5+C2dLz/bImxAehob4O4+yUm80dt2bz8WA/pDfWhSp5FUQSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRynE3I/ELT1hXL5o8pRk0G/AjPPzsx4dTOdLHUREzg=;
 b=npvSq0+aS0N/d2EGogrC7af8ay+4AeX7eTRtdE8adIrtEdgTjGFzXWMl+Zfke2wWyC3KIpmENq3YNPRRadJFCJbCXQJG5jWlmbfGARtye1WrXZ1+4mRhHSAX8dQY/AadPvGW135UJV6ssso5HDCiAmTe6Tv57P64AAFpGbX2oRBDMlIyqpqVX0KRb/IplNjl57ekwDfcs95R917JMlIATiPm3VBz6giEqEqUY6q3hFthp2OCeUAx5Fodw0thCEMRZTLOkgoOHIJyEuYSAxED3MwqPrSuS7nVX4EoYZDfK5ONIL8Mt3U6QjHb9fly89kqXZ5pdpXLiCbnCIoVfs/GJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:15:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:15:02 +0000
Date: Mon, 17 Mar 2025 11:15:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <20250317141501.GE9311@nvidia.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <CABQgh9G2kTqWvjDTMupCJ_YNMxTg75PwgooMSsvEuT_hvemvDw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9G2kTqWvjDTMupCJ_YNMxTg75PwgooMSsvEuT_hvemvDw@mail.gmail.com>
X-ClientProxiedBy: BN7PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:408:34::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8f6788-0826-412c-2025-08dd655e1bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBOerByUd6tgW+olNbtc+5e7QF0jzME5vDghgoY1cbHYMK50d+cUq6/KepB4?=
 =?us-ascii?Q?YtmVq5CzYA3b8zmmsW90UAHL3ZhM/Sj31qvNJWKPEJdXCg3AhOkkfkfsEhai?=
 =?us-ascii?Q?sd3RwMEZMMUFZiqzppbSo0pckgjRcWrUJzfWlilJ7A9ZlPyT5gsCa1f0QkGU?=
 =?us-ascii?Q?TRtQXGAPuLGXkWUQPnPJZfH3lfECqWjTXb+HWIGSw4nApspx2pZ71M5A8NAQ?=
 =?us-ascii?Q?yzUjiOGHyfDQyfMFKV6EkIpHZ27Uwfiv7nmrtOvpqDtzaF3Zx8+lDNDOdJRj?=
 =?us-ascii?Q?sHBbvE1RZr8Ef+ZR35SS2fn3kDb1rtugh+8eqyW0C3tf2wzh/CzQz2yn7kO0?=
 =?us-ascii?Q?pFHx2clVo6VtSoSGndMjfgAYYcD2oD+JKlaULzIjTboSFNy3+uvFf23NP58k?=
 =?us-ascii?Q?ghycCVTtcMlsM3g4AyVog4qHExBUaLe2+Sccu9OzJt34sef5AIADJx0qdlU0?=
 =?us-ascii?Q?JO2lTIoClX4s9UcJtd38a4tyEaBUrpeSMtM+kdq6+Pp8w+mu2fLsWIHr4irM?=
 =?us-ascii?Q?GTTLanJw/3lPt+Ig8sz45rbaOct6zlmiq6kb9DEpLhtlkq2tdaI7nd3er4n6?=
 =?us-ascii?Q?437EODRK564c2UeUm5o4p+jZkENDzTQjrrXsbwVIUvU95qankzGxzjZcTVFt?=
 =?us-ascii?Q?kPCLpLuu8SmHD+T38bEfy3Xt0eRkTTvlrdsouR5axTxijti5Hf4G9Wpp6w1p?=
 =?us-ascii?Q?Vcw4TOgYjmeW/k8oZQJPhcDLGPMIWmxJUwiS3uSUbE00Lem/Cb+rVA+H30wL?=
 =?us-ascii?Q?Y2HsTX6CVfLHbfB0IbSkKDDaW+aqKT+IjBD7djSvKV3IoraHettq+rbzEhQI?=
 =?us-ascii?Q?4BdA8zH2vF+q8V7QetbFPoj+ohpP4znI67z7oZibdYmzMj8joO5neFJmLXDM?=
 =?us-ascii?Q?E8yaFKjNSzJA6tHVcYlTzioDZ5t/vg/Kb6BsJEFd+DcxCUNLqa2TvQO2RhFa?=
 =?us-ascii?Q?kvxzlMEjItgAwdEinQ471MBcu5sc8/m4I8mLJw12bxrpr6qhvDGCrowzhbMu?=
 =?us-ascii?Q?+kH2j30m/XrAC+1+ihVYqt0FZBfIzYzIZVETFB/rzCBFlLK7eHUC95L5QSSB?=
 =?us-ascii?Q?tfzdwMF0bSjpOcRceURX1TFssazoKW/XXPDMmHQ8v45USUX3N8rH4TlMwPZn?=
 =?us-ascii?Q?7kAXtwejyKOFhR/oFKUr4iaMugjnkZ4itgYtRyks8LYQm8NilZV9nOREJxwx?=
 =?us-ascii?Q?2hDOO7HrNJw65auPPrkjNiiHfvpQ3Xrci1jgXEYFt00Wsky97JLB0cYCqgms?=
 =?us-ascii?Q?JfXBfrM8eH5wDSE50B4kLN2BAzaKPSj9BdtG0fxANMk6jCrE+DT2hEItBV3n?=
 =?us-ascii?Q?eH4qmrikEuTJF/jfwhqbxX+Y1yKFA0AF64mWfImCCW1ScV/BxASw+I+WjzoV?=
 =?us-ascii?Q?ui29iWrHgTZX7w70tQ7xwquhHRrhqLvXeYbG2MHBcZVYd7b2hA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALgrLnGVRV1R+qS0p2FEm/LUsf3UZvpL6jkyS8hc4MoLHmdMATq704KLcPz7?=
 =?us-ascii?Q?EM4I0JQ+Z83Y29x9Z8RaVgjfDXG8CvzygW6tX/8MNKybKlWkZ1FA9SQ+Ul4j?=
 =?us-ascii?Q?ODt6pre9bpGrG7ndr56aFQfhb3eANDMxWKQso5f3qQgUZ0usygLktrhJWx6V?=
 =?us-ascii?Q?yw8rA3u/sdGHzNVy8Sp8bDc712Pm/aVcQ2H7GuZFcHtxevm3MPGmwfK6zomT?=
 =?us-ascii?Q?PjN/FvwO78P52QzqA3wqifnVAOqUoET9cGAKrtHxM48cNkXjfFN16Lb1Ap6+?=
 =?us-ascii?Q?6R8+YKnelbBqjiW0HP1lY/vw6DULVZvOwmwXizbdmweLoJafcfw+tf7Rw1vs?=
 =?us-ascii?Q?VCLvdeMualIVOdVa7I0PW4DKy3xT3nZ7WLooj6RVWDrssc0ET0vWSMULVKT1?=
 =?us-ascii?Q?ch7wtFAxTYSdZs4BI/a+vvZFb5bO+fE15u3H9/v83vIVNQsufYd/3MmgVWP+?=
 =?us-ascii?Q?k7W+Q1pN167DfOfB/xTcLRou26RZBUQw7MmZzaqmXITdOeeAP1zlga8bCjJz?=
 =?us-ascii?Q?XfDqyLpXXbjOVrNCTOxUgPodBAaZGgfu9Ql0ITGp/cC4wtaG4FlZ/IntOM1A?=
 =?us-ascii?Q?9vzFKqRe0r+QMmlYYaUxKDng3MX2OxJqO9pLv3murk10Pu1+8T6a6yKpQ6z2?=
 =?us-ascii?Q?H6ny2S89eFQqzkaRJuPYXskMsQeM/lu/ZyUiOrj88/b2SmtAtMfTf/Z6VISc?=
 =?us-ascii?Q?49jhs0qhhOFpu8lEtew7zqq0+eAFYE/micPCsfAgkcNbZirq7ARJGoVpRMoU?=
 =?us-ascii?Q?F1H4WTBD/zvAmcLl9TcfkN/umuaQMDjw0OxfTHIwmmTk0vMGEaaj0e1lT/6r?=
 =?us-ascii?Q?9/bsRzNi4n3KquFAsLUBYt7D/PpoVObSFC7KaVF4+/MnWiCFKftq3ptU3vus?=
 =?us-ascii?Q?bLl+2RNJmdxlVnaOLYwoaHfsvSIJdT7m3XHhV2NJmd803qEmAfjBpL70HTXP?=
 =?us-ascii?Q?d2cYkHUzxvXG/qzIv6Gx99oCTfQ/BAtEfYeZP1DckRpqEUXt0O1x8tdtS7/B?=
 =?us-ascii?Q?EwhR2s8cam0goBUlgLhmzcUrKEWpaxqL9vJPFQ81OaW8Iu86Q/tTZgcH7qqf?=
 =?us-ascii?Q?umI/NlTFvzZZWLcCQKYIskSWemB0ABSPbNibFCipJO4bTnmyYY2uePshCmLM?=
 =?us-ascii?Q?cDh3nVGVLdyFwAjl2pH4KaDdU0AB74otNmYt2hb+Nfz+JR2t+KOrC96TAUgl?=
 =?us-ascii?Q?6Kh3yJmFqRDDAM9ibhUtwealpx3OBiGr/fTdelj6Xjh9JBBAKZW9Fe29LBv8?=
 =?us-ascii?Q?wWDyOm0K3nt0y5YU++otd56/KeYcMr4nH3BcjVdtky97YFC8CNIxW3N3dz0y?=
 =?us-ascii?Q?20ni3+1I1WnId1q7+Xxjyw0XyeanD5WH+91O1tXJwyd6+07R2saFApkEo6kQ?=
 =?us-ascii?Q?w+yMCm4lQ+HruXIl9mxIHqdjQl5JOdQeZd8CFIuKPC9UYWLRlZOCGDuyXmrh?=
 =?us-ascii?Q?pZisKcoMTZ76eNPFs23qrZA8yHw6OzY0z24o805HNr8EPgDe8kXiH/rEvX6A?=
 =?us-ascii?Q?cAl0Zp2ZM3dLITIAuGt1+AjBF3BosTKX93C34FALQ8aodmuiqTO5AO4xqI05?=
 =?us-ascii?Q?sXrfRQ5Mbq5IZmc/pVg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8f6788-0826-412c-2025-08dd655e1bb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:15:02.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdY0pprngh0hI5oa5tOnxxt0QcPTQ8VkwdzOHCi/pWOeCZ5jikphNefj0NrRGmZ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668

On Fri, Mar 14, 2025 at 04:11:56PM +0800, Zhangfei Gao wrote:
> Hi, Baolu
> 
> On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > The new method for driver fault reporting support relies on the domain
> > to specify a iopf_handler. The driver should detect this and setup the
> > HW when fault capable domains are attached.
> >
> > Move SMMUv3 to use this method and have VT-D validate support during
> > attach so that all three fault capable drivers have a no-op FEAT_SVA and
> > _IOPF. Then remove them.
> >
> > This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> > further clean up.
> >
> > The whole series is also available at github:
> > https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
> 
> I retested this branch, and it works
> 
> https://github.com/Linaro/linux-kernel-uadk/tree/iommu_no_feat-v4

Thanks!

Jason
