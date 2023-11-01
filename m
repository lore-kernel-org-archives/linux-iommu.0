Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5F1CA81
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qJ62Bwos"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC5CmygunVBFighq6MKv2Td71CcbN2p1bud5rQhAuJWo+48ZP3H0HmWkM6tQKUWdhszOsL7ZrPTUrdB0rjDaztWsxcrzDIghOjCV6TOy0tqTfLKw7UVoSepjsm3/ncaDhjKy/5hsaJsV5SpIoLc+5zHhrWavDWeWojwYdIKYFGtWDlVDLdPPE3/1Mr0NW1ImK8+Bnqs3aJr1lgHy7Vn/kzhDlS0HPVPbcWOi0UbBkC1IAuMXA4bA1d1pkcLf/e8ysHet/++yEBGZMHc4Dv0997OIF85mvVF39RYNDkxLSb88WMKyp2gI8b7dbDXZitiCQjoLjhGtXAZfWtZ0tkHwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAROnw1Ms6tjK3l/yhCdIeSefffCoQAZEexrXSu4jWE=;
 b=mqNmJGyHce7yd5eY1o2974sNoNRpWVnh2il1goPyMoeAp7bEvyo0td6bonBE0qLfv+Mr5Naf6n00MN/OGfCLxwI/wFFEiYK5XYovNX00TyinzaiyT1YIKiU7nzUzKesv5gfbNUHJ1NGVqOX2dqi3130/R7HUQZu47VTIuJHHU03KoUYqwxWsninCtiLLSr640DEm49cnm90lSfae228F54GvFKKAoptA9q81uUD/O8Om/Z2ZojNJbtQKO5HGT6gwsHpmaE5B5vt3SBSLNDRyjK8SlU8mflSrCGXqzO+QOjGqDZrEqPKwRZ4J/zWQJdQZDYFEaETkh/GCHgJcLCoA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAROnw1Ms6tjK3l/yhCdIeSefffCoQAZEexrXSu4jWE=;
 b=qJ62Bwos4fzaFP65LvyI6C/rwUqMD68PbYeq4DHo1Eyy9nd5WUcufizCD0L9IWqYW7gEuEAJsni1JIVljhPLvVQUDi/3lfTgqPK05nD+w+Wg9aHFn1amwLBWR8LAQeCpCFx6/4HMQetOxU/eTHn1N6qVtJmAm4RTB/58bDE1uXuQJDiCEHY/8by75fq4YKoNKStRZ3XpRKWpV2JPOhOL5RtXXXtTmFkgzBIKnq+XTXIByx6h60eFEODwFVKjofUvA+gKjl5KBPcJy9+mRwkiG23Bgod/xnHFuyuBFa8cftzSh4Vv60ZCTifDLWxeiZ/ytTPK1W3m620CLqoKLfVMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 17/27] iommu/arm-smmu-v3: Thread SSID through the arm_smmu_attach_*() interface
