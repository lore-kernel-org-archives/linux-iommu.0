Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBE1DDE9
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948862; cv=fail; b=Izu4XauV+iHPf/PQb7tRSFVCR1e6HJT3W3pTQ8RDAZChQpvlOxxhbPguWxWA17rD/dd/zBtF4DF33dtQKopW05TvzjyikAGlSroJAe9j7j+hivGV+jR0x+mK594vIQgTky8MmpGQstsIt58rsGBYw8IAvSH/2GNxBYEk50J0GWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948862; c=relaxed/simple;
	bh=0AbmQiwdTelxttj4vBi1GLMI8bXUbtJBTuk+yTAFUnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IUD9SBJg8KXq8uuEWdcfBM2SIKCZ9py6N3bnNIWviaFlyv/ld+ZFKbODZmWBNoKrg/jL42Aw7np5rV7w56xxWgBPvEsU2pT/2BzheT7frFtx+fmBAfzkmHg38gYpZZF5C9cwqDVtDYezRJpnVJRaOPGTOy4XT5zZknXFBs/Aco8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EVpuRMD4; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EVpuRMD4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqpy5Z7Za65md/2sT0cN5XPlPKm1bSZQb3egsNqv3CiP7aqPFQLIx6pSaxGRpe/lRxLom06PylO+828sT/MPFTcAoYqO/7KpjprlzGrNr212519TnoZDh3WMxc8d3EJ3vxJYVQyby12OKrQOUFaZIOWcrcxBOScwEm+EhZI72U9eo037LIZvzlx8VNUeFw68jRnR4IFvBX5PaQrtN7h1+RW9lnXO0eqMjUf3PqWgK4OYHkkIBgxmP+ta912AGTatwiJZF9iU3IdvIHyZXkYONAmG5R5z/Kgm4L1O0Ebm2GcKR+QlWMWIZdiHi4Va9mRdifoWIMEmDhKO4KZ0k9vcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNkeR3kO3CixEI7DAmqPfjrTinpWIf4NhDi1CmR8Wyk=;
 b=WFf+Bm+9sP9qfY//JGYbDkWYZeW28NdVEu5KTticP0+OPPE52Jv4C88pmq9hmxX4gTp5QyRBT09JWf4xT8FQTGCegkHRB8l37E3eBaCviLZpmWNZmMm9YOr3ZCOCklKWXAVdGeCCCziKlgKRShreQWuliRJDb0KvQNPLAaRi0T8XnxRTgfPFeGcvl6EQJ8qSI3tArerVwdXTXTU9zpgXBUWGLOJ1S6TdWg3CyfkkM6jLpK4MYXrzIJR2fgWy5rKtZ3wBwttxdjbMrS4dVhUfB8kzZmaoGzqM+0UIXVize37GNtVlHfP/3zrv5YefDwnw39RepSslCYleYTBkERe/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNkeR3kO3CixEI7DAmqPfjrTinpWIf4NhDi1CmR8Wyk=;
 b=EVpuRMD4c/II0WEsZVNVx6NnKt6IOXJrThK6Iir0v+NZGpKzhSkY8mxIK9FY3t8HwILvnioJYHIdLDCFVW0r5Dx0cZQ5nQiyZPQsDhCGQDt9e2r9qPguJbElCaU0T2vE2qgY0sD9N2kbLlLDdoMYoYu1eqmWdtI//7iuE+RyqIpy2GMGXC/ojST12SlGZFM9doANNKUqdViPUSFcGWu0y9xBVkPInMJYrAS7TB92Ha6Ol8+c7F5dc8vosK5dlj7zIaw2wW9PQhNhpQv9LhGfnR3OCRnYmlB8Pmh/FsXGZgzR1E6TX2rVJ5eqn56rLtQ3eou4sFO2Kh+jwJ+AcRDmWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:54:14 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 12:54:14 +0000
