Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EB26AC1
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461799; cv=fail; b=aq1YHr10+rIKF7JLbn3r0bPdlU4h0zl2is28OHO3CZznESDMBwHKAEXrGlyl58N1QMUb88wZSp0IUgKHFJbilNOcacVP8TrhJbDt4ByGCtzbD8pDy3CISeIhkzdQgz0A1ZMKbWo7o4s1waOLsy0yERNzpo3Wcf6M4VreZe3YLGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461799; c=relaxed/simple;
	bh=hdIufe3itYEEi9+sejpTvTwfBrbuhSmPuwSIBzl+x6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL70gS3jJX8E/Z1Mcp/JnfM79puVXRljMyxEKmJonC6LNWNzxTc3H/ieo+qJsXDJinBB8WfZIaiy7X8CA5/TTpoiLA42DXoyTVxrLO5JklXAdjviGBfRkAoQ42kemp7dsRhxt1CkujpntTWoxjmlIpx2/E635H1QLd17ISuGOpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVkvFv9D; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVkvFv9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMowEjJrdZ5XSDJcA/ErVqQ8VUhl5fbK6toOaUaUEMhpnNwEwcOdZt2J17e0aAttvDwooICo2RNMNzvVAR2KMJ6bjO/Xin0CV0rtGrLwypSNK6nfUSwI3i9zc/vIgzAxhor8BGYTsYauaXYfEaqqJ8bUvK9LqoUZ8+KOtOKyB8kjFRFbae4vmjfsU3N7RxlbzqdF1LNt79TXMwbQ9PAMGT1SJobovwjXWju1gGMH5ERj4FYVDoefBPwj+tGJuJsqNmebnGlmofYuyCR9BjniwVMHvqZQ46nmB4aSFieC8v/4BB7rsAUKTC4672lBg+dzGyKtZefAazfARswuHZnSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0A4TYAtdo98ceoZoMVJepaZYT0AuraloM6v7blE4gk=;
 b=lqht4gzO+SX5nRolGVDK6+8SIrZHZFxEArU/IpmLLLEj/fGsmV9SxX1mv7yT1sMz8V35Aah6QPbw9g0444q8Kfie69Z0Mg7EJoonoEa19yTDJyn2bQQe6RsUhfnaeBN86b4gpa7Wp2aGvsYhKYegWqQ59jP/QucnszKPg+b05/wW9t8EW+8F1qGHL4PrXZOv6BVQ2RGxHRNWTmHcke4z33auTK5ral2J0i4PwlrpPa3MOMrqu6K9pdxMFIHbw34PfLO+X3CfY6hRhoxBd81swE4Wxrg9jpExD+p/YGY6wgRXQw13e1NxuaxPM82BD0I1AFPJpfTDvlN7nXNJIvVePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0A4TYAtdo98ceoZoMVJepaZYT0AuraloM6v7blE4gk=;
 b=TVkvFv9D5iS26LUeBdKmTV+6kdG+G3SRXcerS4bQ+1olOJjg0oPTSSHoouLYTK2P6Bajx34LKLcE6LKWDsagR6zV6F7q0eWU8Js80KekhHwtc5OTaqRzFpHUr3koA1RXyKVRnBEGgXHVFUt6BJMaDGEm9fBpvEOnNrA1bfTfU+CQNIYAfnRpcfsY4dtKCe9Rp9Qb6mau3sUIZrnHxGIZ8f3YdRKqo3igZSi35n780Y1TzXFv4IRAAQ21GljLdmy2O/tIwUaoQc4Ir6uwL969Wi8uSOuE9P2waDJd2T48fGCSQIH43lAaPvQxb46W9PwABOSxiGRr5Kiaq8bquPAf/A==
