Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780005;
	b=ew7dRafp/itiud2vynaN2YNJ4SjL/IY7wggLCI4xb9FNVrwRiAmd4BkDUB4H23qyFyPr
	 eyqNWsaM5gV3nsl0vlg3Op76O6fY6VsgOg0dz8199KlcksoJE7axjoKGz9Mcglr2fXNQC
	 EJrprO47wq9mWJD1Ky4eKWy1dGn0+hl5QOFcmgpG9N12WO91D2ZGYHGljVODPTGmNlKle
	 NjFc1VnjyjOVUWSm7aBLLzfArhctluDtP99VMgLwIeQ1RNo6EiqZKhWv67cMFKI54atVj
	 xOpB74lWt3W/08DmHcZq6nh+9tshdrF+iykkFLRGotug6txP7YykA8nJ1bIhSpSd5YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780005;
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
	bh=lq+9D4FpU8Asrq/k7/8cK98lBexBRjHLhaRDTbKhagk=;
	b=vG/RsV85bOG3etsutfcRuHltuAdYs/xReUMA/ujMCwmpUR/ic3YPdAvCQjrz3U1bPh6o
	 8h+zcAEYX/x+UnF8j79w9CNde+jkvDjDtOAX6/9S2LzxNPmH+KjEvLOduA88F9p5PhI/i
	 W/BffT4OZ8FHD5Wdh07dydmTmbj1U4OSrmWSOckHDq7n+bmBejc76fCtkcQscPaTUKVC6
	 fLtbO1Mz2tU0KV7zCFXEbHp7u+ApoD3RbX1A0H9jeixZsse9tYWeVRWR7G8nDUrGmwmfT
	 Bq79471iwASufoOYV1PvJC+XghFLYQ2MxD5/HDOSc4n+LtQTYOTOHfk62Mceiy/VNNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="rf2lDU/e";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.1
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E29606A321
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E29606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rf2lDU/e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De9j8xwwVij7R2hJ4f7dZX1j/rsfCfDIEU3KtusLrXyiYVFyK2g7amXcNp3JyM0whkwYesgcreyfTQOLIYvn7D1SjRUQu/6cW71EUw1amXnDgRR++FFA8U2FvTIRvLi3vRcn+ZtUvpVBLOXrjZAYjwRu4tXP8sBoZKj0BVcGi0AZ5CMNHzl9v3Dg3vwxYZMHPhkfsjYVmlxig8A1FsVGnjY747i70wvSDtxKDK773CDVGA6uL5wIQ0kIT+/uoNzWP39g9Om+BRTASPUqc7xe1OZwJQ2YJaYZTHpn1RAB/m2H/Su4ZSPqyzNXAlW+tELZCjLU6cU+KpnjyD3OkNZiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq+9D4FpU8Asrq/k7/8cK98lBexBRjHLhaRDTbKhagk=;
 b=fOFRtTu5sozYYsSjnPCAjUjbKmbge3TMWdRG6AJYkshAt+mrAhIy0xSQ51rcn3oQNqv+lEG9DZiyUZ2Hf/fAZyxa7bNyjVoDt00IeQ6/d+PkFSbynhke0ONbQQVpaKH1wu2s0eC7pI1DGDCEBQ35XXo50FyD/pNJ17D/5gdNV6cu2EZxGbbDHF7zEkL00SG942t8XiseE4FiIdz5dh5wEVVJp/oaggCerDKaCUbsuGhfy1QrMnn73lnvUaKV4c5gP9rYNu1BFGaiYNIqPyx3L+Cy0UMQtVPHhiZDnooMHCV4UWl4K2EevRm6ionRlyS4qDu3AuAWkFLo0ZJ3amPRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq+9D4FpU8Asrq/k7/8cK98lBexBRjHLhaRDTbKhagk=;
 b=rf2lDU/e/Ar2+xuWj/39LbpJ1caImvgXqugFrToSN4dp1zYUgKBOsOOkOPXEJV/jAMoL6g+3D+X48RwBLFQ3FBdX2E/ejCu+7UAQCoJ/IoVrYp8rfWYcThlWc6S0sBfdScEIOlXiKUBHy2jmkrJepNmdU2yVf+emPiFvIwgRALA=
