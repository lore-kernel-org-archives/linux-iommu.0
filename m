Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F4346797
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827531; cv=fail; b=OzAjy3j1rGKhJbxF/IyCqfBuq67l0rldOwT0STIwMh6iALufoi7YJDocDJzef1S5Fs7ncsu+8hweYvXyfym5To3MDVOeXJzCerfMvXI8S4/xcbqE2Mh9CaI+LVdBmdlW5dQ87xyfT9ALVsO6N9tw0Y5Qriaj0xs58N/yeyefYjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827531; c=relaxed/simple;
	bh=o/OmKANAD+vxumZwjRfszke/d47s+ahb8xcZXrMY5xA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtH53EnzS2o5PD5iT8Z0XcXTbDCXL4f6jkkXM9fCtf0RNavl2weFxtpiIby5TPJDCZDXeD6UwThZj44kXa9uezmz0d8Ugh4y8FRLTgL8V6CQYevbDpcgWhWYk1iJAJwCwj7LbDIqIvduQrITCTr+XSyBjDen/4EP0zApa/0MZzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFCROZQQ; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFCROZQQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXRLoY3Jj3DXftsc88kM3/XUcebMxqHV3RllrTgRm5ABQZiphxK8ZLqUSe1yAqnqkFDqIjoUWo0sm5Nk7iUFC/j9pa1WJrwikdHuvP6tcoRnAZ5+s7+yxKo6fAsZPoiKZQkJJ3Il8ipAfeQZhtUjXfi0nKZDKm1wKhl8KSpauH2fb0lDYqwq0svc2hNhJFZJWBnkidcuQjdfmil2tz08Y9M1Vz9A7buA7yY4M2pijhUzS6teF6N4P1NW6Mlw04BJA2Jii5cyuNDXatg7hJS3ESlc/LKDSmv2lR7lt1Vz6rZSyfXwwMd8hq4WtCRYjfVGnL0qIlUYylSszLdsk2lU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy6zyKVRkm5V9wGHKqfcvfQUNTeXDECD9rKf2Qj5NcE=;
 b=lt7QNfSwiq0f5nh05m3EqSpm05YXB6FEbQZjGzMLvZYTLYKD+H207d6XCu/d1VseAc69J74a7fuBrneSP1BROiQTtB36rcCHErzQTXqfqASqU89/jk2+i4SXOLsQ+ls0CnLbnYGmvtAS2HZZhlkgHOmtGcPozSaEJz2Z4yzCoy6MYgfFCIGunrmo5jHLncBVZU3bAMftZekaqKjT6LVbq9jzeEVOIwqWbDgtbMxtBUd2gF0UneBjEY8tkONL+8VJmmn0olL/9Mg9b+3pmBk7a9IMoof74h/Gs2ZXsK7ecgY97FBpeMAMrLkqK79rAefn7w8vJLDoLAQbmJ8SfpFwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy6zyKVRkm5V9wGHKqfcvfQUNTeXDECD9rKf2Qj5NcE=;
 b=XFCROZQQypdnP5DckR3Cw1CfcHRNdaeBAUW0iLdsbTKi2vVftWIfy0P5vZSCQ9DyughklQWlHb3llXtSWtsHPfaL9PPEN5aVzxvaEJU9+e667otHUnlStMFqhAfCAl7jt3OI80j+IgGbwgLeWW+6A9kYnI+l+XcCQxe0/8Xceu6uNG3L+L0FZhMyKJ9WFwiJ289uPa0cbfQpfXGgZrQrGPz9ZW0+xT7iOng8cz9sLxnqdmM0Vj8T1oY7Fryy2L5YR+B/3pMeCrkqTyJ8AuEuX+klOdRkoPQoXY87GPieliTLB18SArJ2XOaxfQq0O7SLoK+UNFnrxDiGzkyyhIg8Qw==
