Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90924212549
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540336; cv=fail; b=kLL4LbhG570k9ARXbIWQ9JJE9ImA/0szss/kYrvQixxrMb6mVqySedJJWgg3hytu6RBvU2lKohZYddEQOzPx+sAR1wKsZlprqW0vGOtXyLEcr5HqQi8dyoIQ16pS5Cv5KoIsk60rxocPngTMUp3V4hsQHz9r4eNz2Jh4AcpI4Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540336; c=relaxed/simple;
	bh=f1DVmQj6fFCoGFtqDRKNtSh98aJT7gwGI/0DhRNG7Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AGpgPP8+xNZ1Mx9siUkT4B5SOeF2ONmxWhyfEuqmnTyeNAZDicoGJ6w1iHLNMVUjO9O+wWl0OwDd3+60rWQvi0k4ontJmFAAgzgLrMiDPbIsULUyG8dlHFGkfoJ0K0GzKmgtH1SFXiQ4P2z1sfHlyCV6+aRrfCBA/n/OqDZhV3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWiu0LaS; arc=fail smtp.client-ip=52.101.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWiu0LaS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pveJkpwbp/qr3LeR+YEgrI9ccM1jOeiNOZxnPl4Kcg9hWPSddrhScPB3y61igO7+uPPMPvc3/aldmKUOj30lumstMzmpA+swqHL/4FwOSKBOijB0uzkJp3/cXXEt0/q3u4tU80y5ty3WEYFLwtJw9RZbzyhH1qUm3W15COmUU+5OwWv8oUAC9aTJ/+lZhyNKQ4OVWApekjYSbzQuAmYoIX9aAl4YaatElIhLdQ/LX0YTPJGtdtNTsX/F7Jlu0nSO2jMiaFpwF3caKCzadOU0A5COOA96Wkj+bPWdjW8sMaE8JqkqkaQoihyIWmUR0AjrgScvy9Z5zW4tOPvnls6fFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOJvyRHng1SpKmMK9rR5qX3xPmvQsgLf77BPgMeM6II=;
 b=tVzDNoTfD2p2wSuCSskX+FH69Bk3Cxmxi5arOXpFuh3xG6C0DBGpvRsJ1EUR5rwAt3d36apjfn2p7W8QymKcgVlo3Hioa8U6OOZ+jrTQGoBvLYDDWjvD8Mlx0y3wqMOIae0F+KhjEgATaql/gXeB5G49qHmd3GzCQoqATFrghCt05xmuxfcZjElwr/krOdmRf67/e3oz+UpXcIbeO4WC8nPAQ76IlWtvM87Cn6Lf/EQZYaDgiuVymM1+r5g1m66J8xwyEmCGux3EQnBFYlbWUSimyh+trGe0SYeHc5021e33N0P5vCm6EGDBlSxHLbu1o2m6SiqGPQmA+qCyJHhhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOJvyRHng1SpKmMK9rR5qX3xPmvQsgLf77BPgMeM6II=;
 b=AWiu0LaSJfkxaGl02sJJsvROdZt9ySfZJ/uU0TdQ6T/zG5hrEMV1h2xOVjbb+z8XW9EtVIRvWGPyP4iNDKJ4JVKkVOqh9RHqI45nZWaQD28EQPRef06at5ZZKqVXqeoHqsXSqvL3G+idszt5pcRiLK9yF3y28KqAiYA5qGrwmEtNMLQByPFvWypuqqUyE9vx+9MyFo6Wueywuaj1Iqgn/btZ12vAJEYgRYiidi5M1+uRr31l4uF+qLGm6jJP0Wl/Agy9aAvDYVJrm85QpOw2x4iS04R4MF43KstB1uvbBnEPiwxcKDy86WSYCf6DhsAoIvNXukTxhuyKKnlY964Zjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 18:32:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 18:32:11 +0000
Date: Fri, 7 Nov 2025 14:32:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wei Wang <wei.w.wang@hotmail.com>,
	"alex@shazbot.org" <alex@shazbot.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <20251107183209.GP1732817@nvidia.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107163614.GN1732817@nvidia.com>
 <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
