Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2336B064
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482429; cv=fail; b=bKMor8wEZriUUBW3CGrZLdykZEN48hYHR7mfM8gBDbe5msCxJPvK+k++emC9lz4BH0E08Bojs1CEzp0xmhYEG1DMKrLaQfhQrQWXgEI/xxbHDawSciQo+vZhBsYzVpjCC76EIc6sFhzAr3WSUbL/KtuinvdZxs+Ec7k1c0ArC0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482429; c=relaxed/simple;
	bh=hJ9xLjlYn9NgU/x8AXI61LjeXA3BTkcdPnbKkfmKIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfUhQITAEqwq63rS8qtVmRGa+u3217Y2pF9JzqcnS/C4VC5TKkMKPrRSufdJa2sYElgckKpfzaMPaPlfbhX/DDjt0gVRMn1ZeHOe3bhrN1mK+wq9nauQnsZkPbK+cZSspbUfKtEcmGGHOHEpZ5LYsgUQRkCnzTsKkvC0fI6j4w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=She2gTZU; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="She2gTZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MASgJPvNT9l/XvHTlRt7Dk07n8YTqeYAeiEp/l3BCs9TAozKXm06U8YJDSxbxygQKRvucYAndM+MHkMeozgWJ17r9+V28n47vbuHXZBqINv3CptSmekrQkcfWbwYqcexBISD9UNT4oR2cnfK8R6CI5nreP9uz7lSQMen02J59mz0pyW1Z9ayarQGoUt6NIYxQurbmYEI9yym1y2cPXhrv6eowQRQEKj9KvMwNJR3HDLSFfky1iV9iqYeM733mlAD1PVVkTmXCJou9hcvkAGBIedm9LdcV/B8TINP3oaJghU3IJLIHpFGX+240h0tW6pfX78FT0sfxtpgLlFapCVcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNJ/nxP5e1BuYRfF8S149Xf7027KiebfRSfZlxIZdDs=;
 b=Oy1Uk6o6jnUUjB0+RYBWhbJJcT3Rf8Rw06IUv0Wlspf4fuVBDi2JG51czrEoFBtpf8WHYi5mgAfrfWo+dFau6GLZq5+JEaAjWwoqIuTd0QdAIncDtD0njmRrBOlwEpquwQ4bAhKZhBX9cd9S38U3/YspOa1qhVqE2BA6B8rK15BPDvb2IXNnV2DqkgoUoBGQD+JF59mS5QgRVJbXAnDybocVKTF6gWckQIkjI0g6hDl6cKXzF903FV+Ris9o0rKWa9naEKx6/DOuQZtQVDVo8WHBtCuFPvwmcykBh2SZL2RUJiTas1g3r5SOSuJXc0L7vBn6hBvrB2rNu6vFW6aKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNJ/nxP5e1BuYRfF8S149Xf7027KiebfRSfZlxIZdDs=;
 b=She2gTZU/giUY2+wc7OQGIBL1ZT5E/IGD0g3VmrsoW+k2TP8JniGAQX9x8EmsIaCmN5Q9AHOxTY5yEm7sCQmQrT7bPPlg7u4rKqGcl4D8oK1nfGBpltTW3r+LfcFVQqoARihpSVR1fw5HrP0YIxhJ1wf+7z8KkFYpPsJ1mzM9Q7ZhCv3xlyzJwNgy2HgVtpi9J/xs7UgMkNkZXEPpf8Gnk/RN/ZfpDZ5APPa234+tfaoss6JYFEOmaY2VnhTgiN3zO7ZVbeLP/pBVFvfI3+kyO5RWuidQnbFsfW4XAYXMiuQMBMr4/IhasllqnZFiB+WOWxcTjTZULl48Q46FbpXZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 16:13:43 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 16:13:43 +0000
Date: Tue, 18 Nov 2025 12:13:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>, matthew.auld@intel.com,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: REGRESSION on linux-next (next-20251106)
Message-ID: <20251118161341.GC90703@nvidia.com>
References: <4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com>
 <20251118012944.GA60885@nvidia.com>
 <a79fe616-52c7-4fa5-906c-382b5ff2226c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79fe616-52c7-4fa5-906c-382b5ff2226c@intel.com>
