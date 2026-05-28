Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4C3E2AD5
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967522; cv=fail; b=bSCG95fQDhtEDMURQdoqy6UWOGLBrzTgt+IRjc5hmRhgKFuWwCWNoGr1sJjEmsqhbpYTBwCRPyzWn4GLJIiNlmCj3IrsVksDCHP0eVsaIn66a7zpR67lOaMYgesxsp2K1E4syvYw0KHH85qv6FuhSJPdogd6kxGVP9TRUSfHTUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967522; c=relaxed/simple;
	bh=vXjYDKF7J1eKZ2Pr5SH8bk+0iP0TStFcQGbNh1hmj0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NpYUWfs5XjIzdeEbhaLxMIG9/cmZAvYvezVhoDz+YCFPSXkiSGfA6MaIpQHSMlMVyRStI23E7BViUkTwtiy6eFNKhVnPVi+mUaMizoJ41ZB/ROyfIEDxiIt9+nlYT2FrUcanR01DYkV3sWLaJgutZpsKvZGtAr/qNDAGDbR7N1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IpQW3eZx; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IpQW3eZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGWpxZdsj7HF9JGXUr3N8Y2vdfPgFEmgYhqmhYEbbDp8/Sc6mCQyifwVUnDO7MKfPw1YKM7RpMQ1BcOH3AvD8z5nVtIQXkCLZ0Cja3I3bVm8d7lrGXpYsNmz5mtEPv3bwiX1/ixWTDi6tGgGJAJFkK7S+doOYxckhloHigNIUsknAVN3L+uuWx6RZPBB6pofRIQSDf+40dAKLnvB+EfQad33iCKTeWVtXA55vcVc0druSPrMlqgmFE2JXzFFgsOYAwn1cvRk56B/UVZIYfLzCYNaws7vFpXckBwFPIzTcTEWmlbdiC358oR5NuK9Zax0sxBJq7iMU+ekMY0/NUDqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsAhDQUjHdLA2vFgqYqL1NassgxLGYM6mL1Iy7uj5tw=;
 b=QuqENVZwFqQe+TWLve3H6bl44Hr6XpnWHE4ntFqUVmREK1z/Eouau4AaXlgJypGtA8jSmHta1Oy/wHyD0Oh5ExQUMBwl9q0bYYjoqpGocZh+TP84Jryg0qiO94RHlF2Oubet34HomOXcl5IauRfInU2nDXPvgPPolgQMxpHVWWgDzK/KqibSMWmdhPs83Ld8RsboEAPl15gVvvGYWXZGYwqoDLDWuo4F+IXe2QU4nXU4W6dUzytqphIiwg3JXDv+RRE+EpMc6+DMMgUKDCh9CgG7fXebgBybZRB374B0Yq2RUsDRv/XOcbi3cTJiUPjBvaOGZ5LUzLzsf/EiO1mLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsAhDQUjHdLA2vFgqYqL1NassgxLGYM6mL1Iy7uj5tw=;
 b=IpQW3eZxM9OMl7wiR6fGurji+aJssTd0OyNCBT5icjQX9vnTdJ04r9GRUAx9+Tx4jzkCcac43/acUq5X7X+/FttLj5+PgC9Y1UgM6R2JvN2mDsRS6/yOZjM9fzat8OZWFLbPzfIgbn6JKkjgFxGxdxzgGt2Wv1dr6tnnjKzIubE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 11:25:18 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 11:25:18 +0000
