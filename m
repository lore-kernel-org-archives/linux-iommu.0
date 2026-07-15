Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E64398FC
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141955; cv=fail; b=kYArTQ5EnhVNLf+U6SRw0PhG/E2Cynv857VAQGcXT2TBQzve/+avkmKkgc1Hn6AWdumpfUWyir1lGYOBHhUn2ov5cYJ7CK7WKEQeiG6hBdl6Up8wtzhTCOBVdna6y/PZMwtrNSfRB2NP6LHnJ7RqAnKr0jbWquCzUCXZSmF2ju8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141955; c=relaxed/simple;
	bh=qDCjOyJYx8Rw6cn/4nGA8Fj8/XlMkzaw5UH2MhkEY5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GRLI5HSFUA0LQ4miGdNZaGvPmGSyey/qOMWvlomMBQmLNngeGHCooH2w8UIzIChsXGrsYoc8p17uQ+GqHxH7uZJOT0qqWlyN/zSoeLsuf81jsjzsrNctCONCjYEY8j94oki2t3FWnnzcowzWf3i2qNbAq/L1AbvN2e5+AZKwSnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0tsUjxg; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0tsUjxg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtoS7qoJKhJxB3VH+KmKbPmtU3YdAHiG/8ji4ns/CA3sClTRZqzIHrGWxpW/DC/3EQvTx94p0PTxcnHNUt+9GX5h8newUUc0q4HBY0eMG2U26tsk/Y4xwuLP84Zi21g5rHkD03ar2FuvoEDjGaoppdI5dvMfuR72OJj3dkRUmitQ9IorX2PUz/GaY9DED+Fhed8PEq39tRWMwwswh78iT+RBEvmou4w6kj67/7+rWw8WVjDSXLAU9vHb9no31CrAE1RNN13WvtSJoud5l8bN7JAz/NcJe8yYQ92bchGbqkfjUxk7BphvblIdALo4HF02N8+FOlh2ZtFuqRoxbpcAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQzpQKpMUhvzdTzsB6le0Y+bAokOOa4Ihbl4cXMcb5M=;
 b=cNL6tiB3hMNiTwoiety/fnF4R8MwVHll8xGB6au7UPQhNIQulUKd4F0MBJ0XrOjcCc/2yzl1QOVoGOh82AZU4z8Wr6gEqSXuHB4Am86NAe7yB9/8y+obFQVJyeg0BqdoX+4au2/q/BvNDmQEW/6UqzrUvi1wcZUZXDgS/HCSYeHMVSe7lUbC65NSACFd4+PGoKQ2zTU+iE7hTdhL9U0IUj+8HkKmrLZhD3ELh767cwMLj3pI34Vg5PMcD1BInK7ztsRB4F7NGOANOKqHj0L8gANJHxOAIHy5R2zm9BRxeCpjfrlW/FKbIo5lREQJuaz0c9H6dEhUmPuCaGmZXbilSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQzpQKpMUhvzdTzsB6le0Y+bAokOOa4Ihbl4cXMcb5M=;
 b=q0tsUjxg758eXl+b7ww5TP0V7hOn2i5MkdHup/496M2DQTaQP2V/XSaneGrzc+JoA2wrxalerFQHjd2cqLqAj6ILRlhKb+9qSKhjmFLuX5948SboTz1BIY9LKR5S/IUh/rYD9ZtpJd7twNTf/HictJPR5qq+8+4Ac/9GGXYyAD0wU5YY1S19rGhe2N6E7VZf2ZW25BK2Y2oYimlgCYKY425NDt1hx4bYt7hWOs3oR99rOhw39qkhQBkGfYjRZBebnAfrc5t5a70676Aj4ez3zWxr/RE+KX9lkc0qwz2qgCYS7OGLC8XQHxPOJY8OvSrtV2p/Rc1MUlyevU/mXDzEyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:58:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 18:58:59 +0000
Date: Wed, 15 Jul 2026 15:58:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 1/6] iommu/arm-smmu-v3: Support IDR5.DS and widen the
 TLBI SCALE field
