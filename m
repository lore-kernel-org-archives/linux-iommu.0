Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D42A1CF
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558729; cv=fail; b=QI6t2+LAax1W4R7v+zSy1bytnrKA9sAp+7Xua6i8d+JaBMP6IezbyE1c2aSuclD9IP2T5sBF4VzH6fvpiVBNMkgJg5UHE3KXTtVZvKUuSK4oKTfPBVswmeLhEOx6puQrGLDHoDNH3iIzkGs5jTrhooSbumAbo7NW4ICiHZjqK+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558729; c=relaxed/simple;
	bh=/f+lOMO6JIuciviKh/GWVdfSRGqZNyuFWNjzcfxUn14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXcw3gTqRzzzrW6wwSxZ2n1jr1heTVTc29Hbn4FDrXe7tfirRTJqjBwwYP1wbX3d32Q5gF3g1D/jDHzif1YYmjS2OI1QruzxCrrssrC7q9JP7PJXiz4tncSTm2vAxxes46nCczLeRXSxjSjb93LPMosnxl675dfTxaFc051kNdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fvC4XKJk; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fvC4XKJk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD6uNxsu5ekjXtkRz44bzad1nXIcT/n+kMoRghV7HMZkTgRENXogfHuKGOleSWPszi7EBz0SBfLZm/D2R2j/Cif2JkvF8VmU61l0Hvcz5Hgw2L0ULYytUgYCAgXCaw4sd06RK3taeSzs22D533j0DgA/0J9M350IAtbDneNltIMzJmnXRbrcZM32Za+nipy0QIQDzvdk1NY1ZHeqJaHhLWVrs58tx6T0OMYlIiRzA6R2YAqP8H80aewesx/koynykhWhzeurgua+DUzhXoSO7XuvPfrzyH9yNIOsvAW9EJHpSWUDv5uscU/00Eg6qSuaJvSkzOD4dduwLbtiTvfnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f+lOMO6JIuciviKh/GWVdfSRGqZNyuFWNjzcfxUn14=;
 b=NxlF75t0G+ZRq6ACHaPYKq4bPdulVSQ2DwirWOHkP6O/gKLbXH75xWRspl7uxh5kzm0qMMKZ/t9+eUAWJPY++c2QE2mAY++e7lAGBe6pobW7QCEB3pdVLhjqZFq+6RavqpzxGMZ/Htf9stAtk7ffJ7HwWI4K+D21aMmpK7J7CweH5B5vOFmAGYk4ODnez6plqkEU6043eJMJ7JFyR6Ogg3tUTCchq7wOdf894R0Ik2kKqz7mQvDXaZzTD5pP5Ln/YNszZr5lK3xR2ZT2dBqqfchDjFc9aAlqOU83EszZFIQ99gCtOS5iX7YTTeQGcO0AzpJxNbXkuKQf7SphQo4kjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f+lOMO6JIuciviKh/GWVdfSRGqZNyuFWNjzcfxUn14=;
 b=fvC4XKJke+26XWfBCFYsyUBMl4RITnJKj4yet8ZblktR1R5dmQd8RqmnVoVxs1tkmNcWMPVojPNYR6Qc3XD/sMBpbFkYG0M9auymvgFopLACeA5KmpZVP2uZneE2Dv85VYxO/WCYUdHkZSa1Hy/z+BX5PnTkdL/TGAt7ftAG3fQb3wFwiP//xvwg459O5qlANzPEiZJ9SKTkBJgTnNt6MVFbzKWJpzLvze/GDFEsfnBkj1u5i26S1OHhJjJhDIExym04cZwGKgkgHr8qZ0K35ruScNB/zA1zxIauu6B3RcN2gpSa0d8dVjkon1WLxYpWW36twclIN/RrrJzeR3LlqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 28 Jan
 2026 00:05:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 00:05:23 +0000