Message-ID: <a222a1a5-b96f-4e9f-90dd-2a96e72f6c6b@amd.com>
Date: Thu, 28 May 2026 16:55:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: Add Vasant Hegde to reviewers of AMD
 IOMMU
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joerg.roedel@amd.com>
References: <20260528075318.607955-1-joro@8bytes.org>
 <20260528075318.607955-2-joro@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260528075318.607955-2-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::25) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3386f9-fa75-458d-cea3-08debcabcb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6F74LjHEa9Q047AYJGe84AEFp0s2ksLvYmloHdpw5O41bIWlS0YgfI0OB9zC+wKR1YhfB1o/uWhXACbu6r4GIVx0UkX/XX8/EOgXsK0azw3WELLNaMk1usnE5yQkEC1uRTslJnEpEGtysey37yOEnO9NV1p7XuPCI590kVLFCL+fnK3MqyHpCzlcmEGiVfPEI1bjUgIUacWjIinE5IVa8Z8Oslzsr7vcEd8aahO+WqWR3kUToMy/0zXkTO1MXS76hRjyjl+KqQ/AkoJVPtu928nHGr59VoDk1QmhU4oqEYcw157/zn6N2sLbI0r8LlamwGhtrSvCxzbKsoy5x0nsZkWf+hKN4pAKm8gzYT1pOs93KgHrss6n01p5f0WTtQRGobkKjALJtavEnGgG6O3oPueAwvDeuc1b1T33pJ3Q7Zi3/BNYea03REB9dFTnoG1WspY436vMWiNXxVOsWEgN9oG1N3v7Y8n5M11/U1RCST2sXNbSncKcomMYl/7KJUQejBVDHHlr4WMJb8+b5/QiPhIC8EN2keiEAoM+/siP8L8uPS2dCz2rDT3xFMdQaSCyQqcOwO9wP9reOPwY4Ll9kJn7zG3dvAxx5I5pIyDP5hXPN1lldiagtnvmOhpc4oz5Abm4r5NdRiVjA1ODId23mwpaiEseJ2t/bGRw/HYnqHkNj3aVxGGTwSxNB/+20+0c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE9NdTVRMk1ZSlpXRG8rbGxwcGdvZi9vSnZtUUVNYkU4N1J5Q3dLNEE0dlRn?=
 =?utf-8?B?dW0yZDQ5SnpkT0xsTG9DQXZabXNqQUI4Q253MXFoaXVEVWM3c1MzcVRzT1J6?=
 =?utf-8?B?RVJoMkJtdnppTzlYRDIzVWpRdWNLMGVxdXRQOXJjQ241bjI1ZEEyL3drcUJT?=
 =?utf-8?B?U3dhRDcyTzZpMEFuWFowb3dZaFgwV3prSVBkUlQ4RVdHbmw4Tndid0xPS093?=
 =?utf-8?B?Qjl5T3lLSHNxVEtDaGthV2lxUmZOVWhQUTNTejN6QlhUc2lnKzJWMTQvSFp5?=
 =?utf-8?B?bjhybmszUGlRRzd4WjYxaVhIZEp3U2JncmdhNlhGdmljZUp5ZzUrdCtmZHlU?=
 =?utf-8?B?ZGtiZGtXb01TZ0luaWNVSENScDBONXJQeWtzT0lmMHZma0JzWkRRbXVYbGNQ?=
 =?utf-8?B?K0dJTFBJNTgwZEJUQXZONXBnQ2ZxYXM1WHR2dGlIY3hFTGM1c21lQmtGNjJP?=
 =?utf-8?B?djRtTUhnR3ZuYmRjeWZ3d2NCaGsrdVlZQ3c0VmJ3V3RzSFRaTCt0UkhqTlF6?=
 =?utf-8?B?ZWJldkN0c0Q3bmRvcGsyK3k0dTBlckJMdEFoQ2JKZ09yK2d0QmFkOUI0amN4?=
 =?utf-8?B?a0d2RHMyd1VRTU5lNFZYRS9sdW4zRURuYVl5TEVHY3VUSjlwQjhDTjRMeEFE?=
 =?utf-8?B?VC9BL0R3WUpxT25xRGJXckhocVlQOVNWeDBseDQvMDNCRFF0eHZPN1FUby9V?=
 =?utf-8?B?aEMrZDV2YVZwNXI2SERuT1pvZUdXTURURkdNaVVzcE5Kd1lqamZRd2xudVh6?=
 =?utf-8?B?LzFCOWpLdUtOQlIvN2YvRGw5MElId1pvUzhmRnVCZUV5RC9Tam1MN0Jkdmtt?=
 =?utf-8?B?NDl1RjRxMTFHZEZzZ1B6ZEREaWxUMmtYYVBkR1p6cUs1K2VEalhhWDU1Q2Fm?=
 =?utf-8?B?MVVsN3pJa2UzdXNCK2FNR0dEVEFQMUJNYjY2bzhBVmJWZmx6Z1BIZy9TLzhM?=
 =?utf-8?B?bVg1SkthbndHcU1Ca1BnT0ZoRnZPZmZnOXl1UTVjbFBLK3RjVGZvUVkzY2Fn?=
 =?utf-8?B?L09CV1B6akNlaTlCeVNJeW90UXhUWUZaaVE4bGJXTjMybDlUc3dqMjI0b0tZ?=
 =?utf-8?B?ZXVweTdyaURDeFB3RnA4YWR1U0t6bE0zTk1nUUJxMm5BV0NZZUR0clFmRm9Z?=
 =?utf-8?B?c0srRWd0Z2RIVGxGdHRGUWkyU2VjQk1kNmZTT3VJMG1zRXNXQzVITlpNeVN0?=
 =?utf-8?B?ZERBQ0x2cXMxcm40VzE0VHg1bnIyb3dCZWVEM3JjYTVqcnA0Uk9BbTdDNS9H?=
 =?utf-8?B?ZW1xNXBnS0ovblFjcTlaWnNLRGJ2TzVpb2RmaEdVekdwNVV3R2ZGbDh5Rkk1?=
 =?utf-8?B?MmYyaC9DbE9pTGRyOUw5YkF4YVFQb2xOMDIweEF4U0h4Z3Y5Qk1QbS9GaTl5?=
 =?utf-8?B?b21mend3ZFNzWnN1MHVZZFNuMlRGOVpHYzJNcTVHVUxtZkpvL21IVjZwMnd2?=
 =?utf-8?B?MGtBT1VHNXZpS0tZZXlWMUVCSThiSjk5dkxWcEdZTC9uMmdMNFkrTFNZWERm?=
 =?utf-8?B?TVpENTV4SEdGRFJuN05oWnBkSHE3bTZBRnRPNkxMQWtLVDh6d09SVkxSQmlX?=
 =?utf-8?B?SVRRM21mNUZMT0RyUWtBTHI5dUh0anJNcmFjVDkzYktNS2xqMlpCUDdWOHZ4?=
 =?utf-8?B?a2x2L0JHZGlXUlV4TEUwNTFjbXpHNmRwUTUyZndPTW13TkF0RnE1OXdFUkFk?=
 =?utf-8?B?U216T3pBOXBpS0RhUExYY0RpREtDN3plczRvT1BPcUMzdERBNktnU2F4aXBG?=
 =?utf-8?B?ZU1sQ3ZRTWVMMVliY3FmbzQvOUFBQnZXTmZiZDV2SVIxTEFHM3QrbUd1Rldy?=
 =?utf-8?B?QlhmQjYzT01QMEVENnRleDlScXBMbCtjcjEwN0ExR3dmQi9OVldFM1E2TWxP?=
 =?utf-8?B?cXIxOEZEanBWb3Rrd0VCeTFhbllGVExCQ0dKSDFvTXArZy9tSS9CWjBtMXhT?=
 =?utf-8?B?Um9SbWNoaW82Nk9wQnM4ZVg0YzdOdE1qVmhPV1V6cEVHeXpwcE0rZ3ZDMGFE?=
 =?utf-8?B?QVQrSVIxRCtnRkZ6TnUzbGFwdFgyUlNQcTRLeTFKenN5LzYydHNOQks4TjZ2?=
 =?utf-8?B?a3l0eWtSYXVCZnpBNm9vUDRJTnhBdy9sWmdjanFjaW5EMkZiQmN1T0pINEZI?=
 =?utf-8?B?aTFSRmRjN0pNQ25BSFV6VHZVZ0dQdXJKTmplTjJyTDRYOUpZZXNwMGV2WVZZ?=
 =?utf-8?B?cC9hMWdJQXZOVzdDeXR6MXMzYWg0bC8yWktLUEh1dmdhZ29WUE1Sd3ZGWTFz?=
 =?utf-8?B?YnJsUTl2ZmV3YVNFVll3Vm1BTUxjbFpEWkllc2czL01BeDg2OEs0SXUvSXRV?=
 =?utf-8?B?Y0h0dm5uNXp4RTRLNmpSZy8rNWpXTjlhcjFPVjJURUZxK21MWHlYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3386f9-fa75-458d-cea3-08debcabcb53
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 11:25:17.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYo5fddnRSAuIf2JD4Jl+uAa4oHEcrAOU1jgjup9GM/AYiUG+1L4RxXa30ciK9c/GMPUBYIsGKGj/vWU3NWjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536



On 5/28/2026 1:23 PM, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Vasant has a long history of providing valuable feedback and testing
> results for the AMD IOMMU code. Still, too often he gets not Cc'ed on
> code changes, so make his reviewer status official.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

Acked-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

