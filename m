Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5B30CDAE
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306045; cv=fail; b=jEMbwEDKKH6eXnPEMBCiQ6F9OwLp8B8Hz5PsIaR6oeGMUcbi8FYIHmRm6K0txPwHKFsOfanBSoBT8LPBl982CGAOgklRK13pRkDgvuMQf25NUOasl7v9Z2tQ0LCQ9a3WexzwtQs1UCUcv6z5hOqGvqGGZFCcNo1ySJQJ6XKe7YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306045; c=relaxed/simple;
	bh=WdroyOoz3RZpbLms13oaAXY13irkPiQXyiw+EQbrm1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QDsw+03/RQ8faPbzgaV6bw+4fjzY+H4tsnIJycQRVc85cuCZMmRORPyO8jhKziWPyq2n58gUiuhez+QnLLrRwjAaKH+B7vCEQxp6tvJpoe3mZ6icekGY+qLF9tgPlcOoVpsiDaAg1DxBfvdWrveqLUMNZRyBe0oc8gvfefmM6lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P2cRppam; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P2cRppam"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUBqBYoV/uCyGSLWTD2N1e2V9/N+Ef9WcFieX8Ju+1hmFNsHaAzYC6KlLuAPMZxO3AcKQ2zQNHBIHENfX/7j6cXBdkHO1cAX/zVTVm6a9n5xH9ew1s2224VHmLRg+zCyAmyDaSySG/salMn181p33BeJDNaDrlgqLVgl1wBUh1vabCRkckHm4UobfH8YX5XztfKi4INE9GDGYO3DjYUEQo9AH+lpYnMoy/Dez2bY8AqCRWW6z7orWsHbh3X8dgURGmMLwKhA+EVvfHnemU23mswvr2zLtIiywOiw2pWlTrz9TvDk7sAHssxHR/eljqYFNEX0tMqSqI7pvdzown6t2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvV+CxIN9rjafoiFWzhjsuZYYfJIbwLX5/1gji9cigY=;
 b=kLuDFg5qjqU2PIfA1150Zu5DMiO9SfoDhmVN/UWB/2HSpukIgSrzOatCQcFta924QbMuLReHV9nYm5P/qbqzAoufcZRykqhDCOwhjF3nojBUj63Dz/WcC5NGdhusKGcYKgyZ7Xr1oci7ejC4icaPncLmg7uwlQmuAocz5ND4tx22HWId0PjZiUAXYfjoMnsw8m5+3xIl9L9egLCxIi2HM7M6Ggoejrg3ci3bE7f1w3hCifUCY8A7ZZoBMUaS9fTx7vwN5cl8pE1pwrGmQzvKmb7aRdx+Gxf1FvB+SEkgCJ4449I5AQihJVQvyB8tgb/7hboXU44JAjynvSKvYWrFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvV+CxIN9rjafoiFWzhjsuZYYfJIbwLX5/1gji9cigY=;
 b=P2cRppame/Z9rqaJU+yNwjD7TcLRM74Qn6g0xBrIXJwugY1Sqj373No9GPuSSh92ZEHwC67Q6xSlF8h3/k9Yj3fLYUd76mDqKgkGNYPES/E0OMgOZJiL3ttbcSQ4Wx61HXRZVg3lVagr0yiO9bOxYJ+RPO0EB0m5EvPAF1phI6cPsTdJri61D3zZqgJnqbF2ak4MYuS1N6Fl0GPQsI502xdGijnpUtt5y/DJbiU/1n8S3x4IXsoXj37xx0Oay5liYRAvA3fBxTqnyHMT7DoXveBQoGdOz+k1apcWaJNOnZ23mZG9wYm5f8P8K1h331FIkaK0cczOfLeeMjhDQCpfpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 11:40:40 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:40:40 +0000
Date: Fri, 24 Oct 2025 08:40:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in
 IOMMU page tables
