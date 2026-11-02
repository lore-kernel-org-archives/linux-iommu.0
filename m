Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603130;
	b=mpI+fz75rf2fWIo8PkMecBZzJMEArXzOEu6Ag1Kx5pjaiqtnRcPL0DSnE4gmMHvDUHlF
	 ujMpUjzgbVTQYsg6SYPBXtE3Zjv/0+uOhyJN5SiKl+SsP//RfnXE8HnAYqphTdWJRTasu
	 Yd4ogTNWsyte8MpzmWHoGJysuJOusXRZEtGKIPzao3oQin3/lKxkmqFSkKaMzUVIT2rbe
	 zmkmOVr5WZUopCoR+XVR8YRPHWYBfzPM/cRyAJsaDumin18W3OVOvMF69msOv5K4yx1jS
	 v0XkFWqsgwWhleZfTyyYp9YhknpQzTegatn5q+NFYxhREX8YL//nPhETEbytgNrCstg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603130;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NYP5jbcaEJiux2ypCpi66jxiDzQZVmQ5nEWq1djwVck=;
	b=HxyudErsWOs10aEanz9VhhBn+RLztYkJ1c8+ThVz6AppHEw8oYhIFs7aDLnGRHEHeDs9
	 op8g0RJFOQ5/kNtgGMyGtbkNLKbPZW5r3yCho4IYfv/yxFRjvuOpyZ7MEdArdcGkVysWr
	 Gull7B2gv4PL/soJuJd/F13A+O2R9L6xPipCyB4Me8v08tKB+8ok1MoVV1uTdfTNgWOzL
	 mJPlNXDfxanwFhLvE//fYn0rR4UPWoWgCQO6TvjOxCXqDtULbl1vosOCDtVkXi8Y5hnt5
	 +gV9UOtkBcRiWn6V/9g130BudKAuB9Q2pldMBOPvNXYTx0Ax3dgpiMk55X1URdWxDBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZQz8+6Gx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.16
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA65606A33D
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 07:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA65606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZQz8+6Gx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDof9kVCIk0l77KmOpsp0dIdE4eRFUsbQvuqC7pHcZq1OSdm00EJlAHGwHXQp7MuN15mMnvHZfxnlJOWPXIcc6gc16Ec2G7tv42zU76gGOr2cgqvSTCQrKKYvFxNDVfucU6yyzR2r0LrPBXQ1BvGBWnGi5TSDNK0+XKtIu0o0jJ7BpIy4lZPruz/x3R5dvYXQVJq+ZtepDTw/mhQB3O7VH7bb5RC788HPJP2Loxw79hGjvk6GTj/4iWpYfXUEVGOTLJF4NazTlP3VZrVHTr/um0L/bfWaS3u+dXyPqO7pFFIplP47ZrL9Cr+lj+nHN34nTpwlupeBJd8TNaxLXif3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYP5jbcaEJiux2ypCpi66jxiDzQZVmQ5nEWq1djwVck=;
 b=kdBQ7tESm2BB28cC02UG2DHKlVF31NzZCtomLQ8Se55hvhFTQDr+yrn26tKcL0lFBby/33gJEWtJVuzoF+m4g0woXgImArEtvg3a7Ysy5IBic3SpQs71rpdBe7m59Bjyzg7dsDdul4jsd3ix3q2anqDj59fQ2j+4ynISp9uZLm6fSSomYse7653jjntUOfjobv9wRHlsJYmmLiD14RyEM0WXTYcob04dymFMHVAN3InEqt6mFvuE8O3Rui/ladQ9DolK6zWNCmsq3XWMfAy2ayG5PB3/oWcbSiX0xyWnkamCRE00Vm+cu2hD5EpZU6AwAxCFowevFTvMKL1NmguyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYP5jbcaEJiux2ypCpi66jxiDzQZVmQ5nEWq1djwVck=;
 b=ZQz8+6Gxstpgme6o85HYtSFu8G8wdoerUjg0PVJR+6eADwKpIpNIWHVWfa3RdN1Xcick5Hn9/OCk7i3sVyLsIsMvbV1MbWdOs8Xs8VmlWNK8bGNM2+maIYLiTdZoJf/NgBUku2bSyvnH/Bn4eoKr44d6e5dDT4DacpMxciJ5rfXj4bUrULqVj8+Rk0p/pbUuksCiGM4FTsYT2cDkO4jDfPEf4MCJx4M7t9F5LSYZbmCbFKmoK14W+AQEn/xkUDnHu5BWtkVS3S+eDD7jDl5SZqGs9719ozcvNLzYSFqEPLowcd22YUbuUHV2FWN5IH7MRZ6vAFTShBu2wbjlwOwZtg==
