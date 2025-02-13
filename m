Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B62C182
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451386; cv=fail; b=P5ldQy8uNAh0RFBVkzjJWiBmG8RnHEGLb9ZJ2CozWBmhsG60yK89mc+qlUooTctkTMUgsSpxyKXrqllteqCGnLeJJ+bDjfbJrGZLJlyC5aQwJ2fVIeiyN4uGCJoqcLZEwK6qna+i4obZ3pFg/2Gny2SL+r6xeU+EWXaA8MwFDQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451386; c=relaxed/simple;
	bh=Gf0jp+iLAnZjDQ//TuOyxCDA+TsKC3CCNtaNGum1ZbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7fhsKed5Kx55YY9fAO5RpLrxQe0ZdhxQLiNCIcrhe24GOZ7blwI+f8wEe36dbd0fdM9ktDc1MxnII0Bg0/pIpnl8WNPp6vidRQqloNBx/DOsrmij8JQxsg/KtYkkUFwZEE8WLoMqeRNyC76mFk1a6uitMlEjvwI7dI/9Z5xdYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oaJpKjNR; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oaJpKjNR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFx1wi7Q6xXJUXK2nIukwboY3oGt3pBUmFpUVqYW9w9aNLt36jMlEcdY2mrPp3ECwczW925E021QFPQ2G4/aJFGZc88nqHfpn7hOV98r4pA+OvRMhwVmw2Z2/Frvuj7EDA2ws82bkqFHP6V3HZOGfGzWl8GI53yT06CHRkI8JOIF/RLFNH91wyDIJVtziOpIoC4naLLwGcGpAPvMYqV1bnNSYtQRVk5dNj/GOPn77zu377GOF0/v+z4nx5XjR/PMq7g+8qRbbac6RL1jMiXh2VfOnRv8AIU9qBV8PDr5fuCmAOSNrZedtI/LM9kDJqD3U8uMyT2oMYKF0FrfQBcNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf0jp+iLAnZjDQ//TuOyxCDA+TsKC3CCNtaNGum1ZbY=;
 b=unru19HwxoWNJHINPUu1Wkhvzw6uD9TvxUl/Ha6QSc6TD54LH9gEU11cslz+EjeOCS1UlIYPmLOAMTrUrbTn7XAnF0tqwnQPbgfIopkpWUmVR1K7L5ZDEg7tMNQ5oTnKCzll1KgTFToKKNNK3Is83P4ZLTblKC+xCBXpH+zVOb9whNNhyKnhJKzDwzdb10o1AQW7hy1IjmYl534Nl/6rNOd+U5u0TOMqMBOUpY6O96crX7PIU21uDBkgG3LkGq0t23fx3na7oXwrIZgVpwuhAv5MI/PK75lypOUfQxpON4wuWbZcsFnGhdu2mMvhQbLR93WEkbIIMDlWrKbbef1NKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf0jp+iLAnZjDQ//TuOyxCDA+TsKC3CCNtaNGum1ZbY=;
 b=oaJpKjNR6oz23jqIKOS2/TalP8xSG22V1tCmFCAyQUTCo3CCfcicdOFlGo/XR/+vi/hdWTc8OMlSDqqNKPwJ1quxguLsua118t3y7vDNvUyW8nevKHS7WYWsVVIVmoDIfWHvB6fsGd7WKWHEOPpceXWUOfscRzJv5POiz29EVtmlqXr2FjJvREOcSQ9cEdzk9oMByuHTdCoi6NRTpnM1pD9aqez2WSz1bznoIdyJQ0Bm20I0/5/l2ZXA4J5AF2u34X6lvAsUJ2vVpfaWfUkMOzAhlqIWHMV6SfTC/1NYFl8cPDEzJeTyIfsllGhypWSTPTRaQwB/79crtVDTuQ3hLA==
