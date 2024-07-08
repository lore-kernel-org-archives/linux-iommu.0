Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C14149C43
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461626; cv=fail; b=sy3J6XD5LTK0DVzGG2sM2tGeUCk8Ea1qBUIrgc2AFGd8L8/EbtxAVJW1mOvdMw56N+IlyLxjQBlNt6pg9XWduNh+jX7YAJ7xGSII+LcKmAe+kyTP7lZsQoWgnXCMpwBfBsHsuiLF04SGrljJBeAnfAAwe2+U0Nr2OsL4E8QCKI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461626; c=relaxed/simple;
	bh=YHD+IUTgWhh3Q2uXB03FRo+20ysHhawR+2R2EMI0/5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZuP6XmpP0xWvRsN0P6ZziLw4ZEvSOHJNA+Iasx5/QXbUogPI+jS/rX4yIMbTqiNeoqsp7zhfLLjUGP7q0NDTVhBCA1owUBtjVRWbEEkKLkYodEJx3mqz43iRiSgXq+Z/YbJn1GBUqQUvr5GaFfD2/qqinTJnIrJz9mwjoP8A5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOczIMa3; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOczIMa3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUxqrHVpoAbyyK6+MTblz5qgrtg+85TCZx42CwKPvlnhAyqBOBPQi4T0tVUdJJqvmuWbFIp2OZkwR0cTrm/LcA/CtayH51RAv/BDq+o27AfF4osn1ezQyzjDwVGN/5qBZ45OHEvpGYj5cFbxZ69ei3epbQwoVhF0SvTyVWPyWU7OCNJL2NbW2bX8y9gnfENmVWF1eVkrhDIS9bgGapqCRQGhmuPvOXsZWyyw836+FRdIfsf+vN2p5vJvKBltWxws12y+F4flDoU8yUCUloOd/YLJCD5uA5e0E157ji0PwcgaD9Kjj+sq09PiDO/O0KnJahWYnIyBzX48KEtpJW1w4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxOmm2epH13EdpJ6HL/edlHsyICNkqJmexqRtCIPnmo=;
 b=FnNKv1VzYOVYZYgZ1zuOiJbObqO8z4w76WLy+v1RchGsARm3qWmWVOWxMGZRoauasU8qNOLczAaOdYQvgljQqyToeKQcmHP3OdTx2WAcRRdPKa+EoV7g+d7EBt+0DVSgPMsrwCeC8NRPE3oBLrOktkp317jwmSlfgekJ3j34I6x9yje1xeF3umFSpGP+m5GU2V6EvmRoqFUrIOw6mkruK/wzQ5kTEx6RoOO4jvjyUaMsXkl1kpE8Hnv0oHM6clTpwd6zknrq6CQHRR9jgmXsp+j16rGk8oUFteqIj9hxqpcJeTTSSv4OJEx4iExpmmwKU41wszpl1kNGH55FYeGDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxOmm2epH13EdpJ6HL/edlHsyICNkqJmexqRtCIPnmo=;
 b=fOczIMa3smU79pLlTUsxoa7KRyURT+KP0G4PkkrhMt5DpzwLIryRqhrtzPhnLFIKx5LGWP5YxegxiPTfSEvnr8PK6KJKimc8Y37zTaT545XfCXpSRukZiuOmH8jNfvHq/cawCMwCpuZGWvdTZ1n5IQE2YSKM4XwDsE8+CJvGXuXihzRGN3zbJu5Ji9duywRMAwLNkYENfrLYW7ubbKUiP1Su5ovzP/PXm36mCqb3yR4Zj8gIgA06TmiRLIzoKBjT/lFsQFS039tVb4It7N0nU47kstYRzQPs8rzYsRkDBpbMI7jShS/5/FewtdarT/M5j1zIYqM2yizWqrwssUyw0Q==
