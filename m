Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5232C8B
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832612; cv=fail; b=EEw5bFjRkoWVFHi41IgDsN00wBll/VJU0diZ70rm5SgLrZ7B+R5luhml8ulY0oYYRZ+G+f4z9TEomqR+88zXHrIimKmkxvAkzh72r1cyyyx0mvqIEsYnbfmD+sogZ8dXjYvPxREmQOEUONNdhut5rb4xrxR0Z9gZaQsl8T2AT/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832612; c=relaxed/simple;
	bh=KV6JmMBw45NpWdZ5ls212HlHjwGZnU0wDYJERVp5CrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbypHXmS1uy2J6r12Nph+RWCq7ApSy2mJk72Ax1SWY9/qOjwsMwRH5xOTG82EYC+eg+1+r6hQaRXrZ6muviVY5mmAi7TtHJtVAxqXRCTioF3dPpzUVKCMwY69b+MLW5lhSmsmJSWBKJ7FTkhS1PUK74uFqeZ6LkhC1SEIGbdzr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SaSXe/pj; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SaSXe/pj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7y0H7JItAaDlebie9DPkCk8AAx5tfkYoohTa0Poc1me7SCdWaEHnh9SiYDSBaLf9ylIa3wr0OgmesFvDWoEoOdYpPZC2PrpuZVvd6LkL5nOXqerycbaRF0p7TJYCqHvWxyiuxKrxRy5Vi+6NjCj++5A1+xVI9yvU1BFWP5ShsXx91nVCSxzkawArEFVZw6/Cb4DKZPfI1pqERt+/PkxTkAwGSDre4wJVwOTYDkYitszwPPjULegCA9mnE1mzYzoeNRpgE2qbaOSXLebNqXrBvdVEgYdc6s9tZ/Xn8kIk9H6dqY7nDT8HG+1pYi2RsPQeKsoHkCz48A5hUV+EnisYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC3wKBdTAhiijLKh27jjN6ySQjnNMsqJuSMI4JyStmo=;
 b=c6mEfZZaSMTOkcHel3PGF3DBwhOya20bhTpshAxKnOWagRg2l97t4RV/UM46/lcnLISATbDhfiFsIPpW+pB4lVzruSx3za00SwFdvCYoJ+yyWn8WIl9HTUJgss/82l6rw30kF8LbxDjppIJ4DKVN5voBDvxXYDxvI0ex6pqkzt6FALbMNzSDf8Bc7e80sKjGlOTe7ruK8WH33p4FSb84EYuqR4W+J2O/3cxpCQ8B6doTu00TTAc+heEVdMME0Jo6Y/vfcCByyd9B3wC5Qq1rqAwm53pFOceNCTpgIXJNI2Q81W0MOC1ncn581yrhe12c8D54fKcDRWs5t/Kq22RrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC3wKBdTAhiijLKh27jjN6ySQjnNMsqJuSMI4JyStmo=;
 b=SaSXe/pjcXrzp1c4EYhxqW/psRBRe8hO10Ni/iXmFOmlUDS+dPpI97UFFgO2ikE1VLH0Ibownp+cNk53k/Zpwz15jyTX0G33O+8pSMiKBnNYX/xKFmm9+z9cGXyOAunTcs7+OeMEBJNEhBd3F7yeDkZ2pFUxvlkSoHubk5xD9rjZW0/fe84zqUwgTpXVOy4Mk40z9jLOIjZyKn0Cu1qGv9TBXCEc96h2Y9uD2/A+aqAPr1k8G2vLqjPRJ+AcDWJjUpxI1ZiwRMBRU56EWsiKKjJLz+LPDx12GojoEHiOvo7DXaz8eEsVTBOPJaBGiGOlE/e+Pfxt8rPRsFirPG0BMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 00:36:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 00:36:47 +0000