Received: from SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::8)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 18:03:13 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::c1) by SN7P222CA0014.outlook.office365.com
 (2603:10b6:806:124::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 18:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 18:03:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 11:02:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 11:02:49 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 11:02:48 -0700
Date: Mon, 8 Jul 2024 11:02:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZowpxohD0MMv/9z9@Asurada-Nvidia>
References: <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
 <ZoiQmAszSQbP18lQ@Asurada-Nvidia>
 <20240708113115.GC11567@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708113115.GC11567@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b2952e-e786-4cbc-5908-08dc9f783c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KBfp19Z4I8hEPluYqa5VxvxgS155ojMbj+U5RGoOmmzjSZM+Q4rps2qGbDO?=
 =?us-ascii?Q?GAzc2Y06cRO9Wzh5ty46XaPygjCMBEDFXgu4HB+0NzPO1QtA/9R+4bBtWEAj?=
 =?us-ascii?Q?3jKXIHRQeNFzeOASi9kXIppFtO8uzihF5r6foZMFPJyPlqy9OxTS6SgYD48l?=
 =?us-ascii?Q?sTEmVtjrBmlWXdvyicqhtnkdqPXTNG7t4F3K5HlzD5pey2r+m57ycGgL6qnd?=
 =?us-ascii?Q?WO0IwHVXdFcaXmssJdi+ttPM0uevR4lzTtUX2/GUpYuCzZGwUr+sO7oC1sKQ?=
 =?us-ascii?Q?UOJaFVqTLNwiI5yn4iqBL4F0cmWClk+UQOKpAj2GsNN4KoDzz5CCdA63sc95?=
 =?us-ascii?Q?JyGM9h+046dvZDHzdUVrlMYY6YX6H59n7d7rUwjoBF036aOdv3Jy3t+UQebn?=
 =?us-ascii?Q?CW3gq387Wq2A6d+NnaeGWFJCbKtNX/0my6Wi1BYjmVqaeTxyjWXRYy6rRK2q?=
 =?us-ascii?Q?iAHyekzPMF3EiICMfCwwrlexl3i46GU0C/yu2MaBOXXjWjxJ17q+hGsFqsO1?=
 =?us-ascii?Q?FRki8gF3LI9U8C4P33+wAXGROy3oTT5ne6mY6x9Rc+cXDH/ZVdOPuS0RD9we?=
 =?us-ascii?Q?ma8a/3US+keVUK9GQKXzQNM9tbGyirfw8r0bieHe8m1WIiTujwJT9Wpfosqg?=
 =?us-ascii?Q?ZWpkEBmO2QdKF+gKpaEP2QxvkjbkwYxMdb2WCno81LjY5G6awcoDO/PS6i6T?=
 =?us-ascii?Q?TifqkvtCKAngIOGsASllG9679AyTRAY/PnArB+DUrzzyk1mR+KQo/8hz0abA?=
 =?us-ascii?Q?GbGXjQGmd6u66kJqeDmi+gctOnafEObShDZPanTHISGIzs4fi5fj/TDwmZ75?=
 =?us-ascii?Q?0XhWfJmHmO/rb7sU926lelmuzTAjh3enMar2wz0VUQezbewMthUHRgU1nLzn?=
 =?us-ascii?Q?f+r0VFnbe2Zt10i6tKxTjJi1obZKfqAbESdlZhw1m+7SR40zEFsWvfW92tIY?=
 =?us-ascii?Q?GvAtjZjUU6I7jQfjrm48JIlw5TZu642J0oXYxA6rCM97ajMtHxIlaCg2SJDv?=
 =?us-ascii?Q?oK+iMp6OvDDjzSjaPdTulB4f1OOJDVR4hjmto7HHjxp91BEZ24ex8KqdJG75?=
 =?us-ascii?Q?ENNNIBVa3Ae9iIkJ9+MPIcgFTXlP8gASko04Bxjom8ImyJYlEOhjcgHkhT43?=
 =?us-ascii?Q?kjXAbjdnkXCHTMNPA+b63pMrjUHB7MmwVs9vvnuLOpa+XuuywQBZnxXwo+wU?=
 =?us-ascii?Q?c7HqJYRMgNPb7qbIqIqRoKKlIrhJg/4vP/j7h8s+yI5tC5P/h/9Ueef1IcS2?=
 =?us-ascii?Q?7FzIbFeBurAW1d4ksQR10ueOWWWLCzwqaiEbEOoBKXIcEqpswqkcAOa02dft?=
 =?us-ascii?Q?1p4tR6yqW9Gl1G8rcBViEpsy4/uIiglnPbIH0o+I7xcaiSXAsfdj3AgYBJdr?=
 =?us-ascii?Q?pntG27uXb2tmFtKcPZ9jDAQsmgMFYXvwBcMLJ1bChc6TjVc/4gapaFikO7ot?=
 =?us-ascii?Q?VrQiUCMwVirPAcrdspiivEb7dB70Cfon?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:03:13.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b2952e-e786-4cbc-5908-08dc9f783c04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

On Mon, Jul 08, 2024 at 12:31:15PM +0100, Will Deacon wrote:
> > > As for arm_smmu_cmdq_needs_busy_polling, it doesn't really look
> > > very optimal to me. But if you insist on having an smmu option,
> > > we still have to take in the PATCH-3 in this series, enforcing
> > > an arm_smmu_cmdq_build_sync_cmd() call in the IRQ handler too.
> > > So, it would eventually look like [attachment].
> >
> > Please ignore the attachment. Since we are adding arm_smmu_impl,
> > I figure that we could add an arm_smmu_cmdq_impl too. There's an
> > another small feature that I didn't implement in this v9, while
> > being able to benefit from a cmdq impl now.
> >
> > The impl can also hold a boolean busy_polling, so we won't need
> > a global smmu option.
> 
> So /that/ might be overkill. Architectural queues can use polling, so I
> don't mind having that option in the driver and it should keep the number
> of impl hooks to a minimum.

OK. Let's make an option as you suggested.

> > I will send a new version asap, though I am not sure if we can
> > still make it to this cycle that we hoped for :-/
> 
> I'm in fixes-only mode at this point, especially since we've not had a
> linux-next for a while.

Sad that we missed again. Thanks for letting me know that..

Nicolin