Message-ID: <20251024114039.GA847003@nvidia.com>
References: <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251023160154.GM262900@nvidia.com>
 <SI2PR01MB4393D52AD53469388BED8E6CDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393D52AD53469388BED8E6CDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: MN2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:d4::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 477321a5-3cc9-4b52-04f0-08de12f22886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xgnStQL4d6L/p8ggJt5zdj7F5meoMDE3ZjEYPG0YPfuwa7EQ24luhSN1u6e2?=
 =?us-ascii?Q?hcQ+LK/OCPwcNDqL7MWgwXCmbPpjkjxG0X7Oy72QcBIiE3uGvULFz5ebTWM6?=
 =?us-ascii?Q?lUuiovvKmAVb7K/PK/ndWbu7V3L1Q+cmOKR76n37q/hh1B9VXVsgYlmUfc5r?=
 =?us-ascii?Q?oviTu5wx94YgUMh8Jaz+5j4MeyfDTEVTI+7cC+CErEf/mNzvCxU8xz5+f6I9?=
 =?us-ascii?Q?BalpaFafEp5WfVa2MOGhuNYdkwzg6QVbUo/SiwEIBY8r25AtoFsb1YRsTL5u?=
 =?us-ascii?Q?SzMVpcqHhLBKy5Fz3cNLo60Jra/Q+ary/GP+XE8zW4ocI7A74NP5IAE9gP6g?=
 =?us-ascii?Q?gQySgPGgM96joeBbJGFrr1uRZYQKtcx7tzsmsglVMx/rX1qYZs2d5pL3RS5r?=
 =?us-ascii?Q?zjn4ddvZq7TocCvc7MTES1X0DORrIDIINt4BNPnqMuj368ARAGTM63suQkS4?=
 =?us-ascii?Q?3k1sr5MQuX+q8olTnCnvHb0i5paglV50q6Bm1v+IUDtGVndkFkY/56JI8XTj?=
 =?us-ascii?Q?W3frcSO/Abx+ABWOKraKlffdkFHoMYAQo9iWQKuS728ef8TyerchSGBP5vXv?=
 =?us-ascii?Q?iwrMqcLxOP7W9jx7BrwnAb9PKc74A9n1QvQL85Vz7u5g6tQKY91xDxyB4gEM?=
 =?us-ascii?Q?RrnJ+aiUNkaXQUEy/hRtRBQwcP7D+60cLRZZGtjEhc6D8PqplUwUwWapfxY2?=
 =?us-ascii?Q?kmmj1rcavGivPNZru8wRIv9dz/Sh95HpCL7v/vNo2qLjJ4E/65wr2IUKOWWh?=
 =?us-ascii?Q?dFP9y+2yiR4hu+T51otSvWc/cxTU9eh7kMHbnZ1OUy1ruQ9jAsOVwxs8kbqr?=
 =?us-ascii?Q?ooT42NO3jKlxBZe33Nu0iY4k3yuWFWZZW34ssy32gPpfNTJQycgy/VfzwWcW?=
 =?us-ascii?Q?aSPhrbNkdn6YBOrDd5gNK7ALEPaeJpG3+Z7RU4UsL/d9ZMr6gVvVmozozc8L?=
 =?us-ascii?Q?hj3wvaPeEFRa0zeTRLNqVHl5Bk7v3TJKOyzeY4YnYXKqE4ouiAD5QP3ByHu2?=
 =?us-ascii?Q?Cktn+OFa3FxiuKOygLn0nygtm0Mba4TDFLbxkSKLPAqv/1oWaJaFSFjk1EFx?=
 =?us-ascii?Q?QIdnDpl38tRWd3hqyUtdrJTBe1uqHexDwn86boXpH6jzIpOuWurdplbPMrcX?=
 =?us-ascii?Q?NCxbIe0g3sZAObmF61ZR1Dcq2SyvyULD/Ni5MEbSF5/D0EL3L7v2MY/azomE?=
 =?us-ascii?Q?393XtNDBtZGw+svECv3mK0WG6Iw4jEXcOzfJX9aLDbm4yAd4Xj/3U8VjDPH9?=
 =?us-ascii?Q?LUQqmYfaLgQQxNW63bB5hxPOaUplMSNq98FvHvJvTHnP+RZvdzQfXVmmzPaa?=
 =?us-ascii?Q?Fh4Fs3FPTTo8+3TuWu74d6JIzvTOo4EZpgPBmnqHemwMnNNhjJRSFX/IzFZk?=
 =?us-ascii?Q?8auZGphfX35/O+fMebuK2AIz7lnVnOC6kXGQVekGX6q52qupu+QVFyL5+UQ3?=
 =?us-ascii?Q?VSWijaWEfKJhJvFPo+rl33S4r1zi2qg7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWiKYl7aIMnKclV2CjnWQ4SuN8PJ25uvIw1/qS68YpbsdC15mhyKan4OeCRp?=
 =?us-ascii?Q?gow0t9M6bQSJ+Y4zGKDWzaohFUQTMzwaadLM2bdaS0pkwHuUBULXnH+g80NQ?=
 =?us-ascii?Q?Pl8nZqaClFXHH97MGUkhJRIG75d+tsQTYKV/r13S5UeW/1ydFmdIBHxog+yZ?=
 =?us-ascii?Q?Qc22P2h7YVDtagJaiR3A8NQvCQk0tezB/TvfBdMvhmcPyJyoHFMocqauRoMH?=
 =?us-ascii?Q?O/E4WJh+E7HYKFWOOW3orjr9YVIbVWUC+cR9YuHTLcYTRGB9bxd/5a+a7Ed+?=
 =?us-ascii?Q?gwu90+UASj9OE24odA8lGqepjbm+MOQL1fePp1+VN2qarXSmkQAaIVU+KxJO?=
 =?us-ascii?Q?IPE8ASXD84zdSy960nf+tW76POeOd385yLcLLq82qLs2DtJPwMZCuwC0nqY0?=
 =?us-ascii?Q?yhR3+1Z++h2lliIOKugod0piK1yVRCQxW/8eBfgR3a/T75jZ4kBFAmF3B65/?=
 =?us-ascii?Q?A+KuAoiJqzT7CnpjeV2ThKbA+sphDIQldrppvTJOT0XTBuUaTLEnOtMeD3ZP?=
 =?us-ascii?Q?soLPaZunXZj7/aJXPp0+CMOJQTsZ6seuDi5liyXxSrRzwsKEGY8FzOGYL3Q5?=
 =?us-ascii?Q?Z6cFfdT+u+sISBcMnXrIRtqHsgj7t5Fue8sUycrt7lK3qPhAPxRxC0HJRVCN?=
 =?us-ascii?Q?EguOpv1Yz1+HAMJcWj5Ot9sch3hUmtoY/lFUv50Hti9/QY+bkJ9l7GJLcGnv?=
 =?us-ascii?Q?wkif3EQ93fyZvy7DRH3/99tv/AmQvgCZWjknl8aOKEHIm4ukj7quDLwrS8vK?=
 =?us-ascii?Q?gHqkmP+sisDvuAK3UhWolmOhgjfhEZNCPjQmpbS/vI+GHGGBQYK1xLpBCMl7?=
 =?us-ascii?Q?Au8gIDAgt4l9KKk1m6lvfq0jYqlQ8rMDDnx7ekfRm2sN+7rsKPKZ7Sw0JFiU?=
 =?us-ascii?Q?S76a5/KnZfZXmXA5m7R9P1zfSgqcd6dKxy275f+IWTY22wfZ2irJ/2wOCPM1?=
 =?us-ascii?Q?mWEBHupJMBF8Eb5T/iDZIV9MmQUadBQ1XdfzYTbSm7przK0pai3CjO50MS8S?=
 =?us-ascii?Q?e0aGDGCEJzhwcaBBL6e5WD0jeGaEPZvsEPCfi7eqRIHThcif/MCIrcRnsAc+?=
 =?us-ascii?Q?bVuW5MK42er374jGfCOkfB7PQYNncylmkMEQAo6erXcozYntnBHM/gaaYNn5?=
 =?us-ascii?Q?u5Vj9wnK+I1pvfdNrj5+tKlexyDQGbEfDdoag7AJT7tXDPXjexlT62JtE+4q?=
 =?us-ascii?Q?aTeNSaJhsf8tyJhVkurO7BN0uxmy9/QWrEFpEDYQUXzgu7HxGn4gkaVtalJ5?=
 =?us-ascii?Q?GGsqg7RGJRf1zQHfG7rDWPVEg/oPEckkhMSpIb8mus0zk/H7WAvAX1P/oV1Q?=
 =?us-ascii?Q?uobBzDVFnK2ceXc5hkyuUxLhe9Ma9ugVE+7VIGu0BpOxJ+ygSrIssjD3zDKv?=
 =?us-ascii?Q?hJpgjOFBDRPik+251qSWV80i586/9mC5IB7kbhhrlSRZrVDQ+7hnpDHF4/fr?=
 =?us-ascii?Q?KotskeHOtvGqvrW7ervEJTE4GLr4AEl/9JaYcXlHgrg54cBCWrRarRM7/uJ0?=
 =?us-ascii?Q?HrLY/E0jLVZxjCW2E3pOs80WTTYKElauZewDabNAI29g4o51967KDKpNARXF?=
 =?us-ascii?Q?VVvMVTakSaTEPiKNhgm4GP35Lkv5sFvAYTy5FOoF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477321a5-3cc9-4b52-04f0-08de12f22886
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 11:40:40.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFXMb+ts5c/nREbWLNr35QpYod+xmybMggGJsFhGievywaQOArUeNR+K4PTpLDrC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