Received: from IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 12:56:21 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 12:56:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 12:56:20 +0000
Date: Thu, 13 Feb 2025 08:56:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	kevin.tian@intel.com, eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Message-ID: <20250213125618.GX3754072@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <20250212125930.GQ3754072@nvidia.com>
 <2399c639-b9dc-4c7c-bac8-3776cf6a88f5@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2399c639-b9dc-4c7c-bac8-3776cf6a88f5@intel.com>
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB8659:EE_|IA1PR12MB6212:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c774c9-8f75-4104-357b-08dd4c2dcfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNHSyqBcKuclkqzgc/OcB/xb32DLFFzTxtDZBP9BOxE/FDOGh6bmpwuKuk+a?=
 =?us-ascii?Q?iQPiJfOND9as9UsATanjd9u3ABD1AIzy8Un0n6uE1nzFuob65K7BH2JF7gVC?=
 =?us-ascii?Q?FD+Ts+K0/bzwUWM4VI9Y28la6IE0psgDd/8N+eTwMKUopm+ClyShpanyZNjD?=
 =?us-ascii?Q?jg8qy66hzyVuQzv732XKsdUzFYUnpql5syNA/o+ao1BmIy+Zchi7A3W7OHCM?=
 =?us-ascii?Q?JQT7YtBTVi8VA/eDhMIMJc5t9FwkLrmzBxea++32s60cgV2VLwCI5aH56dEq?=
 =?us-ascii?Q?sImPPPWZf/apAiBSQZT8FM0JJdNR7rBicmYp8UM9sGAU2FYyJGcmYTsW9sQt?=
 =?us-ascii?Q?w/+TxCvfIjUIRFECV+mcC85l3Jay4wSvBOTjv60+AneNOObnXyiIt686/tv1?=
 =?us-ascii?Q?sk+++3aJAXRpViB6APxja0UFQMDu+9VQvfAVSt4xJWcTIvJAi2Qx5LwwtR/v?=
 =?us-ascii?Q?phShNtLWqHw2UFLyFp+Ucc9QN/jPxbkConEymVUWq0P7RQdm9UTrqIBGrOOO?=
 =?us-ascii?Q?bbEBW4IrDrH7OTb8S4jOrinZKSdiXq2OHlPeoxS5t8bebkTxSh8+c4hrLzz6?=
 =?us-ascii?Q?WEL4XHgBj38OiD1+CKzaMfRCpv2kTeLG3BcV2A7tIs9DmdnmoaHysQmGFCoD?=
 =?us-ascii?Q?u3K7OSD/Fm3ew1Od5usfVI9U1HXIpRsMM8gHXtmqN7CMA+2i5ZF+Re/3d7av?=
 =?us-ascii?Q?AuIkKGZ8Z6xcW0hB21FNXwsKZUaFCJk/TSdMLsBCfM1oNPT2sc/vwjzxoAx1?=
 =?us-ascii?Q?YrAeNbNF3VtdiMvB9J16SoaXW0RuEpYEen9FgeP12m4nWNqTC/BDk0Fjvzsj?=
 =?us-ascii?Q?mlZzd6YFqcrfa+XnKz/Jsboc/UWFkdU3reiu/uwTOKM2OQXc1lUy3/1WQg+b?=
 =?us-ascii?Q?csGJF2xO1uhIBpekhKp/vD+OEe7SbDJCqPNysmh8KWd5uvzR7id4lLGgPbHA?=
 =?us-ascii?Q?vmA5f5kktdWh+m77Ac+Ich55KlVn6AOZS1GxeQfqDEm8cWdjSRKfb0bjoCRC?=
 =?us-ascii?Q?Z0ZpJziMIt/Zf+p462AkM95RVkUIGw4qy2yj6df88YC/t6OFbzqfLWJYW4mt?=
 =?us-ascii?Q?D5UzmlsG5XI9uf0Uul53z+++IuydRpmubYAXuUBo9rvBRWH/nh2zd5AsBjcX?=
 =?us-ascii?Q?RuNZo47UFmEbZDuLm464NADaJtO86QfXFDQR7gj0FQfiNRX+iKIWd/tDZ8Tr?=
 =?us-ascii?Q?cdpIfrXfb+BkElaHiXDLrOam4SrWCJKOJJRC0xHzm5OCZ4fOluxpmzDoe9hG?=
 =?us-ascii?Q?HAQ0Wfs/XvasdnJugT6WOsos/ZBPOFI6RdpJWPLrXipoadKbm3bIfBZ3uFbL?=
 =?us-ascii?Q?VtJZ4OuXh6pkPRCyLyqijzU4ZPPuRwULaEoCr5RJe0HYBIbElcKhZ5hWohQf?=
 =?us-ascii?Q?9hp90NRs0DQRsD8eutMQ21iTP6lA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6212.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T78M8bR3tXCslbI32mNopys0E1byqLbSGNPt6VDCOpdTYnNkjJSSYlpgXiZg?=
 =?us-ascii?Q?BIo1Ni7x/XdvGwvzcKMPKKy4Wfi0MgyUKuP6psKzSfF4yet24frqXqA4a5EJ?=
 =?us-ascii?Q?ZNmPsJtX8TKTcRlGYrP8x+DEDiV7Z9HeaM6wdaJcq0SNeytzPjoxQ0tuDsmR?=
 =?us-ascii?Q?7vUn5+wqQi2tVXWH24l63O7vlWr+Za6LY3FnDv/jmUmn7m882NFpKv9LYr3x?=
 =?us-ascii?Q?54XfmxsVzC+TmF79dxVfkgxZtmE3h9tZGrSfgU45pGPfoxCcFQWEdvxOjUXf?=
 =?us-ascii?Q?X77ourrnw3V8B+KgAdTmeZrMtmP8rTM1rt9IEWaxLOksM7vpsVDQq/qc/mHE?=
 =?us-ascii?Q?olbg4sRtay51c0wUL+xDJbluTzJ49oWIxr1KxBWCwiRYN5t9i+9yEzGiHK9Z?=
 =?us-ascii?Q?QFizVyzhHZhobizF8kroMeXeW0M+3lF2WS6O+UkYiAw9pW1nhlbE4AgRfhnP?=
 =?us-ascii?Q?EhLZdP9BqHPxCpBj4LKUllYXxZkntI7Q40rTZispvmZUm7IFbAVszfseLChg?=
 =?us-ascii?Q?nUM4oiUFFbmC6xOsAl49TZJDt+/gneDHQU7GkeKsv5mUtVeqY2lkzCmA8ydJ?=
 =?us-ascii?Q?NVXvyBq++RV2VMhk+h5s6HlRS7nexzwV8D3xBYRn/aBS2S77QDJsrkLKyJSB?=
 =?us-ascii?Q?NYb9a6E4Uzvj/FYI8dW0JvW4y+Q6pNU6UdBupgHJRwzOqB1Cs+vWuiy5ioRT?=
 =?us-ascii?Q?k7diTL7tmu46iRnH8Z8BUPafyR5ue/xKjoGgC5lKEuqCrPtxEy/VSH9iFWe5?=
 =?us-ascii?Q?+CaoJQqOfI5wLwrvzYwxmLhm1Khf/gKj6ZRBZbYlPGaAfCntWgSvGlV3yXU7?=
 =?us-ascii?Q?bBy+P3fi2an6+3p398GalCOQQfFGlVZdCaXp5GRM2dDZ9fdyurMNmJuaxYY5?=
 =?us-ascii?Q?wUiOgMkq1kIY9+oFcLgFs2j7F302vg+aePe+x9qNY6qoQmgrs4mqNiZD6wQ8?=
 =?us-ascii?Q?oT3kDtRfs4FUHHzYys7dOxQFhLBBxCck9HhtMFgjAKe2gxI5ErGoQ2/ox1++?=
 =?us-ascii?Q?trIIaQJv9AFophecXZq2JElNGbuZWYFqc0dFR2UCU2jknB8mga5g6yslRFAl?=
 =?us-ascii?Q?0Ynk2guNWgWPdr+CmAfp6kR27REJMclIMZ5+JwlyjagugU6eZtD4vCHMUuQi?=
 =?us-ascii?Q?cLPPncG4v47K5aCxkr19jpILbzlYI3mvwbD6mZtqVvUAcrcQscrI2nnO/lTU?=
 =?us-ascii?Q?z1YJWnzQojCAFrJtNIgwunuKwXq9UkmjRg4jOM6CuIsafpWfXmcZ+nXFAtBS?=
 =?us-ascii?Q?Q76uZcLD4B2ulu00vCcTLNdu0zfISIEcysTgV12PsafT3B9I8OXsvUW/+qyu?=
 =?us-ascii?Q?lerkYN2KlDfz2v6hEja8KgVyb6ezrccEw56I17/9hjt0Q4d+N/pJTeGfyY3X?=
 =?us-ascii?Q?cSZHLFYsKbYToVr5zvjqzXcL97XNMpS/H39bWpwnl7KjLgpNaWbYJ3MVhhUp?=
 =?us-ascii?Q?t1aUnPdvj7l4mSVfHKArLfpdk6P+fHGPfF0W8rB3UNQehZLO0OO8xYJEJFeI?=
 =?us-ascii?Q?R9w/L74gYtCZnFzH5YY4R/mCqHN+FtDoSCdwj60bQPVoHiGSfuA23TciXA2J?=
 =?us-ascii?Q?nQG7d8LxVcFbsxCjZl4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c774c9-8f75-4104-357b-08dd4c2dcfbe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:56:20.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWtC+kf/5mAS2S4dOHjuyMiHWaONdJeQXuL36+j/zdVbzu7eoJKbIFQQOlOTakaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

On Thu, Feb 13, 2025 at 05:34:52PM +0800, Yi Liu wrote:
> yes, as iommufd always pin and map user pages for the paging domain, so
> I don't think there will be any PRIs on S2 due to non-present pages.

That isn't strictly true, a misbehaving guest could deliberately setup
a S1 that points to a non-present S2. Ideally this would cause no PRI
into the guest and the VMM would fault the device.

> However, PRIs on S2 might occur due to insufficient permissions,
> potentially caused by userspace. Nonetheless, I am skeptical about the
> existence of such use cases. What do you think about it?

I suspect it is "OK", we already have to be safe against a misbehaving
guest creating a PRI storm, if a misbehaving guest does it via
pointing to the wrong S2 or just not updating the S1 doesn't seem to
make much difference..

IMHO it is desirable for the HW to provide a way to disambiguate the
PRI.

Jason
