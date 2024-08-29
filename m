Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C11B86DD
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954885; cv=fail; b=Vk3NWgOAelRB4CFViPcA4VbzWzEbAtxQ1eklWth7OdMbTAW+k0d1eWI0luMbR0F0KKKjoz5vBYtcwF5VxOT5N7ZpOTrOGBlqevNlF9R0xa8fxk69qOcmJnxmqDzM5CCbNmEA9HSmyISJuPt9bKpTLOd9MQWrzJ6WN9Ix9yUL3og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954885; c=relaxed/simple;
	bh=fWq3gGmcx1BX+5IqA98W0Nq/OgGik+GG971UkTZDkKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=im7LBBHpyz2+CPqeLZiqQaO5slhAnJkJEUxv4fQeqItFAg11+D6rua8ghrjmVQFCycnkN2jcmXpza0EnpFaEzv6DrDdJ9AfeOwaU6wKDhL4Pr22XaXgYTx4qpF73LmAPRRfW2LTmkZjPIESecPf/NWvSuvas2VSO0CRHw2jj56c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DvXtVEru; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DvXtVEru"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu/5ESs3iY40JKyyn0AlqWPZaHAenrOIsjGsBVV3/fDOiOKULmV+wSKvTXthcVxyGDJ42QVlY+qYVKyPFhGdd1Z2Jdf70ibcy3AXyCc+j3ECUQsjp0CWifsBU3YU9IflV938omBdNM19BC15DZc4KM3joXCZh4z0Ate5wjLFsuJFgEWoRc+WubjQ09po9Z44zK1urN4kf8syDCR6zfeFlpw1JmWkZcaEHMzy+2RgkptXvgeslYq4dYf7e/qa8Oimo9G1+TyBa4nJ1nlsebTUceXmmg4RVW10Lg7mWGN+Hfq6/Gu++vq2bRamRevCbLI7ZkDaM686h/PaBDwTbl17Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhHDd1yq1VCf8e6g7J3I4Zx8YmU7VedfgD+exBwfNco=;
 b=gWhxQMt3PdGudvPMRpgu1C60Ctq7XucXCZa+D12e2MwsjN0rjRmhtWBf0RV9eh8hu5fCQX3ebz5LVhlf4LZHIWWNieHVna588giS54oDAovibJ6mwevCuaZvIY3mCCD+3ZvE1NlKuxSWDFZ6jVaiCu+z7C4MJm3HdzphUdPlfSrZBHtBP/BFm5YR/4RFg2GidzL+YZMuov8vGyQYXq0c1oI9grfS4tcuVShzrvw0fuA7bUzz4PdW2XrDDt1lFiPBzvHDNylYOuL+TAdCPM9GWB5F831IdD5aUHLSwwMpefTiEUQIXtS8FDyTm02SEeDHWkcn7ZUdaze1h5viDqBdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhHDd1yq1VCf8e6g7J3I4Zx8YmU7VedfgD+exBwfNco=;
 b=DvXtVEruemqTvkRxvjNs2R9H0rOkdxYXWdNlXdX0kdz/yoAZ0q8wb3ckY71/HxTrcJ/ArmXsUberFHZG8pthqs1Qt71WmiBekHgh20PhXkakkzyI0ZOeMWqwrHUL9gbr3KQomtEe6szyc0eZBuPKslXlgFgC0cVuY+v08Baivxo=
Received: from SA9PR13CA0080.namprd13.prod.outlook.com (2603:10b6:806:23::25)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 18:08:01 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::a7) by SA9PR13CA0080.outlook.office365.com
 (2603:10b6:806:23::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 18:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 18:08:00 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 13:07:56 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/5] iommu/amd: Introduce rw_semaphore for Device Table Entry (DTE)
