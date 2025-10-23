Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AE5C96
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186855; cv=fail; b=DTde6u18uvlf18b/B7ulJfRLcXJy5t9DVYHXjQOKrj6h2xuWU9XireW33BxdDqwWyJkBZqUmGajLRee5YesoCpzF1SXFsu9akbWZvV7awiz4TAD1ZI6McG0dLedr08u3KHNK9+1rAGHMdr05pKJ228zD37r2N1v9SG3nSk69ukE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186855; c=relaxed/simple;
	bh=ekd7TVev7ZKV9iODsnb1MrkOrWElbz5jnhjMsMOsNfM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQAei5Kgj7+ss9sKtWHossl/USqDZxb/BCMojsH7rFPb+ukszeoJMDghOewIyfX48sV93bmHparcnfwrS8N1lT6mVumQ3Sk5HeaESeC5k6pylPEEtEUokOh+Eyr4MBswXJ7y/EK8E5rRytVkgYKCHJdTcVIbfsxuM7PpK3VQEcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p05JYWE/; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p05JYWE/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBkVzB6/B4PVCijJd3v6JXCocGbHoonncs+5Mwm/BKj1xapH5OX3cQzFFr1hCBJitiYNmIjdWFIpTEJlSAC5+j+ONWK3IYr9fFkNhNfj+fOrLU42MR8gkWGov1olFVV/4aa8EYiES9udn89C7xtl9GjxEz69VISDwG6Xk0VJuvj0Eb/Ao+frHxa8romE3KUD0dnzzIT2e6Gv8CD2iDNxoW2EBp7LiSCDoEdNiEh7KZ96n6oUr2ynabSAevieiUkV+NmnoqUyKXkT3lixtqfV8OV6M2b+6zP0iRQ4RMLwjOtkqDKoN1sDdNxipbYTg4tmF9prk0DJ6ohrweEjojAFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TYLufM5miJya5tRdQOWx4jbp67jsRCxBjSkSqRwlTc=;
 b=ycXl5Q4xQqoKlVGeiPWafZf3sG+9SOJ0/YB4msG4dW8pD7MV4iSCumES0NvLhxOFfbgjLZw4UqxDlhNOxtD8jr3N9WCvssLGo3LCFevn4xg8rt5oyF5jrR/vJyj2r14HgS1J/dqnzsHcJkX9Po9PI3IWnJQ7RmA3Hqvkrh8GWbrDtBfrsm/5+ZSDzU1k19xkzosf2HM45MfCkuI+eGE8BT8BvwoMWe62G+UG11n5CEYCr3wZla9nrrEwkO4K4LfiF3RjMKF6gYKCB2Vc2Nx0NdhAwPLtsvNz27NJwUXdygqL5xZLBF+6qv8EwXdwSRXvRKBSpGiVRfbmosBXi1+L2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TYLufM5miJya5tRdQOWx4jbp67jsRCxBjSkSqRwlTc=;
 b=p05JYWE/HrFaIkrxN/AsK7kQ7h+jEbcq837P+Bg6jLdQrweiDBIXiQHF77zbuc20d3n8VDGc4AZiUX90Y+M1q1JKxOHfN2Yy5II7GZUA265rZmD2HJsvvNJwvck0dKbUyF1Ysr8ke7zz74vOibMfXkyKD5muPy4F5JOKnxPJ3LQ2zkhrjAAlFEGITiUAnWATAGRR9asb1ZdJTzVZG2/e1BogmY7sOLu5XXx8Li/5F/8TT46Tw3Y3tPE0jUTvtlNd57RXnY3oS7osz2zqX5w/1SyxRtQ4hjaYdF64LZYugVz5RW71yhVDcv5w53UH4Pgb/KXGD39EgaRyCksjRjyR0Q==
