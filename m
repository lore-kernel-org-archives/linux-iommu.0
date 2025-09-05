Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD58305947
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097085; cv=fail; b=LPVHRHg2F4b1pjM1yqf2FpOwCWjfMeTqP5qJVTH8tp8mbWrNKaV2L+lF6hrQAjbMM/dCgjLvuj05rdBaSCno4Z8rka5+RMgRpWA0ZGw+9MYlkJAxUkthdDe1raAxf8YiuXzK4zpeG09Ml8uSJnTFt2XnC74FYjTX8QEuN4j/Nq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097085; c=relaxed/simple;
	bh=QqVT5x8+PjXTdDzPOY5nfqMl8HDKVo6m8HMVNE9ZM0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dfJhxpkZrGjCqOVuogLk3p0jWmHqAQZRONqZKAy4AT6Xpj4Eh2H7I0Ja3wOIAmOUleNmKeOefHRIPrANvW3lNKZT/ZedSVB1IoobnkLZ/WzOt8V/Hv5vGAs/YoZuKLj3ASbqgNAzM1WJAQFH+T/TnbAINb9bIq9ezqS1K3apK70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/ichib7; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r/ichib7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbv0d+AxX05D8vX+awCNPmcweX5aZoJEf/JDi4TXe6kDOp73c2PLNvAjOlpBGsTxhBKEkA69TdbcNVbZrlSs9J1JPIcJRsxIMEdjWBhM2ccPIa4IFMGRrdNEQwo1kGX1lVQHncsfNLkDcNTudX4BjcdwChjBQ8lFESoDqdFlAmd5DzfXx/uN9QIpSeYXZkyE+8xjmwT+BwwATV+Zc+rkqSNXfmbGp7dMs43H00SfylxfP3Msf5m7zTBxuvpitFxgF6KNuxrdy7gQnnw+sBb9k89CfF2b1UH9Rc0lfE/6Ds6zztKdI+mIstLwdyj6vXHWQtrXMIr0HcwDvDKLGf/fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC/uiljbL4bI3Ca4L964umUAQzkle1pUYAx69rwKhW4=;
 b=wJyf4+VMhjnX0i+uVkKnu/6RzlprEuHDWc9pbnmhUyK024K7sL1bc7yrAsTPGdN4aXkELlAvKPODWFU85tZAXHoEfh5wNKH5SxHnRH/OsHD4qxajbuj+7RneM7kJ54og9rVVYEG7d/WDMJ/m0XvQfwOhYP3Umi34X+C/XwD4MTwRrKVUjoxeb5/w5+QIgpg5vPcH9DHelwIMasd55NkiTsR0u9RBIWJCcZ6FEyVB+51nff66VTA9lVaAtkFTJpl02UyfwfyErLbPCbPtaVamGd+CGA4l0mVYbVkdj1uAd36K/YEEZjnmXOM98+GNO3PPyPMUDezT4mRHt/+xnqWyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC/uiljbL4bI3Ca4L964umUAQzkle1pUYAx69rwKhW4=;
 b=r/ichib7ftpCMjM5OGIcGCN2WjvdRDvpU/95OkIBGTe9nnisADR4eVWkKpkXIe7mycdrh5l47l4FKdpxWVhUDG+liX+ayLw869ICuQRdu/ATTeJqYHJprLBb3EESvbGo5UmGtcbAGwoiadRSxMRQZL4L8Qg9v2G5wIsy8TumQNy0ZXPKF9v+9KmqCAV3EXtJNckP7uBMKhge2E9Zek3Qvgv4z8RKUg/bADUS54ilHhAcKAliOnCfZETx6jReDBqr55b/ncemzkewkp5/hmLP06zLOXX4EAFOuFbVTRR+RQflp7JEW1wkgGDtlLVVStGMumoA098dr4j15+LsAqpZfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 18:31:20 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:31:20 +0000
