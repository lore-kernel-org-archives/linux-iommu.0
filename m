Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813182F068C
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123760; cv=fail; b=LhJLbJj0TtTfniZBK8LZ39SXFoLYrk5VBw8FFemjnjyQJO/tlMfuApDWmZgO5gfddW+rREUpD3FyCYq31X0sHVSqdgKZctQsX1CgKS8I9b950pQ3JBaaGtSIdBg/nyn8oI/XCEtKwkgNn4UIExP9cNl5Uxx+Gfe9tkV/ywORJfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123760; c=relaxed/simple;
	bh=PbcZscztWjZ3nWwu10lHIGpUXyG06xYVZiLS0k6OUms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oxOTzg6Pk6MmtteyFRvGKemDg2al3lheoC2U8DnLQNz242h3dQ0R1kbz9p50pbzSKXxHzidXwkLvZq9l+BtClSIwDspnUrYb5y34QWm1WlPaEf8LjkmzoUd7w4MR1LoyUfLoE6MtST8d+MvaFcvN2XNwW+/Kyule3CKRTpqRhMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UC3e+8SG; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UC3e+8SG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwryldFoN+IfyDzrsHQ3cqvvDpJ3BXVEYYnz5zlLzLES6zkWuCtWD134dmkTq2OM2gVs5NYJg8d43cHzR37pmoyRfyZdC1LwuGstDKeRzYqy5mXlBKaYkyLqeZAE2/ZdAFe0vog7uYQeLtZhZH5OoyRmBCgQrTJbLTlQBUD8pPtAN47OT0LtFKwTyOF43WOMUB27peE7m2Mf/lLAeIiF05NrkaxqrPG4XP0MI8H+JsE8c4jZ+cA9OswCfwTnEHv8GSiTITP9mETWhFb81uQZ4/Ae7mREzSuLjZ+gpl9q+RobZprIQq6zkqvbYu8HqZHaD5TVLJndOQct2SG8ZJuBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKZluHdK6Zpwk9KcISDxeweaJTXmlfKAbo/bji79gv8=;
 b=ZYeQaFLcARm8psGZSHiM8yxM2AzENxCoVouf7Dn+fqq9zWjN7O1zJpj8DQNU+uLl03JabRSgVyW0I0sdSmnqq6YvclCPF+szqsMQAU/0T/slgahxozG7ZpFb3+YrM0qm8+xeNUagsDFXugSdEBWUAHCODb5XzdIWJ0Gc048gYWQZgobYWiDQRb5BLYAkqqhwCqlRli6CtA/3cTbWZNTNTNtQ6aCDFeeso6tvbmzKr+HNVZlxe3bbrFyvJqBUDf8w5AhtvSL//+souFNUicci28LYaFSlRE9V4BViWTy1oj9xFK226bYRxrqE86jjijPnWS1WqZqunuyu6EXi3GIiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKZluHdK6Zpwk9KcISDxeweaJTXmlfKAbo/bji79gv8=;
 b=UC3e+8SG34Vj6VqMlt6iIDLQMc/IJpJml659XKloSYJy1y1wXlCmZyks9bVlXZ0hTFctDEeRPEk7oqPmr0uCAjY9gy8bW0TORUN9UjPuZrR+LizZ9jcmbJV77MPGtFNc1byrqAVub9GjyKGNwGvBxaoNN2QqRPGC0iMUVxpbwfvQO5/VgLgZUzHBki3+VCLVZ9DTqkW90KUhLztTk0pq4rQd0pY6MJ8qIG6YfgFAtH1H/o5V6YwB7aqFXOjMET7nE8SaXC7s6El6IOAl+eKkgO43Z4+0edrIzW+QO5nX7oUTjEqZfBw+4JuvGzsVKA3LZ/mBto5+aBCzAViFVdStKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 7 Dec
 2025 16:09:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.013; Sun, 7 Dec 2025
 16:09:12 +0000
