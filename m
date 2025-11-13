Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC742C158F
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061625; cv=fail; b=TrKKR479XpmYw0N1hWCn9XGlCbcidS+CQ+P0iqrOjVdR9pcQTSqxTpItBr9ludTVVcKsxRU1MjKcNd5a7fK03cHcJhmymayKkvfI9bNUmIuE2WNfNPunxBHnt6uSoUjyfqClmznxp8I1gw0exSRZmG/qrXhipOueM8Z+za7jBKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061625; c=relaxed/simple;
	bh=9kHnWAVL+qvE+/mFW8s9kD2Ymk7QJ13W718r4W4EAQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNQz+4RhB1yI3QY7mjlmbiJBcVzL/ercuuvv+2BGWe/BgUPTfPuRsVWUH2fjTn0L8CfhQgTndiv7kVeZzuBcb9iv611hxzXBqLfBpzoczS8t4n/GNOHL8SqY4yY400e5BgIqsElJ2pr47eBlzslOnyFoeeNEJcjE1ZS9uXGFyDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gjnrOirw; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjnrOirw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFalrfkj9TKg7C8wnd1boDLBJ7Bj7GFrs/a75UINqdrnBCCMYmD2NMnHgFo9kyKpCyW4Rr7L51wjIeQzp3ebQh/lmOjaIGcPG2VeJHBFH7ODrAaDvQfeDXraVTbcV5tu+xymnbzBnOf2/TOqTe3ibdZRV5TyXGp/iDL7pSu8aYK4J5VMMd94dBIV4rYIEpBz7qNFCNMwDsIMGTa74ikt4NosGM4/2ykCpwIGMkO3V/JzjJZl1+cVa6zLjPTK67z2XvvmGSqIqEv/icCGsohN8RhM3F/0ZWKxj06vJ79G+EtJ5TeDKOm2/Q6rRGh+TQSk6/J+6FA9w8kGsTxDZRIoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0rshJvOA47xycbVkQkU3Qx7odtRzl2uQq++YnWCu14=;
 b=EdBAu5N4SrNzFAzVzW2Iy541P9WBF86XhewDMYaM7YjEYIrQyOB89Y+5wynEONLLA52Lhtj2k3iCy/zMiv+iRCTWbg9afQ0rmQhz6GpWcUAiyxAbhawaoMv+Z/QuqyrHTLrUAtEwYggDZpXu99p8iDS5dzVer9fW2EX6ZC4ObIZyCaDr6sv0NKCta/wXvjQarJq+1SPgOY/fzigZ2UPBMNY8+s3dqO9r84cYGEepLyrN77fKYsL72OPgw2GPcXwDZwlCXE7zyKiE1AiXN1ycLHizmnMyoAlA9txtgne9VaLaiU6DnlVH8r/t+CGykXLlxVXRGaM6O+jIKMPl5QnKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0rshJvOA47xycbVkQkU3Qx7odtRzl2uQq++YnWCu14=;
 b=gjnrOirwEiaNJ+m/EARKmoanz3kMa6VTDzGizjHUcosylnaaPNA1UUpU0kgeo7hTUfvnaxmDC+ESpj672v+2Q2QPyo3mNSP4L09FkSEP7ILgMVaMwmxQyEvw+/jMc3II2FFD9dnQLvun4pvSceE2L0heBkP4eQo3OHrcepiU8ncTzRCgA3Fahagw9YuspQ78Sosty8cx4978w7RIDJpzTRf37TBUezoftXQ87sJ0khnS4t1pSQSHCS7BbmY3jpvUfYy4VBXi5bBCpQDX7Z0+umjXYQjPOb6NNYs6AoErg1IIchbwg3BI6Nhv9E+2QSjez9p5ujHfJHs4/c4eE6d3Jg==
Received: from BL0PR0102CA0002.prod.exchangelabs.com (2603:10b6:207:18::15) by
 SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 19:20:16 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::ca) by BL0PR0102CA0002.outlook.office365.com
 (2603:10b6:207:18::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 19:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 19:20:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:19:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:19:58 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 11:19:57 -0800
Date: Thu, 13 Nov 2025 11:19:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 07/14] iommu/amd: Always enable GCR3TRPMode when
 supported.
