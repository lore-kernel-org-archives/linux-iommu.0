Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC84480DCD
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322732; cv=fail; b=bAWB6WgmLNzrGAue2b0QSKbnUU8/wdzxP4RBoyYrWyUIoyxIyYvjUSXniCCcYdzGCbREt7yy13OKa3bjgA6QCXzZfXKKnrkjS8pr+ca50eS9a9Oi3P/0yUNgXbMCrOZlYVkIFtONX/JZrYvI74dH+fn35z+50dusT2hYSJXu8dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322732; c=relaxed/simple;
	bh=A/7odybPXB/QFfpLhBmxutWv8wP9HPw1Z4Z4KUnNMBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NzUREdUnBwy/SmES/2sI7F6lnQzC1OHzktkTQAVKBvuU6DYY5S4sdVuI/dUJkXgQNjgBSOZIphiVVpxXn/lBQkFwO6BovShcPLeV/bZ1D1UU5xp/bmQv1Nopn/zf1XRzjhAAD8FC31rzUnnQ792bnlj45T0UbQYd9rBVQOeAVMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBpjpfUj; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBpjpfUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkEMLByq0enxS2rhg8FD8kXJlLql2qyTxOCpFcafqZO3qg7pQZpzy1vV/3w350zYt9ortXKGQdlM61rfrInYJAzSsGrjReeZskECRUuQOgawjptDC0vzv9tg7R4PAZbQk8llxQkGvQkRvWxywewxfKUqbsiEsbfkIU2Zyx9IzlmShWgsSL+qR1oJ3rzp2gvLnQoZSzem/y5RSw7PGztpJx55uimUC1521ldvMtBdrSlt9B2PxFFX7ioaipAdFVt9zw5FqOMuJz+gxa0ykP1NT3XMcw9UO+PIYdtYboPV+AfUu57OZM76p8fdkF0RFsbA496c3q5kJyC/xzbTTVM+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWaKOhcIcOzLyuHi4PZhFzctvQYZ4BFchVDlx3ex96s=;
 b=ZX4bJEMkuM0j/itXGCTwOTo5gO2QPk0cXt65jkC+5WEz9sD8OoAX6FNCv8s0wjEbkrlid3/Sl/BzCaVm4n48UCIYzGNlwkkgwgdlEUR4jozulPya9Lo3P71m6eWxvcB3f/IUWEpbfm7Ffhr/pfmJvgBF08Si+JHwdoaMc3LBPn3o4AAgUDXL2vuJovCOCZKMsJ6pc6X3SnTFLWbMv8DRNzEoviQX32x/LKCpXQJ0OdZwg0EHiVDZioXgMySeJhfIgW0IlEpGg+3Rs+yphGNMuCFmgs5rsh8c2tIrsV+mpHiCX2XCndHII3CoTkjUod6N+fR5eI7BG6foh2StURbnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWaKOhcIcOzLyuHi4PZhFzctvQYZ4BFchVDlx3ex96s=;
 b=LBpjpfUjt73o1sTtZBkjwOwNkrMTGnNJ5pti3p33rK4b14090Tp3yIhwD4pjE7E5Gd6QHbtm68vQCzF31AjBBxBmcGyJ6OasaQZGSzKd7evfWTrvBWWhaiC9vu4TXB5PBQiODqbWsUF0aZrRv/LQVPWdL4byXAYptc8Bqz5eGLjZzcG61aBZ46MZ9anKqdMK9PEycZhPpS1qretywnDTlIMwA0eAF9PTs0z5xeovdikvfmuB+3G+PwHJLC+jTF/LfKEpnG4xg2c16oHI32Y1uDt05HIl6v98CZ86oYH1KeZdFaB6cJ7SHSJhWy+Jg3Hpmx39N/ZNM5feoaWfWno4Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 21 Aug
 2026 14:32:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 14:31:56 +0000
