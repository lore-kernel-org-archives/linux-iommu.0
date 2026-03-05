Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131C288B8
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691530; cv=fail; b=SZbihX7HMWBWs0IoU7q9DA0zO3rbNlPAdjmgwDFwMYvUB6f0oTBm7llGdpdJxlKppio7gF+HMsc+6TimPtjLiWH9iEm0pexRB7h4a8FKjwehwb3sdJf+XnKsI0n4s4gfXQQWylu6xn/2O5hi5eX5TWD3tt7yDVDn9cOlxfkJYgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691530; c=relaxed/simple;
	bh=m7TA+l59X90dLr9NriVpN7jKUwgtRRDeFcCVGFM+4Mw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O2Rr4EQcY8tA3zQ/AsaxMpSB5qmNUJfUxzW4aw4xLYr+2VdnnB+TJPwimE924An959z45wmPW5UDrhoDDzDzm/ju/K1e8raOFaZbCS6mtjAZvL+Aybx2mtGM5NcloTUhQ5SPXQ2Zh+N5wnH6E/d6vX3/YTCwKQJzs0MOpZSAxu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xVf4M/TE; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xVf4M/TE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8dxTVyGnqMlWgG1LFnZoBvvuH3/g0+t9OLn/hEd4sHs/c7SitBfl6NNVXvx85nGHtAvzKRzHkpgCeLSGtZK5Bca///9aRsuCGphM0fcRUcx6N9GfdQL/M8gYHDZru0CcNo4FfrE8LSdq43uzPfdVSaTVAYsKqGFD5UsZ45nJt4RdKCN6VjlaMKPrwp0oXw+DP3MXklHFCEyvNrT7r/4oVN+YMVei0CxAhtouhW6EacPLGSB1qZlFWhZSBMd+w4/jvYQ1gIShzsOBLcMz2CI2gcL3lodADeSWD0/VK8e5iJVhmsdAvF6yLlSU/ZBYXy/jEON82Csrpg3DTFiC02JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN+/i7EBGafHdItHc+IxDljWqprR9IFOQGIwEpWQIpA=;
 b=fDShnTzAM09+QlBF1VOngiwkMBoxmWnIM8RyI+5UbP3dPlSMW1noKOqM/rw5dirHBJKgQZHGDKK54Wrkt0VRJDpMFrAKUpnaGDSaxFvfTUudRuJ8vrBx51gY0X4LU1ueShBaOdiBk1O1QKdQ4ayjLdg2771BQhn2s/du8tv8t17GatZQBsOXtPuKp8nJx0Yx+TjcrcvT7a8lxeF8Bbgd1xTnsbMZ01fzR9FEYzmKLbESjlCJgzJ+3aRHi2t5KOpvT82Z+BL8xqwft6KzuWjC/+blQZ0OZLEDLPvI41JKwXxv37V8vWAENUCDdGT0MDmSMKLT3ps27meqYNbW4fYEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN+/i7EBGafHdItHc+IxDljWqprR9IFOQGIwEpWQIpA=;
 b=xVf4M/TEkcgF+e1zqnjPC+Vv4WGsbGxL53xIAKZJeieRQ0neoQIgVE9W2Gzxbykl8ZT8kiOLQ3nh9X/sXcjj+kevU7Z3w9Fj1/u8Ooo80Ak/XKmJP2oErZLlIO4QPelHVPPQo6ko3RCHqhXz4u9yhSDAl8nQccORK10cVxQVTw8=