Received: from SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) by DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:18:39 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::44) by SN6PR2101CA0021.outlook.office365.com
 (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Mon,
 23 Feb 2026 06:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:22 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 4/8] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
Date: Sun, 22 Feb 2026 22:18:05 -0800
Message-ID: <84b2534f69772e981648c922515c9f0246e54bad.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: e41defd8-497b-43ec-205c-08de72a36254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kKffHvhFqsZn+ayeZSNvTyxBtuy8KXniUgLjzh7kxFuv7oV8Pc7PubZOamV?=
 =?us-ascii?Q?4RXakrC9WSJZBpx9eAWcyLqY3sYC8tzfdlCMOhjQC44MSI4zKXjLP3spt7qJ?=
 =?us-ascii?Q?8ud/HOAEHAom7ga0iP/dRtO8DLmvQ7SJ55rmHcro1D+9KVkz54F2/6Q6I5Oi?=
 =?us-ascii?Q?c01KTWzlnEvQWnv3BGP3DJWwPAIcu8E5WeN0qAvbZJXoBUFRX+I6kRHswoON?=
 =?us-ascii?Q?l+jZgJaeRdD/n+0t+xP4WbrbYzR/A5ri1u0NfLVsdmRP3yDYMKQBZE2vEmAj?=
 =?us-ascii?Q?R+ZLhTX0zwLyUYqFrhmnffYKE9hJZrpW8bpWlF5Arh8YEqHU1CO9Y8YVerXv?=
 =?us-ascii?Q?7KatQWYqtQOhc35WDNblLZEiVTCWDxvDe5ejosAbjNdvx2F9tLhSjr6w4byt?=
 =?us-ascii?Q?xX9v+e8jw3hYS7onaI8JVjiOWGT+9f1z2MCvUOFEixVmBxOx3OvlVJanyS0M?=
 =?us-ascii?Q?Cw/NZi09eyyc9p4PdUQcIoyGNPVZk35HHzFWfYIWFeET9t0+WlHSY8sQSQ93?=
 =?us-ascii?Q?QHT5i9WhlVJmpMLj8EA0m9MGEaA1ll0ZiQDdbAMizHufZFFLGBXtzKjgk4VH?=
 =?us-ascii?Q?XSbAq6cyeZLvStBZ19g+6m8OPwppBHT7U3fRMOGHL7I7CsrfxqC1ay4kEmPJ?=
 =?us-ascii?Q?ds5Tudce4EgbRcPCdGqVU0Y4j0NhglvDYlJ3ibpCQ3sG3+olV61mZpMM1m6I?=
 =?us-ascii?Q?GGB/dX+p1gDGYTIGo5JxquDAYhOr6FjX4OZ++cxIrhqh/BKkdquRj2fN8qmD?=
 =?us-ascii?Q?RGUHbohRF5W0j8KL+NKfFZ9xY3h0lD+Cr4Nj+xK/3D60FSx57rJ4BL7JaaBZ?=
 =?us-ascii?Q?BJ7wIJm8hGwrP3jqVevVukWNFScUzdxYHtNAgg0aTObw7hxdTBMvxxxQ7UuA?=
 =?us-ascii?Q?kSG3NdzFync1u8cZaUNmr8k1JOkkl6R1LADwoIVALmk9ytFg48D4Ox2wo78O?=
 =?us-ascii?Q?9Rp1EQT6mo3JMxMuIWN6RrCk/hRCL+030Zpvm9UEZ2C8EV7sNi5bvAJHosYA?=
 =?us-ascii?Q?hqMJsCOnqXL6KpCxfjiEJrYUwfFc7+GGMaf5Htfqa2an0m+lY8MKa852NvCU?=
 =?us-ascii?Q?PzfAfhEoUGS+d+kQYQwEHBslgs7gGhDhjqo+7hLw8n+/xO++kI/FB6v/hO5f?=
 =?us-ascii?Q?1ROQBcVVIUits6TyKAD7BtcLBFKpI/E4PJemZvqNUQpLUYPQUMztTpa/eYts?=
 =?us-ascii?Q?p/S2uYr8MrInbJlXcIT433g2g4UCTpXhGOtwc4UAI9KJjRoWzUru2turBfMk?=
 =?us-ascii?Q?OTGH+XmAYCGzWMEF3VxtW/GDq7uQUdZrJ2Lrqx8Va7kwdOm/25zcxUJOHXX6?=
 =?us-ascii?Q?OUJTdM0cyc7LMZuPJdNkOo6TXtar6OxkAJEC7Zwo1EswwbctkTZjRshrnbaT?=
 =?us-ascii?Q?q0w9LcCcuFCToST0NSR7JyJeFC25oiaC9Ua4RhNQOzpfXJ2Nis7f6M6A1p0G?=
 =?us-ascii?Q?Od3eeFj1pvQPPT2sapRfBgWt0+jxf5jafIVxVUAkcgeQ5RDx/xrqXyG8haD0?=
 =?us-ascii?Q?m2EpsSFL4VyZNKgwPS+/n0wV7wQFa3meZFeIiyd/lQ/X0FwZ6/knKbB+kDx+?=
 =?us-ascii?Q?+gztxjCYZ3s35A0TLWLNQsRqjljJbKeZR/XVmu4Rzwu3BvtnocJxD8eTQYH4?=
 =?us-ascii?Q?l0otThid4Fit79DLzw8UrxXkzjeJI2YKJRbrrxfT71O2nTmd12zckvC/Gdnd?=
 =?us-ascii?Q?ZQ1fNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UQVGQmiIcTdiPIgPe1hyVtSTuf/gfGGgf4rdURKISQyOI91cI8UkCa37Faed2kYNQJCxashSe5EHuc65fcn0tJ4I1nm0Dv/Kd+sjCDGjeyuCrRoHiXOHBnEHVjcQzsUSRvpTKR2eitcUYdDWv9LVvVQ60nZX98oI4ujPevBzZF7uoszP4zCS1bLB4lCy+3NBqnNRSwgYyd6/Hsibr2qycackrmQfTZdXgcWPCduzQMpss/+7c8P+K8DrlQlr/kN1QeHDV28T750CM7VmDB+4Zwn38rE9uO5E7sTgRxvDxFh7NKLEEDgQdKpOaOs7eBi01wS6a6uB3XUOCQSyesTwiREC18q89Cbvc6kBzO/epSO3+KjikS1EbVbHZivF49Wp7aj40hOYn22DZmO2IbIcoIFLIEI9VUqfDr/Nr/Oxyt/u5AZSBnQdOAAdogTlfsT1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:38.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41defd8-497b-43ec-205c-08de72a36254
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

