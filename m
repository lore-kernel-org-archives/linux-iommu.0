Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632E202982
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774075; cv=fail; b=O3Erkr+eewnh4QJXHOZwHUcPZXowMVUYS3ykpd7QShGocoeWSZNKXymH/A7TMf+YMBKHnPIeRLrwpm1upwgIQDraMC269+9dwJ3Opt/uRKOKP1nLroUhIWzKILxSuZl/KQJM2sjRq2F53vpC0HILzdMBhiLTP7rLBLB65wRGKng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774075; c=relaxed/simple;
	bh=8AoJNUP2nu1PCfxvmVwriV2rf6GIgBKnDXjkLQXQ3Hs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8+azQxHcWaOWzEovBG54mQnPHM2VTVlROUOdzax+pXCM+qA8wCYIPDnAYr2CNHUCFCAzPh4SNrDJk2P1iEyAhxQ85nxgs1sL8LgOancFwnm0gmcGEn+qQq5xEiPtNN+yeFKJmxgrhybotp+vodEbBzakWqi5s+Q1k84Esfi8WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s80Sud3D; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s80Sud3D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6e2QdlHnHLi/SeBBpzCm9ntw8Fiy/8I3hlwkWrbIybqEZe2CxyP6hbxkJn1uIbQoWG0Y4zrL9gfsiWoA4DxKKLm1uJW50VTeajKGFcDMcNzl4ZV2qxn4aFh8xaHU/m+69TKON/k+XcIDK8HNfeWlVuMxDTpeGUnuVcUrZ0WGHyWg6Nn/afL7QZHliI0JjPWKQxSjKchBBiosLoTqHEDxjNMCgH6AYGy3sMX0+eDS97eIlS2a1R6srJ3E2tCrK0cfSRVKXZjTP9z5KU6P9n4I2Zjgn+s2ux8GTYP62AgP+bbXZeWq9OrodaTrPQLwGyJps4R5Q2lxceuAZIET5as8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh23gVXQLZh2i5Qiyihvw6DC2PaQQiImJ3sCFR4Q+yg=;
 b=HJIV5Oi6YqYhiMQaNqyki3W29/Pr8O4Hottd3lVU9uFPax0GngxXJ+XERphM/0yppj1JTlO+O1X+ilkc2fH0WtG0yU/zF1w/ST7N4sd0yAlsAW4QMEV+yLjQvE1/NVTOKZ9HFB8kPHYVo7cBN4GAOyFbcSvETgWZcStC+cDdvOK9BJlQoNcb0tnDhpPBaZ4uBhphMCnkqeq1DQWH7cAj9kbgE/WMfHhKOc0agVnAHO/oDicIC5uGSZoGac/rVURI6DmC3XtQ0qllig9UtpMvbnsFQs02vYqf2iIiEuffyp8LnK496L8JwTb/9K4oYkXpE7PagnPLAKmO9KOcUX79+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh23gVXQLZh2i5Qiyihvw6DC2PaQQiImJ3sCFR4Q+yg=;
 b=s80Sud3DV5NR6URjxSwx1liVk4mSLlCm7sz/73WaOmdrh8ddM5DOs4o/GjJUv0cjlMtV6tW9mTaSyBi/zz8TE+rjWUdbHyJZvPEUbzVdiD5N0g7oCM2vaQ6ANC4YyansKMk+ikokbvQhFtLR7C1B7mjUPGO35DyTLxijPuNGcBQdKSvBTtc7gy7knwg+RNI6qry0eFEC92b0cf6SA1stQkvmhPVOGVuH9IL/jLbc4bUCaH7lr+1Yo48ZddAZqUB0fvuelXzIjzfugytmJp2vQ9MT81Vdbe3Rijm3/+Z2qRqq3c3jEp0ygNfex5V/Qt/D60XEYDaTH8LA9flwPkcIrg==
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 20:21:10 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::20) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 20:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 20:21:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 12:20:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 12:20:54 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 12:20:54 -0800
Date: Fri, 28 Feb 2025 12:20:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<jgg@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: Sort out domain user data
Message-ID: <Z8IapaN1ZD0wImak@Asurada-Nvidia>
References: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: abba1fb1-98d2-4d50-3f2e-08dd58356fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kIIiWq2Km6KjQPuu1V7E5iS1dpaV6YGhkQ2HI9Km2+BVFebvPPDKkH+nC4aX?=
 =?us-ascii?Q?vDg3vtLLKQfL4BMMoJGOYkfeimdlqOSMCeGV2Xv5z0jtjWEXZnKucTRUZqMT?=
 =?us-ascii?Q?8HdZGAxjP0IewIgGds20h/tfBjDHz/Y3KO7Y0aJo03qCLhwzWSAH9cGFD8h1?=
 =?us-ascii?Q?P+72fi+PjJfy0vty/1AP0J4BOWeNFoNqiMY8hpvGsW2M7OHic7c3fkHy5/DQ?=
 =?us-ascii?Q?KDs/dtmjvoaxh2yyhtlcyTpkiVCXigN+VX6W2rUX+7/gcgE+m5deYli1jrzm?=
 =?us-ascii?Q?4OSA0cJ/GWGhIMb6GFgUtAQ9O2iZH0biUu346+4eBAFAJABAFnqaFYTXscf9?=
 =?us-ascii?Q?8nwtx/xJI2iF5gpVTn9H5dtMt/Aa/jz6VEY+VjNMF7dxcXN+91Y2sZlFEPWb?=
 =?us-ascii?Q?l3FWS20lX4VI0EYUMibP+YIqo4GahHtu1enQSlsf3GocvFpTcS/JG9nI51t4?=
 =?us-ascii?Q?VGbS5d5gGk54LJwctzgYvg0CUZmeCABH6v82o5SqWxWLvy79234tO54fwjsJ?=
 =?us-ascii?Q?vyg6eENKgjgXk73CYSDREQ5VcaNl0m1u3gUJqG7HJjKhXiDCya7uGl3TqIFo?=
 =?us-ascii?Q?tZN4LGPFDF5pupucS5Zpu90HtqDzk3weRQLFPcS2M8VhKP1CU8n2JV7RIHHQ?=
 =?us-ascii?Q?AiaBpFNx5aWmfleCMbXcvUnUqUYB69d7KoEFstXKDCVj23lig3bVysPfJNFu?=
 =?us-ascii?Q?fHnJZCFIBbVlgyMeL6plYVFDGfKU4ObiJ6qZh5SktYWPPgXYnBONZpbgPY2e?=
 =?us-ascii?Q?9/31Dr36WLkG2uSoXoHbCYhpFcBC9xeWHiGOK69REELFZ1xdPeCWLvS7vhPp?=
 =?us-ascii?Q?jvlsVXXJQpAJohhO2iWC5BKW7DVa+07eNQYDAl1gu96RUoFRUtTOctVSe7Fk?=
 =?us-ascii?Q?zGZ+Id4qauxHJTXUCajJCGseqi07fdOJ0f5Gz8quYyxWOFrlA/xi7TpWWpjM?=
 =?us-ascii?Q?4aKUqJSij8y7jv+DumYXTFeEa+06J71k0tukg56en8asi/lcyFeSGieHN0s+?=
 =?us-ascii?Q?yyhzt4J1ST9Kb39Jf61cd1nkxfA7kgw7Zp+Q9t4zvnFmil2Z/N/SKp5TzStw?=
 =?us-ascii?Q?/gKhyjDvh05fQ/zxXtO5Sf/0NsxHSP54TU/zZR4j9JKoQvmC5C/Kop++VOjM?=
 =?us-ascii?Q?fa/glMzaadNO0VcXjYruihIoUL3Z6N82htfMXGHejniUBCAWV15EBm05tvOu?=
 =?us-ascii?Q?Q03bNiO2qSczw8IYyLboWR7rzCrwjUBXkGR+6Zx5bfHmzx+spHuXoeMyoKe/?=
 =?us-ascii?Q?ba8gCt+QrULMngQIJz+Us+HOQ7sw24a5wiAXR9MstQYUEmKHNuE8Dv8NDJ3k?=
 =?us-ascii?Q?El6p6X5DuHZkZeW50eX1lVeQ8IC/WQSRXvuXVNiGzXyzEHSEi7o1m1Xz27oj?=
 =?us-ascii?Q?8vSrMUtxiWD0nRqZBJ2WDF/NjRirc1vz2eYu4JVGBGnMCmEWP4zRQNS6/n2P?=
 =?us-ascii?Q?TEum3yMzeNwHxMiHy2itrBQCD8w18MMFCOtkSWA0N/mU1KAvgctGA2f1Lvrg?=
 =?us-ascii?Q?OdA7YkmkGZcHIRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 20:21:08.8837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abba1fb1-98d2-4d50-3f2e-08dd58356fe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995