Message-ID: <20260715185858.GG3775915@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <3f0c3e7b7e9177586d7e545d8089ead4ef7890f0.1784054606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0c3e7b7e9177586d7e545d8089ead4ef7890f0.1784054606.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e728cee-ca78-4f83-5a07-08dee2a320fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|4143699003|6133799003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z0hmDNObh1vBw/TGVoiC763qWCsm/JPv9PxEzwLqoKyNwOi/nnpoXFoUm05zWgZihS34oQW3T0fC4xKsxwhKeO0spHs7D1/FouyB4ondmNSX68/1lzAImlFnzleI+Jl4oyoEqMOGNsArLoFmwo1Ghliv3JyQ7pTT4NgvGF1+l/9Zyf7RolcOzlGfYFCErljhNRyDX5+RcfBoSr/dQifdtsJQD71gNLn5kWQcYfbRZDPAWWRS/pvzXhlUVGsRlhobNqRgWoP/FFRQNOWKBesMxSNYKDgqj6sqxzFtVHEgIwDUQmuEVCNwKhlDDD86omTeVUxe+uIBp4kafHxM6Rnm1k7zTA3OQWcXaZQRc22lY11/i6YzEgtnjl7wH+t+MrgOsWdvUSWe13vDPCoDF3CWalZ7ZZg2K6JT1WmwzC7TgtPUejng22fmH/R+FfLvRsLqAVG7ct/1X0L93l1NqPADO3kqC96+XhdPWJcIKaYgEbWDgUI4Wb+pVWjZw4PxztOq6KO7HhHOoBFNgT8+hJRW/Rdnc1ilCVJjDe8I2qXl1uRfvdn6kILhWOcEm9H0m8CBJ1r+aKO0+P8mRiivUIBZlMGuI7iYlVf3u9iq8GnidB4iCHAsUd35m3C81hmWb8GbNwJtZUttJNL1zOQrZ3MCiIrUk8gEqFiuJP6AGw3IVM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTISHHLXNZ5MwacbPzNsZcrr5cloeC+t+yUw2VgsvrdBoXXAIv2aj+zs1Wu4?=
 =?us-ascii?Q?OZlj/YoBlTd6nl4fwurpyw0eeDSXDQ2DN+Gc87sc0Nw9GNTVNkPKQvcesMhq?=
 =?us-ascii?Q?M3OMortQuYSboU8Xm7oVJhRqJ5yBvrtFX0fQtARuqjNnRYlksxSXoKnxazpu?=
 =?us-ascii?Q?27/1tGrzuGRssKSU5pdNuPm0XOLD4WWBo/h5mJGanf12pvCuqCivkGuhACgv?=
 =?us-ascii?Q?hdPLykjj2bm19YEOCJeJv3S2egOv87klCPvRR4ZI6QErF7+pYXiS6QX3RhAk?=
 =?us-ascii?Q?eNJynZMhHSQHQfmbf8qneuEB850FpyDCDcDTbz/6ocXsd5zwPBc9pM+FUUeQ?=
 =?us-ascii?Q?uNqGJO9OAbOfw0hh7QaXdLnUvFHLeGWuq6lm8TMpDEwZs9/xv+YDlXnUwZWc?=
 =?us-ascii?Q?1vn6NlBZaLdvr4bBPuI2s+tTbQpXyv/xZa07Ui92UsxBciajRMI+XiyI2aC7?=
 =?us-ascii?Q?52a5QrUAE82xUbUa+qfyoewoYHDUL+rbwmU+K7pfqgTET4OlEMs6Bc5VH9iv?=
 =?us-ascii?Q?X9cfFciz3Ln5pW+bCAsMrNKx8RNfv4um+fYYOOFVOUZXQdGu23U3VhDehPvv?=
 =?us-ascii?Q?VG//oHxsiDNIK0Hwuif5VvIhtmIDtzfweBIxygVIFO2PpAI8ni9hiCgkiJYR?=
 =?us-ascii?Q?/PpnX9rTFipnSLvhjwygNxi8wJ/U/LUip9FGPsP0Xq/G4C32bfltjNE97b92?=
 =?us-ascii?Q?74UO94sWoqBuXoy05p8X8vVm9sXgaTiPpgUcZJKYNciyDKEMmDHS6P31ZnpH?=
 =?us-ascii?Q?OyhIQnUQ/Urf0TRY+eY7G3RTj+LuOEhxtGkwVIMBvBNNVjcZlCyM0hYzlEB9?=
 =?us-ascii?Q?/yj1UTMP096kVuYb1UsPbfP7UeqqqPVF8mKSOGU5iMpBTQDiHU1nVFZFFeLj?=
 =?us-ascii?Q?ieIpATx70Klzk0A3z9mJJS+/kxKTGZeO4OupS7s6IocyEhNfgJGaJczLlosp?=
 =?us-ascii?Q?7pIjl8Wf86n9lA8fUZLNUlUYSYTesiLuEh/LnexjwcPRFxgKgHyAvZMXwYgz?=
 =?us-ascii?Q?wRB/K+wwD2Zswq+Cw2G1ls/ce2qa+WtBI6hci1prJ0MzheBPu06jSMWUfuDk?=
 =?us-ascii?Q?yfIsXZULS2dmrnJ/kkZtcg0GlEKCEmqQZlUe6P2Kx3pjRCGR56luR+/sr+x+?=
 =?us-ascii?Q?GT+w+HMd+CmUT7iuxq7S7jZI7Vde4wA3ksoHE7IALxEkmw35IxZTmnJEB8t9?=
 =?us-ascii?Q?HX4p7pSiuJjkH+dKOvvVDZRXxP2yAtlQ4GzPIzjMXXWPJA0UownRm7XxX9HP?=
 =?us-ascii?Q?9NB5vZm6eHzxwzOl32f/asr2oor11VxRaOBH0c2kIqKZRTdX+VPa+kMEQmhH?=
 =?us-ascii?Q?zzRkJzHi9BcsiLz268cO3gOhwGB/JuxTk6PFLqZgklmq83vY4VjFxtqR3XTJ?=
 =?us-ascii?Q?G4LH9wcOgJXCr2LO/mVp7JuVSltzCJJMgeo1wu0C7TbZN3uuLbFLm7mhxHWM?=
 =?us-ascii?Q?fHLx2yA7/v6uATaQ+JD784DZ40WWpXhwb3MDxIQluHj5exsWYaM1+ICACs3R?=
 =?us-ascii?Q?5pmbRp4FSIod26RhIDZISw/zkC4+RpLLuPB6DWTuBVl+gUgQCKMFhhnkuOKC?=
 =?us-ascii?Q?id43an2Y4Fqqij45aCy94ZucngDvqGyBvG0DpZW2hgZ6lop5MI8ahsKamjLY?=
 =?us-ascii?Q?bx8tUYN9fOOMKW22daqGsCmNjdkBcJAZ5bTHCUJnjPkk21Ub0pOPvDu+eAOd?=
 =?us-ascii?Q?63Ht+7umOdfWDzZ9j8J7yENtjnptn2goS6ZOpKkqfF4rq6yc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e728cee-ca78-4f83-5a07-08dee2a320fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:58:59.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4L/tnqQIWks8XpkAbesaF8xKdmo6mHHuHWuG6Bnwo57CWUiyCdYMOlQPN9TcSH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8

On Tue, Jul 14, 2026 at 11:48:47AM -0700, Nicolin Chen wrote:
> An SMMU implementing SMMU_IDR5.DS extends the range invalidation commands:
> the SCALE field grows a 6th bit, raising its maximum value from 31 to 39,
> and TTL == 0b01 becomes a valid level hint for a 16KB translation granule.
> 
> Add a new ARM_SMMU_FEAT_DS feature detecting the DS bit, and widen the
> CMDQ_TLBI_0_SCALE field to its architectural 6 bits. Mask the scale value
> explicitly in arm_smmu_cmdq_batch_add_range(), so the range invalidation
> path emits the same commands as before, keeping the pre-existing 5-bit
> truncation of a scale above 31.
> 
> Also list DS as a valid IDR5 field in the iommu_hw_info_arm_smmuv3 kdoc:
> iommufd has always reported the raw IDR5 register, so a VMM may conclude
> from that bit alone that it can expose DS to its guest.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Cc: stable@vger.kernel.org # needed by the subsequent fix

I think you don't include these tags, the stable maintainers seem to
figure it out with scripts when things don't compile, as the next
patch wouldn't compile..

> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 4 +++-
>  include/uapi/linux/iommufd.h                | 4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
