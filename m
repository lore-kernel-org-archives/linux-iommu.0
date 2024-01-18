Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3D1CFB7
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568700; cv=fail; b=NBzofKNTSZEMhsYuubSYihfCZw1MRE8muZNI5hWdSzEdZDE4xLgMrEWjK5yuw2qmTZLQAuT9ykFO2BlGQXyMUYzjnciOrAOb1h53ujQe0BiUjbxIzlWXGQI//LzrkFTcI6iz4olT50iq+s4vhaNXfi0JUVm9iRqBdFmmpeUgKlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568700; c=relaxed/simple;
	bh=Q/opYxugDJiDwIrUKjjpdZBdGzzkOPgVkMTkPNeacT0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=RHnuyPtp5K0qzpWHxzYpg85NQ9xwlqxlA57dbmKXxMEc+paqiP1usQFGkIlV5hRqG+GSvu8gFgB0iHqHjSY+BSMONHCL64y02Q564uLIFKM9AP05f4hWArOLPrn0CnHmRE5oB35BaPHofh8zPZ3Pmgeqw5ck2tA2PWRTWaet8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5N9qiz13; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5N9qiz13"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7nr8CEWS9NePkEwOxHR+WfNpuEHxv/JDpQ14GJUUlJDJ7w8bqjtu92qusRWn8tJs9yd5/R1QqbHXFqRhCwGr9YRweA5dqXY8H0QUGy7jS6gqmlmZ5elQh8KmCEoxqlkviL4U++JbKA7BUlXRgsgFG0LkklXqCXhORtAx4pOGCQanC7g+So/ZWKgLSZYQoyDbt18ZDQNCn8dCZYBx96DyKCXMEfiH2LmvR24BKCvZGUuUt7w5TDMVPXB+Eh1SsY1d3RHo+PrHOJZ87y0EcXbREhbmGUCXf7gMupyLdluXYgQfatsWX8mVr2N70jBdH+AylhNZ1/IUmzAtvO7RvrjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXt6Q1wtHfjy8BRE7TS0OLPUPvhxbbTNUIrUC4BFvBg=;
 b=blrvcQcgg2elnWbHGUG7iPOcPq8bwjqVHOIZar0UrUNvaDYJo/A8P2rXyAyA4cHAckjx9g9rwBSJFTSch8AtYC3YwLzeltRUvC7o91KfgIeK4EVgdJhHi69+PyO2kZEQXM8trnag0+CxKg2Y3iNdsjZozDJJhNKQabD5giJDdC3kYh82QWNormtVe24K16lIyy+QH40D53zZJaDTVZwZ/adCDugU3fi7tINAgE5CPXZ3ZH8eDPtu9kHbJ+dg0CKWZvGrppEUkNCHRMFiTKM9kT8zm8C4JcZya0A1BND53X0PlkIuzhu2DVWgt1FbXTYHxcT7pKcbc1X9B+Vy1lySxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXt6Q1wtHfjy8BRE7TS0OLPUPvhxbbTNUIrUC4BFvBg=;
 b=5N9qiz13zQbDzW+ms2FKYcZP9E+KIcsMVhZESpiGC1CJJWm6UkvP+6GPPG/ypX3YvO9+C5e4zdGr+37DWdnf7cI/WGfOWyT/enCjwW1PP2UYGXlTdHZx1bnK/iajEnL+lr4bB06CONYYUVnB2mapZPSq4wZv6XIB97AIrXB6XK8=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Thu, 18 Jan
 2024 09:04:56 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::ee) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:04:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:04:12 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 6/6] iommu/amd: Remove EXPORT_SYMBOL for perf counter related functions
Date: Thu, 18 Jan 2024 09:01:05 +0000
Message-ID: <20240118090105.5864-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 343837f9-f185-4f53-219b-08dc18048a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l3gdAW0e5BWDOeOdJtwOuuDlI3Fdvf/c2Rzyr/8TLxgGrfNxGXAePRAN5YWXGt0X46j1C0a7E1irGCM4Yod/Q588X9PNqgUUR1yykey9DpSbwP4flS/pxwAAeeSf7AnnVtDHCUcM8Oea81McUQVI6s6HlnnfadMBe6naIDRyOAeupax8HDle3O6bK0wRtTcDFNhd09k4PyfHY/UdaTjz1feQvxhGcSNmf1vulWS3+mGhf1SNXwVibUbsLqFiTYrKj8ia0qEEyH/yK0flfePNulI3Imw5rJ/htZU/kuF/2G8VB+Z6UBEc/seyX5KWFrAtfkVbnzzQgW6NjHr2ybSfAZLboHTKoAyvR7muMfHzSt0OA1c92UiazYOKC21IOYnG5Kt+WLP1iP7jbh6HkRJCUW4AtwVbifUwQbs50wPB32H/NA6adcFmhPwb1M+4GHelf7jUKW+Nv4HhavLK7eb71soYWipHnzKodNKT4gUUMZKqjK7aPcIQLpz10mMd2MjgbfEHxUzsAl3xGOoKjtYSxocyC81RYNXmejpL8+6oHDZFMnsAox0s7JBAIPWGFnwu0933k4aX7J6N0AQgozr69R2FY2a7MIQIB3am5/40tWkDyGtkevcXcJBoZxRfYx+oi8y2hMmKndYrlbgIJK7BIZ9RM1RfSgexawzu5jQ897SXxBn1GsZnJzlpyf/lxWsJkYr8FTbfP0XQk42okSSDjvtZ6p5dET8F1LFrEgsg+kpuSGymdYh4T8KRrEO4s45o9f1BiecgEbFii+ihAhkzwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(41300700001)(82740400003)(1076003)(47076005)(336012)(83380400001)(2616005)(426003)(4744005)(26005)(356005)(81166007)(36860700001)(110136005)(8676002)(8936002)(7696005)(6666004)(54906003)(4326008)(44832011)(5660300002)(478600001)(2906002)(70206006)(316002)(70586007)(16526019)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:04:55.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343837f9-f185-4f53-219b-08dc18048a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253

.. as IOMMU perf counters are always built as part of kernel.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 426db9ea3718..2b64cb08f795 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3653,13 +3653,11 @@ u8 amd_iommu_pc_get_max_banks(unsigned int idx)
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_max_banks);
 
 bool amd_iommu_pc_supported(void)
 {
 	return amd_iommu_pc_present;
 }
-EXPORT_SYMBOL(amd_iommu_pc_supported);
 
 u8 amd_iommu_pc_get_max_counters(unsigned int idx)
 {
@@ -3670,7 +3668,6 @@ u8 amd_iommu_pc_get_max_counters(unsigned int idx)
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
 
 static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 				u8 fxn, u64 *value, bool is_write)
-- 
2.31.1

