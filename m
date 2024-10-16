Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BA188013
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055902; cv=fail; b=Kv8xwNNF4qyvUU+s5na87aCuVleiXZeJ/Ig6e+owTmyJc9rGWBJWLDvgbiY60GPt23hEQmsz8ZEsYnOcrKsd3pBOfPdTls3jGxSMWZDewOmiM4mUopexOTSUZw0BEIEesJHdfARHnOLdoiUvZyqpsnNh+blmvAW0IGzxZdDJ0MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055902; c=relaxed/simple;
	bh=AEpi+/gB6G07pevQb8iY9RKGjahd+4XnFuKmK9Go+do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EeBdiURKjKbacXbvh4yIuyioZbsdanByJz5EW+smS511SFu4ynwZpKDsqmMPuifsAWGsEVOSBRs6dhQKqNY/xg9JNuKzEOQEZ3BP4EpAjJ7r7NtAvPjMw0G0xO2eGINc5MXVkIsZzjgur88Cky0k6cf9s688LtWR9I+DsAHtJiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KVDLT0t1; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KVDLT0t1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hziqtUUIH0HVUWsrsot8elpssrk22jdMK0KZL9xrVmw3RF1AVZZwlX9RDdKbZnH9GC3EtzlmUzJYFOQLlydM1ZSiqaWbOHW+VxA2ugx3URkAmauQUkKlu9vT16eKF9l6veJuMJY94Gq28/tJpUl9oJqy/qw0+h3jSvmpWbs898BY9enW/4S4dSaEYOxalfXqrpbsbnVIGz6IqMZSElZPTzp7qFU3hSuetjt3xJqZtAmyAzfOwIBYS1bUC5t72p6FeIzecncz7YEhVAEX5sk3EHrgFsqO9hybokW3P1ZoDe9e1wt31MJ4RobNfsdrdD/H5cNhd7i5tbW7rvgDJ6LAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IpGDiaFu3tSCSqx/GDFoOefr7Ro3rTI/tEsKjp7Iro=;
 b=VRohe5uur0IytOMfW/XPgjJnAZpeKq0EO9RCDWe5n2kCEPhFJx9aI1+vbpyfqpTEwwhQmfwEB2NIHQ0XaKbKJSZfpOQvIfl7Y112a7Y+QF+l0yqRRlmINl6tPTtwIU0x8vNPcyTqZav1xVHa72kCAf6BgEkq2qUUJ3FHsWCTHmkZAPZ4+seeTbt9m9zxumu0Z61PhXNU+YQ9x5rU0XubnCD7J+Xi0x9uyvwt4iK7YS+dXAYPo4N/QGqFso3m+dY4ApihFc2mYvjsocQf8nWnB15TZ8nIzR02Y0lhiK+IEEcVhoIuRM+F2bi5uf9AUQhQXacTB3WnISK4TGaGdrx8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IpGDiaFu3tSCSqx/GDFoOefr7Ro3rTI/tEsKjp7Iro=;
 b=KVDLT0t1Uc5JZLuhDcdjuKHddPD8DvR9twGzmSX3u/v5mPZ1HNACzOB7MSBTRSfHCNrEf3fP8IdtPn3UZiu26rdS5eFRnBJGOpU1aiiqrACZXdDAWp7yeuQyq3wJ5LtqQwegr/lUIDLxsF3U3fMGokgTtTRg1S/9wvAvBqhLfoE=
Received: from SA9PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:6e::19)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:18:15 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::dd) by SA9PR11CA0014.outlook.office365.com
 (2603:10b6:806:6e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:14 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:10 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 0/9] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Wed, 16 Oct 2024 05:17:47 +0000