Received: from SA9PR13CA0080.namprd13.prod.outlook.com (2603:10b6:806:23::25)
 by EAYPR12MB999157.namprd12.prod.outlook.com (2603:10b6:303:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 06:18:45 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::f8) by SA9PR13CA0080.outlook.office365.com
 (2603:10b6:806:23::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Thu,
 5 Mar 2026 06:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 06:18:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 00:18:44 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 5 Mar 2026 00:18:43 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<yi.l.liu@intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<vasant.hegde@amd.com>
Subject: [PATCH V2] iommu/sva: Fix crash in iommu_sva_unbind_device()
Date: Wed, 4 Mar 2026 22:18:42 -0800
Message-ID: <20260305061842.3953885-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|EAYPR12MB999157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1661157f-81b9-4867-1bfd-08de7a7f0e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	5T6d15iOnUNd8abRN+68pF46RwaJsAJLmKSbt+BB3UGnzyNbkihU1Boj54UkpoIpvSSzsazWnRSn23G4pYYtJ2tW0+XYaJzjvwRFhw1C774EMDSzp3OmiS4OdL4LoK5MailjlNRamsddOxlY0M0VzZxyq5P0EbZKtiHJ+2YJHd9bsYwceyTleIs4c1jRYmClxb/ebGXZlxKHYrJKESdMntau8THCefPRQQjf/lEFguyrizJ9ViGhd9iAXyTsRpgwCK6J4kagqal1vdf7iNBrp1ikWj9wUpOPRHcMVA9kvR84aqL2PEVJMPSAFjPA+TTi/x/jPTvVjtOnySQMNvFsViAtIAZgbw3LhSnaZXLjvuQQOP18GrVXbhoKv1ViJytYXUm+AOLnh4sPamGutoECuROVWVtZkcmocMGSAg7Vsk93MgW/eP79DPI6BqJEOTuSEeA7pi+5wjCS+/DQ3IQofKNGIu2wtokVELHkzZ+2nPZcYJHaeRNViKHjGEHAC87v6XztZj9f0z385SSePg3E6QWOWY4Osv8fxuhx7Y9GfslYhH6yT245n46vipvl5NJ/I5muC+sJohO9xjw5wapLYJC9cdZc6viqxgpfWwD/Gc24/8q0idlfzyUptB0ktiLmbkcQplQ9RS0d6S9l1ypvQAVvLsOm3aBGGorjFug21iYoOFf4zxnK2yjtp8lc6FVmv/WENJO2dfif1pKzKJChY2PX+hBJHVmEZG4kI3zNGRaWKhydVNO8EvYAijG7r/uBvEww1pzBac2CGz3R3OGieQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Kgql3tl0N4KL+RNPm9IaV/OdReDrCLVr2xa0sWVuo/8sQhK+9lxIVRBzmmrAWrdy3dM9iNdiBEidS2kG0/8muhHDHmXaqqqYwq/6w0vYbjoYqXGZ95ugJiu8m+7+pSeQnwrcCGBDuSXTVSrwC24RiTaIxj0GCJbb9p08P/bqKtGhbC4NTZF44cMpnY++/xwCwJXRdwyL/JsD695C9qAyZ0splRq2hVjopciJBFKmd6PBTJp2GlBU8OB+75MFYkYaBHH3OcQ8eb6RrehtcQvv7ZvkCtWpcMXO3AGxyDxQ2WaANW9CCw7uxCkqwBuR9C4Lopo0qY+0sZxUEVzxEd6jFStN2v/k2LMTQdLAQ/XzZ2THFrzDkQeJhF/Qy+liqMfYhOKDrAFKOLsjz6oXxhv2w91hWcgfhOl1zGkhYS+KESSAgsqlqHrd3mF52zK7Bk4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 06:18:44.9281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661157f-81b9-4867-1bfd-08de7a7f0e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999157

domain->mm->iommu_mm can be freed by iommu_domain_free():
  iommu_domain_free()
    mmdrop()
      __mmdrop()
        mm_pasid_drop()
After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
dereference a freed mm structure, leading to a crash.

Fix this by moving the code that accesses domain->mm->iommu_mm to before
the call to iommu_domain_free().

Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/iommu/iommu-sva.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 07d64908a05f..bc7c7232a43e 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -182,13 +182,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
 		list_del(&domain->next);
-		iommu_domain_free(domain);
-	}
+		if (list_empty(&iommu_mm->sva_domains)) {
+			list_del(&iommu_mm->mm_list_elm);
+			if (list_empty(&iommu_sva_mms))
+				iommu_sva_present = false;
+		}
 
-	if (list_empty(&iommu_mm->sva_domains)) {
-		list_del(&iommu_mm->mm_list_elm);
-		if (list_empty(&iommu_sva_mms))
-			iommu_sva_present = false;
+		iommu_domain_free(domain);
 	}
 
 	mutex_unlock(&iommu_sva_lock);
-- 
2.34.1

