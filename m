Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E91DE8AF
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526473; cv=fail; b=rB4fzukFJlmvfGp4BqCnYWneFgA33uydHFfcoZ+r5DxagI32idAl2yb8MFhOGoGWN3X3oroUvK9JrcyQT/7vxaRmH7Ii7gCx2D+Q+gbFY9qZglSjeAOa0ok8hYWu6bk0haHVWzKS4P3WGFI1rQUlCUuyawua9h3bmPSwtoYgtPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526473; c=relaxed/simple;
	bh=P7IlR61nnFzzs75k2GTn67D4uqdeyC8o+AgYLgl9aOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbxeJPcHbnSao1balE+65NsjDzq8bLh/4lMJDsdlXOUD0BrKjlk+7S/TfsgwZURKph8epyzWkjckLJmdR5k/AjaMwQTdinGcqobnutmbNKvcR8fVlGThaus7O/tQokEJxPlOUcIPzxQ4ARuL0l1pKwDx6pPBfMOOAeen7Hc+2lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hMC2M/NJ; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hMC2M/NJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6Pb1a7N34r4eDZDjiDN+l53RtTCOv9KytETKtBQCaQyNH7t9jiRP9fGawRxqs7rZOB18hoOIEeyLuqxCUNCHyI5MbFrErfqVgxTeM8LwHWIt80dCCNG6IVxMAVyc07ZPOSmrD6Edk9ZNQT6GYhb+2dxoB1PgkJpa/+5shZ7oZkL64OHVFhLg4sm64PeFNek8dcjzx7JFc4fsMGavy19gBYG6OzCCfwXLrf3bqu7616gHgWREaSowoMYw+5y64N31qDecDa7ItN+8K04Sb67267KBiNJw1gpcitstr25wnn6hk8c3dbQ1q3FVOQtm3YonX6f3sdhDmaEkYMSy1vNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eGVZ3EyASeKm8Loc0j00rLDMoQc2wa5hM10SuIrcco=;
 b=Lh/YbuT6B1wgqsuZaLvpa2GKsFsx/gUYraBDrhvv2u3xPxTjIi4XI/6t7ZdBFfEM79XlKKPbVHP3ftTFgVCYOnXOKIOlfGlzK0lG0FP9mygDT9YkWAt3tVTDNd3eafKgoKA2fRd7FikNhZHGnAgeAiMP2Hwmzk+QQ34UUIcehkiJ5Zdgz3rFgu6lO0I1gWXFaY56i1lYT7k3fQfz8Xaqdm/EGzT3hBg4DMl079GHd2i13YQQeZDvIxyVzcFhdNhqvvp0M91RJQ1dLr/9gpSV5x0M8hL3e3Bbryc2O6Zj4xAXInVFudVPw0Z9BpHbycuaQNXuwVuJWQsLVJAffcxQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eGVZ3EyASeKm8Loc0j00rLDMoQc2wa5hM10SuIrcco=;
 b=hMC2M/NJ3SDKfcFxv33tcVy8ffl5NeHrTvCugWovQ+qPnCWTCVU18KcKJOuKJqvKG7/vQwJXwH+Ge/aw3+nShrjr2I4cff/3Rw1CSpx0WgW5lSQljw2B9azhhOgZ+7Jbt6CMoZrvc4tydipVmdm9aOr0MINKNe0hrtO96V0FVMTxS02sUvu9Jg2JeqwmYXaeAovlNjx4inX6nDOBbuZbRvXvWK7Drb2LkQgVzAqY0F5rVBcMtuJ3aSVW0/eA106AGn/B7Z/B5tfTKbG5n8iK4MYamtGMKP99fQZI4380FuepgXkg6VGHkXUvndKjVTiXhCcuizF/AoLKZQm+cjBbwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 26 Mar
 2026 12:01:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 12:01:02 +0000
Date: Thu, 26 Mar 2026 09:01:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Message-ID: <20260326120101.GH67624@nvidia.com>
References: <20260310163136.1179322-1-sherry.yang@oracle.com>
 <20260310164134.GA1410323@nvidia.com>
 <62EB69AA-FA3E-4820-B268-A207CCA6F23A@oracle.com>
 <20260310175740.GB1410323@nvidia.com>
 <94D79BCA-138D-4CED-995C-E89EF7635C92@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94D79BCA-138D-4CED-995C-E89EF7635C92@oracle.com>