On Fri, Feb 28, 2025 at 11:31:11AM +0000, Robin Murphy wrote:
> +enum iommu_domain_cookie_type {
> +	IOMMU_NO_COOKIE,
> +	IOMMU_DMA_IOVA_COOKIE,
> +	IOMMU_DMA_MSI_COOKIE,
> +	IOMMU_FAULT_HANDLER_COOKIE,
> +	IOMMU_SVA_COOKIE,

I would like to change them to IOMMU_COOKIE_* so the iommufd one
wouldn't feel redundant like "IOMMU_IOMMUFD_COOKIE".

If you don't mind, I will make the following list:
-	IOMMU_NO_COOKIE,
-	IOMMU_DMA_IOVA_COOKIE,
-	IOMMU_DMA_MSI_COOKIE,
-	IOMMU_FAULT_HANDLER_COOKIE,
-	IOMMU_SVA_COOKIE,
+	IOMMU_COOKIE_NONE,
+	IOMMU_COOKIE_DMA_IOVA,
+	IOMMU_COOKIE_DMA_MSI,
+	IOMMU_COOKIE_FAULT_HANDLER,
+	IOMMU_COOKIE_SVA,
+	IOMMU_COOKIE_IOMMUFD,

then:
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7de6e914232e..227514030655 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -413,6 +413,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
                iommufd_put_object(ucmd->ictx, &fault->obj);
        }
        hwpt->domain->iommufd_hwpt = hwpt;
+       hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;

        cmd->out_hwpt_id = hwpt->obj.id;
        rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));

And I can put this in my cleanup series v3, as Jason is asking.

Thanks
Nicolin
