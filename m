Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC93218ADD
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512904; cv=fail; b=Ilf70qKbwIc/nwaDEZHSsww6NSHqIkUSC97DETvrkT+FQYJiQUG7T2Ai2+6F+2ZVnH617RCv4kMEZ5GSx71gbsm7lWNtZ4npxF23X38nmnvqI9NbmhVrzomnoxk22kBQ3fEawkxiU55nncDFrGMHo2IP7lKsEoUaxlGeJ27Yw5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512904; c=relaxed/simple;
	bh=vNmjESXHYyfcyn+1vWgI/EQKamzEsMPSr8cki4BnNYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBnR+IWzrFDmIvhiF4uu9qUj7Aet9oF0/Rvq+WS8SsHhCXDz2xvf8TyoLhNcV8GaAEo2UIHjRQywz9Vgf6W2eijGdDGqYzyms9KM+OWydUgaNKd+dmzgIELuNgzcHV38wJb4h81Zn7i1wWuzAcYWoi1rSzYM/1dv30WaviHsoy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1uvoF09; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1uvoF09"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adIH9MbrpE9Ja36IzgCZChHawsNJMJfkyH9lsPTFKMCOqabqhZIIBvk+4ZbHULSG2qJTasn6FjohfVu1pn7W0REAhjhd9yFe0KJLk5EBn/NpcW2tfgP7lJBwcIIceVyNSDccw0VwKww+/seqvD3WgLi1kd6VczJG39beUG/tjd7az0IsdVnWaG/YJgWkp1QBAFiSqiycsW4k8KOOEBazzX4GxYmsFQH5vIEO5iilslbFlVq95YCrzIhtiuEjw7NQNDaEX1zMYIgnlEsczDHcPpKNksRo5jiy2KDit9V/ZVQ83LJMfPnjOpY74G20O9jyqgBShrNkCWIjNyx3/HIIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anAVr1ZHKnw9PBweBNYC7it7astv80ItFJ4GqFIDVFU=;
 b=xZNtg/OsoMBy/8FaTPoTEPLs0Kk54WrPByHb1EzFPwUlQDoodyD3F9OMl/xzSr6B+fLw1xRnzCg7N+KXBVRW3gFc29GhofV/Oyn05fAg6IEiIJRf1N+i7siRr3KYR3FogZaR3sJSAExNIuY0q4PdnDPYZpvwB7Uhnka386dndApTERdbyioPRsk+SpCrtm72C99r3uPVHRg6Olovnmxj/Mq8sU/7yhDHKGXTZzODGuWX3RIdWkCBHwXY9YdkaC+91Zp191ipS3LhNir639/WWKbiXQ3Ex1EFPfncXjWJRcW9XUYIbtRpyxFxnyhEoP9UcFRIABQcwrafV0k+Xx8lUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anAVr1ZHKnw9PBweBNYC7it7astv80ItFJ4GqFIDVFU=;
 b=B1uvoF09dwdFRuUmdOIFghwaNSRjuYDT2p9QcKltjDA7PMf6Q9OTC1SJIaiatRLo/FjlfJcq8+uCK9YwEGyVg6/0p1JKHjXf2Fke22XNW5jnNDEK3/HUWq47TzSz+RO0MvVkUhSo1ACpUIxbBa0z2Jr3HIvOgk497ZKt/fvrJf+LsxdYwO07oMYvnnyLmm4WOSgVZDCGHFZz2v6JSJk2IRTBxHxnanSEyhYu6eSMFkMdh4Jqmwab1paeQuhuwTg2wNA84845VAhJ6AjXYsrgj6puxG+a1N+JFsw42CRHBn0zJ6/IriW+SWt6spk3IdXiW3ZGt9hnQ5P+FxYh4QXAeQ==
