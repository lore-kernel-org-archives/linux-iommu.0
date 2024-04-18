Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBD8821
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436499; cv=fail; b=quI2+w2PxlPuPUp1fwtv77O7S+/lcjvLCYS5GYQUDIkOdVw1SS8L2pzUl8UYC4TUBbgn0u9kdyEkQccb9QgafADM19uQ+rYR2MnY1b9g3i24T7GS68mW46OyJ1PJVWoFoWpihoJeny6QmgZkcxtlJuZFjCdkrCoVCddz1MdJaDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436499; c=relaxed/simple;
	bh=vZRCbYS5q5zx3/2ufHBGpbNYkLOBQ6UFXqXy+Kplx2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlHMnXbEYnnRTXFjJQ/S13n6j9rH1LjES0n3mbTD/CTLBf/BHP/qwhBO5gGqR2Ky8Y2+i/jQfdMmMzykO0zZwTH8oBOVw7dY7TWxt6NyV1d0erAIGMQfp9vlsgqNJaX/rqGccUAheeMPMlbb3GuhjM1VU69iSWVCjVLGamefcrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J5EoSrCg; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J5EoSrCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8bYriITyOWOV/L3V9caNsARMmcGSOPywl7LHwdw4lb9GrfTp5lqUkQTXbNu1WXOP1TsP3Qdt/tO6v+Yk3nZ2ui0yJdgLsM0TfyBfWV/48aGA+sKQkiMDxVG7xZPcGy3G8WUUFio08wHic6quwSmWTA//Z4mRjEUemgQfGKNqDzSQM7ZpG2clYfK8QtNlu9JBYeW/E2MOmQJBddgrwNfIhIJSaxWuOSvyJQwUNo5OGgng7sYSYUp5mdzq02Q+4utHhVwuRs4renbr5w0IX/CWN0/QIWdz5YC9UExnw3Mwb0zT67zt5i4uofYMMnLcJPVymfH9cZII3mjHBPBsib6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRiLT4HcDHloJt+cgrItEwYLrqFmTvEJ9Xod0uj3iUA=;
 b=UL5cFF5rrVdd3f+uN86VrGNbIT0yuMe/zj0atxfgU/iGt4Zi9oXGV4UZHrq2kkxALXPbovx35lqIiQmag39ms3iYQQpUbDDrcWmuqmq0AYM25pB3+ax9cnT9sl2V1b/mkFHAtTxZDt0TD+bcel0wWik/ugY1oPMi6AJY5FqQj3wRRUVTCLr1NaqucZWGIEbq8LtCDO10xhtUWSeIbqppMjImVEB9/14DztzDsG+4yArwuJ4udCPZ61bxx1XgW2C0e9Qn8xXJfCIxKk1LhOdKaASSJQeZhbDSxTB4oRBR3bU4hFZLI6DaUSKcnJ9IKuWSfiBAXJT89LjpB3g7FhNyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRiLT4HcDHloJt+cgrItEwYLrqFmTvEJ9Xod0uj3iUA=;
 b=J5EoSrCgJx3SvuF/Z+XubPx4v059AE2Zv32J1CXN3re4FJcOri7+Mx1fuCrazY1uhU52z8ttVJQ126K7FGCqjmMINVWWD9OONFzu/nckGeo0HwIlIt+7XTeMKUhDX1BdL3pAeeENEMKocob+X/BN0TaFVd0Qin3G7kcOm1ctWP8=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.42; Thu, 18 Apr 2024 10:34:53 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::51) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.29 via Frontend
 Transport; Thu, 18 Apr 2024 10:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:34:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:34:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 02/15] iommu/amd: Introduce per device DTE update function
Date: Thu, 18 Apr 2024 10:33:47 +0000
Message-ID: <20240418103400.6229-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: e37ab5f9-e92e-4508-e579-08dc5f932f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d7Emwqc6Se5VEs206WNX29cb5wcQF+1bcDoXCuXmbGyulh6nXZMAaz9lkV9F2eURw5TfVrT4YfNV7zeb4g3foaxau92XEzZm53aoi2RLar03Z3ElMw2xK+vA9j5P2fdDOO+c0BBjoTbK9lDlJwuEtuq8+zb7RhhR2Rq/voex3fAgqRhT3wpA98Pq3HSFBPMdZfSTNmp+03bSGz7/zUO1C2e7MvmKfTTU95rox3ozqsh3eej6uK8vFqRPTFnwlN+ift6YFiTQcu07P6TvHEUhsJrKalQnUIcA/fnCtOK+wQQ1G2RmV+/7L4y/N/0T2DoHI7wvumIUHRovf6tG4clkBY4eWg85ubHFfW+YrKwETs30ciHX2aRZDWdP+ddSZnAmbc1tUPbsm1KuNYBlUArnbjt6fywdXFjjATlGbNFFtej+YmJMkilq6ol/xqNrL9dn02iWsGxHtY7cun8IWt/fRQTLa8oh7kaiqfSt6Vsa9HGxXU9hGZdFt49i4srOqn2qpr0ezdLb8h98q0W2t6gQQQyJThNU1z8NdElAqlKzdypjT7Rf28mBgj/T6aDBFB4iHzBV+KsCNt1MwH1PjzgsunWLyjIbY7HOybldtco0uiIz2w5629r0gp92IqfR23ModTjcTBG0uVpY/3Zf085/Ctj6M48p/Dqw6EA4CrKelIK9Xq5LZvlWsujpitSTVCbcAe3//xkGJ9Fr0Qvg1fFXtdwJDR5782W2m9kYk6B0mLxHyzHsjs6HCC3YIHwHcCj2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:34:53.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ab5f9-e92e-4508-e579-08dc5f932f48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

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
index d77660551f2a..98aa3ce8473f 100644
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
index e692217fcb28..394623abbaa4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2002,6 +2002,21 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
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
@@ -2036,10 +2051,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
@@ -2058,11 +2070,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
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

