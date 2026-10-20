Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792518498;
	b=xlogagRVShDlSCy3YvBscZInIb7adB9YOijOGU3dMC3CoB07mt5cmVpoO+EOIKDbPbJJ
	 wVefzLH0j2u+39VE7Hl56Qzr9N1RBbO+vzVguwML1iDn3kjA+5uS1aadtGLnxjwTMNagK
	 LR9YqwZyhRoWsT3j8lQqslK7OP0MTniPMg88tvHruOb7F3M86NLaC/llFEEhf+lyqw7pq
	 c8y2buLUoNDSti1QX8O9fHG06oGWqR8DM7Z7G6o7WJpoeX/rLN6Ux1yQkd/jySqwjTnPY
	 tp3wpthp/T9CsiGiDLs/sVU7/+XwIklGXHfI27u8rKf87yxZ8thkmGhymdycY/XfFPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518498;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6CvttVz8VRs9CZmhiCYdtXtLzwcUvYhCOd23LrfgyLE=;
	b=nPqTiikQHWM/IHjSMtYLMfsTAqwHuUAfWMLIek0gJsWmvqCbd/vrMw7661KMahbnYEYx
	 1NCDUyTVmyHVEH2RrphrFyglMnxP4H8V9vpcVEjhWJeG2Mn5w/HXEfaWyie6tf+21uYxw
	 aPmSGVKUstrYGDOllrzjA4DXCAk9PjsVGwA/9JrAvh4OLW3KXWGKV1h7+MIDZxGgZx1nu
	 HvcXepoFBB3VvZoXFgjByeFBw1w8O3IJFSylorfezA1QSw3/vpJBad4t3FnYwcpwB+6r9
	 IiOawchIX89gmgKtq1bVzhl5S7OdL+PYiYk6fMy3ro+8Mh73gBO9WUIAoA6kHCCBeDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="W2/MfORf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628A606A31F
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 17:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6628A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W2/MfORf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV5wx0isVtX6hk04OnmEbaSYAd1oeiIDNyF+Z86XBHO6UAFa2brkKIqeA94AzrD0js1mFBk+jwToAAuOos74F+E84yQO1u6wLdaILj3BfiKHpNQ6XVlT+GdUSXo0n7An7rAEedDOTpop7Qw8VbKolbstjg6nV8dDIDLok/wXLabZBP95PmRnnpwIc2BlGmnXzr8nNOIezFdB8v8e/iK82ah/lSwBcRM3EORjQO+ilNVtDNmNl6KKTXd6mt2Qb41g1QIRUHF8VdjohEK7bojvcjHIG9Wxfn79N5lkeqQtYy6XaPLJyEprq9CMWJuJRSHzHyHXd9VSR7Z0Wh7934lU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CvttVz8VRs9CZmhiCYdtXtLzwcUvYhCOd23LrfgyLE=;
 b=Wz2AU9YYZ2lv45UpUyxvAlnQRNDTR/yGumnZjMSZpuLNTndJLmaTML/M8gw7nZ9/b1ENplcN0FC/nEaNi57JCPJlFnZn0P2BHkf/cqjx/xA8tKON2aMGlRbko4OVmBdmKoGeQjih7sjfOmO+52cVB/1SEV6NU92XrvAaqnboVbdLQZGyVbe2xejoZ2zyeCGQq0VdbE3oC0shtu4TnyACWnkE7X84g03UalMk0J1sosTgREX5yjAwR7R7/+T9jSAsLBrzEwoW7RyE43zopjBbv9QGC6MIdM47Sm5o9LVnILR4+S30hK+pHOslsEjafoyLCD5RP634jesKtWsJ0IQE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CvttVz8VRs9CZmhiCYdtXtLzwcUvYhCOd23LrfgyLE=;
 b=W2/MfORfHpXn4fiilmLuyJPpbnoDR67hen7kIBU83ftRKsB+zRn/6wQbe7v6fgUiPdEMewXg/BHilzMBuVDkKVJYCSVvpn94lSR7sKvzrCsmG/V3nDMPafwqiVR2t0QQF9oOaOxr81Il8MmgTRw79Ebl9ajZgg9o2ZDhTS67832bCPYV8YHWhm/frDOkY4LcTSOxC7NVPPljKqkxF855S+nAffPHCPzw3eTm6ZKm2NSQbHQ8mQVbKowaUANn/U3cj/q7yjgRoWF+NnSt5ViitOQ6tgx3Z23fkzcAWNrZIfcqYLq5VryJtUxG4gtPIQcOyngqIloLBSCFhpEVP9ArzQ==
