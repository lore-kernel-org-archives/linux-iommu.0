Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDE810
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPiP5vU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKXvG+zJQIbBtLoPpSyzurKqiBhMU4knmkLBYaGhRRELp2umFAZhV3oAeVAov3bDQ1rTvBWRsRILVUXwDMl/Qzvg+P9oJlK9r+FCYpV5dluKCIkXVG/08qFFF6bPmbpSh9RCt2sl7ncU7q0CSPGRyZNqi7pyLwo1y383SUJMzimZUMzQyGS7Ympy1sWxqhGvnXTMXwq3+6zEHCU2gYCFNATEgtUHaR6Zcz1XVg6TWeCcVaKlzlV9DP9zSIUdTyYqqyFiz7DOARqZFqPtR5QvBi3g10s1TRHmMtw8xQ7MiTScUQdxXolQPXxCFzs1XAzLaRa2WfNckEiEkLqQIQZ5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzBBVX8IHARBG8hBgQt1hEfFdqAZcBYE3S0tB2lOj/o=;
 b=nj7SObyWIH0t1AsAo7ReSYe9etlrlf1vph4SZCcKTQdpLqQEKwE0UCoqYSWeHgSTvQU5yvXFmekCRiHHHwKczKgFt1OhPm/urZkP7Ltpl5cvMeN88aOgyWaMY7a+PGfdecfV9Mblun7K3LLm7aYYRbmhIbvM/1Slogwj/WSIhRv9ThBuP/EOYiU1BVrwjCt6m06YZoMrH8ABRy3YtpWP4Et93EMs3uySkfasxyBjKAaBgeSNmHpv4E72MJZYcgKf0e1Lojycg1wlixd/yHLJ5cs/n033ob30ZhVxa20dxIZWbSUA4yd8buscAEH6hSBEq7Neo3FCZuE3d5SnhfTTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzBBVX8IHARBG8hBgQt1hEfFdqAZcBYE3S0tB2lOj/o=;
 b=OPiP5vU2I0De/8rE39aZoQPbw7AoVB/LN6WxQST/HHP6Es2jMVJjKfOVKz27kx/GZGdrpzGRwMYImwg56ke0GtYrVPGxwg4xo1RcoY46BcWDWDf/e9wgHYX20oVSdqSY0Pom5hvdWK+qZxNEGfhTFk2qvhVwOnPK4kQp3vEcjGRwGunWG0YPeNmP7d0cTXxtYKX1A7lstqOt+R7EOB7ibf3X+iFsxJpVapmtrqE3MfPmejQBE/6H9/rA3arcvv3jnkVzdeND/+lMSipLjU49UeWC6MRlO6b34h+YcAyA8sDNPLF131U84Dxg22JivVYhPk6YqUzSIJ1zBZZ84dW4XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 14/19] iommu/arm-smmu-v3: Remove arm_smmu_master->domain
