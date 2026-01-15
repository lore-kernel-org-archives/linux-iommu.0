Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A239B492
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482719; cv=fail; b=pXgW0JepgBrVOq0zQiJWzm7CmTofvt3QfuWN7SgHir7VdgSYkkHpDjuttEjOcqNxt7irUd2zzXBa6Jeya+x0+2y86Wzap70vc6Fyp0cJXDkvI2cG7EJ7OZvgPeUyUn6fEbSZP6BtxPuxydzdxvxdF9fpZt4LJaynjkcjk0t1kt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482719; c=relaxed/simple;
	bh=tAtOEL/MlNjNjwC6TEWOIqj7aUzstLmXAsAYpxSc9y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P8+j8LhRKXpfNxoH8hi3EQluxnJInpBweaJI7QEhCb0m7reKPXGKg1tqPlmxQ2W5A7LpKR8+aBT59YuZgwvDSNxTQsxpfrqLl0qlt0yWb8d7F4gHDAQMiZwku/FrqPoPdNP32LzfUKV8Ph8EvaBEIcL0FfPdBvNZQxLN0DkZKFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3LWKB5E; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3LWKB5E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGcMcrHvKhQ0zcZLaPWtUJq4q3VTPuagLJ42m4xaDSSrj7TzarwUrEgmwVXCUV1GLJ9b80GQTL5CgJW70DfV/LyNhSqVAfChm+/kmR0ELT0YeqfmURuEfq0ocszIHbDLYaXqHpJ4GZLpuvWbu7S5fPw4utfCN4TNDieOkqQ2Yf8yFIgtOQqUGi7mP0BCvRQ2dUKnnGEfjQAWR5zxOH0XVNthxiigPX8hNYBPpnrmoOJoamOIw0L5+01Qr7TrJZQ2rjByrwdx5DGpxWWz2q82RxtOar5D6M6wi+wMPp52x8mAjQLskvBzTR5cn4HNS/uYelLby+RYITigkPCHdvCGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPXnTZbBCXvkSz7ju6WnHSJrko67/77sDE7sbkgVbew=;
 b=tI4CUU6m/aC9mqpRarMZZSVBQsMWwUzO1wtRFC8L9/+dIHbg7ZsdVr8AwUftIS209/MXI4jC36J8HSct2hI3IqIMjT12sqRh3db799xdy94VkYb1biZftYiZffynCCngvybiNFLIbdJSNXicybvEurj/PKyJ9WppnPRO/W2jhV3BIXN8vPhXqdHIKlQJILs0wyBpX1sgf0KzDmAjTo31JxCxoMnyv4w0tV0lVN2QDF7hYtDrlfFzP6CgIyaeIaTAu2dtUZNLI/awh7tzor1zXt2/opfjtop2Gc27QNz/sVrEdlwesYacgccbkdFehudX7pyq4DZsuV5Hgk/RMXDr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPXnTZbBCXvkSz7ju6WnHSJrko67/77sDE7sbkgVbew=;
 b=q3LWKB5ES2MTjmdixQpOLjG2VsNcRCP2piPDKeA4ffbNH7GHIOtyoaNX6FSOGBvRjRmv65iRgyytxjguWsDCvQy5XHBjqKrq0qjLM8dQHXcb/3jYZkvG/BET7Wom/n+PHRSu4jJCVBu94FE1OwtAG7YwyhNR13Un1l5c/Pxyh9ogH8bDojRIh1n1XSiupGcPZg8EAeC4fieR/2ZFHF19LIlEgpsXZcluSQtvlLNl+VQsG/pyLll0NJFbtrHN6TQDrZ88tUR4A6TrrT/UzSZ10U+kPr43VGEcGvVWFeYOkpv7KIClatfQew6rliFUzlVKaL+kqVOTj5/J64KHI16xRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 13:11:53 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 13:11:53 +0000
