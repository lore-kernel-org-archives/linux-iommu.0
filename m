Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A31CF96
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184775; cv=fail; b=p7rHg430fMiFyFcvYOi7J+oge6FSosWdhZEUPlgEeGnBydp3YBY6ibNwxfMba6tdUM7x+ML93Bo7HllXC7bZbo94B1cqkbxnBQTKBWma8sMhykX1ZTwWq6FgxIdq/BbaqfN/KKWQJYb1Gv2oukAXiGNkCOGndhkbvfn9P4cKkeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184775; c=relaxed/simple;
	bh=xLWaRqF8tNoXYMwwK63UsV9AE5F8YUw2qgPNhf3x1mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJQ3d3yM/f9yuIQ+bFRRXvFkeZZrYPlNts8DkMJMUESc4M5/kU2CTYzlgqjl2TNmgxau3NNejsnJG0r2zFdo1+facadA0WMDu8mhqhMKr2ySA6C1EVYWUO5vKVyg2lHjnUeMmI6F/aCKA7XK46ErlHZHrt7jdhYrCSlMJ3khbUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OU8waZKf; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OU8waZKf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQeP2xj/A/GszS7G+4eqE2qsWWtF+lY1iUyUspe5bX3ytgIPxgdYoPN+8tBtcbVI19QwcdP2WXRLpHFJS6FoSUls1xvxpt2vesix4J0AHkoGgntvqQL9JW9BKH6kRAZbTY1ei9J7AKl1Gv4iew9MCWGhOHHYb2PpJy3kScy69K5f005uX0+F1YV2KPL4HdLs1aAVGhpOrJuc9npnGNIpAtTTym27/w3pjEK8Rg7GkjIdhS1nHamVRNlJdXTFhF7DCn7cLTVKd92eL+uinnvHb5bFLWe4+JCKP4f7ZtRCgFzrE5ckjN/2tE6tOxsFQBigVlypYWBFrYjU8NbLypm3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwDmghVlyHIKu/eWWKs4hLQTV4glN001WB68N6U1S2Y=;
 b=M09YcKZcYGhXAZgRLhtVarbr1uR1NaEdK4OdgypVpjaAmsoy7A+6sKnbqbCraCeOAT5CI0gQGtdLmJtqjPzPeLCcQRj/dsY6kIzU9pWPvfKgcwn5VOV/YnIZMEppgmT9OMIknQ80V8l48+AwsjwspiNWzejYLRsUY+9Q69t08zVDL7Ox8eNSg2W3DosJzRAJIqwQdN7VGP7nfja/OeWhX4YejvKCcupsOFVlppYXK0dfdJGRoKt7g4T6Ywcl5FT1biHEQIOadT+t9V6EJeGV76eeQpdC9McdK9AzOfZJF0z0TETjwNnIpn4u3X1vM2iY3wK1CKcKiZrTzI2lxmq3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwDmghVlyHIKu/eWWKs4hLQTV4glN001WB68N6U1S2Y=;
 b=OU8waZKfOId22pHM9B9PlLrgXFKnIpb1wCdT+Ud0ayXoxjzu4WU/iMca1gUz7eP901vw/yG+UDD/YFHnyp/L/77KtTzGWwcvJLzfsC98A/9abjffYi2pG7nUL2X7XX+8bd3LP82EHgYAgMq62KZudP6DGZJOZiyHWxcM/YKHPcE=
Received: from SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:12:51 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::18) by SA0PR12CA0030.outlook.office365.com
 (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 12:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:12:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:12:45 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 01/17] iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
Date: Thu, 25 Jan 2024 12:11:19 +0000
Message-ID: <20240125121135.8217-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7a72e7-b5da-486c-bf87-08dc1d9ef40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e4m9TL8OoPPIA3btBV9Dfk9KSt/+jAw8oUMEFI9fzgsaVMaEEj1EV9p95hmO03NNug5mWIYi0DVjx7CZaYPH+HOM5DvShRka3ynv025bhBTlh5W14inJw87JOGhR13tDe62LFkDWEuHXvnol/r6pyriXpKxJfiYG6hR+GsmuxPIJ8PlP2yxtYvSs3zHaba8pKeSuGoHICrczHZYodIaKYRwRynPS456tWGBmTpUxu+ioXq32YM6FU2J7/E6daYVycNJyc5X6Yh/p7x2HriJmbeD3L1aqiYn3ffViZBMx3gmi8o1A5878S84N3XA1sKPyIEJB7bRGA68GsDqZayciRYeAfFYPI6TvjJHzLj5R1dLbbGtAzNDpmgF8iVBdv/xxYQ/gwdOAGQObfpkErswoXYpSGh9eapQjPc7pBh3LAp0FQOGmWpuyNAjsBJsqeZIqbZtz3CgfotXZe+e5bUdHB0N90URRj1GFDRxjFHPGHUJCQ3CZuibl8D1ki4SIimUuakTDrO3UUHts2EJaa+/7eTy55tdM26mJeAVMxTH+DApwwt89KJL46698QSqTUWm53fsLpLSsZ0/0ipZqYDld26qmEFfDiRUhESpmUb2x9jqGr+/ksb+L2neSpdItU9bLiptwuERDrr/Idm6q64mASQlUGd45e+NUcjVu37NDP/XzGQfx9EJiMBb/62FQASvQd+NDFMqDEY4+BKTzFASgWugMPI0a8G9tLKJrciKBMNXzELRvTQcsfy21NwpdOirsVf+MUytyjlW7M/KnqrD3eg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(41300700001)(44832011)(47076005)(81166007)(2616005)(36860700001)(82740400003)(16526019)(426003)(26005)(356005)(4326008)(1076003)(8936002)(5660300002)(8676002)(2906002)(478600001)(316002)(7696005)(54906003)(6666004)(70206006)(70586007)(110136005)(36756003)(336012)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:12:51.4654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a72e7-b5da-486c-bf87-08dc1d9ef40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019

Pass iommu_dev_data structure instead of passing indivisual variables.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 92d6596bdfff..77612142f436 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1704,12 +1704,14 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
-static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	u16 devid = dev_data->devid;
+	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
@@ -1729,10 +1731,10 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	flags = dev_table[devid].data[1];
 
-	if (ats)
+	if (dev_data->ats_enabled)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr)
+	if (dev_data->ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
@@ -1808,12 +1810,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
-	bool ats;
 
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1828,8 +1828,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2013,8 +2012,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
-- 
2.31.1

