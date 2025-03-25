Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE85502BE
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909083; cv=fail; b=BxwcYJDP+d2GXFE+b9IlkYM+Kotc/ONmcvPz7SwM1lEMJpjXNNNhDtysErfkRzpvtAGEmuQM41DFRbAYPsU3tDNPVxsgQsfXiNMjVnuUTKrNF/efIAU2Y+Fx7IzwGjE/GBAUkjAZbSj+j2pr6+nMsTZ9WSMN4OpwjYokJt5IXLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909083; c=relaxed/simple;
	bh=QD1dJ9GwwaFGYsqyjAp6grZnzZ3M95LqGhZfo6puVII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0UMHSjK97cDPyhbAExUQyDhgI7AnrI4CGDmzri8BvR0gBCnTgLCIxLtor3bwf0UHSqGSFc8RJrBAnFJDez6bXvq+n9XiZeComJKBc1YPWkcPHqqaiChf1H0YCgHjQm2z/MkyChdMfDUEhLHfAi+WroXvQcrMLPbrQ6zIKEjY2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nLykw83Q; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nLykw83Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzHEMZLE37G/yWF5BVSiahCYk+2g15WlqNMTraj/MeIq4e0z5lEKk8ArpbVwRu6VBttF2lySHjeYbfrsxn+53iu5PZbLbaA2xUpINGgqxXZStiVrun9NXcq3PiQiecLNghOlUtdtvyO3m4ZQWvW9Zygd//lMxzPH3S+03fopkOXugvNCdSwd9M7NaiyafSSxreV43cNnJpGxkW0bHXqjDK7tieRpcJltYtTj0iDyNUUcwsBAauoMx/YFvIufzMtXJWYSPunG+25YQJA6/3del9wfZCNUBlWNHZWYqo66cn3jli3CFexrH5UAoe3C8rxy3yY5E6KZXDWvPN3tS6X+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5uazxUpdjQiL4HbfhMsrO8dEiw/GcqoY2b3etjsPkM=;
 b=NNle9IYGabGZvQn721at9JCjv+PvlAjtwcWAjOmHJPmI8kxGUWY25KkO2L6xbEXYURkz40hqbneergtM7OLdnVo81Q/+hCOVSLzbkoZercVJJlhfHNkJX8qYg4/KkohyHoKtliawY+KHhnkYHhpipQ5iYX6pYQ4zTNMKbDb8AukfAgzfqjMKkjuH/G48Aau98Qn7lkvzg/G0uoYcpFfRRHvqRhFVQh0LR0Mrt4VnDN7nECchCdcKi/6VX/nIcrFOVgWc9DRwejBSra1En4iW3L96W1FVaXVnaMvtkWaZehQrZrL7NByeK1ouoMwHrZZNP1SF/CO7f5wXqmBNM0Gr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5uazxUpdjQiL4HbfhMsrO8dEiw/GcqoY2b3etjsPkM=;
 b=nLykw83QA/G9Z3fYqh19awqyCd7mxPJgtPdtiv7xvuqjztLS/qjA2wSdAWB1xftQae9Lz5Z1j/q8ZoYr5rKM7l8/wAGaL7qVhZdF8OnEKMa6gS3+7MYWp1j6MomWcXiX2lxM1yBoAkCKVWdts2UvyMt69LdAitF7dTohNmUlL31Ecw7U6pV0nFmGm3IXyPk/dg18cSirSI40XyMILAcdXw3NZaFKLnjh6zvwC/YBjB9QZqMz961mF3Ipf1yN3/PWQh+DXt8DE0icA83G4IqegtieW/IGgSzHA6T81URqu5m0mH9XaQXvaRdEJL/zJBTajA4YrWQW0ylZSm2kaPCmyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:24:34 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:24:34 +0000