Date: Tue, 6 Aug 2024 09:54:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 4/4] iommufd: update VA
Message-ID: <20240806125413.GI478300@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-6-git-send-email-steven.sistare@oracle.com>
 <20240722155139.GH3371438@nvidia.com>
 <4bb35338-f7a1-46f8-b439-5a3be0ca274d@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb35338-f7a1-46f8-b439-5a3be0ca274d@oracle.com>
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfb3dfc-10ad-4f4d-a82b-08dcb616dff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hkheexb1ofAU7QPUeFCowH9eBaPllETbX+3wLWtV46Z9h8a2csHf0GxW/yqy?=
 =?us-ascii?Q?RFygXj2+/HyVhKF34EiKvbJejI+6az13wwSVDBsbL8H/O1X71zHLv+xaowes?=
 =?us-ascii?Q?DsYNyzhJFcSNGvMOulYHpX/eJqbEYF7vrO5LlooGvmxcA6OIAnbsSVwa4XOo?=
 =?us-ascii?Q?ZCqCyvhpT7llX8xZ77MSRO0p4+ipnGoPxTX/mxcpeFuJhAV4h2dN4oOZY32e?=
 =?us-ascii?Q?9sCJfANZsB0Yxar39Z67+DYwiK17JslwQy1fudyReh5feZA99kTMqstWXTfZ?=
 =?us-ascii?Q?XYHlAVqV1WHDKQ3OhG+o1MXIBz9eDTVo83B/l9QcExssKCooTVNtC+yb8/LC?=
 =?us-ascii?Q?myblapvkhh/dpT3MvZO4YIikjeiUM0UxJWktsgFHCGD5Cg1sKEX2LicJMm2Z?=
 =?us-ascii?Q?onba7Zq8wuITL3FpUAkDSgynrP7UGL//qi4UeU7SRwz1uqZi4PuPmrUk/oMH?=
 =?us-ascii?Q?EaZAq1m0Sv7kipoi8Xc5GfGa6zisETsJ/L6tg/YUg1e1IOA69kqieoJJ9ijc?=
 =?us-ascii?Q?TBdDLa3Ol1eaiNnlSrFHd3P3vCDf7NYfO/+FucuWB5z+oONFkUj1VFwrVhM8?=
 =?us-ascii?Q?N4kYZFfrJ77HR6t7MpWjNmetw4lWXEcV4ep+pikLEpYuPX46UppPxWtxMVBc?=
 =?us-ascii?Q?WHcnoZF3G0VQPiezOaSgZ6FzLRGJIWvEtVb0qWsk20LpxnqgfgqB2GNDBcvT?=
 =?us-ascii?Q?DXqo1p7oR5nYgIvsfvMq2JuNa9RbVdTUETRdpcEuXXAadGz2Yur9T/u/gxTN?=
 =?us-ascii?Q?N3KAXgeAiyVlrXUFiotmG1av2rwXRPYMTM4dWRoTJENEUUbizfNdGBvFhcik?=
 =?us-ascii?Q?Hp0Y5/THYMF0Rtiw1D0FvpfTS4g0b1z4b+dHCv/hQKGhP7e62ezcacbkPSNm?=
 =?us-ascii?Q?yxRJUI0tjtGMn1sbl29cUOg3rznI0MtUUvnIHMA+gzIavnacjqRvlXKaM5uJ?=
 =?us-ascii?Q?vSdrDbIW0WXeAODyXK1gMfa1ZNDNYElxbNAiP+mUk1QPDPbmzQTyf8Sz668L?=
 =?us-ascii?Q?j8vFuha66LuTlOnFAz1VtT/+gJzGXqYpFCR+xgLpLfFRpWyKcF8czxlSTzLA?=
 =?us-ascii?Q?DBvFJntQZYlSF0y3VXAebcffDI1pKiibOT0oG+Xa7RcJaLMe2gNQAsUv8zj3?=
 =?us-ascii?Q?aJfP960GSUZ4D2DfBgBTiHLBaRVI9cPjJiq6bro5jGp3O0V5H1zZPsItglMv?=
 =?us-ascii?Q?PNXIcnbUsLhgNXwxMTgDehs7qL6SKWvylrHU2Ic2F13LIIEZIuG3MK2dHqU8?=
 =?us-ascii?Q?2DknTRet+c7Q1drILqj9Uh9U6IpUbQvQNaWSBBDCQF86HyRsYevSRAMviBfz?=
 =?us-ascii?Q?wzPkVtBAxq2qwXTdpS5b7OSyPD037+1Wmye2sb7FDzmJ7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvcsQLaO1oGmhVcitm0X7NTGtLIOOx5L1pRN+0avK+f9tbmWkhcq+Tj1rZ51?=
 =?us-ascii?Q?K8Ns+gopiQFdW3bHaT527g7NNAwrwLNY4A0zIuRe3JoCXNnq+f4aBmiHfoWY?=
 =?us-ascii?Q?lRnBLhOT0zOq52xB6xeYoVkgI8cn2tqhp3mUMNK0USukRgQ+HQl1ZQnIFcxt?=
 =?us-ascii?Q?NrLsIYUt71QxZEg/qYOFca/KOumHDQCIg94P2JucnEaPXvczBpTDjpAIgmDd?=
 =?us-ascii?Q?uWGJ9DIL9SZH9pOOl1snwjxhjE4SW6MI8qv4BLltYE/i0cNsHkomc3t7rGQm?=
 =?us-ascii?Q?uQT05adIvLQ0Gln9BYXcaXaUGXH3aKkb1S5pgRdpSmEghAVAAQM1NdjnXkxm?=
 =?us-ascii?Q?V7EzqGfVjmE1zSdk17YBdauQ1JBdsk3gqCrWbkyqexvxqJX5L2YE+gGDfBe+?=
 =?us-ascii?Q?88BW66SmnFUiTFnElBpVsbZCsj2zshZKL4H7u+8vZqt8aaTue/hWcUA4qgDb?=
 =?us-ascii?Q?ciUdEW9/nSjjSxa1VpP5mOxhYFeSY+XwuXQKe4JJPGlgRoQpeZsb99H/UOtW?=
 =?us-ascii?Q?eCerb+6JnY5RKjgjZCBy86VGnCxpLMTnZhmD5mABwHGLMPD9eIfEluUgQfxt?=
 =?us-ascii?Q?vn6kDgXEl454tXQImdjr0VqcqDhYYUriGAun6R2ZD9RxfYANS7B24SScQlBC?=
 =?us-ascii?Q?/u1n8vnee0CrhuPSBMTeOnhdGfJPOcfMBnYgOxNXtYi7LURdpKaniPotvCLQ?=
 =?us-ascii?Q?2iZbtbp6R/olTOdz2JpDmEBu1UfwYzo0ln/6rDZlm6VBQrSmrNcwPOMvxNKv?=
 =?us-ascii?Q?1VuXzjd+yWVraoPD7r7Kkaj2sNakBFmtMDu9ZmUR2Sa5Fp+wEeWpfjg4/fBa?=
 =?us-ascii?Q?zcq0AMjw0WcXiNLg9qkNR8Sbz9BPgz/21qvBbkX6C6Deh/5GZcHXSuBaKTTA?=
 =?us-ascii?Q?q24C+BDUXR/Mm5mvRZ9DQXaPGePs7VSY06DvtoU1SMUWr6SJso/YFr+97Sot?=
 =?us-ascii?Q?WiC54BN7FTO/J+o7T32XvrmXD9OdTzsAcG+s2hIEZZjWjlW68ByjESvo85Yp?=
 =?us-ascii?Q?Kd/XxM/hhL+TJdcijAfQVAVJx9xgDVT/NQuS/CmKqwR+3hcQNsoFTKNR0LyK?=
 =?us-ascii?Q?qHGgp/ri7sTigHhS4Ny5it3l8R7q0+Vr3ewbO4ZjvSMGmhuoy7r+MIVwFcCW?=
 =?us-ascii?Q?4wkSRnmc221XOsD0i+SfWjWBpYDpxbg3yS3/I0RDgNVPcDqBxrtVRhz8Yon8?=
 =?us-ascii?Q?h8l/c/vhNhiq5qGGpg7jTtDdbb9Oka6Umq3c6UrCzUr3rIULGxNgHircmUNf?=
 =?us-ascii?Q?ruRj3XHjETyR8w5zRMDIH5UFRJgqDpZeTYTD/WDkxDHkiAAynQfXtump3v2R?=
 =?us-ascii?Q?o7kphsw6Yy8rEv3T+qZ/kZfyQ5Mqd6qnvdXdDixjCScgzKYkkslNz/L2kHGo?=
 =?us-ascii?Q?0HMOpZlaFBOy/hNx3mfSQxyntjKWzSK4zQYrTKz2CoYwFMAz3xrk1b3+mRqt?=
 =?us-ascii?Q?MEUmjoHKqyM+8fIGt1E/XCcBShbGYDVb9lbOy0s8ZzpPPhJZHQO+puRQZ6Hm?=
 =?us-ascii?Q?oCBsFpXOpBk2VIDVFXw9wQY4m65NHm3x2CLbRc09ssFWrmpMmbgcQokfUzZn?=
 =?us-ascii?Q?qI5dwyvBYR0w1Q4Fk4MGAuv+CxVAO0pE15Z8hLwM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfb3dfc-10ad-4f4d-a82b-08dcb616dff3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:54:14.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nv1PifRtXA5XeW/prIY/dzwK77tK2xHbeNe2XFyWCJsrHwauN6qOz8I8WOMM2y1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

On Mon, Aug 05, 2024 at 03:02:22PM -0400, Steven Sistare wrote:
> On 7/22/2024 11:51 AM, Jason Gunthorpe wrote:
> > On Sat, Jul 20, 2024 at 11:56:45AM -0700, Steve Sistare wrote:
> > > @@ -458,6 +459,76 @@ static void change_mm(struct iopt_pages *pages)
> > >   	free_uid(old_user);
> > >   }
> > > +#define MAX_UMAP_ENTRIES 1024
> > 
> > Only 170 of these fit in a 4k page :\
> > 
> > Are you worried about the high order allocation this could trigger?
> 
> Should I worry?

Probably? Experiance shows busy servers cannot do a high order
allocation, even order 4 is likely to fail due to fragmentation. If
you imagine you will need more than 1-4 pages of this then it would
probably be a good idea to avoid the higher order allocation.,

> I define a max to guard against a DOS from userland requesting a huge number
> of entries and causing the driver to allocate a huge amount of memory.
> 
> The use cases I have seen only have dozens of entries.  Do you have a figure
> in mind for the upper bound?

Then it is probably fine as is

Jason
