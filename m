Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A2271A71
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555726; cv=fail; b=AWWBn/Ai2uYBvYIt3cJDiEr2xc2M31OZhyNmdjCIixIp5Fz9h/SH0z1TRtqlxShcp0eNSQDl+yw6vm9D946Dwpu3cnCbhD3gNLEty/QdVAjkumuBmFqhLqRKiWN/TymTHMb08/amXGaC8Nv5pIPg222roxjfgfYawUUC5K/cHww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555726; c=relaxed/simple;
	bh=WzPmDHZFFVuYhuokevURezp8rcFhQldC4+SwdO/C1U0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq6Nbp8Gn3GuwvafbI1xqV/TGaQO7JLxIk1/b/M9eZHWid5lFMJVJjHpCR5oJWZOR8tFJKEyjapdhBc8EZz2hwap6f7/OsvYc4rwOiEKX3I3Jpvn2cqtGMR/A/o3uIA1TmckgHm3m1KtVv/oKxPtk3pG7x8Zm3Jwtcws8VoI2Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gw2VLucG; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gw2VLucG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTtQMiUcKIYulVY1ZETnCmRulXXPQDscNGX2epw/i/tkelQk+m2uoCfOA7it6rqobm0sE3pQVd9W0t9O2qJhRmW0YvzSgICCESItFHyf9AKkTBKU2/K7OwacgyyL5XAFjRqe6q19oi2NQzfbeYcA18x9wvEeEFplzoRwKBkEmsmbIFiYg/ouDbqguwrEve78OHSOhAHTWgRkJ18Z1VO8Ao1RuzgcYNzoXDOFat/G9MaVRoVisdysHgBvNuz3PSTCcUn4CHpJglzSJZnDWUhOlw5M7HPFVzEyWc2zPo4F8SQXetiomb/35FkgprQAMTpXVNMTLnIIECCDkvdt93ms3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnYh7bC9mxd0vdWtRig6aYpDXIDqz9uVhMRaYC4Ze4o=;
 b=ZCXIMewcEN5XVC/TGCd4C3iOABeQTZK/lCkJsje2aVPKGUOWOQg5S4R6H1HPmmPlVwkd2HQE7lPDJc3rSF/1amnmawwPlD4bUasF10TFX8xlenHPpWwt6qiMoFpVaQVvYI/cJN5GOLw0XdEQ3glz9iN6+p0ZKXCV5d08HNAMtSszLpBF9ZmSRas0HyljSDGPEC3+lWB+sAbYzsGlcATOVgbpVPFLl+tgIVtBwfIuynRT38vQ4NminumfMinW0PkmYq3jDMUCGuaR9jKHgb5Cm3C7HQ1H5mJ+o/KwKaPkCQuK0vkcTfMZrYVypKjjiXQHCNBCQhN7QaukNmL5scqkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnYh7bC9mxd0vdWtRig6aYpDXIDqz9uVhMRaYC4Ze4o=;
 b=gw2VLucGQ/XRiKYTiquhCpPxZkFMpylVhSHATrdy4Mj2b7vRaxMyF6vaY6YAfnjpjzYVOIqsPGEZZ3MdUnujsRU9oifupSBkSYBOjjILnDiuYp+aPmrH0iMw//iMYSeX7L8OvbxW23usznyr/zt5SVHO1LdSjqXiL8w+RgWv9IZphHWu/AKgB9Zgb2dp1fqcDwvt7WD1jCePGCaNDYj4vxJs/xpk1kO4as6XPrVsc4CQfb/IpOaNDGYp3QCy5k3PzvGyiDswKfCfw2xS5R5xAcCIHqr5SiSWEl2SwFx0K/Mxyq5L/CAxVXr4WKIivUJIN35MfJJaziVByaGO449pGw==
