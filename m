Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47A2FCFEE
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172013; cv=fail; b=i51gGXY1cqx38mxfrWxgzWpS1uLbDb4Ma2D/Q76VfUTfMENAeI7TrQrOYayz8QkVRdCHMe1SLEyEdXNZ/i/u8hB97WmmW2ae80VOm4SLna5liaUc5VrUFzcazOvbmHa5KQhOEHSI2RS48e5UWhhrzmGbvk10qyvFkphwPS1dTQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172013; c=relaxed/simple;
	bh=aQEG4A/O2ey10JvGwHiq8aA3O1orr/mZ4hq5vX6UX7A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUXAYbZOXaytpGlQXJuZwpCrPFiNniCUmetk+t3PXJzu0s4/i/GXk4tpLjPk7oTQxu77k555CmweQ4YfZjDVihvmfLjtX1i/7Z0gU5NHTI0/eVkPaJjE8f7quVkhRpudGpanfhbEsLwkyA0ndAyapbSmkiDa8ISAZIuTVEXqs8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BXRJp8tm; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BXRJp8tm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtQdn2CdFOYHW3qaZHYuziaSTsuSunZgJFVMT5KEL/kAYdkthz4R1YdMXWJ3rHkkDdkOHOyOUcocI2apdal9c0BO/n1KcQXzOrpor8QffyCU7JE1dnxmYIZ2A2Ox4xtVIZHvLMJlv7lNvbM3N9p2QLrKC4nlewKCUfE0r1GUetKz5ml0FCzzbTZ9MpS2FmzIZN3VHyxkLA6a+ApZpGlNBRJgTbvGE2mSkWXVMr9Yx9oxSiaud5ERqCBKIe3qGTbxT2vvJAZgpHer0d3tjixT/LJgi5yXnhyp0UOhLm4GCS5V1mHNSbLQrs1vAnHwVUe2P/PEbu1Id/pDVHz09vR6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9/4OR6OyL/cdBzfbRRm3mN59o8+q164VQHtovOl+Vw=;
 b=BB8TvcWCp2GCLbzrS+ZlQe+hQrxcR4Bm7hPWCtzWWdQ3awvcYKnFgKak0VYemsp/ZP4q5QBWuyhk6QUbqrd8Yct5TmEJ2jNX/CsnLKZNRsYEtT8RMi9cPGVZCWt69u6XNfOY2kWNocnVPWl6vdvQ5LLUIuh7GzWTNgSRWvEnRLtzCadC5YlOpmDZ/c17l8lUuXaCIW+gbNzgUSPdAqu7JyHoV04WMdkN1l9usuwcBHf5QVWEwE3jeIYS+m1d5nOpVPIPIG7axdgccZ7pyTfRA/WVtmxEFKloAyULClbZmbroZUtVSVjmZJazcsQ1FbsPWE4Fw9hILidvcaFDHW3cDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9/4OR6OyL/cdBzfbRRm3mN59o8+q164VQHtovOl+Vw=;
 b=BXRJp8tmxmpUqwzc7iQipv5KIsLVe5Bm3Y/g9ELf3RxC1XI8w1d/JDbVjNlN1eVgiCm79UvTc+sCSvl6wTopTfvsToy3R+5LsWnn/wsVgAdrhROCpcjq1kNCEugNwZqb69csk1OPtAnhHoYA+CylfexKnj7jxd7ulunwuGalCPC58+XkQvp/aNWffZfcxpZG+B9PjZBR9AyCydzzkttikOMaOCKgmmsAHmYT9XOAhHGAUGqdhVyNpe5wMBu0DvzCDBGHczNXo2JiylTQl43NhSlWrRoZEhpt3rTjI61EwPmOZDzDVFCpf9EKVPZdMQA/+jVGkcuk1SbIUI2QpQ6cfA==
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 18:26:47 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b0) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 18:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 18:26:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 11:26:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 11:26:34 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 11:26:33 -0700
Date: Thu, 10 Jul 2025 11:26:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 1/7] iommufd/viommu: Roll back to use
 iommufd_object_alloc() for vdevice
