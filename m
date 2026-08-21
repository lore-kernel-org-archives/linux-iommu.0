Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15377357CF3
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332826; cv=fail; b=lwIa6/3s4ce2SjFGY/Pbbqs2l4BzdwkC4Ba7b4LSK8qvniYU0rOW69T3bwnTabytyS0DWDyFZItL/SL1n1ivjvlY37xeiRgi77+zCRyEZpRr4zGJBqSDXFcOHxDzyYEYbP3rQzR1bnzQKEJFif9gerflnwe4kzISvFaAivTaDEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332826; c=relaxed/simple;
	bh=8QnWmx+6LmbQL8/1RbGSbDqOlv35XMhjij1R2FmpHmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FlkiOohaqPfEe0zaqLKXwtQ0nqDo/cfQg9xMJ30l23B6D8h03srICJo7YcVX5SitmcJDWRkEJygxrYPIZ1DOApCxAI2KnwfBvheZSI8XbJkRyM46x/MozgPeQIbwpLm/shkiP+DYubkFHYkTqh49Yj4B8Tx8SFLpU710U7aTF1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVSS/ASI; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVSS/ASI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPFjSwn7yjfCc5v4RmLJcLl+FC7BC60+Qggvh+67ZuZv22AK50kF+EapiZYcfcfzyzJ7vNGwNJYi4rO+YH7EKSt8a1Pka5XfuAr9hgdZcpyAQsprPMVcJXwfWlfoIoKzLBiBQjPbseTEHiBo72oN8DqSlfwlisY6r90VbzfXww17r+gR3HnqeCjMwJ9KLGCv5B4Zj/3mroCAiVfre+ZI5wktjY2Xm1dtDtt4YN6bWShLQY+EKZfQH+PKz4E4qhPzjLHcMauyjzs8H1PwlQAh7smx0867XWOvPSlxvrefmMDyF2bUd93mydckKpZFpWpLJPe11oMoTEPbmEayXWz/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njwh7iTW3lY2QjWOmD20TIMtwcCZjkXV9ZkpsS5pnzM=;
 b=Sagyg0GLWE6HZNWRNkkLoaamoBjdEf4KVxG9dek+4bLOPw3rNOcItVwULm61m5yRf9YO973GdmLqVRfwqzo4b7cXTwquuhQSl3HJ7DcyDHgDt2x+uNk4Ye055AhLBN9S9bRpmEfndwj3rVRtv1NJg4Sd9gAkEtCQabQpnMgoeMa6rGkgyqUrVI0MSFQBFXwZyxWp3dJWiA+o0vDIUFNN82g9nA/1jiB0fuZ6C+IbVXtIyObJnk4PWzO/blK4JhSBQqt+VdObiGDiqcTP81UTPry2doTsWgE3/BwhTTy4vcBUsFMYhh5wVPM7WmFbJH22uuggknGjclOmXPO3PpcQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njwh7iTW3lY2QjWOmD20TIMtwcCZjkXV9ZkpsS5pnzM=;
 b=pVSS/ASIwK8HudxpqrtxcVjPUzAlqvvKaNyto/RuEi0nmRBTvsSbSk0HSUWJbsYuI91a1PNLMx1uFVRq/wWAcJYMOGzwltyEb2RqwAZakeS5pEgCUfGKetjRjRDWitL7/i9BrrAQjvx81Esc0ZKDFy73X7N21iITlysjMYr44V9ldyDIFTyK10ISQ0A6z5FLPhIYUVjFjXhmFV1//p5pWI4N+NBkIvI76GWWtLnNAJOJgAjJSUcNLfUFYio5GMRQ62NDcq5kgkZOaGp4T3u+ZFa+pqHL4JyunLulCYcCVkzbcxxllrDMLOlaFuAQ9XAIiAjGB2vF9vitXSbDQSVdWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9584.namprd12.prod.outlook.com (2603:10b6:930:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 17:20:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 17:20:16 +0000
