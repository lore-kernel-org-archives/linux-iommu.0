Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9830149F
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927937; cv=fail; b=FZoWyzSA7kgHAWhB84f8rewBlHEVuM9NIMzDKdnOPFAVXUUKvrn4UrWQFLXpd++LcG0CW/spL5yaVs62zPgfPZNnHddBhbNBEO3KZ6qMJXZg6UzdwzvZoXd4Dhf1TusibIAZOD6aDchCLn/K2oXENL8kKPHtp+MfKW5yCgOxlzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927937; c=relaxed/simple;
	bh=T27Y8wR/Ztb7yOgPvkSthugZMevGWAe3iDSXB+//oxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4mN5QRHAZLVLfnhKjWEgDu7XWGCRUK2v+LiZ+YmJAe/Q+cw4OBwbZRTmIO9+Re4W+c1iDsaTx1Xx97C4XY/XruGaF62eIeAOAUncSZQaXfrdeZhbganw2KnR72KDJlHlp8poJkMNG1ZkpZ5YwEz1eLvp8Oxgywf4h9PpPu+dHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhRFF+5S; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhRFF+5S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdqq1t16ftedjnIn7M+oRxP9wHzgCP0Y1mSXd39lg5skYZ4OQMOAumGtp7B87pAyXXT0KwP98829QzWA7zUJAIZlXSrnRG2VXHNbUayCsJbiUO83PelycfoC2cpyUuuRsB9oQQIadidwJpDA/2vrrdZ+ww7ypMeaITVCSg5pC2S7PjmNL6Hs3do1LSFMlmMC9qx20Uqd9BhrZUkRaT/GJBXhwNsqT2gfXQvLtm8ffnjucGtHk1RjQXXj4veMLSD2crmStowYKPxIufsAhd2kcZ7hnLQnY133RpyBlxnq7xInb5eejsAbj4TrZUbZ/SKYLAp3nVdehfvNYvPBqR9/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MspgEZHoRn8etgoyLLUe0QshFSXxkE4WH9MroAlZWA=;
 b=EYkN0MJrgCDRO13LZwFtVL5M01meWfk85fXf/aGjN1Az79AKl8KfdmbxxYXb25LkGhc6iqKoQrrkeVImPoEt5b+K4psSSYe6xMZiP1FHaIKVYm/2P4kOd5rOoOvYcf/Fo7KoONadVHGPO/gs16KaCJSyhJZ85qVkkN8pVBPJ2lOQSkFIMSvRoHzXYFtCIpMVRFZmyzPh6Bhz4lh/4DfkWThTiRyDIzo9oG2YlPz9YkTWNH+nC3YJuVYir8NXp5BjEftWaEnY4cfa0Ayz8V9qwzQ/2QCVWIL8OSWOMhduiVfQJm6vVPepJw76B3zQtYS4MQpTV7mWd0Ti6yeMgJA/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MspgEZHoRn8etgoyLLUe0QshFSXxkE4WH9MroAlZWA=;
 b=UhRFF+5SbH0a5AcyfaB6hUSwx7UtyceZOfkyGnvfJPLixPedYj1gOCfHifWghaBihK6hjJgJ+GX8FXmDZIHx2bIAoqhUfPwDN8Y+exbTm0Ri7c7vc+4+5iGg4mBhMYp1pOWVvs+/JBx2Ej7bx2bL5ey0BdBZc+9Nk/8zpwXKzWI6kU+TpjBkcCPvA/PCs0cz7rfTh5vjKHTUM1em/mpteW8M11Cbs+MnceC5mu8SXlghs2IPu+91gIu/X1zSOqmZDQs43remOWo+pE68ErQd+qUh4aJeDT4OKktSJ06YqRpbUUPJplbaHZzrFN1qgFeJu5Wp1zDwvGD0pljHJKtbCw==
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 20:52:07 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::89) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 20:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 20:52:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 13:51:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 13:51:37 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 13:51:34 -0700
Date: Mon, 4 May 2026 13:51:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afkG1KH46bmejhPO@nvidia.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afkAKlu4nllduGCE@nvidia.com>
 <afkBqQz90OLkY4IN@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afkBqQz90OLkY4IN@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: b90a69e0-ad0c-4654-5774-08deaa1f014f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fuNfoeVfSOjCVE30sxyixgwJH72IqDd24taX3wdU4ewpDDxMOF+cKyPciHX3ITVf5HC5yin3ljyQJaXheLe9wiVMpmhorwHJPayJnRKkm6oikSLVRGKjzT42HmEF8c7rReHf4yz/5/L7+exIEC2LwmCxZJ5zThKUe5zicr5PEZB9NgL9zryDD0So1796VraZL4Rr1MAfiCoRoLrGKlvDuy8Tf6cJ553BUso4NxtUQDXaVyXbTkdLAAcmY3b8nmT1zX+RUhU515qXPJFFikbZCIFqUZHXubG/omc3KvNOHvRAC/KMxZ4nbxuhD4BjVJsPAK3HZgaUmW+5P/eXn2mpS4umValEYBAIvZVwEc16ikC1W/aZlXVq3hhRVXlPDGDLMpIj4WfB6flgEnnF7HpSluk0eH+ZXg7Qhem8MI7K6G0m8E4yHqiSBXuPHjBtHfhQt5Rcye5UjP6R7J9iTvtn7x3FxHLwR17fa+/ahBllSQnl35zEvVhQgdmiv8phyf8in+yxE3QYZRV5QRdrEizVP48XPvWD6KYr5ZgOHajWinm495fKZQAB0+qO2Lvja0vOoDZPMjF2rWeQe6No+BYQT1+2KSSmwRWEhC0/08Hel/pfQt46YACTAF1lvWMpGLOrdRLk2cMrshmotf1KWdEdYLX9Oy0yMmb4HkkffGM4YLIA8WVGvv5EkinJzE+BPjROhBUuH/PY6XGx8EDYQzbxCQwdNB0WtcKb57dZqSXkuL8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yG09BLdkoQe4NuHT2cSKO3ZtGRhkecAxYVZI6kf5hf9dfVh9HwoHhvnfKY0jYs3d57uwVWGMM3SwOdXAid3ReAgy6LtdNRJrz/0uoDbFQuqFYSDpn15RkGfpoK3eerWc3VN2D5vT5VHhndLimlAHXJEsf5R6RTbyPSgcSPfzSBvfm03KIUCBwGXAutFdNAU6IJ0k1WHLlniDMsYRG6V+ZNP/e1ItWoboBLI3QzNVq0hSv1fQ/8GRmlXwkvYDwaBghBSdvk+ozJdpS0ZSd1wirV6xUO4wDUCPCiqiorgVXhgLIjBzVfqEF1vadGLGa8Pr+IKn06uk6j+yZiMWjhEBMjZBONjXOZ38/VDnpKX+DXOcOLDdFeXYiR3+9+3BxXVs7gJUtOEU4u15BQu7hnXtW++LigQYqXFyujY0xhPwtcQ/kn34LanfxMd9CX6m3xPC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:52:07.4391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90a69e0-ad0c-4654-5774-08deaa1f014f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983