Date: Thu, 15 Jan 2026 09:11:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <20260115131151.GA1081267@nvidia.com>
References: <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
 <20260112161010.GC812923@nvidia.com>
 <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
 <aWZfUNXEka3GBf9s@willie-the-truck>
 <20260113161253.GG812923@nvidia.com>
 <aWarF90zBqxD0Gef@Asurada-Nvidia>
 <20260113205112.GJ812923@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113205112.GJ812923@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f761d0-4435-4c00-dd35-08de5437a663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ub1IEbHj5onCc8u7oVqr/kcofMD8wo9ZkFni+u5BprI6l0Aaw8OyFyKWTrW?=
 =?us-ascii?Q?6pt/l86ePpRYGbWWkGlcOSScz6+jJkjHe6R85yPKM+SNN052x95BAUw0DPA6?=
 =?us-ascii?Q?mIM2YZQzwN7eR7kCdyyz9/tTZK5nA3TFCmD6qI1hlxnWyl5aHZ8swn742/q3?=
 =?us-ascii?Q?F3viNJm7BTIEqeZZR+A90xVPvjKsKtUzj9ETZABIVvnBIEL5+nwGtFxxHw4C?=
 =?us-ascii?Q?qqb6R49F+JFS5t5K/alb5/bgcIsVeMTK3Pic1etBlVZ9v5bLSU7+eh1kjkbp?=
 =?us-ascii?Q?rlnOjJms0OJ4tlEUsqA08r4Y1fbBN3wo0NmU8DzHdTd9g7JsyHdtaPJSUbAH?=
 =?us-ascii?Q?s1HDEiikIfSbF4ijsMwZ+NtM4XH9BwJXH5XOL5b737DjwbnnMG9qIJtIaFiM?=
 =?us-ascii?Q?fk20cThtfv4AW8XTQbmMCzyWYR6L14o5580VWT2jpnaBbLuy5c1aB20SAzd5?=
 =?us-ascii?Q?EwVkS5fWQJNjGr6/VMsYtYCVCKHtXfCciujiA5ee2IddSjwSqGE6fgSnGEqZ?=
 =?us-ascii?Q?w9Ptre+mVZovrvxAzZDHel64B1sObjhj3iyoJ15Bipte1bTn+Z5dD8fd4nRJ?=
 =?us-ascii?Q?Ikp+aAxX5/dLCdhIDzCUmLsv07G0mfesN5XDr2+MGNEYGz7hvw88NNpZqixl?=
 =?us-ascii?Q?A5oGSDRnz/0v32eeLGOY6Dqx4yP5l53MbxJnp1bbO2s1fFVZwY598vtVK4BH?=
 =?us-ascii?Q?pjUTxvNuqKkBvC5UJjLPv2/9xuo8CnEZkTNdP0lPmKTdj7TQxRiaTsZE2Tm+?=
 =?us-ascii?Q?ANeUxlFktUrK0AepfBLEM2ROYv8a8EUyIpJc2C/U2bW5xz65c12Xl7wuwgti?=
 =?us-ascii?Q?53ECjFJVZWjtxBCTep9zI8AdHjAnE/p27+n7Trkj7lFBLcYoijnB6kSve836?=
 =?us-ascii?Q?ZnxrKYjEhGq6EoBEDzBNrod0231STZ6C0C/XfNZAE0zBJa5VO7B8c6eRpg/R?=
 =?us-ascii?Q?ATK7lRvsbwZecpjpkJeR8Q2hL/Sl8VLZkfLTKwvzQpX1kufP0smDSIff4aZ+?=
 =?us-ascii?Q?jTcKfKJCgAOLwJ+ZkvUGlJAX4tUuoThSfIRSZM8k6320+ma2HjOYoo7Eo2pU?=
 =?us-ascii?Q?fZGDunc8fiujcuorkoNeo7eHgysiLiTHvEdIKEEUo0Cg12ovJ0dKMPGXFxMt?=
 =?us-ascii?Q?iWEWXuiBcadmUIld29ETiocn1bHqza0F2bH+VPH9xGoApG1sz3gVu2FTC+kP?=
 =?us-ascii?Q?4xF1pev53uvxryW3Wsc2hjAYHVhTdW9dKTV1M/JWzTi5Yn8ortuBxNOLEjzE?=
 =?us-ascii?Q?Obhz8at59W3B6js0FVo89ESOnBHjBg/mMZ9q+jopnSDXcKAn2c1I7WFfXUq6?=
 =?us-ascii?Q?70egbW3cN3XwExXT7xXrbHGnYKjyXmbRF75ThWsowP2OWeLKfoNfRpu6ZaPW?=
 =?us-ascii?Q?kXQvLNM8ttd45XZvFF6oyDflPjGzXpmwHolUGX60YiruBY59e6TN6SMBVeao?=
 =?us-ascii?Q?aF7diliB6D4+Nw4/jHuNJ3luR73H9cIH/pVqxzMevn2l+NJGmrCIekQHqJxY?=
 =?us-ascii?Q?5X9If5/6nTG4j+n0sBpEyEfVjepjpDOlK0rVMZr5jWZcz6nt+goW3dNvIHPz?=
 =?us-ascii?Q?glvll1RS7X47chtzPR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpQ/J0KH5dpdTKu4xn8/yRjULfxi4bRpOvhHoLXRacsyV4zpws4pB5h7YgQ5?=
 =?us-ascii?Q?YbVBynByLhIZsjvP6GB/4Ei34g7GC44ryE2jF9G4X6Sc4cl7Sb37EeQlalwD?=
 =?us-ascii?Q?5G8wBMwutUtr6V0O1CANuVTrn775iasLgzbCScGwAlYi57aoHlIj1hj51iw2?=
 =?us-ascii?Q?vf0Q7tt0Fk9UtCrKsHuOcWliQjJTihSAMniH3I/sAEY3ZlYIB3B8t1jwcMWO?=
 =?us-ascii?Q?8BPcodM++g1a1GHZeiLHnF/YertSNzaWDd8Z1NpGm5DczwAuw1XdQfRGJPXD?=
 =?us-ascii?Q?bjq5NxIyK8AEsEaZawduPrJu4u7ZNjk5OWH9AgweogUEyOr0iwdV8F0TcQ9k?=
 =?us-ascii?Q?PATAVcQZVgciHXygZ/DG9kxhgGPCBe4xoHT4BKcvh9DyoSYDZNaS2IyyrTh5?=
 =?us-ascii?Q?NQPlUy3CFJSixhfGhRuTQjnrOP1uKVM7v/sRRpVFzGI5zqKnQoFwU6djdYB9?=
 =?us-ascii?Q?bzd7iIvb1lpfB8t6XmNAsYZKbXOUhi/yqBDcWBH2n/PDrczL6C6Dax8dmm8M?=
 =?us-ascii?Q?bmAceeF+b+9XMgyAZkOyd5EtBrYXcuGNPgEDwpkWtxchSMgamfqY06xi2BeX?=
 =?us-ascii?Q?MgSImSmSyc2URwyMyZMugONOt6zGArK06X7IapNm/WpVYGxdVJzWuCW1GVnV?=
 =?us-ascii?Q?75Biaw81QmMk/ckY7w4ocr+gH30YsEPtgRSd7ANLGmsAYuAJ6x/HTb5x5KIH?=
 =?us-ascii?Q?LTIJTkOChSp8edsTr1nEsjFW4ZNNLCMn/1/dh89ipZex+fudCOQtDf8qm9wV?=
 =?us-ascii?Q?aVuqA5DB5/wAjty95OpPGDgBCtToz50qRlWHXBEqvLneU4sAMFKewsArR9vJ?=
 =?us-ascii?Q?2wyQg7E4n82DoGjMcapfJ+P8A/KRklVyb1XO0ttcqLBqzg+nhTUMbJFid2ZT?=
 =?us-ascii?Q?MSegoCeSdJhC5sOQI1/bHr01rm1WqF/ud8RW8tRIdk12aCv9T7TLdNla/qqd?=
 =?us-ascii?Q?C0hwCctLVnLJxNjTUVDjB8BHEq3XqE4bPKpzXV9QzCqp0t32R6KWCF0M0I/a?=
 =?us-ascii?Q?GCcydCNgY58quY6QK07H8FmsKf+D59mA0+f7d34JlzMhPd0fEVef8mUh6fMb?=
 =?us-ascii?Q?Zaq2pnrCmBvqZEJag7YqgBmQuKJTNR0tqKNkFnhk7qu+mfG16HYO+ZEqWsql?=
 =?us-ascii?Q?SFsJrL68ODin7M4KHVrKQj4kR+FiI2pEY2od0yBkJ6JeDpjFFO+fgs+qeazr?=
 =?us-ascii?Q?oThA427RhVWTYSgKucQ+TQ7TymhPxCmPh5VXopdtVFM8fucLIDSf0IUYWfxl?=
 =?us-ascii?Q?vfVAQiBrn6TQXDQDvwIoMCV0OrAuKvZlEEiBV6fAnwRO+MPXw3oejL50B/T4?=
 =?us-ascii?Q?UKeRJoPsSaJl5IwZVhfkJ0UywrXQAQ1HjD/FnPWSkSF9McFMxviyiqaYbdZc?=
 =?us-ascii?Q?pzKXzbKxoeG2ESpIFGNQGJxmWJ7PmZ2g1lz2NpUQFQfFzuyIzGylF8ZJ+2f/?=
 =?us-ascii?Q?XXJpgYaCw0k32O/FXzFzX8i0qgHCu+6j5/8oj/y1z7EFkUnIFmFI81pLaKDv?=
 =?us-ascii?Q?LO+gbG2Sm8i8/ekblqOF6z6msJ5v93+XTmmLIIkqHrkPL5VSpZmxKXLUqdiI?=
 =?us-ascii?Q?PLrHUYDQ1t82nBpOmNWhZPcy32+IG5OgIUP1sWkPiuV/Q8i/IORiliZT+7R7?=
 =?us-ascii?Q?DxS3Vn0emvdNKryWf57X0i60AZEJG5WavR+SrLcnqq5LdsJm5HHETouHPfan?=
 =?us-ascii?Q?NEUHLW5cVBfUnv+VHp4ZDqjSYQMNJ3RMxG98QS9NLooaHffpi2vk6dpLhhqs?=
 =?us-ascii?Q?TDtE68eDPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f761d0-4435-4c00-dd35-08de5437a663
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:11:52.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2KSZXGjhdLpiatrtLw0pTxt47vBWOu6V7RmKFLHOewa++PtJT84NGGF4nrFG+J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

On Tue, Jan 13, 2026 at 04:51:12PM -0400, Jason Gunthorpe wrote:
> > -       safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> > +       if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> > +               safe_bits[1] |= cpu_to_le64(
> > +                       FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS));
> > --------------------------------------------------------------------------
> > 
> > @will, does this look good to you? I can send a v7 with this.
> 
> That is an easy way to address Will's observation, makes sense to me.

Ah, but it looks like it can generate an errant view of a EATS that is
neither old or new. Ie value 3, reserved.

I think you should just check if old or new has EATS bit 1 set:

if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)) &&
    !((cur[1] | target[1]) & cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS, 2))))

Which the current driver never does..

Jason
