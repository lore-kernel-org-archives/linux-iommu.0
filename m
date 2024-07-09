Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E31B86E4
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549816; cv=fail; b=cz8YrxH+uGFqDOOXZ8cMnvkmNJq/SY5TTFlByafCnnMwJ8yTu5EI4uP9+Id7bfFMGzvgFDY8SO5VhHXfKIIxGqL9lHzxxzaIugPgPregN3WhYgRrM1bpjRMV1ilpVXok4exCQTaFZfhtx8mn6P14w0FVsefVfTBO1rjOqDPdie4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549816; c=relaxed/simple;
	bh=q+iy+bxRp6C765AWaHVBl3zLK1EQeFxxhsmj+vM0CVc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY3eXtjflXZmSLv6c4tpGur++LhUuZNqSq9AnHbYCu776xp6Fd9XmtBOWXUa9ov5gsr4oeGWzT+OHrD2rOofCz8CS898Knhs6Zk5b34wRGQnpCuOz++x3PyIq2Ga2ejJfjmr6iuV6acdUpqaNnFd63OhdjQ9USlriMu9v0gMo10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJBWkaZk; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJBWkaZk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7gnTXOm5GUQF6mNNKUCF7/82eIhCasuiVnMlnQDNkpGOrvJoOecYif4o31cIh8O6f9y8P/aDJv9+CdmTL5nauIhyRUEmZ3XwtCzsxaw+l1vPbg54RouaH37fGPBYPaXJGPkmNXkzxnHEW59gotvEqKvzvi0idcEWfoOcmmcgxxrhguv6EG1JF8b+eG3cEfyby8drs3wsl1Q8cawK8yBDCzSt8fksad211U/26XRaiR7czol0TU1isO1A+v6DuPa6WuLsENfvg1AXL5GTMjfFK/wcOSDEazzoM8KudfmCUcwEwSNzh7EhqURVOtcXvwt6sQv2aoNySNbVlB7l60NfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QghQOpbE8ayJFaL3QzyvtRiA+hcmcayNq4Q+5MZCas0=;
 b=jGaibVA5RtnDbqwfC0jGM5sJzGOSMZudC7HX4NmWZ5ApDM8wxBXMvuojiMWagBXFRXCG2jUmCSBD4quoHts2mK/hZRiFAtp6561tVJ4sGdKSt2xhGJzuwZ5o2dqrCENxrwgvpPsyPTAkIO0QWSgTB1Ewk1xkp+hCTKlMDMqzUoXUh1ZPbJS+CJamQzd4ZB6wvZoTg7dmbINrfTGDtWjlGakDmBcaHNDEe0pnnSWTQrbBjP79tKe0fbYX+OcNTm/K5cyMu0lAvi/JX7DXA1OsO4WeBkOUhJ83IuG6lx8kFTqXRxEm/n7SYzbYGNpTix2EsFvz2EjNExCj96rXF7UmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QghQOpbE8ayJFaL3QzyvtRiA+hcmcayNq4Q+5MZCas0=;
 b=HJBWkaZksc3VVRI3ffgmIn6kEJ2GGhIpEulm19QrE18kJJ7SuC8g6onj8tJHk7jdCXIrgFXk5e1PcGDmyvzZEJrsyT3s25eIqvAsNMjNablgyT1X8ZG40CGqVpoJ7tDeZO5EWAyWT6pf2nN8GbMnDM8csxu0ph3iVewFvc0nXNavSEE3XEenB48tb2vMaLOTBLwg5wg9P68TbvUxBzTK6WbYidqOzGhc6V4QV3Fv3wANaCZLUZqSatyhhBIIKV+7kMGPjMnnaTqoC6FIPiw4zy+9C5VxxGWwW11edPe1FPOlCFACKAS+uQm3QbZ7Ry9yVDm6kCIZGVjAqPsylefQvQ==
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 18:30:08 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::5a) by CH0PR03CA0281.outlook.office365.com
 (2603:10b6:610:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 18:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 18:30:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 11:29:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 11:29:48 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 11:29:47 -0700
Date: Tue, 9 Jul 2024 11:29:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <Zo2Bmm0KfEBn2jMb@Asurada-Nvidia>
References: <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
 <20240708112928.GB11567@willie-the-truck>
 <ZowpGi/q7MeS5iYO@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZowpGi/q7MeS5iYO@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa985a7-914c-49a2-08e5-08dca04528dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gpKXEUFgbKIxkhSOj7SdwDMBiRKg9j7kGVTY3ia0nyBRL9qwOlW0RxLP60cr?=
 =?us-ascii?Q?/pHra1wgpmLP1rmFUtz3t4t+J1imSd+ovzBRe7fz/B24Jt6BOOK2y57W3mO2?=
 =?us-ascii?Q?JlrDsMzs6eHvgrQIDe39J/HJII5ALoOPgT6XlMRrrzL4drw8JJADxYzQjyqi?=
 =?us-ascii?Q?2m4k7FI0478tGK5IJ6GP7oH9NjfqrFLzgP8hccAyNNjD67tkOSkOfKokHBr8?=
 =?us-ascii?Q?MI+kLiXdYVP2MC1vw6CJ4v1mi8IXSnsNt0/4Ybr3odQhybAuxlWwb5/Pi2+B?=
 =?us-ascii?Q?TmGpzZEJ7rYbZet3r+wr1Rh8GximOQ/IGPBwj/W/dFyZHt1ZfUj53ss3cBeZ?=
 =?us-ascii?Q?hnV79iJD+klMa+4jsgB7Mh5EEULXgS4pNTC2yoNfPaGKzO1w9sRawrWo8ZT4?=
 =?us-ascii?Q?xoBAqQ9ze7xE4UpHb4AJ8fEx+XVxe/Q63rBC+zfIt+bVVtcJxQdDmoaPK+8n?=
 =?us-ascii?Q?GKKE1uNrK5KJlsF1fMn5kH1J2zP818WVlKBOyEMvOHTWLxJV/9G1yTnw4ow7?=
 =?us-ascii?Q?ytVp4Ue1TPKPeFYHot0e8gNG0um9J/VvWZgLXAq1vJQPPq1kaxRXZMm1Mgpn?=
 =?us-ascii?Q?GDNP5jixme1Cmp8SUmx3CV/29A3tUwko6MP+4LQZkzz2LMQ0+s42xzkdil+F?=
 =?us-ascii?Q?Ogt1cG6eTihC12L70Exh4ZkFnFUSTijZuBqERGtZTy5cbWgiwsNaV0A9c5tb?=
 =?us-ascii?Q?YEzzNGUwbtMkSRlQi6z3nGfkbKQTPLpgPXBQcw5OyAluhA9Vq5a96kSweu65?=
 =?us-ascii?Q?EzrPTpDzXWdoqE342HjXjxCtQU++admQ1wwRci36199Pz8huSubF2TZrjNvM?=
 =?us-ascii?Q?8R1L+0JqMvE6SuuvEgxcLPF40ojqC2HdbTsQUyQPJVLUTxOCieycXxXNkuMf?=
 =?us-ascii?Q?eY6PzMEH1m3zaN2VfGYbemZABIXcKRBguRHbNj2apcRksw/1OUi+3+9yPnXc?=
 =?us-ascii?Q?ugJa8d5ovGdRpjxgXFAH//AAPT6s2LshgvnfBuwRBkNOSb0v9PhY6d7+p10m?=
 =?us-ascii?Q?WuHid2jv1LnzRQC5bG3/nxb96ewMMudnIC+0zG+miYKka9BAk59+3e8/j1mi?=
 =?us-ascii?Q?l/B9tzWZDN/RgsOnC74l+N7TybJnKqRz+r9u+Eaqqn/OAtLONK93c2Qoxu9n?=
 =?us-ascii?Q?lHKcoMSCV68kfws8JYvN3ML6hnmXgEaWITrF/9qCla6Ss8EtyqbRtxUMOyjm?=
 =?us-ascii?Q?FAoZoGGMFyq3mm0clkqQX6HdijM4sQjJdVTc1upHlXbawORnpqILgC9fSIpx?=
 =?us-ascii?Q?dNXtAi3/NXLJakUTydL1AU94osKSghATh9u0OUZ8C0w+xYLDI58A+zCgkmaw?=
 =?us-ascii?Q?NMlvplZz275/Pfu7/LmauDU69ZW3XkfnCZ0MMdJs5XXBUy0OqAf4B2yA2Itg?=
 =?us-ascii?Q?JfDIsPnk/H+AiHsqM7gQ3RdZrBU+Wts76YpSdWECGRsOCDszGTgN1ezMIHYW?=
 =?us-ascii?Q?eOWLS0enNZDZW23V6+0Lz9NenQLd8a8s?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:30:07.7057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa985a7-914c-49a2-08e5-08dca04528dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

Hi Will,

On Mon, Jul 08, 2024 at 11:00:00AM -0700, Nicolin Chen wrote:
> On Mon, Jul 08, 2024 at 12:29:28PM +0100, Will Deacon wrote:
> > > With that, we cannot avoid an unconditional hard-coding tegra
> > > function call even if we switch to an impl design:
> > >
> > > +static int acpi_smmu_impl_init(u32 model, struct arm_smmu_device *smmu)
> > > +{
> > > +     /*
> > > +      * unconditional go through ACPI table to detect if there is a tegra241
> > > +      * implementation that extends SMMU with a CMDQV. The probe() will fill
> > > +      * the smmu->impl pointer upon success. Otherwise, fall back to regular
> > > +      * SMMU CMDQ.
> > > +      */
> > > +     tegra241_impl_acpi_probe(smmu);
> > 
> > In-line the minimal DSDT parsing to figure out if we're on a Tegra part.
> > If it's that bad, put it in a static inline in arm-smmu-v3.h.
> 
> OK. How about the following?
> 
> /* arm-smmu-v3.h */
> static inline void arm_smmu_impl_acpi_dsdt_probe(struct arm_smmu_device *smmu,
> 						 struct acpi_iort_node *node)
> {
> 	tegra241_cmdqv_acpi_dsdt_probe(smmu, node);
> }
> 
> /* arm-smmu-v3.c */
> static int arm_smmu_impl_acpi_probe(struct arm_smmu_device *smmu,
> 				    struct acpi_iort_node *node)
> {
> 	/*
> 	 * DSDT might holds some SMMU extension, so we have no option but to go
> 	 * through ACPI tables unconditionally. This probe function should fill
> 	 * the smmu->impl pointer upon success. Otherwise, just carry on with a
> 	 * standard SMMU.
> 	 */
> 	arm_smmu_impl_acpi_dsdt_probe(smmu, node);
> 
> 	return 0;
> }

I have reworked my series and it looks like:
------------------------------------------------------------- 
@ -627,9 +630,35 @@ struct arm_smmu_strtab_cfg {
        u32                             strtab_base_cfg;
 };
 
+struct arm_smmu_impl {
+       int (*device_reset)(struct arm_smmu_device *smmu);
+       void (*device_remove)(struct arm_smmu_device *smmu);
+       struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu,
+                              u8 opcode);
+};
+
+#ifdef CONFIG_TEGRA241_CMDQV
+struct arm_smmu_device *
+tegra241_cmdqv_acpi_dsdt_probe(struct arm_smmu_device *smmu,
+                              struct acpi_iort_node *node);
+#endif
+
+static inline struct arm_smmu_device *
+arm_smmu_impl_acpi_dsdt_probe(struct arm_smmu_device *smmu,
+                             struct acpi_iort_node *node)
+{
+#ifdef CONFIG_TEGRA241_CMDQV
+       smmu = tegra241_cmdqv_acpi_dsdt_probe(smmu, node);
+#endif
+       return smmu;
+}
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
        struct device                   *dev;
+       /* An SMMUv3 implementation */
+       const struct arm_smmu_impl      *impl;
+
        void __iomem                    *base;
        void __iomem                    *page1;
------------------------------------------------------------- 

One thing that I want to confirm is about the smmu pointer.
I implemented in the way that SMMUv2 driver does, i.e. the
passed-in SMMU pointer gets devm_realloc() to &cmdev->smmu.
Is it something you would prefer?

Thanks
Nicolin
