Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794829361;
	b=42JDgPs3efB2bFvfXDlMdkWm22JoxWVT2rS/zzqqRrs3+9HZp/OJ6jX88nLEa1a7vYEh
	 I7tv3FPFTO5Srh8vT2VONJtqLXSvlxBg+B2sMVNjQn295qM4A3nSoTNy8X6npajTLuQKc
	 Phk6Vh33ZtJyCrm/PFZ4wZectZ7EWqTMONRn1U6j7TPwraGU1AVNe4L0Lp8jq26qDqEZJ
	 MIKs1PFikBjG0amx6ZVvTrJbTSjwCGUPDlzNRrv9s9jPsGFvBIWvgZIpPLI8BazKBBn8t
	 a2Kbjc0TSKHLv6N6b4hz1ov6LAI99wZ9LgoMQYOGtdYDFJQH72dCnnUVZs5yk+79a/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829361;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/NAQovNZKteCUZpo1rbO0tQN7leKbAZusFbZTkugjpw=;
	b=oElBZ4SVua5TeFoPyhfoBoyB4fRfZRm5paC55PhRlSnUtzHLzUok3oqT4xc/nxfTQoQq
	 4q9v2IwacIkowNNqM1y1Y5J33hoZA19qflFon6qzXBypqv3KNFZKzT/VS2Sb4VmHb4FKQ
	 2DRX04EdquN/gNQFjEdeiMHBh1xhhuSBhgxpR5/SLOe2UXQtAzzfKgKSZ4Sur6UDZcfNv
	 IDTbCRYtglQeLSoFXeg34n2wsfWaEtX3t6wSP5e9WH/Sth349D1xfz8xsQI1qNHzCOJap
	 JJ8Y0mptkSEj0apJCaGG5GZmeaBKgb4ozPSY0MPGhXEb9RySG1XebbSxDbPMgsW3MLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oHemCEWV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA1606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCA1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oHemCEWV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC6ou19eRuucudU3W//vlzRYPxjmtox97JbRrQ+/STUH0nojNNJ+ihXCMlz6c8BsyRquUz/8IPQ8A8W4XNdBBXggDjnKqSUCKInfNYLo3tifSaBiCI1BJGvvZCRAy3RBDHOknWKz3QLSTjxgWIrRoZpgy/F9gGl1WviR/mE1Ffxd2LkGKpW0Qu20cLPmnWHP5SZV0sRl9gvlnravP//SomLLQ6xleuoEPt7eLKU9kRKOx9Ke8/Vr5p+hnA9jh3lZ4OjGAm5HjSub6ia7xnny6GC97fNgsFWEJCAdSBJ05XjrmViPuVEsj45BcMvbVcLlAZMOmwUpNWGxNGGYp+l0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NAQovNZKteCUZpo1rbO0tQN7leKbAZusFbZTkugjpw=;
 b=VdZ0PlOE1vTV9KUvC9i76mQc6L5r/mVm8WJMCfwcTPRPzDBEqa9oMk/JBGpyOCLm3UsVkhWJw0enlbr9lQ6tCx3FFpsjJnKpjx0SHVQes48akoUBD3CJRaunbuL/dfszpJ2nE5hW6JcGo+QABGCs+R8hDDsd1msrHTrBwOa5skWwthDbGrsO960C/Tq84gIHOG+/DwWUIaENaUEMG+Axhq4puzHLn2GfitC4DbAFj9RIsWqgY565RicO4xUn4UTAVD5FE2COsfM9ecPC/3cLDKsGZUs2W/tKCz7ntTPIk1VSg/k0YbZ1qj3fcF9d3QA4H1uHPY7rI3nHl425Euf6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NAQovNZKteCUZpo1rbO0tQN7leKbAZusFbZTkugjpw=;
 b=oHemCEWVlABSgV9YZXuuYmjmMaKm4g1zYDoDqeZaEgTMohOsKIpHVDIeNpDgPgGE9k/N36gqF3y83Qe84IVf16il7t44ntZMuXWBRlJNdMAW1NL26eEHB+a+FLIE+NrjsmiE9MBHfKAQwRoAHGG0Ks95+SmmGCkn40VLdorqvkE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 by SA3PR12MB307772.namprd12.prod.outlook.com (2603:10b6:806:516::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:42:36 +0000
Received: from SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0]) by SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 11:42:36 +0000
Date: Mon, 16 Nov 2026 11:42:25 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: joro@8bytes.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Do not clear unobserved log overflow status
 bits
