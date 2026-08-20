Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F847987B
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262733; cv=fail; b=gm1sa0NdAPNmG6Hqgr1XZJX9vflmCJjYwRtDl1JGZ5bk9xc+7+E+a6nu3ourbej9XswVNR25CFF68zHaCOH9s0MIiHWXtg/wDZpnEf/my4pWnEDDOqmAixO9UFJogdRr7ZEECwnq+8JCXsQ4eovWvYNYjAfFc+h8wS2Xes6Krdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262733; c=relaxed/simple;
	bh=a7PZpBTstZa6i083ybk+uEoAsr8HkU0Pr2+4F1i18yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dIrjXlu/wOQONUAfPr4SCNka5oSTlWMRBTmETBJx9CQMDRY4nHSpEJjisxEUR42gIramqKAJUn1qhLI8UCGgxDCyL4Q+j4ynR7LY7ZN7lYVwgtWj1huQ31+Dhrc2/YcNKYmZACialUq4rDe1bsqywdrRG1NdekTCgoiEVnbSbCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fk05bKRi; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fk05bKRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc9jQ+geiqsLB/2SK+xhhjCvOPlGRhKStQ/DAdlZn6O1cqh/dvlbYNvRfleOvwNd9L88LkvRlDHVtJetKrd0XcPED2DSXWdpQ96Xvm7L6AP8Rndg8K8NpIE/NeFY/kR1B+G9BULgiPFMIhIMPbeDf7ZGZznCdvMGYCbUf2/wUQTiH0foEiogeXfVuRtbJsnjcM7teEU0vcx9eB8y0A2l8NACvHmQI96MPf9i3T+MRv97bdIQhxSmJdrLiFfPU7rCt7ucBGD6Y2nHhbjnsXaHhVoFBdp3vNOJTqMh51UUWgJQFpZ5VB+ygNqtegiM92yKcvXuxL8df9FKh1Pm7pXFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7PZpBTstZa6i083ybk+uEoAsr8HkU0Pr2+4F1i18yY=;
 b=ZsyiK6bGcVedm5G8Wgr8MUQeP4wVERS0mmyccYasBJ1kecC4Wk3yo5uqAaylYD5j5PD72lgFNKtSeWjj0UMNs7oGIWE11BcnoM2ofnZ53TctYeqDKzdPI4NRLiyKqnQaVoqN2ApFVHSpOhmYPf8vb29mne8jWFKHwnc7gJdbSHp6brCE7TRGWH93V/Xh++QWUVrAECgcm4/w8JBkOcqjd3O/suqDc0Y0ixPC+DhtDWgczbwqBCDuwkUf5nF1d+Ab+jZb5vTh4zyTGTThF0PWknNXBMlu6qKzB2bGqxSAFDj/OuvO5S/6wJg9l+lEKYnrSoAy7pyOMmQN0DzNOG7BhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7PZpBTstZa6i083ybk+uEoAsr8HkU0Pr2+4F1i18yY=;
 b=fk05bKRi2sRTJ5KvuJgLyYLFrghRwXn7/ZE8YCx7661dT54O4Dz+ygA0E6Z1cQ0EAPQvTFmjHKdw152NMgKSfWl2/p0t+TLZI5A/w1vEhv39/ux6nRngiVsvD0tHDbIQnqBEmRV2y7AZlajHNOfWR9qFdJSLfozD0Azj28fgMw8D3XQUL/iw1CXaIqVyXbnSMgrJS57RDqMwV5GHitrxx2gEfd7ZVuES5zy6sI5wJ31bz9u1x/o9kDYmVZA5R/sDUe83JQCa2b5GEMOpAkznjVJQMZDRcINweypepJO/gYg8/L2VKmD/sMNgFs+m8KWSpugGA78VJIFmF026c0i4rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:52:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 21:52:05 +0000
Date: Thu, 20 Aug 2026 18:52:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 13/21] iommu/riscv: Preserve MSI IOVA state across
 domain replacement