Date: Wed,  1 Nov 2023 20:36:35 -0300
Message-ID: <17-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0265.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 98031a4e-52ea-442e-036b-08dbdb336a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmS18KKdjALN61WHISRfmoF2PHNJl/1mh/1NgJaYWH/IxOTQ9qLUCFjilqq6dbSDQdsFFYrp6Ymyjo5niG4RD0pgaa6oTH0BvBP4SegEFxWUHk4HW1tSEkdG/BXZkEldTP33mqzMj3UoTBJQrUirQyPQLq0Xekwowh6VOkNsSok3hTHGgJx3P8DGQDulWIKYPZw4bu7MlmQAaHYVOhoGrTjTyW66L9hdpdaKLAVFZ1vQBpv64GcNUQjLGx3UzYzg2iPK9IIIuQ3p2bnXnCMrr9781J6kI7PUXO0MNSBs/Gy2iuK3jlGLshNxMV+lFM8E8v8ltk/Ac3BEKdyuwwEQlm7XjgkZT//6/H6C+ZA3SASsjAAxKEkliElOGxbvQ3Hsj7/MsPRW0DZqfufEc6LUZzuiNo1rmr8MHEsONtuHT6GaAL0fWBKBNlUo3zSeSH8a4z8cpiZnDNEL2kYgnc6x7TWVV3+omU8gudCLGzjR1iSsvV0CMIjnW6HLykP7KiCcBnl34eKISFMejI22nj6LQAmJ9MzIrAavFrFYwnr5PGLQnroWo7EqsxQmhL8hgEjM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DRie91kSlrUiLtPgwwnw48wO4FP4a3O+yMA4/O85Sr7LzdxZgq0PH0xsRCHX?=
 =?us-ascii?Q?XolPFCV2XaGeWa8znGVPpZ+tz4DxA7plnBY4ld8xMrZ2BxpsVbGf5k4sRs/c?=
 =?us-ascii?Q?FmuKt/FiXLALkHfCOEO/KovjcFyFJZi1TjyfUXCHp/qDUv+lHSqgJOThFB7h?=
 =?us-ascii?Q?knZy03CQZsVJCmj5i2GN4B1SuHdnuYgnYkJS8E1thfdvvJCRKeDLDpYI1PkZ?=
 =?us-ascii?Q?FmGzqhgtK2oKiRNGoyLzFH6GKjKrSmaGmT/ZwCBAEwgolTAYgvAgBVA4OiSX?=
 =?us-ascii?Q?4s406ilERJVYpVk98BIWhRI2OJgIxkjRQ+dfigvbDBBhMHj+gnNI2Id2qFtU?=
 =?us-ascii?Q?+ZX7EW1yhsBfFdRZyk5kiULBeNzLHgSSo9btb/cbeWqj9e9GzEv8To/Ynv+Z?=
 =?us-ascii?Q?1b49YXnWeEmrxsAjI9RVAfcHLJTMUbyjJdZGdVgf8IBEDio/tv5NwQCI7OZe?=
 =?us-ascii?Q?jalGCAOvcIkDDLCAJMYv3n2jaXQd+mj6eWZwU+ivnH5G3XDI7z+OzYDMUlqh?=
 =?us-ascii?Q?j3etFtWyqnRLtz56dN6TUNPeQ67X632WPWTb2CH2gLgYsP1UMBzfIUjS201W?=
 =?us-ascii?Q?mSqtK5YOGIKPQARw+/eCyvA5Dz28p05GPW/W9bdtAqX4dF85WLdrv/hBOyd2?=
 =?us-ascii?Q?WK3R2hrWJax5rHTFXSNPmqVqijg4BVaQNUi0lyvhEHJqw/Eg+JmtYTvRIbK5?=
 =?us-ascii?Q?+Niqpuj4EuX4vbG2k1poGNxG2idEAswkXxNJaV5rT/OqO3IjvQnoXzBCDE1r?=
 =?us-ascii?Q?2LUIwt8NJGOZ6W3f6Tm282FAUHHBMW86xFABtU8rpL4QS3aknfdejlr4HZvD?=
 =?us-ascii?Q?m9rG9k1UlIMdsMuj5eqTkKPx5DE0VNYUIpxnBZAqgnnK1av7i4iHh4b/esfW?=
 =?us-ascii?Q?UYBBUThUDz+ow9cnWsWKGyjc7Vpnetbe0adTXIvGqJAb1PoogM+CcMzEQcnS?=
 =?us-ascii?Q?kExwfpFmo6letw/Bx55P0NUPK350uwntZftMa6J1iiawS+sB6JGwoW4BHDOZ?=
 =?us-ascii?Q?u6XgNO96bIM9HCC+0g5oXUFIixpyuTvzdVoYsVREjLwQTTnhEEubfFpFlW5L?=
 =?us-ascii?Q?nVJjPj09ZVZXo0S1uKy7aIulQEAI63r9HqrjAqnRGuj0U04NxvawrFNG50Fj?=
 =?us-ascii?Q?RaO6NwddQGD/vemHuICCmXitVXkjePgR1+cceH0mjExdDdv3xDlbLyAewUoa?=
 =?us-ascii?Q?r3KAl0nwQLhQZDUviDD0zCaYlfefBZpu9Hk6uemhZJq6uE3cN/pHjQFJnr4c?=
 =?us-ascii?Q?ufvufBqeqxvwnP5Su0mwppEkDnMSlmvPMySyQ4DhzGS+pC5W9rK6L+vqsAuc?=
 =?us-ascii?Q?3bIEb74HEDnQe68igfJ8sAoaCBlZSkinw5qRrSvC6eyKx05+80uoRk1TK6ST?=
 =?us-ascii?Q?CYMnCK+G0NiSMCzA+4O6MJNkd4qdt6FFpqpnCwAj5y0cmx6i+O+j3VnGFGRk?=
 =?us-ascii?Q?62esw2Dr2F+J1c7D3upK0ja29AUCbYMrjbJM6FqMSme5nYCrEeC0QV50T7kz?=
 =?us-ascii?Q?NrdO7RGPJEVIB0O4/qoia5KIotE9uue1whoFhUW+CXdXn6nVu0guX/pa43H3?=
 =?us-ascii?Q?gF+qI1ycDZ/r7BVViousKLEXloCFWKxVoRVPcop8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98031a4e-52ea-442e-036b-08dbdb336a32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmGM++Al5/rYpwKfxG3JsCvJXWYRcOI+p5ywYU8Ij2pSXgAGXrLID3xSSpqcBate
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

