Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4B2F6906
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025427; cv=fail; b=ftCQyMUtojhIISnyEth7S1FpHajjolroqo6rFzPqgB0g4rMi2oh4IyYt4297dt23jERV+w4AIR4LfFxTkutJN/D4hPeYoC/Il6ee+UsSOdjR9OJDpZsfWtF/1VcR6mUv92tVWQe/LHZJHSKJHFQLVvrUDvATAWxJQ4m9IQjifYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025427; c=relaxed/simple;
	bh=os4R3hmRwvAogNeMbHEoqVwh0L3+Oxo1J1KbfC+YREw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hyF8OcRT9W+HeQAxXkv5MBXEJX4iVgmpjp4X9TQ39d/35wmKSQf3oLvR0sf8t9U05gox4TP0G7JundSItGjvgWIiW+W0J7pHwHzVs0g59M/9nd6s8wIZ7eVausKNnIVkcHARfba39qHB4fidccDbHmfFKacpaevHB5qCilttD1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hmnoS+qG; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hmnoS+qG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TehHO3hfBs7lMD9BQR3iw/K3lb6kyRu8Lqbpw3IbYj21L7p71BLk31C/5GjiJxAhdT6o+hQM5SsBGxXY1nvAVFakwP2tJILrz9/2BHfqlKBcYpVkgdRnuV31sSsLjpRTd5wVgSuivcgWGzVciP4aAJeWPokkPWvi0k4EgRIsu9JLAcFLlFkXYVsl4k64DzQP2ZJ6mXPsrxFzoh9rDv+75oSa7q8mmLvoe0dO1JG3HPkBlzGlptW6Ykn0SpptsOfdFQ/8PGpF9R3BnXoJYe/hsh840d9jZeISmG+hOsSbvluB3vfzICpEgC2WkPFx6ZYAErkUeyh7lQi0TCqyeuTrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgkEoumk9SnfRDWCgJZ03sXC4kI1IuhJslHBqXzlVYE=;
 b=TdrRPZaYFvvophDha1FR2Yx3vjuYoSMU4dDvd1/R+EH9ejTvVV6rKEV5SO0kcyzWvrg/l/We0MaWswaJbMQaw2wr2iDrfBM7vZkOcFkcRdoOgNAPadzVL0ay/y6Y68q1kjVmnqT37BzfXIhv/aZ0CnMowcCQV4WJH4Xp6kc+9gZcwUit0nswId2mnGbwD4l90bYtwKlkPv1ykny65C3Q84Kg+0cb2GQh0iJW6t+6Xrf9HMbNgAXv5nQAdbBQA9DHs6ONW5tcmRyUVgA5s7yzVIF17S+Iy+4clOnDnhqulDi7CzrwZvAuYZu074MT7XW2PL9OK1cC6351sz9JDKDkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgkEoumk9SnfRDWCgJZ03sXC4kI1IuhJslHBqXzlVYE=;
 b=hmnoS+qGJ1vmYD845F3sJACSPnLxU9lciycG07HOQusR0DHuhaDzb+iuFpQ+z3S8VulCdoZfYBlwt/XqOZkgFipvMcIRX4AIB3oLelFX7bPHyGdfkqWNypJ2kBhfou99MpRjFYNm2mgxZAaDnOvDp3k4UwD+a4Ow1rOBaLBfgtWo7yb66O9yQ2ZwnqGsSzW8MFgbX+Vk/03W5yQqTtrLpPb+Xg6ZmCBzbT976JOXYt+qG4G6/6T8oK5R7d141HnMxkGy2372csr8DdH3fSdyKrZuZVqWo5cEUbqmPE5H2pjVhf+d+lEdPBBnYyanK9L8D9NhA0mOynaj8Beun1v8Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:03:41 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 23:03:34 +0000
