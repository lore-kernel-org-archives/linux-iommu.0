Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795669709;
	b=fDBlHW/GJ4MK1J14+8XKJNp+D47AgUGRP7oyaTa1Bpezd1/Rr6c+NrgU14c0/Pkt0zCi
	 pykrzxl30d+r6VmGIOtCjN1izWeoS5cZb4oCQJEXkQ2WcEYkC2+np8JaACJ7AbASFcMCv
	 57fs0A2Y2z7cSGIrnTdcLJDHZn0sNVk92Os620HrBIyczUC8nAwo3Peirl+ahRZQaV3iB
	 avQTinLKO/e9AFRHsTL/sPT6AD7MsK6z+XJ5kBAiLnBp3cFbZsGh0uVLW1RF14ayrL1OK
	 gqWqkU+VSdDdmkzy5HP/Wmimop5SAOsFiocVjm9bSHWEpwxg+KYoD1BzK2/Lhvey1rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669709;
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
	bh=DZhV7yH3JiMuO/7YV+zMxGaqApBGb4UKW+gUjYe4TzE=;
	b=rM8KZpDG5LPdQnxC/uLMxqpU9xdM8OiNdz527RDjgKlcmu+lD7kpLZXWkd2BelJLoPvC
	 l1jYTFsUlEfq3t8SwBp5nC2vfV5cRbZ9ji2zPb6HXnXBk4TEYDvBpdV1PR8SDfoe3wEfk
	 rg3G9VqcCqIYURC34MzWfVYD3fYXAZQN79hF5mkTZp1JyYnrXqVIAfeT/75Eb6erwJWeo
	 doo/guu9derUHgTXcbD+dhwOImCKCzN6414UA9BdXGouAc/LDJvkKDdbg2QVO11R0hrVg
	 JEAzhHLSTS23DfX2IKYpRppTlbT4EodVKY2+USJetAsGf1PABhO6wc7jnQSG6JbW9+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="JA/d7mNy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.49
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3248606A31E;
	Thu, 26 Nov 2026 05:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3248606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JA/d7mNy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3hqr0lixl06jI5H+d4vDudsQ3fsbSM8Qp6ttxvMC3ov7Vzd4qFaGdF2qM2MetYSePt3yiN1qu4QkhZXf/1cUMCtJ7zT4fJrRRc+bnKLy4gmS6yvuR4IpivDNJlhWVc/u14IU3EZikf0yS5FEHBK+5UGDWq8mgg0NK+AadblpKe2RXNl/Gr5f9iMwiDp0nejnxXH5ykBS7JARYY9ouGx9IE50ND2+C5miivdGyGFeLhqCZHglmN6t4ytxAT5K/7c91icXEjR0qJNQKlRLl4GyFUuvWwbyjpKcY0IkpWuUJSWDcLM7G6/xbpzYGyk3mAioYd1T/j+Xru/EKRBEiHB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZhV7yH3JiMuO/7YV+zMxGaqApBGb4UKW+gUjYe4TzE=;
 b=fq69ciQyluPlqes5j+Hp+yh3UuACmkaWTkJ3ECUtHhA4UNsD7aYaCb0bjxAJiA298KuKHMC+TKDOcRsidl2D4ELOD0nBe+KN+UsRiszZWFHmu7JQCoMNqMN+PL7wvBirZFQ3EnjWl5yufCA+U8uhqGmtikx2IXj37QsnWsvbU94hsp8PQ5XKm0VjagHt5lyY7SaRmoGRoVtf7u4KWVnDdyJaMA9JgWeCqmQxp07jfNhjgUNJnGGb5XFVMn+DQw/JWH2z2lX8m+NyHejBApuVLF4GwL4FhTxMrtZK9J+FUzARn8gYngFXiQeytMMyJtUiBM6BmB2GeXxCplTjnQgT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZhV7yH3JiMuO/7YV+zMxGaqApBGb4UKW+gUjYe4TzE=;
 b=JA/d7mNyA0PAClFKWUlBCshko5t1aAGkKsHh87aosINEkGolcz4NxSrW7Byfkw2I4uTsGUAEdMqITpBLwKZrlkPg1lgeKcIt6e9fD6Xl66PfIUxuSIjkCUFyZq74hNejl3tP34rad0xoZ6W5CcL54RMRYpUMPKSjIbshidDK9IIgq8GNnHaqF7paI8jZERAOZGgSgV2TnI8mGtmhZusUAtBZZhRGWCkbiRxLF98UhxuWx8ouJLVVn79VGilTOV2sqdC9hMSxZnnnO7XikJbW0YsUc1nL0zgeM78E7M27I+O6Z1R/D96mXoEo1pG921X6GE2rAIsqdaAkvwsloavTnw==
Received: from CH2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:610:60::31)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 05:08:23 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::a4) by CH2PR14CA0021.outlook.office365.com
 (2603:10b6:610:60::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Thu, 26
 Nov 2026 05:08:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 05:08:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 21:08:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 21:08:05 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 21:08:03 -0800
Date: Wed, 25 Nov 2026 21:08:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Rutland
	<mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 7/7] iommu/arm-smmu-v3: Probe a guest-level Realm
 VSMMU via RSI commands
