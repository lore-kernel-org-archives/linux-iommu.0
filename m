Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202243ABD
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433998; cv=fail; b=PsVGYupga9gyOgryqFB0wkhmuBWvfuijv4W9wlvJ1Rjcv2oPS6YX3mdhK7Bcl9LEz1W/Ms0zuSqMXGrL/zoQdMO5S0XocQesKddDrPGwWJWZ9LAhBz9eqg8mdQ3551qoKncQA7w9x9YbsNsWRBuAS+8CxsF2TrwRewEasL5EO38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433998; c=relaxed/simple;
	bh=+kOAYnOT4O2Om4FLh2JbU0tHfCGsutHveclSi2YIt9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSCur6+6KgGCYWltMqcVH3XmYoX/eVEDdl0R+83pVJ2c/G08V/imfIlXHMfFNtfLRV3Ws4FXFjQ13nn1WukpYonWj9dzhYxMmREClNJiHq07Te71x6nax1g7/tjQFjLtjzVb0KuFlIerRslH5s3bO/5U37F6kqI5bJxKI8ah9Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQciL7dw; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQciL7dw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzU1gUe13J5VORmg01jxR3+AEJrkaDwcDkM3BGI+uWg7efUWyZ9iWTUYdEstz3E+Xl9QWKcGciDitMIvaWckt8ay65CM+CClHowaesAEmJYrDj6rfBjx4r6CK93Re6OweOHTugz7tA7EuzSMDtUBxlrOJKJJm6V5GcdMs3MYJgei5ERDoF51AI4te3AsRPJETZ8YNxjO+sc7UkIVkKCxooouXDIRhRKtEOyxUyfozHSMUvevoWjZCx0u+0M1rloTU4WBn5sbMEnNxvSIHMjO9VMfIbYkYiFLKsd3qfvlc7VHmhKm//5zY7z2bNAj/O3ZJAFzHiv4EmlAHK2icW0qdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI07ZdVR0q4yoeh1CRy37bsiAqC9WPaLgSlxEIxhM74=;
 b=X10aTjGij4qPaz4XO9VUcMp7QJ8rsxiBh30NSsGi5iUP6DKxqfA8k2zQy2PFnUhd0FGiVUbY2xeUUYowp6Zh2fUf5cR+YqUQ39N0aqsjKPN9QL+9qRGs/G08PXtfctJIvmtd0+p4CUySlX0jOGUPg2dm7YMb8dVe/+vSKENzz8Zve6qCgFd7RWsJb/1SK9MHCc95BueKW0GdXoAW4sA0FHjNB17847k+QqmGlcFhtIP111703q9WrfKXXkS2V65yBZkl8ovvi6UVzAl3BhHRUwubXohJTIYqUeAYyWEFQwH3dvu+vsR+SQXI5EYSfoNPa8GBvI1UiVObpNhc0PIeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI07ZdVR0q4yoeh1CRy37bsiAqC9WPaLgSlxEIxhM74=;
 b=RQciL7dwPokXUkRBBB/hTi6yZQsOslWTfLKMaQNz3R6WqvHWC4MUKLtjwQ24Kpw/KsCZ7kq30EWSnK3JFnL9AEO22Eyigx70DhLQ0RXGJMLe+fYXkEUTZ0tzj/k0Uq55tQS6uc9jFU894b+aPcNjvH10pNNKpj7/VREM/sfMIM4AzHymPckHR8+dztXY7W2yTxG4MM/rVGdIfuo3Mz44mH40+yQ5eH/Zw8a7iIaosV6Ffki52AQafo81K2eZ2klTx6alW4bKox/d0MruK82hb1wt/p4MBKgLxIOiJ5uAr5OdWPgbwYPFHzNq/nIWD+VgzThJJKRWv7MFgv+Yw4PJ1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 20:59:53 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:59:53 +0000
