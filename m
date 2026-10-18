Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D62336EDA
	for <iommu@lists.linux.dev>; Sun, 18 Oct 2026 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327338; cv=fail; b=HraapROjNUMbXRyMHcXjgcIg2YnS4Ifsnv2Se4MZfgxZyN23Mwei6N4wlGdQ0ZK+ZbGth+5x3J8Q2R5YN4bGQaPUk91BV6RXq9snAwVrVhnIX25SLgWFcAxnWFDfH0uB5KI8bCfigl676SskWvMb2zatt6qymRf6ZAbdztPsILg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327338; c=relaxed/simple;
	bh=eNB+vWb5yvLmYxZUgPSbgBrkVh10vURDJm1D6RaMa0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DVqT3F7A7NK1U2ll5bGaTbzhWMj/ZkJy9LC37LQiArvleSZXkYKIMmOOG8cszxmpxXJXwvjpadiSTOOheQL80Plr8HRhpcANmEm4lNf1HwZfOwZ7cOqNlyv68hdwDGgA7E0y983qDHsjMY2RM5V8uwJf942tujsAt9iJE9V+f44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OoWYjd0O; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OoWYjd0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoXT7EvRxx8hs/oYT+palu4EYfLGeJFBkEdVFOl/5nwzQn9/+4+Tods7hVJ49T8wGxC8SUY1HyhUawxby7XGRc5KaHFqerInxgQi3svo3r4ZCxtVVSjMp4a1KHrVtB8lUGEix32JtvPyAKWJ0NRXKEBKJ2UrL8xLnM/yz5HNngnDidlGBPRP7jveKsUIr3jrpIWO5cc/TBWpq3lis/W7KL7vgH2GD+e1erfrcOAdeQA2Yz+m7KoPEAp1NwC5nVBgim67Fk/CGQcK91RsQGl46l2ejne+uXTctr5Htlk0e77RyfOfN9axOpij3OlYPUftoNtvq0zUoErBmLUHYpN73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcHLQQxiYmJr15qpDaHYdvUKAsRrEqwXMPDUiIlWB/w=;
 b=mLlE62pmYd0WOI9KxIr6ALl9zAtNa4v9fZF9gk+SgLrtGpAIGoiD+U7wEBZ9r1+SYmCS07pr+qYG00bAg9fw5G0wqIM9NMYRYg8zHDEu2kWIWkz7osN9pbfhbEyyvJPnu9ZQXUvMFH7sBirwgIFskNQNNmUstlW1JY2exHzoiblQsEGJc6FqoFbV2HE9NfUsZIMxj8QAd2n7Sl48KBJYSm6+FASvkPGf6fFUdsjd1Ls+TBrJ/qyPr0hFPId0ck0qSkHAUae61F1TmrcsV5lRHhzLzBom5hlwp5IE5lL5vFHaQrmec3IScXVxsl4dFlslu2rg5QCcD/siEwWjh0HQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcHLQQxiYmJr15qpDaHYdvUKAsRrEqwXMPDUiIlWB/w=;
 b=OoWYjd0OQCS+cBmFOkTO4Gp8nL0bK4HWh4ZgoukRPW2UMPBwmudGsK9FoLhw42VX5AstwFenPBDe5EG7ooHjryARW8TqvCNvSqaIHjLoZTyntJsI0d/N28Pk+9hshSn5qhKnnX3kC8TGDNFLb4V3my8Q3I2ShwMwa7Aivyzpwl4=
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 12:41:39 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::3c) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Sun, 18
 Oct 2026 12:41:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 18 Oct 2026 12:41:38 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 07:41:28 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: [PATCH] iommu/amd: Enhance "Command buffer timeout" error message
