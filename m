Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F541E1E1C
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854778; cv=fail; b=c4raAQdLIMNpYwMMWOgFiDLuJZHsYvuBirZj/5YaDMVKgaLoSS8Ac64vZWsShscyCJIKR1doXQ7g2NIjX7Pr4vINgePg7ZV77TWHalH18un+bB/6oCZ6bT+CU9DQ/rC3PzbgaUySOwoPX5/a0sEPDg1kVlctgPajNDlXxZIBVYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854778; c=relaxed/simple;
	bh=KEzw6VQUyy3fwyHAuP6fgJylQnVvDGFByQgeZcpq0zY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu914eZAA81y0HL3GmGTr3Ym73PdDxFG5M1RGJggsw/cSGF0B/eEKMadPeCm8ecdft0mpdCDmIQs7U3Ogg+mtj/jSBwAs5uqdL/KlZ2X+/tkeFazmIlQFStpoRBKOwCRyM3pgVNDFmBZlmdhfcJlR7Tl+JlcP9dpsZLViPMR/Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKIKNQd/; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKIKNQd/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCnRi4kNj8DjZBO5TqsAsYPkHZ63EKrTZxeViSSICLjel/s/camvPBY0jWsYkDASAD8h8tBPZJRxQjo8NQ5/bDqeNsmpvz1sB1aYbwNkZWyXOGPew00o3XAgcUWCniKYBSBVui59cLJ3TzS7DJ3iAzOG6+nD+NY7ptv1siDp0d3h7XdFv2nHqMpo4yk9I3XNdQLwsSpStzUWisPZC8QuGCdhyZPbivzBVIvhwz0cJYGyNamhVsu0MuXq+IdASSKnt7nfQ6EhV4JG2s+e0EkWZBu+TepNNJPDWHZ9s4EoL0HD4MI3Wnmoh/IxybJ16FccQ+EqGBExSveHCGJmNpXkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEzw6VQUyy3fwyHAuP6fgJylQnVvDGFByQgeZcpq0zY=;
 b=wIw1Czm49prMHVerKYrvgqduq7NLDpS/X+P2f2KW5OqUFTO4lWBXqrJccvJdiRD+cdMFxkibdpuIWW0XYi0CPUPVql9ozdR7lCYocgcQ53gfMbVIruImGIMirz/GNL3DmT2vqyIm1jJZDz/jPGuONOApcQiNcbzjjZ7Ph1HA3ebybKmPKAMfTf9dkS/qixTx97tbUCvUTGwB0RoFsB2Efqgjr+fOroaFLHDxo9gDZxTy4dEm4wnCedc2GOeDkIx7w7c+mLJVdEjizH/WCc3AYeVROCfbqoCEojpVJU5nxvwawXljFrrmhBHNmnlAzV3hcGv4fa29UCNEjW37cg7mDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEzw6VQUyy3fwyHAuP6fgJylQnVvDGFByQgeZcpq0zY=;
 b=nKIKNQd/XsAxg/L3TBrDqicE37iFCh/UBP82ErG2xMSVL6INtSv4kHecWMeEBshKcgWbT8T/cY+rSUYRjA+d78dCoplF8+YuttOMARoQ7q1cb7ykpKdrAordLlruMDFiDBxSkRifWjNNtlcZgrNmqWyMudBgu/XiLHvzLQhspPfBZ2e2LXBQ9m50Dgo5PhkDHmzhEMrwYYIITTOoo33Vzl2+62B1uR3+ETPPRFxjFQeGefuvQBqj2XdLQywBtbnZPWsuzzi6OTbueam+chSGkwcIm2TynbYRwiqP9W2nFaxi2LiQDqVVlaG0LpsWYuTkK3aUT9lzRwntql9wPNOGYQ==
