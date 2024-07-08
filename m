Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFF149C64
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461976; cv=fail; b=Di0VtyZvhFMiwB9LoKuMdgYyL3swdCI6lBSezyIJcpWP/r+enaSgSyI6avo1b9cjI1AdZS5Z5NQsSyNjkK7Kuwf9lGlvmVXbbiKKGmSNBSilqndZoZAqXgyKuYHU6blJaopN2RCtaD1fioNqPi+B48WbWcOnWJ9t7ObRC8f6f+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461976; c=relaxed/simple;
	bh=K1iMZ+YiTgjnKMh9pH6ic7+QnzK3e6bDuqkAWXRBXPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLDQEekCR9ocnKL9WBlxkU7qDtwM0SYeBB85+TvrtiveXw3fJSutPhB0UEdUCHHbcMxtpNn2ggMEARgEd1dMJdB0Cwk5crhmQteZaasJIxKmcY1KVdLBY0TITxbMvXQr7drLoz4E95Y9qmY1uWEmT2E2o9nYzKc60e7T5FZbr0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dJgHBeWR; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dJgHBeWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+0A4/t3wIRyrzNuM5suO7X3kKSJup5zz4XjHLD2c86Z4GkPHa3ZryP7htnXZfRCznl8STfj3QlrNw8Ep8Ke1rV8FCtB4l62p/N9eVjaESW28Md6zWatsErSHUnROe4R3pAwGgYgIeZnU7bL3AcjJFxXoo0P+UPAJI8k2HcM9cv/zfcvqAI2TepLJG0pbU100HY6GocyDkGbzxVPg4XofcaazI4Ilx0NZPEFInL6n+qJLSbZRRooFMoSotjg8PB3nbowV4N5OGwWsxGqvPze/tfyzq+nK68uIbYrXgg/Q1XIhzmssiRLW7cwejxRnQgSnAbDGNG5MPR0oLFxq2b5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjPoJ7jpfE4qdrxX1rrIAvxxC2uQ3Q+o1I/0xu979PY=;
 b=WTVdWXdnNQJI5WWdi9v5974JkW3JuPkPQVuhW0soIXJxVfhyyGhl4CWp92SgkCASnBBkZOvfYjcjMsFWNtHiXifaBM1ABJULfYrQEBNHvJgRnVx58nAzK8rQL5r/uSIeJVGTP7KuMx5BaiKkVCRMVgSqK2mh+FCiLaAcEnch06ZbU7giGYEWi3HY7x1MrH416iRnTC9GklRLDFr3DBGmS6uKRMnErVdMpmkIbd6axqEyIDLrkg/5Y3vS2HMV29wUeIN0PPjt1QUR8Dbcgf97HdkFZNDBsN4Y3vaBXu7n/Z1P5JQVhq+LF6gYZ+yEwQaeQ0FFUVHuUfMMByMSZnklUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjPoJ7jpfE4qdrxX1rrIAvxxC2uQ3Q+o1I/0xu979PY=;
 b=dJgHBeWR/xrcJknUBBBjiRuappJuzwKhQUkXhhdKzHN5of006Gkcm+STTu1lp05loZTaXNIMbRQqV3GqRuNiA9G/Ayll1Cm1TlR/IWcfbMW9BTRBsQwHBYNzef5uYHSDJTW7WIH5phqj0GyuYCyqerhZiwMy9xioPuYDb/TgQhPbARi87a1AzKnF+VgpXrm5uIgLuc7KzBUAAV++nDKejckqoqE0XbZe5k0BFOKcT7fdAJPJJcxmWHIjxmr/P2trDWosx39cqIV9mDC5SYisP/zdAcfiR+DpyVmnYP+KF1OVUsM04nMIEo+NeOJyOChjy6BFuF6A7xaRmsMjZctE9A==
