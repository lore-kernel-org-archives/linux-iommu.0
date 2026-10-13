Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBE4F7CA2
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894169; cv=fail; b=LCSitGlP3F4vaDrk27XXpOqHeslT36HA+668yJg6Is3UqisaSuPPE0SAarbS1ik/CkR0OZh58cq3XtCpTvizMXdUe7ANICVqJRfpcyLKok0itXxhvHLVU6UQAq2+MLgdMHocOdy/HB5yeXPtFhCq+S/5G9F7N++cep2tpH9xeP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894169; c=relaxed/simple;
	bh=wXmyGuPqtt4tOahdNTPMAEJMyYtSrcYOpWAFAg4iirM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAE179oHBTf8QGQuN6noQpM0ekRFHdm0BNU8v3zwRTRutNtp4UIuld+MbPRz5SdJy1b8KWAH6crHTijltkPLWS/xthM6FVkXNic7wORyPVjvalsi4YlkCA2L18msoMf+feqkflzkTyIvTNctREG5futUlxOrtaVLNlpzrUBs22c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNN0xJWg; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNN0xJWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGxUkAS47x+/e+PjS6JgKUvxhH78KkSGLH2TVT4j6lrt3nafrF0DhBIPdCwgkAmVTzIxre4s0mK8wOsCnwL3R/qPANjMGeMWHjY1rDV4DSDZjwhrXPFYHcx1jh32lsVAmR+vJVScHBnq7ctGRcMt8atqoFaX/buwA3vWDJRT/FJqCwmWB3/A4HlHTyMsv10zDYM5pqZ6UHAGDrAan6WWFbJ+MK8OqApzjDQDSbfpqHpgHZq7bHef1yASY30y9uNGYXPEVDoe9/I7fvc8bi+5MwPdWk+GsqdCB2xkLtLsFQw5sBcsyB8CbgUJg3Q52qAKXIHknli64J2My0x5J0dTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+wEt9RoxMstqYDfMgU/aZVdd2TgXoSCaXwYp6a3UlQ=;
 b=TAeGp3qN2gMrQDZbrrg0lLrsW17EGzFgEElQMlciShGRASuAws/d/YPNJ5zpCtlMW5SZE5n/2qHkaX/q/9fi5LndcaTDEmpm14i097VN0cmrNnTP56+2qp9y+11Dl9q/TkVDRtO5D972BVkdvGj6JXcXS4EExrnA7GEQjmUGreRXvFaGQa64LhUf2jzT1YwbktjFjfbx6IYlg276LXqWrgS3qBuYaTXBA1ESdPbhmS63a/UjlLz3XeSsCP66QbY84x6F7pCqHA9iHO5KEszgh3568N2+wgn/DCVxzFxwm4R0U5eaKTbWqzkj2pjUfypWuafTlTFKPqzWsESHMcR/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+wEt9RoxMstqYDfMgU/aZVdd2TgXoSCaXwYp6a3UlQ=;
 b=rNN0xJWgfZd3UxFXfL/HshtKE+k5cpt0+Zka8o4/RC0WsvbzTsduN8LWSfOi5k+6DsPBV73A68l8nclDuZsUkKBoGD4vRELlgBp8hLYCwvzuGJNmhvOLaalP9T5U2gcXCxIA0ANF2RKSI8pnfg6AYTHqbPzxUX9oWkkWHHvg4v0jTibFtn5Fa3GuqVB5rSPaMGWtZ8SCDYztUWAJPxzzQPUtCfA69eXOwH0aNWAWF/pxUXwfY01i6Llh312C5/BJJc/rsdgRZmqQFvW6gE1MUiLErH+tD7Ep2kcimBRfgvwOcX+ABw0EMf+3TbfXT8tqWgg5tgP3UrIs0PkSg7pCTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB6564.namprd12.prod.outlook.com
 (2603:10b6:510:210::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 13 Oct
 2026 12:22:42 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 12:22:42 +0000
Date: Tue, 13 Oct 2026 09:22:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peizhe Liu <peizheliu@utexas.edu>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, iommu@lists.linux.dev,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: Charge IOPF allocations to the faulting mm's
 memcg
Message-ID: <20261013122241.GR13920@nvidia.com>
References: <20261012200823.699316-1-peizheliu@utexas.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012200823.699316-1-peizheliu@utexas.edu>
X-ClientProxiedBy: MN2PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:208:237::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 85aa23c0-8b76-48ab-1638-08df2924adad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8PNheXzvleP1Mrd5XJzu/o87Hzb/8voBiqbOfl65Mufolo8YISSUdRwcHctzHKa/Ln7M523POeaG6HI0Znt0rF2au6+rik6Ivz3+3Dg2akQZMiyfS7AeIrJ0g11uQxIp0mrNmsQJoCYpQ1ydUlmZrmaWx6ENsqYIFAdgcwqwLw45Oqz1XCMbV04sCTvEwd9G1gpg+oLDtsgMbplbh+kajr0zZ2wljRQQuZrn8ELOaZkGLf4hgdMBBCIYaI6UqyWNL4XIXk9CAnqX8pn2PKkDhFasKn8qO9FS/pfN0dhXaI3fbpb6Aud0IqovC/EO6wJ7kArgucyuG45qtGAtbmTAprgcMn7nszbQ4tB4YyCKERoaS79Nv0ibHDCoEf7paeyhoXnd367EE7Iqm9WbROh0fTa8DN2LsWuwwe6iWFtYoDk5/VRi3ZEhe4gE1dZCLkNNAX/PsnsY8wvV7ouvnKki6zddcJ/Zy62lOpw9daSB+dybRkaWv5cfnZZLRqAjxsW2W3kv2aQ6Qfl24PWE60qfevId/iY0c7w8WlwG+ZPIJaQ+KBt8pbLEsZliAaxmexyGU3YCSA6gMGd073bg/4aGP/BwwZHCQad9Kdltew8MslB1B/G/bdXRmherYxDKivmPpShQhTG31jNlfnGrKU6gr+Z+W2XTWQIgHxxADf8OBbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smqlxlUDgM0p7XxQzY/nbzhZH6qVMBKljGz2SlbQ+y7x40jedZ65RGbBge4g?=
 =?us-ascii?Q?MeZUJrB45XRlWRzwTHFZRzi06YeY8dkddBnTcwu8kZFfv9lYkLKeRmwSrBjA?=
 =?us-ascii?Q?H/je+p/LzhfNeWYD3N8/EAZbEQEo45CeykbfEAhYAn617ib322mbbE2K089C?=
 =?us-ascii?Q?zkNC71dvLhgAUQz3KNl1w4TU72mHJZFMfe4vH2qx6CXciYjZDnx1FUjXL77c?=
 =?us-ascii?Q?FzZ8eimhb6epYGcBZYkbQcX7ljXfIsQfziyXY16Nqp/zG/6vBM6j1JojRONL?=
 =?us-ascii?Q?eoiwuliouYrm01e5cYB5RL6JhW1/nPWV48yfUWr6wT0nT2xpPmr6NUdAjrzm?=
 =?us-ascii?Q?vFLPYkJ9xK+Arv1hEhRMlTpm7GhKELN4HP5azWDObHMtJousO9fIAIp7rOe1?=
 =?us-ascii?Q?St20yjz+yRq5HOptjDKnFEuz8X/4nA7y5CHt5L6fJLu5h8nctK1kWBepxSKm?=
 =?us-ascii?Q?wCtGo1doZ5vNTPI9vNNBSUBQLa9UzhituxWt1V51fMdfQhiSp6Y0q+CTLxeI?=
 =?us-ascii?Q?nPh/aog/FLeOS0O8MATKZOIY2pxCrN1z5Lvyr8e8Al82lYXm0lQE4aY7b+tw?=
 =?us-ascii?Q?1FVo1x4n8Inc3epkC+EeQc5tJQnh9KPEtG6WzJBBTAiwB3CNjcC56RJDh53Q?=
 =?us-ascii?Q?Q3S0OUY/1ulAZvBF/Xtl2swXsvY3UwA+cdOuYD4fHtpAiSU82UIFdBABZYmQ?=
 =?us-ascii?Q?W1spDl3d+AhsNM7DSlrKE3AGMqphegCEHu8/KqDXT69jn/Owdc6RS+GAjIYO?=
 =?us-ascii?Q?jAAqdhZOLkp3OstLMNNAzzY6RGCWpqNg/ov2j/hC2SaIFlMazHln292DmhHy?=
 =?us-ascii?Q?3aOsLZs4/9d1rleZQAHCvls4QZfNdAfWWA8F80DqPRTcB+gJL4YfcogJDy8I?=
 =?us-ascii?Q?3de+dH/QTwTwlDG12xU46GzwON0Z4RoCMIJCsGIwg/H6pJrR2qCWEF8JlgxS?=
 =?us-ascii?Q?4r77VsTGHuvtNCxoYJZsXlEMgKougGOKEYUyWtgl9LCVbN5h5rqUbvbBN/GB?=
 =?us-ascii?Q?Mj8Q46yxCOrAXTCKOnW9Au70IGUndAHTAQ5PP7yUFgp++yRr5STmCPmKQU1x?=
 =?us-ascii?Q?sBqOaguDzMyzr39PnJxmyuqqZpn66i2Q+LZ+kf8Rcoq5MG5dVcrtkJjsbg49?=
 =?us-ascii?Q?KrE7tBDhGihpwOFP2pxAnMY+ZzcTjlfL3/tufTzX9aQHIHRtpgREGH/Mi693?=
 =?us-ascii?Q?aKLSYYiJ77itytzv/tykPrUV0vSiWFfvVTe8kdEslrsLBPtwXTaqT7YqtXZ1?=
 =?us-ascii?Q?q9dJVdKKeImGcY8t0e4ppC9Nd8d5xwXCd2xHrJyFvfZWUoZxg6+H3u+f1L8l?=
 =?us-ascii?Q?9/0bjK5BgPf4heuJIovvA5wAPXwXh5XSClKvT1ak1jWXOzH8WeZA90k6amVl?=
 =?us-ascii?Q?np8dI3jtDF/AOrsyHMrDr1tODbwqMb9hgJAhkv1eY5GgzYLun/g5h6E8U+BR?=
 =?us-ascii?Q?IMTsgRwbZyhaAAGZYLspdvwRXoUgDap77kpOHKnZ+TZumUvI6UQjWIbE1ial?=
 =?us-ascii?Q?7HDZvL9beUpQQhuqDYXujDUysW10mGQcgCz9KuBFU/IcBayyBWB7VLVBCpbA?=
 =?us-ascii?Q?Ln1hqRtXJD8XIFnn1414oIMuCReII4G/QstLHHfbjHm2utn/p0LIBOYwVKaO?=
 =?us-ascii?Q?uIuwubKSPGc56CxCJLXeighozfUqGfgpF74Kjd1bH6p8m3K47PT58nnao41P?=
 =?us-ascii?Q?BnU0gsMWx66GKQ9XOR/2UpCjLKfZMm+vkhKtd9gJ2+x+1kZy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aa23c0-8b76-48ab-1638-08df2924adad
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:22:42.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vajYsH3hRncQpXw8OZoYPNDyy84Uzk87vm+XSk1RS+1fY8zmsLqek3FVzT44O7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564

On Mon, Oct 12, 2026 at 03:08:23PM -0500, Peizhe Liu wrote:
> iommu_sva_handle_mm() runs from the IOPF workqueue and calls
> handle_mm_fault() for the faulting mm, but does not set the active
> memcg. File-backed faults can allocate page cache through
> mem_cgroup_charge(folio, NULL, gfp), which falls back to the root memcg
> when the worker has neither an active memcg nor a current->mm. Page
> cache faulted in by a device is therefore charged to root and escapes
> the task's memory.max.
> 
> Set the active memcg to the one associated with the faulting mm while
> handling the fault, and restore the previous value afterwards.
> 
> Fixes: fc36479db74e ("iommu: Add a page fault handler")
> Signed-off-by: Peizhe Liu <peizheliu@utexas.edu>
> ---
> Tested on a Xeon Gold 5512U with Intel DSA, based on iommu/next.
> Before/after testing confirmed that the block-on-fault case charges
> the page cache to the task's memcg after this change and is subject
> to memory.max.
> 
>  drivers/iommu/iommu-sva.c | 6 ++++++
>  1 file changed, 6 insertions(+)

It makes sense to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
