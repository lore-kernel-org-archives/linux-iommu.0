Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852711;
	b=ws+koSYbypOH3Ln0FAzDirbw7hrTtr2WwxJ5ZNy3/9e1iiwzhKgE5eOUFfYoRyfCiSrJ
	 QWVQE6q+L6HTdn/2waSXc2u7CoJM3scnViSBcd2ZYwOLznCn9HaYqpytMX0awwbIculCn
	 IQx49m4vvJRebGUmnyQHrcrbJKKcfi/gairaI7TXLRFcXX8X/6iDuXyquTwW9Gbdx79V+
	 30Qo98pCyZzLlQeSdSvnYdpdeVjb9R8szO3e4rVKXi4v2K0ma82BrkYrOy8Ws35JOSEUz
	 Gi3X2EvWHE1R0ewBO+eBVfrnJoQw1869EWnADF4D3Aw7vTAu0Lv51m5NZcFFDNGFKwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852711;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DJUwy50vwYVCg0ZhvktdK+jNk4dBz5deRKRjzpeT75A=;
	b=eh/MXhGdwFOfZ+kCD6WHVviSAK8fGwNUe7rfipoJQLfpv8vjdYQhbjZ4SBaqjhdS/Fga
	 MppyFoebTE2UX3A4bGF6r78s3NEgl9NFVDKb+6pep3JfzaHB2yvIoF4Ar06XLht2xNYY9
	 +ZusiYqv9ogkEszx/V/lqRt8LA1pv2Mmn8ZTrSUi7uGN2rliNvyp5X0EzBZynsNnIwV7o
	 kPUstARBMzHBhEFaMyjvtYiVrk+FN7FvwHkaseA3d78fO9xRYXdeSOikjkEbjHu/OxQCU
	 mExvxTVAHFtMviiigYsXfcDPaJNwvKhonpNxXJ8lTDuZHo/0/iKKqcSumKNj8iISPgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SpVFgc5j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCED606A329
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DCED606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SpVFgc5j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEQjXRueGZ3Ey6HTmxUG0x/Q176DkdH943Q3iQp0k1tsIMcQX4KNG/AoqnYW9TABPC0Uu3w4obo63wFQ+cOlWw602C78OsBbVb/sZ7lVvNt0OPUaWNF5uOeZFyDrIdrrhf9dYbtkSRR6emNEHUeXEA3nm1OyyRjk17C40wcLQj30MH0jPqCwsADmWIcDOA2+H1BlKVKc1dKVbbudA8y++GSptthvJl/Ikz08TIFfQpwtBt1Y2F4O8675Y7cCrRaRovlysMq92onUHdDdWRsADka8DjZ5PWwu4xpwFpS3ZGsxSENd3M30JXVP/hrjkAF0seYMBQoosQ0N//8At2tI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJUwy50vwYVCg0ZhvktdK+jNk4dBz5deRKRjzpeT75A=;
 b=wn+rtntuVujI109h/c2nwcFOlVbBdRM4G4qnnTrRG/umf+QAwHhs7iO5dWQNFao+fJDZ+/atU3V0IGS/t7XoUj09+ChXthPQy0HFym8adLXaTKRq2etGeyz3HIJ3Cw+LkNaGQrflE/radCfKOY4x/W8Nem9z8fllVCODbgoOKUuQwheWtjps5HWoS6AGbDrMIsyeRPv5NRQO58xQ/FtvhYfdZ08BqMjIMYkEBImAIDSpa/Ci+/gPlkVWq6B51qK1FRp+4J8TMWE1wpbJCxWGnhSIrR+f0EH8T+iMcKLHtEpcYLSy7ooE7p6ZeYYHk9XOfFUd62cOGfN9mq7KhhNdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJUwy50vwYVCg0ZhvktdK+jNk4dBz5deRKRjzpeT75A=;
 b=SpVFgc5jOFmct1IC2XtO+PESuJF2h6AI5UZHfg0FxFspGBy84C91EUJPv6Fm/utE1CYQ96a3APJtXpwq5K9bBf1LkPR7nu8go/AspZN7/mLhZ3XhdPe1C/k3p/Yd60if19eVkPbjTh/Pv3DLHAtph+vqVBkgZeK74vZ6WQgmd1Q=
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by CH1PPFDAD84AB72.namprd12.prod.outlook.com (2603:10b6:61f:fc00::627) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:25:06 +0000
Received: from MW3PEPF00001652.namprd21.prod.outlook.com
 (2603:10b6:510:23c:cafe::3b) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:25:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001652.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 04:25:05 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:25:02 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 7/7] iommu/amd: Write the DTE under the domain lock on attach and detach
