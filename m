Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3F45C1A
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185175; cv=fail; b=e45PEuLOdnpoSujew7Tj5aX3WGclSTpsspJokfDj1rUu+uPSSzxqLAVQaxsMMvOBSHbjL8NHttUcS4+6UObR11RhbPzqdlECLPSfJsrtiteMOlYL6R0lq+hk9VTTmMM+tR1uFtPMQ/yXAgG3XbXgczCq7Ax7jTufXuCE+d0MKlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185175; c=relaxed/simple;
	bh=9I7XNET6ZZazC2aMRyZiQLfPsXjmKjd32OJTBedRaXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWjU+MA46/OQlSIgnUr3M/j2Gr2aiBLMynd7VlBTc4HwquyW7FlMOW95dprK2QEMxn3fwOQOJL8+VgJ21xUcIqyl076Pm2Y988PtpmLleJxiD/+F1ZjGyO3hus/G+i1dVkPtsjsvYE4HTuLRGkwQVbZcaxorMlLmFnVQrXRSrTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XKosKq3Z; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XKosKq3Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brQ+ju4YIANj9Uam7B3jFpDWzR83XuD79xwlsnpib7wo/AHHzFqiScR41ItpsN6D8Z0hOUoOPJfbdetjdcxmzGVgAC7JdItAECbl1YXF6t0KriI6knr2j6LMZoe9M2L4MpNk8t7XKqYv3OzDYMm3oU//fee22CsblYLuQs4ixYsInn3a1VqVEEh6C9RmU5x9sYDG0L5Wax/UXwoRJVhvfYUzVXjduTTyNLQ9YhKwwDeWtPErkkX/4Aa2a6kxmK0sWCsh+N9IZvCyK+lT4cV4xbYNhleCPZFnuXM7SEyspgKLziXDTzAzvyesbNg79974YF2BQW7Tr8M+fiR0liJLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6omLlcvpP+PqWJ+vErKcW98R9EMUh8Fb89bVEiw1Tw=;
 b=XuDjsaWWDAofJ8TlntOPv9GY2UsIlRhvs83IqRkEsyCBk+w8Tl3qAGtPfj6Y4SHGwbOIRFsZNICY2GoDA27kXDHY+1/36RxNKLOZ5cjrSA+qpXU4o4D5n6X28u1QIPXUbkLF1TWBJmd0zyKNqjppf50ErgtZTqghZH9KWitBpcomIa/3BkHCauk9IyZOwa/AM03rNu16BPHtq6yTgaMpjpRXb8eEo9W1zH4Zf9cKuGID/+wc8PU67JKNliaZhmAphEORZE46yKnXP8s07o3OqftyAlNEmKR+Xk6Xa3vw8nihCAp3FgzP7U11LED2nPbitNPyIPlXCchkFw3UvuzRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6omLlcvpP+PqWJ+vErKcW98R9EMUh8Fb89bVEiw1Tw=;
 b=XKosKq3Zr6+9tKg2RA5Dcn+tY9sG//aMps5K5MRFhT+jPFOqKoaCD3m7PmeAfJiScK8639sbwpx1KKN5/PM2VhzW48/UHD8DBNk/o8vSGBHs8C0Q6xHWOBJVZni0J+Zn9aYXvxqfVXTjKd41jCmqFjxg5pKygZu7f/JCm0ZjjU4=
Received: from CH0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:610:33::19)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 12:19:31 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::2b) by CH0PR08CA0014.outlook.office365.com
 (2603:10b6:610:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 12:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:19:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:19:25 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 16/17] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Thu, 25 Jan 2024 12:11:34 +0000
Message-ID: <20240125121135.8217-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4e6578-fc33-4667-6c85-08dc1d9fe1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7FBmJztIkuDlq9BGZaQsqktVTnIVBiGisEkaAXDGdCxTRAqIefLSBJKwxxmUDO3989G0f6KzgFLxc8pofLQAA3qtRjYREXdAJHxtZXkXS963PLPNczj4WWZvfrs9XR+RAGkWUgCrnOVmVv2XmtpuyoxfgDSxR4JSxdIrl39TfNLKKfcheK2y02Oy80eRXH18qN5vJ1xgRX4i1fI037nFirwCgG4HvHJ7xVlbZ4KunOeMCmxDmhvvkTtVm9cNiDzxhrrMJ80U7E7EG6lJabH2nEHQ95/A1sX+1sxW3Cxg2J9RSkVOf7Xq0BKOh5cJsod4bSfgQR/oXYYvC3fHOYgVL1HHZVD1JAjgmJQp9eInycLJGIHY9PjpKBUECk5B93UF/bqHl71ZMogziPyXWjnW2InU/h1mhDo7lZY+ESVuW3BJo3iUHtQoxCH2Mx5aVyxvSn6lALtcXRBhI9XNi4zxE0xdGBXVQG4unG0ihiFPelTcMX7mUZ0iNHNslPhc39VXvieXCwE02HoLhEyWWw8rCB8ME7StNF1qOpDlAgozVSSV7GM6efTM3B7ZPSBUaLpMFi/0i5e5GKuUD9lNtynd0b2LUoCi/EKmd7zkNjk86lu2fFXAGPXflQcvYhlCQWfYvmtqXrG1VXXbkYIf074r+SRrt6yJsW8ee9sK2qdwAY6HIJkMrKcZjZWO7dbVKX6ik8qqdr8dVHYxUgYeQtOjF0agcu5fPfKxH1U/9ygIuQhdnneqMEgfUcq6Js+C7UvxSb8sFa0wa0fTjkJ0p/V/xg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(83380400001)(2906002)(44832011)(426003)(336012)(4326008)(5660300002)(356005)(36860700001)(36756003)(47076005)(41300700001)(478600001)(6666004)(26005)(16526019)(81166007)(86362001)(40460700003)(40480700001)(70586007)(2616005)(70206006)(82740400003)(110136005)(1076003)(54906003)(316002)(8936002)(8676002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:19:30.5709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4e6578-fc33-4667-6c85-08dc1d9fe1ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since they are moved to struct iommu_dev_data, and the driver has been
ported to use them.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ------------
 drivers/iommu/amd/iommu.c           |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fead9033796f..79a07a2e4bec 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -453,15 +453,6 @@
 
 #define MAX_DOMAIN_ID 65536
 
-/* Protection domain flags */
-#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
-#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
-					      domain for an IOMMU */
-#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
-					      translation */
-#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
-#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
-
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -571,10 +562,7 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	int glx;		/* Number of levels for GCR3 table */
 	int nid;		/* Node ID */
-	u64 *gcr3_tbl;		/* Guest CR3 table */
-	unsigned long flags;	/* flags to find out type of domain */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3195cfaa1a7e..6cc9ed0b6e87 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,7 +90,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
-	return (pdom && (pdom->flags & PD_IOMMUV2_MASK));
+	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
 static inline int get_acpihid_device_id(struct device *dev,
-- 
2.31.1

