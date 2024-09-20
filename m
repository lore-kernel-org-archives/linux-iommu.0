Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6514D44F
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838922; cv=fail; b=QKoYyIgkk6pJ2I7EB968Jd3MRQdPZycFxzXZtogUZkSqeZ1wPk+TolDTLTZGd3oS0a1NX0V3SRVURo/5D9gGwF2027bewCI+gLDltmkzyKfa67HC7f1CjNmuzrbyDz0vToZbALQscaIvnskhWWtVeuLCBku61Fw1jNkQk8mCBEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838922; c=relaxed/simple;
	bh=eq/D8bkhAB8PylXdqC/tUt/T+a5bHIXGjJwyvQw2T0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nI5krj21pueXunekjC12ZJPxfDkzZOnQOBegyTJocw+1o/2snrOjDdFlKL77ZRGglUpsKh0rqm0hCsEKUl0BKjoUBBwnVqgWy1+bLU1FyCg2gPy/GlpEz9nNkQqBgZlfnZSqjicoHI0dq5kGxt0X50sCY7+U8eVUdUxQKpRpDs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ej3P5+ul; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ej3P5+ul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFSCvlLq+IjhNctOkcsaObXJJBfCGaQ+VUFJ+MabR6pvbRa6mabZQZJCEbksYBsouIRtbay5wk5jS29Gm3Yild4BHxcu32NUYDglCXMT2ly4KJrycGapupGkQbuOzqdz7HU0/L+/Rzs5ozThwn25vWN4moDchRFmy6HqPV2/Osvo/i5RlMwNEgewjos9RuOSLH6UfnLHHNUkROZRxew4r5HBvtHXhwK2W9cy5Q3HDEYilynpp2OKQKRh1/wvH575VwKAgIvOqDSH9PW8Z3wbCEy74D8cZxGym+5CVgY5/11zrLiTKRGZngl4rartYS2jV3hXulZz528s8PqWs6LA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGCdi9xzvut2lg3Pj8S3q0mDQ+xB02SKu4bcVZ6kNuI=;
 b=AbYDS9D79xCVDqXeAhjrg5v4wS5U6NT2I3sq7MinKLrillvrch1ENJHCFEhXByGO1yZShv7svN4q7cnViNJdv14t3FPftxcp1rhiQtZJ+cpkdhkdz9TiKrzENhM1LFQ7Qxqq66gRy50/9xb869NQNJ3bJakH4dMeuHLsxEes9zniaYFWxew6RgoYuR+Xll+orDDzrBWZNtu8EYVUiZL9Pa6ysWCo4O32Ec8x5HDebDKRBk01LYYFrBuLd/uuZ5SKoPR0IKtQ69Bhm5syFg5UsLxFJrio83jEeVW4D234Q/gWrIxXKE8wzELW4tM8FMwTv45NtEz/HLwHwxdWmJCKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGCdi9xzvut2lg3Pj8S3q0mDQ+xB02SKu4bcVZ6kNuI=;
 b=Ej3P5+ul6o27/GghUDfiRicMn6nXMHuh4znUyEupe7hO3P0qgvoT2StwNE6OTh+SJzCfG8NO+Jl/KL8lgKzpTf5FpzwUJgrGsDIzgnzAIozDIa45xBI38hqDHQJORv6ejsRscPJfFbBxekxV5WKj+FWmYtDqRKTtqVOXLKd6O27Iozryl6DV1hd6UyEdHVwDktLIsqa70hUIRFbN3+D+YHNyiDpFBJha5uxh1sLf5GZh1oFpKaqWu86p6WWiq/eXgk1qfp4aABn8lgD/1w0QUfiGtcVEr45rMnS6ddaub5dKLyBvyEv2uMo6LJDWwnNvkDQaY/2TeTXk+jZx5W+gsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Fri, 20 Sep
 2024 13:28:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 13:28:34 +0000
Date: Fri, 20 Sep 2024 10:28:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
Message-ID: <Zu14fVDpw1RWYevL@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
 <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
 <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
