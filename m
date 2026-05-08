Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A94140E5F
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243757; cv=fail; b=bYscqH70ImemagMEUXx7CVQkn8A5QGszJ3Gj/Wttn5+YEJkmjjqId4ibi/hNvauakvyxFX+fN/rmRyf2gQoiGNrc/z1l9a/YJ5Z/SRyHwzuHjuxqhM25AeewpBMhxI7VfSO0ARMFDVz14htQPlnn6b69qHK5td2rQDC8vx5Z9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243757; c=relaxed/simple;
	bh=51W9SH6RimP/uhf5umdsPzcpQMH3V4QhrcY9YGGnr3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JDAl1CjFX0MkHM7+WeYKn5TMCkgyl/a1hIEdr+Lwb+fzVNHMeAYM2pClQqvrZfYkv2rQwj13xIyTaOT2oPXCQzVPsLCwzbmn47kqJ/k4UUqmLcXsZejiepmJ4z2Zx4bbp5LFHCzjdKTF2NtCU8ENPRYv1VbgwEcqa8DqrY9ty2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDJV9McR; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDJV9McR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI0Trk2t/3EgfZB/+TZLnNEGwix46U4fL7NExdr8fT6j8FHk0YrUsscm7iCuttUOEQP8INW7bUvE7yw30Cy2j/7vsD7sMF4SFFK1pNW7A+zeQbgqF9cfrd+3w9u4lZaDyAK0bacfyajhvQZWj/oHjHZQMXnFd8vi9EM6M42RWzSdp2PMsGEH/c3D5qa3YpGTRayH1bPalDd6CJfAJ7rKuSYuNhbC031YO1sLLXV6nWNZ2n90idLvDB8D/FwpgcmoMKfWQLMLANZIVhRxSjps782FVWkuDtW5mnXaZ5rrPdgpz5KuCfQnIwno88jocXD5fVd+hSznulqI92mXEjT0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr914e8M5frO41Ll8HgmM3TR9EyIF1fwKLF1sY71UWM=;
 b=Rseh/6n3k94+KKuuTFyq4U1tPZDuBgf1e7EpWACAfZabzkmNI54hdxCqfoeMrojp3PtmNSUIkZd+pPjLwys+oBXn8Uv2LoRpb/BEyiCPSGl2gtDHfV2qEimZ8IP6Yubz/YKRI87mWW+pNxYi9+1YBkjhTVhI2VAVeIYvzG8Rja5PK0LrgUQPQCuKnIFj6haE+bTWW/snVxY2mZUmY1QMTiszBYF5xY6cqIf2WvpXT9QXj0x3wt3Q+vFxhP1EMN+NwMZ+Lea3ZHlW/2/ZH2XxuRcDrtFevK6aI2rLwiKlvLO4v5ddhdXvegletfIxcM6zDhVTMjkqkHc3D+NzxZKHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr914e8M5frO41Ll8HgmM3TR9EyIF1fwKLF1sY71UWM=;
 b=tDJV9McRUwbaEssJnmyUijx195Ika8p45ZLI2yZSrNyJNU3Lsha93KIWrz1H4dNrI0onRlmMiNJGzFKOicFf65o5jCmbx/WiXfzWww4jiQiaeTaXxbmlyM286dJ8Fah7qgFVGpFEdxBNu9cVBrMk1+iiMr+aCIvPvOFeaDGtujg8o1+ZTRX65NQoXpYKINlo+aIygv+qpKmsmE8b+3JwC+7HDdb/wtPoTuqRCOTYMrkZSHBc0iVp4EwqZvZXOffGl1IxEHdqzj857ikB/vNZXe0AQlNQ+1uwoU94z1sS8iXvWt53pFV1ioXrNiF6f4g+Je3eW0r+tdlQ6Ms8V0JUag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 12:35:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 12:35:51 +0000
