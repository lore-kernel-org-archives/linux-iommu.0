Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797EE4A5C2C
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146852; cv=fail; b=U6OxyFkgtQIqkStqqYz7JNVQ15vRYDleeX4zqSv8yfsW0fZXqSZqxCqRg8yZKziFGLZ3O6TNWv/ry6b1O9iT4bKjxZp2UADO2TlRaomppNJdSbuHj2s/dwvVZtLDh+ODBHxK02/F8tY+i6mkhNCwOIDT+qSds7VHBoPqUzl/n/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146852; c=relaxed/simple;
	bh=zRclpK5Q+r778ubDwSS7+pc30HSgTtXGT9q20HKhWRY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZCnBTh0j/ZGDcDEYNr7fYTRneTrWixKZ8NqO94aVdGwrI/4lrrQFrx46HGCfNYc4eF2WTMZC32Puux4eaWxG2Oorb0QJN2/c6q7aCuM+ITjCO09/pJw/dypKN2plQKk3sdmVDyneZTcc3KB8B0PMZpQQVsorq520CbJOALsIuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/JzfnmF; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/JzfnmF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/4fQ2u+Axf/ELTBYmGUKt9AaanWOX6hLPMMXLEKYCgrGkC1kiNy5aD+UyeiQ/z+275uhhRTmRUgVVFOMIon8Ru2Q9JXvkTGZJba8o7L83vux688yWvOUDW3e9r1tjWK3iO1va0Ytz7wRD8ub90mJsBl3mRre9ATN7VkogK1D4oe+NAIJ9472cp7rMzoko7m1Pg36HdczYdqVjm6Isp9cZz7h6CBX0upJDHoElHTtoQEWqWGNihaoPSlD9XBFPb9UmPBkApOUYZ+F5MioaOzNyQl6M/AUf8LlZ+l9Uf+8GobWoX0z43B6lrB/o5wCJK7xNbdq4wiOYj2czdrlxO0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlWAed+/SrqJQekZMX1xSkZKywb/agcxG25UCF/2iIw=;
 b=R5HFI4HeOdiLEb28lZ7KATDP7pu9l/86rUHG9od841vopiupDlicRHY5mfLtjhcENrVQiPYE+hihR+sQoGaMSG5l0aLoWIAByeL5ef+QiAAjWbDIK56/W/ZrluKZ88GVlju0LBH2j6rU+RryCG+7LX98Jhc+n9qyT+k8G07vhykFf8NXaJZMRMRFAzMQ6nOsu1SOCSlZ3O92TocW3UIaQl2Zt33EEaDIJjNR5va3116L8pI6pgbabcbFXf/sk+mBKnxhNodydd8pAzODXps5zynzMywkaRY2n1tqRMwj4fucuxZ6opG0RCsDrfbJV+u5EzerjwExJcikiLNoyMl8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlWAed+/SrqJQekZMX1xSkZKywb/agcxG25UCF/2iIw=;
 b=L/JzfnmFiHX4XmGzJxIQNhf54prlgwqJmLbL+YksNL5URYDk1DlMY8dhroFz6450WZ7Q9ZI+jsbE0sRQjMwwMGqfarWK9uHmACLdtfPQQxSnwBt07Tl2Rh+6dJCPSl2g6AGw1Jo4KvBzbENEbZVeKReGROKT/uAC4FVDUgbxc0UOHNO4pjneaU11PUc8Hdw2Xq3N8ZCbkC8safmFMrlLcegmTmpUhpUrCbSlSLwtQahPk07LwBVSew+r1ZkKRyaGkmBosKjq90gkyBTo3ivsaHjIC3T8+GRE5DOX6HQluFYw/X9wiskSbdJDDDxESAdStBbv1bhAL1I+8MfqxCmZpw==
Received: from PH1PEPF00013305.namprd07.prod.outlook.com (2603:10b6:518:1::17)
 by EAYPR12MB923140.namprd12.prod.outlook.com (2603:10b6:303:2fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 20:47:25 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2a01:111:f403:c902::d) by PH1PEPF00013305.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Sun, 4
 Oct 2026 20:47:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 20:47:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 13:47:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 13:47:19 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 13:47:18 -0700
