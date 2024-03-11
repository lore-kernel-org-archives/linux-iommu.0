Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317A12B81
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148189; cv=fail; b=DBGsPtwu+ULBMVCKyWS7eC1k8dx4YRZIvyMOOieiGN3xB3CYb1OX40T7o+PD8vxbMsLEKXZXDMPWDwkv6sL49vdBwxLB+QaJCB3wfmXpqoGIvXY/6DSn7alvO2xhYJRD2ST9yg91T/IlJ7kQ7YY65d9bAy8SDzNY4y2xnYm/Gjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148189; c=relaxed/simple;
	bh=CWVQZvhS8LW9FLq1HV9Pqt6bFxtovTosFoRmuy0acr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9IFKkCKvgTHIv4zewn7jnSDABIOwmJn8/L1pjPNWulHmwcHLs25+ZznC1COVp5hAXhGLTf+XQLJ3AEamEkDhZTvxJJ8DQEYP/KP89J7vdMJC39189uYyOvGlbRh7UyepEYCbG/farFqlBJ93pBHXdWTGw0739vTiHahp3nZq2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGR79ODs; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bGR79ODs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1X/sTplb/R1uJUVvXVLBb0QnbwSefhcQilpAa25HE8w/Df9aiCezLn3NACFmFnQh12NZAYM3guZDuhd3A51D3s77yLRGAYPuOQ5mvmIqykxOxigadIGe9QMeJDEAsh/vLr/VzxlP6wo0oLc0BP5C7RnxhauhaZidB4ZS2IiQUoHCNX7vUUgy3hM52qaqexeYEwcrhGkUw/5vhoaVEPeoiMBBbPfhCS/l5DBPwMoI1JwQoO1/6otYVCq+avvF1LnjKahHe9oIVGNhuLFdR5Vym6SDlWih3Yja4uelMkCrAwRRSNEne2b6KMJS5jzZUcJobz8jSH2Htiwepe5PCIYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weQy1dU8OedsVxFDdDzNJRn/n7b8qPY6Q32cVhywW6M=;
 b=d3u3ixmF5SDGMUEnOsE5Xpl7MRqnS1edHlAl960/ub5uPy2ln3M/XbAhbiUb2DNLr+1gjB9fle9283PfKWjo7f/yOFuKemvi5CnocQC28lNU1mE6f8EwOt3eTaykGWIVZoCqsegxPrMQqQ5l6Zj+rjCzNHCnviHVyUJ1uJ9Eq+F5btUoMnHTqjuTDvlmc398zDbbM8ljiphZnjxGXw0331AsFP24gWN/GY+gjaKuGAM4hPKQbjc3K1ab37DwokIgvH0/lb6zwCszMpNedrKn1paHNGjpPKqffRcVT2weFDQM1MvE8lCJF5RJib0xRABG6B/6XWBVtLD/JqSnHDdKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weQy1dU8OedsVxFDdDzNJRn/n7b8qPY6Q32cVhywW6M=;
 b=bGR79ODs0po4okKCV9KeNSE0tjf1ar7ccqxHaT64lRkEVukzs2jivqEFABWJqMzFUnwNzNED1ryj5modsPi5fTtcAKjrknwqpiK5XQ59KLnh8kH2oBDjK28YCuKPhxTSXgmPeQmInlxGBW6KPENDi4pD1GWlGtc2ic0AvA2S5IA=
Received: from MN2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:208:239::32)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:09:42 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::64) by MN2PR08CA0027.outlook.office365.com
 (2603:10b6:208:239::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:09:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:09:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 02/15] iommu/amd: Introduce per device DTE update function
Date: Mon, 11 Mar 2024 09:08:30 +0000
Message-ID: <20240311090843.133455-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: b65cceaa-8dbf-43a0-cf0a-08dc41aafcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aGbbBZGUBEyENFZjZF+Kprv04p0BzRZY7PxJk6a0tJuVrYL7tGowHJYeXpDhEr2uh0oyXdyvcKla/LIZJXe65GMpieH1GIJsEpAU5rDORg3T1iu4OhSuwGbF2WvO0u9rwomTPxG6xNKvch1Soi53ZtpsHnzN88hRufXC1OPY3x/p5MeQ9rRLUacq/gE4OsJqVQc3rsZCXse5TDPj5rGF6ejBDWS2cGm0KrNglPW7osMqki1pH7VmbGWCgSm6o7VeDr0WNekoRc/6jatifyZzqsFN4TOTMJ/wVmlRQga27ylSshwVaYi2lI4BPDeNwLq525IxbpX7wha2eXD6Cv2w+njsTPce2HGG7svu7lDP55wzi5YvTPKn+6jMi2+JM3piF7bmuAWTx2rFT6sDBR0iSq3JyyNEgJ+/rZxqvHZuJtz/UMycnbom2BxNjthOSxU1XZjUYjf2l8nc9ywhHGoPoNIXYhA5DiYHdiGqpyATY4pVb7zGGKYFWxCg0hpJ/1gmKm8q610+Hq6oSFoqQWuPjfL1axjiX4kq5ZF0aD5x0SK8lbOBGVikKhE4J7PRGfo4lmBEwQZPHrEaKsOh7ihJocJC/CyiBsBX5wRC7zoUeM4ruAbVmFv08Xqj7a9v9I5N/tX4xrZoCC0saJjVo/17q10ywKoFpGPkqKYBUxkXm/zX4HzvS45NOcGjMP7f/LOHuZwN6NUQUpUQeZlRpU3zJ8GVXW4NsaRCRz80TIbHTxQf1KYlPjqUE705DZ7JmI9h
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:09:42.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65cceaa-8dbf-43a0-cf0a-08dc41aafcfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

Consolidate per device update and flush logic into separate function.
Also make it as global function as it will be used in subsequent series
to update the DTE.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8849955253a1..7979582b8fff 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -56,6 +56,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65..c61a4a33f8de 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1999,6 +1999,21 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
+/* Update and flush DTE for the given device */
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	if (set)
+		set_dte_entry(iommu, dev_data);
+	else
+		clear_dte_entry(iommu, dev_data->devid);
+
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
+	iommu_completion_wait(iommu);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -2033,10 +2048,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
@@ -2055,11 +2067,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(iommu, dev_data->devid);
-	clone_aliases(iommu, dev_data->dev);
 
-	/* Flush the DTE entry */
-	device_flush_dte(dev_data);
+	/* Clear DTE and flush the entry */
+	amd_iommu_dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
 	amd_iommu_domain_flush_all(domain);
-- 
2.31.1

