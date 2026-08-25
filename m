Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998247ECFD
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666627; cv=fail; b=abv5ha29hG/xshdCnYr0FFXoyfWy+vheOllQxaZyXx5+4MKpMIx0uC9sLt5VQWy/7QEjAzwZ37FdsRUKz3YJNcyV6j8Gx0may8u0rxrlXGC9tZiMruYGyG8E7evIGAl3rPNE5jhVBAfl3DAuqthOufrThwx9q6w9a+yS/BVcNVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666627; c=relaxed/simple;
	bh=2w+KYeTEDwWpJnGrk/NwHa9HAHqY52KDKaQJL9PeOEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQcnwwEdqkKfuQ32OtTjIOi6CttX24aefirEpVWH4UGowDcoPTmBkG/UrZGU9YabYAQASjROgmpwt+n75v+I62oUrBuulBoxQ82Ah5Vk1tnRz7APqHVS8KaZ27j8oV8Z21/rMdN/goPxjFLRj5DFbxsrq/jxpn5NfycY4i6dLGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lvUIWL6H; arc=fail smtp.client-ip=40.107.200.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvUIWL6H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snF7AAtg+4Z8iJrdDP7jsi7pcGzE4o/MxDl7N7VLte4PzZLIGgk0bJuZ7FkozjHZ7eRbSB6Vh+QIhDUWpTLFi+EDiQbB6jED40SYfSqOZlXrS4Vfm6CyMP4abhC0V4dL4dXUbektvceS2NNu50/X9aJ8oE3P3oakh6RWYR7ppzt4aQ82hgIwrMcXut5kdffYh7UrBmwqGZm/vRQlNM0OOSdA3/57IMS4ZyZXxI03wX/bIcuxK0eW23mqemflkQRGjEmTKImZOxEbPR07Ixvc3dy/dGAuqN5A8+agrM3Len1okiMETcbDL0fR/aG2k/tvwks/vabGPoPkjDDA28Ba2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w+KYeTEDwWpJnGrk/NwHa9HAHqY52KDKaQJL9PeOEA=;
 b=bFnDqtziFw2ItIM+eoTsdHSu31vauI+za3P8M40WCHjDgdE4B3+rbEWat0YJh4uc/ijGFk4pCGuifWZzIFgfB9hpGJhBRPJvbDQKFzWR3UvZvX1020qP6a17ngtIosylBEI7yVQFYFoMN9RX1XgkFHLcYWJspYUbBMQHVYGd/uXxdNtVTTZ83Ut9ld1fLO7fNHSyAFnZKEus5lrOVSvbAsDJjtvEX03/It3WMV0+kOejWDey/55O2gJoUGWG7z0L2mkKho6CMGr4jMdtC8Rjjm0UHBLgqyWnR6GaywmHEuOQno5FFpJ7pV398doEaNXUxvEa3it56tCUfNUVY0gKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w+KYeTEDwWpJnGrk/NwHa9HAHqY52KDKaQJL9PeOEA=;
 b=lvUIWL6H7jebqwNHo30JUVlezlzAgmCrYj/foZEhbEW9kT5gTLXcsn/SRUC9GJH1GRRtpQXUfi/BB8/EA82Fy/tauW5yR3ooucTPSkm8LnJ9NLdtRt4fxaowQ+JlDL5t9GUtlg0e3DAEVu0UkUGrKvSTZz8nRNTcherVqpBHAm6U86bSOhXiAIrVM4fktvVAoDkE8KYrWZr0+sjIao22f1arJvWYHPBKqj3yE/wO2THuQ0Hx4spSYI1NkEMyQyZInO4fU/k7k+yaK1rRrGN01X15BQoDNLO1/YPcMrpVPS+6lBFOM+llTQcz3Fb747AwT+2cv0gLKsTIxsNgJy74Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:03:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:03:35 +0000