Received: from DSZP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:281::10) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:05:25 +0000
Received: from DS1PEPF0005344F.namprd04.prod.outlook.com
 (2603:10b6:5:281:cafe::10) by DSZP220CA0016.outlook.office365.com
 (2603:10b6:5:281::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Mon, 2
 Nov 2026 07:05:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0005344F.mail.protection.outlook.com (10.167.23.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:05:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 23:05:14 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 23:05:13 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 23:05:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] iommu: Unpublish the attach handle before the PASID detach callback
Date: Sun, 1 Nov 2026 23:04:36 -0800
Message-ID: <30a392ea6085cd948b90f38437cb0afc41010a7e.1793602084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793602084.git.nicolinc@nvidia.com>
References: <cover.1793602084.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344F:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eda4c8d-a8c6-481d-d8be-08df38afab2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261021123027099003|261021121427099003|261021135927099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	yIgrfSpd4F/HkW/WliItK6vLxyxncY1GwKBeWKBubJkQfO8oHnmaq/IFc5Car6MMA6OqArAoTgIGSmbFM7uClM0x3zeG1F0bc00yk6U7zaFtDm47WddYqCGZ+qXqGEyD4xVWT08QxzUNg5BPk6zMhnht7sZ8O6UlRn8d8cZMMYFbChE1jtnE71vX52WdszOljxDoPEvWLgdHeo+Eoo6S0mzc5FwKmgsd4c7QOT9hlmO1ArhyVjHB2LLLnFaPNRoVtUMX0sDVlmbcV7N2ul59FMdhSrRMbNYnAqodyx/fu+/tikPlQEKfDc1B4/9LMO9QnOuMWA5TPF0H/pDcaO5dZuc0UYC6wlHNqNo8G+C+jvzBGHg4/+oqBg2KDwPk8PZ+1THOHy4+qVxD1QyRAPcknVrVYk9ystckcifIBiW0GYXrAhLNVyAukMhyxfm6xhJeZI09VGoNtnuVDNFjIjyOO30rJ43RJvWmKldkaIAqQjJIbXl2Bn3RPghLKlaL8UVx0Kswwkc1gtuRrk64r39GfR1NVTBEZxmNBPhHaFBavsz8csQCgors9JrvULs9IMfI4prVVBEgN7/sL/lfs+qQIUyeOT7qPeqVo8ho4OP9BHp+MRET396xdmm7ANz4oChtMbOOIpw1PT3hXOcQEv/anHsUTvBuvwXoDol4qoVxJqdJlezUc8S8aGlRbb4gB0rmUwP/H3CMXpAx7m81df87Bg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F01tGJOaqpeAkdKyG2ZEqeJ0EvrQLRkZG344Z3CCKvOeKTomGeeART7Bd+JEIQ0BiKJoNXbFAXDI1zd2sc/Arwu8x48ENl3OIdq2KXcaK7dDJOROGp4QFxy+aFpA5EPp5KSvLa8JB5HIW4xgRlfGCCniC6ggL6p5MdjIpUeFtv+fYOFQ2c9eGInbMbOhfpp4QF2n9HGe7cksV2sUM9j6EIM9uQtzTj0ggil3QxQr4k/IdDi7jj0ioGspUagseTzcA9q1ephskkYhz+LbT9wGAhODt/D3GfZTXqQsPDn3R7MIsRiKy8ZWy+oqpthh45AzJJ63L4giT3kHipjBfSB5rUGo5bXrUOuJ1w59E5i2qZKkwg2STN6w/Z9tJ1BszZ+nISYyDW/oOBkSFFaIvjlgrcB5BXw4hqVQrOhvTWChjTFjrrT1L5GlFJUHx+ZXCLuV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:05:25.0958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eda4c8d-a8c6-481d-d8be-08df38afab2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0005344F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

iommu_detach_device_pasid() erases the group->pasid_array entry only once
__iommu_remove_group_pasid() has returned, so the detaching handle stays
visible to iommu_attach_handle_get() for the whole of that callback, and
the caller frees it as soon as the detach returns.

Erase the entry ahead of the callback, for the same reason the group path
does: a fault raised in the meantime must not resolve to a domain that is
on its way out.

Fixes: 16603704559c ("iommu: Add attach/detach_dev_pasid iommu interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0f9d49a5c3fa2..aa50a8f6ef6f2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3818,8 +3818,12 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
-	__iommu_remove_group_pasid(group, pasid, domain);
+	/*
+	 * Unpublish the handle first, so it would not resolve to the detaching
+	 * domain once the driver is detaching it.
+	 */
 	xa_erase(&group->pasid_array, pasid);
+	__iommu_remove_group_pasid(group, pasid, domain);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
-- 
2.43.0