Date: Fri, 21 Aug 2026 14:20:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260821172015.GL244917@nvidia.com>
References: <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
X-ClientProxiedBy: YT4PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a2bf92-790a-4097-e4ce-08deffa877c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oxi0Igt1eFDa5wEOgeeESqIwVvZQ7v5o2y+WIwXDOycnWw5Y4r8u4uXnp7iQ962EQ14hskO0JdQSJXLKmIvY0cn4LBBjCb80kZJovWxWEAscFhjV17gZa6ESXpWa0RK7CcG3Z5Gfu5EUtleg1WlaTUnPQj9Zg+q/TjfeXFcuJANLGzFXuXoDeSlR8482Zr3ELTNdTiXcZO8bPGapJef6EiXbxsWliFJmDE265DK3OmLaq+/+WcoYUa9f4jMQjgnFpctFEufTqdM5s0G+dvsX3mwauLAwhEiMdK4FBTs7AWYROJ8TLU6kfqg3VpApQoq1l2DGjhGMWrOiumpDl0koglKFoLPjVdsdjyrGQ8WD/5rHldjVwGptIyYcWEpTRwhv/G8UhVClob2PBJJKydsbTlx0CKVB2TAWQdBHY/a/MseIOhKZPFGPwaZtC9OC1KzA7N2r8yxM8OZ6mnzU9tZ1vUJSjXCBDW5MR1V+rjPEKK2pLXzWmWkJBDQXPqY1va7mXt/Lz78iZed3ajoZot1GmI2Vz0skETY69aAznUTiK/jMh4dt2C8gBrcxFwYfcdx4yhQAwxNTceE4jAbPNvZzQXadQiqnNVEqYZR4dvVbuDjyN4jqroFKNBaV7c5/Tgvz9FQHSyhijTX1T4C0KqyqNW+ZaTRHqZlAznPPk886jhU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0Zx45/vYjmbdOuatben6T0Nhb7wF5H47GdB5EZEcKYkfSG+g+HL8b3a5uwg?=
 =?us-ascii?Q?WbrKhwpLSW6W5XsqMJ/npW7rkXtSJ6jDuyQE2Dg40KZWQ2CnQEsVpllNbATt?=
 =?us-ascii?Q?fIqFoRCA5hvrco+CjH/TjXU4BZSuDY/ONOZrY5EwvVUOFo2tAq2iEb991Uif?=
 =?us-ascii?Q?gxOiOoAtMbJPG7mw4zEFMcR1iE/ayVgujmOTyhobSPioCUysTBGqjE9YYgwr?=
 =?us-ascii?Q?BxIsv53c6WGjohL4PJBc6C7KqAEtSqqg4KR9jIC7Di92pxjMGwAmm3mRHeGc?=
 =?us-ascii?Q?mCxjl45BjdoxXo0zkHwN8+DNUbwToR76IgVkZUanXVHPS6n6MAU2t5tJJUVQ?=
 =?us-ascii?Q?D+bRtXBDpBVQebx0KXaYIHvbYpl/wLiG2Ch6crLB1kcPiPOnUjCsLPFvb23e?=
 =?us-ascii?Q?AhSFVWOEWJmvtmRUleQMXWOypg0NuyqXDbEGzFqd9eDkomsa9kW9Ic6J2iyl?=
 =?us-ascii?Q?hMvZFKmuQFSxEg/UivwytTQzC7+OItmV0sxZuHdtD3F2EuB/alcyNOuNYkfJ?=
 =?us-ascii?Q?x/HDfeyd9xX8/JdY4jwhazx1gkaaUpItsB0ZiF6EU90aCDCS0WgaTX/yUG3Y?=
 =?us-ascii?Q?9QR11x6gyKTaB7DpI6kK49B8DTZOVmLmEV5poMDjTYWU+MEKL2vslL3glZva?=
 =?us-ascii?Q?CO+YDKyxkpFO9iRrj0H6Y0fXsnp+Vmq6luFURctpOA21xpnkG/twfWdpMOMX?=
 =?us-ascii?Q?ujyQ1PAsH4gHp10zSvynF84sF/L6i+QtSLTkSoiY9VUtB/grbrep993e3wwE?=
 =?us-ascii?Q?40v38kP97/GISH+aULtRKhbbGFUouCUmQoCAec75u0nCwZfsvsVX4wZRNL3O?=
 =?us-ascii?Q?uV2qIwO0BCMQrlRZVjR2JCw+YA63kuMXaF6hEPBYdz3SQJm7GEg4iRJUfutR?=
 =?us-ascii?Q?+ieA6TzSFf7vM62XPqrAhRRIjUTKIj+zDgaecKVvraNOQslSZ6uv6j1Pm7Sf?=
 =?us-ascii?Q?ioz0onogaYasAANXodD1JbvK1K8W+UTE0JOLlzsa84BA7cwkIeo7RV/bjHMb?=
 =?us-ascii?Q?e0H+8zL3Q99FiUuCXh7sxHFWKIPh9pSInQzj+i/emkG6Na09g5CYyPm1BYYo?=
 =?us-ascii?Q?YYYNkzlPnaVDbIdNLe4iWIVVVozydF5BmQmaiJ9AMpjO8f7kq9irnk/Enrxi?=
 =?us-ascii?Q?urJGo/3X/lGh4odHSKVX1SympjdDP9pOFJeM3h80N/xFqQHd4ZV1RgRG9//W?=
 =?us-ascii?Q?s0k/iI+8ax6hVpcbS53RHfTVI/C4yk7yCEKkHaC1+mLcdlVPguSMtihm4T42?=
 =?us-ascii?Q?YhkDphvH4kVbIVFxkJHePv0X6ZyVkwjMvKr2810hWqdW5hkqMTtgEw8hdhAA?=
 =?us-ascii?Q?+IDdGctGrPbU1J+hotHULcFo9ug67gDnTyPAtgpx6OqXs8369FV829NvuhxJ?=
 =?us-ascii?Q?F9wo3Zqb5oImR5C08Lh4piBugFzHOW6WQeNYuYxQtfDtDmJD2f23fLVFj0y5?=
 =?us-ascii?Q?wz6pm+OOOzaGjl0N5HxynmW1bBH5ROUxjqho6pQE2u489f6OuW767z/oNiDv?=
 =?us-ascii?Q?RaJIihfEMA6AJZ/DW3cdgnk2PMIB5lQwjUPf/6Yo94XRgYVPdJJGvYJQgrmS?=
 =?us-ascii?Q?EfpO/xXcfWaxyxiLWqAda2DL6Nam+uDpMTWaDEVB7hNuUkWrEtdAao9bbQWJ?=
 =?us-ascii?Q?a1HEwBpMQL+oqNtdKJr3vimnJdvdxuwRjvpOF20T3nBJnVpwDAFYBNcbArUJ?=
 =?us-ascii?Q?ISxTIP0h1KaqwL9oSlgLx+EH/3TyqXAT9bMS3Xy1TIXAW8LO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a2bf92-790a-4097-e4ce-08deffa877c9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:20:16.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHy2b/7wQdAZYAM1M9tKyKUDgqljXfSGOQjMRIlMBEodkeMYO6YjvjnT8HcfSImQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9584

On Fri, Aug 21, 2026 at 07:12:15PM +0200, Andrew Jones wrote:
> > Does riscv absolutely require this? I suppose you have a new problem
> > where you don't know what affinity the guest is selecting when it
> > provides a MSI-X addr as you don't know what physical IMSIC page is
> > under its S1 IOVA?
> 
> The IOMMU MSI table operates after S1, so it matches the resulting IMSIC
> GPA. With a vIOMMU, the guest may use any MSI IOVA that its S1 maps to
> that GPA. With S1 Bare, the device uses the GPA directly. In either case
> the hypervisor provides the guest IMSIC topology and the guest interrupt
> file or MRIF target needed to program the MSI table (through the IRQ
> domain).

I suspect you should have an IRQ domain for the msiptp functionality,
but IDK what it should do... Is this basically to remap vCPUs to
pCPUs?

The viommu can set the msi_addr_pattern

The existing msi stuff can place the physical ICMC at the right spot
in the S1 to give to the viommu (Nicolin's series may be needed for
this too, I forget)

Not sure how you provide the guest MSI descriptor and have the irq
layer program it directly..

It is unfortunate you can't learn the vCPU the MSI is targetting from
the MSI descriptor, in terms of linux that's a pretty difficult choice
to implement.

Jason
