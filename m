Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CB215770
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513625; cv=fail; b=ZXmOSHEw1CkkR3XbatlOS6w5shqU9Ldb6QSViBhSh05izEHIVPFVb8Yej25Rrth726fGXiVyR7gYXo4GImtn8+lvcUWpBBIuyxVsWEaBiT/M6ylnoPNOCMd79JPOC4oi4yfAC6AjoXnzqzd23wjV5cMUldAO2O/06ugcRwtwhKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513625; c=relaxed/simple;
	bh=7G4VgRrkrIIGqGjnvlztActi+/z03Bq5eEtTfB9DSbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZd/1Ilq7Di6n9HKDxEV5kX7R3FHD/EjRKrgqqJ7MHxY0Kyw+EQDLFJYaFnhHC6FuorkVa+q+Vzp93fKkG1bEWxc9tn0fPdFTZdK4dXFxidRuIB2jFGQiw5cs9GvN/28y0SnmLwVEM1lxa+ga7V3ALieWY0MSEO63d2u9wnjb3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pa0dmwQN; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pa0dmwQN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPnENiAjI5cZNjoS/PBr3H/HEOn9801JN6wCiCf8FqxZPC4j6bRMoh2N0PVbY6MntZyyjr9V12ilGs/KhIH0v/3VnUzQKXEIlVkoc3nAJZ7Vdzkp1TRYeY8nBUPJ6Uqj6iyyNwqSEOM8SoGxSzmyl/gyH/djx6bQmHW/V/LPoY19miREE02Ixc7sSTVoF9penZ20AtbtlbEiw8Rd22MHrvmgypV5cRZaijGPeSc30ZztBcEWCDi3VlmewpP+89bZJaISwlRx9dOZTgu4WqTI2GgoF3qjntG5a1u9TuAxD77M0mAwRa1RhtWPdeH0Oqj2QiL4DqLrj2Suy28Y7V6KVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8zD8dTnRm9KxfDEuAaw73vWg3YCPlHyC0EqD8E0tKQ=;
 b=afXudN+5mhswYfgrw+xDzyZlUa6zhgg5nKlb0t9etuy8smPplWEnkq1M77IiYNYlDtUioYaE+xaCSd/X/F7j823crAVKf0unytlnB+w7XtQVKFX76F8HvbieRqreHMlpX4Zg40YQv7Oh7LwPd786nQ42EbLvv8P0iG6qa3CSNmzMKBGIjDs+sk2qK4kOu1g8HDh3TooRh5FDdjeU99+EarDa4e4JXTDWGYSSZVchR3OF0acJw7cXa/xWP6YEVahk+iiYV8xjE39ddyqUBc6wLPkTB0MNvi61wcTjJhl7oREhPt271YBstiuh9QkvG88lWeWOiojYqF81iyjkbhRALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8zD8dTnRm9KxfDEuAaw73vWg3YCPlHyC0EqD8E0tKQ=;
 b=pa0dmwQNI8rfuqUmP8ytU+hIi00qbRP+md233Mu7l/xg+nsFM0NeU4GCwev9Zdo1WJVkdHzyBg2cqKBiYex6QvWc11nRwIhFz0PPM08OtlyaYbwJSUxhOKL9ypRfYQoyim/Wcvz8EREe7OpULFNF7dZZ3z0gdLhQbfCu86kYRW5g/m5giEPLq/ScQHCvwWw9n1qzXZ1v8ZAyhgA8+qhXi0PCbYgJE422gF7OoHEVGq2ulube3b61gtysvWSVX9y03/nGAZSVSwkAI27c/6PzIEybXU7LkV/mb+724FVG2mJPlePTYYRJCGTUf4QyR7HrQC8rSn+QWIDsxr2vufDIwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 23:33:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:33:41 +0000
