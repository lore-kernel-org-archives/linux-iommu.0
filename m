Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BE1B9B40
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916559; cv=fail; b=QFVzRPwB6g8jBytbvzzXbYA9JkCV97lPCS5yXfAyEz/M9OpN2Kv1Pv24LqM4qeT9K0MsAKKMPSfn+Nkkpsc9jArRakanV4cqy3pkTe7BAsSLC2m8pTZyaT1PfNSgvAVtM/6R5hpskjaSyq1fongaNfgYV5asO2tDAvWKhfh4GtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916559; c=relaxed/simple;
	bh=d5JEyZu+KHnkL19/7ooG6JVor066QChTqNyXUYaCfMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHowdjIptHnPeMvwhODPAx0iP3VOa1LHrpV14KtzdCeDBWlqzu9+PuBXwnxT8CC/rl0wv0CFHIwpVhM4Ar5QjIYiy2TaI498rD5zVj1YjwjPFI4q7EY9PHSpIg7rG0tURwep4OXuniAiJSERFPoP7fLPLy3ZlyFqnpJ5li1jcyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfViBbMm; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfViBbMm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmhRF/dBC7deQMtwKWKgieU4hmvZJdbLNkewA3IOYUuySLTn+Ia4hfAZ/sNtc2Z47t59sHJ1KJNIuwNjNa2g9oUqfTl00txHxFJcpu5roINRgacKyG2A/D3TvcqGYIidjBw2NwzepuVL8Jaxf5JBtMtAngnQ9JcSZAheoA5JiDYo+C6ktt7JDSRrY5jmDfQ1T5H8lNzGvgnFxhVhM68/IJMDPkm01z3Q48Rp9qJg3AGPE8/KPkFroBY6lWWmmoMVNNySxlK2m6VFRFBXiEItQCxoR1MxaiGA89KnnVWBWdtmc0JABk1HnJBJ8IPG5+pKfomQbiB8VPrqXHKlc1UpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWLpyC9T9SKyYUkmQnhGp2NQYd0S3ZdKuZv9cTQImwM=;
 b=FhNn98tvpEHGPBT2luNhcOBqTLFw32cGD9G6asTWK03fRHm7agGuu8lc7wmKWAWu85N6N13KiQdPEKu68WAjptsYNGUYaKBfzLkcMxH7qoqOwzCrRxfRyHL7Nf32nE/r/uV58G1zqgg3m/KLuflu+T1LlnlP+2ql1Z5QIMxA+r467+hY7syEzWyJ4skR1kxOShfeMYM5GhsZjvBCC5aSQg8YcDcVtXmZglpAl9e3nqoW+Ht5RMjrn92x4zj+WaI5KZ8Ky8BRi1iMDx76Mzy1Hv+pXRfdrPufpy+4glIUnjlZZSvWsn9GZb1/hv/ahrK0/Yb70F5ZkIHQv5itHiI2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWLpyC9T9SKyYUkmQnhGp2NQYd0S3ZdKuZv9cTQImwM=;
 b=MfViBbMmhZ+Lphzj5D24XYgQAGUyOPd1A69h8MHjJVdCR/X8pLIDI9A83jMBRNeTE7+mLRQs59MC9jzSpeHGXsoShuzyKpuyYeAVg7KxuuVqVK3q4RUl26QrystUsFIsORCORTbtc5lbhVShipE7wN9rci7a3C4CcHsg76WwEv1qRyS6NNuKStvjcq1OvxxepvcMR00yJrk81eqmQla70l9VKSNFJ+mhBIvtKdDth3bdNlm3STCvN7/ruNtoNkR/gef/yL8TOemIPg614MCqXXQ5f6oT01/7XDesQ+eIx/WCwq+BP4G+yGrQq5LG7Kww38RoFiZklMAldTpU5v3N4w==
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 03:55:54 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::e6) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Tue, 6 Aug 2024 03:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 03:55:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 20:55:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 20:55:42 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 20:55:41 -0700
Date: Mon, 5 Aug 2024 20:55:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/device: Enforce reserved IOVA also when attached
 to hwpt_nested