Date: Fri, 5 Sep 2025 15:31:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 4/8] mm: Introduce pure page table freeing function
Message-ID: <20250905183118.GP616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4P288CA0082.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::12) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1e89c2-7062-4603-d732-08ddecaa68a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QrKmAf8HSc4s1bqmI5lJBRK/awMyGLSpMUlw1zv1uZDVfHN/6woa4+tPkJiZ?=
 =?us-ascii?Q?zsivVWXheGLgXIULhaAqQWQHThLI4ZSZiUx3GFAY/oiAk+jeAeTSwAKLqqTb?=
 =?us-ascii?Q?xPS8jSHlFfKVwXh2/rmg8fSZhwc/d6PeB82NIdLOiEb/iSVY+kuiy1boMzwW?=
 =?us-ascii?Q?xZHeqwhQRRP1Dj0p31yWaTjsXixfukG+T+n1V0WakqNmi/fcAKN7hn/owsiL?=
 =?us-ascii?Q?+tkTQLzygK8f4ygAa+XWnVpqohlfaTHY37uVeC4NXMpXQCHfBOVK21+GJaua?=
 =?us-ascii?Q?SUHjolGrjDkRdtH8BnaXFOL5zBugHW4i29F+6gnVYBrNAzY8FsThOMToDdGW?=
 =?us-ascii?Q?Hewz1vYhSibcDLFn17qIQEHtXb0HXkpq+RK0fIgYUarjVv/ctdYOd+XeSJYX?=
 =?us-ascii?Q?guNRPfYMZ9nDOiXV8BXnQpvvD5+TxXAO49kPhbXXG3IzpGT9as6C/oxNFTmj?=
 =?us-ascii?Q?M0G/Ny8ModmNM0uexw7ZgFn4YQ+0N4aooinZTsg2mcS02TIhpQef1qvRYS+P?=
 =?us-ascii?Q?mAYubPNX4Zqd7G2bqov07BD+vyUII6dmtBcFcpsYk8Lgfhi3p4iRMRiyB4+1?=
 =?us-ascii?Q?3VSzTls0Omh33eImembdo8zxCSHOjtOdL637XBEWZ+ZiyDc1fUUl1cWLASJb?=
 =?us-ascii?Q?16CESQu9C4mIh8YYyyHr7SNrwUks1oqf4l20CNGxmzL/Zrz35I86hfUjX3Bc?=
 =?us-ascii?Q?LVcH1vGx4kBP4YLcFf6abu3nfjZ+h8q3Q7Ro3C9tiLXZP0UOcOzFDi/iA2zv?=
 =?us-ascii?Q?WIyYa4NKjCSIzK9BHOIPVGjDT/QXPdM3bry3180uSJDoZ8HMmlNCZko2cnzN?=
 =?us-ascii?Q?Mok5G4u2sMh6JkQFWO8kteOPZHQldqe3MGOn/E7m8ssEHakdztj+CLofjqPP?=
 =?us-ascii?Q?RqRfYh93Qibu4R+9AoT2o0ouE4sAF8goXJtJEbqQfGbgP27JEh6LWUGdtV76?=
 =?us-ascii?Q?qvxxhrOOHdxSkpjNmb/x0YRLhuHGYIargjXnbVq5p3ZrmjUdL/J1bztqpYCx?=
 =?us-ascii?Q?gy9HPYYFIHdniHbQWv54SEF77xkSOB+aaVOgjMWozIvmWvMER/HLPHx7/gjn?=
 =?us-ascii?Q?BpG7aA8RZNABCnxqPSF6R91hLrcB69h93WwTVKuKS+oqSW+f2HpIGU23RBDQ?=
 =?us-ascii?Q?jVKLzEV8EhhhEUPUL+bchi+6jfZNjaahhtS0wxtg6/v835ecZQznZq4n3rSI?=
 =?us-ascii?Q?poiZTi9e2s6xpSeXgqYbzj8BBiIBPfgTSlVlEA1nMVoJC9NV9tmNhHFsaJ6P?=
 =?us-ascii?Q?4PGXA3CBUCEBVsOkZ2EA7ABbfLAferc/bRcJDpafB42Ol+lgD/NpxQi9oe54?=
 =?us-ascii?Q?wNYRli35k0yCter5Zrn8SSN2o8pJQSL6W+OTIfHVsQ9Ib0YJu6ICsZia8Z/s?=
 =?us-ascii?Q?SFnZ3kqKMvLGp5KqsxghShJ/kvHbMb++8q9raB5ANFZMsgzeBFfqpGZgEcmu?=
 =?us-ascii?Q?5U5+gBAVrFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQ6yvhv8j3HfmNbZTf21oROIhOfUPxzK7Y48W9aZBMOsCtqbTO/qsEQ+Ulgf?=
 =?us-ascii?Q?cQEUArrNXMmRZOFyipp0snQRbb4PpEOIy4u72rIZvUB7tVKt4kd4TOUwJYXc?=
 =?us-ascii?Q?cAkra2pxLIpTZm3eOfrVGVJZ3Jt06hFFNiHAriAsBOfkXX9InFp7hcJId1pP?=
 =?us-ascii?Q?An5fI5rBIYCo7o1xQ4cpzihHJ6EKb4iisDtMBo9i5mFZ/YYmDxq48DUEog0f?=
 =?us-ascii?Q?WrNCEBfKGOxxP+iceIVIhqps1shRW6rjN4i3pDKKZSsAelCOfEIwP/G6zIGG?=
 =?us-ascii?Q?glWzmKSbfJbX/6XreOqiEI2Mx0tS4rJZWXcokWjJQJCbb9tN4WoVrXf6COMx?=
 =?us-ascii?Q?UNsjoZltSIEHUwRL/wg5jIIiqjeA13+R57hscJ9bGTyxsXhl5NnldKMMyhf9?=
 =?us-ascii?Q?0EG32JbMn/T/xSWZ2m9Dg5kyuMpQ+5p4eMotMwAZb8rHNiCTKbrcF/HXM+Da?=
 =?us-ascii?Q?7Gldzl8jtoOAePHcTisF3MMDbfC+VEIGM7mW8/1OeAoyQ8PlDW0DF9HTQiii?=
 =?us-ascii?Q?KmziRO1j/cONGNIreM2wZDu4Q53zaQJ6N6p86ZyfMNMaOsi6jl5T1erytI0R?=
 =?us-ascii?Q?H9Ht34alGV3TapSXwzLANwdJNupl9cTr7nEjbrSxZj4m3jJdj96m+zHLgX+6?=
 =?us-ascii?Q?RXdgRyMsOrPtJ+sQ+6mhpRoRdKtxIPkgczv0mWy/psVTIgilo2AoeolqTA5g?=
 =?us-ascii?Q?PZOmaNE0RR6l5jehe399dXeovxg9pTTri6YbQL84kv0TdoFYS1HmGZTt0X13?=
 =?us-ascii?Q?6frMAvSAvk1vP9zUu1kw2sFwzud5TfBiqpn6hE44Zr/x5mek9h89SR5ydu/C?=
 =?us-ascii?Q?WP9u06vWHXQ1F4znrpHn4+GvwBUxSoGCKM4VLZ9WUoNA/5yxgB8RsLf7ZtQi?=
 =?us-ascii?Q?5ZBoqaZsqs3EKO5jJPRb6KLZ9ZCxxvb23nvGRSSFenhcO3ZeAJ2aHNjioelA?=
 =?us-ascii?Q?I3PH53Qsnvkjg8TbXv066SClUcXSFLBNiULoekNjDtle3v4WFx8lrNh/aBok?=
 =?us-ascii?Q?D8Ofu0R7r+S5jAtbIoEtM8adCgLLiwQ0Ri8PZfmZ/5r4HqMe50OzVeW5Y1h/?=
 =?us-ascii?Q?8qx+iPfgYgCQMKJEFNAxiKZomNg/WEyCHhrMUbPBdGCDsg26XNsEdrE+ACNC?=
 =?us-ascii?Q?+GEKnisgXgF5MSjgHO3INwwrr4F2hPAqGZMqDou+K/sfm9hM4In4IZc0y9w6?=
 =?us-ascii?Q?wf3haYEpX0GghVAuv7LIG5t+qVAGvI0o5DWFMlkn5OERj3iUMlHLE1vsOUdl?=
 =?us-ascii?Q?Okl/a8tUpgOVVQtTnSo2kEeTNP2JV5TavGx9Sw+aLnhXl36gYU1mVZwjAosF?=
 =?us-ascii?Q?GvUoXVaK6iZoWzT3lMCIwn/zAgNA21PfyW9Vi/aldf8FbAwzLE7OHAyrw96n?=
 =?us-ascii?Q?9kFkYCMpHwlsrqN498W6rzGobof/dwxGnCSy5R4Qh9PntOSkUl28YJZB0NnT?=
 =?us-ascii?Q?xoIuepUWbrKACChwL36VKmxCqH+wajOMXWLcC/B1XT4F9RPfD1GmVfDYfs3y?=
 =?us-ascii?Q?O2rUJZvuylyJV7/EZ7OfbGYpIhYG2PBGZxLGOfspG6+cpePqyz1M+P9i9e+E?=
 =?us-ascii?Q?U8AgEITjG5yl9EUv/No=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1e89c2-7062-4603-d732-08ddecaa68a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:31:20.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LklgOqYqoMWwSoD8xA6z6TeFDK2nQzo9kDKRQGjXFvkS46+ZgWGc2TLM577y+lKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528

On Fri, Sep 05, 2025 at 01:50:59PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The pages used for ptdescs are currently freed back to the allocator
> in a single location. They will shortly be freed from a second
> location.
> 
> Create a simple helper that just frees them back to the allocator.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/mm.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Having the only way to free pages take in the struct pdesc is the
right thing..

Jason
