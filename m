Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E32524F
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068786; cv=fail; b=e+sl0Y9MWrdc2Lm0Ufqghlek7eyJW/Pbg/Rz1olKY7s5I1IxhlI5wTfb9E7N/4QxrWZQSPksNuhXW8qqBV7atv6fyQD81LmrqCXQkf9P4gLu6Avm8v3RNDJZPFobElqm3jzuZTJiw064xdkkCVfzjMecDbWprvIEgJuKkm629PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068786; c=relaxed/simple;
	bh=k9N52uIEgAeQ6dMKQ/QyeG7VWSrS6nvXCvLU+hUVLUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aua9pZSdL7+sqPMUSRFeZIf/SS68vteonjl1hj5e+oOjFaftemcZxPgJqRql0C+zeRXoGMDoAzgPgl4q/O8ssRwwmVw15HyqBzyry5uEiloVT1UpWwCg36lOcrMPnv4kZ9C3mLhoNbKPt0kpRxE6Qos1whEjxQDBsVaGz/g7vsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tfn/2vlX; arc=fail smtp.client-ip=40.107.209.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tfn/2vlX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG0c4pvR0ou4aLpdFJFLlqrvh9VMpM4F2RfZu/PAX3yBCh0uQLXujZX2ZXHz2V6ABvxCLxnXY3oQKMsmsRmKfaw6GrBaUN2KlxLmb8PrLgqtpp0CkvZuBUuokHqlWool3adrRh1OLW1RUQ5/QgDsVhXWOwOmWKR0GcLhtOsIQayoCWU/gqxE/R1jOmJTsCXmvJQRlemvQTrdgFGGWvpC+ptB5HjqMwXYcldTDiZdCe6I7cHcR5plcSxNm/JhMXSK/cOPebtxMif9tMOEGjIWk7Wx6rSyM5kBYC9Agw4ajJXJFS0lf6AWJrgGF0BWOdsg+aAvYReB6HNzgRoy1Dttmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqBdtVjFGfGlyNTjjBiZl8eLIVBK00uRq+g9hidoqYQ=;
 b=CKQ7ksYRegoe0149HlQzVtOGTc/QIu0Q3sd4WxOLTenWlqXRYz2LE8hGqNg/RHLXUNHs9eVwQWDJTI2S1AkzVXenIy3CLXAsEAymVOQg0xGvzC9278a/gMnBG/XtcRs8IxL3a+b9Wuf5BNylaqh8HMr/8G6JIAH1WddB7GJhp5oeZWYecRs92SdZ649mGDuLMPGzcbqnpuZQKKFaU3WAl+vmururA74IUak6M0nhpCCrKcJGAhD3GfFSWm5IQzYc9EfiYhtG39e8OaqRzZWdRSCa0wKRVYzZPvsNT+LRc7qbLU0PYVYop/FlIbY/P3EYiKMEUpx9NB4aSUyJ1KiGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqBdtVjFGfGlyNTjjBiZl8eLIVBK00uRq+g9hidoqYQ=;
 b=Tfn/2vlXDi/xFPr8MR8L2fia/zaPHgQUfFPvMbbrI7P1+e/VTy+HeqXYEGVhUZLI5DCaz2dDtM3Wn2q79si1QaIogM2lEcalNsSEGTN8D5Cm+b5PTXNC8Vo2Umcj11r3krzIqc3X/7QWPYLYgp35HD353ynzCgcTL3LmPfpl3DINynoaqXLhWGCDCgb7+29FIlhc/SsGdK//fEq1KrSat1Un2o5IMb8qL/MYabMgt8FmWJ2ZdOlaaEjOejGleXGWR4eqV6MIV/jqjMpktEkm4nK7t+KPrZn60JeonLS6sOdJwaoktpqodt0HgiOYhsOqSyRGpVgBpXhhMACco/rMQw==