Received: from CH0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:610:e4::32)
 by IA4PR12MB743615.namprd12.prod.outlook.com (2603:10b6:207:150::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:48:13 +0000
Received: from MN1PEPF000793FE.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::70) by CH0PR03CA0207.outlook.office365.com
 (2603:10b6:610:e4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 17:48:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF000793FE.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 17:48:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 10:47:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 10:47:50 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 20 Oct 2026 10:47:49 -0700
Date: Tue, 20 Oct 2026 10:47:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <atepRLlIFT/0xPTC@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <atdSrRwrphdI9ZQA@google.com>
 <atemgT/67JPpdk57@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atemgT/67JPpdk57@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FE:EE_|IA4PR12MB743615:EE_
X-MS-Office365-Filtering-Correlation-Id: 60de04d1-0f42-4a06-b13a-08df2ed2504c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	x3jqe6uG7h9XjgJGjcEKjcarAoclusZriLBC1NVoPGCnzpytybc1CrvT2fzbtueijRPVw2NoVHkoDbmC4fW8i507AQRysPpgrMH7g/V4bWRNiM22rzPKP1wH/rPgHecvhyp/yHUPglKx8LSoZPCWX9BmDapIoguDE4GeERReMs8YY4+w1CLaNx4+h6sKQ6bGoYCZo7bqVGdOQ570NwdASoTAa0ZLdJf/WK4HHsDrZjhdGZVtK76Ei/FYCgyy8jiC9+O+sY9aBhX567c5v/WCFiMSiUsyFRYnaPIDY+KdeaK1PcZ/EOckq2T4nG+uErQXgDUa73MiEqwy5LCI8KpHb9Pr/Pbs0T6YE2QFt7MqvOBXrGm0ZK1e1iOi4ho+J8rJ/aTKghsIZw4Z+GbbusmK3oHd/M1hMJ2cAVVJXNvJeURUBJuheW60CY1STAC6AAy549nukGaRJg27l8bv3suNpe0u+37DumpBY/pGRl1s5xQ9/wYMVAQtXg+ARKA0pVNjw/9MtG7Ehxdbve8rFotgV6NdhtL5jTKegWVi0PZd69gewzBTBxGvy2aFPDmM3zP1GXR1ISx4gGSTYoONexlFLFnQesNkAZOPyplkz9qtOa7UgXG/B/WhoP78KT/jdvXqpK0Xdq++xim3A2CuF7PJquhQCEoq54QJIkVb26nkoGHbI2g55NGCZZgENp7A/VLbbv1nF5Io+Su0rtemAHndVA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2JhfhLA5QsoWMhwqB/tOjWv2pASVUe4Lxr3JNmszTwoOL1DpxFclyWocIKCupX7LYz2lycYpuxEuZ+hwpMOewl5HD51k8loedCtaQ+PRD50bhX1NsQ2yruiqPWwGHQgjL7ChWOpxoobTSH2A7pGxVlrVijiwfK2yVYHJ2fLSpqxlhfSe/YH1DHp5Envd2nhWBwncpzrHZHnKoHvRpSDE7B3Ejh4Dvaj4aoAWnmskVCo7QMU2ooZC0MK0y/rKY3tbpb3hr9U3La6vJKlVvEL9MT8CYiHdRrfTZDtrmvEDw8B+iUR7Bi74cwOMDAUCDHHcSC7yiszbRuUc/dPB5sF/8KpQRDm/+RmVxPPg+t9kLNePtw2Ij3xxQLYNBjpElbFBjLVy9o+C6/ig87awTMfoS30Zsi7u6VdOzo8hYNxyRccJdeYn2Z93wRcffZJJyIsB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:48:13.3203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60de04d1-0f42-4a06-b13a-08df2ed2504c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB743615

On Tue, Oct 20, 2026 at 10:36:04AM -0700, Nicolin Chen wrote:
> On Tue, Oct 20, 2026 at 11:38:21AM +0000, Mostafa Saleh wrote:
> > On Mon, Oct 05, 2026 at 12:30:49PM -0700, Nicolin Chen wrote:
> > > +	/*
> > > +	 * According to spec (6.3.24), HW aligns the base down to the table size
> > > +	 * and ignores the low bits, so an unaligned base would make this kernel
> > > +	 * read a different table.
> > > +	 */
> > > +	if (!IS_ALIGNED(base, size)) {
> > > +		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
> > 
> > I understand these are best effort, but what happens if the address
> > corrupted and happens to be aligned?
> 
> This is a basic sanity so HW wouldn't immediately fail. A corrupted
> address would be trickier to test out; also we don't have a perfect
> way to do that. Earlier versions had some address range check. I've
> dropped it, following Jason's comments.
> 
> This is also in the kdocs of the whole smmu kdump functions:
> 
>  *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
>  *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
>  *    the real hardware. Callers of these functions are responsible for gating
>  *    ARM_SMMU_FEAT_COHERENCY once during the probe.
>  */

Oops. I copied a wrong paragraph. Should be:

 *  - Values read from the crashed kernel's registers get structural validation
 *    only (format, size, span, alignment, and ID range); the physical addresses
 *    are not vetted, as the kdump kernel has no record of which pages held the
 *    tables.

Thanks
Nicolin
