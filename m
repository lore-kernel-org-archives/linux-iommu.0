Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A16FC5
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876099; cv=fail; b=qHQkHUaxs4TeRcJGqkB/Yngfx/LBByQxCGQt38J/xUTcofBiXdxGmamwWHkbuiggR4sCBEmcQd7k9J7nkFQ2rTK7vUqrPhoBb9dnacmiXhn0iFW/I43oQVG4LwNfre5A3n4Y6ypecQIinisNIu8FF1XT2zRFewGMHJpfbLFy4uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876099; c=relaxed/simple;
	bh=oCfAKTcZag/Gh28i5UUp5D3ESYfPU3UdxBVubUyfHgw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSaYMI8yhutcX3MSSDIJYWHLa2Ygzd6kQrx5VB7pzBrxm69oYbp+XUsjN+MiPu04YInRBo/QbfFqALb9C/P+kTy3SwpkAZAIAP0GYWWrd71Vh95zcp3UzkJI0xHyrTBcn4zFFFnbyO5vGaHO7/eMy1KgGra3I6EYXxIDtVE6OMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMbjQzWd; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMbjQzWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5wmSm5OoyKA6s1ATsFCdcxTYvlFnSZqkjXgAW74wJpNTIEr7BtcK+MM+/owxCGnRSA17c0XWYXebL+81sEQUM1MQgU0spVSRZM62oEh1kL/TbLnpO2XD9ZmCEH/7DyosdEPyohbszA3kwCbmZvIBIpJHGyg/o8xI/3rT1W6dt/BsPc2UaqV8CbKkGLsGYYnJJLjvd2WUhY0kloV74php1+e1S3t8+p8f4/wPXtxBExn4RTjEJoMk773LIJaZRaf2n6mMJCxH3j8rtTxTVBb0ObsgZG8zOT+yC8OJxqf/d+N+XTYyw7pD0piJeW+LRoo0MEx+2K6xbwbwudGaUErUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwysrSkhaIB9tuduSH6dkAGtfJVPOMD+MeAwbhsnvIM=;
 b=DQpAJEGKoFZJrDTXPDuCA+kWGSRf0vUi2kngDaC6ue1IOqBU9i7L5iDzNepNWsha6geK1SgspgMNHX4dh4Iu/DdJwCZL8quTWTw4MIqAHOrBAYACzIcXnHcV7Hojvez54WHO61w4hal7BxZs0FDue1Hnl6EGnUWHNoC3L1oQe/HDfFtrhfIEYSjtkfBKB3apmS9h7iY7egVHLZsUdJQUW2ebeaOotF/vGHMOpdYGBxIfY4GHUIlLXlMgXVY+ZgyxS6zmCMgLMS3a8pNNn7BaDVwSuKlZUk9t10JSd7sMaJ7Qs0u4FK56QVwUPHRpq9GHvBBS43eO1i8A+MvDM4bfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwysrSkhaIB9tuduSH6dkAGtfJVPOMD+MeAwbhsnvIM=;
 b=RMbjQzWdBG04CYg32YH8dRaGmt6ZBzq1Cm3CA+6frLp0oBhY5eIzy8Uboquo56agVQ3TJtMhGUk+5GlziBP1IvUu0NqHwwXH06YQVpOjVP5a+KYVeXoOYkDEfvIgOAB2aCAhC63lT4WFw35b2bEqGEAuAz/mfzAR60T7OpqeKQjopamiBoBRJ1lqZow+fSEf6LgDtDK1xeB39LVad4I10LDsSJK07BX24FnmhOykht71e+ZDnQxceGAMmzfWKgITZCwkq85c68hasLmz4CqqXOYS4kLjispAe90wACDOjKd8ovqYhkTdlWt+JohcPZ1YfuR8871KLdoy7aOvuA8rLw==