X-ClientProxiedBy: BN0PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:408:e9::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bca4c6-2c4b-4d5c-c0ea-08de1e2bf695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UAcg6+SOx5P+1W52O9s5I4aIBpNv7/sB3avJjuOqyYqhc/1lnAdNZasY18se?=
 =?us-ascii?Q?xFhVdOg2td/EDJXsscaQZPvpki9h1KmBv9fyI8oY4+e4O2vZoStRkpRG+5Yw?=
 =?us-ascii?Q?K+EvYhvgbGWX2U/N7TE4oUlLYuqj6C2bS+TK4lKRYvowe7pRsS5PkG4ociQQ?=
 =?us-ascii?Q?tfWOPHrOwActkmrgJCFM0LfNJaiGZOcIRHFd57M9rKzJKhZ5Ajs+druD3hIB?=
 =?us-ascii?Q?BhkDazE9Lnw+YbR9gO1+iOGjxJ6WT8Fq1pK0GT+Dz1IBcXxUZSGHRMqCfQ7p?=
 =?us-ascii?Q?SUJWxQjRiLz0nDEObAeydi8B+xYouN10qtSh+u25mmmNhFVhvMjUvvYrBV7q?=
 =?us-ascii?Q?ziGxOMEq5nmj3FokYRXapbVlKMjvLTxpcz1Z3t8/bQqBIZ9NFkz9YQcPcoSf?=
 =?us-ascii?Q?+Oyg1J4K/DJjPiHDO+sP0u1RqQTbYD5FFOUolvLyuKhqHdD0cu329eoXAWkP?=
 =?us-ascii?Q?BkBHpOQQWDNYmnIM943OFmPRPGLyuWiKpgYnLQSu5YG0Jrxsfn8oZ+Kn0iIX?=
 =?us-ascii?Q?IN5gvMmdNVe8pEsNmF5coYn62d3u5kPhKDzlBFEk+weWZR3HqpdeoqtDs2QQ?=
 =?us-ascii?Q?ARRYwJZl69DRchBGhZvkGW7OYb9KshBA4mp7EEskYYkHNHpkXbUs03aaVtZs?=
 =?us-ascii?Q?fwoxic1296dhzzPsX1LorG+zjc3Vi0Rel2GHJq0OiYoJygZN3qiAqzWFTeaN?=
 =?us-ascii?Q?0XoSD1TVnHgfQ5GMg/WOexPb4gYTcw9Okl8HEpSSloApH+1zhhOVKiAiJBRI?=
 =?us-ascii?Q?DOxnF5dZEr5wPX3402edMfoqYSH6MQw1SEUoodrROmm14Zp69nKRqDh2UFBI?=
 =?us-ascii?Q?b4XmkUfDFqzSiv/IVU2luNlZAJ73nGEYCdj4KT0SzlYttAx/faUv8zjz8IQV?=
 =?us-ascii?Q?1YHPb7NsTUt9UBMldncn9dudA6zNypZsb1KgkV3Cp6+czD1t/Qp8fdlaM6lw?=
 =?us-ascii?Q?ZT8ezWsoN1czgU+wX7rvHhbcmShQb66ZxnNYFPd9pk/oVGywCOgsA+r4ITDW?=
 =?us-ascii?Q?fUqQfZR1ASIjamxUECEjdz0mQ0sNFv6gERAVKZOet9x+F16muh9m1pqGsJAe?=
 =?us-ascii?Q?oczAFNQI7HS8V3SnWOPLCmiQfPQLGtZES6R+KXBWrtroUOMdPn8/q+dSATun?=
 =?us-ascii?Q?/VHVmy1NQlcwesZi9VgKwng9pUSc8o0zxJ32/VC5bZkPCAhKqDIBOcLx1RHO?=
 =?us-ascii?Q?Q7kzrCfx6ltub83XcdQENOT3LFkx/pf9TdJ2n40ESAZAHTK101YbaqQNsfhi?=
 =?us-ascii?Q?/vndAPUeUKotYmiSeMB9/XsXrqoBMuPYixYt+VZKO8Hk7evU5Dib1zu/UiiL?=
 =?us-ascii?Q?7MjRmnoVU+2ViaQXLIbicPHSB5arV6SqhzN+uASSnmZMGdPKOqxQ5lYfznmx?=
 =?us-ascii?Q?RpKjAl4NLnEtDDYE7wqLFDUX86enl6wtdLedBYuI2/1lO0KgW3ABifmEQ7ci?=
 =?us-ascii?Q?ExhJMyGnBZauVrIkmF1xozUi54NMIXmU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0qJbeQW3wvuYpAdJjgrVuSMo1lIOUvO/oMAQn+jFqe2MhC1VGKB+PnCNTDgN?=
 =?us-ascii?Q?NkayNLypG9SLmisaZGrPEyEbDZ0pfOQDFKG3XX40yuAkkgjrn/UtrAXdn8m1?=
 =?us-ascii?Q?7qHkiE44FtvBZ5/6P90MOyzCVI3pmwuHidmUTgo0pRBQ6hEAONMmtzzBlp21?=
 =?us-ascii?Q?lB4mYE35kOuTKyiFqk7jgFIeLmoL5SNacn7zF80AcEeofAUnmaOAQosiWwSn?=
 =?us-ascii?Q?6oGXLX+B0VSGQwDYrr9HTqo0+LmJj9od0337pOJVfx+9pcbMooV6mK0Tzejr?=
 =?us-ascii?Q?9m3DZECEPvDAMvw9wjSUq13awTpJCvrZJ32juvdE6SkcnLnz0hLHViXgwCVq?=
 =?us-ascii?Q?L9wV4YiIOXp8M6k+mz4v/8/nMQS1ZW8tbvb20KgRb0+jueBBKq5xoAjXKJcH?=
 =?us-ascii?Q?kIaJpDBgPcftu/wDiT9uFCqNAxxqI/qPpF94+ihwpWpSbKBtKL1MpqwuoZSd?=
 =?us-ascii?Q?LYYpwYPkPYnH0Yjbdei4vGTE6WGWKyvsRcWtsIRufS/FuUEmqNTvXOkLuFMd?=
 =?us-ascii?Q?mpKl5pFwbnuTuBRKGn+BIpn2G9DcNsmbbKeCHns50OUdlFh7JdpPYbAXwoOu?=
 =?us-ascii?Q?fWcXpMOFznmzBC3DRzjm9MAdd7xoP/r7W90jC9HEkquIqtdGavGb0EP+vwpv?=
 =?us-ascii?Q?hu66SZ5q+87gfQ9X67YkVHe4Eia6+Uy+oAz8jlM8oOdAaRFsmaeTixiDowTt?=
 =?us-ascii?Q?bG9sBluHk9pqD8HgqT7bRb3FfrHafo91WgxuP5D97MrI3OlQWsiOu7I5gKLE?=
 =?us-ascii?Q?N0bvRQki1nQWA9lwpVsLxKAXvBWhbZmt7W1pkEy8KMLo+G/yy5Jq/uZLOIub?=
 =?us-ascii?Q?Kmxhfb7Z1YFLOGbxDrSO9fKMWnUAaq6XHGDxSAJuaU8s2NuS+mV8OXkxCHUv?=
 =?us-ascii?Q?Gnw4Ll6TGKPjGdbOL2GXhizNUPk1lvxURbenv7mJoFqqnwDHmYCXN53SzLiq?=
 =?us-ascii?Q?oOM7y5YIPSIr8sdz9RuRCS+CyQywFv/9Bv6cFDWbG+F7fk799rFqt1EMxiQN?=
 =?us-ascii?Q?TfEvJMUT1Xc84f1a6HFTc+EUdt0LqxNRLpHXcdENU7lGgqogtyrMuGg1evyL?=
 =?us-ascii?Q?ZvXp0ATtWuoO+qDWXd7JqU3xO1ZbfFeR00okH/Xi/ae2H4ZzJj38i3b1Vay3?=
 =?us-ascii?Q?hLFizjsUobWkQeEmfAg3E38JsWDaZRH8toQSE8/gDEgX6U5okjsZxEtipQbk?=
 =?us-ascii?Q?OoUtz1S0p276RuiOj3UuVgT1S3BJt8PHtV+/WD42YRScDpoBRFk8rtY9li/7?=
 =?us-ascii?Q?NE5XqFAalp4VF99wMTSm7RQJy3hl9/tFnlsqO9W5PFgkm5iHdLcXju3yFcsr?=
 =?us-ascii?Q?se9fqgklvrkofLzRst88q+hjqk5wfyW6UtjLWOwX0gCU4cfA+Tt0VD8VSehT?=
 =?us-ascii?Q?ea4hGbXFwk/wmiUnN+eAM8YNNTV6OzZIUmJ12Ls+8Sn51+44RqyzCOdPbXrN?=
 =?us-ascii?Q?3SaIXnfsixvA4bAiVML7HtXC73BEDPuQeFvk2lhaKM9+Eoe8p+Ua2OoOM8KE?=
 =?us-ascii?Q?cckoHBldIBIXuaP0y/9w31wUeemt0VxKEYaUH8uOLpUbPro2PnUe0eYDoXSO?=
 =?us-ascii?Q?b+XBLHbJK9fEchiOY30=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bca4c6-2c4b-4d5c-c0ea-08de1e2bf695
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 18:32:11.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn7iH3O2xdPUINCKNA27IYd9AfKB1keIiICSbH8CJwDcxA23ha+xYrIQONV5Kl22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