From: Jason Gunthorpe <jgg@nvidia.com>

Create a new data structure to hold an array of invalidations that need to
be performed for the domain based on what masters are attached, to replace
the single smmu pointer and linked list of masters in the current design.

Each array entry holds one of the invalidation actions - S1_ASID, S2_VMID,
ATS or their variant with information to feed invalidation commands to HW.
It is structured so that multiple SMMUs can participate in the same array,
removing one key limitation of the current system.

To maximize performance, a sorted array is used as the data structure. It
allows grouping SYNCs together to parallelize invalidations. For instance,
it will group all the ATS entries after the ASID/VMID entry, so they will
all be pushed to the PCI devices in parallel with one SYNC.

To minimize the locking cost on the invalidation fast path (reader of the
invalidation array), the array is managed with RCU.

Provide a set of APIs to add/delete entries to/from an array, which cover
cannot-fail attach cases, e.g. attaching to arm_smmu_blocked_domain. Also
add kunit coverage for those APIs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  97 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 265 ++++++++++++++++++
 3 files changed, 454 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cfbedb76c8baa..ed8820f12ba32 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -648,6 +648,93 @@ struct arm_smmu_cmdq_batch {
 	int				num;
 };
 
+/*
+ * The order here also determines the sequence in which commands are sent to the
+ * command queue. E.g. TLBI must be done before ATC_INV.
+ */
+enum arm_smmu_inv_type {
+	INV_TYPE_S1_ASID,
+	INV_TYPE_S2_VMID,
+	INV_TYPE_S2_VMID_S1_CLEAR,
+	INV_TYPE_ATS,
+	INV_TYPE_ATS_FULL,
+};
+
+struct arm_smmu_inv {
+	struct arm_smmu_device *smmu;
+	u8 type;
+	u8 size_opcode;
+	u8 nsize_opcode;
+	u32 id; /* ASID or VMID or SID */
+	union {
+		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
+		u32 ssid; /* INV_TYPE_ATS */
+	};
+
+	int users; /* users=0 to mark as a trash to be purged */
+};
+
+static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
+{
+	return inv->type == INV_TYPE_ATS || inv->type == INV_TYPE_ATS_FULL;
+}
+
+/**
+ * struct arm_smmu_invs - Per-domain invalidation array
+ * @max_invs: maximum capacity of the flexible array
+ * @num_invs: number of invalidations in the flexible array. May be smaller than
+ *            @max_invs after a tailing trash entry is excluded, but must not be
+ *            greater than @max_invs
+ * @num_trashes: number of trash entries in the array for arm_smmu_invs_purge().
+ *               Must not be greater than @num_invs
+ * @rwlock: optional rwlock to fench ATS operations
+ * @has_ats: flag if the array contains an INV_TYPE_ATS or INV_TYPE_ATS_FULL
+ * @rcu: rcu head for kfree_rcu()
+ * @inv: flexible invalidation array
+ *
+ * The arm_smmu_invs is an RCU data structure. During a ->attach_dev callback,
+ * arm_smmu_invs_merge(), arm_smmu_invs_unref() and arm_smmu_invs_purge() will
+ * be used to allocate a new copy of an old array for addition and deletion in
+ * the old domain's and new domain's invs arrays.
+ *
+ * The arm_smmu_invs_unref() mutates a given array, by internally reducing the
+ * users counts of some given entries. This exists to support a no-fail routine
+ * like attaching to an IOMMU_DOMAIN_BLOCKED. And it could pair with a followup
+ * arm_smmu_invs_purge() call to generate a new clean array.
+ *
+ * Concurrent invalidation thread will push every invalidation described in the
+ * array into the command queue for each invalidation event. It is designed like
+ * this to optimize the invalidation fast path by avoiding locks.
+ *
+ * A domain can be shared across SMMU instances. When an instance gets removed,
+ * it would delete all the entries that belong to that SMMU instance. Then, a
+ * synchronize_rcu() would have to be called to sync the array, to prevent any
+ * concurrent invalidation thread accessing the old array from issuing commands
+ * to the command queue of a removed SMMU instance.
+ */
+struct arm_smmu_invs {
+	size_t max_invs;
+	size_t num_invs;
+	size_t num_trashes;
+	rwlock_t rwlock;
+	bool has_ats;
+	struct rcu_head rcu;
+	struct arm_smmu_inv inv[] __counted_by(max_invs);
+};
+
+static inline struct arm_smmu_invs *arm_smmu_invs_alloc(size_t num_invs)
+{
+	struct arm_smmu_invs *new_invs;
+
+	new_invs = kzalloc(struct_size(new_invs, inv, num_invs), GFP_KERNEL);
+	if (!new_invs)
+		return NULL;
+	new_invs->max_invs = num_invs;
+	new_invs->num_invs = num_invs;
+	rwlock_init(&new_invs->rwlock);
+	return new_invs;
+}
+
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
 	struct iopf_queue		*iopf;
