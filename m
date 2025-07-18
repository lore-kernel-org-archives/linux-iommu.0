Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3A1DB13A
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859810; cv=fail; b=cP9TaPM9bCKbfggghTkUTQx8yX/68y/jeSKihWbLmGAJTYhVkZUVy4hI0137SKgG7m+q9cJQrHvxvTzzccww4pLA4bpvoyPZTAJqAoGjkziQyIatqzT9d/Tp9guGHKfI//EUlZfOhzTOwqbM+jvUp8/VeVdV01lWDVfwKPqpiIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859810; c=relaxed/simple;
	bh=FOXkTrx93MJUxH30W1vzLJScwOz8v4RUtHB1yQsI0rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cyGHZbWdf05tMJuGM4/PjJQzHNB5CxWsCROOfl0hwD5SB/wkK5BUOW89jpKQSov/eKcbd+tc4aCiAjKtHrlUuM5wxtSvIebkKxVI/+j3o/nptuGTcvRDU0qyz0sjefytx7Xqk89u6hks3hPpk+v63BcLNn1SSyOP4g3InORyvss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMCPUtRM; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMCPUtRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+twqhDGkE2zObn7NQxUFc/WTrIQIVtJGrdxxvima2g79J3I/YSM36bklpTjoPiHMMwU5WQX2pM+CASkvzQEBYB/EzLZ9le3wpcojFemxY5Tih4rdByx0XYwESUt2rkb1ObYu3B4Z27WDgU/zcRofQpuUTc3NCJAUz7DhxZvcQIzH/nvXEi6GgzhWIfG0evL9D0DzjhIltsr4stRcegSB6lQGXhH8iXxjx5beO/F73CYEnlNVY0uSuF5eCF3Hn7YavnefZCdWbPRBI/TrHB+lGz4xrwEXx+QC1j877tLal5crVX9wCgxNnrCzDSA4p0fc+SdzJfIMZzazEtrs0YbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8fcBpldNdnoOvQCyCTuACSkcoaBdQp7F4EfjZ2YKo0=;
 b=kV8Go2jBb/9l785B2Hj0j9JgF4+t07WXKJpocG/2jOkcCWJK8AAzRb8VshN/uk0L+z60uWBaA1BFq7qh8smkFZ2fF32KmB60JoZCaJdI6RZ89scVrbZem2EQMXAnDbpBODajR7KrUJdNqme6mYS9pQudP5seScIPxq44M5DRhNnUaETCo8dR2APDIy9xPW2cW+6jbQ3E0WDQHZXfhqlhUoHj9Y9QRKQbZB95KCrUAf5zfZdCp1xDzIP5fzr1DSbbOdF9sfKS7Q+qoiLT2gqA+qLkXNqBqNyJCKtjjMqjZYlIeOcEfh1BPEQ6zWpItww2daEIoV3rPl1jrLKUIgq0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8fcBpldNdnoOvQCyCTuACSkcoaBdQp7F4EfjZ2YKo0=;
 b=GMCPUtRM3ze9eMFwjDwQMGg+deg/meJDOT/DGtWk/eLnQLTZ7LP4BB+o6ShzSt5yHXQgVe6rbv4zA0ffj22PeGI2hGZNAhy47GXQ6xwv96EhmLtoj6SkBeKAZWwQjxqIDhGrtCVokEgOZBBw9ooQHtL4V2oFW0BJgNJdbvgxL4vaVPdoEMHAzbTE0XMOknfU7hOe2dSxbIJlX57ZL09U2EtMlbEVzXdydjfklJTXyeo9xm/GXzNyR1eExRDHU5bwYw25ClMuOflWjH8FrqmHASJL5Nve3Xv0SLlZvZtAekkF4AbnB/3d3YDswnIeHldbTJb71r4DtK0uWCfAURUD5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Fri, 18 Jul
 2025 17:30:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 17:30:04 +0000
