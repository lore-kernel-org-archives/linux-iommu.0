Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65017A30F
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905824; cv=fail; b=ZwGK3X1RujuTHPBIxgM+rOFJUpgW42/aLXuLytLlBPbHz+6sGb8iPBcYqo5S9HpEAH3KTLZbw+Tzk6v1sLvxsi1gdhF3dIEuOl8/ZSMNJo9lBfEC1DLlwNMc9bKTm13ZBy8H2rF0r4vcmPHvvTuBitVgEVUu9Xh6SQk/ah5j7eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905824; c=relaxed/simple;
	bh=ruqWpGz/VXP1cstdXODu+wv9/8mOCLhdyGqWX1OI3u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDXwLIv487wT3i5mIdWDsGk/eCj72Hb26PhcQG+vDmo/mkPEO1fT7PW+WzMGTYNES1MP3lqdrqhg+fCCzeCTfYrmvR7ErgP5WnKWeF35nzMgHi643lhCcyQ++vKlSHo1n3xh1DXI4hxNNuacjtZBoFSQGRPLW9YCvv4vzlTAtV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZSmSrI+5; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZSmSrI+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqfbymj/QsDc67cec+LX9P+JURj03qSJ8ZjW6bYRPEVAE+t0+wMp6qZOgOaj7KsamSFzz9YON3GeoMgCjPSwPIf2cgBLNgRB/aq9W3U3J+5J+5YK5Zd1HfkULp/iW/ghepF0IwbeC4OVc5na5XJ6fh627aR9P/Y/q0Hf+wcy6vw0Exg7H5HOFttkK4tUOS86uNupmsR58FNdMP6ewIX5wqpt43YtKtBsylCYq8gvC4lqX4ZkLt4Rje8bGA+cIP6E36F95TzEaem7zj/HCyKPAvDVARVFXw8lcGkmtBTVr0+I5YpqJXIDQ610aMSm7iofhJrRYzOil2Z/yYvfdaoyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bad76h5agu/aipC2LD9OcxsLCXSV9eTxqV+7nCVoVIY=;
 b=sSnUpHu8e/3vQP33hhna7AQb7WwPGZfMTOTX6S9pOCEvcQ9r8nI6ah9SmZMH8xC5jueJTKuBKRVSBUWqGRisRrTzGgGavGfepsl4VuIbEs9ovresfZ8BsvEr/4zvv5wqiDq/t+jdY4mHGlIcBZs101uoa6YtHQnbybKgIkV0O9PTvWmiywuKhLyMCn0j4uyPk4e3ZMznrXBNC+YShFwW/AWSn5qB2PtXnWAIUJTKQXGf71mOEH7ka/gJEiSp+rHIp8jvmRJuGLjPLpjzBNwPRxSy+7QU2eEHM9IRldJYBGsDugkwiqW32XME6EKg2l+VE8iLZZyLiHOgu9q3fYW8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bad76h5agu/aipC2LD9OcxsLCXSV9eTxqV+7nCVoVIY=;
 b=ZSmSrI+5OwRzjfsoV0Cfh1B3HlhK15PKb1d733EcQkY7oP7vuzrmw4x1baZIlqhTmvbvfXGtP2fEh/GKzjEiulfPId3HNkJjBTCg601vxSaL4JWLlqIYf4Sy/tz0axGrlGkS4uSeYWj3CGLKY3e8M1sWh+0wYy0yVYDVC0Ys1wP9Aoh5PVBUwOQ77qYHsYIOWojaKU1GDEDuHXbiZWho6qzuh72tVaXPvmkuZG7gYKJqoS4GXxvAUZawukKsQ0HyTtJNryr/fs0Za0z5oIlDgeqXkTGl0kltjX+rB9dik+xkeY9GgYejvP7IPIbbfDphSZnuwpplXcKPED0CMvDBZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:10:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:10:18 +0000
