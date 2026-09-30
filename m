Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8851EDE0
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804699; cv=fail; b=bguoWgPWA0VtGCveuxIvgr9eHC1fY+MKKotJqsOpQNzZ+H5+xSeaa0KJTkOEsGPwHxvCHd1qL680YTnhsWyqogzI68EKDpK5KVqD7Nm69uApsj1ZRTm4hgXN/bFAopi3Ei+Afaft520mg1NRBwiyMO6mG/ah3B6B7K1cpFH/B6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804699; c=relaxed/simple;
	bh=6x7Xj4sqTEa0c+mbrToNwVBe8bdrFHRp/lZ75pnjCvE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCHEBfMbBXC9NXZ4bHMeNW8Kla3CHYawB2dZSAvpJsTPgAFqbr5JX7hFThkcPjgkzkd+eA2vUc8X7AnElAfAMxXdxwwqGbbUby0Lyg8VY5nXTz6dXauD82QYMRgUdjIaF9u9WhCb6H4vpZ0CdiZAS8kec+zzE5D7HQYqX/bt6b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4TAnaBM; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4TAnaBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoPS+YlnFDXYombUUBHMZ+yRQ95MscopmCoGSS8zXm/9/BDPv2eVWnlNJ/VBOIGN65Q94QbxiLK1vePYp/5P7nTu876k2q8ZyC43TCRANHM7FkjvL9Hz0m5GFmEEtIHNxWgqAnuRdc3lf/s3PbJkZ/er3P602J1gp9J8xs+ygiPv25W/ZlobZHGnjj11YiZBFpFUaYJmNXK0cR2nN4UiLWp+3pzqOtRweGGQbe1BfAmlYKItkpU6qpRlxCIIwsACiNO/ETvLB2oPu6HC+nJIdAVmHduoIBr7LbjLIcrqGUtAbPKkseocAmKVBF+pTCTLArFlAEYdkiJ2Iz7K8fAYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyeA3gUYBT3XeepRS0137wtD3DVdii3hDJdRlraG8QE=;
 b=RINcXyC/5FGNHenYUDnFOlRV0dC5pTaQKrPY0MXKSek82tdsfPdQ0mgJTbj4I/i5feKXrmUbx9IRGSb/D87AOZLW9PgBGmMJeu0jB8TEArHqzKzF0njuRGkUo8eFhqCvs8bvc7Tz/ql4H3zePEczuocq5jAdRudNukhQ7czLzbyTax0ByEyTshW45NP4Xy6BJhbcHb49/JwQ2WBFimT82uhBpAJj5HojlCILR7OLFsBxDCI9I9Hu3k0xswfIBu/C9TwZUDz7BXCh6oReC3Ht3wFf3GuWYHmxGiGtzLlcCqMOxB/5txpucFW+zaxbRMmJafut6Zvhc0ZYRHur+1hV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyeA3gUYBT3XeepRS0137wtD3DVdii3hDJdRlraG8QE=;
 b=t4TAnaBMS2BwT5kvpQKWpVFutLavn0U1+DfuGNWy/TjgREquusGGk2JWEvrH2ELL23bVX5jRSRHXhesHEP2rQuqAm8xtnzJIMUnojWjHei8evek4o9p3omtNLRB6qSTnlEUjUUOk4ZQs8yWPl1f2Bkx0fJrIITmvZTPqXqFYcqrZ57SwWfG5EFSqSbmm+ILUdW/LQKJw45YPu6LiqR8YtX1e5/IriwZSsySoq9GzspQAHkoKiGrkM1iTQu66BPJ+/w7o3q8b1vy/4i111Y+Se6cR3m72zXv5UNFcx4c8Pcp7SRCY2iZQ2oqN7QWluFat2njJQdf5rK0kK9iye6t27Q==