Date: Sun, 7 Dec 2025 12:09:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aTWmpijaV75aixNb@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
 <20251206193408.GD1219718@nvidia.com>
 <aTSH5Eap7leYQtPl@nvidia.com>
 <20251206195752.GI1219718@nvidia.com>
 <aTUEikcWXWwKAS/1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTUEikcWXWwKAS/1@nvidia.com>
X-ClientProxiedBy: YQZPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::6) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a99cd4-cf78-4ea8-ed41-08de35aaf5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zK0qvCAt6xbFpXmhs4XPF+R46o8wbNB10hveHUdQjkiDLCaDJEAvNl1qwE+b?=
 =?us-ascii?Q?ECZjlUTPuQMu+tAgq6FgpAc7oVgPsxapX7YDMfOz9Gk6qZZcpd9q9RgjW9i/?=
 =?us-ascii?Q?jTZGIqZnOipcmPbHAzwxjOjg1gX2DNsVhFZpWQO32iJG6s1aInqgAh5bFUHK?=
 =?us-ascii?Q?MjqS4zLggww0DUuvFayRaiN3vbpfpR/dwDHdhzBI+btpBsJTNxbK6iJr73nq?=
 =?us-ascii?Q?ruiw4oH8y34Fa9W2+UFwDT5ZIXicr3pyChvHHIoKoBTX1D+ZCRhjbhoUiXQ+?=
 =?us-ascii?Q?uNKfDZtIu+u0qrfv1xQ55VtP6FxdGBXCevoh1mCV1b/VD70iKauZZ6/GIyDk?=
 =?us-ascii?Q?igVxlOE5eHrruOGHoeJPwPn0ej+0jHeAOWJQt/9uAmWprfhxYXZqQAC+HMzA?=
 =?us-ascii?Q?DSLfmwxIA1MfEZ2f7qdtw65IFfCIudMfjJR61teBEzHrB+fgbnelidSIiTQi?=
 =?us-ascii?Q?0JHwItKNj7A6zt06NseXtSWZ7LCZYFdndfCPG100WzWRJ7lRqOkHxxs51rzw?=
 =?us-ascii?Q?/wXguHSgNnFeAs0l+tNpEdaw7+fLz5ogq8HbIo4RwbSUkZELYiZ3Gdfi5rNa?=
 =?us-ascii?Q?F3O1cm/0XspQH0zJL6q8oThpDPHfz2+fQLu89/xb4p8KAd2U6y0NuGkmSvhX?=
 =?us-ascii?Q?c8+FxoTjvAB0Wi0l8QCZ8FC+ASkB8LlRmWYK5h19AQEEC48HmIzOaLxRSQU9?=
 =?us-ascii?Q?/Mo0P8MiAV0YaP1hEe6BqvOAooRAYLvnxPicJqbEOVPOXte+vVbBf/fAJo+K?=
 =?us-ascii?Q?tylduTlmrRwEOpRerwgpPV4/yVKKmhINavbq+YXDjarMXa5S3OWtRpQ9Oh5l?=
 =?us-ascii?Q?WQgx2Qg013UO4H23fWUVhCuxM0Yb3MwrDv2KR/XsKw7ht5C3nExZsxB5gssc?=
 =?us-ascii?Q?YbPLBURGdffv1RVWUyFgncT9Zegc/Y1rt0ePHDL0u9X+LHaTtGN7LJiguqyI?=
 =?us-ascii?Q?lpRPR1NRZIYs4b3VNR/VrRdD5a+Cssc1xBzxuQLUQqZE0UFx0i1B4xSN0odj?=
 =?us-ascii?Q?jhrEEj3PVdSv+Ee0/D2qs6fD7lkwkoY1Nes/YITHxlpI7QtVsKyhNy5Wkw5A?=
 =?us-ascii?Q?EuLa3Uv78py3X24GpWZAWR5+a2WfcQS7dZkQOjsp34AHop7sZ2OYnPpu7XGi?=
 =?us-ascii?Q?6N5q6XAJ8v6NhSHO24CzHBzfUZ//doVBqtX/3tb1uO5RiNIfJMAj/5z42ag0?=
 =?us-ascii?Q?dqDx5EJwgHw700oMw52YosrOcFUb45NHcCt4NPWtsZFkoMTbwTbCllCTX5CL?=
 =?us-ascii?Q?0ovoJE28LASmkjfZLRWScjDrVN14cAGHyZPYWt/dX0Udd/UhwW0PqfMIkP/3?=
 =?us-ascii?Q?gzofSJ3t/Isu27yB8JW4VlHwg7QnZcmbFRvKZvxFFT4rirDv3Z4EdGpY+DTD?=
 =?us-ascii?Q?SCdyppcho/GuVHnBaFNdp5KBXW5ELZ20DMiA5IPyvNeTTvbmB7v4JHljKXx4?=
 =?us-ascii?Q?9wy0ypm4S7VILpK1YEes1hNTklS4faMD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pGHJgzj7Qc1WQt3ZHwEPf+mHVFmT3bQX0HUBvJraXrln0ZuZfcyo8LUzS2j?=
 =?us-ascii?Q?OyT+t9GY0CuHNL6SJacjT4TUGk9FGSKD5Mpr9+kuHGxqDU5IPH9Oy34kCeZR?=
 =?us-ascii?Q?I+uKeDiB9dlThXjwygp1Djk/8BGxCVyuP9lb5ffzJ2XUos3adK+jbjy2Ygb7?=
 =?us-ascii?Q?Qm9kQComjCn5UtGfLhALv81oaCYXQi5+t7xbeinVaLah0KKmYRJXbUhg+zyv?=
 =?us-ascii?Q?PpxYg7INzMv2Tf0rWrShIBEb1FzAqarju8mZfkJkIO+Z8Zea8YkY5x//07DY?=
 =?us-ascii?Q?JMUXCRmUb+ihSsmTz7vtdH9F6kmdRUWNJp+JgDcWXkHAjNRCvQ38B7DS4AAo?=
 =?us-ascii?Q?YgGOtLmPxYh/bhc0lTROWtrRULFD0seJ1mbsxkZc51gOdHI7MBghXknlxpT0?=
 =?us-ascii?Q?8Ki7RljgVdS0sXPczI+Zdj4lm9Nq0zevpEgUKwNeNoO1te6VB72UfWsjRHwH?=
 =?us-ascii?Q?XJ2ADBvGSHoYEpqJj6DsEEv9h8Sd/nFiwsJQdlkPN5TuP18e3wYs7lcpczjk?=
 =?us-ascii?Q?jZLjhmn7xdmowNCE1SqFT54/J/9AYIyJ+3rzM8nb+nc9iTsAlQN69BgaQOyv?=
 =?us-ascii?Q?a6pM9C9n0jdGlTa64Vd+aHRnERQ78AsitDuZmBpXfSPNT/a+aD6yCpv09S5h?=
 =?us-ascii?Q?P6Wnnz8LY9AY/8al/hxANPArgH1NwgHbKNMIlMUoz76jG6y7yyO1giW7XWHP?=
 =?us-ascii?Q?VzHvEBuKWcs6gFERprBZf1fT4WEDUmL5ow6UlKkQndWWPeOIrOsf4qM2d116?=
 =?us-ascii?Q?XkHecoHWXvqFKy4FYR+6GRz3uYz8mgZ+p3eZIYASJf7VRp4STBbrS0bUoL9a?=
 =?us-ascii?Q?UhOQ2cD89Ofy9WAlTSC/V/1nAp8VvUccDZwjANsm9UkiPhrtasHsRwfneTRa?=
 =?us-ascii?Q?eqfh+9Ju3m3UpkzUzRS8xA6532jkoPHJbBBzeTaJmMsn9L1Eq6K5IncNJDuV?=
 =?us-ascii?Q?hTa3GXjw7mvnb0kg/Hs1HxOV/CcWJTyAbbhYklpit+CFWMk5gusEZy1Y346z?=
 =?us-ascii?Q?303wr59c0JcZKaFH8v3ZtjaqOfoPSleDJFRfVG3x61Ipdc+LqH2jzo1DzLUa?=
 =?us-ascii?Q?8U1Mfw3MqTiUcSLDsXaYfeZ7d+R3XN9yaMkuR5X3hjgB+vXm/NkSZfmoRhJA?=
 =?us-ascii?Q?+KW3JmYOBPzJrATylL7o859aH4NMth0asMHT4NL/RUNMfByjqHKgtiEvbudV?=
 =?us-ascii?Q?8vz2HG6dMAWbNQAt4+NnJJrJKZZpmwBchaTu14gBfNZpQI5BFMsRdtQK2XXP?=
 =?us-ascii?Q?eFuCOISxzAhO7Zq+RfP3hCpp/Xuhuo+yqjsbxziPfaTOBnKHJnx35t/OZiUX?=
 =?us-ascii?Q?6gPPHyBvTWzaKOQ//b7uOz34LD5mEb5ejeY6YkrRy736RhbsInmy0VYm+cUY?=
 =?us-ascii?Q?wB+mcjqXFSjisKm864W5k4vaCmuSk/9B1rYa1qX7hCnKWdCjmRUFDmklvFLS?=
 =?us-ascii?Q?B5C/1k/Upts9TGdEEB/KZqcX5CwuoZZCsnJO6kBFiUsACMkAalY/paMv38/J?=
 =?us-ascii?Q?DGWcW16pKCXqSfYFYiuwr8/GNYKw4Nr+mfZ/1E5/EsaMzq+HH2txgzEO667X?=
 =?us-ascii?Q?GCFnZaBR2BCbZDG5/PLVCCDkLjzvduzG++av7WzH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a99cd4-cf78-4ea8-ed41-08de35aaf5f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 16:09:12.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YHoKTGZqUHBo8gdUGM9efLAMu4lH/8uCtgPqvZMMQ0b5YJd7f51/la3FfjrHqQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

