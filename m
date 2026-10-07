Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B01390231
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404405; cv=fail; b=I0J3J+XI6lnJff37kO+WPw71jSXrcLwPrvEUZIzyNoNBpM/Xl3UFzDMcTt9JHlf6gafsLLBpyxtehRMxRzNsnej5JtCq54gV0eqltxVUR5kchJPHvs1tZSbZxWMlW2rT0Btu+7m6IsVtS/Jh3FRnbm/r+j+ZFTUoK2MIZ7qbOnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404405; c=relaxed/simple;
	bh=vuAc5c57T7/wMIYyWz7P5G+qNZS5RcsnbQFD7rMF/A8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PODvgd3wrxi0YVY9GREXVDSp+gDZ1awrwWP2AVK0mxXJM+htjMaEPsADNm4rebdde7cQuzrGZhaF4TaownLJcZM2VKDUK/z5vHhg8TXzHC+zv/tWVFOq1EAQTED3xtO6Ilzmqyjh9AD0geGAsRHKHz3uM5tVIkcM8DktLmoC3vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nrtsK0VD; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nrtsK0VD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUjyQBe8n2quevaZcij6zMJfj5S30ZJshMoQ0TCjoMkQcjlluGEkDgRsshjdijV/nWW1bsaf/FIfaJqj8Mh9aM/s+dOZSDBG28E4q5QPfUJj9PjEem/sx+Hxhf6IKc4TdNBP1VPcZ6gXnrXUb2NhzEZCNpk2eKqiWxcfhucjlhwKzp1n27YcOX+MfMEdcKowe5CtJT/MCjr2PGOAN2CpMNx9AQt6UWxAJ9wEmIWEbWbWbxu2sKXe82xDJqukw2FRz9SZYd9fEC7t57qlKWkBHQb++qf03h1KvusjJsc5APvOmQsAA9Lu7QPLe1qvNUVnx1FkmI6QSuR30723nR93XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zeMijoPUBTctuNIPymPjqlMt9Lrq4OIe2peFUwF79g=;
 b=eCwwaMIRSygfnfjjC+icS1bYEsWruKGAUBbjxiLcsICEfPWcd4/8/AJ/+fyBAYVF1EFUNQj16h/fTYm4MKlCMZWHaXInBc5/Ylqkc+L1QqcbdAdyJeXtDsvvlU1uJGyhwW7PzwKPqr0It/8N5vYfhDL3V9kPQ528WRhMqS37X0R4SpGOZTzLQ/3hD+orvLsPgjhVJtYmnNm60EMO7OQoSp0ANs345iCkYXxRhYpwy2waUgtOsbqhBfYsOJ+KSv44pFJXNjGVrbzSd25uukgE7HN4zgGUSAf3L543WE0BRizw93TJuWhdHo2C6xEIbbMsQrkPr2ytAtZq6hS4d0JQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zeMijoPUBTctuNIPymPjqlMt9Lrq4OIe2peFUwF79g=;
 b=nrtsK0VDROhKBz0LZBWvAR7yYZxBVKCuXot4ivLCWxG3Ff6oZxFzMxd5h/JKURv9hcRnTDxAIK1HuT4/NubkQewWf8a5q8QyIOnM0ay+lcene+Gkz0mQdQOKLI0YP0imwq9OXAClsScESOsb29Ii9gPPAurFuvm6a0sV092WcG5Hf+cgy4l1xF2poOyn2sUqzW8vQMJtBV28Md38GMjMv8cqZbVpKo4/UQxLLYyWZ8LUhfuG8yw8n3CXtt5OFlFXlwoN6dqNFdZBT5UQ8y3Rr4YnGwjXSnhk7aHZgFBv0kRHWqAbkubhi7yYbjW+gQ2ll2WEZ9TiffD1ca2g1wY7IQ==
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 20:18:08 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::4b) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 20:18:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 20:18:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 13:17:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 13:17:36 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 13:17:35 -0700
Date: Wed, 7 Oct 2026 13:17:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu
	<zhuyifei@google.com>, Pranjal Shrivastava <praan@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 14/18] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <asao3APyx7fkL1TN@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-15-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-15-skhawaja@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0331a1-ccc2-495e-27d0-08df24b019ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|7416014|82310400026|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	h1NYFRU/QSLoW9kUEYvKes5q9lxsrHK7WfJkLiZB2RKRJ+yai7uc8sPgmAe+dUhpYqJbAoYj4/9inxZI8ST5Iz59wbvBbIYGWgtU67ORB8CZaVEHitjn+CLZPVIISjNxrLLjeiResOX4Yf1Ubd8GVgRbOZB/KWMsJi8if9lo7JWYiahHqsjBV1OrO1+kAC/4YgWzXsHFpsGS7iJAAq27/q+hjgX68SLvohl+6qOUftPO7P3Ha/sDsmzDEIR8mcWZ2NfU7p2mbpOM6RvTRcDHMlUXTmtY2vBAGhyylBur/FVZYJ2j37GK2fShfwqDeNwNOZrZkNYqBMr80PxmPMDcCSQ/ftj9HzwYN85mXdmiWEuu5QmHTlL30sMzsftlYq5GoDcg0p0ZlfBruFq9Cjkb4MzsfOO78FQeGCmqlgtNfXKlGe5A8i5C2LcAwhMmd3/E5HjQT+o4wtHCvfyvBB/X/owaw3q6LyUnJtdC/WPs2JI+5d8C/lMz6rLzQcQL11YgTngy1nurJPuHsbSpO97LLO/Z5o3gpVc9dULodX0yoclha3QVSC9uRm36jteGCY/jYrLukKNmACiT/TkW9J7jF2t9j9+EZV275U/rlv9sYdN6Hw6W8CMRe0Oci3rbbYhGvTBYQSGJRsOVWLpkf6k0qJK1v7Fp+g0oabrasFPA9h1cAijkJ0KLPbjCdoSyJILsQMI1JpKsKBFvM3sDrid3cw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(7416014)(82310400026)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pckpze12GBqKjl49SP11pQag5jhAEgGBaZPAGtk4uBFcH/AQPCGiUx4XvBr+FblikZ3ov+32s4FBNWPBr1JVQVgZc17bemuP2M9hCQKxLDiNodngjYUmoGeRXkSK0aESaRFm9eHVUBUjk58DJ401MY8LhC/cqMRKjLDx9Qo54n1Q/LOIuZojRCsTV2oZ4uQ28VDb0gpxS6kFcDu7MoBs5qbgnZKDPFYaJ74VTCt6QWbHTxM52E0SvsOxfyl+AxB7pZ6TF46nMCHVm7j8Wu/kH6jovzCQcq+xITOHZYIilVyn3zJhyiohYYtVCZlNWqBEyMAOrPXj5y761jAcCvmrrmC2Nm3tFt+Vl9St80dvv2kgtgmrBR5GlcPXQLx79h25628KmdR9st38mNAKBhPeFL3TP+QkjABBMQ7Q91d3Iy3sGlNFRD3Lfeko0+9t2hYg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 20:18:07.5979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0331a1-ccc2-495e-27d0-08df24b019ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

On Mon, Sep 21, 2026 at 12:48:30AM +0000, Samiullah Khawaja wrote:
> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_target;
> +	struct iommufd_hwpt_paging *hwpt_paging;

I'd move hwpt_paging inside xa_for_each_marked() and rename it to
"hwpt_marked". Then, hwpt_target can be simply "hwpt".

> +
> +/**
> + * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
> + * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
> + * @hwpt_id: Iommufd object ID of the target HWPT

HW pagetable ID to preserve for liveupdate

Nicolin