Date: Sun, 4 Oct 2026 13:47:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asK7VILK4CgEFjdT@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asJTsw-oWDlSqNa3@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|EAYPR12MB923140:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8efcbc-ca6e-4636-048a-08df2258b260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jM2qrAllgSdQt2RTq3j00ncImY325iB7ZNQ2ofPGP5vOZZQcgUVha6AM3lBUfigrxlhVgFgC+sT9a2E4eOjl6PPE+AKDe2k23CT58hrR+0L4H6LK2OuziwciTjsMZra7wyROIFtggtxE1+tOt7oe5lu7O3vwazOjhI6LPLMnomNewY/NAL02+NyuNRJNEMdImXS/hMEkl8HtB2mjfYR2cJQOujVYS+3aq4Da6mt2cWRV6F4DR24C0tcTOpWE2tS/eTU4aiNIJ+1P7Ko8MKV8UH/CKi8dARI8YlgklVIHy06bNIlpczq3RjCe2XP/yz+dybaAS6qkztOwQ4FPn+BoT/i8u02U+9DSQ78UDdgD85u+UHhpNDH503BoKNyAuSZsH8RxgQfiuEj8gNkB/4+NL8AZYDZU05qxK2w9TTzns1amYgIUM93xO48mIBKj/bw5eckIzjXDS4V/N/kgeyLNhsGi/1wfL02Z0yLFmNd0O5KZ8imC7DNbUg8/DcMAGVQKUt9ymNd1DE5xNVWMCvol6mLS2iNUI+mWZjWwr/zB5hp9S7MuDPCuWzDSOgImAdNHuvDAMzC9kiGS3lIOcCn48jfl3qvs/l/HnKMzfKtd60uF+A42KzEAFXxmYoo6DlgPkCdXUP6Im0O9qDwCTaX4+LT5br1xLG3LYhDTl0DX5N/E/ddvZ4zr6U95hR2T8Y2Tgmcnjw0aFmkjNsyGTv3Hlw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bdzZcHIDQ/8xC2Xj/jpzwVq7alsvddXyQdioWv+0quzJ0/XlA//FxVIS8GRAeqdgD1IfVh3QjsyFr1oXqJQRq6iLWjY/0ms12yyfxVV2naadWldnLBqcrRMrTJraSoiwb2mqlp1chbz59qQO3SEwKcwsPQbt0EA4r9oOFutJOfSqfWw2mTWR8wmNDsem36NRPkbzPXGGSx8j1AIomCJjJTF3sw2cQ6vwnVmCGrSo11eWXjuo5/pgA8ztkU98lD3m4DugnYSBXCQk0fvNECLYWl/NH37HmdzH497Wqofv5QZp1VUcwKaOz7wM2Fo27NHJDHcMoyk4kCy/GULjlTY7UuGk1SY6QgHEDtljMx36rwlaQUcb/Mt9aiEJsN71ch+1dwE3okHM07FJYLAg3DfFLTdGz0T0rM94aZeJ7TJo9D4Vy6MsJnEtcl5BFsHMrEIv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 20:47:25.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8efcbc-ca6e-4636-048a-08df2258b260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB923140

On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> On Sun, Aug 30, 2026 at 04:18:07PM -0700, Nicolin Chen wrote:
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 229 ++++++++++++++++++
> 
> Please don't put this here. The live update / handover stuff is going to
> need very similar logic (see the RFC from Pranjal) and I don't fancy
> having to rename or resplit this file when that comes along.
> 
> Maybe just stick all of arm-smmu-v3-kexec.c and arm-smmu-v3-kdump.c into
> arm-smmu-v3-handover.c or something?

Hmm, Pranjal and I already aligned that cleanly. And there is no
further rename/resplit in his series.

arm-smmu-v3-kexec: common helpers for both
arm-smmu-v3-kdump: kdump specific (my series)
arm-smmu-v3-liveupdate: liveupdate specific (Pranj's)

Each of them is built on a separate config:
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
 arm_smmu_v3-$(CONFIG_IOMMU_LIVEUPDATE) += arm-smmu-v3-liveupdate.o
 arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o

If we put everything into one big file, we'd add the two individual
config guards internally, which isn't as clean as currently IMHO.

Note that the kdump file has a very long notes (kdump specific).

Thanks
Nicolin
