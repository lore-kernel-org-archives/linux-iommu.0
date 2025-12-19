Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE7363C69
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161854; cv=fail; b=EAZxsL+y9lDoGGtkEnvFg4e2CvYt+LQBtoSLUfEy7AkweO4Ijf9N+esAQC9gPlIuxVeTfA8RbOHwjYD6+003UtN/Jt6lbGZp9Cq9+LvpvY6rP/d730wcAr2pDpIYNrWoNEmdUJfbbiQNAbQRrZyz+8MIELjbzRSoqAK2Qh3GLUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161854; c=relaxed/simple;
	bh=+L9WIkgcLSvAr9pqnecdERW9wPWfOSnLLAoL5f3NMLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aCEhmfsrlS2kUxJgdc49LLP8qv7akCDaMExjY4oSq5BcZdpu3WWmb4mm/iSwkCRYgkpL/z6zXx07sv80TthHksrRUz5lBYcj1CvednebHyuh3RSQmahfJoOF9SbWl8A0vXKPlHd1WXbcG6yQ5xRNw2KcmyFPoDxARc5k7RPmVDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MtwUIcGY; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MtwUIcGY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDC/YIwNIK4HGHzGCI9r3q/Eq+D0F5KSvt24iQqKUaLQzZuZI+GmcdrPaprmjZ6o6r/9U1c7mwoctuNY6WEStIKvoGSoPLXvjUQ4/eJiTcIRFa6x49Brx2zwg9G8ahO1868ps7u5rRhF6FOT0PKRtFHTJmeWgM//TBNwoHXtFN/SPNo9cQJEdcWn9U0dkNF1qcMVJMOjh8SxQouPQVN93qkNUGcv5ooKr3lL5Cak/utwl83DHHdn5LnDTuMR+epJHZ1smc8PJ/OhcMpaece+BQa/HmOb5bHuwzJr974S5dNx8nqyE0fOPr9Ll81sjxVwaB0bV7/zvmEejNEUcreuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laLeW5RlJ1kKx/l/jyFWcmhc/iGFxbD57cIMt493Qr8=;
 b=WgH5mwTwLroPIZ57KfWrOcXE0oup2lzzehd4VOckM4k/RZwdyXjxZZzJB7HcEzyCZueF25cwIvW6V/H9D7hD2VVU/JHCGa/v9spQ18WwbF3zAhBe9N7TdqUacwyeaIi62CXNq/I2z1eRPTOaCvE0C1aZShWSpNZgy39wIpN+0Y0Q81kUsNdPWIR9FJEhoXMi32I4NeLT3goJKIYQfe9VnFinBaTtyern7esVUb028fMPDmuJzM3uXw/Pm1nGWTTtCcjq1JmPZ/VRBUAgljF7jvlK443mxP+tvSjbIL8qi22BxpIO+f+Tw52cG+fEuphvGC6IFVC1OvHvL6DAS2aBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laLeW5RlJ1kKx/l/jyFWcmhc/iGFxbD57cIMt493Qr8=;
 b=MtwUIcGYAjmJfUlNI4YfNe8ki+L/Gitm92al7750EkNCvzZlo0Vquaxew6PgXt6PIRZyZp4iyIOuxgHz3agMTboeFYQrvx9NK+bFwWXeCbv/LNZcveUN0yjvuI+caiDDMHsOyaICpSWhzo5UFEE6tWckiaHyjuLHuuTsOggQqAkmRsnXKHXr1zQxycQ1D1dc0RIVbBBB8HvIGKkdoCZ5oX9Xp/cA68UkLlxApThCUsglO4sTIeIalngbNhzC8Hg+/njSi7M0LgjemrTdR3MqnM1wfvW28tsNqY/84YYErrcglW7SFrda6txTVt0VS5vHEFj6SJ3AfF4C918hXDFlcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 16:30:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 16:30:48 +0000