On Fri, Nov 07, 2025 at 11:56:51AM -0600, Tom Lendacky wrote:

> When you are on bare-metal, or in the hypervisor, System Memory Encryption
> (SME) deals with the encryption bit set in the page table entries
> (including the nested page table entries for guests). 

So "decrypted" means something about AMD's unique memory encryption
scheme on bare metal but in a CC guest it is a cross arch 'shared with
hypervisor' flag?

What about CXL memory? What about ZONE_DEVICE coherent memory? Do
these get the C bit set too?

:( :( :(

> In the guest (prior to Trusted I/O / TDISP), decrypted (or shared) memory
> is used because a device cannot DMA to or from guest memory using the
> guest encryption key. So all DMA must go to "decrypted" memory or be
> bounce-buffered through "decrypted" memory (SWIOTLB) - basically memory
> that does not get encrypted/decrypted using the guest encryption key.

Where is the code for this? As I wrote we always do sme_set in the
iommu driver, even on guests, even for "decrypted" bounce buffered
memory.

That sounds like a bug by your explanation?

Does this mean vIOMMU has never worked in AMD CC guests?

> It is not until we get to Trusted I/O / TDISP where devices will be able
> to DMA directly to guest encrypted memory and guests will require secure
> MMIO addresses which will need the encryption bit set (Alexey can correct
> me on the TIO statements if they aren't correct, as he is closer to it all).

So in this case we do need to do sme_set on MMIO even though that MMIO
is not using the dram encryption key?

Jason
