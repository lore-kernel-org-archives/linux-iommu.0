Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C816419
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115147; cv=fail; b=JryWsi72zUOyVgahDiI+U6lq4nK+vvTAY1BOllRi2ofBu82EN+QmGs9VyCwjT6qpOrCd3hKsei/gSa7i7Jpy2lY1hhNIas0n/PEu+j3bm61xC4nG95ifyNQhYLKzBsHvQpt4o2enlCfa+jYM+41Iq2SagVSywtlf30KuLoWf7Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115147; c=relaxed/simple;
	bh=KNuqqDNRds9eFzyoEcmt1VFZbPdRVYvTnTkrHEAWRl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cjr+K0B2V7tlyZWAoh3WESzSww2WtfNtqxR56TeWkWUAtw8XlaXKDFmRrEuOeCj/IiODaZIVMzAsJ+b4QaCOqTPKiu5mOFduInkx9N7Sqk5D6JJNrVzjX1kbdapKTkC7fcJIR7d0cA79z7wG1zsADgbRP1fO8pSvn2q4tt+21Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MsAQHdPm; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MsAQHdPm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqridgZPkFEOgL3A20t05SBK/ylrNQzxLyNHXDgSPJw5Wxrph5cN78Deo2TA7b0M5rOrTrLMm6m7QpK9UOIJErKxFnqaNbl6uMCZ2Ems8DWFVOhNoNcxDJR/UqdeWj6BIrq4TWVo1hMstk+MddjDdDNCGp99SQ77hp0/fpeHS02XS6uVvFHKNRp/90XzUuKy+IYasfkvdGffy/e55HGSOy9FGcyYqyN8YRogQSL9l/Jq93BS2b4J0JOyLZ9/hSQ/+hrTAHH0s02M/MSR+hnQL0h74jnNXMPVGh9CSXkhb6EO3R0vYCZEmnFCOk6OHk7ctb4XqCXiSCUrBf8eo1d1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNuqqDNRds9eFzyoEcmt1VFZbPdRVYvTnTkrHEAWRl0=;
 b=bqfkEc0OnYSXE2MSpecQ+V//LQJgcyJ5tj+2FWPZn1VWcl/zlrulTn1clTkw9I5Q31M/kJXuMMdYxVJEZT7FF8K4XCpr9EN6OSHwcRyiC4qW/O6DRG3QffC75g76h0bB1Cg1Ueg80UqOU+K+tQDV5SZSDF9ROu5M99K25qS4ADnlRSYK8j40X+qkSlXWhLWjgHNWh9WTfW1Ah7MZwfuhFLCKCzsf5PVB7DA/tyUwfTAJ9Zi3MCdr7XbDCEgMTkj2yqn56eZtcYXd3cy8FKQyszoVbT5eBMKpK73tDWcV9rnE2+MZMXErsoG4FkJxXVpPVLkXgvUm3UIdiN5C0SV7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNuqqDNRds9eFzyoEcmt1VFZbPdRVYvTnTkrHEAWRl0=;
 b=MsAQHdPmedpOQFWm4xZ1dean0A2fG1lRpZ5JWsR48G2/PIo3Mg4Ddzp7/yyN/zCJEWmZcgME+Mu0POqBzeDWrOedx1oEapzmIXEGDecvYInlxkPMIowbrcym0EoLosUtOITzFv+6FUTmCZYRsKm89oSPdqzORg72QMJMoKWCu4jJCGY1oZ7q3fWQPJ1mBklw5GAmqiT78DcWDEIMWAkvRfK1hKpUO0bjW+kXdQGkSqP9DzUMZCgx7Ch6ZwjZcUxeW4HNMtjwGDTetjZLYF/7ZBW77VsNPq7Qu2rIq+vuxXJoidf5HYr04yUwyHixjpzr0SlJKToebmCwgl1E2s3iFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 18:12:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:12:18 +0000
Date: Mon, 23 Sep 2024 15:12:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, andersson@kernel.org,
	afd@ti.com, nm@ti.com, hnagalla@ti.com,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <20240923181217.GF9417@nvidia.com>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZsdktJEqR9BOgivK@p14s>
 <99c874f1-3d85-43b2-a3a0-40e1e0c25696@ti.com>
 <0dbde87b-593f-4b14-8929-b78e189549ad@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dbde87b-593f-4b14-8929-b78e189549ad@ti.com>