On Fri, Oct 24, 2025 at 03:05:05AM +0000, Wei Wang wrote:
> On Friday, October 24, 2025 12:02 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 23, 2025 at 11:15:43PM +0800, Wei Wang wrote:
> > > When SME is enabled, iommu_v1_map_pages() currently sets the C-bit for
> > > all physical addresses. This is correct for RAM, since the C-bit is
> > > required by SME to indicate encrypted memory and ensure proper
> > > encryption/decryption.
> > >
> > > However, applying the C-bit to MMIO addresses is incorrect. Devices
> > > and PCIe switches do not interpret the C-bit currently, and doing so
> > > can break PCIe peer-to-peer communication. To avoid this, only set the
> > > C-bit when the physical address is backed by RAM, and leave MMIO
> > mappings unchanged.
> > >
> > > Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with
> > > memory encryption")
> > > Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> > > ---
> > >  drivers/iommu/amd/io_pgtable.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/amd/io_pgtable.c
> > > b/drivers/iommu/amd/io_pgtable.c index 70c2f5b1631b..6f395940d0a4
> > > 100644
> > > --- a/drivers/iommu/amd/io_pgtable.c
> > > +++ b/drivers/iommu/amd/io_pgtable.c
> > > @@ -353,6 +353,9 @@ static int iommu_v1_map_pages(struct
> > io_pgtable_ops *ops, unsigned long iova,
> > >  	if (!(prot & IOMMU_PROT_MASK))
> > >  		goto out;
> > >
> > > +	if (sme_me_mask && page_is_ram(PHYS_PFN(paddr)))
> > > +		paddr = __sme_set(paddr);
> > 
> > It needs to use the IOMMU_MMIO flag not page_is_ram, which I think got
> > mangled by the time it reached here..
> 
> Could you please elaborate how page_is_ram() would be mangled when
> reaching here?

Sorry not page_is_ram(), but prot - it starts out with something that
had IOMMU_MMIO and got mangled.

> > Though broadly this points to a larger problem, the iommu domain code
> > should not be trying to guess if a mapping is private or not, this needs to be
> > passed in from higher level code which knows what state the PFN is..
> 
> Please note that this patch is not intended to add an interface allowing users
> to specify whether a requested physical address is expected to be mapped as
> Private or not. Instead, it implements a sanity or correctness check
> within the

It is not a santiy check, a sanity check would fail the mapping. This
is changing what PTE is created by trying to guess properties about
the pfn.

> IOMMU driver to validate whether a user-supplied address _can_ be mapped
> with the Private bit (RAM is the case that "can" currently, and since the driver
> can already determine whether a PFN is RAM or not, I'm not sure why it needs
> an interface for users to tell the driver).

As I understand AMD's architecture the hypervisor runs with all ram as
encrypted and has to set the C bit for any dram. The MMIO is only
protected by the RMP and does not have a C bit set.

So even in a TDISP world with private MMIO we still end up with
system DRAM being treated differently than MMIO.

It really does seem like IOMMU_MMIO is the right direction here.

Again we should not be trying to guess if something is "ram" or not
deep inside the iommu code. We have IOMMU_MMIO specifically to tell
the iommu if it is ram or not.

Jason
