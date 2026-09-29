Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF64D1780
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718764; cv=fail; b=ns7dx06SgAcj8kftd6cU6BKlJZLbl4m2gSDgu7N976WIBf/72VqkuKl0xbZdmxz5v8bx8WQ+H/yD6ZoYT4RzPUkC1T0jbcNdfkdGuEsthcWfIAV9T5UWCI4YCti/eDjICxJE7mUA/xzvf8SXdMJLaX+SEbOa/mRjpqF+F/7nISw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718764; c=relaxed/simple;
	bh=BTKV3+SiOq25QLYOFcKL9ue66h9Ze8bmMFxsoxhGYDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cMaf/t7RHgC8ItObfv3kRr6DA9/URW1g9piHUJsJ/faTf1gOOJvIzVmyQGAvVmnXw8HoU46n+GZlgtNDJE7kuWbsZ4G5Jw+kR0S/lrPBzsuGJ6Tq3lKpL8DycQ12rxxt/IrwqNQ6erCGjjXT8OI4T69Pi7TvQEL0APwiAt75nlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=itPl5IQm; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="itPl5IQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRdm1j3SUHjjQzFGsWdjrRihdav/EA+NvKxO5MHxbwRr9cLJn/rWITXS95qQiCx03zqndCtT/2R2XpiIXj+XB6n0N/dDWs937dC0ngT0KXfiWnIgywBY/v/cIv9V8E4kbx+O0NOBkL0RWNtmJC7W7KbJ6GEU5rDAFQsT3QJjzZvpzNihjGHJlUCYocaaCOFqn6mf4bfMmsqQ1nFu5J8dp9pkdWCW8R+TEpX36BTMYwyyeAc8gX3kes4sQ6XXgqtSCNz95U0NztWjCZaTS8Zo1C4ApWBI4qqt9VYUabKg9iOBMnWc75N2WYNWgUbNRs4ZR25dDuDp8drFwhWf39TcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bmNtcxjYLpsG8hsMQthDL7f1+77kLrldMCdterwk/s=;
 b=bWK8Hi4tsDkPeVLqBVJn+vLj7AOe/9nTISoTvL694qcv4yEuNUI/kYSshkvILc8rTjJrA0ZAYZVF0lsq2jgGFMzqzAmyMnkXRfsfhZ0dPDe7Ac6wSDGdCEuPr0hEEJu7IkEXqVuuCvap/3patNMnBczzGZlBb5TYwUQVneYRIisgc3b7LH45YilIbX7nyfDwXzYAJB15nc3mJf1rDHumpnaDqAk94uqNCkuip6+pjTEm8Np0J6L79ygCskwNpM8fRWY1HA21NzppTrF9EZZehOXurh3sDnYuZ6VYocOW0mr5YDLpjO4DK0rUq4+S5IbQqN82Ht1aog2are9otQpqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bmNtcxjYLpsG8hsMQthDL7f1+77kLrldMCdterwk/s=;
 b=itPl5IQmwzcuH6WcQlF9Ch/mtcDlHEZZ45XU7x2AKsiz3U4jGP3dZGcGPd11vTemqm6j1vaIR3Q1WYcFWtDd/lZVC156/QQO728EvMTBWYpieth5iiV1FdT5xKtIcgdnxRp6cgvtaRJyTw/sZETcYUFYjdx9mcMWaXj8l4w6BTcgSfUte1ZoOb570uUTt7tjtNbQcYf65vyzw3ms4UnX5ieWj39TM7qgxJEHV+JbnWKREKBNGEk88vojvjyBSPekb+z1rOluvZ5hN/ZS2oErpTQar07F2dMACtwoEG40milI5ojKd7hzsmnmCNaKqIIhBDBUsieojTH3O59J+QjtBA==
Received: from BN9PR03CA0769.namprd03.prod.outlook.com (2603:10b6:408:13a::24)
 by PH9PR12MB135921.namprd12.prod.outlook.com (2603:10b6:510:412::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 21:52:33 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::6f) by BN9PR03CA0769.outlook.office365.com
 (2603:10b6:408:13a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 21:52:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:52:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 14:52:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 14:52:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 14:52:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] iommu: Fix attach handle publication ordering