Date: Fri, 8 May 2026 09:35:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <20260508123550.GB9254@nvidia.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0SdkjQOZxnnaQb@google.com>
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e80086-396a-4738-1ca0-08deacfe56f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JG4c2tMzURrnl6+rM2haWg1BpM7tgSh/4Zu6euaRDIoM5HFlPwUIBnYS0gzcQfA1r9JjUT7g7RTu/KRx9TBbKsOwJW9/avAIkD0ZjbYN2ujo/F/oNxXG3a/y4KVrMwxsLToBoAybOtDyyB2oVR4mlZ3YwqN2ythKcZR11C+DKEZrcURO2rlLM2dZvQLhD4YEwxu+dxK5SVrB09FdFEb3tNtuPB4rBU2LPZ8Mw2KHV92sAhmlYjtAWDwwRGSZI50HO1FpWS8WQ05UhspLLlbM4b54UC9dNvMe/20p80BVBrkdmNMJdRcv6JTQ/oBvZ9x2ydIi96hdOCVVQsC2MHpq24qjvzt9EqDqoeDrS7dVHP+YSQOaMUrCtzoLvY8lBa4wHOrzcvXJfraN/B67x3O42+/onT6DEOBNmZ5gudJv3iQrIr5cUm4AvkcX0dkwBXDjoEjK/nQbm966B4BW9ZAApsHkg6fW3+QGaZFxMQq5wv+LKgAPr7hEjbzRfimuLjbLwfORcrYHFhdrWcXNO5AriycD8sGve4fPhXrf3qjAuXzsanadQTirl57+cJ/oe3NKXRq5rx5C5MFQhDdLGLePUJBAZkGTWqiTeu2v0Uk8Vm9b8uUbiVC95RyOkKXp8k/Bxzkf3PC5njjtWeNV4OHYeeIbnOOazsZVnb93XEBuILOA0lR3d9VB+5fPqIbJA06a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Eshh0fDezhBEAOufiqQzLU8yJ1969EeNtD7OYQ1pn+4asPRfL9xn+TFpIvL?=
 =?us-ascii?Q?tajnWUe0VSlJVBZDXpLaQbB5eyncd9AaYEKxQMPfMBdxRvFYpTxsVRTZkiep?=
 =?us-ascii?Q?udD3nUC/L/GdNihsXeLmeEaeAqRUSumuu4JAPLdrfJQjCoF6cfBzBQ7VMH9/?=
 =?us-ascii?Q?jTKLCqqKf89XdCqAleTmCrwG+NvFfiiLNnaCXFvTZQsxOE2b+X4QW7fgOud8?=
 =?us-ascii?Q?MMwHHtiKDIwZ8VmYEYND0dNTi6kbFb6y+hSm1xOyWR8qIfAG5xWqqHgV9k1Z?=
 =?us-ascii?Q?VHAXNlf8ByBApyBjy5KQjvFHdAVyFPAifq36dpwV0KfhkYYU1LGPcUkhNM9I?=
 =?us-ascii?Q?UklJb/ymrahNYSs6MeL9r07lq5GJEHhdwehmE0Pfy725JvlqelhK8JYtHnuo?=
 =?us-ascii?Q?otYVx9otn2OVW/aME1MSt+3d0P+1a+qluxaXaSlK4daVbBmfpq5wAbqGYRdf?=
 =?us-ascii?Q?yERu6RXoFtfol3SCRRLLqJTtn9eUoSF7I5V+VI6tiJ9jziEb3IGD1iFIS1bj?=
 =?us-ascii?Q?7TsR/BgMXC+1Bk9yM7qkBudGYCVyv19z/wyrS3i9Bb+SFAfDYi03J0eZz9Pz?=
 =?us-ascii?Q?R9Pw+HURBHr956yym5eb3JBxmlJ5CEy9BFoXFSlTMkYfC/Ig28m30k1RgSCM?=
 =?us-ascii?Q?rbydx5FpxIMiqVarUZSQ4F1O0A/SZQOCeeQxbesPSS2Nf0hfIXlm2Z95P/LI?=
 =?us-ascii?Q?JVivBvEN44RL8RLjxWj/3051LV0VbQ5zZudeQWj8wAk44g+i9azHa8hD5q/3?=
 =?us-ascii?Q?0+9V85DIu8PELIg7d7mtn6cfb+N4+Antshn1QRoXC3TAfm9ynlMeGFLbaYAB?=
 =?us-ascii?Q?N6lA7teLJY7TVjFdokfMM1V5XTMK2rc1iD4+mVp489i3SCdkB1k3W6OXpAN/?=
 =?us-ascii?Q?Z/YwIplr9c96FKbhiaLqCTC4ZEcAmT+vNpPWUuvdjGZu/uVo3Gxq3hCz4xCu?=
 =?us-ascii?Q?wbGwWfQWBoqtUndIRpNERnlBFz9DwRg5RNRgZWqMiPRQJPz+/dTsfGyL4HYF?=
 =?us-ascii?Q?ljdlk/aCh0RBjCtkUGrdx1cGYxgL97ikOYT0vo1hm+LW0NmHIv62AYr+a/Hh?=
 =?us-ascii?Q?MhmgUu/1jwzEXfZcCHMSJ78lOrVxlpQsU8+EjS8kmeMo5jUyszDLlYCjQhM7?=
 =?us-ascii?Q?o8BC3cqF3ouMuNmOuYg6oyLlRu9QFgng5lrdPbecgHX/LJmVI93TysfamhIF?=
 =?us-ascii?Q?4UFS2vMUJnk/Hm7c4bpbjsPx3gBfRXKQT+v/3DdiTBaOJVM+eSrUslpFAqE4?=
 =?us-ascii?Q?yb8a7O3BjP3dWgxq9yDcEHG4NhN4rzY0BWVzXM0g7zwpof9xZQR8gGShWpYT?=
 =?us-ascii?Q?pGDUBUmwE7GdqlH3o99YMZGZOHeBHufym2lNaC+llwKJWL0cCZP7ALLCL+H0?=
 =?us-ascii?Q?TOjgJt04uL1PjMSNfZtU3DGGyB5lKm+P8oa5Ot5srGw1NOKUd6dhnfd4dwpB?=
 =?us-ascii?Q?FdC2uETDWoOGv81kpSdUPb9aR26FHBv4W9ZleAJJTAsmuiiHRGqQH2wQ/7Eu?=
 =?us-ascii?Q?t91EjWpZe4fLX/1oWssybNWhwmQcSKjOqr8gZLvxgR89QrkFqSG3gDbLHQVi?=
 =?us-ascii?Q?fptasAdcS54zHH1B7LyJt8Swh/69hBZMnyJFvTIruKdZx6Tsk2CRa1GwOimw?=
 =?us-ascii?Q?a+DZZ0iJRvLE1HEsd6CMktRUbfT66/VL3xEgTIPts2sazDqA85CEr/lRnb9Y?=
 =?us-ascii?Q?pOuvfib1ersxemFqLI9REgIcDXMqj3VZvIl/AgUwwNBgCbB/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e80086-396a-4738-1ca0-08deacfe56f3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:35:51.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2nr9WZ0ih4OVBJeqjVMQthOecmBujbgOriA/pTZENbH3rzu9rkpolh+epxjhAZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

On Thu, May 07, 2026 at 10:30:14PM +0000, Pranjal Shrivastava wrote:
> > @@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> >  
> >  		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
> >  					      CTXDESC_CD_1_TTB0_MASK);
> > +
> > +		/*
> > +		 * Enable Hardware Access and Dirty updates (DBM) if supported.
> > +		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
> > +		 * share the same bit.
> > +		 */
> > +		if (master->smmu->features & ARM_SMMU_FEAT_HA)
> > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> > +		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> 
> IIUC, we should be setting these if IO_PGTABLE_QUIRK_ARM_HD is present?

SVA does not use IO_PGTABLE at all, and it directly constructs its own
CD.

No relation between those two flows.

Jason
