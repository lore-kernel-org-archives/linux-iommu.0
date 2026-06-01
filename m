Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4493DCDA4
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346602; cv=fail; b=S8aq/zLKg3H53fhAMgwBGeBzWqQsoEy463DE1sfajB9mTCHpluIFKVdCHmQXCMH/rFQoG/mXRXW+tb7/AmV+rju3adpX6Nid9ehhp8X2Jh2sO+ZkPRlBM0ko/w+E9cpi7ER7Zup4cDYrLeOdraPasxv5/jqsTBoFo5IUNPisOqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346602; c=relaxed/simple;
	bh=KKiqcYbnuMNWzAHKsDMs9tYOEBqCAA9CbS4SvGktVds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8hdoRtzbf7TY6IAEpI/FFpjQXDiSvLfhjTII923Q2utUmQ5ATyD3d6UsBnHVmjbvlFtxbwvZGYyPV4PZZuudWoKteLE6JSPjS+iRelhtnfYuh4VbpPCyOeW8KwcwBhQG2NBLMBlr2JKEI9KguqHIzZnKpRcmKLnk3+W3azm7BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBwrGWM1; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBwrGWM1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBGjnX3yWE9rDytVob4adQoWrenfpFwcsxad9saz+AGyh7RQcKvELJ1e78Cs7yYQE50aNIh1I6IYS1a/0mJmm18MIxC9460mQFB+acfSgFiH7tG1T5Fi8YJIFX4SbUknxGLR74K+WDJm09iZJz1H7fBx/lco00TgVnI6jL/f4xBEb144tMK9ja2mo5jgCZ7u2TuE8XfkV2ShGe5/RsJh7ZYMDvB+cVdtn2KQGxYkFLMpYyViWt6hKMcvPscv7jaPXqUMv8hUSZWjLYyUb/JE2Qr4P/jKgBiAtTL/K2lezVjwjWam818gij7y8EYsFmGIChVhNECOFy2z6JRDMUPIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj5FGcqDG+pkxdR5aW//jfCke3Y1uDHhuV5GZSc9RA0=;
 b=Guyu8nU204SQJKSeEHngh23hn0iXRlp+QbtUQ0UysPjeDcicMHkJUkomQc/xdGegkHMwwYxbqe1lxUBEa4NislMf2v1LD8kNtdm5Teqi+D94qqAPj5CrA9kOO37lBpYC089S7d/fzWPtFYAd3vPU/8UdYjbp5VBtHe9utSARISm+2kc/ILV9tS2+EU8JQ7pxKiqpTIEQ0leE3z/i/IXx2OL4uC2yCSdB+RrOsCjOu2bXPrFKaM9LBi35qUdiMlniNuGmRF5lJWGJIsyghU1QYfG7bGHtzLsTg9M2R2o3WSlBhXNUAbLbgW3qxHh48HuxUZ1mV+RKDQBwQY2Zrell7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj5FGcqDG+pkxdR5aW//jfCke3Y1uDHhuV5GZSc9RA0=;
 b=LBwrGWM1I7TJ0sbavCkuojBszwGwuMFzfBxNzfNfTNMOYd6W5YqFAwh4hZiogm+anuGblN5FVXNyUK1GM1brL+w91Xgl3NHBe7Qo8rKQvrYudvi7D2bD8oEsd9UhBVJosPzacoDTP4kcT7PVQJBpS+3IT5SKEzYdWJCqdmo5YoUrPCqeUHsApWaSW/Tg5ycEPn8XTfZM69ieCTpRKCPONNN9cH3vQN844eRmTw1phhVsPf4Jfd1FtXeSM81BMAcMkLHH1mxWe7sxFDx/+AaNQRjvkkxDZ0ziprFiEvBJC+EO08uv/ZByuex65apMEgdjM6Dr8jYmICcLCu8yd0V7Kw==
Received: from CH2PR14CA0050.namprd14.prod.outlook.com (2603:10b6:610:56::30)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 20:43:16 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::5b) by CH2PR14CA0050.outlook.office365.com
 (2603:10b6:610:56::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 3/7] iommufd: Propagate allocation failure in iommufd_veventq_deliver_fetch()
