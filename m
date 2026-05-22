Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105B212548
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410224; cv=fail; b=p50r9fTKHTGvSoP7NYT0nZ2b1UkIZHEs0vP+f8Et8zsgUFbrKzAPZ4JltvmKCZMCkcN9Ayg6H6uDszV0OaqTt7ZFuSabjIxZFqdnVxyZVWpHrH8rlVMVUEyuG+G+0SULDedDhptRnQvE6LyALiZoatKCZ4jqyM0nRX8dXVI+ul4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410224; c=relaxed/simple;
	bh=0EdPmZas632ldc+RpZz/e7wnoJ1fGsJ0K3Gi2XFj8Kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW19SPabOxXqloJ9djifaCwL3BdfE1BJNjoB+or4/p6aZvx5uiWegsvyZy0/1Q6lHLbTCDoaTWixQamJcbzNGowrA/SFOJHBpPYmym7fSvMrcjo6MYICOGpLVynTnSpJr91xSiAWy+9Rg2jgMCOkbZhcxU6EAc9JLJJetmzNbTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BD2Jsmz/; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BD2Jsmz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khSzcfEZYiS0Qs3yb8kf12thZa2xaHnbNge4NeX2QHnreWt2JaHJsn1GaKWOiEcPjbbEiu4NgFQUD3Cn8vLn2pwXN4n5mxC+qlj79oRuws6rlrvfNAHHPg1CC62Cn3/mXHXweGkVSW4JFaS55jVS1jVwkRy2cGVGwvM/NPC8kJjNNKBIbviU5aWLnb7xm3p3v7s/FM60RiVxnbr/blXidBeXlZAdcOHV1S+XWyoebz2XTfP4J5JDkKf7/vc5RF9kWe0181ilx7oinkfUwvxkcbnHCB6+PYrf5oXPS9uMNdlcfTjpZpC1sopozW/fgbqwzv2/03gPol4BrwEsemEZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MojnsBeKUD/yCEDAHKcrUO5bjytKIiQFDaSw5jmNe5k=;
 b=U7uwKxCA0rToZdPHqDvzZnJ11b+mAGLLl3WQ2Uv3Lk0+xY2/qF5ZqHrW74MDnXhj8OuvcyRMyPnvl+NNjq/PcTWXNPF57hBhmGsT09N5gGsn5YJQU/BtRoerzKafGhIMlQOIsKsztzRoK/M+mRHSt5b+5yJXjPGxiRHjqw+407ybqEJ0FwBK78Ol03j5bFeF39Y6ylbGQE7/M2MumwCfAAOreijWTG/6av4UE40FH8V9uwKdUfAuMh0wyjWCHd2pjCAJuwCW/PtRlK8mqb7zUkm3UTWQ9Y9HiX7WoMOdRxV0M7IWxXdDbzA3GWlPQYdTglC9SehNTINtIxEw0nmcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MojnsBeKUD/yCEDAHKcrUO5bjytKIiQFDaSw5jmNe5k=;
 b=BD2Jsmz/7gK7BQdSChJ1NqUL9saTC4YcWaD8vgv+51RE9FDUz4ybleceaa7csu1m9nwc8jA1sLmMoJlW9Pk0LOqZcjejmuuAO7Xkjp2/c1rpnNVZDrRAGKr8BMbsaNPo9d2fDyMHP2siNGnqfMyHo69By4dnbCTDy01w9FbbWh4Tk2KV6Yhir8FBsYppoibdNLxHposNGXHKt8qid4EI8W5CJAycJaUNSkGwlxVPtWkLMXmJKXkE/oxqq6cDXvNgxHGZ6RmIk5fbRGuT/n15B+DdR6+LdHagMecK9e9jp/wp5OBtA91vNp4sZ2P3kLWILwwbqifMRRLMtu+ObhFcxQ==
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:36:58 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::12) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:36:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 17:36:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v2 1/4] iommufd: Fix data_len byte-count vs element-count mismatch
Date: Thu, 21 May 2026 17:36:32 -0700
Message-ID: <f7665f839b9dce917d6bd394375a1cf56568d86b.1779408671.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779408671.git.nicolinc@nvidia.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: bc64ad77-a816-4858-9bca-08deb79a3ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kkZY8pEpJeAie/5iG4L0lASbL5YQpE6k2gIkMVcwprlO9PFwRggBA7XoQbjFwSKBdMkPTlAiNjmELj5sZFLYsXtTa8h44L7UBUvbTbCNtFZzga5MgnsrM4zZU5SvynWkGFzxvaI91h3tyVHn7U0ut2KHAZoaTCJIC7gdLyDEHyBb6YG/tLkjkYeqFFCAIbanhIZWN4Z6b7ztepCjj5unqsh/rQid0z4SREYWfx7S6wi1RFU7z8GeQRy5O2Vyq9w8S4Y+h0omZz8YJYb6yiNOmH9lSJHLcqlnH6bdOEGSorx+SSywlfqMZq7X+K5SosNvTOrdawNYgmw2jkF3jIjM10ZbDNLU9WBTm7FQWGjnUJ3eYFeyo/jOJPrkXyCHnOqnGKkb8MlRrXwFKXHnX3FJr4+QR9yuw/mON8W0q7oe8FkRZSUFoI/yPfIg3G56wbaRN8Oi2ihQydSaK3bTd95JfXk8e8kgzzEivkllIv1pM1SLZpJynfqn422Aslv0kumMcuEXhmvICnlGMjJnr3YvumP4d4S+YfV2mp3TMejX5jWnSu+tXUut+LNTzgAe+jqGVDF5apzkQRZqWe3qfhBtTIEffHUKChU5LP1ZnV4hxv5WtS3Mt+srzJPV2oaqACdz3c0o1qW76yT2VT5bXDPJR+JgrHYUTemkjt7CCz8Hppk7k1h5nOiXIBh2wDTtEMcp9LpkEImqGfKJK9r0Q8XyA+fDMwQbyyblHDg7Hx4Ms0g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p05iXhwr8VMva8m/gCiU3EV2JTrMmnVKoa9/zPfqIPwmLEIXfsmOp/3TDBaZeMMH4YwrsEze6cTUjYv6jQFTKH4gmERrmJ8fFPTNT93A4GmkTAtEp0OxUfL1HHbH5brel6FtmcJa/g6GlafydVx96RCB7VyhdMUJ/u1ExQSOeCRGP7ZnerOH9Rw7Mu2XByP/UkxpWkEbP5AYGwSWcH5mhkN4gfJPZeXToIStE6EopF99+L168JChpWFjCXYwux7AMSoJOIEYMVrHYUvIBMucx3KxCv+m3HrW95G2ffmJmK463HIbNBlRdyLq+yUOhoHSd5gbeydvZEXedOC7D5WyulFn+NKsK3Tf3eUxjODgxXNEp4EL1AFybKGX2gGMFMpekvSu+kCDtknWQxQGhmyIdaCnjFuGYQbuNOGdttP6xRtbM1rE9G9CwmXB2MJjrmJD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:36:57.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc64ad77-a816-4858-9bca-08deb79a3ae1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

kzalloc_flex() computes the allocation size. With event_data typed as u64,
data_len is interpreted as a u64 element count. Yet, every caller and the
read path treat data_len as a byte count. The current code over-allocates
by sizeof(u64) and the __counted_by() annotation overstates the length by
the same factor.

Re-type event_data as u8. No functional change in user-visible behavior.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9a..43fbc5bed8de3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -602,7 +602,7 @@ struct iommufd_vevent {
 	struct iommufd_vevent_header header;
 	struct list_head node; /* for iommufd_eventq::deliver */
 	ssize_t data_len;
-	u64 event_data[] __counted_by(data_len);
+	u8 event_data[] __counted_by(data_len);
 };
 
 #define vevent_for_lost_events_header(vevent) \
-- 
2.43.0

