Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAB3290BA
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428801; cv=fail; b=nPTI95NTafU9XYgTvFtt9gXx9RQV11lzFYYBdzeh3KpA1ZiwNEFO31FNDRu8D/AuWzik5K1zIMtjWIBye/cDRtTG4RPUiPyOkTzcBZdjh14IsYw1uB3vMqnLEeMo2arrAYw3XazdlZYbSrtmDr9cQKPyvxi+87oHtKdFMk10KNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428801; c=relaxed/simple;
	bh=JcouDXM7fFbj4aLQr0MqaciK0IYLsaInwLk+XGjAQq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IwlQznqsSnwPvgNCM9xnx1ileyMEn/1YkYbLwPKoTrcEeIFxYFDzQbFLPN65IyrjmIrsQzXOkOmCx2mH4jCirfKAG5/g7AODCulNVX4BmpuQFMDpw/nEAUSBXeDc3X/VpW5kV9TjcubJ+J9uFgUhzrlUTSbBSXDLPl78A4BoqpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q28vAjIF; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q28vAjIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMKqzd6hCDemLd8ZV79+S2aDJJvZsy5bD+hc9W4wjbUa+beWP6pL/U/1xXW+sUB2b76siAztbewFhigomfeWQfpbrz6R2ZFC5OfTGQzsaaJJ7j8jIUmYu4N1PsHmRJoPJaxHzUNqY7Ph4sxbeJHW5C7TcFdMtX9iPqlb1XW06CQ4tctIgV5lsnzr4L23f0AWI2km8ARvILPPU5b2WwYVnZLcRw1yZeK1Z2nqmpd762K7CAQRI/8FvwaJ5x7Lq1VWLar0L4hXPkElSR+7ua77iE7w6alkFMiIXzn9ewOf1fwwQloLNJUt8MD0vThrkLdvMDMUvFoLV/600i4GpqWHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl+64iMCPAlqsCPAEvV0HLWf1NDn24JHnkYwnWD1LW4=;
 b=ZoSSqbfQxyn8IbkqftjUgFxwutCDVX4880LvC0APttNDosngqdtePeDGIYoBNGprOo9S1Z1TupJyG8DvqGKo23408kQ8Xpqnrscx6aSAmOW1Y9TYX1aW1BnwitJtzTLyXckw/APKOYlgWnqa9Oq8BKHmVQS8NgIxvmUJo79xxWnKhiT3bFbNs/MAPJIAX4f4UON7ptSHpbDYdXQlRU8+v6B6WKsimZCoWfzebc+ZSFZBdAOLqtUB9bW4AI5UefcqAbteCfmPx5BlSXvtreNZz/2+qoU3F3ifcjcHrCmVY7pbIDRSxH9nl6AdZx+/TIDXT/Obfr4yFjr/hyX8TWfyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl+64iMCPAlqsCPAEvV0HLWf1NDn24JHnkYwnWD1LW4=;
 b=Q28vAjIFqzdMRHebtkvUlEzwlUmt9N3/pnaxGGAykRe10wS4g04TjqW5UAU9n1urVRTV9StBr9Lp8tHlHOIUZ4b0KcuY3woXcCeKaf8V2re148c14TO52kjHcOVqE4ndmodr1Aar9htVDZg+MXB2/dyGLPCmWKaGsu54P5ZKm81Nr3s9inrUTg5RvdIm/Q6RfJBogtH9m88K47V2xqz7mR1jjVxx++wGvP9BAo+RMziD1KveldT1eWg7eNdH9EYwL7ABseT1EI7t0Da7HFF6lDZy04R+JyCVgVlyA5qV+ZfqauJEuZFpwpDDRzbZS+3jn/q+0vI7ACVXFsTFkKT2EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 19:59:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 19:59:55 +0000
Date: Sat, 22 Aug 2026 16:59:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	praan@google.com, kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v9 07/12] iommu/arm-smmu-v3-kexec: Add ASID/VMID
 reservation helpers
