Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9A387590
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407366; cv=fail; b=EAXGtWehNzsDs49kt0rMfWBYvr7vlKo83y0HF9mwfCqC9SEAgwoPYTz7IAFtmzXKzygoX6nCUY1fnCP0dc1MfAqSH8oc1bllw4Lcj/a1ATeY1WrMsImXYXhLTjbYOKqPEd3fUN1uca+ZufMOOvtCMzdl6WII7G9unyoeJBcNQ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407366; c=relaxed/simple;
	bh=7sY8ES/B22Ri8jr/FFGJqBgIa1qHrdyq8QFW8p/FNZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rynijPfNUgwNcFo7+PY594SVHis0XWrdp1ccKQJCOWstJpAMH+Gw2jCxVvMvn67NiWPH0SgHUFKk7dTJd/L/hhWtggVKPnsKsUM5dq+iCWffA9u8tD0oXqIyscmCh+OxG8EPHi2EXC04xOJv5b/TavvSiegHCm6c5mTMQHnz7iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bZEloC/0; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZEloC/0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAZiwfvBdOygCp+U7EEwNOrwdlljMr4zReF0kY6eCrWn9CWkdNiiJdyr4JNiJDnjddC74PJgTU4F30pcpnrrRqFsyH24wk0PVbieazd/USzpMfhbrYOhWUQ8DRq1dEETDQOqfL0QxLtmKaZHHC0fF+ZbFaX9+jzGV/2ZXGa9MEfVSuoRB+x7Hx/g4ltgdpICoKvDgW7VY65pqoUfLUFOZ8opyF9Iu6GDz0RRCCxtSLR7lmatocM2Uc8WSInAUhgbgs5j/BY2rdXfPrXxsV/ckjJkEcLNq4HTr6f86zbH/AqpqtUErPj3e4IAW05df5hxS/AUTPyAjJmu1m9XsbrpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9W8Yk20egcocmnGj4pP/yWQj+CbskKr4n1++gyA+78=;
 b=u8MQkRn46VezHvawR/TBCtDaqXHNflkAv/0oKbJH2PhoHPaHLF2VWVpSFQ1tOTK5uQlKOjA6y3tBjBUWJhZ9ajSC1/o2l5Rb+1mlqEACRliLiG1YBDq/0Igq6m14NEtHXyk7H9RFRdJHseazCkuxJ8ntn9GfS1zaWI9QCVqo6ItBFZjNYF4fRZpcaGzFD1gfvop/BPVyUwdy73j0Bu/XY8Nt3qf4ToodCyRX4EdklyLgGcL+/HWiaecElcKhugu/TnSB1jxlhoaWBBx9zTdZ9UXrs1Y/Btdu/vwHxIaIqJPAZ4x7Uy2EV9A0+1wnuDSGtA929nEOfZFGolH7aV6DiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9W8Yk20egcocmnGj4pP/yWQj+CbskKr4n1++gyA+78=;
 b=bZEloC/0wN5rUOD+LK7DtqN76bxsHOCvlTwXstAnR3hRPxWFHXgYRHmFhFU1q2YoQdLoC70J2i5IikQTsX829pzGThRnFjSBOi5YLtyr1MyfVLwAixtnzarMKRDZyc5P76yUJ8QVrBeWVO51rvxPeAhJj/ua07dmoeJPsYvMlmWbxNDULPPpIIH2ITjVxCnaGkBe5hBskb8pf0A2C53zWvAzwQPqClIKg2DILw7fkaXXx3Hcp4ImDH9a1+E3uslBR75TAQuW16XjBwnHHxtK5T20HDIJgVBPv9qDtWE5K302pLJi6sTSRlEp5U3Kbes3G0RQPnWdrIybEAIrIOyueg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:16:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 16:15:58 +0000
Date: Wed, 14 Jan 2026 12:15:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v6 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <20260114161557.GB961588@nvidia.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
 <b8055e0f0f1b4473db2583586350b4f7aa8f3b4c.1768248467.git.nicolinc@nvidia.com>
 <aWe9C8wwfszvqxR6@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWe9C8wwfszvqxR6@google.com>
