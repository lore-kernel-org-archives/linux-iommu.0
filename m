Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5592D876A
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316750; cv=fail; b=S6bv6h/DNKygWiIc98UKO/spTVrRb9WbOgHiaFZkpz99MOdwdlfqYUZgxeb2oQlB+DBvvh01FiyQ0FurCYTMs6OT6xNxnFqUUuEVsfATdd2A+7R5fhNEXTdQ9/u4jUiW3L3pQa/f66s1VHMNaNsD1se+Gs8do1Ie6QWOVGFpX5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316750; c=relaxed/simple;
	bh=p5Z4EhlLFBgKwhynsPQVhUtiMK9haMOGtvCxw0Y8lSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rd7uLY/hl05T7397j3Y+q/2eoqyicy5ifzdWZULxc6PZANpPoPfWfkfmca+x3UsUh70X2N2C4uM7ef6+e70/f3qrjZIzh12AdpevEQ6A7A/P+SHYoGB3Y/H9nfZB5IscUw7Tn4mU5F9d2GFPUgWl9Hab9FlQAG7nFvmvAvf3mVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jkv636hv; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jkv636hv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDasNMBY5VZYoC+tKK2PnV6G39UfrJh/+EHwZ1yhMWitpsOiueqY4izfn4wAnjQsRyHL9yawP2M/w7L/oDXX21Lvyfbx1s+l4K6KaoX1oKo6IDKMBDsh7Q5jdvuzSyDXE0gxAQUAhYKsvhkLq6X3nuzvR4YZXrsPBASkCYT6lMh2o/a27hRxo3b3lFTYUZ+ZKPZIRzScKJoK+tJWMllUEfajHHcZX6bJHKaF3DmQiehgSDmvemnixRiW/qzZ6umjfIKgjhYlFwiD8Y0aDxnMOA3QP0eXNcTaK/iblEFaVn2nEfVZsIqM5CH6qF1doC18D3lLWNSSK1ywLbMIaP14Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrnyGZwcIJ5oZur5RnP+px6g9PGuBURHgpLOlowVFng=;
 b=aV8ZF+c8pkFdZ6MLlCVkJBazhjcp6d/dTlg9QWiTuJLvNxcg4W8+spWJuevQLfh3BnnayqDtFN+g72i3vpiSEGfbk1Oc3Vcnr1K0iTYh52S2agLX1P00Rj609eiudUePV0pnOo+0H/lEavxei8nwVFxb50w9HOTaS8rrpUSkUZUJOQzT9gLH1W74WndGFfC6yInNFDOVwjfrVfWGzrhi27s8VOBb8uF5d462xa9z52mD4rZC+fUwGvOnjUrW0UFI9ORiP5/MPffTE/CP4miSx2D10+hnGi8zme6qrHTe5bC7VkO91QPoA/v3BJNPGP5fgCBpKnX5UwLcoKgnzuoaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrnyGZwcIJ5oZur5RnP+px6g9PGuBURHgpLOlowVFng=;
 b=Jkv636hvvf7/21bm5oGyv2pSbTS+cnJSbPb+ZQyyMeDRIRbCUjbv/8wDKGmadtJQIQ3ZwcXCIkASjPq/cef0SfE/ouo6o/JNu1PX+bGgwPiCiD1LpoqWqW889gLf3ksh8zSHqBUt2otGzjnPHt9p2hKqwAeWoPzPci4lycl+DN6sU6XKOyuyx425phodbUqQ+KwaMHsUeZQ6T7pugcQIzqkvb7LgRn61a18i/ECmExZTID9hjqWsti36nyQo73kFaAbHk8zwy+jmm4PK81hxL9p7/dRX89uWOoU9kkgTMrU653XAORCgyGl8WeouF+RPzkWD4ObRix3FqcDhOrx0ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:05:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 15:05:43 +0000