Date: Fri, 21 Aug 2026 11:31:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260821143155.GI244917@nvidia.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
X-ClientProxiedBy: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: b268479b-41bc-4a90-e58e-08deff90f3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Lpx6q5qi0ZxVpi6oHuE1asTHlfk7W0PodvlOJX9mT65Yn7nYISpKsfNwdpoOi/XEpkc9YohLdQX4wexRhK3NBUPswDmwFMKmS83tm9Bl94EP6nI/kNXTdsiUyhEAGgbRJ1wDF/HFt3b2JmOQ+TcxAdQXWvk2IIip5PAHb1/yGS93SrnbX3Qoia5xvLgswxwxc0fCzq30BEA+IV3fHK5us3VjBVO4g9DetmD5mBZMnCSuec+KvuBNmFH0OzSlBkC1PIBdeGRCN0jGruQcfN5T4OvL/BkqFZdmZQnbajRTacep3/lf/5KUNbiN3CPyjfNpaHbjCqD9mH181qE005fDtDQYa99PtKsRrvomRqhjk1kKH7a7dvA4Y5ug5af1UenmdWk1/QMbtmoMdIe3q9ty0nZfrfbvcCWtjzz24VWcxD2ZS4cn4Uhb5OQt071+PnBRAvav6hEVAvMfpSZ/zkB5otKE3I1cIyu+0zf2S0WJFKlSnlMlf02UMI4Ionu6ARN7HV17Q9yPL8SN8UWkZSdGNmAeOmsOR2o3MT0gSHsEGK6CKjFsTGg8ZJ7jJfsfSP0WzR+OkJxz3d+jIDxmSKYjcq7SIvY81oTEqZU2u87CD3rTWP/V+ltUkGXuGmIOl0I1gtuGdTsZ0hQkUD3jZKaPrptfP+MXOxpk3Dnu+6y8GsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwdXm13do0sone9cswEL+EBXRxBYJkpo3kfI4uqQFco/GTEjYxA6mu8Dqdjk?=
 =?us-ascii?Q?/TOIu0aG7rJoZ2NBuqT7gQ/YxcrNFfOglH3HeKFV/jHHmMuOmxZDdCrok7Zp?=
 =?us-ascii?Q?qBKnWqSLS5lRxoV7IZwJ8dJea/l24MKHt3u/VxR+ZLmiIru8IN3xKgcS4JP1?=
 =?us-ascii?Q?AVVB7rY++EakOUfpkdvU7OtH2YUFip1E8gM8k8WVq339UVumF1EICPrHtWHZ?=
 =?us-ascii?Q?3tRzGGOwRrjphs0lLNSsqrHAvEiHeGFc4UDGAh8uwH5V4dQuE3q5MJDec0JL?=
 =?us-ascii?Q?foudy6NLqbBp9I8vvRRmhrEDr/0w5abItI8Nf49M+h/VX5tQTcf5UK04vlKO?=
 =?us-ascii?Q?IjKuc9woaIiNC52r7K1e/qB+KXob1n+0T1PhK8p+AOyHB6RxzTNnOS4/lvzZ?=
 =?us-ascii?Q?3RJXnZNrAgfUsRbCYI0CRDDOotZ+vf3To0eXzfiQK8t3mhg0ssQ76sjYtm6G?=
 =?us-ascii?Q?mVzVqIIbRCCA6WW4iEpF4QOVBs96d8pDIoEgLKZVpxENpykdrllx3+87A8G5?=
 =?us-ascii?Q?xYTJq26OSrsRfvWJCblTUKCRZQ9rabQkb3wS2QOwdQaOiPKQiAAucPXL+1SZ?=
 =?us-ascii?Q?TlZhgkYz19XgRtqsJYoxm1ewnJI/3JxzSPOpFu3xD0RQVisLslELUm0JcOQW?=
 =?us-ascii?Q?AQsOQNOQMnprCXrCkVsZAratsuV8P2nEk/ziOVUv8sKMTIgXh7HA0IfzkOSq?=
 =?us-ascii?Q?EPCiSNqmkk9+Pya2ueSVB4OycgWr+Ec3SRXCHiPuno3vvoz2QGs0m4ja8+xM?=
 =?us-ascii?Q?6fTX8WNZQmscBV8XslLthVl8aaZmUi/+wAhgDp+TW5HoZYizJC8UlQVFz8xq?=
 =?us-ascii?Q?9K9hebixx9rkhsPLN6wI6ud19725l5KEBGk1S2O5iy+q4DHG2iFmHCpFb/yM?=
 =?us-ascii?Q?c1q0/XwLidD6NZy9FevPfYUQfLcRHD6q+TiUN7howLUE9XgULZrpPpK3mqr1?=
 =?us-ascii?Q?gOxfDmdNfHhg8LxoWXP3k7WmnTB/3DE2s0x4jR0sGM8P2TXWTrHH9lVIyGNg?=
 =?us-ascii?Q?gm+MkZzO0GIlhxK6n7Mx0qGwprI0rmFZ7h1njuYlKbRzqXUdqm7i6pRIPfGp?=
 =?us-ascii?Q?In2Iz03j6aonIhySswxqspbcdkzcWZzx9VWBIZjNAHBbUvMVj0AKyqkDdk67?=
 =?us-ascii?Q?5KRopvBd6T7EMlYVIX2iUfRTZQj29D9y2YZVUgcdp11KJTPgIUcsRkkkP+FX?=
 =?us-ascii?Q?jj+7CuqrBHXcXev3KA04IEaGdRTMfOxAPJqeWSLovJrP5qdO+FcMXSQAPnxB?=
 =?us-ascii?Q?B4gvmsuu/0aWUljxWOgY6GYnR2AQiwPcxp7bzagv+Mbxf16x7w9NPvWPx5IK?=
 =?us-ascii?Q?BXPWYdkNbTiXzfHJKyiihjsmj2QMJ6uLxNQrFCrvQKtZvn8Poe8GwUBPQk8B?=
 =?us-ascii?Q?ju0dHxV6oL3eqBGiIZoF7kVGcOv/ietgC5Dz8TP4X8slxRyVXpHsESBKftQL?=
 =?us-ascii?Q?SsubQuVPGEqXyMrHdlUrU8Z/86yo9QM8v65Y9S9wJWKt1e+x6HT7hAE9Lv5C?=
 =?us-ascii?Q?zMaWXJxn4N/y5Mm4ixdc+tVATATaemtcJUWhGCLKuuqCjDvGaVcUfaBaHagL?=
 =?us-ascii?Q?Q1hZ1hPwIGbwUO6SlFNCjifpqlrpn5Vmz8L6gqAa4wrw5HGdT8Yp/Ch2qVuz?=
 =?us-ascii?Q?/VjtWpYfsz7JxTm5E6CKMBu7wZltBd3Lqr+B/WwwToZEy1M/m6+dJCoiGEJo?=
 =?us-ascii?Q?zMv7Sj+tRAWDMw03tX7dg+nqpxEQvHcdKBpnRiKnRmgnzLFM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b268479b-41bc-4a90-e58e-08deff90f3bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:31:56.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7sTp+vLo7JaUs48TOPO0NDt+4AKy5oCtCStJ67ROLeG3zrImCt1U/cfWcpTVe5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