Received: from PH7PR17CA0069.namprd17.prod.outlook.com (2603:10b6:510:325::29)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 18:00:17 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::58) by PH7PR17CA0069.outlook.office365.com
 (2603:10b6:510:325::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 18:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 18:00:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 10:59:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 10:59:57 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 10:59:56 -0700
Date: Mon, 8 Jul 2024 10:59:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZowpGi/q7MeS5iYO@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
 <20240708112928.GB11567@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708112928.GB11567@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: e17d9c03-375e-4615-e652-08dc9f77d2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wszt82HctndE/6+MUAWVwGzMhNQy6PocCJq89KSlx7G51pNMDUZ0PkP+7ul8?=
 =?us-ascii?Q?36a032VhBRNmXbZdSPD9eiwYswyFlTx1eA8iwJhQnxL/YQdCAee4GzWaolsz?=
 =?us-ascii?Q?xdnt1mhe5sl7xgkqV4Dr60lprBohny6AnU21w3wnFftM4RHWeyQwlZTQtX/W?=
 =?us-ascii?Q?RyzctHRRRhaOPFQdUE00GVuCZZm26vZogkCDvCY6+eIUfc+8v/deST+TqDq6?=
 =?us-ascii?Q?+bcgeoXcTITtQBu0TuMWyIVEmaP0QiNEKjI3jrCRP6XUyb87LLlgtgkX7qGe?=
 =?us-ascii?Q?UnldTgjsXg6tULKJjHT8TKQSdBveMrEhZmfMHs/xbw/rHRwOGR2vU7y1gBUS?=
 =?us-ascii?Q?b17FXIXhoeaCCtyVYDi/k8f2azI/H+S9vzyqkIff9VnuzrmCpLTfGHGbrLFh?=
 =?us-ascii?Q?sxGFrJ0fl537wFZMXTd04ye7kqkpvxHRkKuTDy7Gjli8ndd7D1cepTVAwikg?=
 =?us-ascii?Q?tTR9aLFlWvwhwM6DBuyWAEA4tpnMSsUlswtx6eQ6jqCNuatcocqTzkDQTzdW?=
 =?us-ascii?Q?yHYkxYoVo/WjOoBxCQ8k+Kke4D2coJ05DePPZe1MOy71mfINrT99qiKvURGe?=
 =?us-ascii?Q?ib8JKqM1qHZ9EaCtcJApLUrSpsbD4qEtTSAffP+c/Nvmeh9Q0V3oazx1BpnA?=
 =?us-ascii?Q?vvKH2E7bXexqwVWME3ttRW7AcmvWONF/hfZdmPJcZl/vJhkFeCUNGaJLYXju?=
 =?us-ascii?Q?dKfE7W0Nqcu5+TbAqg4OvpN4DK4MyZNwS/WjXOPk/nfSPq2TAPSPSxVZaV8C?=
 =?us-ascii?Q?qld9TvsjVZp66FKDPshtv1oQjEpXqWJPnLctzLlaGKA6WzPgJUt8qggIt8my?=
 =?us-ascii?Q?idfwFVaUk74lXgZClJdxdPqOwwafTXrbMmQo14phWPGbxJVuAwxxLdU+iiHs?=
 =?us-ascii?Q?izIlwyWgKM4LanR7kT0DrPQ++nkWjS19WSYLigDnDEe9vE2RlJtERoQ1XEbj?=
 =?us-ascii?Q?3vCQ8ea2Z3dyfB6wqSIhOhxcqsCyEr1VrA/xZ9mUnxvtTGX7MKPwleGcG60g?=
 =?us-ascii?Q?7PzvNKSTQQb0M33sHD8LRMiIdo06hDFa7E8AWanX0mZSRvbLJqJASRB/5nMV?=
 =?us-ascii?Q?PCS8MXyYcSt/RTDy2TZV8eM2aYl14x+4FVq1HaX9Ri7K0pADuIVp+KWZG3hP?=
 =?us-ascii?Q?5Er3PmQ0IuHF5/ebfCb/iIlAAxQw0/WBpIFMY/4HRPvqyN23Oby3Levdmjdy?=
 =?us-ascii?Q?rDq7gKVXaIy4ho9fMuOg1B4x41NQ1dygZWNQ81LNpVC/54xFrG92uDBszHMY?=
 =?us-ascii?Q?O8w7463PpCB1ygbNfFdZEncTqrvZDaVvT73DKNHkGHoSGEpgVKe2sg2BGM/H?=
 =?us-ascii?Q?Z0T++cI8o/CNJw410EqMQ7AuWHyCSblN8/ip6uChR076GwHfaALbO+uXVz2H?=
 =?us-ascii?Q?VCldiTZL3dLXiHBpOEO0fvAAOG/XMaLchg0kS394sdE/D6bXQ62C4qYlTwu3?=
 =?us-ascii?Q?JJQ/S3HUOBA7lv0h1EpGer3JbyVlqsIE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:00:16.4995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d9c03-375e-4615-e652-08dc9f77d2cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021

On Mon, Jul 08, 2024 at 12:29:28PM +0100, Will Deacon wrote:
> > With that, we cannot avoid an unconditional hard-coding tegra
> > function call even if we switch to an impl design:
> >
> > +static int acpi_smmu_impl_init(u32 model, struct arm_smmu_device *smmu)
> > +{
> > +     /*
> > +      * unconditional go through ACPI table to detect if there is a tegra241
> > +      * implementation that extends SMMU with a CMDQV. The probe() will fill
> > +      * the smmu->impl pointer upon success. Otherwise, fall back to regular
> > +      * SMMU CMDQ.
> > +      */
> > +     tegra241_impl_acpi_probe(smmu);
> 
> In-line the minimal DSDT parsing to figure out if we're on a Tegra part.
> If it's that bad, put it in a static inline in arm-smmu-v3.h.

OK. How about the following?

/* arm-smmu-v3.h */
static inline void arm_smmu_impl_acpi_dsdt_probe(struct arm_smmu_device *smmu,
						 struct acpi_iort_node *node)
{
	tegra241_cmdqv_acpi_dsdt_probe(smmu, node);
}

/* arm-smmu-v3.c */
static int arm_smmu_impl_acpi_probe(struct arm_smmu_device *smmu,
				    struct acpi_iort_node *node)
{
	/*
	 * DSDT might holds some SMMU extension, so we have no option but to go
	 * through ACPI tables unconditionally. This probe function should fill
	 * the smmu->impl pointer upon success. Otherwise, just carry on with a
	 * standard SMMU.
	 */
	arm_smmu_impl_acpi_dsdt_probe(smmu, node);

	return 0;
}

> > +     return 0;
> > +}
> >
> > As for arm_smmu_cmdq_needs_busy_polling, it doesn't really look
> > very optimal to me.
> 
> "optimal" in what sense? In that you don't like how it smells, or that
> it's measurably bad?

It would potentially not work if someday an implementation has
two secondary queues? I got your point of making it an option
just like the existing ARM_SMMU_OPT_MSIPOLL though..

Thanks
Nicolin
