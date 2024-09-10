Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C5179953
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951548; cv=fail; b=qmjq43I7guFO3qrmZkPFc/iYsGIdXS/mW5h8yibI2LQEwJ1CIrpQEBm9PNSNzPi6ibiWus5OZlDUo1A/oRvfYA3WIoIqIkxcF7+u9J2YvrPd0a1zujyte6DUhVIv4IVG5CydVjwsFCvNKIO5aqRLiSj3odahjEbVWrJXqiPsHbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951548; c=relaxed/simple;
	bh=X7Gr8pXMutVkoyR57MDosYw/CcQGpd2bhcjSBuBYPVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKeBWAScDit1DgWz09JfOmHBULAFpW/cjZ2r+XbZpDFnYol5cS2IWBGUHN5xV0F7xEpoyZXOjV/h16w+f9w+gtLzZ8o+s4VxGDuzkQYjKfsmllC0S4gWmRPxtTl5of9yG2GESmFCiJyHK7AWN+16M9M8S7krOLgnEvOjc4Fszn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NkYVDquz; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NkYVDquz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3PLkYjONoR+goPn6ZwypyTO9tuKC2ac89+8OSzZQ6bADzKYi8u0ezzpy0qccdR9Q97LXKGjvysAiA8UiXM7TOJrQYo9jtqZz/zdzfhPFQfNVRqAZNdquC4ig8SRoIzl4eHG9tgnrRWVMvlnKBuqqoyDgSa/clVN4Qzlq6cvU7Wd4cVORKkZ7fyftEzHHnAa5cNTsmu6Uljq26kPT+SrfKlZZ93tobTvBPtJCq6ZX+X08nOjSve1F8rWBJTUyp/rfamCDERlbSApEF1GA/HeE2l2M6YqtQD/2cG1G9c9JXpgKsLNxCWYZ7LE6Bd819FsY+c9d5iUKH7TIhLGVEZ82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I08/rnNi+g5phU0AJEAxJfkpTLSPnw6ozGf+sXa5ayc=;
 b=eydvxzLTMEi46+m9/sXRfs4B2c33p0FHlWruOoDJkmIvTRDVTZ/1EtkWpoaCRA5emUWjG7xNx+sOJgsmJ7w+5ONnsHdvwcyheYnJ7cfpnnmurmlWwX78WcahI7GZmsZbqtScotvGTX81kRMcWOg68dkdNbQNfsXVMElYi1DUuDTV+jYEvTfEyXCNI66ghTlp3XKcNOBOSSzCzq6rqBilbjRDoaVuF1bnvxANBcJnzzVx+qWU4Zm3zEPbafLvfx5oeXSXzD2cI/oAmMymTgYgfbzM9t4MOv5B4Bc414A2bDcj6bWSQlkBx+9yiGX+tpEpS9u4CNjS3JsJ7u80nWkTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I08/rnNi+g5phU0AJEAxJfkpTLSPnw6ozGf+sXa5ayc=;
 b=NkYVDquztx+pUgAb+00wPKGVAHKbPDvOexPOcXws+H19Gr/FpnawN8Gzex0IF512wlu8IqlSkji3WM/FGZvVL8h/sIVn0f9wGk0MWjs+LJZos7Q++FxPJz3z7ZS2GuoWtep+J8QRIk6hUsfPk+lbjy7gEfs36/4fIm6oOja384U=
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:59:03 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ab) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 06:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 06:59:02 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 01:58:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 02/10] iommu/amd: Remove protection_domain.dev_cnt variable
Date: Tue, 10 Sep 2024 06:58:04 +0000
Message-ID: <20240910065812.6091-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c15718-41ee-4cfb-a903-08dcd1660dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIvepmBu4+RrXDw3CXMPdbg95FwmFcxj3GiNfVjMn+opslPfD2DcXVDwx86j?=
 =?us-ascii?Q?Ho57HDglxcKjqQfEmFtNel77vpnhbDx/Bjm469Vztkhis9Wt72decmW5PeyY?=
 =?us-ascii?Q?KBeaACffW7smFof33B2kYHOi2rV0TcmeJ/Xsdino08Hgi/Hq28iMMVs+C0Yr?=
 =?us-ascii?Q?qIrB0VkHLl/ZNSOVSBsqG/sJA4oGvJM8aFDpnmktOtEI38GEmJWTSvCB71j8?=
 =?us-ascii?Q?b5+Pc0YKNOrC+RpzOqmyJ8ApWtqeN+R639fodKsUpuJUWjv0MR6UpDftNhhK?=
 =?us-ascii?Q?6IcpVyud4rC1eaRgnrfA2cjF8iXl3bdOkuuDypOZGT8t0Ef0gQYVhs4OZaIF?=
 =?us-ascii?Q?7yFlgedOB5uIud4506iz7hcLgFUX3icLCK4gxFx3DvR2uIlM2HfihXdoUYVc?=
 =?us-ascii?Q?fdlyTFrbdEKQ3mZ8i0f/QgQyEijWgyw8jM9DzGzlp+X1okfOHiZtdY/66X8C?=
 =?us-ascii?Q?/cjvmimeYUCHezhz4uzvzq8k2VT+xvoI/Zg26vxpoBntomz1uJvPj4Ruw5g2?=
 =?us-ascii?Q?+a0K3PN87QO+CyYnKgt5wtPmhbFbiW2xW6AniV7I42jgE03ZSxzAEQ50XSvi?=
 =?us-ascii?Q?I9WcRZ9xskBjWyf2R3s7vP5yVJOuqquIDIXzn3e2w/ZUxdM2wA0ylPxU0xtX?=
 =?us-ascii?Q?wn4VAN+eD93zwyCr7AluEDR7H+PALJB8DhzqK4U0ZnabVOH+mUyTOuZFfoUf?=
 =?us-ascii?Q?L9SiSZ/NY08ZJPyFE3LFsVEd/+aSQHEnlbK3BFcNmsqjPjwXCb8dXSDjqCHy?=
 =?us-ascii?Q?ppZlJ2CfMY+frsamBsNJ5OH1Fw0F86qNuZ3Nhh0KZa4pjhMmK8Rk/51OCTrI?=
 =?us-ascii?Q?5IDSNILC8XCp8wXzIc6qBtCyY0iTnwqCWrZcFihGnKDbgxzT3g/yVeyInn8B?=
 =?us-ascii?Q?0NZEWfkoADzeKyCgrJ+uvkQwr7CFkhyol0P1YaLC6OS7qWrM/leU+j6MPxB8?=
 =?us-ascii?Q?bzqaGU+Ls07g4jDydWB/pY/VTQm14e5p1NcLs8gmBuFhbvbE6pt2HkYtanoZ?=
 =?us-ascii?Q?nySyCCv//2J/UGuxDt5oaHeFNpMbNJlv3PZCiPyg4D4H1WiX7IFRSs9gtFqD?=
 =?us-ascii?Q?dhi0mh7YBffl+WHj1/kCUmRD9l87Q4dexf+koFihEh0nmjSpPe0ffqw4tuVw?=
 =?us-ascii?Q?W0jyt5Ms2Q5IxfA2YFUwpdI+x+Tz52hqgJym+UqhkeEI297SjlPEpaLv7bh3?=
 =?us-ascii?Q?vN3E3IzOmLcN5OJNb6Fe2YvC1+VpEhEtP4VCZLh8glw11DCecke/aEjGX/Wv?=
 =?us-ascii?Q?08dzFlJhKGSlTTQBwu9CkIFHcOjpFkLMhAjv/hS3Z4oMN0Bx50T9YNPWMS9h?=
 =?us-ascii?Q?XNqO+wC+WtMNb2mW4hH9Yws2UQhuAzzgKyQqIpO3pMYFfWi4hnFBeI1QpPbW?=
 =?us-ascii?Q?r15mie1mK8YfQ08tCWsmGd2C+k45KNNi0e6x30RJpwMdXbf+g/MWAIfCV5iB?=
 =?us-ascii?Q?gfinfcZTJ/QxhnBQWX745ThGD6IHX9F7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:59:02.6389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c15718-41ee-4cfb-a903-08dcd1660dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

protection_domain->dev_list tracks list of attached devices to
domain. We can use list_* functions on dev_list to get device count.
Hence remove 'dev_cnt' variable.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 drivers/iommu/amd/iommu.c           | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d32a86434de3..418c14aa4ec9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -578,7 +578,6 @@ struct protection_domain {
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fc1969011ff9..d870aeb654a7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2033,7 +2033,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
-	domain->dev_cnt                 += 1;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
@@ -2066,7 +2065,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
-	domain->dev_cnt                 -= 1;
 }
 
 /*
@@ -2239,16 +2237,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
 	lockdep_assert_held(&domain->lock);
 
-	if (!domain->dev_cnt)
-		return;
-
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-	WARN_ON(domain->dev_cnt != 0);
+	WARN_ON(!list_empty(&domain->dev_list));
 }
 
 void protection_domain_free(struct protection_domain *domain)
-- 
2.31.1