@@ -873,6 +960,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
+	struct arm_smmu_invs __rcu	*invs;
+
 	/* List of struct arm_smmu_master_domain */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
@@ -925,6 +1014,12 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			  struct arm_smmu_master *master, struct mm_struct *mm,
 			  u16 asid);
+
+struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
+					  struct arm_smmu_invs *to_merge);
+void arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			 struct arm_smmu_invs *to_unref);
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs);
 #endif
 
 struct arm_smmu_master_domain {
@@ -958,6 +1053,8 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
+	/* No concurrency with invalidation is possible at this point */
+	kfree(rcu_dereference_protected(smmu_domain->invs, true));
 	kfree(smmu_domain);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 69c9ef441fc1d..7b8035b1db24d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -637,6 +637,97 @@ static void arm_smmu_v3_write_cd_test_sva_release(struct kunit *test)
 						      NUM_EXPECTED_SYNCS(2));
 }
 
+static void arm_smmu_v3_invs_test_verify(struct kunit *test,
+					 struct arm_smmu_invs *invs,
+					 int num_invs, const int num_trashes,
+					 const int *ids, const int *users)
+{
+	KUNIT_EXPECT_EQ(test, invs->num_invs, num_invs);
+	KUNIT_EXPECT_EQ(test, invs->num_trashes, num_trashes);
+	while (num_invs--) {
+		KUNIT_EXPECT_EQ(test, invs->inv[num_invs].id, ids[num_invs]);
+		KUNIT_EXPECT_EQ(test, READ_ONCE(invs->inv[num_invs].users),
+				users[num_invs]);
+	}
+}
+
+static struct arm_smmu_invs invs1 = {
+	.num_invs = 3,
+	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, },
+		 { .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
+		 { .type = INV_TYPE_ATS, .id = 3, }, },
+};
+
+static struct arm_smmu_invs invs2 = {
+	.num_invs = 3,
+	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
+		 { .type = INV_TYPE_ATS, .id = 4, },
+		 { .type = INV_TYPE_ATS, .id = 5, }, },
+};
+
+static struct arm_smmu_invs invs3 = {
+	.num_invs = 3,
+	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
+		 { .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
+		 { .type = INV_TYPE_ATS, .id = 6, }, },
+};
+
+static void arm_smmu_v3_invs_test(struct kunit *test)
+{
+	const int results1[2][3] = { { 1, 1, 3, }, { 1, 1, 1, }, };
+	const int results2[2][5] = { { 1, 1, 3, 4, 5, }, { 2, 1, 1, 1, 1, }, };
+	const int results3[2][3] = { { 1, 1, 3, }, { 1, 1, 1, }, };
+	const int results4[2][5] = { { 1, 1, 3, 5, 6, }, { 2, 1, 1, 1, 1, }, };
+	const int results5[2][5] = { { 1, 1, 3, 5, 6, }, { 1, 0, 0, 1, 1, }, };
+	const int results6[2][3] = { { 1, 5, 6, }, { 1, 1, 1, }, };
+	struct arm_smmu_invs *test_a, *test_b;
+
+	/* New array */
+	test_a = arm_smmu_invs_alloc(0);
+	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
+
+	/* Test1: merge invs1 (new array) */
+	test_b = arm_smmu_invs_merge(test_a, &invs1);
+	kfree(test_a);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results1[0]), 0,
+				     results1[0], results1[1]);
+
+	/* Test2: merge invs2 (new array) */
+	test_a = arm_smmu_invs_merge(test_b, &invs2);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results2[0]), 0,
+				     results2[0], results2[1]);
+
+	/* Test3: unref invs2 (same array) */
+	arm_smmu_invs_unref(test_a, &invs2);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results3[0]), 0,
+				     results3[0], results3[1]);
+
+	/* Test4: merge invs3 (new array) */
+	test_b = arm_smmu_invs_merge(test_a, &invs3);
+	kfree(test_a);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results4[0]), 0,
+				     results4[0], results4[1]);
+
+	/* Test5: unref invs1 (same array) */
+	arm_smmu_invs_unref(test_b, &invs1);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results5[0]), 2,
+				     results5[0], results5[1]);
+
+	/* Test6: purge test_b (new array) */
+	test_a = arm_smmu_invs_purge(test_b);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results6[0]), 0,
+				     results6[0], results6[1]);
+
+	/* Test7: unref invs3 (same array) */
+	arm_smmu_invs_unref(test_a, &invs3);
+	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
+	KUNIT_EXPECT_EQ(test, test_a->num_trashes, 0);
+
+	kfree(test_a);
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
@@ -662,6 +753,7 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
+	KUNIT_CASE(arm_smmu_v3_invs_test),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 375f2143efc1d..f6a423500ce1f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/sort.h>
 #include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