Message-ID: <aRYvXEj3NQS/viHY@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-8-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b61652a-5cb8-435e-b4f5-08de22e9acd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lW3P6rOopbaKC50FAldTfECIC00h/qcFwdWIS4VXN6VtPGszoLQZ6+jsWkix?=
 =?us-ascii?Q?urEl6TuC8Vr+j4O+7L5XUMUHInLAb1igg5SEC9He11RaQNyrjoaQvrguF8/k?=
 =?us-ascii?Q?WB0Ua8cPHFnVHyNMU0+1Bui7wkMAc1+P9IAr0NgbDwVw9tBZoLnGquICKtXx?=
 =?us-ascii?Q?Cxv2X+uveg0mKzVEF9NuacOqGmwHRpSa5BX/jMgcE9XAjnSJ0aGGj9q2/ZES?=
 =?us-ascii?Q?JFKZLaAmlx1S/GCDni1BqDFfoT9G3v/5+hGXXHJ9dQ2Iur5WxaA+BBbNOncU?=
 =?us-ascii?Q?BSE2YhHTzZRZ2F5QVfv/L4WVKREiwex6CyN1qwTxFbMTmefDCzWRQ17nW5Wq?=
 =?us-ascii?Q?7Ttp0miG+RlxsJPfMZGqnW+R0/UbiFrFvfrZJ127MHhsCwroUVatCsL2lKY/?=
 =?us-ascii?Q?HjZ5zexYtBuV8IevBGqX7HUbRRh1abtusYiL98X7Mwme62+yLDi/YdFMTxbe?=
 =?us-ascii?Q?zR0E6UV4AL6htpeGfg7Q1Cj+zPUYUyJym4z5feZcDk+cObsfC+y9so2Kb2vt?=
 =?us-ascii?Q?TeY/DgC1MoOogUBms4llW37yfELvGL6ep9PcSNmRRuul6xJWzDEVvqwcLb1P?=
 =?us-ascii?Q?owyxAL6p+NAblEyhmLEcJUzfxG63rv96oV5UuH60pMvdd5pEzxemcidKHIns?=
 =?us-ascii?Q?DuvyD1YHdpPUDzkI5LIMP2Pj43vhaaDAEN1aWV33xJSJVlGA9HyhPEJUfXUQ?=
 =?us-ascii?Q?2xX9NKmwhdGU5Aht8lY3S37KhsaXa9H1v+CvuZFFGJAbKBjYSagdMHMj1C63?=
 =?us-ascii?Q?lT/QDRTLt4vzwuheDkRsYKWy+QUwHFAkDA5v4jEDpFkWwnRRCLT4FM5CNpgN?=
 =?us-ascii?Q?tqSPqs2CLqXdmDwte6zZn7o1aBDDM9cC9VpoyPO0zrIQ5BruNFD9SIa7dNox?=
 =?us-ascii?Q?6kkDTA0gNg1pMVaG077NVliCD8awLe0Kl3NM1/M/Wr4I99InCi/JSLiJW41A?=
 =?us-ascii?Q?1ydvcqc+gV22FdCSFbOD685NVZvOZmJgfY7LQ+UsNf9fRzN0A9xMkMp8d7lj?=
 =?us-ascii?Q?pBxP1eVrwZT/r5S9CT179LdKvbmNXa2S7D+siDjs7XxFnBaxXkRFN2596OLV?=
 =?us-ascii?Q?dkohOaUePiygIVnjQ3eqa9E/rRO60fCkVbs0Zm5psw7Ect0F0YZTUjwIxg4J?=
 =?us-ascii?Q?OPUtjJKnUpt0h8ws8edrs0YEJGv8t/DYvDxkknM+ihKnUSG6+C8EgEZYaoE0?=
 =?us-ascii?Q?8cYiejD6Ea/zSanUnyZp4HHltxcr7UT8HxcOiN3B1C3yA+DHbR1SEJ30dIt/?=
 =?us-ascii?Q?FJ4GwWA/2ONgWrRC3hBvSVAjf+1OI7ZGkKH0zd1XmXczoeknfjs9y3MULy2S?=
 =?us-ascii?Q?IFDlEQniwh0EVBbZcbwmwwbQytrz+ITqUDJkiVcj+e93JVEhSmJ3u2jsVEnz?=
 =?us-ascii?Q?ZX4k8jmdUdL6V38LzPs42YlD1aTGHy8yUhs0Lcqd9WZhCfPEV1lZjdulIQYZ?=
 =?us-ascii?Q?Z9sozQ1sMhw1XizJfVi/FQp2Nav4vJUKJdIP9xqBzvAdX9m9BWSO315abw9y?=
 =?us-ascii?Q?YjDSny98ZJ4rED0H/51KMGpEbu07e7K5tBg3xQJFeQ1NU2/tVmiWn7qfw1Vj?=
 =?us-ascii?Q?RCiy93AexbfP782saAk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 19:20:15.3988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b61652a-5cb8-435e-b4f5-08de22e9acd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

On Wed, Nov 12, 2025 at 06:24:59PM +0000, Suravee Suthikulpanit wrote:
> The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
> with GPA (instead of SPA). This simplifies the implementation, and is
> a pre-requisite for nested translation support.
> 
> Therefore, always enable this feature if available.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