X-ClientProxiedBy: VI1PR02CA0047.eurprd02.prod.outlook.com
 (2603:10a6:802:14::18) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 96749f65-c38f-4158-115a-08dcd9781f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LR2dRjNoZ+1lFDIpHj6hHVhXdKjD3QVVpAvOWqziP5uk1DmN0GP+ElgdnTC6?=
 =?us-ascii?Q?VpgiPX6vAXYXbe5vkb46s+i3BrajfzqakITvuhM4p+CnY87jJ68JBpN69giT?=
 =?us-ascii?Q?088/LYtCzz5OdIvI1gOkU28Jg7Cj7UHIb3BjdHyMo1PcpgUspOfMVVVhxVGp?=
 =?us-ascii?Q?NE11U2EcPEjUIAWzyMsHq4nNFx5PCLLDjmmRh4YB8ybAqZJFizNinyhisES9?=
 =?us-ascii?Q?m/qqR1isb5eE900IlX6nm+QUc1/ydQZYiuMUDjbybDjJvcVudQI0i9hbjMhg?=
 =?us-ascii?Q?topUhOVXdgpL3d1ys/D0auudYWAn73vWRCfu6U11ViIX0+f8YWcbffcGYPjK?=
 =?us-ascii?Q?4IUZdcBv9QxQ8o8GuAiJEjJocqRreZJAuFM0cUwMpW6/1Mdn/SwwuHrk6+mX?=
 =?us-ascii?Q?HjDsxQrOgd+syftdUqQxBXz1GIoXbHgmoLau1yYMZIsCl+jbkPWHgBCssN1g?=
 =?us-ascii?Q?VuY04YOFw806g/ipHMjh+RfaSKMal0/5ydHyZYu7DCJ0DlbWbVXl65eOCeKd?=
 =?us-ascii?Q?HpeGcYhKQZXLi8wOXqO4BWRYzc0lxdZsMp/AyKcvVTjtQb5oH7adMJnCULzj?=
 =?us-ascii?Q?pxhgLBnr0JVV2eDtiqxZaU0/23AOqQ0khsoMuLhlmsSnsoJx4Ey7VEOmvFUF?=
 =?us-ascii?Q?SOgCpS03w9HuQMek+y4bdF+EshbJqVcQTDBNbMMznEDHtvVLi1oOoold12XS?=
 =?us-ascii?Q?XIDYK/gyCaUrBk1csOvVh7wFhsNoxOVI+oq4RKuRp2jv7G7nXnG+nwIOmvNZ?=
 =?us-ascii?Q?chm6wclB/Ad9mjmQREjVyLhbklUdUXzCW+ZL7wL7rNztGbgQk3diWBbl1+tA?=
 =?us-ascii?Q?dxXUN6KGChamJcVVp77B6DShspiaP2mVcf7CbMsy0I/eNDqek/LzecLpblS1?=
 =?us-ascii?Q?bqehYN9IKdEvsi+d1TMmfceqsA5eO7r1mqKTCQQV0+rS9gORKTxul9C6ELJZ?=
 =?us-ascii?Q?xe/NPqfNLzQ6L8e2UIN33qkeLGYzhFjAn35lQG+WQgj6Rjujmgppg9A04kUj?=
 =?us-ascii?Q?nUWSwsgTxHohJzFTMF0zwqFjWlw4bIlJ2QG5zuqLBZI3PuEGrXcPRK6t3A2d?=
 =?us-ascii?Q?bkK4ht8G6QNxclklHy0BduwImh5CigKphcOayhO6ce33COpqBMeAtI8rFPlm?=
 =?us-ascii?Q?Yhx8lhBSYjzZ/3cZpsxpeCy52CwmHNA7/47APnIeanFMcBlAE2vlBsJhjQSz?=
 =?us-ascii?Q?83AJPMftfc43ivtrgSTNZt/5g1w1WD0V3YrLdsfTEk3rGzlzQQhUmNTjK+Uq?=
 =?us-ascii?Q?ZGfXt46kke3Y7qzSoCvvBemZw8CupWBbc+DBXdVcV8rQOJgDh8iEm9u3ou2r?=
 =?us-ascii?Q?33wq+1b0rMvPZLTWX1ykFH6Esp8nymbKVNW9fYNMihaX6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZgI8Co3PBgIqLxcEiTGFTSLPDJMSaJejyxsEpMrjPTEO3HpCEZjoD8UgL/z?=
 =?us-ascii?Q?PwARgo7aWNJeLBh3zgXkPNkEMaLcTqvfEnrhU0pyeo8WqIm9tzNK5EEQxTz7?=
 =?us-ascii?Q?eEGcZ4I2S6RVnLsS7i5bZNPJzRi7pgmXoG0Ta4e6RR7Bo/8Zd1gicC3M7MLA?=
 =?us-ascii?Q?miknj7daVriDTxiM2bLtMiXcsDAlvNI8rYVhlwdFv0krWwvIEtR2MBPzMsV9?=
 =?us-ascii?Q?d4LUcmE6mtSHPB8Wu15K2VQn8OVwQTSXAlhb/R6qstyKGSZNDmeHzAdeIv1t?=
 =?us-ascii?Q?YEOxT4++tqQ8hEggyZy8qro5OMA8q2nSA8LqLHsl1IWKMxnQ9cO2u6gbaYO7?=
 =?us-ascii?Q?FBrJ9wgohN79at2zW92M0KvZytJRSt1UOD5BRS6cw3Op4WUPhFWV9CseEo2L?=
 =?us-ascii?Q?3c2aF5i51myOAWQ0Zw+dB3ZpOKFzuwcHYRrzn/isSALn8un7OOTUL4rkq9vL?=
 =?us-ascii?Q?qyzyIfeXSmobVST6AFYsGOLvyi0yOEk8p3I9/rz+CbGNXgpENFxEZn/F/ILE?=
 =?us-ascii?Q?piQCyzUijrKiKVWPHeFKuFS/f+ZSDk4jJ+e5iQO4YpmTLDFNz19srWZs2eQi?=
 =?us-ascii?Q?44YI4Wo+S0ox5oLOCEgsV+t2Ay6+yNF2/6uOpxEIhz8s/4veT4PZvro9lTTn?=
 =?us-ascii?Q?fKZC9OgSvN8Ir5lNWIFlI9D8ix/8zMGQOJ24uQCFAojDllCqX6PfJmM0TVtt?=
 =?us-ascii?Q?QLWHsP3+C1lGvAqgQXIx3gzzxH7bQ0WcVlbkD1oOD4HhA0PSW8Kz8KTLR9Gj?=
 =?us-ascii?Q?R4APEpp7zoPfdaUblWqPcAzr4W3IpR3yRU6XXZ99u0ucrevP3h0CpQ37ESRS?=
 =?us-ascii?Q?QVIMdo9wVuRZWvUu/qMbxok2JX2hOazmyLxFC6X9wqo8xBsywtOuYKnO0UEK?=
 =?us-ascii?Q?CYYnF+uhlZFw+26TPXZw+zLPF/N8YD+hhIrPwRRVsea2w0OMlK+UIDnG4T6i?=
 =?us-ascii?Q?d4zfkAnoJdJE3HqzjVbrnsuMOI8nMe7cngVVTdQLeDJb0YikGmSXcj/NAmuy?=
 =?us-ascii?Q?7y+FISvmPyeNDn9YE/zKeeVO6+oo4JeKlUwmH7UeO/PDTOhx69SmOGT5Q6zM?=
 =?us-ascii?Q?JjapVFvLaUkUY74ns8pkzzydWqo1u+LzGIZe89BWotEJpKUJ0gEm0ySCsVGO?=
 =?us-ascii?Q?E7y4iXJsZ8xG9CVs+Grfa5/xSBGly8dT+PW8KOmqLersBBKL3J3ytLGDCUL/?=
 =?us-ascii?Q?+nijgugqzs+NCE5wJ6ROPNEG1A663pUjMcTMWT8f1kOovIwbZJGeXUAixtDC?=
 =?us-ascii?Q?uXA7DAygWBJ73m2FYWKq8AlKuegV1WHJskTXXhfR5ANZfn3kF4QBMNWFYar9?=
 =?us-ascii?Q?9rMDNcx2YJMz4iaf/Z0kLpcyTwLIe8JqhN6aWqgUUBHkaRvri3+krijvcFG4?=
 =?us-ascii?Q?64YkNIqSdodJai1bfoEwazMa08lwdCMzK30t3haEQunW2OF0xHgxlHg4/DLI?=
 =?us-ascii?Q?AI5nbVe1wrlS7HLh998mzCEJEojAjXShPvICSHOm+zXtvNPjVYWwCqfjsOv8?=
 =?us-ascii?Q?YHN2CoFm4vgw818NYJZsNjeUYLD4t/4e1pGj1RuSw6fkQ/0f7a1vtLe6pSbQ?=
 =?us-ascii?Q?tKa/II6pWjGYVir0eA8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96749f65-c38f-4158-115a-08dcd9781f95
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:28:34.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bmB8TVaWvfuX3nIHdQNeMbAhD66NnB/jaxWZJDsxv1lrQFZlPC54FkEEw5c65f1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001

On Thu, Sep 19, 2024 at 10:11:38AM +0200, David Hildenbrand wrote:

> > > And repin is really misleading. We are simply adding more pins to an already pinned one ...
> > 
> > Jason suggests a better name in the other thread.
> 
> I would prefer something that simply adds more pins to an already pinned
> folio. Much easier to get.

Yes, but also nobody should ever want to do that operation, it should
always be part of some kind of "splitting" sort of behavior..

Jason