Message-ID: <ZrGevEpFCntQx6wV@Asurada-Nvidia>
References: <20240802053458.2754673-1-nicolinc@nvidia.com>
 <BN9PR11MB5276B6D6A75FFDF7DB14CAC18CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZrEQt5r978B+Pgex@Asurada-Nvidia>
 <BN9PR11MB527682A9FBDDE82439A3F7E28CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB527682A9FBDDE82439A3F7E28CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8bfdca-84f1-49ea-9094-08dcb5cbab2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzE1ZUhFNWQrNXZ5cllVeERxdmRqcVMvWEwvS0QwbzhNK1RTcFkzVng0cC81?=
 =?utf-8?B?ZG11TTFTMFNXeitIS2c2MUNVSk1IZkROcHE3a1VYTEpiTlFwLy8zRVhGbXVG?=
 =?utf-8?B?Z1ZielJnbS9OMSsyTHZ0TWtsZFNvTWQrbng4V0RaSVhKMzMyNEx2VllwTUlx?=
 =?utf-8?B?eWVMWFBnZEtUTjVCT1l5NlBEcFV5WWh5YlBuUVg1TFhlRmFVL0VoNXlPMDZN?=
 =?utf-8?B?dXcyYTBwTzlvSVpHc1ZwOU1Qb1dDUmF4ZUpqczB4QVFpOXZrN2NwZjVnMlY4?=
 =?utf-8?B?UHNYNTNWUWI1NExlVXdORnBSTlBNY3cwbSt6aEl3amJkSi82Y2o0ZEdNMVpv?=
 =?utf-8?B?SjY2aERYNnowNzVKT2xOV1NUeDVONjhMTXk0WVVXWGhwMkx4OXVYUGZjR3pz?=
 =?utf-8?B?aHYwcWdtQkFUOUZrSlF6djVWblVJRE1QNU9FWC9CcWcvcjZDTkp2OGdaeVVw?=
 =?utf-8?B?MVJJVDVxdDF3WVZuNmllaFk0eWx6RVVURkgyM2M4b0ovZWlvK0YvM1FBNGt5?=
 =?utf-8?B?UUtYaXFHU3ljQVNpd2p1bWFzeE9DcWRYVjBmOHNQVmpCNElTb2QyaHhOS1RP?=
 =?utf-8?B?d1NHVGxzcU53VDE0SXB5dnJzVHFtYkp1TmxPRm01aWFkMXJYT1lCT1B1M2lV?=
 =?utf-8?B?TUdoL05mL3ZlREREVjYvRDFxWi9ZUGVXQnR3blBTdXprWFZLK0tmTk44TTNu?=
 =?utf-8?B?OUlnc0luYWxNMDFVSFVaMWhqNURpWGRsZUx1SHkreWZKVisxVG1SV0JaUVJ3?=
 =?utf-8?B?cFVzMmg5VjdnOXYvK3FNVDlTWWNzM1pvYjNRK095OEhLYmVLMUVjWEdDVjNN?=
 =?utf-8?B?MlVsQWl2dVpxbXFSQ09vYjZQZzFXUEorM25Sb1JFb3FsbFJaV05NSGVWTStM?=
 =?utf-8?B?b3ludnkzVWdROEhjUzNya1VmUjhxLzRsaGIzb0VndnNmQlV4Tm9HWDBkNzdr?=
 =?utf-8?B?aTdhNjFBSHFidVdGRXlHdTNkVmdNR1k4UEZBTmhHSGhXcTY3OUpxN1BvL3Rj?=
 =?utf-8?B?T3Y1OU1HVUJMNkhaU3BGaFVuOUR3MUF1RzBQVkhyTi9aMmcrV1MvMVV3RGM4?=
 =?utf-8?B?REJEb1RtZUIzY1VVT0FPNVE0ZEEzMTFDTkpkV1FUYXBvMTR4TmNzanpuT0ky?=
 =?utf-8?B?WjNKdDVTNW4wd24rWlVtRlJwQVJRSXYwYmF5Tmw4OTkxNDhDOEwwcjBta0JD?=
 =?utf-8?B?YUtzbzdaNFRKd1RLYzd4Q25xVHVrNmNGWEkrUFFZK0VHSElSYTcvQXZoTksy?=
 =?utf-8?B?R1FUQVYvNXp4Q0RFV1F6NCtVdURDNCtJUi9LNjJQZDR5SjR0bVRKOGU3bXhX?=
 =?utf-8?B?WFF0NzlpWjUvODk1Z0N0TXAyUHA5K3k4WjRFblhwKzhDVlFBSmdxQ3MwSSts?=
 =?utf-8?B?NlRPRlpucllZdHUxYXU0azhrNVAvZ1NZTGMvVTl5SjJZL3VOeEhXSW5nTUtz?=
 =?utf-8?B?RW5aQW1OQUovWEs0UDA3YU5TWkNCeFJnU3NPRTl0TXV5VDhvM05xUmUraEpE?=
 =?utf-8?B?VGhjN2g0bFBUL05QcjRqc2xnOXF3N1J1eDhUKzdxWkpRNHJsS3U0M1ZxWWEy?=
 =?utf-8?B?dWJBdkMxdWxvYmZ2c2pTQnhhdlJpQzY1b3hOOWpabklFMTZoUDBNaGlZNEc1?=
 =?utf-8?B?SzVOZnB6SXNNVnpvRWJtcmVZcU1tMUpVRjJhenJmRFhpTSsydVh4QXpkVmZU?=
 =?utf-8?B?aE5lWUtDdUw5VTA3d0IwRGZDMFh6Mm51K05CejcxMWpETmlWZld1TytNdkZU?=
 =?utf-8?B?ZnVoTzAyWFkzM3JOcFJTNkdPVEpiVGJxRUJSblVkSXk3ekIrTkM3OVhiWnpx?=
 =?utf-8?B?Y1k3czVXNlE2T2pLVXN5eEpYUFdvQndQK3l6R1hmR3liVnpVeWRSc3JyQ3lB?=
 =?utf-8?B?V3J4bDNJdHI1RElwcUpzWGZ1bmYyd0JoWlNFNTJvSlBjeHdvZkRGMFpYcXhp?=
 =?utf-8?Q?Iel9zBo4ZDFI8BFfB1vcP/69286bRjKB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 03:55:53.3668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bfdca-84f1-49ea-9094-08dcb5cbab2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