Received: from SJ0PR13CA0062.namprd13.prod.outlook.com (2603:10b6:a03:2c4::7)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 21:44:51 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::5a) by SJ0PR13CA0062.outlook.office365.com
 (2603:10b6:a03:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 21:44:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 21:44:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 14:44:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 14:44:33 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 14:44:31 -0700
Date: Wed, 30 Sep 2026 14:44:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Sairaj.K@amd.com>, <jay.chen@amd.com>,
	<Ming.Shu@amd.com>, <SooJin.Tan@amd.com>, <chrisl@kernel.org>,
	<wvw@google.com>, <wnliu@google.com>, <dantuluris@google.com>,
	<kpsingh@google.com>, <alejandro.j.jimenez@oracle.com>,
	<joao.m.martins@oracle.com>, <guanghuifeng@linux.alibaba.com>
Subject: Re: [PATCH v6 04/24] iommu/amd: Introduce IOMMUFD vIOMMU support for
 AMD
Message-ID: <ar2CvJGaPiP1MNaV@nvidia.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-5-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930092344.5616-5-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 62566f1b-c983-49a9-a16f-08df1f3c0e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|7416014|82310400026|1800799024|10067099003|4143699003|6133799003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	ExnSzPNcuOuZSnqVSlXT4pZ3kZEGOu/xx6kt4JD6NonrTW4da6WE3wzCvr5qdxnucKLP2ya7oQQrYa3LmYIb5RWFPYy/Z0Tav81hrA675ILRmqmaXVlelk97Tb3qeEuw1FMNOiBRVPKIHSR5d3A2Y7DLgNdr4FJvBJyiPDCdrONaPUmjOKABcmvYCKeNuZeGFzQEjsx/n3+EpbTb5dKPyMGe214eV7BBn6TjdO7dtfIistgcq4d8G1QuX6TxjKZAm4NJaqD37EbiSN+023qjOcLVA05L4YQ53IkjVrSLLFfY7GQnxipznhtOI3O+Eq9C75kGr3qWZE/X1bQLgBKFyERoRVmOdjmS4m7fSllslWvJaVrXLUUQrNzwk9xa9oyDpdnzMsaTdxO8MUqC+h0WqJ2EWwlqGUna+cali9FVqmXcFoX5Ch2cYjME8wsSsBJyg+gLWbR3rVT2XTwiPXA1ZZWVm+GFNgKibgcEvGc2WcMx2QvyAolS6UHIdm3JuMJfj7QnoLkpjM4MCWjBwtx+e5VbUZRKclkNvsHhhcdvUXlfxCnkwWlV52dl6fe4xpRjd//8GAJVe+TQUYst1zmWipvzCzK8xIkiOUbMyHID5xEhdxxKGzt0t/HKDp+0iDg/e9HpHY+xUQDSFFO+JtANuGUTqsRg97WA1I+Q0QaXlOTaXbeEE+zQkQKVPzPEG/FJ+z17jA8mEMpaFK67xGK7Qg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(7416014)(82310400026)(1800799024)(10067099003)(4143699003)(6133799003)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gTqu2xJ/VjGI1H+e+/CVz/1TCJGCEFOk0QQtEYVH+1jzMGi8B3mSgP4iRJwl+ZAMsX7gl4zLTipSnSScm62bg+lk49plZEbAOUXCIudF6TebT+In07VUWW0VhkSMQaaiLpSJlDlr/Z+vA45RilFB0WUiNrx5V6cBft/GAIy5KEb2YqW2Fr/zfVkuG0ZurWMRGGjYsRDe8+uc2AObh4YNQyZhklQFN/8pVu8ZMfXa8WU/iyvV+jtduUX0XZIXDP7KsRhWGHDBtNq22AvU9CyKJ0oAd9AcL3jVa84izHrvJoXihSRBg1Roo/SMeBjmjAR31Vwg3jPdxcyPJxx6BgWtKMoBGOSglDi3RHuzOdHkC55b7pIRxitHPutAnlbd7Hl5XqZXCTiwne8n70HLOXomBHKFOI+Te57VF2WoE+q/iRCzr0FXrNpDtOvafiOnnVL6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 21:44:51.0501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62566f1b-c983-49a9-a16f-08df1f3c0e71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

On Wed, Sep 30, 2026 at 09:23:24AM +0000, Suravee Suthikulpanit wrote:
> Introduce a new enum iommu_viommu_type (IOMMU_VIOMMU_TYPE_AMD) for AMD
> vIOMMU along with the struct iommu_viommu_amd, which is used to initialize
> IOMMUFD vIOMMU instance when calling struct iommu_ops.viommu_init().
> 
> Also, hook up struct iomufd_viomu_ops.alloc_domain_nested to connect
> nested domain allocation with AMD vIOMMU implementation.
> 
> Only report a non-zero viommu size when the type is AMD and
> amd_iommu_viommu_enabled() is true for the device's IOMMU.
> 
> Additional initialization will be added in subsequent patches.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