Date: Wed, 7 Jan 2026 20:36:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com, praan@google.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <20260108003646.GA537728@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV7OBrH-TDiGRblt@willie-the-truck>
X-ClientProxiedBy: BL0PR02CA0090.namprd02.prod.outlook.com
 (2603:10b6:208:51::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: d97c4957-23d9-4888-7bd7-08de4e4e0149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iG0xOUdMAngENRW77lnnZ3bu1pjd4m7yD8TTB99xNhTrx6XGKZilHaHAXeX6?=
 =?us-ascii?Q?n+SysmrE2FneNQ6gz/ARZNm+atPlUz4ML6SAuJXBq0y6Fz5W/iwB2qEUOnqx?=
 =?us-ascii?Q?aKrQX/Fz77Xtr2xN0ZWFzenLUHRkw9G6sM5d+p4ALwuaJHPRMPC8pROFLkU9?=
 =?us-ascii?Q?hposoJIqj/Y3ap2HQx38dznn59fEIZs8zkJ0IMxxxjwvPdsW+Q1TCwTEOETh?=
 =?us-ascii?Q?kZOd2TRjGLV0x2VgfKPIEuqsxlCMPwdHouJotmTwbJgqFoV8JEKvPJchRS49?=
 =?us-ascii?Q?aFFH1Haift8h0Iv3LUkAr3LA0w0n6CplDPhsNjqeT1ka9ONPFoNqpyn4r5pl?=
 =?us-ascii?Q?MCC/i0uOtdxBYc9D/WSvzVoaxpL+Og5+n+SXSCb4mUV04jnNOC3nQiXV8auc?=
 =?us-ascii?Q?wmFPUCedHFNZKIzDo0HgZ5i5G1O9inUHl1tfbw2OJEMrzTgCdyHqCMFNaJkk?=
 =?us-ascii?Q?XgrSSfQb5DmiC2Udx5aiD6vKiZjXJJ7oupIj0CIhl7nIfwETfVV5mrrF/YYF?=
 =?us-ascii?Q?2poi5OH49d+mdHtjj74iRB+AH1+p6b6UzMY/jbCN9wt5SduH3ZIyQwmwObOX?=
 =?us-ascii?Q?VjdK7CL1jmobFAyxUog0peuud+w35/fBH1hSfLszqR5TAzCuB0v3qXUZnlwX?=
 =?us-ascii?Q?KjjwpZt0bU+nPsf5LS+wAhQDFPi/VtI4mDqYftDJqSt2Yi40f+REo7A6nYra?=
 =?us-ascii?Q?cimtQ4ecuplMkDZYrWjBw5KP8DDRrA2FjHubiLIn+tH5WkNxn2KKeg34CyjP?=
 =?us-ascii?Q?qjC4wxWPk2kDfxk5TBxq9LN5gCKbkIPawenqqtS1vkizCHOR4c1B0lx96hVj?=
 =?us-ascii?Q?p7EUc+kDzJyFWQCQ4o/Dx8JbX0776yN8TPSlVrHF7/54b6/oed/3iZREIRqx?=
 =?us-ascii?Q?XWnXnigfLEALa9XqinzRMMovnoGkh22MFNdnW/R2cNPyiNQlIogY8yGL3eFi?=
 =?us-ascii?Q?IKfiqtb7r5g2SNJQ5v8LBPQ9h+8+eLr3eLymbb9PnGcOyD+dGD0XTVnAFTHk?=
 =?us-ascii?Q?OngjtWB4rrOUW0EM9wD0a2hHGv2rmWatzSNxDP1Id9dRd6ki/WXFdfOvPaIr?=
 =?us-ascii?Q?Wd8DqCr7XM7rNvd2L4QaHlIZh5e+SwN6/wxglHzDXGXOrtkmzp6zeIxAPVFh?=
 =?us-ascii?Q?JDi4ZQ7nJ5ZvHcVE3dyu3tIezl2KNB4lWKfcWzstCp9T4RfIi2v22EVyW5G4?=
 =?us-ascii?Q?UJB9g4O9L9nL+6IY4vxQgcfv4eM0L8l91jL01P+J0ido1VJWGFYVJcgmZjIs?=
 =?us-ascii?Q?q8Z6UDPp8f2wfKlbWErOK4vB1I2bWPCR55QsQHpas9Q8eyLzjPmO2PSOnbf0?=
 =?us-ascii?Q?HrpgepbgW4itwF8+5hnWfUEwRbzlPtTR/9O3csh4HxL8A9iBAsWKdiiLbvxN?=
 =?us-ascii?Q?teB6/a1gHB5nlxhr1cJGQ5ZHrjlP+cqGGZ+dEAaUuvCH2FuAWQWcNnVVIJoF?=
 =?us-ascii?Q?cZK3E6+4P7kcenoV584+M8lVujt3Mpvc9nacOtpQDhF/3Gxm2q+A8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rnh1cvdmVCNZr51B3k+Uc1P+Wk9ssa1WQ9gda1eoTFUPqu0SIXTnVBtiq4JI?=
 =?us-ascii?Q?EnwdqRu2zTASJm7BDuzREc6iAvK55kmX7R3Vx8Hi5cZvVxoIb34dCuE6X5rK?=
 =?us-ascii?Q?gPu9HIbR++hU9VK2eldO0nE92/Zf8RDdlGgv9NbggXniXDa/KxkjKr/svtqB?=
 =?us-ascii?Q?MO1D29NGP0LbAby8rwg3WbN+Je97nH+/yfdciR3MdSUD4T/NLcUVI74U+Zot?=
 =?us-ascii?Q?5lzzXVkcwYT/sIBjgF6aWkoGlILlq3Dtxg89SNUXboAEv8ZzsGb8AFuEeueS?=
 =?us-ascii?Q?edk42gipDMpmQkl/ncP8pjlZoLMheTZ3dBuRMA5GNsh90lJ7WcUFZtCzyVAr?=
 =?us-ascii?Q?iBQ8ZrOj6tTNSLb+qB/5akXNyKgknc7Ct09xNFaygqIkjRxPm1s+muI7h3i7?=
 =?us-ascii?Q?ePjBhaqnSNCpQ5x8EtBvKQ/KGXI4tStnkUttW1MGlTG8XNNkpgw7o9O6mDFj?=
 =?us-ascii?Q?LO/j/tj8PeJYg9+ukCcFpQq6XVKv7miJZDNg8jTYdwHqP+ma/T1EloxQCpmL?=
 =?us-ascii?Q?b8OTEDlovd9mtB7geX6KJ66CzgprPkpSaQf0prObn3dQf/3CKUCIEa6ruwPz?=
 =?us-ascii?Q?OGVy4Wv/ddsdA9c08KfTGtBSx2wrK7W4GWOAQK+rnpWaolu4ZJfRnkMdqxqz?=
 =?us-ascii?Q?B3IhjJHap0DjrnLKgYYjhTMmVkhMMCJlj1L0l0R7OTe4WP7bURk4xCjE5Y14?=
 =?us-ascii?Q?ChAfYtgyRMTjJtGCUzYsRXmv/a971HHDzKEG4tyBFZceFBYs9oztjBM7Qf1c?=
 =?us-ascii?Q?O9J8zGn+/75EJqD8+6xj8V+bb3qWPiDQKm5QnuW1fgt20JDvkT/oHfYLnR6f?=
 =?us-ascii?Q?LLUv1iWp9iC/qYMPSdzO1xOjAz6u4AXReRixI0iEbrmXgksKnwpwJmnWxPr+?=
 =?us-ascii?Q?9r42WTTXibx3EPFK52KVc/w9qyHR6PfhTM+EyUwthf2cxrvocJ82rgzMIuhD?=
 =?us-ascii?Q?Q7KR0IIOpEYhM2eokDW62Fx2l1fWXsFU0HGhn4iEZHCy9u/vh9KCByXlsh+V?=
 =?us-ascii?Q?GtNJgI/nGLXKOg8BgIfMR2pP34K/p1mEYXC4ZNHaoPesnbB4NfdPzg/3FsNr?=
 =?us-ascii?Q?JUMTZOEekBJQnySf1p85jsBmIJ8Ls1xz6myM1Lgmyu7ioSJe+IG360XaM0CF?=
 =?us-ascii?Q?HqlH6ipd13qbcYfGbx/Ju4+2398yi9I/WVMsJCC2VNWoTSJXZ57lpMoR8ZEy?=
 =?us-ascii?Q?/KFPp9jPm3PxtBTCFn32VHzPHG/fepP/GtQ9xGqeJgefH+EZiZKGnHR5A7xC?=
 =?us-ascii?Q?+AtdrII5SE+ecfbSRN2FX6OMNvcwfrPGqtzYuh7Ol2L3vNMz/vKpSVw3EYf4?=
 =?us-ascii?Q?HEAFXCzTE17+SWpschBmOv6wkGZyFdPR0ckgatCn3ytk/nlUf6em3+9FxVlw?=
 =?us-ascii?Q?/NEdgMDjICRdnLJnSZ5/x7G5WVmx65EDnz2XnYRBQi35IqL0D9UuMEmVv+yC?=
 =?us-ascii?Q?gY/jKDsNbtAbBgUyrg8NbPhzwloo+o+A9CIf+D8gT5BIRsYTbasUlVsfS/O8?=
 =?us-ascii?Q?J0Jtm0Dw+jipr/Z5QD5l/fxvz+Cyp+2jkCyo4ypCBWHXyl42M6OI05LCNUl+?=
 =?us-ascii?Q?cqDa9wWrRFKjmp3gllW0RAiiTIEZF5Y1jUTB2yTLrWGTSVu8WJclXrzcSK26?=
 =?us-ascii?Q?ROvEeBvpQZTwxKNgQs1zMP0jJdATxOI3sqcgEa6tFXysFbLUP5kK8ucRDazY?=
 =?us-ascii?Q?dSdGehPAluai0fqFaQO181zodqpew8wqMYXpk9dzr8AT23EPi5kfFnSLo+8c?=
 =?us-ascii?Q?NI6gS5j7BA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c4957-23d9-4888-7bd7-08de4e4e0149
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 00:36:47.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53s1TrXAnqe6QCDV0S3RMw/GX/0APDtLWzgpvlzXT/rEzWZn79ji1sdMgLl7V+GC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

On Wed, Jan 07, 2026 at 09:20:06PM +0000, Will Deacon wrote:
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 18 ++++++++++---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 ++++++++++++++-----
> >  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> Hmm. So this appears to ignore the safe bits entirely, whereas the
> rationale for the change is that going from {MEV,EATS} disabled to
> enabled is safe (which I agree with). 

The argument was it doesn't matter for either direction be it disabled
to enabled or vice versa, see my reply to Mustfa in the v4 posting:

https://lore.kernel.org/all/20251218180129.GA254720@nvidia.com/

> So what prevents an erroneous hitless STE update when going from
> {MEV,EATS} enabled to disabled after this change?

Nothing, it isn't erroneous.

Jason