On Fri, Aug 21, 2026 at 04:23:22PM +0200, Andrew Jones wrote:
> > But RISC-V IOMMU is also not involved in interrupt translation. Beyond
> > it could remap the PAs which represent the CPUs, but you are not using
> > it that way since it is statically setup.
> > 
> > So I'm not sure why the iommu gets an IR? Isn't it the same as ARM
> > where the IMSIC itself just has a wack of PAs it needs to access so it
> > calls iommu_dma_prepare_msi() to do it?
> 
> Right, this series is only remapping IMSIC PAs, not using the IOMMU MSI
> table. The MSI table must be disabled when second-stage translation is
> Bare, so it cannot be used for the host mappings here. It will be needed
> for guest interrupt files (the irqbypass series I'm also working on),
> where this IR irqdomain can then intercept irq_set_vcpu_affinity().
> Also, keeping the MSI setup in this IR irqdomain avoids putting IOMMU
> mapping knowledge in the IMSIC driver.

It's ok for the IMSIC driver to call iommu_dma_prepare_msi(), that's
the architecutre of this at least.

Until you get to adding something more complicated, eg irqbypass, I'd
suggest keeping this series simple.

I guess I would wonder why the IOMMU needs to be involved in changing
the mapping down the road, why not just reprogram the MSI-X address?

Jason