Received: from MN2PR14CA0011.namprd14.prod.outlook.com (2603:10b6:208:23e::16)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 18:06:10 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::3a) by MN2PR14CA0011.outlook.office365.com
 (2603:10b6:208:23e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 18:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 18:06:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 11:05:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 11:05:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 11:05:43 -0700
Date: Mon, 8 Jul 2024 11:05:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZowqdsN75nb2TD87@Asurada-Nvidia>
References: <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
 <20240708112928.GB11567@willie-the-truck>
 <20240708114326.GE11567@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708114326.GE11567@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 073c2b08-6f26-49b6-1d33-08dc9f78a5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XlnWhTlfDy+2dpLjYm6bV47Z/Eh329SvmDlX1uaXVDb1ZgsWdr5GZcknQ6ET?=
 =?us-ascii?Q?r0x0kfI5uwNfvr1nvMgiwpqmlRTn8J2eJLdy16KIgfGOpj8YZsURigWEoRF7?=
 =?us-ascii?Q?1B6uRV4ufgrAnJHyEi2nXO80v/tRSzOmAI4YGqvhD6XkUlzJM1YE8SSF3sI1?=
 =?us-ascii?Q?WNCfHhk3tYCksJvu5QWmILdxVVzfGTsuTXmNFTSXLeDQCMKewZuznyAhVOai?=
 =?us-ascii?Q?lr19ZDHTwQ3FQCu6Cryfp9qye6WrWmmduUJXjx8QLLAhHxObzjO6ak4+7tS6?=
 =?us-ascii?Q?Ziq+SZZOba9QNjPmpmusGfcL/1sRKJj0EHuLHudu/x5NBIZaVHhPNsZPmRR7?=
 =?us-ascii?Q?XsrXBolOC1ObR0EyNbGAntVymOUxq6vUC70yQ8r2tFvp0ECTXkNJwWAinKoo?=
 =?us-ascii?Q?hFJ7QnVFtYOoAJnUQjOSHz7T/8I97gnYAkZ0W7TSySDLZhuB4DIEvXBTzGVt?=
 =?us-ascii?Q?Kyy4s/u1d307Olkgc+AgEwvxJ5P8s+I3pHS/p0b9qkMHh4tMVHxHXYU9xS5e?=
 =?us-ascii?Q?Xzb3242J4LB7AGXo6gHTN2Qd22jt3x5XuMwH2v+mWwiKYCExHm/BFfMoYMPU?=
 =?us-ascii?Q?W4eovRuMHP5IStExPEa0KBH2gWsPMaBUlFgtQc8LtkyA9BSg9kjnMss4d+2r?=
 =?us-ascii?Q?Pb/BeS4eOm78jfWocRnqKRMLO5b96X8yU2uD5eCe5LY+9x3x9uN6mitZUlw9?=
 =?us-ascii?Q?8K6xjW4lFjDl17M63OWFhEoM31yII90BJKz1K+BLnkznme2hAi1nEU0YNHxO?=
 =?us-ascii?Q?t4pGQcNc/kDcVtJrrI1OaYQ84inkChweGVhEpjuuq2AT7q8X6rl48yRsJWY3?=
 =?us-ascii?Q?E90sx+plpxCOW/v4pPr+fEu7L5FsYu4HBmd7oXuqQEiBI2GCr4VoLOQeQo16?=
 =?us-ascii?Q?+0yTVtPFsDSNZ8D7Jgh1+yhMbpQGoD4rE9XwOW1FgOJnnPMszlOfThZVyPpf?=
 =?us-ascii?Q?r7iskPwBPbWEiVYqtKGHEbDpUVj2OjY6nJpk6pZs6Mh08tpDaoOSpv2YJtsf?=
 =?us-ascii?Q?C4fDtzyNEekDM6vvEOeQ0JsSQjx5wZtlcThfnZSsdB1hD33mWSe5YPO6Dkxe?=
 =?us-ascii?Q?D/qq/lswAqp1Gm553iGd+WR/+Ogo6JBjQTZswQZ1eOxjd3FTw3l51yVsWJWZ?=
 =?us-ascii?Q?Me4pg69ommk8rBOWO3sNZny0544VxBppxivjM0USjIdBykFP+btPAa4wqHue?=
 =?us-ascii?Q?OrDHVZ+lYECjkoA8JG1zQM1xg6Th9lC+mBBBBXNl7wVjc874Mn4LAR3pyfre?=
 =?us-ascii?Q?Je6hSrQvB9J7RIxQIaicw01WQqaD5ptWXLcf73oGQsG4/+oq5NToxfISaojz?=
 =?us-ascii?Q?24MnHqOqXTP7lLAhYDoY20Az0+nVMWSKftrVcHPA4R8WMC6CanCVEJugDtDQ?=
 =?us-ascii?Q?ZICmvzZT0GPvM22xpyGYvdP6CR2ogzIicOiy4wqPTP02FkbIBdU2LcJuAzo6?=
 =?us-ascii?Q?KVoaoGIXYyASttXaRaOYfp3JX3WV3mud?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:06:10.3986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c2b08-6f26-49b6-1d33-08dc9f78a5c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

On Mon, Jul 08, 2024 at 12:43:26PM +0100, Will Deacon wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jul 08, 2024 at 12:29:28PM +0100, Will Deacon wrote:
> > On Fri, Jul 05, 2024 at 11:10:42AM -0700, Nicolin Chen wrote:
> > > But if you insist on having an smmu option, we still have to take in the
> > > PATCH-3 in this series, enforcing an arm_smmu_cmdq_build_sync_cmd() call
> > > in the IRQ handler too.  So, it would eventually look like [attachment].
> >
> > With my hacks, I think you can just call arm_smmu_cmdq_build_sync_cmd()
> > from the irqhandler and it will work.
> 
> Hmm, actually, that will mean we end up using MSIs for the error case on
> hardware which supports it, which is a strange change in behaviour.

Yes. I highlighted the smae in the commit log of PATCH-3:
   iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd

Do you foresee some potential risk of doing that?

> What does your hardware do if it sees SIG_SEV in a CMD_SYNC? Is it just
> a case of failing to generate the event on completion, or does it treat
> it as an invalid opcode?

That would be an invalid opcode.

Thanks
Nicolin