Date: Fri, 18 Jul 2025 14:30:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v6 0/8] iommufd: Destroy vdevice on device unbind
Message-ID: <20250718173003.GF2250220@nvidia.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:208:178::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: aba0d79a-0710-445d-baa5-08ddc620bba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGoZc45sLy2mrT9q+9i9bEl3LKwTXck3SMq8YTurvI+BgxAMX+wqUZnlfULY?=
 =?us-ascii?Q?iP58J3p/GeVXhNylZg6rkw7pbIL0HPlyK8CYA4s5KY+eNGvn8pOzSEpYWlvB?=
 =?us-ascii?Q?gmiYKwMFW3M+bOgJbtGJJR3B7TjloTK0CcD4qjcZvABuEsEe9T7ZiyLlgpSb?=
 =?us-ascii?Q?P2C2CXJ4ctcugfsCAJcTt9zGQlgC55FO17PJQvJkLfIvKyeJ0Ecnp9xBY4Xj?=
 =?us-ascii?Q?ZtqOPvg3MrhZWUEsSYyOahVUM09a//qh5S5VBa21nJ1iAWUSARNLyqz18R3J?=
 =?us-ascii?Q?qqdJ5m2oSIUL6UAkMfzloWZg7lbq1i+A2Iz5UQSMLnvVAjBZHqryC9/tzX9k?=
 =?us-ascii?Q?m+eH4eg9cSm1SOYzAGAhCDm244rQKr3GJQmkKo7KN8g4nN0SfOQJbhjyAXaf?=
 =?us-ascii?Q?qto6eUfSNW1qczwU8yKoLo+OEa7uWNnp8HHubvWb3Rf4v4141nht9gYZRlvd?=
 =?us-ascii?Q?fSKnk1ZG+RnNCQu0FbLHl7YaGLZlpnsu6HzY9Q1s777pIXLRVsvTHfp1xNu1?=
 =?us-ascii?Q?fKV9Z4U2DGDEsX+6VLQ4CJuXZ3ZuLrga1w0BLmFirc+vctWBKyyq82mMy2sI?=
 =?us-ascii?Q?33by4t+fx4OW+iro2LMUHMK40Hq+LCxac9lqvUF2SrY8umL0x0l2RNyaNM+O?=
 =?us-ascii?Q?9lgutdY6fWf9tv7z/Wq6wvSeA3aBl/0VtkPVtVXE32W3pN+1WrkA9BqHLNzl?=
 =?us-ascii?Q?CPK+0ZlE1PHIjiDs3z3Q6J+gmRCh2X1yIEK6n5cufFj2cB8wg68+ALiJ3Nht?=
 =?us-ascii?Q?1A9AAKrnm0asPTDG/5cJSty2OVtwqpkaPZzVAVwt0ozb+szRye4I/w9gJOKW?=
 =?us-ascii?Q?TKvSOVJb/AB+x1W1VBkxQm82DduqWsoJxd73u1o7RVn23d5d15IfwgAJpW1n?=
 =?us-ascii?Q?53+QaNg7sIsrxXzzDVOJZHrPYqOXLTlcKMl901A03u5Yw8Av0ZOV05zap26O?=
 =?us-ascii?Q?2ncrIGuCnNDfmPH2fNC7HP87d5xjLD+rsZZT35nYwFK0BXJ1M2kcCoc9iWp0?=
 =?us-ascii?Q?Ch42NEqDvAITxmO1d8ffJMPZZrSTxv9QgFP/v1W5OjC29RlCQ8lppqWU9XNU?=
 =?us-ascii?Q?CqY2P9lP1uXASS6v77nSj4fL4QztExwNeEAwA/K3OYLybi/TSHFSHLpCPeyo?=
 =?us-ascii?Q?/vYgNPzl0jpEZhyynGsZLLdp1iIKOz1Wn+pHW8vFq04OUYQg/vI4orrLLGOg?=
 =?us-ascii?Q?2ncfSS3HRtF4eqojF7D1QbRwbYgrjgG9no1lzFoHOdwxNhCkKqOVP5eKzsN9?=
 =?us-ascii?Q?s1CUr4rfFVjtzGyODiqbG/1chexXr4T/8Hn91TwAz/NmpxTVJfFBUCulYGb8?=
 =?us-ascii?Q?vOeXSF6dd7BvNvCYg9ufwelR5Aj+XOuBtOCdzN7Q9XZ9JjUFpUsXbGsIcBoX?=
 =?us-ascii?Q?FKtDX1NBqi5xiGyRg78Y5tdwhFii0as3O8Ti3K2ZhPO3pq+QKen11sciF+nA?=
 =?us-ascii?Q?uFmQ4/rXHw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5XJCmkqp7F5xLwXsWjUIpMt/+U53h2kKvpoPhMfBDutyc9ezV4VkPGykEzj?=
 =?us-ascii?Q?WFR05VtCUQu6+dqkdjfBwICZUEvh3x4K4Q/BVhGNPe9VhIJKG1Vo0uSjmMIv?=
 =?us-ascii?Q?oDKhxQhbbO0W3Asll8iZ58T5IOV+z6vzA10J3Sp7ORWcGEh9A5e8V+FFP4ap?=
 =?us-ascii?Q?4bThOkH+tQdddBiWvPWgSizZsgsWDa2fIZHnjXDF5iNzG1T3peIsR7LvjrKf?=
 =?us-ascii?Q?Q8oO5Zif3AmGDX6nJsabGxljz02GDviqkAi7W4ICKxWdrD/glg8tP6slzP3q?=
 =?us-ascii?Q?XcGM+2yTSqhDRKAvAjm4yApB+zLFF2LOp+q9NeQuZyCOlq8cJ9wVvcUjaMtD?=
 =?us-ascii?Q?HsjNIR3AgcMsy3tafRQX1xhQ8z6rJ/2KzZG5uFMIWRuXUshUoYZ4ujlZBbr4?=
 =?us-ascii?Q?Ch8lyWC/fkkQ6B9/P17TraNBKlRY5cwU0ZU2VDx3aahs+RB8PvCrZlfcuD9t?=
 =?us-ascii?Q?dfScrupTiFjqtk5LQz2zfhZvduTNeCqshFED98FGWcXx9HJ6R1iUxsa5OwX2?=
 =?us-ascii?Q?lWPSsXf7zKJki8EsUKD5qtpR3C4fD0eD+aWHdODYvsYMXAtpjncu1DDpNnq8?=
 =?us-ascii?Q?saFOaEl/9L6GEyx5InSCE3gaWdm5IL80B9L6pNGX2CbNB8DofjeKfb2CG7lv?=
 =?us-ascii?Q?th+skGce6UnNqBe1x/gT5+choUwHojsEH8/3X1XmUQdxwVUbCECJYQComaRi?=
 =?us-ascii?Q?scSWZfpoBDOA98pdr+xV/rDHYXrs9gV82SGiSiFUqMmi5EeB83FzQlNKVvA7?=
 =?us-ascii?Q?yMs2V9Ng0YULwd7gGp492EXGlzYXIsMf6b6VKvu51cF5hnDQhhJNHnD+sLO9?=
 =?us-ascii?Q?+KHOsUb3V6O6fQlLsj56cmQozgZutAC5SKPRi9y+R31TmvhShXiwv4bScdxw?=
 =?us-ascii?Q?1kK+bSemVH29/COAS/R51TbHoeI9px1NNBrUqtsZ49iHhYlI1RS4LMKbkCGg?=
 =?us-ascii?Q?dAyN/U2MPECAJ13b8V+K+m8Ourm+z86UEpE5FIBNS+7zdxQrJ7fL2VlH6pGA?=
 =?us-ascii?Q?oxIVQ/PuuHFj6HLsvrj90JbFCEExjR7SclIG77+1pksDsII2dICMoyeO7wV8?=
 =?us-ascii?Q?DdReiHoHbpv0CMUehopEm9w7aE7jp0mw1Z0gnhmsKyHxwXd7EzBjJ4ECg1NJ?=
 =?us-ascii?Q?qVNJfwDqbG3Iq6EZrUhRKXBM6+eDM//TtRRlt5ESwH4HLADTePWdwoXD4sUx?=
 =?us-ascii?Q?1By8QslZW+OIN5NJBhEpHlBK2gt/dsOTXk2bYRsx0ChTIwMwcPq0SVqWTmxR?=
 =?us-ascii?Q?sJie46qZqeEQfDVz8PqSr5J9P2WzT2YNb6a5FTZ3xeI/aT3wZxLsc+PvqgJE?=
 =?us-ascii?Q?jwkhvQ6EEjC2xj861P1Y6EgpOsja5xYuAmNxME9LcbmB2w3AJqfZLQm+86SK?=
 =?us-ascii?Q?a9nu43TwMv1a1IbygQluh9PyQGoZKEcy3Dmu4t7FtanNThHdzFBPOLFN8YBw?=
 =?us-ascii?Q?mi9eVWxnbq2VjK0k2Flt4rG0XfQToiiVAVkNnmYji+9EugGUfA/ANd60LTTp?=
 =?us-ascii?Q?xF6RD32+gohU7rG77xcrXe/nBD5lmBkSjfg7sGTXYFIwmRyARa2L1Giw0UER?=
 =?us-ascii?Q?vLYzJA0BTD7IY7uagEEbe2SjZcqSmqs0WXnLJOtI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba0d79a-0710-445d-baa5-08ddc620bba7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 17:30:04.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30JrahArWz38SKQh+tvWjTV8cURdnATCYAeYyjFk2IFjjtjb2RAQrItdD4rBvrwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On Wed, Jul 16, 2025 at 03:03:41PM +0800, Xu Yilun wrote:
> It is to solve the lifecycle issue that vdevice may outlive idevice. It
> is a prerequisite for TIO, to ensure extra secure configurations (e.g.
> TSM Bind/Unbind) against vdevice could be rolled back on idevice unbind,
> so that VFIO could still work on the physical device without surprise.

> Xu Yilun (8):
>   iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
>   iommufd: Add iommufd_object_tombstone_user() helper
>   iommufd: Add a pre_destroy() op for objects
>   iommufd: Destroy vdevice on idevice destroy
>   iommufd/vdevice: Remove struct device reference from struct vdevice
>   iommufd/selftest: Explicitly skip tests for inapplicable variant
>   iommufd/selftest: Add coverage for vdevice tombstone
>   iommufd: Rename some shortterm-related identifiers

Applied to for-next, thanks

Jason