Date: Thu, 5 Nov 2026 04:22:54 +0000
Message-ID: <20261105042254.399163-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001652:EE_|CH1PPFDAD84AB72:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a9be85-13ec-47a9-eab7-08df3af4c49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|11063799006|261021123027099003|261102123227099003|261021121427099003|261009223027099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HQ07CqLNcW8W4nBFR3exMzLngaKazk77eFw6Z6bWyAt8o1m+F+u6aW9w9TlglPjovBCu5NVL0yXSf34zI/9V1nHiSm5EBBUcBEzee0LXCazPJ77f9xPiFd/J7nCGlaKXnptULydmofyjKWLTALkndJxGIwdCSaZHAh8SUi5SyPHgpwI+w6NUKghxd5y9JKrW1uC899LxCmGKD1AQSTi66bD5GP7kzZHuU7PkTPJ998tHrKqN7Em9YU0gJ47kBMf+H4tmqE58Yk5O7vJxiTzEr/NYNm7sBvhfr+SAQ0vshQ1kfYoGrPZwO8oKpjhP0bK11GRC0GTaX0pimRoYLH9VE0kf5fL2y4GRPwx8lCdOXnXUSsWceWCcWZNMCG9QPs1dWbpfDJWIZQov9D7KRC/6Y7tXjWD8k8/MoaJ4ZZ4FRUENGp04DTXVi9rpba/rS5BQI6BnNef04b369tlgzkDuBbUkbh6a+7WBwaFO/b90TlxKoZIPjbtx3d6zHx+ercP+krr6tTWUNlynWJV6l3hHDnw9dOnZP6ogxaJylZXOAwrzm9aG7zQU4Ig9g80j/dMmJlcOLjxgLuoxNYvsE8n+5qr0DuaYYcxQ6xj4rv9gQ5Gpnn0LqV/tb4K+DTSQOdSeKp1mrBYvnH4125/B2jmnSagY7EQdmZHixBuV5lWgItD8ztBFUz/Lk2Bgu1/fnAWRSD9HGeF5hTtHHCfWZiJBNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XFA6aatGaoqwHbP1iQNSa6WAlcrsf+NOkm0O4jqULmKTx1fVvcFm5Ku6UUJp3MSwYZNmmazcygKVBEdchX4PP/BA+9YWch138CbRZJ0txdcokt//ZLygeAhuKTvHDB+ENhEgz9Nx/0pacWns7ER6FWacvgqP7/ZifB28o2rScTKMDy6Hu4gxwkglNjxazaD6bnxk4FfwsHWWlU+Ie+IQNh4WsRjIc2JQnyv/ZhFNsmlAA+C+h0Ff1QAju6UB9VrJr2MVgw8i4HOWFqF3aqqGh8mmMkWBajSFDVvIG5YXwp7lzEzHxYa18G/qKD85QPZH+EyPFdnjN1HCHryXJ2W4D3O7BEa8k1viRhrpoG7Q/ko3kWLMNf/TThodX26jNO9K1IU9xWZatFwdHxRGlVevq8gD1NPwbTK7QcErdVYY/2cmhU3YyocN9gvZE/ahOe8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:25:05.3649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a9be85-13ec-47a9-eab7-08df3af4c49d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001652.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDAD84AB72

amd_iommu_change_top() and amd_iommu_set_dirty_tracking() rewrite the DTE
of every device on the domain's dev_list while holding the domain lock.
attach_device() adds the device to dev_list under that lock, but builds
and writes its DTE after dropping it.

On concurrent update it's possible that it may end up writing old top or
losing HAD bits.

detach_device() has the mirror problem: it clears the DTE before taking
the domain lock, so a concurrent change_top() can make the DTE valid
again before the device is removed from dev_list.

Hold the domain lock across both the dev_list update and the DTE write,
in both the attach and detach paths. This follows the existing
pdom->lock -> dte_lock -> iommu->lock ordering already used by
change_top().

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ff5b6abd6503..2ec0a598d829 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2396,14 +2396,16 @@ static int attach_device(struct device *dev,
 	}
 
 skip_caps:
-	/* Update data structures */
-	dev_data->domain = domain;
+	/*
+	 * Build and write the DTE under the domain lock so a concurrent
+	 * change_top() or dirty tracking update cannot be overwritten with
+	 * stale values.
+	 */
 	spin_lock_irqsave(&domain->lock, flags);
+	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	/* Update device table */
 	dev_update_dte(dev_data, true);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 out:
 	mutex_unlock(&dev_data->mutex);
@@ -2441,11 +2443,12 @@ static void detach_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pdev_disable_caps(to_pci_dev(dev));
 
+	spin_lock_irqsave(&domain->lock, flags);
+
 	/* Clear DTE and flush the entry */
 	dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
-	spin_lock_irqsave(&domain->lock, flags);
 	amd_iommu_domain_flush_all(domain);
 	list_del(&dev_data->list);
 	spin_unlock_irqrestore(&domain->lock, flags);
-- 
2.31.1