On Mon, May 04, 2026 at 08:29:29PM +0000, Pranjal Shrivastava wrote:
> On Mon, May 04, 2026 at 01:23:06PM -0700, Nicolin Chen wrote:
> > On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> > > On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> > > > On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> > > > I am thinking, maybe the call sites of pci_enable/disable_ats() can
> > > > check to_pci_dev(dev)->ats_enabled instead of master->ats_enabled?
> > > > 
> > > > Then, we keep master->ats_enabled as-is, so detach() can revert the
> > > > nr_ats_masters and ATS invalidation entry in domain->invs.
> > > 
> > > My suggestion in that case would be to update arm_smmu_ats_supported to
> > > check if the client is a VF and check if it's PF enables ATS:
> > > 
> > > static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> > > {
> > >     struct device *dev = master->dev;
> > >     struct pci_dev *pdev;
> > > 
> > >     if (!dev_is_pci(dev))
> > >         return false;
> > > 
> > >     pdev = to_pci_dev(dev);
> > >     if (!pci_ats_supported(pdev))
> > >         return false;
> > > 
> > >     /*
> > >      * If this is a VF, ATS only works if the PF has already enabled it
> > >      * with a valid STU.
> > >      */
> > >     if (pdev->is_virtfn && !pci_physfn(pdev)->ats_enabled)
> > >         return false;
> > > 
> > >     return true;
> > > }
> > 
> > I think that's okay to address the issue for now. But it assumes
> > that pci_enable_ats() will never change so it won't fail for any
> > other reason.
> > 
> 
> Hmm.. in that case, could we factor out the 
> 
> 	if (dev->is_virtfn) {
>                 pdev = pci_physfn(dev);
>                 if (pdev->ats_stu != ps)
>                         return -EINVAL;
>         }
> 
> part into a helper and export it? I think iommu drivers could use it?

I think having two identical checks in the same attach_dev() path
isn't that necessary..

Also, stu is __ffs(smmu->pgsize_bitmap). stu should match if both
are set. The implication is still that if pf is ats_enabled.

I prefer your previous version.

Nicolin