Message-ID: <6d4szg5y2okmq3p3adtztynxbdthftw72mmh4robipjsbqjulm@uvod3zhsrxs6>
References: <20261116033902.3277875-1-guanghuifeng@linux.alibaba.com>
 <l6vwegv7ju3csy6calsdhdoxvu7tq3eza4wmujtdd2yno5lykw@tzhh53fljavd>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l6vwegv7ju3csy6calsdhdoxvu7tq3eza4wmujtdd2yno5lykw@tzhh53fljavd>
X-ClientProxiedBy: MA5PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::9) To SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6837:EE_|SA3PR12MB307772:EE_
X-MS-Office365-Filtering-Correlation-Id: 23425472-2820-4b7e-9699-08df43d6b5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	nxn+l4pnl1Sco71USuPU6FCNGfrWubylR37KQHKvNmvCFB3lBOTmRokEZDs1IULBNYD29bt4s+f1jOOHSV2Q8P+iT7+rdF4UfrStaPRQykIjhE5FMbBtMKsYlx3X/L0e/MLfk0Wf1PxSO0vC0rFcCxMCVv8Gqdf5PV7QXIxYEWlSONy1pNDn5KL/o4FT//LZ0yfc4erwvQP/9aUNtEaRa6RBQT0BavgSqy/jNAVsQwRdWKWzltXR+Vn3qxoBqKTdhD8EGcIUReGhB27y4Kc0XxfvxtfCRsc81LXwjG9A1NmLr/w9xj0lopuEyabcAkPsYio3pc4deDMKzqEhCI74/NjpCtsREzBW758AWxzEn4sJOOZtLrbDRg70v5ocbKc52gtAruqR/FDn6wY8UImdbapYm6ofaeEZzyy7exNaBgyIwknf5IuzAFLjDSbybFZxq2woPGmV8DsoBC9ZAM97Or8/QMXU+09asFQnSn41Vk/cZJVzO7A35POqZRCRLdAxJ/6t02VQCFfXz6HQUjhqNJK5O8S5Oiw2ZR+qSNDA+7pg6EGwjq89FQ6aFtUBH99WIfY4yYQte0CSeyQLeFpE8A1G/WNh73SDTqTDk+ad03h4jvHeG75bRa/VTVvMvFJ3aMzLgKCpAn0M33fnsfSAs9OyfgL3EsvFFdQzI0H2xj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6837.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/e4lDaJRq9WoL/bgVNJPnHPBMr9tYnltjW/RRHRVgd83rIWzX9XM2YGRWbew?=
 =?us-ascii?Q?ehG5QCwXhcMyo2k+VrBB5wWQfJ0bZM3+6Y6D/+O2+B5Q0gKPDY7vfaFXU++P?=
 =?us-ascii?Q?jdTay9wKMUnkQ5MejFltj8Bes9036eaeXcPp0Gzo39Ghi53++0ooTkTL+Inx?=
 =?us-ascii?Q?Kv3F3p+vP6gLwncmn9QGrbGAMT2S58FWvbkB6y7hox3y/Sotsh1R5cDnvm3p?=
 =?us-ascii?Q?ZpD32e+ugmC4TkSEF2Lc+eRmsdgGVb9UM9DUyroQQ5ag0oYYEiFrT7monfqD?=
 =?us-ascii?Q?4wqXjGygZgXZj+QjbBz3Xy4XixwJYTL0zayOR7WulfYf+FzUN7LrNilTLaH8?=
 =?us-ascii?Q?i/vWF+44MFFkU5QBrpjIuO4pmQ2fvWFFhEBmFvQEtuoshzmZFnUBljfesFbQ?=
 =?us-ascii?Q?8QRWZTeJpOmJeOUbYs3sJN1H2l3JPelE5T6WC341Mg11yNWEMKGtdk5+lKPR?=
 =?us-ascii?Q?wq2QSrY1Jt0FFveN5gQeskxN1XfG/JxTZiORl6qWM9kv33YsMHWqBwygLy8U?=
 =?us-ascii?Q?Lmp7L1/j2MSB+wDiLC4MlvBFH5EDAVLu3OgmQxx64Ai0nZoGlavc2sOH6erg?=
 =?us-ascii?Q?gjU1kqkrX36jbksYyrXTPWKBEZl9oGt5P6cbK1BajlrKL0W358AhZ7+eLZp1?=
 =?us-ascii?Q?zPtC5EFG0P2ZlNQpwcgxwmTg4+jxlskzPV4XFN0s4TIf87PVGRQWlc3PPlBa?=
 =?us-ascii?Q?zyRbHeKxLSxTKge8cjZob5M/hcy58Ob4NSwKvyY29DJ2pECYzagnjxzm1d/Y?=
 =?us-ascii?Q?r/nEz9MXgBeZQzyFvjA/uH1RLfvVREk59sq63knGLiCspSd0WuMVKkkP7TY/?=
 =?us-ascii?Q?zCg9QNqyMehZAc46aPhLDHc7s0YBL1WSZssJ/DKYVw2w8QXxNS2jIQXpni6r?=
 =?us-ascii?Q?TAgzTqMKxdBi90mMfWvycTdt+/sSyEHLnqVSIWju3Tmg4hm+8MCmpEIZ1b1S?=
 =?us-ascii?Q?v3Y7SMBb8qbNuPNfeDO3Bz/rRebWU33ZUoMhHhHSvi9H+yDjQw2RLhSFQfdI?=
 =?us-ascii?Q?Iz2wdG3Lb2ZpDCaSa4f5Y+/WHlMDdpyvVwb4rwnnKlu+Dqr+sVpUwLMiFXMl?=
 =?us-ascii?Q?JrRctX9t/rfyomo0ee7A9gsbpTOQ+QwsLPzeKNbCmo+HCLqkEE/Y1Zplqyrq?=
 =?us-ascii?Q?JigTWD4IJzNf1Wg6aBri3yZREXU3NKGcsRtb31ghr07Z2hP0/BERQs/RLzxU?=
 =?us-ascii?Q?0m+oQDzwt+RrWALVGEYqDvGoVy84J3kVk1dIYNwWmEBc9fVgB7LxLEarpzA3?=
 =?us-ascii?Q?0XeJrb5+Pqd9jzR62PuJ31jNXL/lbuKW95QxXDLGcQUBDH87Ens1fiCGbKQG?=
 =?us-ascii?Q?/U+f3YgfftyShfiVyAJxemNwbrlDv51U9XtLyps2sXYui5U9SJMBuXlpif2x?=
 =?us-ascii?Q?ZzvstAVXqy+c2ZO+Imfd7EWWhBrHHoepbvOhqMK9RW4qr6Y5q/U687eajRIJ?=
 =?us-ascii?Q?czNuNbUovVY4BHH1x7da72uCLw/GTQZVPf3Y8YMTcUvImjx9UGA1H0nyFNS6?=
 =?us-ascii?Q?WU/4S92gdqFU++NY1epgCEKaEByl0oUMTT0+cxHl9/vrI/nQNHE7bPzoEN0R?=
 =?us-ascii?Q?AMa3ZA1U6hLCrXRYrp5/6BYKiWIiG03z5oW536MVdQSMKTU+Hn3yX/iH/8zC?=
 =?us-ascii?Q?ITYT0+idPdG7Aa5ugotLeiWb/x9sENbS0Hw4hSF6uyclDHm35PPFxHLGMU5A?=
 =?us-ascii?Q?dGZmC9OUWxa+hVE3cg92PHMHDLw1D9xQCFfyDx2GuNWLo90v/FTn8njtTFg5?=
 =?us-ascii?Q?/K/fxScg9A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23425472-2820-4b7e-9699-08df43d6b5d8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6837.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:42:36.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvWEZ//oWbBWA2eT7OrbQtCki4MzdSn1GvZAo3kUu4gvq6f9f1lnIyKEbrHV19hlTCePsVDkqr2mFJ9Yk43sMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB307772