Date: Mon, 24 Nov 2025 19:03:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20251124230333.GM153257@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>
 <aSTRRyTBh1nATwBa@willie-the-truck>
 <aSTfC5WFoa6sJlBj@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTfC5WFoa6sJlBj@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 0163daa5-92d8-4ce0-0ded-08de2badb1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIQph/E55sY4Yl9wmhvWAcqE2Wt2MVHaa1N6A2o5gsVq8MhZDsVtrqvoMetp?=
 =?us-ascii?Q?pyl3T8BegB0B/wm2r/ljRregTuHIVwXPooMGpkLVaUV8nQpkSz716VzR4Kt7?=
 =?us-ascii?Q?zWBBaWzFVgPC0vBUypMh9So2FK26AB4edzdoTvkAohkLMO+IRGUqEfD/hP5I?=
 =?us-ascii?Q?/wbpJoKExOHLANERa6MUP+me1/oVuVjdaA1vnFHIqHK65TFIL0z4XcjO85G2?=
 =?us-ascii?Q?KzoJdjiaiKJw9/hc4jh6i4pco9uoGyfr34Uqf2rivNl91t8pLab5RvdhIv49?=
 =?us-ascii?Q?561ZKA9AM3gkV+LEo3gHrcbdUoVYyi1apFNJ5ls622maFkC9j6sT3AHTg6Px?=
 =?us-ascii?Q?CaE9/U5RyLLakTQsY90BbjmBYPWjtrDk4Pduzm7gRwpa2Q/sJJrasvMLo0u/?=
 =?us-ascii?Q?Xz9hdekW0RFLL13xf1PS+YjVE5TDCdfXEccKqeXuvyugUyIMpO/ycqnvTpEv?=
 =?us-ascii?Q?Zfgr/YitWxC2M6sdJAV4E/kVAUBhrI9VW3cBYsc8Y37GOSqhXo9D19rNyA+d?=
 =?us-ascii?Q?ZY1JZ2HaVG/i3zxdh14b+CnJGzQTuP5YRQ/p/5M5lGfWjTuxMksq/X/uf8Ao?=
 =?us-ascii?Q?7SJ3sR7HBNSoa5hdkl/mgo5qOarDDuKKDec1nDDkyQbNoyDE23aWgF6jYfyM?=
 =?us-ascii?Q?ufwzHFVNoThIrOv0gYvakYgtFtLzXkuRyglOuQwnpyPNoZVhtNCQIaXUxsaa?=
 =?us-ascii?Q?8CX5ohKWCKEWRln4Nn1C0mdqwi8o7MvPegzHuSJuMxr+n0NY7BC56b8GHQF1?=
 =?us-ascii?Q?/jmU3xnLU6b83pAYp4MGQDehq7KyhNrBvlKTquMpEKfvGiHLe1gWQ1k9ND7v?=
 =?us-ascii?Q?whB2BPALPwwc4htwJ353l5zSGO76ge80uqyZDeIOHJY4p0lkelEDmycaTBxl?=
 =?us-ascii?Q?zRR2UqbYuPIxzvVNCX+RsgvKOVzMDln4dPQOeVfTuwCE+XY0gvgFZORztZsM?=
 =?us-ascii?Q?E09GhvV6lCg7xIcUKm6PUaPm+XaHMvm8do8Wy67gzc9zKC8g1uNlLcrWxr7x?=
 =?us-ascii?Q?AOjYvw6jqe2ZLLCXX2lZ55uytu6iL1zR6yMbcPti0zu704hHBGnTS6v9R7fJ?=
 =?us-ascii?Q?Y5GEF968h7+uG31Yqi8I9jQ08ZeT3Ji3aUEMWH+JJyBj+aidQifCSDjCN5W3?=
 =?us-ascii?Q?c13PQLaI+ax68V473AIbCvTCLMk+L2oOH41Q6UOGgIFfcJ8tdsDFYeg5sff3?=
 =?us-ascii?Q?BtxF8oIpXa8afn308Kp4ln49jj1hoqTV/tpQA6BIY28RbelDxac79VQJC4qH?=
 =?us-ascii?Q?Y2M4gWuqC4EUJIaV4jdbIEMS4F/5jQbLb8WfF2t8nou4WruCAguRNjGWI1LH?=
 =?us-ascii?Q?sFvaZnQNVVttjeyBSjeUXmMFkwKvgGbekLDX4XF5sdgo7AaMBDGrBipOTMil?=
 =?us-ascii?Q?5WaFhjwjv3Wu6kS0YaHqgPhE98Tn4qT/4CwROV31akK6hFCv0s+xI+BKBBe/?=
 =?us-ascii?Q?sXFdOjAjNfPk5A291AtmVLSRMrWK9loj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRQ45P62tHW0jrSGAwkm7JEI+J2w/5W5fd5kSvBX4R46Is13xZ7IZeyW01/e?=
 =?us-ascii?Q?CtAMBPbgyr0wDfGDz90mwDhzcXB/mTtw4veKsCctoI6/iw5bBpo2M72cNpCv?=
 =?us-ascii?Q?NCzsRSM9dN4unQYB0KCdAsEAUJOp6fjkRo5pajnTV1b9FL0r5Jtw7MualKYS?=
 =?us-ascii?Q?emz+enk9LLh8nEZykmmqVFDrlCjI7NVFoaEdjmP6dvxGmuZshopgOfbYoGmo?=
 =?us-ascii?Q?5JlLns95pJBrpIFi72TCKuqisO1QEYbYc9vzEsEZSb8ymPGOO+nEfUV5DWCd?=
 =?us-ascii?Q?LKT1ZMVGX4U8unngbKSvY03RmUXdTK3Ox2t2YM2OeV4lNGkxYjouSkLSMZe1?=
 =?us-ascii?Q?b3AUfo8vpP3aUOLi6LDXvPZCaDxIvZw+CMrhyGAhg8SLxx864PW5dY6LGoz/?=
 =?us-ascii?Q?5A7eLyrGk3xBrIu8ZFwzBlWvXpLzIpxrjuPFDfIfAnEpogdMdYeqLLPnXmh9?=
 =?us-ascii?Q?rSgTZCYBXoqX1DSB9WRMR5hRWE1biGc2m5sQxcg3C86Fbne0qzIyrtotSsMi?=
 =?us-ascii?Q?SJktw7VHzBjGEr9qL4cMYhxWxAmE/WrbT0FD8On8Sgtyl6jzuRUOFuMLWDEq?=
 =?us-ascii?Q?VnC3VlQsUO/1esIZRnE+YDMy1i+jis/hODZJRIIPCrP6W2eBT7wrWKmf0UY7?=
 =?us-ascii?Q?DQNu0R47K0jsalS3rojZGb0X6mfUy1vsriBuT2alNeNxTgrtTYez/lSHkhGx?=
 =?us-ascii?Q?qY8859KsJWHvXYaOo4DTBezCjE3edwokEj4XEgeDSSTQ98hJlmbV3WJzpGLe?=
 =?us-ascii?Q?1Wz1rflbQ9t1BOYgvU+Uj/Sy6vB4wuRbNdrU1TEFHiOK0KX++N86M4b9WeAn?=
 =?us-ascii?Q?237OoLtnEOkIIBLlgo0I5wNYF/Np34gCj2zTatM8yZ/cqp6rOI/C9Hf9VoZb?=
 =?us-ascii?Q?TL7xpE2tMG3alNWjD6isYIgQduf8lFC2ds8H4uq3dLmlfnpM57lqjC7YpHLS?=
 =?us-ascii?Q?4aHVIRF3pP5c1A5kRrZ9fUkF4kf06Ub7XEtfUAnZ1S4YJ0E7CsqnNR4Ytn/G?=
 =?us-ascii?Q?TSYFRKg6GYrJsrUFqpao+42fpb5Mnqc9vSHCAezht/a3mpLZnJWm0pPcbsS3?=
 =?us-ascii?Q?Pa3S5ktV2Ux8LbvKChL02OX6i0yyhh537YW1GzN40ZJIbaZ39GhHIHU1yKmQ?=
 =?us-ascii?Q?M3II1wdCXnJciTbBdpc02y1Hqt8hwP3JRB8vmYVP6h0GiADlLgqWTYczEp7x?=
 =?us-ascii?Q?ZbbvaBgdiS+KSjevDZFPRFN/47pxyl4jP/qPXVoNhTjsEWMIyJJux+POQUTN?=
 =?us-ascii?Q?fXRAGkQdNSO4sO8cmTG9FUR0wWQLr46j9xQ2FPp1t0Muo2Hl1RcN+4fPnkZ7?=
 =?us-ascii?Q?HTCyvMDS9iKKDiGXXR6zZ49LCEWtHgnWJopzMSxhmD8cCzSKjOd24fKDC6dn?=
 =?us-ascii?Q?oTdkdq0V8EdEB20AAZjZ+gBGbCtuETcImCGIK/wJWRCHakkxyngu2uUMQJsP?=
 =?us-ascii?Q?++4rAuTtD3iWfz1OdzWCTb+RHbGZBEJLlX5daNeNK20gmYSfH9h600T9ghnx?=
 =?us-ascii?Q?cmLeFlnDy5y7Vkvsa0X9nR8TnIpHwPsLeeKdQDKyUs5q1/9YknIAgqVmykYX?=
 =?us-ascii?Q?wU8eRp7YGeJ92Wpk6Jo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0163daa5-92d8-4ce0-0ded-08de2badb1d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:03:34.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoJ8lWPZxBAJkeglvHlNw4U/RxMTGJf1FNVYBdGks+T5kTPGYfzBuH1m+40uWwT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On Mon, Nov 24, 2025 at 02:41:15PM -0800, Nicolin Chen wrote:
> On Mon, Nov 24, 2025 at 09:42:31PM +0000, Will Deacon wrote:
> > On Sat, Nov 08, 2025 at 12:08:04AM -0800, Nicolin Chen wrote:
> 
> > > +EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);
> > 
> > There's nothing really SMMU-specific about this data structure manipulation.
> > Do you think we can abstract the invalidation array concept into a library
> > which other IOMMU drivers could use too?
> 
> Yea, I am trying to shift to that at this moment, hopefully to
> combine the iotlb tag (asid/vmid) allocation as well. We do see
> it could be quite useful in AMD driver already.

I do want to see this, but also without doing work on the other
drivers to integrate something it will be hard to design.

My preference is to get the basic system agreed here in ARM and then
move to a generalization. There is quite a bit of work needed in the
other drivers before they could use it - which makes me worry it might
never happen anyhow. riscv is probably the closest, followed by intel.

Alternatively we could try to just move it as is to a little library
without pushing for any generalization at this moment.

Jason