X-ClientProxiedBy: BN1PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:408:e1::14) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a83626-5906-4a69-0e4a-08de26bd7194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODsbpvri1MAGNnsNdy2Ny5viIKUz+0bCclf/uoWrI5PU04p5kRYnjPyt1KlQ?=
 =?us-ascii?Q?tcaAXYf1bp95pU1mJXsay/hBshCV/rZ8MBUVDCsClbsY2n1x/e7dHKQAo7ur?=
 =?us-ascii?Q?QJ0N5YOEQ2yE10IkIx/sYlhjS2LVBYMHG8i+rCiXz0l08iKiNF4Aszw02vsG?=
 =?us-ascii?Q?IwGgLXrZZnfmegVepBIxvIPUDH0CrsMFXUD0ArGSPIu2YK0xE75txMwPZ2wG?=
 =?us-ascii?Q?317VgQMEL5NEzsuwmdpOq6tofMpf56UytgVLjPzl12AaK9Mv6n1woggA8ZxX?=
 =?us-ascii?Q?ItrbIUhQv+v6XZQjA/xsCEl7zLYUD581KNyi5XM9PJNiEr5W/Yo6mMxGCE4g?=
 =?us-ascii?Q?vuZ74a1ZBU2HdGbcn/+znXpKOPdH50HkQIyldyCHBosHng5y8Xw/ggshPnPa?=
 =?us-ascii?Q?0GEATFGuaan7GnCiMiewMfRqYC/d23baPc1ffjk9ffsRVb6cSCgBVXNvFsT/?=
 =?us-ascii?Q?Ka3lNdLxADBdqIdM9yCg6HIqlS75rwUBhqq2pPLloBAF/hMGAB1kM/VNiLz4?=
 =?us-ascii?Q?CYJvqt/e0YiMyGvbc9PsEy+tEnLEJQ1rslWyHJ+5Y3zjwoY2lB2aGFZ3sjdP?=
 =?us-ascii?Q?Dp6Iud1UidCls99BcZeW3ZHZFdLu+cWuY2cNpwVeabLY53rtgEtxZOLk4XuO?=
 =?us-ascii?Q?pqodzwogda8U/ma5cWp2kAMYxTBIt8kZinib30i6s6qCTkQbcmRNp6GOjlxA?=
 =?us-ascii?Q?1PjagoIoypTD46Y+S7xh5ZEkkocqY5SoMdhjbOLQEXzn38/7S0DagnvuMwph?=
 =?us-ascii?Q?1gBhdRTeb8CXwohfTctcryfQBUGEMmy0md5a5ZGG52oP6IozHZrKnrX6l1ze?=
 =?us-ascii?Q?yGdLIsj2RwkmgzbUxPHc4E1PYNt/ezj74uRidwbaGdgGuq5MYUbzMW5Hyx29?=
 =?us-ascii?Q?NYwEghCJBJPsGeGHnIZc/v2+jzCghRGNeEj1D2TVwEkEZkbHxk31DEqZCBxD?=
 =?us-ascii?Q?C3TYew/qG/+y8ThhSnSX3tnzl/ErfOrBYUTfw73Dsmj6VphLj11ebXvvz5LI?=
 =?us-ascii?Q?7aP5b+izOKng+0RRhsLFmqdrMPVsrNrU9aJ5UuiO3iPi1xQJBNlOS4bgB9di?=
 =?us-ascii?Q?pOkH8nSl8xAkLDaCYRORUmLpGCNj8z7FVKN0WwTaPGAAvtL0ckSht+M5Tupq?=
 =?us-ascii?Q?bnCgL00yzcT0t8Gk3TZC5RXectqFYFvaHhCLd0v7W41OhoVqDtxAu000S8j0?=
 =?us-ascii?Q?lSpFB97tqR/N6kXxCzDl4DRR+R+LtQimGhQgecupJA0b5nvvuOpAckD1W8DB?=
 =?us-ascii?Q?bxZlonjrNV2Vn/DB21JTp4b16DuNJYAXzV4ClLN0/lSzlmbJCGh+Ec7yoa8x?=
 =?us-ascii?Q?9m/Q8Me0imGcsOqiNHqgG7DhhHjPaQ2Uk0kN8cNOS63vCHyHQwkechZW6kKO?=
 =?us-ascii?Q?rMbgDwIWjkGqeQul3w6/NGKYgRrByEc8tNw9ZPDoY1/ZzVxViPWnZY9CeTXs?=
 =?us-ascii?Q?Rv9Gzhi0TPd6KCu4s/MvQMPwBl8GucU0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CA9fSs5ffyOVDHlXzOd+cmjGLIvWzwrdth1mR2hSlJFvWoVN0dIm1noDyjbs?=
 =?us-ascii?Q?HBnBADz5lNpsLQlzvYSeMppUdh6fytsjABswG6CBqWQ2CWFzBXrF1KgaMlJx?=
 =?us-ascii?Q?+KZ9ttjodCbjTd4v+0zEjUrsqUV5BMO06RxIzR8eGpWkrhSBZCunhM8VZbK8?=
 =?us-ascii?Q?iqE3u6NJL5yEtIZJIczTfGcFndzyP0paKRxGylQ9uu7bJSEARlIrw+Zue0jZ?=
 =?us-ascii?Q?E09TPYY/ln28wr/R/jJv3w9LeolK561NQvPx2Y2Bro21XN8zocJ8XIinrRzG?=
 =?us-ascii?Q?Nyk4KoUx4GcVNIUGyUbwaM0wZqZD3KuVT36r0P7/GH2S0Ub0QmGkhxiHsi/a?=
 =?us-ascii?Q?feb3a4JQIEHJXjT2M58/1/25IOWIzaNZMYkJCG7QWW/XSDxAQvY8fpTMSbq/?=
 =?us-ascii?Q?O9KDs2oWVMV3b+ZnGv1Rn84NDqycdU81NBItydb1yENw0sWRu5NJBgoF4ZQj?=
 =?us-ascii?Q?drdRXaSGiBHiyRXHRkXkhtCmCW15LDOc15uF9tJnHyRHvY9HqIUKKa+wisiN?=
 =?us-ascii?Q?P3BMnvcfTxbb2ncYa2bnm2Op4L2d9VZ1OAGLFHG30/znkAVrqZdwUHfsofAo?=
 =?us-ascii?Q?zYOew0oBohbeJEecM2fxtnADvD42KBUZtzE+FfwP6J4yJB/9AKwpyXncohpM?=
 =?us-ascii?Q?TKNNBLgbSNlTSFWX4/X5vebAYHkFz83dU7tkq6iaa+OOZ/jY2zpknROwzRza?=
 =?us-ascii?Q?9GQb20zT5wxbNOKb2O6VKc+vIrU3iK6PgmMUYdHv9kJWVpTW0Ey8p4FtiHAR?=
 =?us-ascii?Q?7Z6Oq7Aes74zxsmJ6P3OFvQAmYHoKJuEFgTQt1oXkvq81y04fXTX6k7HcVUK?=
 =?us-ascii?Q?9EWvFZbEycJXu4/LwMzEwVgDP/OTxJsf5jOpNZF9P5RuZSZ5CtT3vlR0V+TA?=
 =?us-ascii?Q?R9htnISQtXWNf0vrXAUl4kZ/tFKvtQzlYvNqWP/mVfaXZFVdhC9HKlvtbTpf?=
 =?us-ascii?Q?qIf5yf2OZjfoPpEy/4tItQSNpspUoRCFgm3khdDT1lF/ESrV3osWr0hg8XsP?=
 =?us-ascii?Q?pIa1yoCX/1yaYyIeBoap54CtyLjiCot6wPyrTpPGoZ2Xq923qEEicLf68FHU?=
 =?us-ascii?Q?f9BlM+jK0W5vRWdJeIC8IHlESAoDRQ7rGZ/FXzAXLP/HTA8OpxSh0ecVM+aa?=
 =?us-ascii?Q?AurZ+ZMLQsVvrZiBpOo+H1S8MVVscsCWJKfQBZSOy+0BFOQSPKUXIycUM4DD?=
 =?us-ascii?Q?IYWGo/Lk6dIKs8SF0tMT8BOD5A9IL6WNehB+Q4LbowtInlwka4pmYjRQI2zD?=
 =?us-ascii?Q?tcLHeysGANXdur7bnAj/Po6WKVb7h4AuFxcwq9R9aOCgeZQTcDgzRSG45GpU?=
 =?us-ascii?Q?wRXP15OeqnavR7RFJ3zaZoyzpO12ltLj+KXJiRAXRmHyRPWPNYgoKYnKpBUc?=
 =?us-ascii?Q?1Ee7K/xRIVP2kdXGzEGdoCzMYmVXts5Tu0Nxd9L8xqgjRMxvXbmj0NQU1jW6?=
 =?us-ascii?Q?Pe/7ffcP4FAQOJX68ABZ5m7g81Y377/kPfvmCmFuqshGO+DW45OAX2Es2CsB?=
 =?us-ascii?Q?DHmXy9mVodgc4H5qThV9M1xOMpVvQ9acqYWYtiPOEzYic6Y9aeuvG/F70/Vp?=
 =?us-ascii?Q?ZnGeNHYWusY9TfjGajw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a83626-5906-4a69-0e4a-08de26bd7194
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:13:43.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLnc2trh/EHJ4XI7s2C6EuqngkAxVkZc1E2zEwrr4bXVPif6iLlkY+V2mKWhIzJF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543