Date: Fri, 19 Dec 2025 12:30:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <20251219163047.GA376568@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
 <79cd18a1a959ee2e54683e8c465b799d49ec48b5.1766013662.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cd18a1a959ee2e54683e8c465b799d49ec48b5.1766013662.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c79c4c6-c790-49f0-0a30-08de3f1bf7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1wgblWxI76V6VuWF0oS9M8fvp56ltA/gIKGtMypwxuxSWQTdeyWSPVj1ef+5?=
 =?us-ascii?Q?P4PizvoDijziyBboiswgiPGHKOIh4lKd3zxLs/AN9jTuK2oZLM1aCzdK1mlY?=
 =?us-ascii?Q?Me/qfKg0iwyZhwX5nCnp3J44opHUT9lf4DjsxDXuuQeIofyDTSRzB20n1oMY?=
 =?us-ascii?Q?8Gsbsbg/sL/b44UM9cRzULfeQLWfhuyTB850AG8Y9gLNBNfLSI2dqbG5XmQ9?=
 =?us-ascii?Q?eOzFIfC7lY0FMR9W7Rl3seGl4advB3z55DqbBs6Q2InemSxeTbn4jwlGCYDL?=
 =?us-ascii?Q?xfgMIzAjiYOUxMPCs1VVM3gCilbGb1RKAhx9yuk89PES7rToBjt9x9Ciz+ZT?=
 =?us-ascii?Q?kQbL9WEab9LcZ/brBXCzh5EYuv/50Dq9aIJI7ZzxcRPxao6/Yrj+bpnT7NKM?=
 =?us-ascii?Q?nEe0Ns996amOJVPTStEckDvv8Hr3gOqiKEwS7dO+ZxitdZW+W+eA6BG3UY3g?=
 =?us-ascii?Q?Jh76wSVZ6oIrsiQrOT/XNTSSOTpHaIK7cK6r0YQZ7boHvDHIDjy129LpXX4T?=
 =?us-ascii?Q?uDEBnQyZOEOgMlbSxDlrCga0f7d9gAWp/Y0nZDSzlA8rGDUNMhZGDhuMGbqU?=
 =?us-ascii?Q?ineiZlkmFCPQ0uXNe1DBFi117lRBnrZIsEE9gShKOEcsc+tvoeunMZM51hU0?=
 =?us-ascii?Q?DL8Gk9hLTTAr7TaxdhkYjwWYfYmFXCnYZvGwkLgNclEAyElBiz1iSQgtDrDY?=
 =?us-ascii?Q?MZJzBefzeDRt3PODu70GisA7I9OfHrpJXxZIGuQUu8jW9QyRiSjoRu0MXsdA?=
 =?us-ascii?Q?D3IEN2Hw4Aih8zfx8th8VxRk3DUlfU4bv8CGJ9W7K0R1tP5zHrHGUwAr6q48?=
 =?us-ascii?Q?uxa/JXskKwMMMAHekhwVsYpzRE4Omo278F41mMqPzgwFUWApVS0P3UrMwGNq?=
 =?us-ascii?Q?o8M1EGEuTSKni7G3hKowylu+L3kdn5oCMqKKU/Ti/ebHKK8pQBS3oO7i7vzj?=
 =?us-ascii?Q?juqKM4hf0t+VHJG8tW4YqldoJlYMr0RnvRkitPVn3K5qwzzbOXq2zjCVwBPN?=
 =?us-ascii?Q?UvqlpEyXpkdRHlrXGVvbRm1UJ7dHAPLyKIxsBua6quzRKtecblmdRxW2I5o4?=
 =?us-ascii?Q?VqR4lcx5GvwqWavWrZZB/8gRVwvC0X1x6TPAgns+KlTfHgf0YGqmsteG/0dO?=
 =?us-ascii?Q?U8OGeXAgTxeojX9M1zGDdduXVSkzIf5Ho/kWvsxVgiEYT0XpAEJM/rSK2Dun?=
 =?us-ascii?Q?SQ5xFm1608e/xHsutmg3b22RQLWDsbC+XjdXFjF3ilr0TO5dEVvUpvwNAliE?=
 =?us-ascii?Q?ym5fc9j8SZJYhwCAeJndPs5bh+XiwIDR6rUUdKxcsdn2kDeqCIE8CEJ9Owaj?=
 =?us-ascii?Q?FpvMnbTYcty9aQ9tc9StkOBJhimith96b36ZhftfEkY87c3BzTGYZmKtlAMm?=
 =?us-ascii?Q?l5WHrvbpQsq4nXhxEqgXErxqzAWoJVPTEZxc1s6GyjXQAmVO+aNd2coZAQZy?=
 =?us-ascii?Q?0gUpzfhn/vny1mI9Qhn/1zy1fBcFC9EJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7GKEmiEqk7jxG88KCAax3NiefM9x9Dz9+IWdatEjz7+YKQcsQ1o40FGxU7I?=
 =?us-ascii?Q?bkPBAinX+aWJ2gUoergNwxrzM4VcuiHnXEeo0nkcz9s4YjM4N8nvjoHrWxkR?=
 =?us-ascii?Q?kXGBbCQBorRqaBdREUjMCR6P8rUC2voOa2WweLkb3ElyrJtR/fqTIykNOqPQ?=
 =?us-ascii?Q?0V5SyzA7dhQAbqa90b5a0n/GfO48UDMAG3h+Sb6b6MmGQLpFNxEq39Si39y8?=
 =?us-ascii?Q?r4t6qiNqOAu58B25wO3AvN0WlTMBezbQfDyQeent102whbMmGMFL457lWPLF?=
 =?us-ascii?Q?zOxskDMkUcf3QaG34cHY2iNe6nGJTg+fnTRxkYF9oGItwpvatJsacU6vjVmt?=
 =?us-ascii?Q?AEsFBIdE3vkhAbo0GkxS1iW8TjLBmJaJ/XM1ANTznS8QQpwYxoaUotTxYOYz?=
 =?us-ascii?Q?oZriTjYXvj9ifEPvc1UowIhDIgbhhOHLr0rF/2dfpxK2jJlq4/xgVd/8RuFo?=
 =?us-ascii?Q?CskIkXCR3mS0Jxt7lyq9/gFKY4QZ0NsMITk6fzU4ONVJEcT5gZmO/sh881FV?=
 =?us-ascii?Q?euh4f6yRnCDutHDRTma3QWtrKAsRxzak4MfJFkHKU0zidII8Ek6+6nyY5G1o?=
 =?us-ascii?Q?8u8aGLhL7CDf5f+LEVmbynZeqv6v0KiOxMFtfB57d/9QiIBq2N3bR2WW+vRE?=
 =?us-ascii?Q?LB5VXG3YXOeu+WSegoI47UN+nKNW1lRYXn1yx7bvCIlMgM41S/8d+X4JZbZn?=
 =?us-ascii?Q?+PknhZ55pbfre3mAi5LfxL3MKDzPEt0Kh/q+LD5ZlyFtggvxKIISpZaYZqiW?=
 =?us-ascii?Q?1TFHasXcGlHSEzxHAkEg6Rkrsum22f5hYxBAXqKaQ/WBjpogHpqneznCv1Vb?=
 =?us-ascii?Q?XdYyXp1yaWQ2FX/yyfzNvjiBzf6XlmFG7rlEbHifunPR0mAccwosgxVMnbgK?=
 =?us-ascii?Q?K+b065Qx9arp7sDhQIcFU3oz5SaCsB683eksfvTrn6l9LR/Y8hkuN5UkMO+L?=
 =?us-ascii?Q?6AFdSNQPmn3d6sg9q02RS9pfuxekJx/Be8OHJLvUWZv0yVEXYbT/qCawDg+M?=
 =?us-ascii?Q?N2nFEIBoKqiGTnrPmfSshZAYxT2EzGtODDve3l1Uf71FCKoa/Ahz83MLlh4u?=
 =?us-ascii?Q?RQJnO+IfUjfYAtfyJcfNmIaQeb4l6Nw70a3z+ue1wGUPnWerg+pk//mM7j4J?=
 =?us-ascii?Q?4WzoYZ+Tfqb8kwl0+3BTOfJIJTh1cbMZQ9ehjWVHxWr2bmPk/hrF/Tl2FVT4?=
 =?us-ascii?Q?DH6fx5OXg959rH9+pdfb+nY4NOlDAJgNkcTFxIsLLkXFzESVBQL8KU+OTlAf?=
 =?us-ascii?Q?GyFbrRAs4rZ8TK1UUka9Er/FWVrRV7i7jngAGkjfko7kATsF6AC2LfPVQiBt?=
 =?us-ascii?Q?RDV3CWO36Fsc4xoBtYVwix2hXqce5Z5rYGVVzzR7lXkK/+5mRAGG6oITjPEf?=
 =?us-ascii?Q?KB2lCKkSEfh8gPRKn2fI7oCRagsmfzhRur0NDVvpID0W5YCTQXhQHAzKQ4wc?=
 =?us-ascii?Q?XxNnKRcdjXaOuQlCXHwVFoYgVxd7Rrxn1sucWOZ/FMkqCetqMBcJR8QAFb9F?=
 =?us-ascii?Q?zkC0g+2ZHvlvq72k991OnSfJMgsv32wHsIpNDfdVbEcSsg8s2C51l9aW7L0I?=
 =?us-ascii?Q?YSGDSFVkjWVpnerDrPfYBqvpm4arH8da4f4OT9eVRR7+Wz4PJGq12Q/GMVD3?=
 =?us-ascii?Q?IDSPYwmXksViRtGrKz/xQENvtOpJ19VycPJT4JYuFvLs9NEB+RO/EPJU3HMK?=
 =?us-ascii?Q?cFoWCXUVfW8/f3sKVNvrSyeiSBCwaTbJXNDH9iYKaBAU8keA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c79c4c6-c790-49f0-0a30-08de3f1bf7b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 16:30:48.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miAbCRtRVQ832ZX4GlPf9OA4rHUQMlOsbLvETACYqLqEggy0gUKXh/lBRb3e4kea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Wed, Dec 17, 2025 at 03:24:30PM -0800, Nicolin Chen wrote:
> +static struct arm_smmu_inv *
> +arm_smmu_master_build_inv(struct arm_smmu_master *master,
> +			  enum arm_smmu_inv_type type, u32 id, ioasid_t ssid,
> +			  size_t pgsize)
> +{

ssid is not used in this function

Jason