Date: Tue, 29 Sep 2026 14:51:50 -0700
Message-ID: <cover.1790718296.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|PH9PR12MB135921:EE_
X-MS-Office365-Filtering-Correlation-Id: 816c3574-1449-4283-96d6-08df1e73f73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	lclnb4YfRmbfQfWZFdEGmn3Oe33zsD8ao7hUE8DCaY+Vb22EHh9h8EGr4Nn6BBddzbpLucIBu2Hb4ohiT9+Ra2C36uwH+BtdhyadMZ8Z6f2VX83cvUxhQhmE9EwTB4Hyp7AzWhR5yxOgO+CsDegvnNqISpZ9qSLXzfWNkC64POS649oTVI2QKK/33ll2EAk+d5xtMQgKcYejkkJCgPZ4Z/Q2zue5Jupkl+5nRC1wGy0XzBpejOLBtuK0YXL2PshsL+37TbX1NrTAwO6vj71FqN+HKGhqQ1YnN8jbciPmSm1tWr1g6X6m4mQj1FyreCAp0bKfldBjGmSkLZxdV+/TSv1mbUj9zqiLGAHF5maiTtmHuGR5wse0rr2WnQs8dIkLdoZw5iv4cMKL8Sify4r8fb6mETNOP2tPDztmJ93nErYf5Vxj7QuUlywk9HN4vehg5zucA2tLHY2C+9qFPhA7LKH5nelvCQxpZ5FPtCuWCGBtM0a2H2+V/hbHEmC7sLYx7RXjFI9P0JsW0jrOpkkFFnQbaFmrp6Fq4m2a3Ww781PlDykZaLroG59OyIs2Dr7HkIDUqtnn2layGXvyGCC1EEhe1L6+BtbIu/JluI8MzQ5EBPtHKmOzboCP1XtDqcPj/yvd3lYPOC+yp4ojeWBtEuP2rDyUzFB9aTGI15Rj9xOEb1yDQWUb5aRcX0AAlyTxJfsc+Hbe90RezBD6EDL8JA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8osjwU1IrHx4NSHjdfZrk5w9st9GS6lq4ty/kTaOsdmQNibGLDd4CZMnlxixwWIAWmXGEcJzsuINmf/DKATff7fZa4fjZykse6JsSuBhuVfAcDl32MV2N6fxSu5oUW8CSfhhnR4JyG6ssR9pQaukizZyz1gt8cai5qUvoZKyFrarFAriNMqzjK+3taepXDYa+3qzbFgY65NgKNjgQApCgilwvEYDAc785u7S/LTUzlJnVYANPMlkv5djBA0jj7/MSj66mNby2ra9zTE/9sIcC7ZI0shBjVIatwESunh9Og5SVmAzRC6RUn+bhEr+0LTvuZ8K+/pAtSlLA4TVSAQpXG82XthtjhGNjHNHoXjxMCDJMbRz9NHnFondlKRO8PhfymYDCB7R0bBbeyTyLMphavZim3euF8PBCZgDPjX1Dsfn7ok2a5PMSYkj6RUXm5Pa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:52:32.5873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816c3574-1449-4283-96d6-08df1e73f73a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB135921

Jason pointed out an issue in the attach handle replacing path:
https://lore.kernel.org/linux-iommu/20260923233920.GJ2545495@nvidia.com/

When an attachment is detached or replaced, the IOMMU core can still leave
the outgoing attach handle published while calling into the driver. A fault
report looks up the handle without the group mutex, so it can find the old
handle after the driver's fault flush and just before the caller frees it.

These four patches unpublish the outgoing handle before a driver callback
for both group and PASID detach and replace operations. Both replace paths
store XA_ZERO_ENTRY to reserve the slot and restore the old entry on error.

This blocks new lookups, but does not retire a fault that already obtained
the old handle. The driver must still synchronize those readers before the
handle is freed. A same-domain replacement skips the driver callback, so it
still needs a separate lifetime mechanism or fence.

This is on GitHub:
https://github.com/nicolinc/iommufd/commits/fix_iommu_attach_handle-v1

Nicolin Chen (4):
  iommu: Unpublish the attach handle before the group detach callback
  iommu: Unpublish the attach handle before the PASID detach callback
  iommu: Unpublish the old attach handle before the group replace
    callback
  iommu: Unpublish the old attach handle before the PASID replace
    callback

 drivers/iommu/iommu.c | 54 ++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 19 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