Date: Tue, 18 Feb 2025 15:10:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 2/5] iommu: Drop iommu_group_replace_domain()
Message-ID: <20250218191017.GC4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-3-yi.l.liu@intel.com>
X-ClientProxiedBy: BN9P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc70dae-2735-4ca1-cd4f-08dd504fe22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RP5UFs6JzOGb0nZsOsWj6D3CuKEcZBeBpMStjDszdRXU9KuSkPE/6ICi0Gtk?=
 =?us-ascii?Q?iRTfzdkA+GsEzORyBWywH3kjOlDZtTi4f6mUEx4CDYrT88+JfX+htfivGRZt?=
 =?us-ascii?Q?NEFjYTMG2xElwVt9VhdI5vdW/dcJpBDyb7uyEthk6YM8Lgc6lps5zdF4pupk?=
 =?us-ascii?Q?tKp+g/dlxw0PV0Kab5wty5p0obB6s8VJeVcDbbbYSGVQwHxdfNDbxbaZFv4q?=
 =?us-ascii?Q?6G+NOlmRD6YsyUZNyCxTMy9a0CuFX1sPbx4BpyLGUhbpb9cQ/uR6SpY80bBl?=
 =?us-ascii?Q?NVhKDkCk8otN2LlKspuN5RHbohHvG4kcwWUCJSePLxjiYhSz9D0xYB8NDz9U?=
 =?us-ascii?Q?ISBsyWS/IXSGlbxVrsIHdyTew4fwDAWyXDJKVekNTKxj/7BYEqCnCCUakKDy?=
 =?us-ascii?Q?6nwCCc+DPeCxHN21i0AiF+KZsg6F6IlDrVz2CAEXR0LP4JDX1SJcdYKDvThQ?=
 =?us-ascii?Q?ZwvFgMoOZt/VoIgnyPbe6W2Ba4Ug0NmHQ4ZFUJlkcujk7x3sO45sp96OJCBn?=
 =?us-ascii?Q?ys3vFd+yZNEWZsbGuXGaq5yUzh0GZliDbbkJDeuDiCW+7j129oMdLYpj2Eb6?=
 =?us-ascii?Q?9tCKtKPiroYJxZlrLBEtxVYVr0vk/yuj2Iqo8vx3XYeKBritBKqZobHfXZvr?=
 =?us-ascii?Q?c2OaH1hib+QgHAXuQ86xd9JMhtsnnDPPpw66ZoTb18LoYv8DRSnLjN4kcUHq?=
 =?us-ascii?Q?1UXe5fF0lvc8ktYAXySPfwWTVu0wC8XwlXzpEFHmoINt17H680dKos9Xfr2d?=
 =?us-ascii?Q?S6ROdBKl6uFk4OFIuBCw6cIlduZc7EG4TCSGcoF+KuVBOL4NJvLesGwNaQND?=
 =?us-ascii?Q?S1UrkLDSCN40H28YTWH2mq286yC7xdW8xJteouBv3hYHpov68DEcWdrH/4h1?=
 =?us-ascii?Q?Bf7kGMNy3JlBYGKaZCYedZwkOhBf79dxW2cbNMdC+m3B4OJ5P6d3lqsGcLX6?=
 =?us-ascii?Q?S/1D9dGqHDPFTtitdCoeja6GprXHXTnYGhbxRwyLEambXKApz/775VGPX+s1?=
 =?us-ascii?Q?qqXLWZjOPaJo4V1FtS6iybDZWG6TPSHoNwdR/qVJf4Sl7MaamhtqNVpk9rFu?=
 =?us-ascii?Q?jjmvmwIztf/KQgLWW8yG0QiLc0obTjYVG94LrOA1rFPWBIvi5ybOuiOkmOrJ?=
 =?us-ascii?Q?uYEALAKhKm1S+8QumMnovXQVfMI3UZNMLZE3qPFFgmhIIBDXOoxx+vEr+HnT?=
 =?us-ascii?Q?2x1Io0IMAW2l9GIsBOiIPapYmObt8+fxFTuFhdL1QRT/oa0Q952odNnMmKmH?=
 =?us-ascii?Q?vF77Qtnloyb/EEcemXZK6AgFzrZxzZ4sp5B3zjOphtEamFzpBIwjWw1aEmsK?=
 =?us-ascii?Q?tK6zPm7xELGPlqALhjgCQRFr8YsUMrI+FfRnByHw16v3Dc7IXTcTrtvbKLi5?=
 =?us-ascii?Q?zQHNTH5sjB656hKEDw21s0wn9JZi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?btwx70/gugyzI0+NCcJ/JRxhPe0qftThJtiYyCxnUTLcG2/okW9Tw2E22gYk?=
 =?us-ascii?Q?dyjNYI02knfdVKjwPX78UJkLZ1WsgoEjxsZNrBkOuY6N0E8k2KG+Bm01nMpd?=
 =?us-ascii?Q?1RWRSBCVSU+p7NOr8jUpXk0RrECiU/Ff+RQ2lgVmqo7i3v417C3/w2I7CYCz?=
 =?us-ascii?Q?WCEvJsvoB13HtuFUElPDflW9eLP2FWeHjkXZMQibRFgib0S2/NDIE2Z72QhP?=
 =?us-ascii?Q?O/0kXIMuSj/Z1qZsguig1stPq566QYMFgiHsm2NUZ6GfYDEfzLeV/7EB5cV+?=
 =?us-ascii?Q?8Nk6MFyOzfIcXtSZN9m18wK87IfXGYjmbFelp9EPlaHV0JAg2HC5zu1zYke+?=
 =?us-ascii?Q?g6AGwKMghOQBFcgzWPRfWp7cFOW2NvXch58xOp39Vbu6xAdsny7YpQrb42pt?=
 =?us-ascii?Q?gf5UScWCpPhxqHo3MPVMwruDLBGNdHpXTHF1efCrv/77IOpYVBQb3HQho5KJ?=
 =?us-ascii?Q?20GbFacETVKR3LzMjQpZd8wNICXuQLnMbktYysxt4Y6hGnPgCSUbPNy0AjfD?=
 =?us-ascii?Q?LFpMrdOZ1M/eKKdqkUS3mBjFqSxozfXgD98PtiXVLmPRBqlTJF4v9mTdo5xg?=
 =?us-ascii?Q?uEesz7t8kVmQlsiLYZd9GTCyTtIV1s9queuwYamqNADdMdk8vvLrFK52kuQm?=
 =?us-ascii?Q?7KGIKMNLQX2iUpw0SpKPgp7TbjeDuH97+p6n0NCDRw01keFhLAfeQhy9xKGA?=
 =?us-ascii?Q?xs12W+Cv4oCsx8naj+9LlAyC0OCNaYrGOSBFBTcCWZA3gGwk8UcCmqbXymJl?=
 =?us-ascii?Q?1KWNdvD4oDXeHazqmlKH8g+C+XfsV1QeAFgUQmz7IhtKtcDQcgK59mQjxVis?=
 =?us-ascii?Q?ZfASeViVIDWd7DXLMnZahW+ae+6QfNY4Fp6eCrHfYdEaGmcWju+x+6jxzXgA?=
 =?us-ascii?Q?OniK0YPd85C3CrZHS/+D0uxzUZPtrgoaxT9QZDr8ZGr9ukkoZOROH/u/2azr?=
 =?us-ascii?Q?1AtHwCNHVFkq18QkbJm9hQMgH/hzmkfoSqg5ivMtnLNYrvxZw4+zsAaBmycN?=
 =?us-ascii?Q?iQ8OiksdK9zUs+WWlFJeWMWbyNy9gVEsqQAEOMyFkIisLGxJBNY1sV7Nc8/L?=
 =?us-ascii?Q?k58jiDtyb+ClVrgetcuIXFtcJ21DF7AmHCXzQCo4oc77GVqPI4omvKI4p3tf?=
 =?us-ascii?Q?dmQCTsMBqoKN0Ivo438k5bOqnK+OpzVPjuvqggwsTZp4Ah34ItCiPRw0ifPn?=
 =?us-ascii?Q?OgC0T3XrUg6LkPE60hZt9eL4ojQcFgn4WaL91tfYmmSgih/OvdAqNKOhV4hl?=
 =?us-ascii?Q?qKSvWSaH2FpL5dnbL//5xuvsHQjJz6Xh7e2qQwEe/kFczdssApqKHf95cxaR?=
 =?us-ascii?Q?tiank+aEanUbrQDU4Tv3Vkepm7ci+pQdvE7z8B8pXxtkXcrkFKdAqBr19t58?=
 =?us-ascii?Q?tOGxOrw6FrCu9VUJ01vYBegsxkrOe7FDODEdqLtQLwda8ZKvvmUrlv6m0eIq?=
 =?us-ascii?Q?epdZPfIYvKnXG1HAwCefjrgLBbbBpxS1ecDByPGn2v8uoCXr53Q3S6cZzeVC?=
 =?us-ascii?Q?xRHEf9uBjSSAm6208J4E6aV+24DVMd78KFbdAUVJ36hRQhUEA3ox3c9+2s4v?=
 =?us-ascii?Q?zCgQbzvc4apBlR3SVJbX1KJJy4ktbWfeKed7qlsB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc70dae-2735-4ca1-cd4f-08dd504fe22a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:10:18.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7zFNR7sSLzm9mPrlb99RieO0b6Zh2vQbZvaj0/1d1K/gUhKjfKenH2fuEPsDijv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Tue, Feb 11, 2025 at 10:05:37PM -0800, Yi Liu wrote:
> iommufd does not use it now, so drop it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 35 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