Allow creating and managing arm_smmu_mater_domain's with a non-zero SSID
through the arm_smmu_attach_*() family of functions. This triggers ATC
invalidation for the correct SSID in PASID cases and tracks the
per-attachment SSID in the struct arm_smmu_master_domain.

Generalize arm_smmu_attach_remove() to be able to remove SSID's as well by
ensuring the ATC for the PASID is flushed properly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 ++++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 877bb8d69c0902..d9174d609659d2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1962,13 +1962,14 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
+				   ioasid_t ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
-	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
@@ -2452,7 +2453,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	/*
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
@@ -2523,7 +2524,8 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 }
 
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
-					  struct arm_smmu_domain *smmu_domain)
+					  struct arm_smmu_domain *smmu_domain,
+					  ioasid_t ssid)
 {
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
@@ -2533,8 +2535,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 		return;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master,
-						    IOMMU_NO_PASID);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
@@ -2554,7 +2555,7 @@ struct attach_state {
  */
 static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 				   struct arm_smmu_domain *smmu_domain,
-				   struct attach_state *state)
+				   ioasid_t ssid, struct attach_state *state)
 {
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
@@ -2570,6 +2571,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	if (!master_domain)
 		return -ENOMEM;
 	master_domain->master = master;
+	master_domain->ssid = ssid;
 
 	state->want_ats = arm_smmu_ats_supported(master);
 
@@ -2600,7 +2602,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
  * smmu_domain->devices list.
  */
 static void arm_smmu_attach_commit(struct arm_smmu_master *master,
-				   struct attach_state *state)
+				   ioasid_t ssid, struct attach_state *state)
 {
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
@@ -2615,12 +2617,13 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
 		 * SMMU is translating for the new domain and both the old&new
 		 * domain will issue invalidations.
 		 */
-		arm_smmu_atc_inv_master(master);
+		arm_smmu_atc_inv_master(master, ssid);
 	}
 
 	arm_smmu_remove_master_domain(
 		master,
-		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)));
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)),
+		ssid);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2666,7 +2669,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&arm_smmu_asid_lock);
 
-	ret = arm_smmu_attach_prepare(master, smmu_domain, &state);
+	ret = arm_smmu_attach_prepare(master, smmu_domain, IOMMU_NO_PASID,
+				      &state);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
 		return ret;
@@ -2692,7 +2696,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		break;
 	}
 
-	arm_smmu_attach_commit(master, &state);
+	arm_smmu_attach_commit(master, IOMMU_NO_PASID, &state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
@@ -2757,8 +2761,9 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 
 	if (old_domain) {
 		if (master->ats_enabled)
-			arm_smmu_atc_inv_master(master);
-		arm_smmu_remove_master_domain(master, old_domain);
+			arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
+		arm_smmu_remove_master_domain(master, old_domain,
+					      IOMMU_NO_PASID);
 	}
 
 	master->ats_enabled = false;
-- 
2.42.0