Message-ID: <awe+sQo+TL4xI3Vj@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6872b2febdeda2990731fa6946cb4e00c7899185.1794343501.git.nicolinc@nvidia.com>
 <179563006503.253973.1333208494920198413.b4-review@b4>
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
In-Reply-To: <179563006503.253973.1333208494920198413.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 847aa87b-230c-478b-7a3a-08df4b7b4bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|10067099003|11063799006|56012099006|4143699003|261021135927099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4ugfPcO4eloVy0/sts4gAb03JMCqctF2NbxyDaQqF2pd5g2REO4UDjY6HnhP4aGyOFXx2SWNFEDbn8+GtHaAwMsIokhqzLxW7Kx7se9/XTQoU3Wv1Dh8Vygb6xCphWLNymdvvDC9nqHZuE38ZH6HdOYe6V8MrIldc6a0ORZ5gSDGmx++Aa4HWkVaiN0uoFauFi8Da4mhZFIVEMW9scUbQtVH+wVwt6p9AP/JwiBXZWbaULcIPXxvtTKUsgP2DpMJUBdFs20X8V+nj1Ai7fVL3pLaijFoxuO4bhKtRJyZXIO1sBGiwQHjc+buK5h99+fpXK2kL24CdTZD4HD6cxWFZIoo/X2TCKdyHVfIL7HYUPvdpp/B6R215J+Lz4nQlQAvXfbEx0uYjGG5+ts+C67IZq6mt9cF9j5YEvpLs9hB+mPGKsQw4vaozV9cypo8cr33UVmli/UUbVj7Xtxhea/h2yTaLQU3FSPi/ZZg63zFVO4Ek4X0GTJzLwai/QSkFn/sWGkfvnq/no/UUkzR9AnC63yvJ2SJ1UliMnNrDV820T0xXvwwHAOU0lvD/QDKD3c0mMrfFzQwifNH3CwZNsmmzWoRPc5Pr3HUxju+zlRjTExRSFBp1PuyGbTFek2c6dt1b05nQ4jnZjylAwpoft4BkaKrrC2rzodCq55ebc9TNtCmHGW59kqJ6soie4FjqmAkvR7BXhp/aMZYWlrXS5ocTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(4143699003)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+IvPhBngpJw6ncN+E3JgDvlnJOfjfeYsJl2PAT7p3a67er0axmhVKLAPsDjC9vyyR4YllXYav/6nSqwUyUGJ4I4YN/7xQbaHJztzTdojAxnWPn4+ycWKUbKFyp/PKjTmccDho3d7DEHUOPEvHYEtZUD7fHPW+I6RF0fx8KRcYL87X7d7TWMVCnrK3upxrHrHUgq5Qu9UmnY1PMAD5AT/d45UBNe0MpwcFcGdriiaFe/zQ/t1Zy0Vu1pOVjB/nUCVKASmfsuawBYXAbsVw65F+rSeIEa9dR4oM//C6zR+mNfBDmoFUgLqC5IRbfIs0OLcnUGOUekNTZP3F31WI5ezFm89os0wFVuylgN/CarNAkQei81pB3yOl0t9nLcdzdmPJTPEwGao3C99H8XqLQ5kEIht8HsQMg4kxtlYf5WdlHzar5WW7pKojcup76Moih2W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 05:08:23.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 847aa87b-230c-478b-7a3a-08df4b7b4bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > In CCA, the ACPI/etc doesn't tell the OS whether the SMMU is a confidential
> > T=1 instance or a normal T=0 one. Instead, it has to be learned by issuing
> > a trusted RSI. Before the kernel can operate the trusted T=1 IOMMU, it also
> > has to validate all the information that it gets from ACPI against the true
> > information that it gets from the RSI call, to ensure the ACPI is correct
> > and prevent substitution attacks.
> > 
> > Use RSI_VSMMU_GET_INFO during probe and require the returned register range
> > to match firmware. Then use RSI_ARCH_DEV_ACTIVATE before mapping registers.
> > 
> > Currently the driver doesn't support a T=0 SMMU inside a realm. For example
> > it doesn't make the page table allocations into shared memory. If we are in
> > a realm reject any SMMU that is not T=1.
> > 
> > Once the SMMU is activated, its DMA will follow the DEV_FLAG_DMA_CC_PRIVATE
> > rules. It must set that flag to ensure its coherent allocations for its own
> > structures are allocated from private memory, not the SWIOTLB shared pool.
> > 
> > Also skip Tegra241 CMDQV implementation in the realm world, since realm has
> > the support only for a standard SMMU for now.
> 
> Maybe clarify that from a guest perspective there is no way to verify
> the information with the RMM in the NVDA200C ACPI device so that MMIO
> space cannot be used.

No way yet with the current RMM spec. But, yes. I can clarify it.

> > [ ... 21 lines skipped ... ]
> > @@ -5611,8 +5613,11 @@ static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
> >  		/*
> >  		 * Tegra241 implementation stores its SMMU options and impl_dev
> >  		 * in DSDT. Thus, go through the ACPI tables unconditionally.
> > +		 *
> > +		 * Realm doesn't support Tegra CMDQV yet.
> >  		 */
> > -		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
> > +		if (!is_realm_world())
> > +			acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
> 
> I think I wolud put this check inside
> acpi_smmu_dsdt_probe_tegra241_cmdqv() with a comment including the
> above note.

OK (to the other two places too).

Thanks
Nicolin