Date: Sun, 18 Oct 2026 18:11:13 +0530
Message-ID: <20261018124113.910-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3bd34d-c0c4-492e-9bad-08df2d15277c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	upd6kGAmxFovaSY/9fQ1VWDbszFZB0NUbuXr4/L6ckdKAWOkZFKmB7h1OQZnuKWi0d7P6VEULN3ybYflpskVNThAACzTG/lMBEMHoRT3mLffKLUzSHDqBvpjYsxaT1zPb/A58UVuYBGm1/78jdMMSU0HbjabvCbRiItFI6+q1IuC0ifL7W3yTH+W+RADwMMkgYvjzkqR/KNKzfe9rroK3k9u+KoI8DYCtrHd7mPnL6OkHQFcWLxoiyw0ghBBqM5TJDd3v6znGf8O34X1O+7AbjzqKmVXlbWW1QCA2Vii5zJwph1kinyAswwQJKcxSeXYvEOxv4d1x+MZQg6k/PL39CbwchwCoFNqCZpAdXb4DQYNF0qovJS2bZvFxL5FT5LdUUkrwlVbszywsruSXsHfnbJjU0ZvYht7hxQ9QKHBu/5DUdZIA4gdevzYbcjJZQ4fYCYfRHGukAvYcJ52iT/ZNdXov74K74o6+N/bXfM96mgMl6m/HNAIegm0e/K5YDHRTpbXOD1RfQyQOilzg8Uh5v6CFLN92OxrLkfsjZSRSqDoJg7gMOIw5Gms0+xbMyj59rMzBPrC3766wctex3wbz2s1Ts+RvHAGLZbMC+6oUyFmic/VxZvauf4kJ2lQi7z965yGAaUn6FWvVTBTHBJ+Vm2JuGD5AcgsI8YZBMJhjWNklDBUm+sMbKh6PtqIzC4WHqHJjnO89p3vQS12G23xvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l2ALqHsV+HP/hzqw2BsdEg/RbU35F/Tvq41uJKLMH2/uOyk4mSfk+n5QOHWmekNCW+wsX93kkUS629I99PUlyGuGP5pUMi61dE5PMIfbg1Mw7NEngF6VgnJNAjbvgeZPFNrmqPcXGi6YyBfNKTf9EdRKymXsav84IxwyfcJdZaM9F2/cYX5YGvHBIJQ7r75E3mmrVflRJwoNUTf43wus6hSZl95yHNxQ81FKSv9cjbDZFQvJX0ftBbmtcuxkSbIgX6qCUiOMQ3f/VgWJsT38AcSZlNsIP3/6s1SuaZvQyEAKoPx0vS61F/ycpjpEKyFCAoOGyME+1N+rxnGHksN3b4G3Em3vPD/gFP8XpYa9TlM/3YCyyjRvtRHaSzL6OMP/fUXx7BsaJcpmbmgvYL3p/cvoqDgfw28HSKHG4waDn8CET+2GEy1UEjSdgeKaIy3o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 12:41:38.9396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3bd34d-c0c4-492e-9bad-08df2d15277c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

Current IOMMU driver prints "Command buffer timeout" error message with
insufficient information to further debug the issue.

Enhance the error message as follows:
1. Log the IOMMU PCI device ID in the error message.
2. With the "amd_iommu_dump=1" kernel command line option, dump the
   entire command buffer entries, including the Head and Tail offsets.

Consolidate the timeout logging and the command buffer dump into a
single helper and use DO_ONCE_LITE() to dump the command buffer only
once to avoid dmesg spam. While at it, apply the same reporting to the
completion-wait timeout path as well.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 893cd2be11a2..e75b3f6123e6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1228,6 +1228,16 @@ static void dump_command_buffer(struct amd_iommu *iommu)
 	}
 }
 
+static void report_command_buffer_timeout(struct amd_iommu *iommu, const char *reason)
+{
+	pr_err_ratelimited("IOMMU %04x:%02x:%02x.%01x: %s\n",
+			   iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			   PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid), reason);
+
+	if (amd_iommu_dump)
+		DO_ONCE_LITE(dump_command_buffer, iommu);
+}
+
 static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
 	int i = 0;
@@ -1243,14 +1253,7 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-
-		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
-			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
-			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
-
-		if (amd_iommu_dump)
-			DO_ONCE_LITE(dump_command_buffer, iommu);
-
+		report_command_buffer_timeout(iommu, "Completion-Wait loop timed out");
 		return -EIO;
 	}
 
@@ -1422,7 +1425,7 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 		/* Skip udelay() the first time around */
 		if (count++) {
 			if (count == LOOP_TIMEOUT) {
-				pr_err("Command buffer timeout\n");
+				report_command_buffer_timeout(iommu, "Command buffer timeout");
 				return -EIO;
 			}
 
-- 
2.25.1