Received: from CH0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:610:b2::34)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 02:34:08 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::cf) by CH0PR13CA0059.outlook.office365.com
 (2603:10b6:610:b2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Thu,
 23 Oct 2025 02:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 02:34:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 19:33:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 19:33:54 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 19:33:52 -0700
Date: Wed, 22 Oct 2025 19:33:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v4 11/16] iommu/amd: Introduce struct amd_iommu_viommu
Message-ID: <aPmUD3U764IPo/et@Asurada-Nvidia>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-12-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-12-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ce11ae-74ef-4664-ed47-08de11dca496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?va9EsNL92SjxyDnGmuUFR0YnXQc4PDf8JyiyhIXfzpodbykI2xumqtrCu+M9?=
 =?us-ascii?Q?RrsjJtoD/XfD40CDGOfw6Q8XRMqvof6/rkTHa2hxHICFnLUrC3JnQSgTuA0Z?=
 =?us-ascii?Q?fv4VglXS42ZIYPlUamshd3d6jmpvgARKfhPjKOSeAPn2d0E5BrqBtvudtOBi?=
 =?us-ascii?Q?cXi7rJkcI7Pcv3WYhVtJNbBI5t7XU+7Iy7zCZmCNNmW9FxGlFdeaAOqJcD9a?=
 =?us-ascii?Q?Otw75sapWyXH7w/s0OZksh7+jIWG230FYvYFkM3MSYzTlpSE5jkH2WdnEGZQ?=
 =?us-ascii?Q?8IoTPjlZIm7j3QFvwaEEdC9/hv9GTqHmH/Q2leJ+9Hi8nri2OzWZeH8bqB32?=
 =?us-ascii?Q?AD18LKa/aPqZ+K1QcpK4BxSwxKArDBtAQ1aHM6xmtD1aS+4IPgzU1skqHYXK?=
 =?us-ascii?Q?OtWN5NJBCKtLR51YbzsCj648+3SiMXGtPJRKraw7YdLf2LOilpq4hb0/F6RF?=
 =?us-ascii?Q?ztXwoVzPMysNM4T6Nsia0hfgX1cWC/gumtCKgFWpg0GxJE9n8UWEAqku4gEI?=
 =?us-ascii?Q?cEkmdmfFujlQcILP4lwTPvl3yDCo8HaS18P9NcN4D9wU6mkGd4KWtU7+36Vl?=
 =?us-ascii?Q?V1tZqLSAMdzzsJl3UrFKaOZfGlIzZcxdTw30Iama4Qh1g+Y0ydID+BldZwDe?=
 =?us-ascii?Q?o+zqHPVHMOhF1UAerxsNXzI9Hms8cPg2AGs5siMGh0CAWc/ngdl2mKu2zXz4?=
 =?us-ascii?Q?818DhWLjSxM5XFP9BZhaoEnDW731WrK3mMYm30OX6kGITnqsRO/TOloh22FU?=
 =?us-ascii?Q?PSHpRNEL9asYwGoWeZIhuuSmbqXBtAuE/s+p7rLaKQh1/pVkK80MJsoX9PBi?=
 =?us-ascii?Q?8xX5fuFOf17KYWJUnPv1Gh8USM2HyGFucKmkLYO3g9scwneBiiwmFZUVtxMf?=
 =?us-ascii?Q?GWaCN1ouO03bOKRs12ULKUanFgi3JxMRfJT+Mif4x444NSGn3nsMY46mgUI2?=
 =?us-ascii?Q?FBODPk2Z8sfPFB3Bh3c9SKQGHG9AHDwamgth/CCk4wZhtZiMGuX83nDrnFJS?=
 =?us-ascii?Q?utKpIBkoMaVc7N1YrxGdLIyudbykVsZPNnauPnugf5spCMSjubhxW1WYbG2U?=
 =?us-ascii?Q?3lqclSjwYvwuFwQHD0sMFh+3LrbvNXv/WNBhcsmQDSEZYBuRNhQx3HBTNMop?=
 =?us-ascii?Q?NmtxyZlyaOzeF9rwtonv5lYno3eAD8Cc3AHKu3kyaaQL7s0mK9ts+mvQ0OxP?=
 =?us-ascii?Q?4xU7VZ+5odJFBdkysfQ9vNB6PGW9gZk96mwru/2dCM+HmxTBFk+d1a51895H?=
 =?us-ascii?Q?olLlYgUIAGS82D27cmUldD1vLVCEEEmdR7tVHkdl70t7Jp9Q+Pe8DxYRctaO?=
 =?us-ascii?Q?gY4QB+REPfa9pP8Rt/DlNTgbDNKeyiJV76+pH2XYPYuT7CqKdjm3PBLbZuU1?=
 =?us-ascii?Q?Q4rP4jQjUzD5OV+dHrYjdiVbAFUD1V0eJvjsdk77JFYZQuiR3Cc0k7a8tSvN?=
 =?us-ascii?Q?I8iL7BoqygECyO+hj7XXeBniBlApAnXU6LYn+2mVE8ehBKCq1YHiszaPQvnZ?=
 =?us-ascii?Q?PcIfqpnqs1AdQLSgnUCqt0kfoxJ1CssVEICcwkJWHilksRrvV9Lvtzazl0X2?=
 =?us-ascii?Q?oxhoKvF/G/Atla9wr/8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:34:08.3508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ce11ae-74ef-4664-ed47-08de11dca496
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

On Tue, Oct 21, 2025 at 01:43:19AM +0000, Suravee Suthikulpanit wrote:
> Which stores reference to nested parent domain assigned during the call to
> struct iommu_ops.viommu_init(). Information in the nest parent is needed
> when setting up the nested translation.
> 
> Note that the viommu initialization will be introduced in subsequent
> commit.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