Message-ID: <20260820215204.GD244917@nvidia.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-14-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820214150.545737-14-andrew.jones@oss.qualcomm.com>
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b39425-3db4-4c92-b1c0-08deff054634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z8UcOkgdIH5GxFYuE4yrHWxyyA8ou8fV6LOmv4h3wM8JY1BxYvU/JaQRbO7KBztGAS/7LPm9t0/dmQ01ZyNsL+zGgCwHZQU+zTDFqucUkKDsmA/PMi08bv/qJsd3e+hf/t8lu3JsOpZRSxOqHtA1B+V9wifo/zZRu0rhYx3jUJg9mOHhzCC6K4esVwE7clZ/JGtC2jyJ6IR/VQV6i8J5FAYAJ9FKFu1iJZQTjm2BZMaff2WM0pkUDqhdIDQXUFork7jTP4Y4WWkFajdJDDwBgO9dSWW89s6PyZFEh0MFIs4VULT3q5BnRyFaERP+F7s3Q3OOPnfVJwk+ZgsmmDUKOcVvrcUzkGdXUfnfU26ZYqMSOI8oLLkQvhsoiZSbMnMXpWGK92aoa1jfrVgxqoQXefVlyDkdcX/nljr8Ud0GS0Bz6RPKZYaZoDicJ9SdckTyvnyWYTFMntA5s2RdkMVaNRELWBvv9CkQ6fLsL04m6mCzBjNKjAYY6tnPLJ04oK2p0DHUCQujIPtaH2m2m+gYoHQcqrV71u5DvnIEbPNibkfYh8qCKjFCqpM/zyRAk4b/TIOHSE55BKTatrwmypebjF/BDHN2hp2/mcwdLucWGvE3TPuFctL58F7utxdEznHlbXwZ9vQcrDzd2d8g/UT9HXQG822nVPNQMVQkzW5tXYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pB9pMvqnFkIo7j33bMydOw3kkTz3jUzOBqiKtUWPLR0MzYXDshACMerGXifg?=
 =?us-ascii?Q?fosBZ2gjue/Rrygq0883pByg9EOIa7jozTW2WeW/HP4DGPdhhVLwkSzv14wb?=
 =?us-ascii?Q?oU1SttZxjZrWEvE5aCcLveJaErTw4E0hSMsJ1qTW0timkKW0kBBwVDlQyFLW?=
 =?us-ascii?Q?D0ssVowjDnK5FUAypR2k1wjjdn2xaW3xqUW0gFiEvrbWFaZGnSuVVveLOSUP?=
 =?us-ascii?Q?pP63IUfGG/pZrTA4DJg7ZdosT5vZp6rWQus6S63kPGa0Vdl2N9q3MmUbBm8l?=
 =?us-ascii?Q?bzxGnWoJqg//j+mYW8TEwMWA1cnmBrQg8ktFtKXDgJDPv2FVPXLHSOsIjQow?=
 =?us-ascii?Q?DwJxT5k9aZdFzdY8SVXPA1hInMxwc7e2/kGJXZdygacLjm+19b+IfnIlrcK2?=
 =?us-ascii?Q?9V86GMG7eyw5FfeBRzeW/0v9qEdLQqBOpIXPR1jDLo0KnHOr7qHTCnssYsMh?=
 =?us-ascii?Q?MkxlMDsFrNAaSmlyIc7UlLI2w+o1c+fVRtUEweZSvjh0G4p2fNxm5RpZ8v8c?=
 =?us-ascii?Q?pG6pw3tuIg7Ttpe6e5IVIpOAweIG80maUOr104FbbGzT01nsG7NdfWSoR1bl?=
 =?us-ascii?Q?dGNv/ENahBHbLCZXPfnJUrynXguksXsosZ56U82BYbnTlx9EPXlzoeMXWsiV?=
 =?us-ascii?Q?FhCXnKtmUIMUfToAf8IjnTDRKduKkKn4uLtEwdU1sovXe2L7yCtktSIkBeru?=
 =?us-ascii?Q?x+FXUWTj9YWhUVKX4XCOXu5L+J2YrGlL+BMW/0SrgBpOkM2szb01sSLKKhwJ?=
 =?us-ascii?Q?dfjHrq133qVJ6K9z3kdR4kij0Q0TbU5GO0lrs8g8V6gtcWtx41sFNLNvd73s?=
 =?us-ascii?Q?OmInUWuonxqVguNahuh3g8mXdP1IJCbcZScRQl7I3+FWEEJWzU1p0F6ufZ69?=
 =?us-ascii?Q?cNlWC5WyTBjcqUr52Jb45bZE1ucfsN/MXEzlCQsTjY0IFpt4UbjxNjyRpI8Y?=
 =?us-ascii?Q?+s4dFFlhS9blm3MJicP6e+/asUAXnxNU1DcXmePP0tcPCXJWpSOtZeRdcAHa?=
 =?us-ascii?Q?UV3RyNZqyHHTXQfY6Yf5CG3Ni8PQtWccr6ouZsxXzJFJlSaCmrHrbM7gW6Pp?=
 =?us-ascii?Q?Yn0geurXfBCDHtFwibrX2sKeXBGVALcq6auWXKHnS/TTziZ7Jl/9mHVsTI3m?=
 =?us-ascii?Q?AaKO2eUWlqEuYv/NqIArxbFuaPK4NtAP8/kXVAzOG5nDg1UvQYLyDWz7YloR?=
 =?us-ascii?Q?sq1PExlHCPrhaEwJAZtuhCdVI2dU3Oqkp7nd7L+0x2uEvokhGntvRmF5hUVX?=
 =?us-ascii?Q?RUWqdsDMwHZNL8k21ObWzNNL0eFmssRfGzMgswiGwElfwW7H6y2oiN3VPTTc?=
 =?us-ascii?Q?ZJ/FBmTecItYCfSxHyukCS1HDZtaSwdikQCzV++wdkVabGACtzpY7oEQ8hHj?=
 =?us-ascii?Q?8u2zi+9XYXh01tlFrfNaMxBFyjYG9y6KLleXYS73Ids4KtTWGpdUmtZFZc8E?=
 =?us-ascii?Q?B3Tc2Yr9TMyvdW7j4HdxSiWeUTElt4ev1HnguVp7obFMEXNLxzc2DxrFfX2S?=
 =?us-ascii?Q?Dad8cgQI0InWiCCl2NT7+skGegdoA+zOrFtDQvCwxRfBTUq+FocwrwmtG3yb?=
 =?us-ascii?Q?lCAiHGjHKAa2CPOU4jhyH9VbcpN4Xznqn72r9UsFcMeZKKa+dReBlEI+2pTv?=
 =?us-ascii?Q?36cAXU2AcfaK7f/BGMEFPzmQDJEFGeeupccLLY9AL4Rok2v9+nTrUKNkAm4P?=
 =?us-ascii?Q?Nqaeind+qb5GJtUVgleXWjd42kIiiahjASQKCf6HpTr3FqHW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b39425-3db4-4c92-b1c0-08deff054634
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:52:05.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cStDjBO7K7uuDcaeSlAm3z5joW7BYBOsxwTXtvc0VUpgE9ZlKt3DwurZwcrlaIIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

On Thu, Aug 20, 2026 at 11:41:42PM +0200, Andrew Jones wrote:
> MSI IOVAs belong to a paging domain, but iommufd may replace a device's
> domain while its interrupts remain allocated. Waiting for another IRQ
> allocation to populate the new table would leave existing interrupts
> without valid MSI IOVAs.

???

iommufd is supposed to handle all of this itself, that is what commit
40f5175d0eb7 ("iommufd: Implement sw_msi support natively")

is doing?

The whole point of that commit was so drivers don't have to deal with
this at all.

Jason