Received: from BYAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:a02:a8::22)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Sat, 18 Apr
 2026 23:41:59 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::9f) by BYAPR03CA0009.outlook.office365.com
 (2603:10b6:a02:a8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:41:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during __iommu_remove_group_pasid()
Date: Sat, 18 Apr 2026 16:41:36 -0700
Message-ID: <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776551790.git.nicolinc@nvidia.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b383f7-f580-4845-d0f9-08de9da41575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sbWxJQqnxluPQYssBwRUfk1Kl2bSlB83mE+9Dc16wI6G6uIktQxaDJbI4Gn97F7xyxmRaD8pUTicJ2JtXm6WwcHYkg8Vj++MJeTDLQFqG47ZreHfCMW07R6LXeHhaGXWMz5pHw9glxw/ATglkBeGs97blAOhWY8NxwmgUsAYjEjcq24CGltplxsjCZ2mPuPubZVdDSS3PYIHBCiLzXkcRy5Q8RmIFzUGTzS+aF9zUw4mwMfrMoQ+9mm/vt/vo1cM0CqUC/Q1/jp1ouWfLQAT/O5QEMFhQfXAEOSiC1SwtmxISGujBOkiCphK5H8bxPkVlTsZAv+oUav7Te+EmOqndYPEvVFuMrZMQFWCSVBv/4Ei1yEb6/dSll5JZ2SkAuUp7Xo8OndmDbjGB/KKmFkpPKy0K+6faPaw2UMMj2iRkB9oAUjT5PjqEWWPFDJ2uajpfqznbDZh3fSj8zF7dlonfd7myLU9WAz2X1D3s+PVjKDor5uQj/wWUcqoUbZYQBsNdFE91aeGFkYd8yyykNRcAOMTbD8Jx4VtA5MXUaOgTLIc3ZJSfOLIUfvblBdX0AqnvpFip5rmg4E2HLzVweh4Nr5dvnWxBEZUISgaIJzkjYypd7vWH5eijlGONNw39eTePwe0Wt8vW0tGdsj7SLgIqzXrP3b5FbRUe3uz0mMh0bjLP8pjW4egdPagEoQL2OpYxapnyow/HIMX009Pav9obKYAR33U1LQu5WnJPH03hMCbexbr5h5fxXtl6Zp9s+Rg6dqaagPZvp/K1K1sVPbPeA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lvExC6AiNFQiunPIP6lOLXC5bupw2N7fz88Ft3g33+R66JxbsLYLa2GFg8/4oqbQUfY0UUTPEZjZneKKeX9PWVWePe3BllQdVIULXpnlyUnnxLJF3o8XFku4x+Ys8nc+bqWBYVnJfTqSHFAagqjfIEUlTVg5JDBpldZY8xxVI3Irv0U3TR1Ku11n6nKsZPp0oVNFeJVwDdU6x7Yp/u85Sb77ghPz4XxAuev+7UScgdoM+iFNh28NhCibvtL396EWziLUXbDf9+eOpTVOtgSYLaoT6ZdyErifN2AMagx7+xm6c8i8ALgnKdjov3SzewA5AoTuSxTmfJAfMUkNLVBdjXB7XkZ/2rAgD6V8ZzseYShO6z2x1yTnBNVme50n/c0iJr0wc+zJB6IwBgT3jY4z5xjiF6C/IzRx5eulSG1lr0SVTHuYblkDepYP4JF4SWd6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:41:59.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b383f7-f580-4845-d0f9-08de9da41575
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582

If a device is blocked, its PASID domains are already detached. Repeating
iommu_remove_dev_pasid() is unnecessary and might trigger ATS invalidation
timeouts.

Skip the iommu_remove_dev_pasid() call upon the blocked flag.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Kevin Tian <kevin.tian@intel.com>
Closes: https://lore.kernel.org/all/BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ff181db687bbf..30ba18e613faa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3554,7 +3554,8 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	struct group_device *device;
 
 	for_each_group_device(group, device) {
-		if (device->dev->iommu->max_pasids > 0)
+		/* Device might be already detached for a device recovery */
+		if (!device->blocked && device->dev->iommu->max_pasids > 0)
 			iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 }
-- 
2.43.0

