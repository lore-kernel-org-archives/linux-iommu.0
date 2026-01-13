Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978F31AF07
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337818; cv=fail; b=uAZa1vcNhi00vE1p6+zqAylPbWeVv8kIxUneYrpp4UY6vf23GeOFqWkm4xkLTHRwOqouRIx8yIDecax/RKuYxWKl9iyBq720Dlp+451XeSD7eI4qyoM0wDw5BPhbuouX+ozyphK8H9LXZWOBrRbNGniFQqJxU/sAnKFppOThvmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337818; c=relaxed/simple;
	bh=pxQ/Wlf+7TE9MNjRDpdCGXiBwHxDl44q7KLPbeZ7c8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJ9Ezs6pnlZzbJ5Iq90KY+o1Td5hkyw5MxRGHX9S4FtUQoeFmvCdVFUlxJVPwzr0l8YS8yNnC1oQ9yqFzy4cc8hQjihACZzYVXpb2LNU9argIL7kkpB5qaIpHFQzLMaOJ7LIpcc8mQnRlqohQh1cfAi6CZ0+b5SEo/ES7EJJMcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVM9FkjD; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVM9FkjD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OusCkbAeCsJry4p4wPpivwCzGhNB9n7gZrIsPvgmiYk8gi/B2VSFW0UXkIDDM98OKzWBJUK0lVFgqzBa/il/HTyUH0pJswU0RI2Xn4oCqsMdH7S50XiwUekCWcMeK4j8kZ2cg3YMulIKpBx9OMExOq0rnTvmMAm6psLaLO0i+ZkxpvLlZLVGotviprP1TgjdqvOYyICV4OU+Q1SrAcGiSJ5pK5m2v2qWbmEofhCIPOvE81spIwEIt9447BVS/qmO5iXkDZceoPBz8rzLiP6RGrxEg+FpsmDeupUCtvRsstXY+B6C3VLtGWC3Og80xMG9Vyk77/Vxb9qXEIiFYTaWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU1eAvr0Q1nlf/vS+yfVnvIZ0i1MpZPxS0GafJvkbk0=;
 b=lZaKgkdDjoh5YAkYOXKQW6O3f71jrDS61mAYi4TnCWxVn5pgh32Gt69MLjQKbAF8rRdpSuWG6p5JMSP+SUt+nnYJOkLrItKXyFqwQTN1MO46vka9Zbpp+YFdsKmTOWbdaJyjYp3nxx+UXdrBzh2NwCZuX4A2l9pgSbdcXEXBiHSPzGt3VmVQf1IL2dkp+HOurJOoHvehJmCsItfZmHvQJ1nSeZ6bR+nyo+UiAJIQva7sEtEv2+3imHA/gYtNefl+63bFwtu5wMqe4LP7gqgAOZZDoaRl/B5cF4uZLGzHpR+P1Z+nM4FziRb2oaY8XRZ0ZGR4sVmEp1HN0wgS3WFkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU1eAvr0Q1nlf/vS+yfVnvIZ0i1MpZPxS0GafJvkbk0=;
 b=CVM9FkjDflOH8zTeGujGM1ayCmVr+h0XzWrvmAxP+4pNVqWbsRDKIkPMQziAOPXfhVFanIHkg5uXLm2nyyY/QD8njbkgqZg6OSycPIZuvbaoR0aH+T/g2MaK2EVBnIKGgCr7rpjg8x6vcZEwoz4JoTEcX0jpLqSFJnehSuLvWdLo26XZjHHOAukd6LtgfUFeuD5CSvz2dGDLN7KzH3vRuIxpEuCuy174OpHo6Qc6brEUCkOom8tLcELPeqNPj5w0DAR3Fmhf+d/DuGpAjAot7Qyyh6vKb3SEVJNFFU7vydiAiugwRankly+Ic/rpK0AgtLJigBlez2D5hS3TictN9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 20:56:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 20:56:52 +0000