On Tue, Aug 06, 2024 at 02:59:53AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, August 6, 2024 2:04 AM
> >
> > On Mon, Aug 05, 2024 at 07:40:45AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, August 2, 2024 1:35 PM
> > > >
> > > >  static int
> > > > -iommufd_group_do_replace_paging(struct iommufd_group *igroup,
> > > > -                             struct iommufd_hwpt_paging *hwpt_paging)
> > > > +iommufd_group_do_replace_reserved_iova(struct iommufd_group
> > *igroup,
> > > > +                                    struct iommufd_hw_pagetable *hwpt)
> > > >  {
> > > > +     struct iommufd_hwpt_paging *hwpt_paging =
> > > > to_hwpt_paging(hwpt);
> > > >       struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
> > > >       struct iommufd_device *cur;
> > > >       int rc;
> > > >
> > > >       lockdep_assert_held(&igroup->lock);
> > > >
> > > > -     if (!hwpt_is_paging(old_hwpt) ||
> > > > -         hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
> > > > +     if (!hwpt_paging)
> > > > +             return 0;
> > > > +
> > > > +     if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
> > >
> > > hmm this change is broken. In this helper:
> > >
> > >         if (!old_hwpt_paging || !new_hwpt_paging)
> > >                 return false;
> > >         return old_hwpt_paging->ioas != new_hwpt_paging->ioas;
> > >
> > > Obviously the original code wants to enforce reserved regions if
> > > new_hwpt is paging && old_hwpt is not paging, but this change
> > > skips this scenario.
> >
> > Hmm..I think that is the intention of this patch?
> >
> > The original code does that because it didn't enforce reserved
> > region (to the parent paging hwpt) when attaching the group to
> > a nested one. Now, it does. So, we basically check whether the
> > associated ioas has changed or not. Right?
> >
> 
> that is too much tied to nested vs. paging type. In case a new
> type comes w/o parent/ioas in the future, above will be broken.
> 
> IMHO to_hwpt_paging() already resolves the problem about
> nested parent while the original code above appears to be
> more future proof (w/ the enhanced to_hwpt_paging()), i.e.
> adding reserved region to the new hwpt w/ ioas as long as
> old/new hwpts don't belong to a same ioas (including the case
> where old has no ioas), instead of adding reserved region
> only when both old/new have an ioas but different. 😊

Ah, I see your point. It failed to cover the case where one of
the hwpts returns NULL from to_hwpt_paging().

Will fix and respin.

Thanks
Nicolin