Date: Tue, 13 Jan 2026 11:05:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <20260113150542.GF812923@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113030052.977366-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9938f6d4-b32b-4bb7-b7f9-08de52b53916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BOHrK1NGWx/AB8uOFgltTTXUdLTOquc4rpNdZ+AYJuSf4R9VfA+6xZ6VO3qN?=
 =?us-ascii?Q?lPG7BflNew2E0t0m/qEYLzAek2rY9OV1LrtbQKtCtGIFunkFh2uyTQKsX/Z3?=
 =?us-ascii?Q?Qm+pqXb8SgJI2PHwechOOqv3mNQ0mvVUuoeprD/CM5TH5kKKE/VxBgpMhCrf?=
 =?us-ascii?Q?hALGnvI0KlxZ1/L20tENVgX3vXMX99DVgv3oqDQWQJk273fTkEM+GT/vUBFJ?=
 =?us-ascii?Q?TlQbQ0KoHLD898x3PVJLeGNiFmvOVuEQtih9kz69hhTcQZioupMZFq2PAJBf?=
 =?us-ascii?Q?i3vL7hDVNPf3b0nOkKbyczhdnNJqSgtYz+JUt09sSybUjjgQ3KTq9hUbWLUO?=
 =?us-ascii?Q?KJmzvpAOM+pRrGVDBEajcVW9PpNU/yMABucO1jD/hD2InKupzSCBo60u8KAG?=
 =?us-ascii?Q?tFSvUAS1oQ4/aTGQJz0bOr4h7/P2XM2Tfdc5QOAeta5yyCBcqGG1A8VavAe4?=
 =?us-ascii?Q?1gJSfFsAO3LnW6/DWTgyKyDBfQbR1kw/PcGgjZTWmErpiyZgru+g2Nwug0tO?=
 =?us-ascii?Q?U2mhNbkZgHtrBOH6WDKUoODtbLjZfCJWFlmOHkVKsyOhyHbF5qBCfJabHvjq?=
 =?us-ascii?Q?9i7nhFV7nC2dfr9VZMFaU5BjSDIXp3bvXgk6S0Y7RFIC09kgP133bQewc/yL?=
 =?us-ascii?Q?YZs/4UQhWVAlkSlCxtuPB4zulL3D5Qx39sfRqsQ4wBiguqnvqrRpZUQKkeEF?=
 =?us-ascii?Q?h9Sp3SDCbTt11HAtbu2tV59/LYStSsByzAJDqnJ0xOPG0u3t/Qg+vGVUTOem?=
 =?us-ascii?Q?6Q9kqqcGPhE3/cNiPrsD/uwx95PA1UxhGQCxaE6MCZe/xh3IYv2KxOGoQjgE?=
 =?us-ascii?Q?42QexZWKQhxLibW/jfnUlhgoZh3PKWbplmkpQRZE061jDAqOeFa6fL+SVViV?=
 =?us-ascii?Q?/GYs4kHiL5v2+iirENYMfM7OgZ0wkYXf7MNEWFVcsZ8khb7y/qRdEfLeyAmZ?=
 =?us-ascii?Q?JWy5xFV90Tdyuu9tuJ3es+xqhGjLx+I8A17jlfUrvKy+HZfleR3V/AJ7AxCt?=
 =?us-ascii?Q?U7h+P34WpH5AqjsilNV+oXk1nf1JZ2xGOrGycz/aYnA58MRib8W0KAIoR5jf?=
 =?us-ascii?Q?CthV2XJR/avt9hF15bhq0coSjxZDXl7On389MEg58FAwVC1JFCf3PUMT9k5I?=
 =?us-ascii?Q?+rnHHHPth7S4lOESXLR4tgM9r00zH3Vl13jePcKqMxuKZVFXJZDErQWnLMn9?=
 =?us-ascii?Q?vBrMkbwep21wbD9QZPJYJi7AVnUnP1b18egkUjTWCecus7PWQn5VKAhG7CSX?=
 =?us-ascii?Q?R2gcXALZsSCAmvPi22szkcByfUxCREHoXnwaV3oBYYlhFvc6IrwWtc5yNSD8?=
 =?us-ascii?Q?OJIRELMQFLV/rGlFnsIHKCZY3b7dvvTN6g9i6F+cs74KKZdi0nMXvZ5CifnD?=
 =?us-ascii?Q?qQQjd6FQPSFeFIlhfnQEukkF95sF9jKcDestH0atTbLXrZb4Pq/V9qez+fJo?=
 =?us-ascii?Q?iIWTEHq04cvD/9DtoftPr6M1EosUb60vMnTGNgIqjRVaIxeSGx7oVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+6bvKk0Z3kkwz7Rn7V1aYmUskhGbPwlLFt5eFMbLbOxVtBK0MfOsd1RLnlW?=
 =?us-ascii?Q?OnU2MgQd962lryvIKwMDl3Iu8I/2IReAkC+4eQ/Qc276maHRr5HBueMNo6cR?=
 =?us-ascii?Q?daW1JMFmFSlJR5iJetc3ZU2yz8J1KW+hKwsCXUkTgeX/MB8HAPmhA9TR3d7F?=
 =?us-ascii?Q?XDoRkRAGzj18sZtAZbH6/UZX0LKmDuCefo7Cf2EKPq6wp5IRvqieNd+lsxlI?=
 =?us-ascii?Q?K+2ECk5iT9j4XZgyaQmCcheNVghNYJn7DA1rG3MtdNiAPuBnt/N+AzxK5ruw?=
 =?us-ascii?Q?1wIKt6DTt4CZLTOuLmVcrWALSVdifKvZqy04dqFqs4NYZdSROplXx7b9D+2i?=
 =?us-ascii?Q?KIKjpDZpWrw2YZ8QPik9WhBBv2ws0U5AplQzFs2ePr5vCUtzZi/L16KGtsJJ?=
 =?us-ascii?Q?xq4P16dutFd5bJ9SIrgdDyF6gpE0uNsNaQD0OyF/w02km3M8/McAfPRY+wQ6?=
 =?us-ascii?Q?BpFl1gq8cL8ovCZyrrniid6YsKADwlXiU5VWvnCoScuXpg06Zf7LCr4eJ6Zh?=
 =?us-ascii?Q?uwfYY49H3LLNTwhixbmCVbJPkmnTmD01EUIDeIWrV8eKEbVtfE5sdEUg+Mt3?=
 =?us-ascii?Q?uFSYCW39L+AcgYnIJa4ZxhuvOEOXSH6tI30e4wLkCyC8NLXdPuWMNl+lD/aN?=
 =?us-ascii?Q?FgBAGENDQuybBTTT/Z1ZzZN2v8qgYGci4YJYxlYP1t7TDvKgelEVrpSALIZp?=
 =?us-ascii?Q?2qRtlkxcYDL8L6GQWUfo96XNUvCxGrzGtNLMJjdSFVF5EfNREKMrOsO0Qw0t?=
 =?us-ascii?Q?hOtOlbERv9NvkCJ1mhTuyUgYV8Mmp7p38kAFKIzZe0TmUFkQhjukakd2JnJR?=
 =?us-ascii?Q?JwiNMXT0xBp9Dz1QP2oKlmdx5Fjx1FZIjkvwQedLMpXj7892OuEdx4SpVZOw?=
 =?us-ascii?Q?qQLRypbk7RV4fhuBu2e6yIg2vImZcvFj6sA6zl+aQgmvx+n1/JWiZ7sGlXlP?=
 =?us-ascii?Q?F5oJ5MsHWm1ldufZYdpmgA5z9OPFZtUXIZQqgzp+wR+e07YAfzhc5SxN19TA?=
 =?us-ascii?Q?ZKItVVbH3S3ecq6OGKQSmkE0FG9AfARsI8BBjg+gpN6N8qaIEkCnFMSxvnxV?=
 =?us-ascii?Q?QT782d1ZkKXYte4SLNS8Fan0GAIx9ZlMBheTON+w94bjBc/1QyHXwAwvm80F?=
 =?us-ascii?Q?MI0ukpRy4dkSCYCRxn61mKC57Gnqe5yHjbYGTYOm89K0WC75To0BZIjob8Oz?=
 =?us-ascii?Q?c919MVHou2QxndNqbC+Rkn8KIRw1KQoYIVze6DkEqW0wBik2O7AKQS2aFw8Q?=
 =?us-ascii?Q?QWas6w2J4LPh3zH4M7T0EbXAzYi9Wxe71aQiy4U0PKLQp8qWjthYx9p8KacZ?=
 =?us-ascii?Q?nxs6jZDct2taY+F0sVes7DmR1GvXc8bIZPqwnSYoB375z/7uGJoifh0Q5eOC?=
 =?us-ascii?Q?N7LNLcd4bvfi9aT4n8aAciI3uzV7sVZwHdIHOYE3ZiYjjXZEeH5KkHPNpCOL?=
 =?us-ascii?Q?8o7PhgKh9KoSkfS2Oid4efIDlr+tdv5hVWpyqWctdVYCIRcIUWmKHm5bWE5B?=
 =?us-ascii?Q?k8jUDrbpJhzHpIkWAFYnrJvZd2a4msCiPF1s1w3mKQYd/LieEb1gMus9fU4P?=
 =?us-ascii?Q?2FWv7K1ZQO+6flRXBPm1TdPPh+wXJeJKZo6ytRVSXi8l7/UXyzC44A1vwbev?=
 =?us-ascii?Q?Y5crUCyeCzB1z46tFsqjEf7AhzauFIINZDLAy9WRFxws5m5VmvJL+9MXEYf2?=
 =?us-ascii?Q?THZl3XDsUgXo0e5LSy3kFeSky1bdEF9+1qcej3e0UQrbMs14Bn5/P9+kLoL8?=
 =?us-ascii?Q?UJlntq3Rsg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9938f6d4-b32b-4bb7-b7f9-08de52b53916
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:05:43.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpDq1T984zt1nKSBkOXqqOzTuTmJdL8SrAquhCr0yS23Z9RywfNEssbQvb7jEpUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041