> Also, the tests fail consistently and are not sporadic.

From these logs I see the below fragment, noting this:

 gem_exec_gttfil-1010    [004] .N...    50.126420: map: IOMMU: iova=0x00003fffffc00000 - 0x0000400000000000 paddr=0x00000001b9400000 size=4194304
                                                                    ^^^^^^^^^^^^^^^^^^^
Which is the high IOVA.. It has bit 45 set. I fed this mapping into
the kunit and it does map successfully.

It is not high enough to get into anything special about sign extend,
the driver sets:

	if (cap_fl5lp_support(iommu->cap))
		cfg.common.hw_max_vasz_lg2 = 57;
	else
		cfg.common.hw_max_vasz_lg2 = 48;

Maybe this code is wrong? Baolu what did you get for this log:

 [   50.126166] i915 0000:00:02.0: Using 46-bit DMA addresses

In your force second stage test? Is it 46? Second stage uses different
code to compute vasz_lg2 and is sensitive to magw:

	if (mgaw >= 48 && (sagaw & BIT(3)))
		return min(57, mgaw);
	else if (mgaw >= 39 && (sagaw & BIT(2)))
		return min(48, mgaw);
	else if (mgaw >= 30 && (sagaw & BIT(1)))
		return min(39, mgaw);

Maybe this is the issue?