Date: Tue, 25 Aug 2026 11:03:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260825140334.GA3325090@nvidia.com>
References: <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
X-ClientProxiedBy: YT4PR01CA0193.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5b0d68-528f-43ed-e599-08df02b1a785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9KwoHYYFHBJPwPZvBt5N8xbn/nwqOOmAnlOQXapacBvVFLad6gBQTWaRHIKmnZqWhvwLznboA/gOKNZ/Fc7pw0BO6SfPFNEQKMtt2e3OxqZIx3PiFYokjn4Av8LBPv9yzRv34UPdGkeu7YgtrtT+PkShH9p5YyZrSNMVv5a4tmBgKCv2DwTF6oxs7HEzuRGodGNG0f5M2rKA8sR7XCRKJtYlIy6MbhS9NC28eSClIQMJEu90yBrLeV99UD4dPOUlf9bO3kBKmxkARPOJigaqAhBApDvXZZfF/a96lQvDbUsrudMje5FZTii0A9MXmm7t2NtjeegCyw34JaXEplmHRKhH2xMipXSE0fe4+VvL6oOJvZyl8Io20N2jFXt5zK9KMlJHxTcJYLt11MyQn+S0S8evCqiOOPDOcq47E3nrFMKpvpTdA4zBjkHInHYT6CwSE/YMT0WQKVXwmcx4acSR/el8wwxWOswv6+2tsvHNFU1eqG+Y1CDa4HYJkZIC/9T2rykXVxPwFmXS8P2jWfSo+sJ1ozLHhVrBujz0GL1YKicfEmf7lFxPf/M4n4pqnEJ0Gy1UL+lMliwiDE7/kCRvCtZjTNLHuSiS0aoHbza8jcmb6o3NAg+9wCl7SFu0ZA1XckG6UmABiQ5Jp6yxMuIoB6zMt/jwj2Mr9jSKbkuCyI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pa3+B+QjNeLrN73pxAsGDxqNaTxADCmnY/OlSSo4U8l7KfsnTVnJCZ8d583M?=
 =?us-ascii?Q?9JQq1E4bdqaxaFQJue4CTWrTtrgF4V1TZ2AP+14JKScheB96moLuq6AsL9vl?=
 =?us-ascii?Q?yy0txTMFC/srBTkj9fFd29lX75pgc6B2Ue8kT1Y6pMnO0FEjBGRKDlc/rTpT?=
 =?us-ascii?Q?a0kY8vLJiJbAOLtSidZb0mUF6ftiyPRmc/jdaDAO6AMqyUF9hLxM4IMI+AWH?=
 =?us-ascii?Q?f926HBFcya2rJyATD7yYSw4NXlHqW+WVLHX9kTzzLB6q4yBCFes/4eY2gKB9?=
 =?us-ascii?Q?SqIjAnn39yQPseVlvl5z8WIvWfrIf+LSDXMKUojNYubCpnqN2K/QHmWdA1D+?=
 =?us-ascii?Q?2oI6gxj4oOugP8aTboRVcVLgm7jqCUgA+GFGekYMx0NN+y51X1bp3XUIlyDT?=
 =?us-ascii?Q?4BahSXt/k7Iy5/NQAMMVUu4ofO26vt9EDT28gftQEQWd0qVMqtpAz/qiCCvY?=
 =?us-ascii?Q?YPAhoLxwNMu4BjFL23+dBdd7cx/JWYtLS0jvjt+hx9awUnn/c/hFpF4GX9bx?=
 =?us-ascii?Q?4YIwcNcHkI5FRssvpdFcZo/t3p32MDJpz9Y4RqxGIUteWVwMoiQd1WhSDSE2?=
 =?us-ascii?Q?DfNPP3lOS79nK5zOCsWM6Xngh6hE1xMeNc/dqEokneEkI/Jf2DDrXb6CH5Z/?=
 =?us-ascii?Q?mTI+GFWdGv1T4hcNIkVdTrwS93DWMjmMKwFzqowf0IoRAHAfvOKqomJKkdIS?=
 =?us-ascii?Q?2PkP3bBUSD4qkBS1tBTJvn5Q/6U3M2e0fJ2x/a5SJHK0cME4fchpJVsikh97?=
 =?us-ascii?Q?HSsnC86aTi9qsCBDqW548iDBaObaW7rxYWGQDPcr492KuSGtehVMwkaEiOvB?=
 =?us-ascii?Q?OU6Ka/Yjo4GFBNx90irMq+Yy+ivZ3mnMU4t0a6pO1nJfKpiJ28I58aB2XA42?=
 =?us-ascii?Q?8srwOdR+0mAyCpZvPqb2VFHRgXW9G7yEqrbbGvflWPpg0tyM1b6UfoVp40in?=
 =?us-ascii?Q?XzNz5bWMcOsd4Nkk/+XpxxTqA/vb7MlaxcVAJ6hCIV0k47GETQ7yMERI4IPB?=
 =?us-ascii?Q?kRKfeVvItVP5Q09DNhlYWKY7NEcBCC1CSWv9XCtmmE8cuCoE6oy+GXBow2WR?=
 =?us-ascii?Q?EhJ+SZL5PdnFztoIJKVZRzGoDFbP6CbqzE301nZc5CXqSNEM7Z4R7+p3xWgZ?=
 =?us-ascii?Q?1KkQin9cL9bF76bvNl13rKhs5spZDzV9D9Xx2zd5YN6tKznFdSZUTttoF24k?=
 =?us-ascii?Q?b46sE8pKO7xTHCJH3+IxOW5Z2WKXXUcuepDYrA12USBKl6brTiI0Gc11rVpm?=
 =?us-ascii?Q?w3+RDDakrhpqjZaYGP+59CGogWLCWdWopON6GxJdDi4m7S7yo25Z8kRSlO/E?=
 =?us-ascii?Q?NVrjg6BlGtvldNEq8ArH9gQwxPbDO9Fvxw3HICL4ace8y86WCUB5OsHy3wsM?=
 =?us-ascii?Q?yHn8fY14177kMSs0tYJHqXqT4aHkiokuU5EWVW8SCSZMEgeVX3YOfYs5nXa4?=
 =?us-ascii?Q?y+xhwA+FcLHEPbEXQv2nsb9g8uj1rKnCuNUgOg/28dFgM4957OunthSUgyFS?=
 =?us-ascii?Q?mmg3ZR0Zyka8zJCANSoMHYixdHSnBsfwRCVfGfWfFlUHvKQSSmgi+sRqcFtJ?=
 =?us-ascii?Q?+lH4MLmW3WNTDBg7fPa68LYW8MlwBnEMZZyq43jtVvxkaDFj7TuikI6esws8?=
 =?us-ascii?Q?3bXnF0Op0wIWR632S91w3x8gXdCZRNEm7CijfPsc6Z5nPykVbFn6SfGlC92h?=
 =?us-ascii?Q?oMBn+Ub+sIiAlt0TIALx1v9Ebv7ap+1K444bZMvbGysQ9zdi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5b0d68-528f-43ed-e599-08df02b1a785
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:03:35.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5quxompRE9yKFwgKVQ6alWtTwINBbpwKxYRklPVgGiT423NqzJHOSE9T+6LL1OqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

On Tue, Aug 25, 2026 at 03:24:01PM +0200, Andrew Jones wrote:

> The irqdomains remain per-device. The MSI table belongs to the
> corresponding S2 IOMMU domain and its configuration is bound to one VM's
> IMSIC topology. The current prototype rejects irqbypass from another VM
> once the table has an owner. The irqdomain does not sit on top of the
> vIOMMUs. A vIOMMU links guest-controlled S1 domains to their S2 parent,
> while the per-device irqdomain is the IRQ-side entry point for updating
> that parent's MSI table.

Doesn't sound like the right design to me. Pretending it is not bound
to the S2 just to make it global then blocking multi-VM is not a good
place to start from.

It needs a design where the guest remap is linked to the viommu so it
can be per-vm, somehow.

> For the host remapping implemented by this series, each irqdomain is
> per-device because it is inserted into the device's IRQ hierarchy and
> provides MSI remapping through irq_compose_msi_msg().

And this is an entirely different thing, you don't need a domain just
to call irq_compose_msi_msg()..

Jason