@@ -1026,6 +1027,262 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 */
 }
 
+/* Invalidation array manipulation functions */
+static inline struct arm_smmu_inv *
+arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
+{
+	while (true) {
+		if (next >= invs->num_invs) {
+			*idx = next;
+			return NULL;
+		}
+		if (!READ_ONCE(invs->inv[next].users)) {
+			next++;
+			continue;
+		}
+		*idx = next;
+		return &invs->inv[next];
+	}
+}
+
+/**
+ * arm_smmu_invs_for_each_entry - Iterate over all non-trash entries in invs
+ * @invs: the base invalidation array
+ * @idx: a stack variable of 'size_t', to store the array index
+ * @cur: a stack variable of 'struct arm_smmu_inv *'
+ */
+#define arm_smmu_invs_for_each_entry(invs, idx, cur)                           \
+	for (cur = arm_smmu_invs_iter_next(invs, 0, &(idx)); cur;              \
+	     cur = arm_smmu_invs_iter_next(invs, idx + 1, &(idx)))
+
+static int arm_smmu_inv_cmp(const struct arm_smmu_inv *inv_l,
+			    const struct arm_smmu_inv *inv_r)
+{
+	if (inv_l->smmu != inv_r->smmu)
+		return cmp_int((uintptr_t)inv_l->smmu, (uintptr_t)inv_r->smmu);
+	if (inv_l->type != inv_r->type)
+		return cmp_int(inv_l->type, inv_r->type);
+	return cmp_int(inv_l->id, inv_r->id);
+}
+
+static inline int arm_smmu_invs_iter_next_cmp(struct arm_smmu_invs *invs_l,
+					      size_t next_l, size_t *idx_l,
+					      struct arm_smmu_invs *invs_r,
+					      size_t next_r, size_t *idx_r)
+{
+	struct arm_smmu_inv *cur_l =
+		arm_smmu_invs_iter_next(invs_l, next_l, idx_l);
+
+	/*
+	 * We have to update the idx_r manually, because the invs_r cannot call
+	 * arm_smmu_invs_iter_next() as the invs_r never sets any users counter.
+	 */
+	*idx_r = next_r;
+
+	/*
+	 * Compare of two sorted arrays items. If one side is past the end of
+	 * the array, return the other side to let it run out the iteration.
+	 *
+	 * If the left entry is empty, return 1 to pick the right entry.
+	 * If the right entry is empty, return -1 to pick the left entry.
+	 */
+	if (!cur_l)
+		return 1;
+	if (next_r >= invs_r->num_invs)
+		return -1;
+	return arm_smmu_inv_cmp(cur_l, &invs_r->inv[next_r]);
+}
+
+/**
+ * arm_smmu_invs_for_each_cmp - Iterate over two sorted arrays computing for
+ *                              arm_smmu_invs_merge() or arm_smmu_invs_unref()
+ * @invs_l: the base invalidation array
+ * @idx_l: a stack variable of 'size_t', to store the base array index
+ * @invs_r: the build_invs array as to_merge or to_unref
+ * @idx_r: a stack variable of 'size_t', to store the build_invs index
+ * @cmp: a stack variable of 'int', to store return value (-1, 0, or 1)
+ */
+#define arm_smmu_invs_for_each_cmp(invs_l, idx_l, invs_r, idx_r, cmp)          \
+	for (idx_l = idx_r = 0,                                                \
+	     cmp = arm_smmu_invs_iter_next_cmp(invs_l, 0, &(idx_l),            \
+					       invs_r, 0, &(idx_r));           \
+	     idx_l < invs_l->num_invs || idx_r < invs_r->num_invs;             \
+	     cmp = arm_smmu_invs_iter_next_cmp(                                \
+		     invs_l, idx_l + (cmp <= 0 ? 1 : 0), &(idx_l),             \
+		     invs_r, idx_r + (cmp >= 0 ? 1 : 0), &(idx_r)))
+
+/**
+ * arm_smmu_invs_merge() - Merge @to_merge into @invs and generate a new array
+ * @invs: the base invalidation array
+ * @to_merge: an array of invlidations to merge
+ *
+ * Return: a newly allocated array on success, or ERR_PTR
+ *
+ * This function must be locked and serialized with arm_smmu_invs_unref() and
+ * arm_smmu_invs_purge(), but do not lockdep on any lock for KUNIT test.
+ *
+ * Both @invs and @to_merge must be sorted, to ensure the returned array will be
+ * sorted as well.
+ *
+ * Caller is resposible for freeing the @invs and the returned new one.
+ *
+ * Entries marked as trash will be purged in the returned array.
+ */
+VISIBLE_IF_KUNIT
+struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
+					  struct arm_smmu_invs *to_merge)
+{
+	struct arm_smmu_invs *new_invs;
+	struct arm_smmu_inv *new;
+	size_t num_invs = 0;
+	size_t i, j;
+	int cmp;
+
+	arm_smmu_invs_for_each_cmp(invs, i, to_merge, j, cmp)
+		num_invs++;
+
+	new_invs = arm_smmu_invs_alloc(num_invs);
+	if (!new_invs)
+		return ERR_PTR(-ENOMEM);
+
+	new = new_invs->inv;
+	arm_smmu_invs_for_each_cmp(invs, i, to_merge, j, cmp) {
+		if (cmp < 0) {
+			*new = invs->inv[i];
+		} else if (cmp == 0) {
+			*new = invs->inv[i];
+			WRITE_ONCE(new->users, READ_ONCE(new->users) + 1);
+		} else {
+			*new = to_merge->inv[j];
+			WRITE_ONCE(new->users, 1);
+		}
+
+		/*
+		 * Check that the new array is sorted. This also validates that
+		 * to_merge is sorted.
+		 */
+		if (new != new_invs->inv)
+			WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);
+		if (arm_smmu_inv_is_ats(new))
+			new_invs->has_ats = true;
+		new++;
+	}
+
+	WARN_ON(new != new_invs->inv + new_invs->num_invs);
+
+	return new_invs;
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);
+
+/**
+ * arm_smmu_invs_unref() - Find in @invs for all entries in @to_unref, decrease
+ *                         the user counts without deletions
+ * @invs: the base invalidation array
+ * @to_unref: an array of invlidations to decrease their user counts
+ *
+ * Return: the number of trash entries in the array, for arm_smmu_invs_purge()
+ *
+ * This function will not fail. Any entry with users=0 will be marked as trash,
+ * and caller will be notified about the trashed entry via @to_unref by setting
+ * a users=0.
+ *
+ * All tailing trash entries in the array will be dropped. And the size of the
+ * array will be trimmed properly. All trash entries in-between will remain in
+ * the @invs until being completely deleted by the next arm_smmu_invs_merge()
+ * or an arm_smmu_invs_purge() function call.
+ *
+ * This function must be locked and serialized with arm_smmu_invs_merge() and
+ * arm_smmu_invs_purge(), but do not lockdep on any mutex for KUNIT test.
+ *
+ * Note that the final @invs->num_invs might not reflect the actual number of
+ * invalidations due to trash entries. Any reader should take the read lock to
+ * iterate each entry and check its users counter till the last entry.
+ */
+VISIBLE_IF_KUNIT
+void arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			 struct arm_smmu_invs *to_unref)
+{
+	unsigned long flags;
+	size_t num_invs = 0;
+	size_t i, j;
+	int cmp;
+
+	arm_smmu_invs_for_each_cmp(invs, i, to_unref, j, cmp) {
+		if (cmp < 0) {
+			/* not found in to_unref, leave alone */
+			WRITE_ONCE(to_unref->inv[j].users, 1);
+			num_invs = i + 1;
+		} else if (cmp == 0) {
+			int users = READ_ONCE(invs->inv[i].users) - 1;
+
+			if (WARN_ON(users < 0))
+				continue;
+
+			/* same item */
+			WRITE_ONCE(invs->inv[i].users, users);
+			if (users) {
+				WRITE_ONCE(to_unref->inv[j].users, 1);
+				num_invs = i + 1;
+				continue;
+			}
+
+			/* Notify the caller about the trash entry */
+			WRITE_ONCE(to_unref->inv[j].users, 0);
+			invs->num_trashes++;
+		} else {
+			/* item in to_unref is not in invs or already a trash */
+			WARN_ON(true);
+		}
+	}
+
+	/* Exclude any tailing trash */
+	invs->num_trashes -= invs->num_invs - num_invs;
+
+	/* The lock is required to fence concurrent ATS operations. */
+	write_lock_irqsave(&invs->rwlock, flags);
+	WRITE_ONCE(invs->num_invs, num_invs); /* Remove tailing trash entries */
+	write_unlock_irqrestore(&invs->rwlock, flags);
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
+
+/**
+ * arm_smmu_invs_purge() - Purge all the trash entries in the @invs
+ * @invs: the base invalidation array
+ *
+ * Return: a newly allocated array on success removing all the trash entries, or
+ *         NULL if there is no trash entry in the array or there is a bug
+ *
+ * This function must be locked and serialized with arm_smmu_invs_merge() and
+ * arm_smmu_invs_unref(), but do not lockdep on any lock for KUNIT test.
+ *
+ * Caller is resposible for freeing the @invs and the returned new one.
+ */
+VISIBLE_IF_KUNIT
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
+{
+	struct arm_smmu_invs *new_invs;
+	struct arm_smmu_inv *inv;
+	size_t i, num_invs = 0;
+
+	if (WARN_ON(invs->num_invs < invs->num_trashes))
+		return NULL;
+	if (!invs->num_invs || !invs->num_trashes)
+		return NULL;
+
+	new_invs = arm_smmu_invs_alloc(invs->num_invs - invs->num_trashes);
+	if (!new_invs)
+		return ERR_PTR(-ENOMEM);
+
+	arm_smmu_invs_for_each_entry(invs, i, inv) {
+		new_invs->inv[num_invs] = *inv;
+		num_invs++;
+	}
+
+	WARN_ON(num_invs != new_invs->num_invs);
+	return new_invs;
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
+
 /* Context descriptor manipulation functions */
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
@@ -2529,13 +2786,21 @@ static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
 struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_invs *new_invs;
 
 	smmu_domain = kzalloc_obj(*smmu_domain);
 	if (!smmu_domain)
 		return ERR_PTR(-ENOMEM);
 
+	new_invs = arm_smmu_invs_alloc(0);
+	if (!new_invs) {
+		kfree(smmu_domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
+	rcu_assign_pointer(smmu_domain->invs, new_invs);
 
 	return smmu_domain;
 }
-- 
2.43.0