X-ClientProxiedBy: BN9PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:408:f4::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 118ade89-0823-42a8-50b9-08de8b2f59e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kVsmwLFQSs9Uf6g4OWc/pYNDBxcv5qeUFwLucwypLdZqYYNR0K97krAaISDfcRcnd0G2EGWutk5ExeOKKRUUWoJDksiYGATfc48/Maq0olrV823m352lOfUkEkZrTyZV9aEew0fN1ION+5LhenCVtYvy4J2qPjLB7Xt+64vfqIzJqFfDzFEeupOI06QiT/nlwZ+RCD7vKDn4ATH+kkBpxvBqf2Q4GrwWkl7It2PKlzN5+f7m4WKkVSFHMRul60c55IHwVaIPbGO38IctJzqilowdyNSKqyFyyso5mIL0Xj5sXv5mPaIEISMzGsFQK9HTzsGzi+ew8tRaXWQ6ES4kh77fg5ekDjAjBBn6wIMEmx5sPEcqy6N+ZVZiR8/4auaL36nULQBmtUz6zE3bdbr1NLU3rc4f4iCVznK/itpXHSOnjM9YjI1LzMMU/uwiLnIyNkW9oBZEy4Cu0ndW4ivjGkDcH+md3tu5tVbFz/gGL5HvLr8JV3rTWTf0LI60t90WsFlaqSYjibrzDy6+LMHHvEY5XQrBpFwIcbxZ+kUzxuzZvf1yYDqBk7kOgcgcuJVn0CW8vdNs0GepJmRT+RpSpAlaLcKIlt83+pWKGV1QN+9Dlid91d3hqoOa8gpTtfsFszPDiJXZ4G9f/4Mw6/e/qYrJkL9u/zYIt+zImMJdIEBCW+eHHHVOQVfO4JpJNO6psIxtVAD4dzP/rS9+qaRW7svUs/yPXs9gvpNPOuzOUAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGZydTFZNitUcm5KcXRKakxPRHVES3NLQStFT2dBL2loZFJzYUM5ZHpCSTZl?=
 =?utf-8?B?ZnZwRGlCZXNtRnFWTFhGcEMzOXlzajhIR2dndVkzNFpxRGNQd05wK2ZvelZy?=
 =?utf-8?B?Yks4REZKTDR6dWtLdDNBMnU1TXZMajJGODRtbjRkUmVIQ0FKbm5hZkc3OHc1?=
 =?utf-8?B?a2gyYm5qWEVFcWhEWGttYkt2TUhJOW1HdjkxRHk5OWNlUmJjREFWMGwyUEZX?=
 =?utf-8?B?Y0Z0c2lOdUNySDRsMjNZK3pCWlBnek43TTljb1JJM2ZBTmMyeW1KdW5xeWpy?=
 =?utf-8?B?YXNMUzZTR3ZoeFliZGtwZVNuS05GQUUzL3JXRjB0dHZYd3ZXaXVuTCtqd09S?=
 =?utf-8?B?SVdVd01uRmk4Um5vUk1PM3piUGlvaDNtbmZOTVp4L2NzMkswRXIwQUgvNjJq?=
 =?utf-8?B?VnEwLzFiTU1PUE5KejFPbzlJSWk2eTk1d2hWSCtFU1kzdU1OSmxsNVFzMU5n?=
 =?utf-8?B?Y2FlZGY2OFF3eWw3akpaVEphTmxIZUYydTdYZjV1WTh4eE8yeUdpTlZIRVAy?=
 =?utf-8?B?dW1ibytQVmd0QkdDK2Jrd1VxdFM5WEJFNzQ1QSt4R29rZnRzYTRWMk9PUUVl?=
 =?utf-8?B?RTRwUnI0WjZWUmtDZmdFQjhnMnZJakszY1RqY0xSWE5adDRXY3RCSTlrUVZq?=
 =?utf-8?B?aUN1Mit0bEluOWJzaE9GcGx2cEZLdVduTml0ZGFDaVJqVmFON2FHRk5ZZ3Rp?=
 =?utf-8?B?SWlKdTlwR2NEd3FaSEVNVCt0c3BJalVIZElxeUtlcW9XVnVVM0dvNVJ2UEN2?=
 =?utf-8?B?TFo2NDNUendHMXJTTUE2MVgyN2dIYk9ISXcyMVVoQ0tTKzlhR0dpVEtMWklX?=
 =?utf-8?B?MDZCaUt6TEpBaHd5cDYxcUVzTlIvZkx3UUhmMmtVSUllcGlhaktRalQxdWVn?=
 =?utf-8?B?KzRHNVVIdHRna1lFUVYvWEtVTUl2QjBnbE1qWjRtTS94RytJVG1URlhpbHJX?=
 =?utf-8?B?TGtQR1A2WjJ2OVJkaXMzOFVGYnJwNFRvbG4rZk51Q0I3Tjg4YldLS3p6b2tS?=
 =?utf-8?B?SDI4VGdLYlJiZ2drbmxzTXZlQlVSRjhLRnRYK3hSdXY2ay9GYkliMWtYbWhq?=
 =?utf-8?B?RXFxdzRWckNMeFUzdEtmYnJvT1NlT3NWMEN2QUZOQVJzeEtuRm9uYXVUSlNZ?=
 =?utf-8?B?SmkxU0FBZHg2V2NSUjFreFd4amNBQytITE5zY2paNmViMW1ma0k2QTVWTzhp?=
 =?utf-8?B?M3ozQjhUeTlIRGc1allYREU4M0FOd0U3STBzVXVWT0Yrdks0NVozRTVrUDI1?=
 =?utf-8?B?dmlSbjNrRTllNVRxQ3lhZ3ZwVTNqcnhBSXBhWXJMNlhJek41WkJwcVN2N0Mz?=
 =?utf-8?B?VEtySzBYa3N1cDZIVzc1S3UzR0c0NllUSGY2V0dVTWliUTdQMW5sWVEwWmd1?=
 =?utf-8?B?SHR3dnNaVHdpT29Lamp4azZIdHJDeXQyM0huREUxWExiYnpsbTM5dlQyak9H?=
 =?utf-8?B?ZjJQcG9uSmtHMEE4K3RENkpZUWVNS2ZuV0RaeUR0cXpOZlpGdzQ5ZE9MaHZP?=
 =?utf-8?B?ckN3T2M3bURKeC8xY2lBb3lzbFFOT1dxWFUxUkdKY1pQNE55REdadEdnZFpM?=
 =?utf-8?B?KzNac0NqMkRyR292cW95a0xDYzc4Zk5KaDNFRWwwUlZLTEw2WTNFbEZpMlFV?=
 =?utf-8?B?SEpWTzdGZGh5OGxEM2ZpbGw4SkVRQVAvTzBaa2EzMmlTRk1DTGRxUnJ1Nm15?=
 =?utf-8?B?RTlCK21XUlBlVEVJY0NYMHVKZ3BJRG1LWGJzbkNOMWpwd1J6dHFqdXFTc0NU?=
 =?utf-8?B?c3pLYWtJMm85eFAycEJ4UWhoTTRyWitCZzhCNFphczdUWXgwUnQrZ0pzK2Q1?=
 =?utf-8?B?cUc4L1dQOUJNRE5UcW0vT1pvd216enVFT1FaU2kzYWJSWDFrN1I1N3VnREwz?=
 =?utf-8?B?S3VoblJpbnl4UDU2eHJMNFFDWWMzbE0vNWtmT2R5QTZKWVJSQ0FkSXh1VUUx?=
 =?utf-8?B?czJpVzhEUTd6bENGWktvajVXRkZzbnNrNVhVbkFtWVAzYmNZRjZjTHdUbnhP?=
 =?utf-8?B?UlR0UlJJQ1NwZHFxSXJVL2RISUYvYTM3cDZ3N0VuSmZYcmxmb1JXN3RxWUV5?=
 =?utf-8?B?Z1RrVW9RMlg5MFRoVGx6MFgwQVQ5Wnl4cnNFWnMreDM4RHkzR2FHVEZYd2xr?=
 =?utf-8?B?WTZBbFpSTHhNZkpCUFkxMHo3R2kvMkhrK3NWY2JndXJkY0FqTkppSzgrZFdI?=
 =?utf-8?B?blZyWmpFa1l4T053ekRZbjJpM2grbDZLQlhIeGl6eVlqcHNiVzVUWHkxUzAv?=
 =?utf-8?B?azFaT0tnejY3Qm80S1ppelhNcnJVU0t0eVVVUGxVWk9TeVNuSmRZNkw0eWNF?=
 =?utf-8?Q?2Aa1CDfLl/+sZQBPsf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118ade89-0823-42a8-50b9-08de8b2f59e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:01:02.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA79DPBB6RAjuo2nWG8dd+259D+9+dLktNORu0XonoY8R+jT8RbyblQNOQeQFUWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851