Message-ID: <aHAF2ATrZUIFCf+e@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-2-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-2-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: ad74960d-c5c3-4d30-255e-08ddbfdf541c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5N41b84trnE2fMk8P9PRh2jlnTjMEgF9GC984dubBvKaUpDuifTyi6PzB9dL?=
 =?us-ascii?Q?MOYYc4oS1fnVZ5ZRnzT+tRTp0PbhixFxgJavY91X9AgSI3t3yrKkERB0ABny?=
 =?us-ascii?Q?BwQ7YiWLxxk0V67U3BoHPT5wIIhfzfJPxTDFSam2ZBXngNaOJIHNo7CsJpnc?=
 =?us-ascii?Q?/IunHQGHC32+KBICiaB5ymDUzSNKNn5EPDlU6kwf5XUJsqupsLw0MEGGJk+4?=
 =?us-ascii?Q?Vaz7BolanJfAexGF54kQvHPDro4Gwmdv3sXRAQFSzKFRxWiqCmPUtkN4yU1q?=
 =?us-ascii?Q?wDz2OLsf+7NCRdma1UWvCI/H1ujEsKG47uhFLV5dECIrbUJVaqIT3Q5dIxz0?=
 =?us-ascii?Q?vA1ctuV7612Z0rykyjeeKkrkQcQ/Jr/7F8HMuOvYd+NEYaOZgbc+71nGtLhD?=
 =?us-ascii?Q?DauGmXbFrfdqVxb7o+J9SQybcSGiinm/YLVdSg/PrJ8Lt2puMm4BFclUXRM/?=
 =?us-ascii?Q?T9MqhIDVrIy6D504CK46JC6vuGzL5CIwaHgagIuUkPu1SkzIwVdQt8haYSYQ?=
 =?us-ascii?Q?xjaVuYfe/rQDHzFH68eMZSWrmqn7a+vIGJjp5vQNRF0V4l0N+IwtUfu88gBG?=
 =?us-ascii?Q?6RYBj+jz2kU95t5rZggf9300LK7OnHk91fAYtvY6K1yZtVTAhQhSHfM00qYb?=
 =?us-ascii?Q?1LwmZeVSXdYCqrwCZ73y7rkfoIFCeKdbE2yQ+fsIY58iL2e72XbW/TeMZOWr?=
 =?us-ascii?Q?n0v6Ye8KEbbJnBrT+C65gt2ln0pwi1UJ6SFi1nmE+vsYL/35XPN2OjAlwN7S?=
 =?us-ascii?Q?LRjs3W6Nkt+XXvSFNpScg+uMONGxgV3exqpvO745Cfhv0twTI2pnaJATQXOB?=
 =?us-ascii?Q?nu2f6vVUGBcfKQ3L9fvtg3BiyjtMGeby99lWLPolR9TbWbULK5JkcQuSfmxj?=
 =?us-ascii?Q?scrKLnNIqvihv5VEc9Dy3E6IGIWVifsj2mydlpTQ35BPuSNbmlw1+idKyz+Z?=
 =?us-ascii?Q?mB3f2HbDxfgWsxpCRRnZlBc9AQkmp1GAsD8OR+Y7xanKav+3G+eipsRHU7Ev?=
 =?us-ascii?Q?/XBmhN7RSWNdjNFYhYaI8yLurVpmMgIjKUpcCFnaVvIpihPmGyBBuLbB9n3p?=
 =?us-ascii?Q?k1uP/Lp8KOYS3SCz8A+CHgSOViokqv7315HGsU5k/ug3hIvTDTfDqPcTdB4x?=
 =?us-ascii?Q?13C8TruRx5L17VuX5WakkcVDv37xbIHd12d1maiYJP1myZ5u4xB8b9O7icYi?=
 =?us-ascii?Q?64w6mu/SQAV6UAZ/xrLh1xsy83zfwgbYZUv2H8VMBf31Ws92/MuW7w155Y80?=
 =?us-ascii?Q?tWWagOVOM2Ci79pqc9SsmLamaFTXKx2Seb/jqkSbhCjTg/ELTp/KWtkdjBil?=
 =?us-ascii?Q?uuBbyHWHNfdOUADeKzl7FDTUpV/KmyTHpsZKVJf9k/7Fnc0vANo2dhxdvLQ5?=
 =?us-ascii?Q?EHVvzZNZjrVP6qsas1ZY/YaqYOYE87SsrAyuLfY5S4/s97EUBxnDDwag6Qkg?=
 =?us-ascii?Q?8Cq6vNIIJc6BHxfh69Zd4MhYsui5OAmWMnoCvkmwckGFqNqdTe/nPWAIkFJt?=
 =?us-ascii?Q?suMpgmOWcstrFw2zsO3sJqeX7vsgAyNM3y1z?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 18:26:46.5580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74960d-c5c3-4d30-255e-08ddbfdf541c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

On Wed, Jul 09, 2025 at 12:02:28PM +0800, Xu Yilun wrote:
> To solve the vdevice lifecycle issue, future patches make the vdevice
> allocation protected by lock. That will make
> iommufd_object_alloc_ucmd() not applicable for vdevice. Roll back to
> use iommufd_object_alloc() for preparation.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