X-ClientProxiedBy: IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b16f167-73ff-459b-31a1-08de538833ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3ogux47uwx7x25yygKZ1mfCEWjyxuThGcmjPb5LiC19C9TbNvePvc7viKSW?=
 =?us-ascii?Q?K7lZ30jhd6I8aScIJQrOfPr+zb+FrCHDhR7gTyyg6T4LCUksACtZTBzCz2CP?=
 =?us-ascii?Q?j2Fd2KbTcW7VQJBA/ojl6511ir7rYtHMd0AtkO/ZINQzTUp36zS4ZFcWhFkV?=
 =?us-ascii?Q?pWaQf0Y3D8FYQ6RR8Aivgd3YUyMRNDCl1kt8dz3lAgn6BrMHfLPO6DQybI7h?=
 =?us-ascii?Q?1hBfGgsNx2c4d7+GPI+2dArIPl+QikuCaLfY03joeHZrEQiFO6Wkk0OW7V2m?=
 =?us-ascii?Q?i5/EXn/NjMXIEshgd2E4xbDsqq+Warl4330eMMTjgIlqq6iizRk+jjXntJ32?=
 =?us-ascii?Q?gqx8qfFT96rLmYOtyv6Vgmtpv5asW4IuaXZPZkSS/SVXfdkF8kP61sOSgAfc?=
 =?us-ascii?Q?XQcrGwruHC22NIRCPZ+viDY55cgtTL1A44nAoUPbWQXm7Ty/0PMBiZGqPDIw?=
 =?us-ascii?Q?ux8Ho2rm2XaImdahvzZ52lmFgQQVs6mECopay8bJGJf7FpY+M6352C0y63DS?=
 =?us-ascii?Q?9YTZlZ3nSW3sFQoFfHqiqgNI96aacP77k06n77XpNa0ga1QGbjNPZdCZcFLZ?=
 =?us-ascii?Q?pqoVcwWlRljT9jfwgAIqbTn15r2JNQqdhoVaZzRdD8SP7+qKF+EWWPj3yZ/T?=
 =?us-ascii?Q?0s1VH5R9fvTIR/r/SvtqKNZkB7ypixH4gSiPYj2qOEcHH76kDmyXIVrBiFBE?=
 =?us-ascii?Q?qKZ0Yzl03bD6pUujtC87L7TkQK3o8Rtgv5403pqvFgduCwKLLWZa7bshizmz?=
 =?us-ascii?Q?b06tY6EVlxW6LWY39BE1LLRe3abyksSlu1zFC1zzylJe5VrfEb3PfVxOkniX?=
 =?us-ascii?Q?gb6VSpgw34ky95tdi5vIUwBhJ6XhCLGCzzJQbE0FuBUb7XR+oqAbgUukMoCn?=
 =?us-ascii?Q?jIibPKqX3eHBljjSRqCcLxTvPTHXFS4mMBYmM4VzYgX2DaO9QHjCE4XdGef9?=
 =?us-ascii?Q?c70hCDidd9Rs3l0+iwVWIHRFlzr03rQbG+/lvw/TQVvcJru8/rquD93AOny5?=
 =?us-ascii?Q?5IhoritypYDHOFVTh7jARBud23Q6Q+jEUqWh+61o25+woELoklI8EKjUlQ3D?=
 =?us-ascii?Q?QnZNbmrDUaorXREnsjoCyCtlDTVDKi30JbyO398OipXbC3BQxA7v/p/HRiSU?=
 =?us-ascii?Q?q4Mv+TqQ1i1kN2G3dwy9Ov/l5Wt3FMzkRY6sgadsQnzLCV1I2Dx9j8VrjD33?=
 =?us-ascii?Q?6+2PFKKGXV1kWWxkRPp7nlp5WWzeVv0ZB2C2H2eEss9xqpNrxTweqEvYq1gu?=
 =?us-ascii?Q?9KASeYbiomWqExzDKDKy4gWZL/HQw+Eu/LLz6mPz3EoiCtReBGfSypOHZ5XH?=
 =?us-ascii?Q?25KDjFU2CCijOghrE1iC6CMhvRnuBy6TnYd8rmp26OHCQc5bywoIU3geB5IU?=
 =?us-ascii?Q?ilUm2O8hcnsyzAm5vQGe+/JWM/81aNnK1ld9UCIrmUuAv6O7p5WAKMneBMKG?=
 =?us-ascii?Q?1bud1Jd4M7MD9aGN9tOUWddgda2ad1irqe0z94QHnVqiOiPtPNSDgV+i3RrI?=
 =?us-ascii?Q?ab8/aH2CbanUpPKebHNFkGE/KiUXIgR994FVghv4k6c3q1cGiHOStng2tCH2?=
 =?us-ascii?Q?3bfcfcK377V+9JVlXgs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQ6RsFDbTB+XNlf4t5A5YLiVwqPjvkus/aG1TsDkuanGeSfNQcJIIHFzM0YO?=
 =?us-ascii?Q?L5tEyaD301nb6lbHsPG1LB5ILFDXSSAqjtsfhhtaQFPmlcUJ8KfHzWmTXZcV?=
 =?us-ascii?Q?DQ/Acj2hg7eFeDcCQ/P9SBSLhRPesPulL2h1bx3x5ThH62hyU5MYyS57R6Cv?=
 =?us-ascii?Q?xmKNDvYkOR0JLyNHyQGJ/DiczJ0SurWvHQq7q5xtep92XMWN2QcI/jaUfEkB?=
 =?us-ascii?Q?RMREhi/ssLtNUWlEdGBrPm2z1AW2AyKtS+ne17sT0JeiRYvXGIPTx4rUVsIh?=
 =?us-ascii?Q?xIT4EoNkSjMIcTlfJ3tSEk+CShqEYuvq6yeQotYLHhM5dBVZrjKhmwJtm6RZ?=
 =?us-ascii?Q?8mtAuv1yCE3xArxHRPffDSg8rLkHjJCD1/6dXHMHwc+liSljL//AzY8Yo3Q0?=
 =?us-ascii?Q?mGXyCXIPchf/XqsJLy0zAjeCtEJja5yYPS1IaZQwZkr0szcURp5l54y2yH+a?=
 =?us-ascii?Q?Rm1Qar+pJVh/eJURxof95VfeFL/vo/0SyJYPOYRmH63nffnK2JSDQmraz5s2?=
 =?us-ascii?Q?qooKtmdzSHWybaABFeEHTfCKLVMrnZuPnzyZPStP0dH6fCiE/FZ/VVhQ7hE/?=
 =?us-ascii?Q?fjX4oKdlHI+pni8ZGj45V3aQBEFeo1sYVANjGg2H3AKzXPNZTXlsQatqbP3s?=
 =?us-ascii?Q?bHIqW35Q7+z851ze1SGUjdcj8tOoOVAMgXog60OWTmHdZj0ilvU08zfyYGVD?=
 =?us-ascii?Q?lZi5NjMAbfEfFvKDQzQFrQnQrHm4iTDP0fl3fvHPiIlyzYZHONesf24je/K8?=
 =?us-ascii?Q?JFZfPnPN9oVBb48MHH3NKnllql9quXCCmmEfPlqohX3b17QfCLcuBS7vNEJq?=
 =?us-ascii?Q?wzbVnii+JFayL92msmFZKWxFRF0f2pHS8I2DLAtsC2ZnKdquWE6TGvfGHiU0?=
 =?us-ascii?Q?q2Ypc3rMYEDxZH4ckS25yH/aVUFGZFwCfJevxZLPAglP2dGV6w1aWdEUZeyZ?=
 =?us-ascii?Q?NDMTN/0t/wTvBYmYWfXUrgEj7VzvZxHSat35S85uuwwpUAmtrlUYga2TxLkF?=
 =?us-ascii?Q?Llh27+iUMiAzbwPpGy/n0up/s2y4U+2niHK2XR9UQDCrPrCdmMMYMtC+UKtr?=
 =?us-ascii?Q?0HZmSRjdMcDIwkjg9TrLSHiHoe6poMafj3feFz83weBjlD/eTsujnEHnz4dO?=
 =?us-ascii?Q?17ArRNRHBrGH6vxScCxYhQu2eYbIdDv15EEv2wdYNyoR2XcDcwhH/YcZGoJ1?=
 =?us-ascii?Q?7XeSqRxliF5sRl1OuLa9qS5YIXdhjiNC+qk5Go1WhD4hm69XXDcOAm6EZ8u0?=
 =?us-ascii?Q?Pzo44yM+NIDw6M46tKmEf/FQo5hOIqoXgOvtvhQoDuEnbY7nD5cLi4YvuIeJ?=
 =?us-ascii?Q?s+WlvHB4qpj3BXOxzZ0weLb+jDnDENBG5KjCOvrqCYZ/hcLpi+FiKJ99qHOy?=
 =?us-ascii?Q?ok8hm6heCKIf832ujh0iEhDM96/Gw+S+NKiL4c7PP7W/NRgnV2/6wCOAGzuc?=
 =?us-ascii?Q?zKd9LdMUgK5oONE7IPOmCZzKHVK3mPqpbUWxBD9y5RwJFyd500kNcadhK4vL?=
 =?us-ascii?Q?wZLqyFPp7EoOub4Hu6EAwN0nmzDhGZ668uYxU39ftDlta18maQRs5xjc0LdV?=
 =?us-ascii?Q?XicA1wlNyEOsQbHBisnEPiH/rfxv9j4MmMEJxtr5Q70Q2ox5hXsyfwzrlMaX?=
 =?us-ascii?Q?TTIag76/o5Kc9H+8MGgnWj9F9uovm0MBIFUaBFpWD0W51hiaDT8aEG5dViWm?=
 =?us-ascii?Q?QGDYoY7nouox2yVDfMTnswBu5TQrTH3FVGNqh7bfA4pI1G9FfeOcpRINGwrT?=
 =?us-ascii?Q?btUwBGv6mg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b16f167-73ff-459b-31a1-08de538833ed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:15:58.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmRK/tCLXw/SwN3hFV7eGM70Uf1L290Vixx0gkP50CiYgkqoQlNn85cdqOEfYZnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

