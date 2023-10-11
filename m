Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A638803
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyCeV9/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRtMK8t8XfpaMwdc8uVLuVcULYOH1Pg/8Q4kcAhTg/9L4lsPK8fmBlIcfpidjbDToO97/ZeSYgfN+mbfBI9QThb375AzgYkkg0rLO5pCe4uLjdUjBi2GU5cet3BvBhzQD7GKaOJOGMyx/TD6BuUikQ9qL1KXRlfd3bHeQONtZf7bckFtP8SQZq+EbUO9ZNjg14jxsYpWmzk2coxznRrDkvEeIpjVdBqOU9pr6Xz1JmlqVx0a0yahA8bP4BdLRQrTZpxYltzOryx7pSa8G7y+gQQnlT5Hib9GLYReaU8lcqGCak9cKjku6VZUkLnql2WaUORG/wL2J07uczHsVb/J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJEnKe35tbWpzXhz/4/6PxYmS6R8IirgNIvg5EWAmQA=;
 b=U894Pof9lDu8ohu1Xt8U8H3F9UgFpDLje+xP59LImETWy2TJP8IZbZoGqb+cHFcfaq9DJO0qg+s8A1OUSOMsNqL0U7mDHv1I1fJv3sJPG6ZaXYlgalNudk++rzXyKPP6YvpdFQHqpi6cevHCcseLEKGDSMWWdrCd5crMe5ldSXsbHbVrP7+nqOFmmlfMURVFU1xxhcoR0fl8k+w5TQG/3Maolq+RbnxCoV1GP6vYS8dL9DEfyDAw3Z7qo2F+OrA+P9010C+pk4EysPYBVGQrUCryOa/49fdwHameJVLW4a6+f230zA1tHWIMgrdOJGIttHhyrnG18IDG+pUyPUqo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJEnKe35tbWpzXhz/4/6PxYmS6R8IirgNIvg5EWAmQA=;
 b=MyCeV9/B069RO2i/4u/iSJ16+bEG+aum3GPjGD34bmHA8IEd1LduRJEkY03EtEgJpGo83RBjT3NGAOyM1kDkZ5+SXqs8X7uysz6KlSwgVE8d5kwJ935x0k5TCVzvjz1VfNdmbZMRmoeMtNsp85Zmw22AAcKAxoCeACSR6Gqo1zA5lQc1KPPJDihOZf4apJS+MWAYIi0+wrThoQNcgvf0HmX2ChDPJbb80fO7vepz1hK+kNP4UMvUdvBDQ+4T29zfi8Zs3vatLS7pXLXPlm9Q8E1Eg8neA8scnUdk+FTYVbJd6RfLSzdA54U3r/yqTKfYUFx5yR6N544H7SOTe5iimQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 12/19] iommu/arm-smmu-v3: Put writing the context descriptor in the right order