On Sat, Dec 06, 2025 at 08:37:30PM -0800, Nicolin Chen wrote:
> > Then ignored should be adjusted by the used: Only if both used are 1
> > should the bit become ignored. Otherwise we can rely on which ever
> > used is 0 to generate the hitless update.
> 
> Hmm, not sure why it has to be both used.

Thats the only case that causes an issue, if only one is used then
there is no need to perform a breaking update.

If cur_used is 0 then the bit will be set in the first update, if
target_used is 0 then the bit will be set during the last update.

> >                 /* Bits can change because they are not currently being used */
> > +               cur_used[i] &= ~ignored[i];
> >                 unused_update[i] = (entry[i] & cur_used[i]) |
> >                                    (target[i] & ~cur_used[i]);
> 
> If one of ignored bits is set in entry[i] but unset in target[i],
> the unused_update will first mask it away, resulting in an extra
> unnecessary update (though it's still hitless).

Yes, this is how it has always worked. The point is to leave the
existing the same not try to optimize it using ignored.

> One more change that we need is at the last equation:
> -		if ((unused_update[i] & target_used[i]) != target[i])
> +		if ((unused_update[i] & target_used[i] & ~ignored[i]) !=
> +		    (target[i] & ~ignored[i]))
> 
> Either side might have the ignored bits, so we have to suppress
> ignored on both sides, which is required in the similar routine
> in arm_smmu_entry_differs_in_used_bits() of the kunit code.

The only way ignored is set is if both sides have it set and then we
update the bit in the firsy cycle meaning unused_update must have the
final value. There is no need to mask target since it will match. Not
changing this line is a big part of what makes this appealing because
it keeps the logic straightforward, in case ignored is used we shift
the update always to the first cycle then everything else is the same.

Jason