Received: from LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::18)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:46:40 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::26) by LV3P220CA0009.outlook.office365.com
 (2603:10b6:408:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:46:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:46:40 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:46:37 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 7/7] iommu/amd: Write the DTE under the domain lock on attach and detach
Date: Fri, 27 Nov 2026 11:44:35 +0000
Message-ID: <20261127114435.209548-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127114435.209548-1-vasant.hegde@amd.com>
References: <20261127114435.209548-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dec65e-d10a-449b-0e5d-08df4c7c19da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|261021123027099003|261102123227099003|261009223027099003|261021121427099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tpHQQuBhUbk5nMMy/ye65ju0ObyMB7WPcIjBzAziDDgZDyKIm345WNtBUjgtav8E4uKjmzdeOYMwkSBlLppf5xr3jGmBJHnLm28iFHglcXmrkCTnW/ThhV9khj6Ui3yn/kLAkLFQHFeXC2FRPSmO+WO8ssg3IxCdy4iMt/LMEZPy9UnM7vb6Nr4x1kHIlIlhXlFCkw7jC/3FkIGeJ4G2sdcQ9bct8EoTKcjJOJKp0KXH+6uKqBgukN3KqNeYJv+Dbd/fey/+1j8gnDz75754Bn5oLVpJDWPeWr/FdZetebzyvB1n5Y3s/jJaFyOdfqowj6/mZT9YwHMNxEGpw8yUh+ERBdbXDRkArteD+KmxX4MbUrkoP0X8s6v4BFOYWY+A1qeWL7rHKBi79VGVxR+BthhwF+wyhiX0wSkgzzks1lf3fdWHn8mDADkJt9atNNY5BXdNj4WDoKncdvGc74F480nOm4jgzIn1ozrgjHpoFJoOOm3CNLJyzTAx/rriJ1sM1SRDK6DEEJUabWFPxJf0j1Vueio7cDQFQGYamnbs7Pot2pN9tLLBCIkMPUKNLHiz6KFQxakK7w2lflgiFLYwH7XEOIf0ZP2mo0jnHTNqabmi8xjBXQdJZNRGVKBqXjPLIGaMELtfiWr1dmzkwQI6plFaSkLkOpuKVg6312xWX2jLK2WO6LZLD+evQxp0UZCi92fBSe4eu6NIzT2goKFjhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HKgKBCWzTCtehIr4DoMICIMWWssQHFzsa0J5AwHlPO6NwNZOExsjWBxX2Wk3RSfy7EN3tp6l3jDSSe7HpIvJ+wdqVSDvyO9BC+u7PSDcRhgWZwlGJCnVpIhnvHuQAcg5x7UKXGnKsJSaNdQI/3NvUsqdNW6W1a97NiS++Eh0Y7AsMQV3lJ0nCMJzXE3fjV6Aa05wHh6HiyNRu4gvrh5zqUB2hkZ/9ZzMvMTRue+mqJbXem9RLwNhAOkxx1FLAAr8TV9F7s9i+FTPq48L6s2SCfi5cKw6XqHPfllk4zM2KDqkg/TsgWKl6bY1TrI/y9z1H2s8PMamNscK8hCQm9XJPZN3dliUbzNnlNX5GI7CxRV9OC0vgsTkpJrEGcMawzI1SwBKrfGkszaYk22PspdbUdE9wD5PI8/c8RKzX9eCopmkLGdXgYXL8VOs5sFoncWI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:40.2861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dec65e-d10a-449b-0e5d-08df4c7c19da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137

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

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1c307310cc2c..45298d31b183 100644
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