Date: Thu, 20 Mar 2025 20:33:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
Message-ID: <20250320233340.GQ206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com>
 <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:408:f8::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 525b4e3c-d9bf-4a71-142d-08dd6807a60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7HteMzi7e6KYZpi6AMKFkVOufTulOiLmGXloIquhGsNsKRzjQ+FkZ5grUrn?=
 =?us-ascii?Q?xpWOWEdyp2qzft9KxtEbfxxsYM8cFBruDM+7z1Fx/WYp9+84cpvROcGys9xU?=
 =?us-ascii?Q?CtfAXPVYp5uMJjz39aDnu06sueQ7OadDRGV3nWTk9H+XX0eBJNTqW0zAAKuo?=
 =?us-ascii?Q?4RrVNbHyz5n1RX3yuq0wAOy+D55YYmr4OsI32qP+93oqWF45Ybjgtub0cZbD?=
 =?us-ascii?Q?qO/J1Ml1OqVrYrYQZug8VhojtY2mcz2hFhoPehMrNDpbZxphrPo8LMVlrKNl?=
 =?us-ascii?Q?atpMKKBTrb7ZWtaGdxaCCw1wsKrBAU/FxMSx2zOWgcuF4PSOP+eu66dN/MnQ?=
 =?us-ascii?Q?kZAJ2jYSRU0LtEwC96hRnJAp5W7uH1p+rrOM/bwuIBShOsStkuUrjsZt7VKq?=
 =?us-ascii?Q?U9FalIVi3zozYK3S+AGvrMSQQ7ZDRV3nXQc2B7OmoXqYKVDJPqF3bOIl37x8?=
 =?us-ascii?Q?ivFYSb+Wx/tNTxWL5mGbbC3kXjIaW7GPcOPou6xWgK2AfnS4J1NX9DNfdlpn?=
 =?us-ascii?Q?Q6TIrfdIzLszfAMGQ2VY/cqOwPIwb/nH256fzCHNifUwTMfq1rQKRe8LQEwS?=
 =?us-ascii?Q?FIRlwTjFEHaAc2FGV0gv34GjjsvFWikzTneFWO+LFmDdQMGQKm7eij6czfbH?=
 =?us-ascii?Q?4lUi9UYl7lb+2Rv1+0/I/Kk71DtoKhrGd8Ux66cuggZMFGTD+V/YOM2issaB?=
 =?us-ascii?Q?xppWzxxI0x1zgkFe6dpo7YmlsR/Stv6B+nG4QkFcTYXKcNSBCNQ2sFC/eLBm?=
 =?us-ascii?Q?iA8qhMcAu5e1axvYPLZ9jJ5svGVGglxO0+BKX4Y8h3xvt01Z5fEJe2yylYo1?=
 =?us-ascii?Q?LaHaKXD0Wcvk42q6NS8/EXGSO5yt1gUfxxP+aFNDU0uvFBCt922KMaUip9HR?=
 =?us-ascii?Q?PhwakBz32RACYfNcu7/CvJfUau2LYLvMoBH2Zi/r7DPJDQJxqEyj6iNRoUP9?=
 =?us-ascii?Q?fGdev+XuY4HD64ORKp6wqKoUH9uMnuvy51/Cs2xq/J/wdQfGylIL/b0kdQjc?=
 =?us-ascii?Q?aLAg0SJt+8ltTSPOwY4MoCqVInOB2swTBlv+rD29hZ2TL/lAzl2B8S/1xJwC?=
 =?us-ascii?Q?eY6uL3VGTRjq1Vhlo5vOc2Ea+m+thlhlb8TGsuNIqEPfoFYALna7pm4CC9+T?=
 =?us-ascii?Q?zT9G1jfTKNVwoWrvnqf51zzCz0e0bmuJIgmiDPY0+A2V/uC6UNeX03M1lZyp?=
 =?us-ascii?Q?N9bSu8NEZrXHwY7yhuLCx4PHktHDvZy8MHnFgvELSuyKqMHqT6FHhmIYReUO?=
 =?us-ascii?Q?wCNC0Sp80Khd7CZ5Wx5NCJEpkKsBk4doxiQtTIkcBboBBv7a73bt4pik7SLK?=
 =?us-ascii?Q?K+LRXTXNSURId1h+kL+KBifmtKkHCJOjvo/jUMbjuLycYj5tsSQCOd7pHlAe?=
 =?us-ascii?Q?usyp5GjLRG4YxaeAE478091nX7U4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0tNWISv516DEzFuNsDIQL/ud1RaF2lcWAKlwhLmM8Bz8EOXUtBjMWmFK941?=
 =?us-ascii?Q?0ELZDxauS8wnFNd2Z1ErcBajh4rkAsrhYowpsq1SpE0F+uUJXyebe8m0NU9V?=
 =?us-ascii?Q?UbmH7eadALZm3yBYBCt+zft8P175mZz7D/RQ/iDiSCK+6LpRjAue2r1/KCib?=
 =?us-ascii?Q?z5lagvKlc45wy6OHZfayISlI/McS5LtEfFP2bhIsAfC/vARIxyH4CUIZaLDL?=
 =?us-ascii?Q?SBxWKyjHDsltyn1K//K/dTTlmxZE1Kzw10BVaDpgewt/PTKTQ2Gp3fd/gt6/?=
 =?us-ascii?Q?k2MbxIwNrFqmiVvyqjbSdzRH1XzsG58zHXVZxxAWoOrPbEI9CES7a0jryqU7?=
 =?us-ascii?Q?az6rMD0dr/gkZBzyQTv6QpOYULsIouQ439BXsSE2hbKM8Qu8qLBILWy7Z6Zw?=
 =?us-ascii?Q?54sv78cNDShmPSMAtF7unJk+wzTe6DfGMKoDjYPJaDN6loD16FUsEgjdYsQX?=
 =?us-ascii?Q?DlDIZXxXte1im3ZFS+v91JN5Ss4lXhN/WakIJJXYSmKHN7+V59r/CGFp13pY?=
 =?us-ascii?Q?1RYSywcguEwc3eKKbp366RFZXDNkx3RFUfG1Ew/L6Y9Vp6FIzfi7wPJuOP7+?=
 =?us-ascii?Q?LTJN+N6TWkyMrYDiq4TiqGsArMADVhm9FrD1D89eljXmwr8GJMXw3bUx+wLN?=
 =?us-ascii?Q?Q8cJJzzPsTfqxoFwt2fIGsa4wCWAQSK/6uzTVmocEUdyo9X/2htyH5AOvj2s?=
 =?us-ascii?Q?Lx6r/WFdKQxMOkkNakyfsFzs9B0/Mo7BlByGcObEvO+tL4bAFzv4cvvrlIQ2?=
 =?us-ascii?Q?Bk4gXzZfQkdh8stJLF2MJVYPNKgztZqVy+JW5KuZG4Iw3AOqOR1S4zAGeEEz?=
 =?us-ascii?Q?EMb5hUOh16tiiq1pDtZWsrRQbULeE+FBj2+MmnvhzsQBLrG5+Y8CXokm8Lv0?=
 =?us-ascii?Q?bIB5ytSTZEX2t/XGjwFmEGlgfVQcPPWyicWPRKF5NWUprsm+k+NxLsmYFoSn?=
 =?us-ascii?Q?LKsCU/VoEzQVJpy+f1noFUtnQ6AsLVa1YVw5osN6tNczMewvwCCWSDgRXoV4?=
 =?us-ascii?Q?0bPG9np04A89WklbPt+CZJ5WFdXtvuwoAngTvFkNT10K/LV87eHwCOaeeJgi?=
 =?us-ascii?Q?YYX3fGkMpPt+UdhyTBLonyB2HwX/e4QvKbxQpYJ8ZMZxDwvHtp+uNKDdYDE8?=
 =?us-ascii?Q?QID5MgAU/4v5+6Iqu7JG+/UzUYOgtRoMyuJXgQleeipP7LLQ69QII8Ifp3AI?=
 =?us-ascii?Q?+9tQfOnXrQEc+31ylkBqAP2zWcdQAiwn0psfJmjylHMfBb0bT58RO+h5GN1c?=
 =?us-ascii?Q?pc7Ybl/cYRCMoIiyMkbIaLDJBCKeQWpb71khWGKndrRM6ypJTyJsLHv/CVW7?=
 =?us-ascii?Q?HONwt6m8rMOdnEhcZhgBe0phLsTDZjZ5aoRfQgvlNWlYLvOB92pOGPyNqsem?=
 =?us-ascii?Q?wRGNOLqH8IgRMuwfm4HTtT4zLMZQ7ZQVMGDW5TxguxkKa6or/fpj9qe0kOl8?=
 =?us-ascii?Q?Q81+cyKCcmWbYiasxrTA8lt6a3BjAlBiGqK6JMumX3nCryp0cx7hN3Dmh+2L?=
 =?us-ascii?Q?eGDRBaKrTYKTWhbp7lDVCoV1maDB1TtNRzKQGdjRV5vKbvwVCcgtOlwPaIhX?=
 =?us-ascii?Q?DD4asfC5l/s0ndiNQKP9i2eyKzU5aqhTp4Ga5OLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525b4e3c-d9bf-4a71-142d-08dd6807a60d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:33:41.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfMWh3NV1PkpQVgzfiIVvF89RArd6C3kN67bpyalrYVEFklBHzSu8o8A9j5dZS0U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

On Thu, Mar 20, 2025 at 04:17:52PM -0700, Nicolin Chen wrote:
> > @@ -223,10 +223,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
> >  	return 0;
> >  }
> >  
> > +static bool pasid_1024_attached;
> 
> I recall syzkaller would do multi-threading... We might need a
> global mutex or something atomic_t?

It can't be a global it would mess up the model.. Store this in
the mock_device maybe?

Jason