On Wed, Jan 14, 2026 at 03:58:03PM +0000, Pranjal Shrivastava wrote:
> > +
> > +	/*
> > +	 * When a STE comes to change EATS the sequencing code in the attach
> > +	 * logic already will have the PCI cap for ATS disabled. Thus at this
> > +	 * moment we can expect that the device will not generate ATS queries
> > +	 * and so we don't care about the sequencing of EATS. The purpose of
> > +	 * EATS is to protect the system from hostile untrusted devices that
> > +	 * issue ATS when the PCI config space is disabled. However, if EATS
> > +	 * is being changed then we already must be trusting the device since
> > +	 * the EATS security block is being disabled.
> > +	 *
> > +	 *  Note: Since we moved the EATS update to the first phase, changing
> > +	 *  S2S and EATS might transiently set S2S=1 and EATS=1, resulting in
> > +	 *  a bad STE. See "5.2 Stream Table Entry". In such a case, we can't
> > +	 *  do a hitless update.
> > +	 */
> > +	if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> > +		safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> 
> I understand what we're trying to do here but isn't this implicitly
> saying it is safe to transition hitlessly to any non-zero EATS value,
> including S1CHK or RSVD. S1CHK might have other config dependencies?

Will pointed this issue with S1CHK, Nicolin has a suggestion to fix it here:

https://lore.kernel.org/linux-iommu/aWarF90zBqxD0Gef@Asurada-Nvidia/

It would block RSVD too.

Thanks,
Jason