Received: from CH2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:610:60::39)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:14:54 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:60:cafe::27) by CH2PR14CA0029.outlook.office365.com
 (2603:10b6:610:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 04:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.2 via Frontend Transport; Tue, 25 Mar 2025 04:14:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 21:14:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 21:14:38 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 21:14:30 -0700
Date: Mon, 24 Mar 2025 21:14:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<kevin.tian@intel.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>
Subject: Re: [PATCH v5 0/3] iommu: Clean up cookie and sw_msi in struct
 iommu_domain
Message-ID: <Z+Itnw4ys6dmDsc+@nvidia.com>
References: <cover.1742871535.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1742871535.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c40960-1c63-4bf9-3e0b-08dd6b539895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cw8nexgutpleipBWZfDNnDzZRIh34YCO2FahWU1kBaPs4qS3LbE2r9lokScB?=
 =?us-ascii?Q?Y37IusDQsntyqY38bZ5Emp6uM0yNPi8eSRUuCkHf5LIb+rYKJA2MD5Ma/QYb?=
 =?us-ascii?Q?pMS37cTDxRTcooYShfYkeEOZCidtmTrBuwYqGaYMnYVPpQNNyDgmzacoFmRp?=
 =?us-ascii?Q?PF0wbcPxzVcKJ1ff6WBERWfM8j9eTD7YVEs+Ht3bEyhHRLLCjZdvfeBQWW7s?=
 =?us-ascii?Q?VFMbG2AUT2HVY1IwR8OziXQbtpCWpjf9CNLFwRv/56X4qZRY2f0jLnw7Evuy?=
 =?us-ascii?Q?+7aJE3LCys3q0+Kf3ez3xIxo37dwF51HKeIpdOPap856qHebiOI8HZdWt8d2?=
 =?us-ascii?Q?UbW81zdzFQVpe865Z646Qg7y411+FALTgzsua2xo0WwSBvMjsMlu9chGjKQD?=
 =?us-ascii?Q?o4AakvYFJ7BvVPaK1QN9s3A8iAEfnLZfm/NTLN1zjBG341jxo1Ig7EVUhHct?=
 =?us-ascii?Q?+lSkDnbuUNqhP6tDaZ533cjcS7sKhgcu5NH4A5/w/TTkPTj93y6/vqrEPTcv?=
 =?us-ascii?Q?pDRi0vOLno71XbN1rgRRQLcmu1p+PC3omg11in87qJFpTkqQtubA5pMTx3Tx?=
 =?us-ascii?Q?wTFb+tLILAVfV1CJxG3O8+caE/mS1YVTjOsPwh3eC/BCRmz3kaBoylpyMoCr?=
 =?us-ascii?Q?T2TUFRTQiH7jtbc/VYSGHKsGeBzuZgij22ZnB+2wfIY3gieiQSifpK4bktqq?=
 =?us-ascii?Q?y/C1ZdbNygLM/sKKyEGXBb/PjjG7JAIUkW+sAkrWxtDPnv6zNBws1HRcZDeY?=
 =?us-ascii?Q?w5zt5DrEwmE8dsYWLmaui7aLT4OuFMrSMwfkEc6r3MRTthu7zRuBe/UkyuYc?=
 =?us-ascii?Q?om1As94qzkGvH7EnNj/kF+3kVIDWgxWzCZd7E0W7zBfrQepJ23SjMtzxXJ4x?=
 =?us-ascii?Q?WIrFqbWje0C0dngbTRDjAcSlz8FuXzsq5g28zus7r7Jdimk/TVZ1re8MEfBN?=
 =?us-ascii?Q?sd1mEMA8eSQFH7f67J2fFlJVywDw9pfC3Rgl+T4N0cQ0fZZYpLG3vSNOut+k?=
 =?us-ascii?Q?71zPOehpm3x0T+MDpUonsr1/cAA/Q4BHPItaifWblSYr+kzDse6fPWaf8Kbk?=
 =?us-ascii?Q?v8db/tXYMEtV73o/1CJkBlb5IoDI7uZMd5+BwsWFW2dfoICJ82HoJ0RIHBHr?=
 =?us-ascii?Q?0VXRW+LzIF18la1KRtnGBuO5N5YCIFb15vfuOWIgCoYl4SwP2jT+97pVqfXE?=
 =?us-ascii?Q?y0TatwshxVqLrVNmAICNpbFtTRnfGZCCxkRcuno9Y2vwzWKRCzzKqx9g/3JV?=
 =?us-ascii?Q?vRbw2WoloxlYfkKXan9WNIdN4sVMqY0Cfc/L4bhc+OPpiIhgcF/2/dbX7KmN?=
 =?us-ascii?Q?TmJVXR/IhP1DRGSZupvw5N7UugYM7k+aT6OjpfLOD14J6TcGy+JmQx5pTZ3/?=
 =?us-ascii?Q?KrvmjnayfhR1YIaO9lOmLGrdkv5RpVgueADq2LPAV4G9gD1UNnvCPLAT9CSh?=
 =?us-ascii?Q?pm+I8qvxTrTvkN64h9XgPDdKsiIX9r0DFAVllfXFTNPwLnjIWIHy8sIiV8m5?=
 =?us-ascii?Q?T3puyAxQ93obe5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:14:54.1384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c40960-1c63-4bf9-3e0b-08dd6b539895
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

On Mon, Mar 24, 2025 at 09:05:14PM -0700, Nicolin Chen wrote:
> This is a clean-up series for the previous sw_msi Part-1 core series. It's
> on github:
> https://github.com/nicolinc/iommufd/commits/iommufd_msi_cleanup-v5
> 
> Changelog
> v5
>  * Add IMPORT line for IOMMUFD_INTERNAL and change IOMMUFD_DRIVER_CORE
>    to a "bool" module, fixing build module errors reported by Arnd:
>    https://lore.kernel.org/all/20250324210329.2809869-1-arnd@kernel.org/
>  * In iommu_dma_prepare_msi(), let all IDENTITY DOMAINs pass through,
>    fixing the regression with IDENTITY domains reported by Nathan:
>    https://lore.kernel.org/linux-iommu/20250324162558.GA198799@ax162/

> base-commit: da0c56520e880441d0503d0cf0d6853dcfb5f1a4

Hi Jason,

Assuming that you want to replace the commits in your for-next
tree with these patches, I rebased them on this commit:
da0c56520e88 iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations

Again, sorry for the trouble.

Nicolin

P.S. Attaching git-diff against the current commit in your tree
"git diff -U1 e009e088d88e8..nicolinc/iommufd_msi_cleanup-v5":

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0f4cc15ded1c..d96e6fabb4da 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3653,3 +3653,4 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	mutex_lock(&group->mutex);
-	if (group->domain) {
+	/* An IDENTITY domain must pass through */
+	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
 		switch (group->domain->cookie_type) {
diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 0a07f9449fd9..2beeb4f60ee5 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -2,3 +2,3 @@
 config IOMMUFD_DRIVER_CORE
-	tristate
+	bool
 	default (IOMMUFD_DRIVER || IOMMUFD) if IOMMUFD!=n
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 352513974154..a08ff0f37fc6 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -249,2 +249,3 @@ EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
+MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_LICENSE("GPL");