On Wed, Mar 25, 2026 at 11:39:37PM +0000, Sherry Yang wrote:
> 
> > On Mar 10, 2026, at 10:57 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Tue, Mar 10, 2026 at 05:17:31PM +0000, Sherry Yang wrote:
> > 
> >> Unfortunately, I ran into the FIELD_PREP build failure with
> >> 98d5110f90ae (“iommupt: Make it clearer to the compiler that
> >> pts.level == 0 for single page”) already merged, which means it
> >> doesn’t work for me. I noticed you mentioned clang 18 hit the same
> >> issue and fixed by the patch. We’re using GCC 14.2.1, looks like GCC
> >> still constant-folds the contiguous branch despite the change to
> >> pts.level.
> > 
> > This is all a performance path, I'm reluctant to add more code for
> > everyone just to hide things from GCC bugs.
> > 
> > Maybe you can rework this to be only when gcov is on, or maybe you can
> > fix it by futher enhancing what the other commit does. Perhaps an
> > always inline annotation is all that is missing?
> 
> 
> Thanks for the pointer — marking amdv1pt_install_leaf_entry() as
> __always_inline fixes the gcc/gcov build failure for me while keeping
> the original FIELD_PREP() path intact.
> 
> If you’re happy with this approach, I'll send the patch out.

That sounds good thanks

Jason