On Tue, Jan 13, 2026 at 11:00:48AM +0800, Lu Baolu wrote:
> +static inline bool pasid_support_hitless_replace(struct pasid_entry *pte,
> +						 struct pasid_entry *new, int type)
> +{
> +	switch (type) {
> +	case PASID_ENTRY_PGTT_FL_ONLY:
> +	case PASID_ENTRY_PGTT_NESTED:
> +		/* The first 128 bits remain the same. */
> +		return READ_ONCE(pte->val[0]) == READ_ONCE(new->val[0]) &&
> +			READ_ONCE(pte->val[1]) == READ_ONCE(new->val[1]);

pte->val128[0] == new->val128[0]

> +	case PASID_ENTRY_PGTT_SL_ONLY:
> +	case PASID_ENTRY_PGTT_PT:
> +		/* The second 128 bits remain the same. */
> +		return READ_ONCE(pte->val[2]) == READ_ONCE(new->val[2]) &&
> +			READ_ONCE(pte->val[3]) == READ_ONCE(new->val[3]);

These READ_ONCE's are pointless, especially the ones on new.

With 5 words to worry about I really feel strongly this should just
use the ARM algorithm. It handles everything very elegantly, we can
lift it out of ARM and make it general.

Here, I did a quick refactoring into general code:

https://github.com/jgunthorpe/linux/commits/for-baolu/

You just need to provide a used function to compute which bits HW is
not ignoring and a sync function to push the invalidation command. It
will take care of all sequencing needs for all possible new/old
combinations.

Then delete the replace/not replace split in the code too.

Jason