Date: Sun, 15 Sep 2024 17:59:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 9/9] iommufd: optimize file mapping
Message-ID: <ZudKyNtw+sCcq/dK@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-10-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a726d3-4d4c-4f33-73d4-08dcd5c958c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5URm0YZiGk4CqXcBpxuSQ7CN8oUkHIq8XhXWRmkD+KV2i7m9rGiJmyg3GACN?=
 =?us-ascii?Q?mcUpnev2Rz6TEyQTsYJz7SgG4BzvGYWYo6VgSsuUvVJOl9CKQuPz+qTIZxXq?=
 =?us-ascii?Q?IU1apZDbv6vy2lBE9kbYyZ1ogttcGHAfxuoNms//bDvmY2860gQZPRkeHEk5?=
 =?us-ascii?Q?1m6VSQA09uajHfAUTvkBqcIglee8mCu+O2E3BMH02mA/91FNmAWTvByO85/3?=
 =?us-ascii?Q?RtDNhBr/qjDuh6S8KSfC5dVWlJRqeEpbUAiOhFQ/zVTxkmDWztPPql6ycBAt?=
 =?us-ascii?Q?m1XOZ9wXAZSNRn5xRwdLdszrgCfgqQmR89Q1/vN8bSDjcwV10gywAse3pFFS?=
 =?us-ascii?Q?X6MIkxdBO/oy3pST+DaNShbpb8N9oscX0hGQUXB4mS4yeC//bHksU0NQe+Q7?=
 =?us-ascii?Q?NfL3tXCi5KVOlFfBHhmnH63iRMAY/0YEW9JxdmcznQO4VVPAYjAIvttnrcgN?=
 =?us-ascii?Q?xnwgPR2m211BBvTOYmZ2YUktPfefS+aReU/SmoKKLnGH8cK+6r4xHi02YRMN?=
 =?us-ascii?Q?kGRHa0GRaDRfpwiWqoR9G4seCpneHofuoLBsLfyFwq61uSjrP8y+d4iESy8c?=
 =?us-ascii?Q?DiYENpa15mKDs1fcEDuMHu6rBC9Fqt86pxQkkVtkDNV9h9Mrcc3AnSHScXhV?=
 =?us-ascii?Q?My+hZYL63fqhyyPTsGBQzZYraJkQi4bEHsjp7XMe6Wc/FhDFqgeknAwdItxS?=
 =?us-ascii?Q?+Tci+Uj1rqA/O7DSy0hRPcfqboyW5LL/oP1Tqr5gUMz35qrLCcHETd7hzkIT?=
 =?us-ascii?Q?XRf2a3j1r8F92kBbbvSiQ3QOWrbhUQzpsFA2HKnvmwtPXLKvuDTZyJpwdZ/N?=
 =?us-ascii?Q?Hlm/u3a2d0fJYky87F66m/5i4EfdrUDGzab8OT5KanWYhqF61lw5fshwRqWb?=
 =?us-ascii?Q?FghdYfzY3upQiEtqkyWtdSorhHcchm3cAYhojDXKXDUH6XPvYJ3cDOY6irSv?=
 =?us-ascii?Q?fL8UmN6e+kwIg4ZIx+zxc3mrccW3Qu+2U36e1baz6FZLfs7UsZwiuQN6FWFx?=
 =?us-ascii?Q?OpgWDAUOcYAYS2stp90jy7R8Y3yKKc2iTvI5vFEIX8thY/FSGnoSM4sFdN9I?=
 =?us-ascii?Q?6fRYI6JnH9oyKqRdDR1QWUhR2zuKyOjwQEqmqG3Jj3mx/nZ6dtp1q1OvNY/F?=
 =?us-ascii?Q?rw/Z7xGQvF1o+zrhRAgx4q7ByAJ61xRI35bOGSxwh4lhaYd5BzE2OlpwYah+?=
 =?us-ascii?Q?k11njCiuMJpqhgdFuYAYHxqfUGrUqvFeumFr/hH+HlWxtR99tt5HY142Gmyv?=
 =?us-ascii?Q?wdSiTBmt20/H8v7LL10Z0CHRmgjBmoROdroG7Fgy+Arj9dugCIWww5ErRx9b?=
 =?us-ascii?Q?4ax/0nuZ93J13Rg+nruuBjatzuDyX2RQG0DI/+jJi6aOgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdfKOuV+MTCARwBs9ElI+fpPtpY1AcLxa9jTSeTsw+s/mZ3WgL3NNeEB3X3j?=
 =?us-ascii?Q?iKXwknJ+snCyUqX5Ic8YcOZtiSUV9DjxxsD0JqNEvzpaEF+QkFtpnyhW9k7C?=
 =?us-ascii?Q?9BeLcHcxDDOvWDcPZOUFcNXtrGXHheRPEadK8MAVFRLx7leSGTrivOU8a8Fw?=
 =?us-ascii?Q?x/Z9QFQ+k7xmvJDbzU2lvb5D4ukE5wrdKrzZGVy8QsRFevz0FiIlOL8T5tPv?=
 =?us-ascii?Q?cvYBixJDpBo7WlzHGb7EVrGQtUDwum58uPfc2W0vJi2FS+N7CCwNdJIZ9ePK?=
 =?us-ascii?Q?ZHXZMPrFM1bLobaHUpFAIGuuHHYZeICiVFTDB5ERgWDhdYUXOpJd477H8VN7?=
 =?us-ascii?Q?fO2TZgLiM5qqcievwDTWazlDWueo8f6JJGTZ73VNey7kwX35i/jr3kuFsZko?=
 =?us-ascii?Q?Fh5OT2NopAOEfoyaUOvFKccAiOlcHjOFksEuW++aYkoCxUrFYflrDZjtqK4c?=
 =?us-ascii?Q?QgVALUQtxEm34MOuV09zK+A9DGGNsvYwqv2BLQ+W4Pa2PPB2DG86wDmffymu?=
 =?us-ascii?Q?vkw2b6Nc6GwomHB4ODxkirTk5SAcyk2D1PPxc3yeptxY4ZT2XRvdqax6YIHu?=
 =?us-ascii?Q?E4VsISnegUXe8ft2nf8l/1j3PDXWI+nQE6CV7BOAEcMFxu+9SZY70wgqv6fY?=
 =?us-ascii?Q?cK1B9NLSiv0aeXZr8lpc2vEow71ub83a2R3+UUutqaWaHmeoxc+WQjKzrqjK?=
 =?us-ascii?Q?Bd/8cB5C4HC6i5icNhbsCIvr8Gc9Sksb6K3TqNPk4rgTLA1r2xzSnYrIYdKM?=
 =?us-ascii?Q?j/oq69pWUFbHzFoupcHMfTq4tWOR/Hv8H2shNBUCYRDTzthrnvMyyPY6RTnO?=
 =?us-ascii?Q?nJsfc7wgeVtoX+nK+9M8U8cCuQZvFiJ+a1DCW4NP4MjTqAyboWa7e6XW8Z2+?=
 =?us-ascii?Q?LgdTLu1tqBf7+puD5g4EOPsc9Cfd8ZVHWd8xriBCM5RATyuJRU/xAzSrjTYM?=
 =?us-ascii?Q?HMKqx0e8DNfkJAS8Y/a0GcwrCPoBdYJql111aobBcmCka9Nk6XeV/+pKV/xp?=
 =?us-ascii?Q?waebjmLBohck/ruPg7MZQVxjoYiFW0rOPburIg6LlMpVHiPXXrldLP6zoNPe?=
 =?us-ascii?Q?nsJryQFKGQpHGAOC+DG+MKdJTBZyXf2k52/25hgXmxWrQDv+L2oIe3anWheO?=
 =?us-ascii?Q?iUC5DTSPhclcvyILyg78k1YAP1hdJaqd3CX5Z1AQETCwAija3OhbC1JhC97d?=
 =?us-ascii?Q?Hf3DSbnevno3OaeHDXaXaRudk/V2juivoF1s7RI3SavqdOXjcrUTnKqJNm56?=
 =?us-ascii?Q?yrr6yS48GeKbSs0k9LT7Ty7BMvPUoRXWr32o8mxpsIdPwHhdyxB3iMpHfAZt?=
 =?us-ascii?Q?YMRkhVrzqHHUSvm+HT3KT/zD6L6j74fGN+xNj/wUc50IQ8jHnTRJ0E4MROk8?=
 =?us-ascii?Q?z4ZDpFW18JQHJHHSFokz2BcuTeNbypfu+h9SeaCmz8w+dc1k0MOPtaD6kXV4?=
 =?us-ascii?Q?oMV7l215q1/f8DVva9+H0ydXJKok6d0lvDsEeogQpgIPh0BpvrUDnZunFWlE?=
 =?us-ascii?Q?n1xTXlRMIqwpI9CgOZvrdl/Q5Wmo3b8S7m3r3GtR03P5H6Hm5kbUBISXe1Wc?=
 =?us-ascii?Q?752x9HlCgPTUCWbg9iow/8kNapbfFmJW7JqySpVr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a726d3-4d4c-4f33-73d4-08dcd5c958c5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:59:53.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCpcoLtId8LFEIlbWKPxv67+1FPNuWIGzarlOV+7s/+jpTxEKAnRZX8895UJ2aEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

On Sat, Sep 14, 2024 at 06:05:58AM -0700, Steve Sistare wrote:
> Avoid expanding a huge folio into multiple upages[] in pin_memfd_pages by
> adding a page count nupages[i] for each upages[i].  Provide the function
> batch_from_pages_num to efficiently add counted pages to a pfn_batch.


> @@ -695,6 +717,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
>  struct pfn_reader_user {
>  	struct page **upages;
>  	unsigned long upages_num;
> +	u32 *nupages;

I think you'd be better to have

union {
   struct page **upages;
   struct folio **ufolio;
};

Add some batch_from_folios() to do the logic

The flow would want to work the same as the pages where you fill in
the ufolios array and then trickle it out into the batch

Jason