Sorry for spamming, internal server issue which blocked reply to
external mails temporarily, because of which i couldnt see my replies
on lore so resent it thrice.

-Ankit

On Mon, Nov 16, 2026 at 11:19:55AM +0000, Ankit Soni wrote:
> On Mon, Nov 16, 2026 at 11:39:02AM +0800, Guanghui Feng wrote:
> > amd_iommu_handle_irq() clears the interrupt status with an unconditional
> > writel(mask, MMIO_STATUS_OFFSET), where mask is int_mask | overflow_mask.
> > The log overflow status bits (GALOverflow, EventOverflow, PprOverflow)
> > are RW1C and, per the AMD IOMMU spec, transitioning them from 0 to 1 does
> > not itself generate an interrupt; they can only be observed by an IRQ
> > round triggered by the corresponding log-interrupt bit.
> > 
> > If hardware sets an overflow bit after the status register is sampled at
> > the top of the loop but before the unconditional writel(), that write
> > clears the freshly-set bit while the stale sampled status does not
> > contain it, so overflow_handler() is skipped for an overflow that really
> > happened. For the GA log this is fatal: amd_iommu_restart_ga_log() is the
> > only recovery path, and per spec section 2.7.4 logging stays halted until
> > GALogEn is toggled. A bare W1C of GALOverflow is not part of the
> > documented recovery, so the GA log stays halted, no further entries are
> > written, GAInt never re-asserts and the GA log interrupt line goes
> > permanently silent, losing all AVIC non-running vCPU wakeups on that
> > IOMMU.
> > 
> > Clear only the bits actually observed this round by writing status & mask
> > instead of mask. An overflow bit set concurrently is then left asserted
> > and is picked up by the existing ERBT1312 status read-back at the bottom
> > of the loop, which re-enters the loop and runs overflow_handler().
> > 
> > Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")
> 
> This commit only moved the existing clear into amd_iommu_handle_irq(). The
> unconditional write already cleared overflow bits before that refactor.
> The first commit that put an overflow bit into that write is:
> 
> Fixes: 5ce97f4ec5e0 ("iommu/amd: Recover from event log overflow")
> 
> The GA and PPR overflow bits were added later, by af47b0a24058
> ("iommu/amd: Handle GALog overflows") and 274c2218b8b2 ("iommu/amd: Handle
> PPR log overflow").
> 
> Otherwise, patch looks good to me.
> 
> Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
> 
> Thanks,
> Ankit
> 
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index d0d55c93a480..39254671b924 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -1168,8 +1168,17 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
> >  	u32 mask = int_mask | overflow_mask;
> >  
> >  	while (status & mask) {
> > -		/* Enable interrupt sources again */
> > -		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> > +		/*
> > +		 * Clear only the status bits observed in this round.  The log
> > +		 * overflow bits (GALOverflow/EventOverflow/PprOverflow) are RW1C
> > +		 * and do not raise an interrupt on their own; clearing them
> > +		 * unconditionally here would drop an overflow that hardware set
> > +		 * between the readl() above and this write, without ever running
> > +		 * overflow_handler().  Leaving such a bit asserted lets the
> > +		 * existing ERBT1312 read-back below re-observe it and re-enter
> > +		 * the loop so overflow_handler() runs.
> > +		 */
> > +		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> >  
> >  		if (int_handler) {
> >  			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
> > -- 
> > 2.43.7
> > 