X-ClientProxiedBy: BN0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:408:141::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 6554f771-3e1e-4a29-34b8-08dcdbfb42f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uA0v+xMmW5iMB/LX2jg2lf9QXYxePURxrMlqcT+eqEAKInJUQToqntVq0aDR?=
 =?us-ascii?Q?kXPkJgH4d1JC5RFmQye1ap++1tDH/EIEhjcnAESUmlnhXsNYE2CO+zHoYT4A?=
 =?us-ascii?Q?q6O9Eq/yV3J8wWinKY+kPwhZikUi4Cb3B1dGp5zlQ8zKr3WxCE8+OU0RgjiE?=
 =?us-ascii?Q?fxWtevlczyTkMApPKZh46FqbqmV6oovAayamFfl5Tz39VP+Br/RJjpYHbIv8?=
 =?us-ascii?Q?Ba3X52dTbGbnJMf+yUaMWvtBVPN9iY9znvQ4dsI1TZEmlYob6/H5RpPLrJ5K?=
 =?us-ascii?Q?8PvsC2LhlKe+giJ3UfLEKlqDFyavvMrbeqtFAT/c7hSCjc2oqcTkfkZJ2dir?=
 =?us-ascii?Q?kfUtMZvRF9kWBEqTR+CupU72pf9K8pi1HfVpUOtSuJHzdI7DFsC8DD8SpqSv?=
 =?us-ascii?Q?SptNMYIdKn8yM4MzJv8Wk/UG+kEgjCMggppemfSsoHateqSe65/YGlwD80oJ?=
 =?us-ascii?Q?i6H3NTZ5siPFL3ZATtIpxVm/bMTQfLmdlI+9dimbinDdNRm4GPcopuqvUdMT?=
 =?us-ascii?Q?TuJDIMhw6zdifA7aOIIpcKI+hMYn5rT6RoLupQNuOPCPCI+dGSa1sgYKtzjt?=
 =?us-ascii?Q?k6nJ+d45D1CaXSiIJmMbaxt5HhYjdqMuT8yViNsWQtilSjFqhoIgNnTKaO45?=
 =?us-ascii?Q?T5D26aToUEPuGF1AJvQYZaM7rcnwsJFriNXxE6oECTSLgRdLUNq4srguIwmK?=
 =?us-ascii?Q?Nz0wddfu4hIedbugxvKnRpeisl3fj5PJsfp1IBsVJWzyrQ2MlRtZ0OBSxDRY?=
 =?us-ascii?Q?tv7aMOXj74/2ht1zbI8GnVMepv5RG7dvlAPDPTq2HMheFUR7nmCjxxtuW2h3?=
 =?us-ascii?Q?9NP7fXY6RJwOz/lPXpJEMHpDG68vX5ycEUIIkqvaIfC6Mc1ugNqCQEq2X3cr?=
 =?us-ascii?Q?hLRMrXfYJ3qRJU870JAhhcykv3hm7Goy6sYQxSYoRMLCAtalcKtQUMhJl5XF?=
 =?us-ascii?Q?faoDQCoMs6/7kWUhgXYbf/NZi0hPAD+iweRqkAqAQgDWy9pP9DxxjX2uSj/S?=
 =?us-ascii?Q?04QpJd0+Qjmv48TENeMKw6engreG2Va/hUB0L61hVJPQ26ZvmEavBbtA6Wr0?=
 =?us-ascii?Q?f3xjAFsDK/GenaKb0+z9FUUbUQQR4Kmqf4k395Aro3osNop6o6y0nuAy0Odu?=
 =?us-ascii?Q?CTutvlPJIN7jmskRvKCxZsiiIqIdGN8qGrvF02xJUrDPRi6YrYy+iMT+jceC?=
 =?us-ascii?Q?yoN5L4JNrI7mALMtBSK0sYfk1fFrSuDWX8eC/UMmyF/+3Qc3eV6hVjrl5jY5?=
 =?us-ascii?Q?yDnhyCwQqHGLoHQqaaD5NvPdytTlzCA6y729g86KvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X42pV2gxCqbDSox/dmakjcveByb4W//6vITqVCeZuQkh6YJd9y21N0y4XkxN?=
 =?us-ascii?Q?2FG5A6qct64vZyObXSHsQ0TlWzmKBmqMxLgMzij7Ph9By/yWA02YWRL/jrvN?=
 =?us-ascii?Q?NedB0cKnzGpiJt+9y89FF/fdme48OK+50m6xbUGZ8YI7cV89o+ecIkeb7CqE?=
 =?us-ascii?Q?8Tk0jqyZqwwP6c2kW5XI9lQvWJqseaqTLmMrYMiR2OjCHl2nI7VeKAyS43sO?=
 =?us-ascii?Q?Dxt43UFqx7d20JoLQGaw+9tDSgpi5aENvKeIG1pFInMtGWwzzsJcsIJazvmn?=
 =?us-ascii?Q?9WxdDhd2oDH9US5Q/64/x59quZ8CRC6+0qhRlQpzf5TKldQMu+t8t8WT272Z?=
 =?us-ascii?Q?Zm/kuDsfi1bJCJUDPUSP9X8nLfrsFLemclh8j/Wb0c4n/bRhI/8IGEHjG2un?=
 =?us-ascii?Q?sjf4OlfSeEiNZf3DblibOcRXhNAM3tvzDdKRhVn7PU05msm7UlqLhHmHPO21?=
 =?us-ascii?Q?yeKay9KkC2GoJu+tUnQfVUry+8S0LHXjfP42sgOIxzPKmHGWn6uSEhiL+xNA?=
 =?us-ascii?Q?5yh475Ww0zClojwsUTgY6mRZ9r5g1oAAZS9FegpqBTzNaFq80fNUH70e0xxZ?=
 =?us-ascii?Q?sMP3Cufe4EJuWD2d1iiLayFFt4zqq7fCZyy9q2kkWF2vjPgkWuEamLXpdFo1?=
 =?us-ascii?Q?E61zBBLZPsrlRK42UffcAk++53UsGwIIVNKcPlP+UIQ1ZMEMCa5LZVHpJ4xB?=
 =?us-ascii?Q?WkKEWthrP9g2689MJvvD96JkbySvjnZSdzi6wI7QmAoxmqR5sJSWtr8m+WL2?=
 =?us-ascii?Q?nx8+gifpM615fBcd4nWgOVC5Qocsl0H/BxAz3U5ueJSW7Mg66y8+hXPx4SI4?=
 =?us-ascii?Q?Y2ycJWakJnCdn99DCKwY0kcQ2BkC5GzyVLHRDqJcoHTwR4TZHsP0CvuDp82K?=
 =?us-ascii?Q?1IP9/jhKVOnfJDhWZHLItc/Qhiptnv9s/OJ0mUm0CtvVG5dpvVjRB+QTGl1f?=
 =?us-ascii?Q?UhL19m86BElh3/cgvLU/fOTt9FwYwpIwIi84WLWv4vtD8lUDZKWBJRyAN26g?=
 =?us-ascii?Q?rJK0TCCBQrjMtgLHogIvsEMICjFAktH2nuPVdzdtCoiELCA1+X91TFGQFM1t?=
 =?us-ascii?Q?6f8GxYOCyH/1Ps44KAqcgPxOvRm9i20lrggAWKiNKL40GNLdKhW5XXQVSMA7?=
 =?us-ascii?Q?gKVcLiTMGhdplXonkybQh7cExTzFtKivujnoqdqy7Y6oLfU9f41HjZ88l905?=
 =?us-ascii?Q?JzqKj/KVBJjdXZBckz3jRGGlKyjsVPaDKAxmiaK8MNFTepPyJKDR4bw4uzSe?=
 =?us-ascii?Q?VQJk0o/67EWqffyabclw865Qmp1OQ6Ue9Q7XewUmSOQnQmsyTyK6BO2IQKMu?=
 =?us-ascii?Q?TmrDesBreZaRolNJuibohGyQ++gjeX3zg/6pywEksMCleWUu8lj+blJSUftS?=
 =?us-ascii?Q?9e3gN776SmklMuDSv3ELRtTq7fZD5dmuaSeTXvj11/k+9ZfK95ZLpPuPfaLx?=
 =?us-ascii?Q?fuptqE6sXcpex0O8Z7E13uR8hoqli1F5mVqGQl3OU9QFvQMXtJSutgJX8Jl9?=
 =?us-ascii?Q?SXRDEyUKkX4OR6bUYyC9fsd+O7I6xUW26aCtlLMqcXPAtJ0VXN21byONRX7C?=
 =?us-ascii?Q?icpS2/7o7geYS41vXfc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6554f771-3e1e-4a29-34b8-08dcdbfb42f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:12:18.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e32h1BBWlTKf0dunO1a8fx0DdEmT7F75VMmZKT2GfRTU6Jh6ub6mQJb5xpYk9TQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Sun, Sep 22, 2024 at 04:57:07PM +0530, Beleswar Prasad Padhi wrote:

> Since commit 17de3f5fdd35, the IOMMU framework has changed how it handles
> callback ops, moving away from using bus->iommu_ops. The omap-iommu driver
> has not yet been updated to align with these framework changes. Therefore,
> omap-iommu, and hence, omap-remoteproc have been broken since 17de3f5fdd35.

That commit is a year old now, if nobody has cared to fix or report
this can we consider removing some of this old code from upstream?
Usually a year of being broken without anyone caring is a good enough
threshold.

> Acked-by: Beleswar Padhi <b-padhi@ti.com>

Thanks

Jason