Date: Tue, 10 Oct 2023 21:33:20 -0300
Message-ID: <14-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: c07fc13a-a795-437c-e3a6-08dbc9f1af64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cJ65mWdneSl1nCJ3EEhZDuxsvkkNkBGscScvitjyT2NQuvz0gMiUtTeq8nKoNKLDBDO33Ml10L+aaIh+MGCv9+ptLoi2VBqRCcxpZbJSMwOboFJxUo2YteAIsKsF/pHL5Y3cLjy28Wp/n7T+3Sbq2HryCmN/EPgCW14Se8eXtQi1U9frMRmbKGLDMxdf6SpbVxNdJAJ3n6nGHJFhhbMvTE/Sv8NdZMwx0a8LbvN3gt2QPiJ+KmdsxMSA7EybvK+oQXfk1NCLhUi9SYgWtZn0hShg1Wug8hQ+Y6pWshbME2nyFEBy/VlhAkp7pWbCJCejFu1+Aj3iPglUfRZmKb7V3mhKAdBxgNJbc94yYHKfGWrXM/L/FM/0nmok+LDnuC0K5YLOyZCsnrUud9GgeNRBXrrV1UgGLC/pf04Hmm4rUd5ov5dnJmYXyCqhAQU7UAKF5NnWSgWuA7BlQ/wXGqhCJS26mrWpyT7ppNzk1WbVzcKmBRzoxs9ZcBj9gOssxkEolpqOGaZIHnWmBMMDi+SHp98cJ4BbFQ99Rd7wtjj5eb7GSbK/r7HCOAYi1pylzpNw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y0jw59FIuEd0cLuQJ30GK1bJBcqJpFURpYtmh/metOsmQyph49dqbZLCOW33?=
 =?us-ascii?Q?Ssn5JnaWYClGBXKzElhYUz3gMTkAaePDyxENCrk33MZXpPI9hZuM5i81wWkD?=
 =?us-ascii?Q?o4SmHxpYOkDCVhvG6bgn43ZntM5nvu6XOP7ALd/Gtki3lkdczonrJ437mfQk?=
 =?us-ascii?Q?GMZix0DW+PW3xc2IRM+aHXLn/y2Fwg767AndSnE6s6ou8rVMKWrSCZ6VYBdV?=
 =?us-ascii?Q?jyqrz56mKRj5x7THnjUmB8S0mB6YEPefy88pM/F06k95Iw0tHnPbXvmQOKh7?=
 =?us-ascii?Q?0d1TRO30ZQQ5ZR35Flg2udU39XXCD5Byhp9eNize6v0hvkAgVaaBH8EtcnQR?=
 =?us-ascii?Q?KBU2h1W/IccalCFEEPeVL/PQ6iUG2PCpp2KKnj8NlGwWXNfmgZKiPnexW2vv?=
 =?us-ascii?Q?aA2kRoPU/Ma2KRYGJtEzRtHjy1F7sfTKVAy7bGAYSYPk+qKxWHFGhWSDdbnc?=
 =?us-ascii?Q?yhqR1EyBBcnh4BBpr7jzXlXmH2oSChk6bWbyyTBbiHDDuK5k0XANYkZC6ru6?=
 =?us-ascii?Q?XGLd+6hXuUSnGBFl3+wT359awva74UqiLncXHrmZCJ94q6uGrpweIlBocXIn?=
 =?us-ascii?Q?T0m8unnM9k/iFi5P3Y5OLfpBKId206ibBRVn6NZ0tiIxj7Ocxp8mvjKYmqWj?=
 =?us-ascii?Q?//afuRwJwggaMvT4Fnj2AlwlBPvKHY0/H1aCb/jz2Ka8bHLBH9dqJ/Umh2fH?=
 =?us-ascii?Q?Vz/Ktr177+Z3fqjaqdXF87fN/6LbvL35PAHiihZnFyGVUxYflPC6Qvidgz65?=
 =?us-ascii?Q?7oD8VBV5VNjXoS1oC1YzA4Jw2/TJg2AObMxn6ZBuQEIi54PRJQAsm3X7BPMA?=
 =?us-ascii?Q?BjL8Or22evQB/sGr+si4n9Oj1kridjsbNKcJk7BV1MB0KBWAru3K6Lz8JC0q?=
 =?us-ascii?Q?uRHYTePjaiMNpF3WFBwSw2mJ9/f4N+CC0IFe+Lf8OS++VXJpvGTsKFSYu4rv?=
 =?us-ascii?Q?r1B0nAKaFpzCAkQkrBC5/9LCgTI/bKsBMuL6NvuoPiCNdGCOfbT6V6D9NmnV?=
 =?us-ascii?Q?Adr3mXse4HQ4I0G+wL2HGSfSWdUHPS5NcSOCW8ZVe9QEy2Ww2Z1uZsoLBmmz?=
 =?us-ascii?Q?7QuBXxEKm1yI7o2rw63/kI9ok1TW5D8k2zgrKdNYjkv9FQNdt8GDK/PbNtBL?=
 =?us-ascii?Q?pzog/zk0tLpIYA9v7O95I6iyR3nHzQwM+Xjl0Wzndtsz+GoeaPgklzeXJqbp?=
 =?us-ascii?Q?XmBo8gqiCxC+xmmcXeP8OlHmTCjBzMqhEUpFR/X722fB1TxICIkLvH5pbXMb?=
 =?us-ascii?Q?+ZLGRJaPQgT7/iUORmn1L4s+xeXiw8AaaX8jfq6AOz9OmRMuIeIMrzQrWjrB?=
 =?us-ascii?Q?LpD2h/B725zwUwQRTwZ9kw7KQ3FVQ04hxsKX/YBx6RLF0Vz9246I8bhZPZYh?=
 =?us-ascii?Q?EZmMyXeEj9mrrXyPczrIwNeykfCm8H1MoRvR+bQAwGxgaxLY+I07/DsWElAe?=
 =?us-ascii?Q?t9Pj3ufmOcGavelgD/JmTfXmS4M6kmO63epjxw+zolwkL0fyPkkz7gDwIMjj?=
 =?us-ascii?Q?Yqmm3F4vOA3zrFYbTdGpVfCsHMF8RnNvEVV6PJTGs2HmFxtaDUD3u3k2k6Eb?=
 =?us-ascii?Q?cDcs65B3zeTZUsfRAfoufqpeQEECnsc78uRFdmvF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07fc13a-a795-437c-e3a6-08dbc9f1af64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQWRqxbAgfclp9ThALx17r7OEKBIckodBdQsr1g7gROwe4FmRAxMiFfrMPA0crXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Introducing global statics which are of type struct iommu_domain, not
struct arm_smmu_domain makes it difficult to retain
arm_smmu_master->domain, as it can no longer point to an IDENTITY or
BLOCKED domain.

The only place that uses the value is arm_smmu_detach_dev(). Change things
to work like other drivers and call iommu_get_domain_for_dev() to obtain
the current domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++--------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 34893801d05c73..26d3200c127450 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2455,19 +2455,20 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(master->dev);
+	struct arm_smmu_domain *smmu_domain;
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = master->domain;
 
-	if (!smmu_domain)
+	if (!domain)
 		return;
 
+	smmu_domain = to_smmu_domain(domain);
 	arm_smmu_disable_ats(master, smmu_domain);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	master->domain = NULL;
 	master->ats_enabled = false;
 }
 
@@ -2521,8 +2522,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	arm_smmu_detach_dev(master);
 
-	master->domain = smmu_domain;
-
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
 	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
@@ -2541,10 +2540,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	case ARM_SMMU_DOMAIN_S1:
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
-			if (ret) {
-				master->domain = NULL;
+			if (ret)
 				goto out_list_del;
-			}
 		} else {
 			/*
 			 * arm_smmu_write_ctx_desc() relies on the entry being
@@ -2552,17 +2549,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			 */
 			ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
 						      NULL);
-			if (ret) {
-				master->domain = NULL;
+			if (ret)
 				goto out_list_del;
-			}
 		}
 
 		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
-		if (ret) {
-			master->domain = NULL;
+		if (ret)
 			goto out_list_del;
-		}
 
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
 		arm_smmu_install_ste_for_dev(master, &target);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1be0c1151c50c3..21f2f73501019a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -695,7 +695,6 @@ struct arm_smmu_stream {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	/* Locked by the iommu core using the group mutex */
-- 
2.42.0