I don't know how the GPU works, is that the command buffer that is
getting 'request 6000'

[   50.128337] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: CT: Failed to process request 6000 (-EOPNOTSUPP)

?

Chaitanya, can you collect these two log files from the commit that
works please? Lets see if it uses the same IOVA and same 46 bit limit?

Thanks,
Jason

                                    [   49.064561] [IGT] gem_exec_gttfill: starting subtest basic
[..]
          <idle>-0       [010] ..s1.    50.124236: map: IOMMU: iova=0x00000000ffefa000 - 0x00000000ffefb000 paddr=0x0000000100271000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.124414: map: IOMMU: iova=0x00000000433fc000 - 0x00000000433fd000 paddr=0x0000000128532000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.124598: map: IOMMU: iova=0x000000002ebfc000 - 0x000000002ebfd000 paddr=0x0000000128533000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.124782: map: IOMMU: iova=0x00000000443f9000 - 0x00000000443fa000 paddr=0x0000000128534000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.124966: map: IOMMU: iova=0x000000002dbf9000 - 0x000000002dbfa000 paddr=0x0000000128535000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.125149: map: IOMMU: iova=0x000000002cbfd000 - 0x000000002cbfe000 paddr=0x0000000128536000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.125347: map: IOMMU: iova=0x00000000413fd000 - 0x00000000413fe000 paddr=0x0000000128537000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.125538: map: IOMMU: iova=0x000000001fbfe000 - 0x000000001fbff000 paddr=0x0000000128538000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.125580: i915_request_retire.part.0: 0000:00:02.0 rcs0: fence 18:1034, current 1036 
 gem_exec_gttfil-1010    [004] .....    50.125590: __i915_request_commit: 0000:00:02.0 rcs0: fence 18:1038, current 1036 
 gem_exec_gttfil-1010    [004] D..1.    50.125592: __i915_request_submit: 0000:00:02.0 rcs0: fence 18:1038, current 1036 
   kworker/u64:1-138     [002] .....    50.125600: unmap: IOMMU: iova=0x000000001fbfe000 - 0x000000001fbff000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.125627: unmap: IOMMU: iova=0x00000000413fd000 - 0x00000000413fe000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.125643: unmap: IOMMU: iova=0x000000002cbfd000 - 0x000000002cbfe000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.125659: unmap: IOMMU: iova=0x000000002dbf9000 - 0x000000002dbfa000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.125675: unmap: IOMMU: iova=0x00000000443f9000 - 0x00000000443fa000 size=4096 unmapped_size=4096
                                    [   50.126166] i915 0000:00:02.0: Using 46-bit DMA addresses
 gem_exec_gttfil-1010    [004] .N...    50.126420: map: IOMMU: iova=0x00003fffffc00000 - 0x0000400000000000 paddr=0x00000001b9400000 size=4194304
 gem_exec_gttfil-1010    [004] .....    50.126701: map: IOMMU: iova=0x000000001fbfd000 - 0x000000001fbfe000 paddr=0x0000000128539000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.126892: map: IOMMU: iova=0x000000001fbfc000 - 0x000000001fbfd000 paddr=0x000000012853a000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.127083: map: IOMMU: iova=0x000000002d3fb000 - 0x000000002d3fc000 paddr=0x000000012853b000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.127271: map: IOMMU: iova=0x0000000041bfc000 - 0x0000000041bfd000 paddr=0x000000012853c000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.127467: map: IOMMU: iova=0x000000001dbfc000 - 0x000000001dbfd000 paddr=0x000000012853d000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.127653: map: IOMMU: iova=0x000000001f3fa000 - 0x000000001f3fb000 paddr=0x000000012853e000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.127838: map: IOMMU: iova=0x000000001f3f9000 - 0x000000001f3fa000 paddr=0x000000012853f000 size=4096
 gem_exec_gttfil-1010    [004] .....    50.127877: i915_request_retire.part.0: 0000:00:02.0 rcs0: fence 18:1036, current 1038 
 gem_exec_gttfil-1010    [004] .....    50.127887: __i915_request_commit: 0000:00:02.0 rcs0: fence 18:1040, current 1038 
 gem_exec_gttfil-1010    [004] D..1.    50.127890: __i915_request_submit: 0000:00:02.0 rcs0: fence 18:1040, current 1038 
   kworker/u64:1-138     [002] .....    50.127966: unmap: IOMMU: iova=0x000000001f3f9000 - 0x000000001f3fa000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.127990: unmap: IOMMU: iova=0x000000001f3fa000 - 0x000000001f3fb000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.128006: unmap: IOMMU: iova=0x000000001dbfc000 - 0x000000001dbfd000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.128024: unmap: IOMMU: iova=0x0000000041bfc000 - 0x0000000041bfd000 size=4096 unmapped_size=4096
   kworker/u64:1-138     [002] .....    50.128042: unmap: IOMMU: iova=0x000000002d3fb000 - 0x000000002d3fc000 size=4096 unmapped_size=4096
                                    [   50.128337] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: CT: Failed to process request 6000 (-EOPNOTSUPP)
 gem_exec_gttfil-1010    [004] .....    50.128561: map: IOMMU: iova=0x00003fffff800000 - 0x00003fffffc00000 paddr=0x00000001b9800000 size=4194304