Date: Tue, 10 Oct 2023 21:33:18 -0300
Message-ID: <12-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:208:234::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 227a7608-1f02-4c45-8741-08dbc9f1af24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMGm+AVeb2uhpstDnRSPVathqK962dhP3O2U+ZQ+VwoBFYzrx0akHD8CQSztGQco3eZVjyofRUky3hOdkkpCroaUbzBzJ64qSxb9WhqKwWzMSqI/fU8foiCRl5S3V5OLNgzCcsJhwy9X7/JJhm6uCzMt1EU+S09xImGc2Dv0xpr2P8g8uJ7n3KDBPyZesI2nLtFLt46xEHDnNnDUB1O7zB8VF1ecPU3Rv9c1NnvNVoDb7ne/ciCroax6ZkKagGCIXwJduc7nSZRYoERQLcgJ3aM2XounloP5Oqsnhl2CB+5JE2pTQvETuBNiNgVjYIqMaBj9d5me0fktcY+fO7Xrd7nQzCojqk8t5S1pxMULhuqr8sYXOju0nxkSQpMSeavAmd0S4/JNHmfSFzrbjBpgip7TDDym9Rt0PcK6646KSwibWNKkSJn+SZSSy/8NAlTquU88erzxY3hwTw6nyZph7LGuxANsuZVTGRVF2fklLrxhaFjxNjoacHLCXhvJWgws6DID4k/8vzAzkhZQDXK654EInkEjHhT5idJHCD+YI31MwAmagTZJqj0aLGMb6iBd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66899024)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?052nL4YJA3qcdlPIAqiMJr92XFfOccimhqfK+dmGz39ExcWmTiYb10/jQexd?=
 =?us-ascii?Q?7kx6vn3pzwMM3zAdUrYtXCMcpBhwpIA5n3N6MbdImpt2Spt/NN1CxHfoSdR1?=
 =?us-ascii?Q?//h2y300lF0gsb+VchKHeCXuy0pspOvH9oelLvXc5jGn+N7yoEfiu1WJbZNE?=
 =?us-ascii?Q?vL+TESA/ZfOxAbPOZNV0pBlc5c7/k/3pGj6gV1ZXt2VL4hzypZA4mEyAjEKC?=
 =?us-ascii?Q?BBKh6wUisklS+xuLjdZWUYAiTIiSwxJj7YrluS1UNonCS2fzyIJ5R8aKEUvN?=
 =?us-ascii?Q?/8L2uBPl4TEfGWfg5wqesMtxFkQWxBa0B4VzfRtu6qoGMazzl4YUuMuiV6dp?=
 =?us-ascii?Q?Xpdbfg08Y8bG67cckRaoRDARUmu7lBnk2jRjvi+zAl6WcWG/Y1FlGpXt6GRl?=
 =?us-ascii?Q?Q7ySAldI4aqP6P32PufYmCqj2NMZACUsUEOU205yBXdvqnobjdFJXI6YoolQ?=
 =?us-ascii?Q?qPilF9z2gYY85NeAcy5v9PvfOjgL1tkEI8XJ9YTgUSppPoEBK3ADZ8ETejoc?=
 =?us-ascii?Q?Fo40DN7v6QmpgQdZVEyrR6klIuoka5r4lkYbodRdmLBINl4kawSTkTEEfy7a?=
 =?us-ascii?Q?EOELOuhDQcueqDrT+k7987RJ/hIwIITPFWiPA/DWRFZMEvuzAWaOAls3+7gU?=
 =?us-ascii?Q?w3+JrJjaLIRCQBuEkpDvuL+ml8i2BqIiFSHEcwmsoPOS3F+L8vMJz9aHA3tz?=
 =?us-ascii?Q?QJXbxKT07X1g9YZ1gkG3OczVGpkDMhNzX59n/aKVQXUxgI0PZQJyM6son3kf?=
 =?us-ascii?Q?TauQmkHa6ddtM8hOuYqNsTYL6DeUY1POhrEF/Yl0GHa8HriLJFrBMbq6BXdC?=
 =?us-ascii?Q?wvVMXqGFjareecGYV4bQ1NaOO0inNXoh/nGDN/06XlSUcuFtfzBy1WQFps5W?=
 =?us-ascii?Q?qknFXJgu7u0uk3iutfuFHw6DtnnHh+ywAl6TDBHJ8s18AarAbIVC4mVo9O+N?=
 =?us-ascii?Q?kn7Amp/ufq2Mav1J4UQlHPz/RjRSePVl5rgKQYSxDAx5AkvQwBvAJZJj76Dr?=
 =?us-ascii?Q?/KUcugIFC9P2P9a+PuqvcvLnl6dSHjjcaVApWdxmuC9QvQJVasHAPjnNNKKC?=
 =?us-ascii?Q?yHg8d0e1GRLo5k1uAunsUP1jkmFF81UUD0sH8Y74PZRelO+VT8yRNjEzCQ8L?=
 =?us-ascii?Q?0QKcjFKdGbcRW3qGlc35Z2enCGKA/wHUoe/cQxi2agt8QcDiPJO0bo9gq6zB?=
 =?us-ascii?Q?KaFiMn1YmfJSCvR4K3M/mAU/vieei+BmmCdap9MRkTEFzYAvaTBl0MCLROvy?=
 =?us-ascii?Q?zPHY6bB8isljlV+S4yc8ZsLpD8FnVTyYTdDBFzm9p+ciOKN/PvT33LsjbgYj?=
 =?us-ascii?Q?V3U4osjVu0EcWmFqt9B+NqfDNiQ7q3crjisIhShf54HgCXJaaKtDKY5mJdGM?=
 =?us-ascii?Q?1NGkQ9uae2t4Q3cc9K5XpG9Lh8XH6RNe12oNSIelOEidmvmSa28m1HooNIhc?=
 =?us-ascii?Q?3fLxhVM/B9HcPEGWlPXxIYTNjQ1GYdtG9bN0ysPE+84LYgdPOXSkNGWDa1Ez?=
 =?us-ascii?Q?7pVqhkvRp/q0SGZR3I1YkNywEQbWFS77gfj/I2lPzTK08THp5T4Xu1tbuGQQ?=
 =?us-ascii?Q?HnrlIM8k/nb2nFEyK/a0kUH3deV6G7Z7xsjQe/TV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227a7608-1f02-4c45-8741-08dbc9f1af24
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq3F9it+PY/mEYB8v/oXwgfQg6+ps3Egu2LulBqgF6xHLHscblSFL81PicxjUFiC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Get closer to the IOMMU API ideal that changes between domains can be
hitless. The ordering for the CD table entry is not entirely clean from
this perspective.

When switching away from a STE with a CD table programmed in it we should
write the new STE first, then clear any old data in the CD entry.

If we are programming a CD table for the first time to a STE then the CD
entry should be programmed before the STE is loaded.

If we are replacing a CD table entry when the STE already points at the CD
entry then we just need to do the make/break sequence.

Lift this code out of arm_smmu_detach_dev() so it can all be sequenced
properly. The only other caller is arm_smmu_release_device() and it is
going to free the cdtable anyhow, so it doesn't matter what is in it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b84cd91dc5e596..540f38bb44873e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2470,14 +2470,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
-	/*
-	 * Clearing the CD entry isn't strictly required to detach the domain
-	 * since the table is uninstalled anyway, but it helps avoid confusion
-	 * in the call to arm_smmu_write_ctx_desc on the next attach (which
-	 * expects the entry to be empty).
-	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 && master->cd_table.cdtab)
-		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2554,6 +2546,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 				master->domain = NULL;
 				goto out_list_del;
 			}
+		} else {
+			/*
+			 * arm_smmu_write_ctx_desc() relies on the entry being
+			 * invalid to work, clear any existing entry.
+			 */
+			ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
+						      NULL);
+			if (ret) {
+				master->domain = NULL;
+				goto out_list_del;
+			}
 		}
 
 		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
@@ -2563,15 +2566,23 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		}
 
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
+		arm_smmu_install_ste_for_dev(master, &target);
 		break;
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
+		arm_smmu_install_ste_for_dev(master, &target);
+		if (master->cd_table.cdtab)
+			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
+						      NULL);
 		break;
 	case ARM_SMMU_DOMAIN_BYPASS:
 		arm_smmu_make_bypass_ste(&target);
+		arm_smmu_install_ste_for_dev(master, &target);
+		if (master->cd_table.cdtab)
+			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
+						      NULL);
 		break;
 	}
-	arm_smmu_install_ste_for_dev(master, &target);
 
 	arm_smmu_enable_ats(master);
 	goto out_unlock;
-- 
2.42.0