Date: Mon, 1 Jun 2026 13:42:34 -0700
Message-ID: <25d29feac909e36f78c145fa99ef2d4cb7a415da.1780343944.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 9182ab36-b969-4f46-36e8-08dec01e6804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hZAvfsi+qgXzAGmHL5nSbBdIrRXjeeQOoYHtpHenskS2Ln1Hei6CXSnKiMahKg8C0xQfPBUQphSLogcYMe51nYCHh4eLnSa+nTX4cSOZgjync1BTQ07qesTL3qu3u/XebxSVFGUmf6Vul8YvHTEcviFsYmXFwsMO+OxbYd9OJQSeNnoXT0yZ2L/HjLT8FuCD2rj15auXTjA7BHCMfMA2Gcq8Y+YUu7A1XvJyO08mQFx6pxvJmlraTGNqiS8X/aC9sLgevbsCD/PV948nHS77X+SyJB71nWW6loYPg0nbw7ODTK/CQNXIQvgIpY5cJjJe04KWRC/N4EeT7yDh6aDAvNXFkaLRhk+ExkKXKQ8RLTPZ2zTjSQ1sAQisc7lpVhQ3w/guHgpQcI3Y/PSqejZSymOIFHDoqiUBR6jthcX9PZ9X9fkwrHICGUe5e5NpG6xt/uCg2aINpF9C0Fy71nzdBLC8cG5kzhkHvUEmuRDq3yGY7cDzA4xiOz27U3WSJxLZXeRzEiQ1/OCtbohCXCPFPNvXOMAGg03YZ5h+FBr+8hdbmueTgO0gQ0XfC/A3U+DtnMjF338r3o2UdTc3/vTYJF6tgm1lIHJhpRRLYJKdDQyeo6HxkBacOBWeTMt5SQDnlUP+Rw0LX2E+dxHtXu8/KEXrGgpDwb1Zo09vF73/cgeOUhpS2wBMPsq3vusxkNZCVov5mykF3V4W0YOhjy/XSjBWJgNKcVtqUEoqDMdMPlk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xcF+RlO6qbMovpSaSqqRk6WB3Xki1AVbHxGbLcM+23XwDuHEOnVf9UX7xhm/gXuH8JttfgkfHLaRAW1cK9JgwywV1RJMlFM4f+/6t+ESn3xcuHyDScg1mUXFABNRT+PV0E0ptnUuNahQ74UyXCjt7LU6tV/pB2P7vagZxxe8E5dHqj+J+IlNhP6AR7sX/6iFgpbLOkGyXqhKG0QrMeVUow0VTvm10jVHlYibBzMO7y6Q64+KeVuBt0J449jI4E1ypmA/XWd1Cs8dA0+3xITLHfU/Mlo9VA/WOMfuOKXXZGM12hkKg0SchkuAe8htTM9Nj4ZjSZjPjmre9KjkZu/L36QiJSt24DBNwnR5w2bEi6OCP0ch/GmdIRo7hdVK2VloRmadw4BN2D2NmkGRNfxFK4fNbB7u+/Oe0n6ZKyzzWvuuDs2Cmw1NnF0pmNq7/rcP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:15.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9182ab36-b969-4f46-36e8-08dec01e6804
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

When the kzalloc_obj() fails in iommufd_veventq_deliver_fetch(), it returns
NULL, falsely advertising to userspace that the queue is empty.

Propagate the -ENOMEM properly to the caller.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index ac485d010a439..f55d173c59f61 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -264,8 +264,10 @@ iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
 		/* Make a copy of the lost_events_header for copy_to_user */
 		if (next == &veventq->lost_events_header) {
 			vevent = kzalloc_obj(*vevent, GFP_ATOMIC);
-			if (!vevent)
+			if (!vevent) {
+				vevent = ERR_PTR(-ENOMEM);
 				goto out_unlock;
+			}
 		}
 		list_del(&next->node);
 		if (vevent)
@@ -315,6 +317,12 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 		return -EINVAL;
 
 	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		if (IS_ERR(cur)) {
+			if (done == 0)
+				rc = PTR_ERR(cur);
+			break;
+		}
+
 		/* Validate the remaining bytes against the header size */
 		if (done >= count || sizeof(*hdr) > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
-- 
2.43.0

