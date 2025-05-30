Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374622D9E6
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624023; cv=fail; b=uV09QFz174Duc6AZ9y/oLsdaN+VwBuCXO3GmPzISvPcbeNZt854131KkFwEzliBcdejVYW0Bf7wfdP1ygwl/oBYPB5jpwIkhR43VbM+60+9OaevpcievxY31NzHf81pv+d39MbSNTAuBE+wUaN7VbrII/cW/rSUar+GOLykZI3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624023; c=relaxed/simple;
	bh=2d4AF93G++/TJnHYucYMlF1nGYt9EZB84uAB2PUpBaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EpLX9kQ54O3qX/qQRM2n8BuK6XkH1L3t0UuXk0rQf7s8GZpv2EE1P7p0B5I3lUDJ87G0pXzLbrWpInb8Mm2BYlwYorWI9xSuuW3mgnVp6DYuIMdWbhQoxBt4ltoPfN90x+9U+sl6qeHQ2mA3xpK9TGpKEOReN26sLzsYqIUN740=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tMAm5m5X; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMAm5m5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QchEk3fbY9o7JJ41bks755+WpVcvDshFU/pAR+z0IEbzIU1DsqkzcGTnqjUvW7o3rIskJ+EBOyrSHibWO83R56NSPPSVcn/p1yS9tjvfZPmp/TztfBbx8cG9AtHKfOSKVW4aY4YZQL4fmbTN3/NHtxtTmG3gfWPHWeTXReXPvHLkk7bR4exHR9zLyuJa5c4dx++E+odEPP6SCLlppNTHmgMODAMNzge3YyP+smjfHRxmq6qPpsPWSmqLI5o7nguhjXtF6hJrVoGXgilJN0nvd3r0cCd2LN3e2lgI5zOoHJ/DPZuZWPTTcwmNFu307T9KEHdKJ2I4hoQXbcJEyxUkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4JPRxbKHhGWXoUFtu08Oznnuj4aDhCGA4BXXpcCw1U=;
 b=PodF16WYugWnTabGLQA9gsKF/t6yzOWRhzq+Up9EQ+mwdtmg+FrZ0/v9iG+aerM2kwuliqPX0Lh2EeZmYhjMhOKSyU1r+rBwnMM35Dxvr/W9izq0rESMuGyWAW8WJ0jtlxXnt1Bp7NDmYdfxbd9fy2N1LyE6ntKMELxOubi1OQwW3bKPhb1uZS5vU4r74uUPnI3XKZSpV93+zMc9BPDHCxINHERMQ/LStySsJTjecF1I+nMR7q424fs1r2QSDkVg9M325R8zsnvKLfemachQLPv41ki8uWR0GbsBJ59pvtECEoEzuHjl7tgEO7za5vDcegelYmoxBV0nqCb6Lqn8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4JPRxbKHhGWXoUFtu08Oznnuj4aDhCGA4BXXpcCw1U=;
 b=tMAm5m5Xufzwk60TIcjQ3KItvmVRZz7GzeODzxTH9AnDkwYnzWEAAxRE2nrYWAY/bOcLTYONVSh53w1fwOIje3LSLZ/EkW831WZN0Ab6aetW684DBLkzjz5P+Eg6NxkbQWuBxbeS4ELoDsuvnReVHeIkd8FnGeDIBrx/cryog3Dj6hIzMNuS7NKGXpG9DhP2Cuq6YSnd/6RO2IV+/YRG2KVsfaSuAdEz98N07McoC+B8yotYB4YQ2Pu3CxmCD6+tcvF4wmG4AN6mLIJiCSZzt96DZOZQUouvp6COtXWMHkA2++ruT04JhX2lsUUOaiVtiwt6W1IBXkBvkDtlKABpvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 16:53:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 16:53:37 +0000
Date: Fri, 30 May 2025 13:53:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250530165335.GI233377@nvidia.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
 <20250527000511.GK61950@nvidia.com>
 <20250530095112.5ed4c249@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530095112.5ed4c249@DESKTOP-0403QTC.>