Message-ID: <20260822195954.GN244917@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <9f9d227c0adf472e93293008e7083973688d015e.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.13622444378152698190.b4-review@b4>
 <aonvzux7UJVxBSfm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aonvzux7UJVxBSfm@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e2d77a-81a0-4d05-62a7-08df0087efc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|18002099003|10067099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0Nu0SJ4brraLErDgSq1rF1lfBiJloBBGpBFn39yJDufnkoC3Fobfim8kRpiBVEYvm+7y0lyQ7xbCdgLky9tk1uZkwI6/JIowkaBLjxa3nBFFlSeUTE5mvTVGOkD57DxHlm9wfkkPfTpn4/VgOGCgbMg9FNyRTWsbAZzzAQ46bwQI+38xZenCZDl5Ks/UdxqxhNG+DbHoVPKkgcije2lIrj4aej4tslpHDQGQo5xStscsz19z3rh2hws2oZl0njDd5XvGegfyMO99SR1nDCDKNMl9ZyWIbbeu6BEAArzWGhfl5/apBLQ4EPiwXu9SKpbCfxNg4oS1YOFrCmEpaawubsK2wR3NziA97emMKCb2hTKsjgDkC2m/3enhi9sEwUD9YWg51WUx6a9jou6xQTVUo4KTv3/PV4t6bIPqoZMdYP5Vpvr2RM4ZXyZ8AOgMaUJ/LLghHb+DZKQmNR7j1zX+2OfkS6Az7r8DY7+JZc/vhDNwxW/6OQqmhS34BR6/FXIsX1h9s9x36CpyiFzAuQu16DxZrW8ICsEjdLMWx4Wnluk3rbVzoAONoMDqicQNty9kA9BTfvbKpWHmRHdO9uy6GTuaieKWqMsuEW93Ud+xAN4E1eMWRzqQZowFpZBgJ689IDCGHKqznSkfc3E4wMpObkw8njuV+6zDRg+JArT3JaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1rqw3awbp5HOTnbXGTkhfS1CjgnpgiEZbL9ZIAU3o9uMIFhTj/i8NP8xbRlL?=
 =?us-ascii?Q?rP3lJCM9IjtLiwifG5naBCIcJs3Vt8ol93MRJxryB/gNsVYYYDYMMf5Gca16?=
 =?us-ascii?Q?h3t+00bGy0/hHjK/FWXCjIP70DUEkpv1mTzJNXJJRvaSYswuynXpjuDnzWfR?=
 =?us-ascii?Q?J9bkRqQyAq/lrMAgCFowu1vtNuNqxo/dIe0K39nHsdpP/sR0lP35hQKlpWk5?=
 =?us-ascii?Q?BpEb+9r/3RA21dK9GBW3zRrNZtW9H+730eh72hkEEk0T7dRrpqPKGKLKUUZR?=
 =?us-ascii?Q?rECnumgZr9pMytpHIwCzlMggAS1JP0MZhW/DwS/S4URVQ1rcNeXhQWNd687Q?=
 =?us-ascii?Q?bpHiHWJigXgVbJ5SbXQMnL5mRKWa1ahBBJdOdrI2yesDoAnJBcz2OvfIs2UZ?=
 =?us-ascii?Q?1kJbVTBUIzKRRe1z3lArXQJmcq2cy6INxx4p7D7p4vlMephzbRVz4a5c0t5q?=
 =?us-ascii?Q?keAnpPe7uPwPORorxnhP5jPgZQYkcPPhk2bbatsiAhq2SjDYMvnTqSCagx5a?=
 =?us-ascii?Q?43ijLUd49MNLYekr8e6R18SAY+Dc2zfSDjEifk+7AB3JPCZJPnWKEcqxlEKy?=
 =?us-ascii?Q?sWhkL9KstfLKwN2BDI8bIZ1PN9jiwWegUuq1kOazc+5YQKCHyYG360a3+8bz?=
 =?us-ascii?Q?4MhWfNqT4x67o39uobu87K4J2zuKJDN8xZRCxchRbdPDvzayWdbg76rEys8A?=
 =?us-ascii?Q?ZukdlMIF+CiLQT+cGJl71e0c4qRFX8Wa5+2oNH3+/LeQ9QFLntrM0vsbl2/J?=
 =?us-ascii?Q?68N5lryP8um4i35ifVmsnQQ/PDC94+V9stD6d3SjU/wvSXFPQwuCyb97EBhc?=
 =?us-ascii?Q?WmOkpDeRqQpqXN2u0q8zvjvyIIsWnNOEe6WP+K/yZN3PXdmhWCp4xZpuW4yC?=
 =?us-ascii?Q?Mnem2PKuiTcsIqqlMPaN2awQ4IPO6CR5i+mHaI/3TfMjTwqfVMAXd29s3Tjk?=
 =?us-ascii?Q?9n1YwZX9X6CZpCX8/6vP71EqXqKEUTJ788BMpnYNrFkYHT5D9z5lyhU1Kxey?=
 =?us-ascii?Q?42bMliqJBB9fEHS3tVXPp/PvGq2fcwEWPN14Yx4klh4s+sP32e9xVwtRl/Mh?=
 =?us-ascii?Q?k+Dm5KkgJ0UZ6KuEQQ4mopYbUIdZhXGFqURSfs9V61Ne2wH2bETjRBNEPz3c?=
 =?us-ascii?Q?nZ3C5qs3z5cohBMuMdt37EKUqKZz+JjJyam0XAZVjiOtYggyjb/H/c2jYdAm?=
 =?us-ascii?Q?59NfnxzkjkSUdqPDErqZ4bURIIYNGSMBPC4VWl4fyU6yMqLn/YNlx6hhgnrX?=
 =?us-ascii?Q?lNlKKOPLDjZWqMs9zcbH0b7Wfqu5vt4EWgBDcPFA2lroT4yYNjodIKsIZl2T?=
 =?us-ascii?Q?5Dpsq9cLGZUr7LA0EYq+iKtn6+gzAaueEQnwfvGDU7gd6m0RxrCPDWfgfTKw?=
 =?us-ascii?Q?1b0o6LM5S+h4ZwStAzPcK/pkAKe24R/VhzbtEXVqwGp+9iB/Sm1TnNtGixtg?=
 =?us-ascii?Q?d7qa64CVH27nxrqxVOZklbyklXSghLq6aq85DFxEHcfoI+6b/PiKLyHT0vcR?=
 =?us-ascii?Q?C/AbnUrBfnH66O0AgTB/u6BiAxDYg9w9daRh0LpJJSdOPdN0NYMew0msqOdi?=
 =?us-ascii?Q?65dQLO/bEaWojF2Cn73NtJrVWAC+8269UShLGXuuGk8k+Fm80Hg1MLrgEwhw?=
 =?us-ascii?Q?yoiify3BDKtE+c50imWHVOtwlz5sWvJqhAuOTac7x0y5LIwIuVzS1dkcw/hv?=
 =?us-ascii?Q?+ZfPRbejUOkEZkLVu8vT/wiR5WZAcSJt22XhmdBNdoWcZLUn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e2d77a-81a0-4d05-62a7-08df0087efc1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 19:59:55.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdJ/WcOnSYnLmT71i/RQgvg4hfqizwIZJKuqfEcWQEH4gS4/XmOGTEG2xBOJN0sD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

On Sat, Aug 22, 2026 at 11:51:58AM -0700, Nicolin Chen wrote:
> On Fri, Aug 21, 2026 at 08:15:26PM -0300, Jason Gunthorpe wrote:
> > > +/**
> > > + * arm_smmu_kexec_unresv_ids() - Roll back a failing reservation scan
> > > + * @smmu: SMMU device of this kernel that failed its reservation scan
> > 
> > And wouldn't need this either.
> > 
> > Actually I think this is overkill regardless, just leave the xarray with ASIDs
> > reserved. Who cares?
> 
> ASID might be 8-bit that would have limited ASID slots. And it's
> a quite small step, so I think it might be worth keeping it.

Once you have it per smmu just clear the entire xarray on some
failure

Jason