Date: Thu, 29 Aug 2024 18:07:23 +0000
Message-ID: <20240829180726.5022-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 64789a6d-379a-412f-a0ff-08dcc8558517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oGbYW4LIfYQbpx574U0Uio9Qsn5I0cyOTT9bB1iUDf+aJpvOS1oh3EX32wVB?=
 =?us-ascii?Q?r+/I8Q0B7MVKc0TjwkEomrDuPeM2t3EXwV36sibtIYnfyfKmTK+gmbdx6W78?=
 =?us-ascii?Q?+Mcr9/etcaPazv9wb7nebeTFrsJRgjShAdSAljHMbrB4G1BWq7+3NJsDUCyW?=
 =?us-ascii?Q?70RGdoTbL4Mu3ULl4YGYKHTHqIqAioB3dbhGsBESWs/OBtB5H+FvMjuYshnv?=
 =?us-ascii?Q?mvtqZXQ9MAPa54385VsyZE0I0yM9nSIGEOA8wsePfmrAkuUR0ysjEVSYkPmj?=
 =?us-ascii?Q?Ee9XsNYdrXfdI1zD4K5QSx74tX1pvBzqR3e1EAG5QJAEab8Nnnnomaj1EeKE?=
 =?us-ascii?Q?nOcgHxYNtZL0Sb3Lxnq99rbSjYLgMHLJdvc+1At8rtdZSCP/hcciU9S4ZfYa?=
 =?us-ascii?Q?ZVyKFTDwNU+Ku3yzTibpph7Sv19SiWtHBXCnTZ4oN76Q/BCl0+eZuf5is+Wb?=
 =?us-ascii?Q?++JWdpRzZe/RDlU2Ih/LBVA5qliBU9+onKTaRPYJQM4cFfqG7lwH0x2SBud4?=
 =?us-ascii?Q?Ez5nOBvTDtU9gmbKLEIejI/Su23WimqoysmiT3UEnQxFZ3HtzHOu+JwPAxQd?=
 =?us-ascii?Q?/R6712t2t04d559sfBEIHwFxjqsz6CZqFiBkPMXVsaLu6M/KpQ188WaDvD+q?=
 =?us-ascii?Q?KmnSlhaiSZrrBsOluZcSTBmzR5OhDcN1k03GtZ8fTs7OCqq43Nuh7KjwwLCQ?=
 =?us-ascii?Q?QuZ/f/BuBc5SFycDQa6LvhsZAP5HRSTBWv1beb6S7beEqQdLaP/eghFVPePz?=
 =?us-ascii?Q?ArDCuVfj0SvfYYQ9bI+ldKNK3QsTby70jHqn+3CYpO4bziUZebGrkHyuObcZ?=
 =?us-ascii?Q?MKsPcX7byGMebYVCvQywWLkYw7wPVJgSSv3xwNbcW9+M5Ws81RvPGJ3XDF/s?=
 =?us-ascii?Q?R0c3zO+9Ll4sESdjKygXgAKnOdWtQfSoi2gI8nMOuMbgksoBz513vsCBBRT9?=
 =?us-ascii?Q?jer644HNdIPoCq/4DzeyUCXmNPPx3fRaVenpQdZilCLhyD26UpC4VactMeBC?=
 =?us-ascii?Q?x+PYKogtyQYygCqCGKpt3tKJ+ZGGHF/6PHWiGfWL5GiXxvnWd+VGFxGMV+aa?=
 =?us-ascii?Q?FIv3nle72Kq6/Lrws2Fnsh7jCTy5J2Jvvca2szEmJCz9iyfko0L7UoMfNkXM?=
 =?us-ascii?Q?oH9F7Oepsx9CAnrThJNaGB+hO+9erNfpikh2FIAZ3HVkiw50H8DQfH0J1S5n?=
 =?us-ascii?Q?1RilSYJdRGJQvV7WiLozJTnfhkoTzRl4nwdgdUL1l/Y44I4l6UlOLZnxtsSi?=
 =?us-ascii?Q?uDJv1PwNqlzNrOYLMJzmC5H0VR54mm6RguVJDwoSUINk7VbzgcSq1jFmgVX6?=
 =?us-ascii?Q?kPIhn+y+9gNopiHuAGZS820BEO9ypQEc4HjkugMzI8m4iWqXR9RFmUqvShP4?=
 =?us-ascii?Q?Bn0BIQdkU2bJZZ3lZ6A0+BQns4dUnJm73VqwSAuUFEvqqy7enETqVyl23s/P?=
 =?us-ascii?Q?GLftMBxmKAAabYce2q0VtXRPmVTc9pCr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:08:00.9055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64789a6d-379a-412f-a0ff-08dcc8558517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

In preparation for 256-bit DTE update, each DTE access/update needs
to be protected using synchronication mechanism to prevent conflict.

Introduce a new rw-semaphore struct dev_data.dte_sem, which is per
device. Also update certain helper functions to use the new dte_sem.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c9f9a598eb82..65f3a073999d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -833,6 +833,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	spinlock_t lock;
+	struct rw_semaphore dte_sem;
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 87c5385ce3f2..994ed02842b9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -205,6 +205,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	spin_lock_init(&dev_data->lock);
+	init_rwsem(&dev_data->dte_sem);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1946,10 +1947,13 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
+	u16 devid = dev_data->devid;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
+	down_write(&dev_data->dte_sem);
+
 	/* remove entry from the device table seen by the hardware */
 	dev_table[devid].data[0]  = DTE_FLAG_V;
 
@@ -1959,6 +1963,8 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(iommu, devid);
+
+	up_write(&dev_data->dte_sem);
 }
 
 /* Update and flush DTE for the given device */
@@ -1969,7 +1975,7 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