Received: from SJ0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:a03:2c2::22)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:21:35 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a8) by SJ0PR13CA0047.outlook.office365.com
 (2603:10b6:a03:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 23:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 23:21:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 16:20:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 16:20:34 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 16:20:33 -0700
Date: Thu, 20 Mar 2025 16:20:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
Message-ID: <Z9yiwAQDeCkBZ/5i@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-18-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: e781a492-2e67-4b04-a21e-08dd6805f4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8WBtzV5+eE724E8kknGG4vFjskMiHa5WQn30KdCe13iJDUewThhduIIjRzNb?=
 =?us-ascii?Q?OpW6cNhDGvDpqe9UuYu2nB0kWWtaX/wGIfO6K5UeDIRDr39sIV9v8HBS0eYA?=
 =?us-ascii?Q?piH8gQkR8SwLQlvKalEY65oMcJQadrSY71zOzOypci82V+tqzsyPXEn+VaOZ?=
 =?us-ascii?Q?erSRk/DP0JpF91OglPh3Hd9bz8o9eslI4D8YH9075rzTu4ELBSXCGYYEvimh?=
 =?us-ascii?Q?eC2uoL23MW9OWoC+vEtIrUyFYy1rdGBezlfBEuIY0ELqmfAe8WhbBVmaSHBm?=
 =?us-ascii?Q?i2XK3hjk70/acr7aMhCGSK0+z9PeAWzDu75GJaumfh9sKsz1sBVEOzVptFDY?=
 =?us-ascii?Q?kxmlKSy9cY1YxZqn21/a0nzIcCU2LLvZH2+jRxplINiBXHwId3LtGurIsnjM?=
 =?us-ascii?Q?SoJDIYMzdYIJJn8lGnpmprLdgBd1X6FplKfsh1LmuRhJfNOKUutNnmUxMh7J?=
 =?us-ascii?Q?4ZoCSp2Dj3QSBY6X3OkZr6aTY0bJsyIgcvlKa47VnQP1AChViCfbpVlimZ4F?=
 =?us-ascii?Q?Kfa5Ryw2ZnOHiGoGLtrqXR6BOG3J1YfgUByhAk8dwBaZZZU2VnZFI3nMbB65?=
 =?us-ascii?Q?a434PvbdBRHiHzvFYhxM0lduwVUjA4582GjvKp7C8wcyDG4BXxCUiDM567p8?=
 =?us-ascii?Q?WMbsJQ6HZxL3PveL8DLEh91lxanQ4UhK/6JByPt2QLCBw6SQlwP2K/uN++X2?=
 =?us-ascii?Q?u/kkfLJv9lIAYsg9buP54QKtgE5r51kbyKssyWJOwEdUiJh9dGRfYH8TEDKR?=
 =?us-ascii?Q?6V8gF6tuYGaNQMCd787laykX2Ga3WPGLTrD6HZAGL8aQcMFOC1a22jOzKnuX?=
 =?us-ascii?Q?3V0HRcH5Wf65fjrpzv0klXfiP4g2VDjfSpiWwehXI1shvXTxFh7Iq4cd3CJB?=
 =?us-ascii?Q?8pLwWV0B817TpgPWGbUKIg43xji+t5ncqcU4QHyB8jvuAWYIRb7/4HhPdics?=
 =?us-ascii?Q?nklj2/WWzz1Yr9IAObwEIKUOUuxBJ+RpLwrX2zC/2VjTKYGUb477X0mcpDF/?=
 =?us-ascii?Q?B7cop5/5agL1+VXK/+TiqSj4LRT99qWCPbfWQq+d/NSkvYOQnpYh036CiqSd?=
 =?us-ascii?Q?qVIECKrbfj/JljpzzwaceEACBvEz5dGsQ7RStDLTYwNWYbZIlPI+F954E7ea?=
 =?us-ascii?Q?kU7Se8og9iTquWXy6B4bwExkpUdcfRPy6J/Q57roSq5ne2dWF8WZXf1x5nOT?=
 =?us-ascii?Q?pP4Nql29kPSAw3DZAiLOH7te7F2C8XTVEvWJ13YNPoFg7FOTh8EN+1BsGbHm?=
 =?us-ascii?Q?Id0YZv15JA4djiGLDxz/ySPK0k3qjcDxSE/Xi/Bl1/5XRBqrzqcJA3OKs5EV?=
 =?us-ascii?Q?DwiJKPWvgjz7ihfjS4zkdKFwdhI0Ou9Opu2lEjSm5oaVPcge53BYSmQqkIfF?=
 =?us-ascii?Q?D0adBvSMYQGKPINztUz0dynKTY4kS8sxBNvMyUiWP0XE0g+CM+tQy9AmXwOo?=
 =?us-ascii?Q?FBIGUQHFa/y1pw84pog3DM1HKtqKuLRTzv6wz6hUSTTwk3JH5omkuVVgJIjL?=
 =?us-ascii?Q?fW9sNt1xM5TIoQE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:21:34.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e781a492-2e67-4b04-a21e-08dd6805f4dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151

On Thu, Mar 20, 2025 at 06:47:43AM -0700, Yi Liu wrote:
> This adds 5 test ops for pasid attach/replace/detach testing. There are
> ops to attach/detach pasid, and also op to check the attached domain of
> a pasid.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h |  31 ++++++
>  drivers/iommu/iommufd/selftest.c     | 151 +++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
> index 1a066feb8697..efcb509f7d56 100644
> --- a/drivers/iommu/iommufd/iommufd_test.h
> +++ b/drivers/iommu/iommufd/iommufd_test.h
> @@ -25,6 +25,11 @@ enum {
>  	IOMMU_TEST_OP_TRIGGER_IOPF,
>  	IOMMU_TEST_OP_DEV_CHECK_CACHE,
>  	IOMMU_TEST_OP_TRIGGER_VEVENT,
> +	IOMMU_TEST_OP_PASID_ATTACH,
> +	IOMMU_TEST_OP_PASID_REPLACE,
> +	IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE,

And we ould drop IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE?

And totally 4 test ops instead of "5" in the commit log.

Thanks
Nicolin