Message-ID: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3083d9e9-49ef-4054-82b2-08dceda1efd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oA3fuasGV71WF61OmDhwsGP+O59YSIiO4ZTQxEC2eTD/ua5yYHBg7hUzIxXq?=
 =?us-ascii?Q?XAkre+kDkV9g0YuSDxECP4HhkKPl7fmz477VSt8SmkHnFIUXNxA779v+7FKh?=
 =?us-ascii?Q?Va76COWnFy1rMQ8jLHCl3/ckpXwB1/XZEH7BdUxC9y9xRA4AuoBJY/OgzWIB?=
 =?us-ascii?Q?sb7tcbyBJh7d9ReH2j4GY9Dwg+2fjEfs6wpUK5uP5LWfgmw5SBVK/cfigeLI?=
 =?us-ascii?Q?RNoivOIZvFnY0n9hU069bcd5sRTJAdgjGb8d2JFp5oFFUId74WOqp9dfPw0X?=
 =?us-ascii?Q?ga8DCIA/uu8HuohGc9KdCqzTLjzxx2gOXpV3+9gaA4g32SkhSnMXStGgqJgD?=
 =?us-ascii?Q?+uLotrF0Giw1FrRwn0fkOrgi8cw09BZAr8BP94Vu+WhSEFJ5Hqy8ZKJo0UdW?=
 =?us-ascii?Q?ab/MhIRQ8PECnCQAmQlOTrT5zEGZAHN+uxAkl++VTh/NQCkcsmqkLQx6YPGD?=
 =?us-ascii?Q?MFsGXu5cO9XAXeIK3laApuLBwGCe+Xlx9zryRFtb+WQEfEaifmu+Ilr4BnO3?=
 =?us-ascii?Q?2ZMHePYiGcdUanhqHzvzF4kW9t3d0YseKylGTizxW8YiUxgXDtTywpK7J96f?=
 =?us-ascii?Q?0UFBYNMtllIny5/pjIXDAUNCovNWAwjTmHcTJ54hmiYwtS7h4NEGx+1lSJEH?=
 =?us-ascii?Q?u4hHiN3OusET17UKazZKd4Pc2cMQ6fdjdBD1wE5cCKC+JCkao2V/e5zzfAn1?=
 =?us-ascii?Q?jqSETqoCUfSGx29W4iLKsnsxjqXxBBdmRPa6tcsChlWjHSCzNzs0aac+f1H0?=
 =?us-ascii?Q?owSGxv/g5k5ZyZOX60RiXZ3IiwpRHz5gzMpPsVlFONLl4IVVfC2rq6fMK6+q?=
 =?us-ascii?Q?uUxrZP9WSrGRjjQclP3fOMsh8xWxNrb+OsTtEpxjG45FN8iOsfS1E+qk2WZE?=
 =?us-ascii?Q?7jY50yW+Mf9G0lqnf0yIqeoRW1mQHovgZSC6y4jRgdzor6YvSix4dDPmKR+l?=
 =?us-ascii?Q?TBOHYmEZKLyWenkSUW99X5ZxODXrcxML/6mKDYJZPYhZp7wRunll1foWcmZR?=
 =?us-ascii?Q?ujo+UJSVQk8mjBqhaFnabzwuTgAXRWxvz2d10kN3fVbXWG5Pog/3kIiTFsOY?=
 =?us-ascii?Q?kc4cV0hbo1TKsFEP+ArdirBNceQJsjW5DbFz6doMIEeVr8rUGQ97/K9tMaIf?=
 =?us-ascii?Q?QlYD0sFS3uZEWdxq1DBBUVs9EuU5pYXCwibJKA7nUQ0g7MWBJDflatn4ii/q?=
 =?us-ascii?Q?SVvbygfEaL5GebrZgGc4zgWgakDZQb79Pi6f3GJGHdHWPar9IorGWO3Jncf1?=
 =?us-ascii?Q?kX1BWmVR+NAWtW/DbQnCI4kqYuMTz6HSEN3ZYD15tHAn2O8me/IcBctHlwgR?=
 =?us-ascii?Q?gYfT8BUHeE97QqgXDKvqlUvx0APCbaJUyC16ocx4QLjTUinr28xb5BcWJ+tw?=
 =?us-ascii?Q?tKpC0wDvF8A6UYv+k3/Tv8/eDtyB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:14.7898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3083d9e9-49ef-4054-82b2-08dceda1efd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v6:

* Patch 2, 4, 7: Newly add

* Patch 3, 5, 6, 7, 9: Add READ_ONCE() per Uros.

* Patch 3:
  - Modify write_dte_[higher|lower]128() to avoid copying old DTE in the loop.

* Patch 5:
  - Use dev_data->dte_cache to restore persistent DTE bits in set_dte_entry().
  - Simplify make_clear_dte():
    - Remove bit preservation logic.
    - Remove non-SNP check for setting TV since it should not be needed.

* Patch 6:
  - Use find_dev_data(..., alias) since the dev_data might not have been allocated.
  - Move dev_iommu_priv_set() to before setup_aliases().

v5: https://lore.kernel.org/lkml/20241007041353.4756-1-suravee.suthikulpanit@amd.com/
v4: https://lore.kernel.org/lkml/20240916171805.324292-1-suravee.suthikulpanit@amd.com/
v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/

Thanks,
Suravee

Suravee Suthikulpanit (8):
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce helper function to update 256-bit DTE
  iommu/amd: Introduce per-device DTE cache to store persistent bits
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Introduce helper function get_dte256()
  iommu/amd: Move erratum 63 logic to write_dte_lower128()
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()

Uros Bizjak (1):
  asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128

 drivers/iommu/amd/amd_iommu.h       |   4 +-
 drivers/iommu/amd/amd_iommu_types.h |  25 +-
 drivers/iommu/amd/init.c            |  79 ++----
 drivers/iommu/amd/iommu.c           | 364 ++++++++++++++++++++--------
 include/asm-generic/rwonce.h        |   2 +-
 include/linux/compiler_types.h      |   8 +-
 6 files changed, 322 insertions(+), 160 deletions(-)

-- 
2.34.1