Received: from BN1PR14CA0015.namprd14.prod.outlook.com (2603:10b6:408:e3::20)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 21:19:35 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::ab) by BN1PR14CA0015.outlook.office365.com
 (2603:10b6:408:e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 21:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Thu, 13 Nov 2025 21:19:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:19:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Nov 2025 13:19:15 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 13:19:15 -0800
Date: Thu, 13 Nov 2025 13:19:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a2e342-cf40-4190-a97a-08de22fa589e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pi8aoPpHOBe+GYYUXr39gx2QZOq8WOuliK2+4q6BPzhv7GFFdtOhnrgw9O9k?=
 =?us-ascii?Q?WfQdJ1SbGiYQlb/mt0DOv5Kmqkhbg4/Zk/+VRnZSH1zSIpfcKZTJsANUhtSk?=
 =?us-ascii?Q?i5FF4nsgYAg8c1/+ab1v3q8g35PnbhLpXGvAgJBL6IRE7uvcss0fBndPtE3z?=
 =?us-ascii?Q?FbE8SqFaEkzvVPWcHdStuTwSZN6PFB0JPyz/qprIQRM/u4f0Lj4iVnBX1iqo?=
 =?us-ascii?Q?tVpO8jfxgYQ9tbycmHQFwLlx9ql5MKIYrSjpfbvUB4D1pyjJmu/4Xqb0Qh5H?=
 =?us-ascii?Q?r0U09UmqQR6ioZ2b2PRd3unkV93odYlj82vQ6uitWhPu/Pwb9QlxOGwqBzOH?=
 =?us-ascii?Q?hEM9m2ng98TU71y25d3EFyXWJWb1eoPS004FW+GpZiwfOc3hKxsDkgnML1Oa?=
 =?us-ascii?Q?nWeSnPlmr/khVn5TfTQWFY6FhcY2p5CP/X0FQYNX7fbxT4YcSBYSvCJXZ7CV?=
 =?us-ascii?Q?N8aonhPBIdMe9m3UhJVz0KW/XmZ0PUJVRFIz8yG3112/eQnkMTFzC6n13nrx?=
 =?us-ascii?Q?AQD1FrN0RliwfTam5lYty+ZLizMVgszHXC8YgrbKZJ7bepYllnw0F1/wCTg9?=
 =?us-ascii?Q?0nTlhdKih0B3EioLy0JB8G8RwuzA/473cOvNLUD5bzdBnu9FXvdeRiQ2ZViM?=
 =?us-ascii?Q?DPnN2K/3xEbVpwJ8W194tnsiO5lgUZHAwONsKjYvYGYU+EOJmLP+Y1d0L6Jo?=
 =?us-ascii?Q?GdOKJrJt5LlJ2StMNq0AIzNID++AvDdQMZurB4m9XXUwZT74iDzsQukPeFhi?=
 =?us-ascii?Q?ZXFglGSBOYdFUYjPC+6vjnqxlzmOZICkFJn45pctjDQIU/F/pHyr3Rfx7aCb?=
 =?us-ascii?Q?VwVKk1zsaL7EATCcv9FEF/Q8eALCae5OzY95PXe9VDHMA+xBjVlkUxNf8s83?=
 =?us-ascii?Q?KfqxS4Gnt69ta9bvFhaoDJIB7q/eDHlxWHZ/dVKwqV25A4wnisAW3OnClhI3?=
 =?us-ascii?Q?KHr6iLhsgXfWTp1ocAAHUY08Ppi4CFqQ3D3ZfTA90oa/bA1QJ/Tcb4jPB6Mb?=
 =?us-ascii?Q?rNvst/BbBAzJPAoaEGmZlbbIy1z6n9w6IUDC0QTCfEEYuodpLht1G/TMC4JF?=
 =?us-ascii?Q?whIKIKQgDJjjIi97W0t756+XRpGheC6uzN5AuitlIsgUn4HPHCqQASXTPUDn?=
 =?us-ascii?Q?AtKGTjZwZRJMp6PJPf0d9uutZaRvqkiAUEsZemOtUCcoyDQklYBG31g81kY7?=
 =?us-ascii?Q?Bhfl0Ggbhixg0Cg8OC9ERVJ+aPvY+42vthklhj6pmg9x4RSjiQW9dJq0kbVT?=
 =?us-ascii?Q?dxJN2WrxySgEBpWoICbONUKnJn7fH5oquKiOJqYz2NDGw1AEdv2S2p5lAJcU?=
 =?us-ascii?Q?O8b9nFze0woDqPFej5ptaWK2oQuv6ExpR3F5T7aReeniVFW/LQfqVMQBb1dD?=
 =?us-ascii?Q?NSuY8oepfSzN2FLRb56LS8cbcnpiC6H0+dckVGJ0B81Ote2Paj/ED/EfQGtu?=
 =?us-ascii?Q?y2BbwIgZF3peDulN7eyBwFIBKQVUvW36wxVvt/HVrFB/+yVG3U+QyId3j0+r?=
 =?us-ascii?Q?F7icGgS9HYnjXzdBiWkHtuh1dNqodkAzZf9QRZ5EkkVE5Uuv3aeNg4cmtvpf?=
 =?us-ascii?Q?zrPB4IdhNjYEUYDXwrU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:19:35.5350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a2e342-cf40-4190-a97a-08de22fa589e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

On Wed, Nov 12, 2025 at 06:25:05PM +0000, Suravee Suthikulpanit wrote:
>  static void set_dte_entry(struct amd_iommu *iommu,
> @@ -2074,8 +2094,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
>  	struct pt_iommu_amdv1_hw_info pt_info;
>  
> -	amd_iommu_make_clear_dte(dev_data, &new);
> -
>  	if (gcr3_info && gcr3_info->gcr3_tbl)
>  		domid = dev_data->gcr3_info.domid;

set_dte_gcr3_table() now always get the domid from this link, so
it's unnecessary.

>  	else {
> @@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  						       &pt_info);
>  			}
>  
> -			new.data[0] |= __sme_set(pt_info.host_pt_root) |
> -				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
> -					       << DEV_ENTRY_MODE_SHIFT;
> +			pt_info.host_pt_root = __sme_set(pt_info.host_pt_root);
>  		}
>  	}

And this __IOMMU_DOMAIN_PAGING path seems to be used by v1 only.
So, it could be squashed into amd_iommu_set_dte_v1(). This could
tidy set_dte_entry() further.

>  
> -	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
> -
>  	/*
>  	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
>  	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
>  	 * do_iommu_domain_alloc().
>  	 */
>  	WARN_ON(amd_iommu_snp_en && (domid == 0));

This, if it's very necessary, can go into individual functions.

Though I am not sure if it is accurate as it seems to imply that
IOMMU_DOMAIN_IDENTITY has domid == 0?

But an IOMMU_DOMAIN_IDENTITY does:
	identity_domain.id = amd_iommu_pdom_id_alloc();
doing:
	ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
which means it never returns 0.

Nicolin