Date: Tue, 25 Mar 2025 10:24:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v11 00/18] iommufd support pasid attach/replace
Message-ID: <Z+KukOKvs3YcYIEs@nvidia.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
X-ClientProxiedBy: YQZPR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::9) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd9a924-e7e1-476e-ac9e-08dd6ba0623a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58vARMguNKRKEIeiRkoMTMLy5Sup7K1dYEXlbOB2t+yNHQcDdlRM3qpfU+a5?=
 =?us-ascii?Q?4dX/8TJA2Ae0TsSXAjbN3s8Z4v7sk81mN8gaO/pnS9bihapeqQQobPt4gRBe?=
 =?us-ascii?Q?aghsKahR+ABx9Uf24f6ruuuMSuFHm6uXjHC4QNUqlBLLKtWYkMKDJHFJopbr?=
 =?us-ascii?Q?4xlhSrByTmrrn2pXxSJV/+hBxWmaBx6SJFxEAHjVGPq55+ve1/6UK0167Ohw?=
 =?us-ascii?Q?FDL33e9xGm0UgO7a4v8YZ4YZg/TtA+CsjYAP+Xfq7oulW2yAHGBwBMtTMXU6?=
 =?us-ascii?Q?3dnZKyQo21Y4d4U45iFyMG1jsLE3+UDDCqOv9089whXWAYfGgpveBZnOe57V?=
 =?us-ascii?Q?+gPPjNnSzdymX43oL4912NEHNeghwL9ZLagfVSuRbOSRKQ6EpjlhGO5KlCUE?=
 =?us-ascii?Q?beTnhz/gdjoJhzWUooe0ErrL837zqbbg2YnLWwlKVviVBmgf+tGJ1CbhCy0N?=
 =?us-ascii?Q?4Xbe85KezhXtSYpGyLtA10JjWXeKNQn483EkTva5oQCp+aTtL0QiBdJIS5tX?=
 =?us-ascii?Q?gFlXgXToCeiKXUBTxpIxu/IGv1EuQorvPSvW1b2VL2J/ma+zsZMD6mivHPK3?=
 =?us-ascii?Q?49q0Fu5XpCu7rn7fcn4K29VpGyb4s9To+1EQ2B5SUEJwgOkYl1jCp6z7TQcx?=
 =?us-ascii?Q?PWwDEFLv0ISi6uWLuTii79gE+dIkMGy07UgT1s9lN2zGmlbX5XiBabupcvPL?=
 =?us-ascii?Q?qmRjmT8ICX3+IKDcHJcKoEhiUZml4KLZoy+HCgGeBTuj3gN3Pc2IBG71sM6t?=
 =?us-ascii?Q?DmHKq9ud5JwmGN1jzRAYDzGoUyo7ZGtGQVYSq6foXDYAHq+1mky6gCI258Ce?=
 =?us-ascii?Q?mtPp/bYjx6zV5m/XTiYBz9qwPYwIVmgemGhauibP6R8r3Jjocjp/V6NaBe5u?=
 =?us-ascii?Q?LXyhdDXHTPvEpiR/EYXB7Ufl/JgmWN8PDEAHc18/5SdEDyDLF6tcgFgIchEK?=
 =?us-ascii?Q?xUvM8eVTHDy1SH9LLJqWwxDF6dWm+TN8ehIvluRQTFVGSdNojdXwl3w6Zt8e?=
 =?us-ascii?Q?GFOCxh5QuI50f/c0dXh4a0+kdt0F44el1qk9FWPuaiSfPxiN9Dm3UxB3OLnL?=
 =?us-ascii?Q?hhpCpjQjkJNyTECH5Srf7WWIqqYO6zQspWo8X+5bIwmg4Mg+Tm3A1TVOD9qQ?=
 =?us-ascii?Q?BNLCQ+LAtnmtsHCeJ1a/Hu4B2Xn1+M18Ttsyzu6ygJqRQmAYXbgrNVQhNPQH?=
 =?us-ascii?Q?rsAE5TxOoa//S0+YGGFlrAiynmENx8OBE102oCgGDn8U3qUNn2kCmBe5sZr3?=
 =?us-ascii?Q?lna1IlXrwPPVYSVNVsXjQkcQTvuMlXx6KSKddYmZFZZzVxJl8mR7auVKoe1h?=
 =?us-ascii?Q?4gExAsFsKvZGjD1hLaiTelDcMzhGe2q189FygfsxlwPoBojRlLi3ndNUTe5n?=
 =?us-ascii?Q?i6tIEeusrL2GyZz9Hm1roieAgXxD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PLetCyZqyh4F4trQ7MkgAvU6rglry1w9EIhNGY/dQQFnaIKF/9gbg4WaJis?=
 =?us-ascii?Q?Cqsk4oXZtdP08EEJXhCNIcH/CdvMHTeQ+9WxnjomPQEdCllumtGBDgMiPKuK?=
 =?us-ascii?Q?cwo6C/5SWitA4Ij3VH4khOrq27ToBfL9gTM5Zg6KvJ2kTmAnPc29G66GVor2?=
 =?us-ascii?Q?I8ujKSoB9loRsqzZZ/aHwZoZLvpsGB1VZUwbJSvF9GNJvr333F7pFOiBwYEA?=
 =?us-ascii?Q?sVqwNhjJOQtV4ObJ0jK4cEo55/MOkD09XRItszDVURfJh/j6mcls0s2wL8Ms?=
 =?us-ascii?Q?q3/YFjkd57kfvLfs81ub+NJzL01LZUMsyGAlIcu2/SCB6RGb9OByj1KOYYii?=
 =?us-ascii?Q?YBpzQHX+8PDdzs0gO2z40wx6GDTC6EdHvx7s9RvyljetTqOMe3BSBwQzZ5rp?=
 =?us-ascii?Q?Yc60vuXRHGBFVkrCA6QWW25AgcIt11EfIPWJTweQhZLd0bWq/E7wxkmHi4Cq?=
 =?us-ascii?Q?QJqOQT3h95e1bCNj/X6X6vF/g8bmIuMTMQEE38Eg54m/tAg6pCdZUZpb6+v1?=
 =?us-ascii?Q?OMNjGb4LgysKFzq8TZWD7MpZBmkwaLTZtXplLzxYeKoKNSBrZPQdmN1STz7W?=
 =?us-ascii?Q?j9NivXFypuIsp3zdwfv7FgOmGHzY6NqrcfvyGGYyPU7NwPBXNe6+it4Nap+5?=
 =?us-ascii?Q?SkerqCCRAXEcOhgzNTa/51NklIL5ckwVgjTZVOi97y8AI/vcn7jMJ9M1G/Aq?=
 =?us-ascii?Q?xiVrYTSUq4dBxx108kRPKAzofxJXd2Wjf9qch58McQwcZbzJn9fKUsfDEt7h?=
 =?us-ascii?Q?uKRj8E/8bnr8uLlvlbEtYQuGYeInfS/GwynddZPtE2CVQmvFNzEfaHfpGlle?=
 =?us-ascii?Q?/KIlaFvrfIs068u9XZOc0QayP3Ke1dW2P9+yWwyTwC4l8IXzkrLPPP9DAsJe?=
 =?us-ascii?Q?cQrLJBNcGtaUZyo8o633R4Z8mhnQffQqDT2NoisoXcSb1lw3ercEdhF/98yM?=
 =?us-ascii?Q?GkFj5E4mTPz+CkRyP8x4RbLaO7J4dmdiaLgIAL+B/DRZ+D/FLN6lvwaGNXk/?=
 =?us-ascii?Q?arKSOTZaYlX/6f64Kl7DZg5GAb6Wm4Y2u8UZSX/xwOx6ShTFV9aUAgX0dT22?=
 =?us-ascii?Q?MMMCFh6MVYvryKSETcmNlzsTf7xFx3pBojNbq9BgdsvczeClcz2mv7Ih8fI/?=
 =?us-ascii?Q?bVt9GehXSOzhZGSrFRrca/eDKXGnrzc0GghArmz++cvFLky3GIUuSfJfwYJv?=
 =?us-ascii?Q?iE5Jdje4LHl6cxMLMsUzVKQfN3/FfiwTmNSbvj6DQLCp/gHknNSQmJqyvuRt?=
 =?us-ascii?Q?i1trIeste9OuFTXH7DdSIhIk72CUqRYTznKECPhfbxnPHG3vcdH50OWD+ido?=
 =?us-ascii?Q?u+eELcxiiQ5PgQ3PiR2jO4/AyT5b7SbaK44cVYI6t8HIdgc9nQiURMK/KM9+?=
 =?us-ascii?Q?FgZyqI3llevMk0WxYjx3iHBaQI5UIBMsi6NJY78RIz13itpuMWKVZOsGtEk9?=
 =?us-ascii?Q?8983WWZK0ADfEwMonHK+P7k4RQtmMws+XrL2TsDgGwlhNEsk0dd4ZaIQ9vNu?=
 =?us-ascii?Q?e8XOHypd47XbhBChH4q7thHdR+5vxkBnDVNShWy7Jtppxg7jBltfkBZn0t5L?=
 =?us-ascii?Q?Ls7qv549n0ZErHjpMgk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd9a924-e7e1-476e-ac9e-08dd6ba0623a
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:24:34.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vwr6GOZIn2tpP3dxjCzdF/yY1+pT30QfXaPnBfb+syQ3bcZfL6gm2fren++jzPFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256

On Fri, Mar 21, 2025 at 10:19:22AM -0700, Yi Liu wrote:

> Yi Liu (18):
>   iommu: Require passing new handles to APIs supporting handle
>   iommu: Introduce a replace API for device pasid
>   iommufd: Pass @pasid through the device attach/replace path
>   iommufd/device: Only add reserved_iova in non-pasid path
>   iommufd/device: Replace idev->igroup with local variable
>   iommufd/device: Add helper to detect the first attach of a group
>   iommufd/device: Wrap igroup->hwpt and igroup->device_list into attach
>     struct
>   iommufd/device: Replace device_list with device_array
>   iommufd/device: Add pasid_attach array to track per-PASID attach
>   iommufd: Enforce PASID-compatible domain in PASID path
>   iommufd: Support pasid attach/replace
>   iommufd: Enforce PASID-compatible domain for RID
>   iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
>   iommufd: Allow allocating PASID-compatible domain
>   iommufd/selftest: Add set_dev_pasid in mock iommu
>   iommufd/selftest: Add a helper to get test device
>   iommufd/selftest: Add test ops to test pasid attach/detach
>   iommufd/selftest: Add coverage for iommufd pasid attach/detach

Applied to iommufd - it has been in linux-next already for four days

Thanks,
Jason