Date: Tue, 27 Jan 2026 20:05:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, peterz@infradead.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260128000522.GU1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
 <20260127170837.GM1134360@nvidia.com>
 <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
 <20260127182348.GP1134360@nvidia.com>
 <aXkF+FcsXG928Qfc@Asurada-Nvidia>
 <20260127191938.GR1134360@nvidia.com>
 <aXkcrXQH8pHgE7Ft@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkcrXQH8pHgE7Ft@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:208:23d::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6179dc13-94fa-46ce-8472-08de5e00eed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UFNtOJCbdfo+U9eeBhY6E6sQvLDEPJ6rBewYFUocviG+B+5NTBeGfbcpXZ+M?=
 =?us-ascii?Q?hJFr1IhE2uTPJpUVYgmgY/pWYHHunKrrj0inIuBQzK+Kw2U8Y24kKp76zUAU?=
 =?us-ascii?Q?J6PEQf4n33tNtujmdZI1WAhm1GGVqV1/xMg/054N31IdD8xsd3gQaE30KUf4?=
 =?us-ascii?Q?+V/rkBJ7h+j/lWNAx03SHwmH4vpbdHReFLevJjcRU7zUa9LeiK5eG0dz8XI+?=
 =?us-ascii?Q?o63euvkwtaI21GmV9w8HaG0FktH2ilZcGFQtn8sxY2f88wKd5pku+m3a2bgA?=
 =?us-ascii?Q?ddLJ8n3aaCkEnSgetndsE35KXxbqgvLkvubR4+deKOvgiW0V2OpzAAK+t3BM?=
 =?us-ascii?Q?MjDSNrN/mURZFuLT7Wz9Cjq4FyIOqmJN4sMIS9/AX2X+J/bSqw6K5+k7RZT/?=
 =?us-ascii?Q?ZOKAmHvBx5sk4GA699qq3ZwNwlvscKtHSHcno00t1fKDiAcpswsRESywcIm9?=
 =?us-ascii?Q?NRUFJ+ARb3lGrv6Wiei3P5PY0ZNkf02SKPtUTbaCN3E/J488mXZLbiGTDzdb?=
 =?us-ascii?Q?+woWAqYx0OPXf58NPLNL9htElt5yJbMSfWO1MHQXOu40W7ptJFKfOUJFVb3j?=
 =?us-ascii?Q?vKPYj9f0Cj1NNN6DLJqCZKR2TMIqGzvt5nAge7CdhAIvVj/I4yuKd7jWVl0G?=
 =?us-ascii?Q?iqdlg+nL9mU3SgucyW4lA1wjo3BiUxvSSiE3v8p8ZQ26catVoZksT0Kr0myf?=
 =?us-ascii?Q?BrUaTgdxk6P/2/GRjSBJ17mbRRQ2Jx2tzhYX6QZ+bjRiyQdIYV1pdIkiwwf5?=
 =?us-ascii?Q?fBjUBCHV84K52E5t7SMjLcIRQzYrwBe1+ODLVYSPkmiaXHe+F/ldw5PYCEMJ?=
 =?us-ascii?Q?4iXwzYwa3mUwnY+V25U42izbOf71Kz6rFb+Ey8DpgvEmgJbHXWhvA3LARr2+?=
 =?us-ascii?Q?S40nio3NMxWzEVVpcknCZNaYW3bQcU3nT9ypWMNu/IDy9D8AIMXZQnPtwE6J?=
 =?us-ascii?Q?ATSaAH+nkSkhRDd2qCv6iIA5Yb78/IgunnA4XdhlaHEL5LPQNTO4opaINWH/?=
 =?us-ascii?Q?yOgFDPLWpPVId2zuMBRwtjASy8NvkgRSLZqs7epTRGC95vhdZeGm1nsrGHAJ?=
 =?us-ascii?Q?1FKqVqJQ1HN0dhl5vGFDxp5GX5wJT1DpZjwZ0vcqbtHnQcGqFgHX24YpGrpx?=
 =?us-ascii?Q?qy2P6VWFjEIAktYj80OjqxHURB1LKgdMH4SaAPnGgaO34ougYag5ScjP1bQo?=
 =?us-ascii?Q?vaqykJsOZOSPSJQUre9yajhIUSqnYbJOFRaP4cPy5X2x066hz4njaB7w1tjY?=
 =?us-ascii?Q?4t6JZF21VgPWjB3zPjMXY4B8NqKuMoLa1DMgyFxPoRo5mo8E2DNvgljd3NcX?=
 =?us-ascii?Q?eyY2xkTKYjZ6XuCDnWQG1XAPVd0XllPcZKGfjoWrQszmlD9Csvfi39n4rENz?=
 =?us-ascii?Q?HHa1fDUwpnTmuqlAqAgTXPTuDxrt4IDY0hejyc2ZOleO/MWwooK743Z9k+2C?=
 =?us-ascii?Q?L5eYJCxdr33WW7rtSsJDvC0+oIcvzAhuTkn/JXo9nxq8Rnoa5kW+cbD8J9Mr?=
 =?us-ascii?Q?GZFQEgO3WG5KHUsa4yCunBCp00es5DYOHaf37EjdtIkMzX9LAMCrP9Q/vVSb?=
 =?us-ascii?Q?WduQGTOi17sYzmxhwQwh+iTxutTTNMdOEFlegNCxuyjqAEjJJp0E+V+sGXB4?=
 =?us-ascii?Q?1EvN+yjcAtlLVLCNY+ICi9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pW3xiLrO/79dPgsoH+vmVH4PRXLpXCngqcXMqWomFtJ+Cld9/QV9qabLUYnW?=
 =?us-ascii?Q?g5MnZA/Dm8p7VRZ8MMrolXpgxA2Z2NYxOzKht8NcMcDvHKZfliLfQPvhlD0X?=
 =?us-ascii?Q?r0Q/sE/OFyZxAZlfoIDdiReWqVqvAhpQFzUjZf9zp7Hb2DI7Oq/D5PDWAvNO?=
 =?us-ascii?Q?Qvfifn/ZDsmF0Az0y7KoW9LxZisavNZkHO+7xdcAmVYlIGAMgtVFQtTQfmeK?=
 =?us-ascii?Q?HZz4nQIQ8CHSj1IkEJDVqBSKlhoV54nJh4Xc5e+DAJJYyt5M+eXnYwamRlSf?=
 =?us-ascii?Q?zE6rAGF/357RcFwFPO6T9KBiOIJIKQacchGKdOj01PdhS0iTQBZ41Bn/fCAw?=
 =?us-ascii?Q?fOQJOALeuQ9H4zD5FbQsFwGuEU70Y4rQijC2MqMvaDixhBTSN6yD7vuVbLd9?=
 =?us-ascii?Q?e97/yzIKZJRrpi78V4Jx3NTSmKBoKwBL+SxRPkh1kbw+knBBdhFpzopTp7wf?=
 =?us-ascii?Q?Kz3Z9jxhraD1FeKwgqkbPLMydTLC6ApMft6bssNb1Xb9ToGQgQUfE2ABQGZP?=
 =?us-ascii?Q?jgzp1OPOs2dlAn1SCqmO6DL1n6ilV1dzrbWn3wdYmvg4t7oF+kgzzY4ohJhs?=
 =?us-ascii?Q?aCNa46JwaBepQ8aYC9sWszqbA3wK++JKVF5uTkfQ18PpbeYDm6HiXpTCurir?=
 =?us-ascii?Q?xdlDNaxzBTFlzPURKDS6WBqkH2IM6ILY+eo78JV4bEKUiIESRC/HWDtUScDy?=
 =?us-ascii?Q?tOuUvUpY60e5b8fzV6ur/1pQ6ajAtDmUa1tUyvWnl8X0zl2zZ/flfC/R0lUH?=
 =?us-ascii?Q?Fi3/jIxLuSqnY5x6dRwepH7DsfSSMtXCVFRkIfoRpn+FMUT8wJRvK2JYd4Pm?=
 =?us-ascii?Q?2q0p9amvlJGoLtyODsoJkaFQTx/jv++ore/+d84yS6/E/M5zVD6JGxAlqHu/?=
 =?us-ascii?Q?4rSDlhYncLcgH9+oColSIIPi/watlHDeC9RWkQLTGm5eFHbxsU90WYclPRnu?=
 =?us-ascii?Q?JAo8Ol8Qo4PWwbJc0QyjqZW4MsZHMrnmzZ/4Lo/CTOqrL3wiycdyedTRHmN0?=
 =?us-ascii?Q?LIELYJKqVx46MnddrpxMWA94K1N0l/tCOkXmGY2NMbhbQYJH7qPr0oadn8XF?=
 =?us-ascii?Q?s1oTrOEuaTEES7DwJBIsiETAcz79xJEPikA8lB3oL2v6mcpilse1oAnoBUzN?=
 =?us-ascii?Q?xZiEGogv+7Khi4xef7Gel1Z0FFzLdXIPSfPKRGQ6xeRQtsDvQtXE3NddQcP0?=
 =?us-ascii?Q?avgx1ZCf6DGMouSs8NSf6z/n0G/q9UhLSLnJY1qSKrmRMhlhgLADoHH0NlcI?=
 =?us-ascii?Q?aCDFOa47eN+L6InA9NSJ6rC55ZkwCzkKwb9m50R14jtodvIrBBAlEjpJWGj4?=
 =?us-ascii?Q?2mzv9G9BCZMlpAy63aIGiZrUD6XfERQV/onL4JcGG2FLew6X6C0j0GyvzGai?=
 =?us-ascii?Q?Wn4xkT0Uw3b1ZflmvuqXN2gxBgTygHinvTlIQ2RvP2YPNlAXdkcu65TNCkfS?=
 =?us-ascii?Q?fLW4vBxY1g+80tnn2HoxxwXWXH5x+/DHaeNXqhJWfsNn9MwSDV+QhyGSdUzb?=
 =?us-ascii?Q?9SHVxUjiqg/JfdK1CBM1A5+DfddETWm6QgEiIKdeDKypRikXTI/+6eyuBx76?=
 =?us-ascii?Q?RHlDe9mT0QbsKsrxAW6qJjL1Ioq4K/EU//ar70SrrrRSU6jTduKwE/Mi9tQm?=
 =?us-ascii?Q?RdQOEwW/gr3v1kuoGhsleoQ5YalWLNb/eM2pTl26qZcpHIT35ccqwHKNN8PY?=
 =?us-ascii?Q?3kicgYaqHmSVOJyoZXaDa35RY+G5ghPH6XtxuaXoO5gMY6Ba23QWlGgftNvf?=
 =?us-ascii?Q?BfMzSst7NA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6179dc13-94fa-46ce-8472-08de5e00eed1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:05:23.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBETYm5yBaZosZgNOmHnf0OIqstb89MTgFdnX4RDKqlWz/n9YF8JvvevaPnJXwXz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156

On Tue, Jan 27, 2026 at 12:14:37PM -0800, Nicolin Chen wrote:
> And I don't see any non-hackable way for CONFIG_QUEUED_RWLOCKS=n
> unless CONFIG_PREEMPT_RT=y, which would be a different ball game
> that I assume SMMUv3 might not be completely compatible with.

SMMUv3 should work with PREEMPT_RT=y

Preempt is a good point, I don't know what the rules are for preempt
at all. So it is OK to be conservative here, I doubt we could measure
the difference anyhow

Jason