X-ClientProxiedBy: BN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:ee::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a332c5-fedb-433f-42d8-08dd9f9a8574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v7AuG5hvIvWJ7f2fSdsi7Z1C4eYnJ+E64MH2M/WkmDz6OUei61H7mUOGljBm?=
 =?us-ascii?Q?mQQH95lHugO3g93DmG4x5Chy1QmifR7Zg8qHwtcskSK2r0hDzZHcTIg7DeyQ?=
 =?us-ascii?Q?Ao5nUBVLd/oT7gdnAkPTuIy6Iu1YOJzwtoXs0KqFt59eHALjAQ05fGxpEA1n?=
 =?us-ascii?Q?7ItaeKGSjePUS9nIoaLgMnTHxd1op2gXFAXJypYzku8rrSHGooClZDEiGA/M?=
 =?us-ascii?Q?jYGAeM5rQ6PjbBl6oy3AM3JcPdqTJgvqPBaCQdUWqmz+nomCIRig6VYjmu8O?=
 =?us-ascii?Q?Ci05Nf681VM/ld9rSxuX4IN84TpJUXH08S3zLAmUZfjS8MquMfg53bvi39FZ?=
 =?us-ascii?Q?+QBmQEPg//JVvGDa+Zls4yETokDBgDGy8umVuYpBi3r3Ae1pPEhf2Kp4/2lU?=
 =?us-ascii?Q?PsSKLhfowpCSBYGxOlDxq41jr1VpQWiXWtlV3nW1xd1q5ElRjVRYV5LsfKeb?=
 =?us-ascii?Q?uH5iw51OUmqkX5cffXsirFKznfDuWVTn6vhT7E2D7p6lu+2q55WLwzE5CUh4?=
 =?us-ascii?Q?hInkqT0itikuzw6DA9ZauE6BjYK6MPSqb98AH4bUPKDCUvTkfp3SHyvCDpqT?=
 =?us-ascii?Q?zkLGX2cC5iChW81ja88nFFQyQMZCTPYAnLEtij7+AANpRvZyX3lzTZsWZc6A?=
 =?us-ascii?Q?aXKBCW+/AdanRDCESBKmHz0hMzsvHPTYRKNpnV5rJKa+pbyQfTVCODdq65L9?=
 =?us-ascii?Q?D4QAJpHQG18VVJJavSYeoWCri760ChSVK8T2wxfalLGPLGFk+vsFoFTtddeA?=
 =?us-ascii?Q?+FKGixIPGl8UdExzcuHCPeHCj8st+qg+aRFjRP+nNa2uSLO3S1A6itRxQ//O?=
 =?us-ascii?Q?1jfdVtvwhD4CqK8TN7DXETKZUM8r8CyhoQYBwis4Har1ldEWTfIsNq7X1p6i?=
 =?us-ascii?Q?qC7vhDU6Eg2rfxhpqX7WmHAjeUYpOyhqAzaiUIqyn2fr6ZJ9JfFF6RSy2P2P?=
 =?us-ascii?Q?VKcKc6/yDjPubpXNrrosCUMVfT/PlCxw9oEjGCvHs1q1rPYk+JhDkSa4uprP?=
 =?us-ascii?Q?wWYhFE/lUpkYlgMnMfPuXU7Qvn3+6eeGkZ26L+n2ebKvPdCs5AjjLFDO/bl7?=
 =?us-ascii?Q?Ri9HKzAr/19Ah1ILjSzPo3EjrhN+FQZbdUbNNL+TRtO8ZGU5qIMcvgI2YZAI?=
 =?us-ascii?Q?KvyocofNQBtGdbAQoi3mv3jpQuNCOK9sxvMeFKQfuIiT0sEgZYNmzuMoxhva?=
 =?us-ascii?Q?GvEKa2VWn3RnNocDdQuCTpHvd1KgVO6TSTZPyvXDxcdY5vLMR9fMi/uQ9OpQ?=
 =?us-ascii?Q?1cDKGF+VriZZDqHegxEmmjZ08T0W0+LYnrCiw64x5oP3IAzib88PfoEeoOlu?=
 =?us-ascii?Q?0E/6Tv+rOiVAK8MmMbRUQocURUlfFihZkqOgKAJYRvsZgdizRcViKA7lQ45k?=
 =?us-ascii?Q?OwIYqkVVkLywhBNRXTFoFPB5pLSUpRcx/E7JGYHL2VsBpf2iMSvZo0Ce286W?=
 =?us-ascii?Q?SBImksV11Dw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ou9ELKPo6x4XGXPjBluXT8wvOHQBRXveIx1L4qEbujQVgZt9GvnNoPfr+/4K?=
 =?us-ascii?Q?4OQl2weyPlQOAqcZK8If2W7uOLHr4LfSSWmAmLr5CblT9UruOrJ9cW2Y0YiV?=
 =?us-ascii?Q?mx6Cnr7qb8lnYpMYKFtFv/mjb6OPvMM2MTTp8WcCQvyQhnzrXknfrEi//Mdw?=
 =?us-ascii?Q?cBXZM4weYsdkd4cuk99/u5xQ8gpOyZ4aXtQNUejtQowvDj18RZ1pax26RMEZ?=
 =?us-ascii?Q?7LxKL/5r/DEl6pl02LZqHSJ3cUHwHwN1uhfb5wTQPC2BYLA87bySHzZyxoQs?=
 =?us-ascii?Q?EjDozQj93m+ytySOahB8In+oYZ7IbBBRTLTQVZ1L48ba9uYOAnJo4OqpB18P?=
 =?us-ascii?Q?ozYk0NWt3yt12gaVPK7RL3+mLRSdA1v8KZbWZ62AKI8fadHvAMq1D17cJ4q4?=
 =?us-ascii?Q?GjOG94l23X+mhJIj26OYEDhakgyFH0u38Q4bRlnBa7uTbkfdNP/muxdLRxhI?=
 =?us-ascii?Q?Y/QdN8nVHX3/TH60AHpDhfmDKPP833bsAB6ISF5OW3rWdYY87iMP8NJGTPpB?=
 =?us-ascii?Q?lSui2zAyKlNZQ8AI8Ey/t+CQxLyVkUrw5s4iqjTGl7OlGjnS3hGPdNfRR3Rl?=
 =?us-ascii?Q?K7UotHRlTxlK2YkacW0bChG8E//kdhXaMrYPqtWL0KXgtHvyNvX0OyxvG5kN?=
 =?us-ascii?Q?yRKcygD8HrKZDfNtha8N4WshV2KaHeZ3DMXHNEx3DaHrifz9+uMO2lpCViWP?=
 =?us-ascii?Q?UjC/ugOKF91RfO+PGu2FLn2wFu1TjrbPQBQBEh1uUS5dM3N30AnVWPlKLr7N?=
 =?us-ascii?Q?/NkxptdVS25Vdiu1VA1IVfihesPLN2XLEir98U356QiW0JjYPig7pTHIHAJR?=
 =?us-ascii?Q?TR6skZG6zHoqHLl0i636oHbQQBS5x3SApPkxtlnqsa9BxwpCKfvALbQBIMJn?=
 =?us-ascii?Q?6gG/iUmvbJN162oHQxs5iFMM5Y9aeOcKm75jRLtMGc8uXARM54KpAwzUzkFF?=
 =?us-ascii?Q?L6sZkTifA4IMXwlo3js+JFthJqZVNzUeWrXLlKVPVJlkzNAf0oTWzguOVKJC?=
 =?us-ascii?Q?2UhqIj7opbBc7zaHr8PazHG41rwOsp7NN6xdIMIeZlsdBkS56BT0EHjpYucP?=
 =?us-ascii?Q?qqf6avkBV0U5/xS6CcBZMyFrTxm5nfaeyzCOntdazTsGNGQi9kqQ5IkeKmJx?=
 =?us-ascii?Q?8JHRf9l7q0BdxsO3lS+SlnMvSyR34ifw4MRAfZWStJZSGJKjoNM2LeiDLC42?=
 =?us-ascii?Q?fIVxpV5Gergb7tt+YyeqCK6CnBy9nEUFrmH1jjQb4Q+pzqdlKpBFlEdpkzAp?=
 =?us-ascii?Q?suKJA9+io0Wji5NlpK/vE2oa1jpI0zzfNKv+q2aQVmIdIlPEDptgd5qBmXyu?=
 =?us-ascii?Q?Sk4Yy45Q/NpNDiRh6IYhL5deZe4WFiwPB3aRCrYVNb7+PvClw9PwXcv1eMkK?=
 =?us-ascii?Q?3koJwxAoxWZLFT0m8YU1zdVbMN0GSUodLWpjkpCreGF9n2igGzLaRfS05JKv?=
 =?us-ascii?Q?GsyphsFOOZ0RrP1va32ZKSIOTQZc/pFGnTNPaelNgGYsr24DcZ6yM2S/FADf?=
 =?us-ascii?Q?NBda66qDykjQn9BdmgayEDrOcCL4MGUE0Nz2z2U+L+dIiStgWQUWmXV+RXx0?=
 =?us-ascii?Q?Fmvm3DzSp5MthAd8WNigh0tyrQXsUt9H9a5nZo4U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a332c5-fedb-433f-42d8-08dd9f9a8574
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:53:37.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ke5Fxwf1AtLKNkqfdTJKwjMPCCUY++T+jIzdERDGns1iReXqjhc6IWTTiwvyLGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

On Fri, May 30, 2025 at 09:51:12AM -0700, Jacob Pan wrote:
> > Maybe more like:
> Looks good to me, please disregard my patch.
> Tested-by:  Jacob Pan <jacob.pan@linux.microsoft.com> 
> 
> I guess you will submit this?

Oh I didn't think it would work first try :)

Can you post it as part of your two part series? It is probably
simpler

Jason