Date: Tue, 13 Jan 2026 16:56:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <20260113205651.GK812923@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f723a34-3eb1-404b-6731-08de52e646ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6uuJbq6Q+5Bb9cEI2Op0Ch7BJdMpdTbiQ2pHzMM1+uZYXONz6Va6sngWZvs?=
 =?us-ascii?Q?Y0kY/cZsOwIfVjdixK78hccAbEM9bD0GWPKIL59CwWwEbIxK+NqCQVKI+0ci?=
 =?us-ascii?Q?aj0/iatyO58jlUFFArwzQB3cqJ5bWKgojKyoZJftmw8io5N258oyszzWRG6O?=
 =?us-ascii?Q?Z28m+DDZ3ldh+zRM6gjwrO9mxruys3zte85zOnQm+wr2RBiai1wCsptSUSd1?=
 =?us-ascii?Q?ee7jPK+5LjQ04Ykf79xUl1sKaknqvjL36+U/24v8pSPkcxVj7n+hxEyXtWY6?=
 =?us-ascii?Q?qfujiZm3AS9Ey7GKxCQlUJVba4nCLkp5dv6rMOMo31G5KcMdyAxHT0Cndhvy?=
 =?us-ascii?Q?G9f5MMd8WcQbLlRE5z1/7amXMjMvHpljb/vbwyRsCkOwvOQZBaFTJseOsecv?=
 =?us-ascii?Q?NQjWJNPxXMJdhjxCndkefXjiGC1BnMXKgY4JnHJjgORbUKpYvlUmr3p+AuVA?=
 =?us-ascii?Q?yWxt57lcCV+wS0PjA4vdk5/xNy9zWaVsNvrDcE0115zBvtzapRKQfa4DX6iw?=
 =?us-ascii?Q?DSytR23qgqb1lUfDAaYfQnY6zAWCEI4QySOKCgadlplM/IkMmT7Lrvh4P2LW?=
 =?us-ascii?Q?pb+p73d3pgYWPIiAEjiShHlhVW38zM6prkucmAmJ7iHgN8Y1wV0QDOrtlj+R?=
 =?us-ascii?Q?7EqBksGJEfOxe2IG9OmbaZhw91MBAE+4MIr6k4cnXEJet7iMp5uMhyleia0b?=
 =?us-ascii?Q?Ncln7zG4T8lQct5KDTAldWfy1MF9rmq3Jo3BKFoWquGl8RKZCqz0wy24DrSL?=
 =?us-ascii?Q?XaWBZGqkFaNqjS13pHgpQUAFeq0bhowbGPOHfP96FMXJwifonOteT1upRpqn?=
 =?us-ascii?Q?YiozSPv0n3tt6CrAqbsxFG529fjTfw7YU+b+rJ/WGoTMtxgeZrlF5K1P7XM/?=
 =?us-ascii?Q?8qZ5OS2us5Lq81eTUb/QH0NfD66w8Qvj8aqPU8liniht9BVD5zcb3SkHOn5o?=
 =?us-ascii?Q?GrH9t5SfzcVujWy/CdHDj+dX7/1vHMOhQ21+cGxK/l3iS41AYkBxeTbqNs+c?=
 =?us-ascii?Q?o6gCV/xmwnux89FWUZ5RRMTJHfnr64adm2f/XNlO9CJYZ16JRXwIbEH3OLhk?=
 =?us-ascii?Q?yeTMh+JUUTtOBkSxKc4rRMqG603TbUOrbmSUxVtsgzHHe5o4AXNDosRUmmal?=
 =?us-ascii?Q?w+Y9B8nKLbMmFOcJadgycioqQXBv39Np9d/bpm1pY/kQCGdttuxc/k92IUuH?=
 =?us-ascii?Q?KocYIZfDROsW+ANIASxT4k6CmiAY82Y/Vq/SYthgJhs1/9ME2i2JuSpnPO2+?=
 =?us-ascii?Q?G0yPHBqhs5clGfOW5Pq764dgd7RTbVCXg0q/aO90019JAXo2lV0EElB2dTGD?=
 =?us-ascii?Q?raQrrEGcuXaJ5DE9Eyzf5znPVNLsqvEAoNydaQGVLplhUKvD1ySlcQPFP1XG?=
 =?us-ascii?Q?E29ck3dWIJ1UFLlwoaDkgEpCXvHzyr9RRgQolNJdHSMgLjaRRX8gr372t/Rh?=
 =?us-ascii?Q?cixHDwpwUJc72f267F3AODfgoQ6m0Xe+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fFmiVopTYXj+0nqVekJBhONi7u0ER4zslRAmk10/DNSdZDavanTN6B4vuCQq?=
 =?us-ascii?Q?VGqsKOq+A6hIqc+mK+g4bkMQCYmKg5nHgXLh0BLXNiDZBz0K0KaNej70iLqT?=
 =?us-ascii?Q?uh+14UikCxRpi3CaM2mvrvKtydx7GqGugwyRHrDhMLFVhGo6tYjJT56i3vSS?=
 =?us-ascii?Q?ad6tcAAJaPY49BosZP5167EoL8bsJa/5FeiIUdEw0/113LCZUCOPlySwixlq?=
 =?us-ascii?Q?nxpU/QhBEN999+v0hxWPimouD1CHRcMd7Qwz+1Prmu3uygLe28Am1jb1R+sV?=
 =?us-ascii?Q?1/eZfoxC1V38WtF+28/pfQi1Y+b/5/36I+4IX3l0ypqUQhui+YpYJXl4HarH?=
 =?us-ascii?Q?ZZLelypjKvNTblRMYDb0af7bc0MWW5f4xw+IRYOjKn1nG+1phA/iv9mBgJvv?=
 =?us-ascii?Q?1eUxGqZcV7z1CG3LgEWCV6iM8efvmjpLSVcgbWZtnjakai8vIkuAv7ZjBbTK?=
 =?us-ascii?Q?Xmj6fSFV/7uCKvLoN2CCU5L2RgRNY9c6Ijxe7THojLHK9G7PawKA8NzLuYXj?=
 =?us-ascii?Q?/O7DUWvO0MTWaxy4dddQyM9Qcz9FqQ5juEkqx+CO7gORA9AYKzNyjIaxPqMC?=
 =?us-ascii?Q?27Glt3AWoBrY6eE9FGq/pG/6i4EWlYLfUQfChC38GfA2OhmootR7nLv7imoO?=
 =?us-ascii?Q?Lk4QukXbzovf4oMF/Xq84rhhoDAJdiQUKgLlkOsoGL5A9/ipK0ijvR2FdmJS?=
 =?us-ascii?Q?WMZDs1QqAzSMBXSmV9XAhbLUMtJw+MZ4Q3R1AL9A280ArP/guNbQ5S/XYJEo?=
 =?us-ascii?Q?cs8owwvBlHPDuwjE0MaxPkOhzMwzFKGN3ZTkLsI3gBZHJKZoEYkXtwKdTIfP?=
 =?us-ascii?Q?LHggqpZbEGlaYJSqi+1LgWZoTmDGV80oFFvBcieqzwhR+NiD7ArgxAIYEAcp?=
 =?us-ascii?Q?4nCcSPoivX6ILgmqlwyv20kYUIL+qhvi5uewQemPpdCMjOTOZsZJeXbpmBYU?=
 =?us-ascii?Q?0SviG2fUKrmY3DAomP2IQlurtCpYwHd7kIal0VopIYx1/YoGh6HBolMkZwVy?=
 =?us-ascii?Q?YTTJ4/QIN4FBqbIgPT/WX2qLMduWo2YGslKTxz25rj5br+d0GI+rxoeS8QJU?=
 =?us-ascii?Q?yPpuwbmPsuhhB7GHGsfl0EwCvcYJFXP8UKu5X+cFC22qzTG7Gzr3sj+8OZ7H?=
 =?us-ascii?Q?y6N2AOaomV7rCxSVoxb0+fR3OiyKL5nX1C6RTC1ovR0hWF/J1VXSBnAZTxab?=
 =?us-ascii?Q?13r3PirwxqnIg8W8PR0DDi2eWHWfz1Iwi9yGFx2qFLSyxsUAebn/OtgjtYrh?=
 =?us-ascii?Q?9Zof2gPklxIvUpTxpIe5CnduWlpThOdEMe44qu0sshCD0v7cdAsAUsa5YMbJ?=
 =?us-ascii?Q?Edu/pxqXQkwZOeUMh1uQ89BzB1AH0eVcF6e19e1QNNMLPXNx/X0kAGOnq3v/?=
 =?us-ascii?Q?1/5BfzM91P/lw0ZsSF9QCSEuTOBE3Hf5CkyAG9GfUBnMSDoPCxdMtkPqJg8q?=
 =?us-ascii?Q?qU0YJsXXqbpz8CwgB0pFI6CM2NjHEx2pFrjxdE812CtJkh1cFIDsfu09jx+G?=
 =?us-ascii?Q?igytBUaL7G7ddGyxJLF23QD6KUms6ctqcbBv8e83LbS0w2C7rb0fP2ai8Ij2?=
 =?us-ascii?Q?u19lvdWJNvb7BbEZMY/sf5LfrSwJRxxpt8lGVnIOaP8TTOPq37JnL3KGFKxL?=
 =?us-ascii?Q?ZmrZw+f7sIuRNyh7MQRxi0KmCy4V1cNUAwFSYuRDqH8Wmfk2/gT8DyDgkjes?=
 =?us-ascii?Q?sPB3hRmnJx8wfzqoxkN0jTFRDsKl5Sx6BCjZ/nKCQ09sKGFo9Owc+ma/Ka0D?=
 =?us-ascii?Q?4VAvj8dI3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f723a34-3eb1-404b-6731-08de52e646ee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 20:56:52.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StLxwRY9oRftbRnjMH0tG+pS0TrMtoiCA80Z0HRXtLXXVnaIFr4zIfDZOSfrlcuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

On Tue, Jan 13, 2026 at 11:27:30AM -0800, Samiullah Khawaja wrote:
> > - Update 'struct pasid_entry' with a union to support 128-bit
> >   access via the newly added val128[4] array.
> > - Add pasid_support_hitless_replace() to determine if a transition
> >   between an old and new entry is safe to perform atomically.
> >   - For First-level/Nested translations: The first 128 bits (chunk 0)
> >     must remain identical; chunk 1 is updated atomically.
> 
> Looking at the specs, the DID is part of the first 128 bits (chunk 0),
> so I guess for the first level the hitless replacement would not be
> supported since each domain will have a different DID?

Ah, yeah, you wont be able to do the KHO replace thing when using a
first stage..

Jason