Received: from SN6PR05CA0018.namprd05.prod.outlook.com (2603:10b6:805:de::31)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:32:50 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::bc) by SN6PR05CA0018.outlook.office365.com
 (2603:10b6:805:de::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Tue, 7
 Oct 2025 16:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 16:32:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 7 Oct
 2025 09:32:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Oct 2025 09:32:38 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 09:32:38 -0700
Date: Tue, 7 Oct 2025 09:32:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aOVApKmiaaqWp89A@Asurada-Nvidia>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <20250924175438.7450-2-jacob.pan@linux.microsoft.com>
 <aORieLYckU9YLdVF@nvidia.com>
 <20251007091220.00003a44@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251007091220.00003a44@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: eb97e74c-b331-4a9d-9c32-08de05bf27a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIF5czATQvv2qrutK3TR839jQ9TdWKdISIbeW0UF2fBipxRI9ipDo4SG9C6g?=
 =?us-ascii?Q?VQ2TWqGW+WHK/pupR/ZbIWgUV7JopN9Md1tpJUcgW24pSm+VGJ8wtEFNsvuX?=
 =?us-ascii?Q?pdpM27DeSS5G6ugO32nJiDmNp2wCZsolCWy8a69zkt4iax8f0ST124tRvMbC?=
 =?us-ascii?Q?hni/hsP4ZfLXV1zuPvdI9NNnoB7A7+Ih5xUPy8ClNZssz162KbbXyLUgq9wq?=
 =?us-ascii?Q?4hx6njjkBSItrtzFGsZeAIXX9+8YstAz+pSct5Pp4lpmX1gWwupzr58GGGvQ?=
 =?us-ascii?Q?guz37G/EsjTeNxkEfeUqIA97+V+TGL21fmo7iQRyUawyF/yeLeqVZ9qFyDLo?=
 =?us-ascii?Q?wG5uz10vBNp6nwkxb+J42doSil7XERLSz+JhFyqBZ5kcC7Cq85QOEvuB1iFk?=
 =?us-ascii?Q?7ZwJjQeXYGO4lyaiN2cWSjwEDQyGzmHQ5h1UNu042ZTJw6vK+uHvHRDnZ5nY?=
 =?us-ascii?Q?0KS+hEUIU7vy/6cghQU+O10+ve9HmQG/He5Vorry32EeJzGE7VAc3eksQts6?=
 =?us-ascii?Q?GjA3ZPVbEcr2y7IvjkqLa4b5iUuwlG2wtwwAL3xOVVsKhQtnr42bqdIymBZQ?=
 =?us-ascii?Q?YTyoUQEgAv5LvKDeq9i6uHBYBnnkQT3dZNU78FI0sf18zJrpdzURSJ0Qvve7?=
 =?us-ascii?Q?C1F98fbaBvZZaHVij7eiQ2ms6TdolKD+wyIRPRv+Pqu84RQflVMlfeDJuSsh?=
 =?us-ascii?Q?MgtgoCxAoHFI5QJ/8b7H3UdxP3CItpaL2D4fpHz09mvI9woA8eN9awHjUSwu?=
 =?us-ascii?Q?TMteEnibFK3lCYFwVqbXAbIXsKYKWjO9VP+MyMlnto3hUxDEdtEUuQRCbtbg?=
 =?us-ascii?Q?gO0+qJYIxyNV13fi9Snf+8odEHz/KuqmhTxi3styI/H9LwOCmZWohI3UsH48?=
 =?us-ascii?Q?AsSQbar+pE/2w0FV/HMGjRGfREuMygKqer3gC+7WGjd6icLBoGhON0DWTgRX?=
 =?us-ascii?Q?HtVNbY5/zF0o6hnfp8shL99zieC1q4op8dQMxFmT6da2FEdm5hJBGIMYUd8P?=
 =?us-ascii?Q?PFhmoDgbmZZW6C07d7l6n/Gl+KGvydEVyvKWsXUV9mzSt+qwFn8LOZ+Bz6rv?=
 =?us-ascii?Q?9wyI9CHdgNkjfoehm6Dn/vszBC6UeRWK2LpK+KScxbK0SYtFfHejIoXUnt5R?=
 =?us-ascii?Q?lQOOh4vtmof1zD7TdQNxuTCisi04eY6AF3Clmj1H0xlrW/PEMnuG9nVxER9a?=
 =?us-ascii?Q?cVJ1hb3IbdGCI19FQ/nGr4hbVo7R7K/68F+WZx093CVVe+uGh7K0UTjD/vvW?=
 =?us-ascii?Q?i4HTUxGXZWB4zEIi3L1Pr1CynvVi+VbC6k7EBJErn1ssSmwXtgKVPJ0IqaZA?=
 =?us-ascii?Q?5NpsWpNJXbEbN97q5CCQ/DtHb1LS7ROa8p9uXYFRRWTte1EyTg9M+mRFioWy?=
 =?us-ascii?Q?RmOg7Lsu3201YP0A+J/w0+/f2wGW1N0GddzQEiqjg77dHx4FGZwna8ZZbAHj?=
 =?us-ascii?Q?3OfmQMMLt08TdVaGpQQ7Zbdsn4KMaE5sPbvu+oZsykfTBN/9wb9qGHbLQE0E?=
 =?us-ascii?Q?Sua8QU0HcB77PQANx/Nw5Q69q3/6S1lS5AB8vNDPrSSCMRIdLVik/k7lWz3d?=
 =?us-ascii?Q?yVpXtjgtRHZXD9N9pKc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:32:49.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97e74c-b331-4a9d-9c32-08de05bf27a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

On Tue, Oct 07, 2025 at 09:12:20AM -0700, Jacob Pan wrote:
> But I am not following what you mean by "replacing
> arm_smmu_cmdq_exclusive_unlock_irqrestore()", could you elaborate?

Oh, "replacing arm_smmu_cmdq_poll_until_not_full()" I meant.

Nicolin
