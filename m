Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15022EE1
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nN2OTSgW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaAfPFRVd3pS0lWj9z3xKP3CLOt6ZUBRMbgyd7iLqPW6+AWCg8DFKVR9hsExxR5Td9DbQPvcgT3zFGIyGQDHY3+xx/721ilDB3HuZ923yHOaWICvM0+fYgx2OHjmfaSKbpyMhyQz+2auPOWr6OK+/pqzfsZ8DhD4wo8B6EtEqwTXsoclI2k4Tzk+HoKi5Wi7exPR8d9dPxVkYHpaFXUrPsulIa0iwV/fNSejwhvyvUo4KYTn75QjS1SFdNbqzLdq7jpAnnOMNQlWduYlaJK+dgJaRJFVsLR4IFYzmihZfrmfHP49R3GKztzBYIbbmRM66TNGSZWB1zVaD3fh4q6TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTuACXyciM4pg2ZdMgnilAeCvfBwrwpgwk/dAoIoopo=;
 b=ZhyzdJ1Qd5mw+81Tl2cp3FZD3vhyXTgw3zmd3+qKziLV3iWinL1/LmyegOAFckexJdQjai9gni2SSCIAiLao3Rufl7mAmaM5gmxR0QMQu2VXtPLuQSXwpou8IIvoEv0LnKj9pDZHsHzH7e26CLwsMuERJksL1vWwdBw6vyYLQuBPDeHE+vZyJSBJ7DZO0mVl8fYmiCbygd6fWScp1aHUF8u9SJnDyU/rgVisKDRCRmuYeLa2YYXGpYVKGkcc0SPMVtQps3Ell0fE3rvPFzV5s9CoCgcLUAwoJ7zwHLGoE4GszbeHM7F3I2atLaJZViWZ+oM5DHdTxTcUBroXKfVcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTuACXyciM4pg2ZdMgnilAeCvfBwrwpgwk/dAoIoopo=;
 b=nN2OTSgWbi6W5OiXFvfU2iI8cuxEsG8ScN2TympRd4jcGDmGV5acXFMrsvGvKGt8g8wclcbRktTHaTVLv2rBk0mTSZkUiS00AiCqC7GnVqscWdRacgB64sDzwzBWfJGQByVfjOpwCSDSApuGBgt1LY43ZgyFNZIMixOS76OUYc+iHW78Jmt3S9LJCZt0ZusBzo/RTM6Y0kx0GiN0jmETcRn/15TIrwk4/cxEWpC/AZOzvkJfkP/7i3y4Mo7odxUMaqmtaHXPJ54AdTuJWPi2MzKpITKNG1zFQLpLzs0HXucJfj3T/QBwSFBFuY3baUhV20ZXdUzK7pF0YAhu+cDSQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 14/19] iommu/arm-smmu-v3: Remove arm_smmu_master->domain
Date: Mon, 13 Nov 2023 13:53:21 -0400
Message-ID: <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b480986-214a-4b80-64b4-08dbe47170b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wXbhcxMgHlxhpLMaTJwSRjx/2irY2Bj0h7DPzjGfdt9+10kMhTSqycwmqpc5nc1JY64nir5GHeL62H51t27zG3sNq1f3YTQsL29WClL1LhE+C3L3CLYIxxhJYMSiBrtgz8nOhbN6x2FqtkBgL9J5zcZAUVuH92CIqZIu5Ndj6alV5F8dxiLdE+SCx1LMKXDEmikHbKZGKE4CU88XAnhuar1yiPbv6EAcJkaftwpYt0unGdoTkGcb+50LHYbW0K13uv4G926tYQ+rlzopeBjPSvoMc3fyhSBG1srQOPpODA8CVuaFvAJg2JomfRr41/H2uesU9lQOP6gM0YIbqMmGsHelwF/SQupYTNv2BtkMDkX7hU5y2VQ90SFtbbVoNX/xnVyDRdlMA6z9tP7ab6A2aUUAkAXbUbkMh4czztNXB7ZBzQxbj5t93XaTEkpEb5rbfIsnLQ1x66FJVpjMA/ojhzIgRyGvVJLaEHvT+33KwW2glhwfCkrwaZ+tcU2yLfubRHu76V83jUZK9Yj9hy2GvQxzkaXh3GzekKVuav3fzmCsdURtVvsAf70+XsSg0MYm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJnkieywCmMaBxczj0SBX44bO9WyihDzHheA64wxufq7rjCCXB8fCBWcmRmw?=
 =?us-ascii?Q?IhaVysYBrc23xRqaQktGQn8XlbyNdgmTLMOU6dkPXSwYFSp9PrUGk4YcExzq?=
 =?us-ascii?Q?MUt33T/Fv4lqIvd7prsJlnP2DQQMUiOEdE8BmFP4xjbamG6a6eAdJsKji6PK?=
 =?us-ascii?Q?Vd/jax58TqvHkmeXYv4ptaK1E+s2IZjutXxUcfdk9ajOXyXhK91NuZjrsJhG?=
 =?us-ascii?Q?scECN1+AbfjRpT2mksDnf7jljsxcRyGriG1vx/+U5/J4lD48WIgVqXklBvnn?=
 =?us-ascii?Q?gFZ7YFMpsuVm8ZMT/RrEEAhBkJVhzZR04plbSAGTBsNaH+S5kQ0Jvb+GNMjv?=
 =?us-ascii?Q?fyGaiYXdHUse99ZAqgEmMfkYpoVtpmTawRwxE9VBzAmJghnGPeEkRwWUBrCI?=
 =?us-ascii?Q?1bMfrGI+YnYMjkIaMwitid+tp9ShgSSuwlamBQPXdybF2Ni14+FKFZvj9dFj?=
 =?us-ascii?Q?1Lzied2qHtQbmdzdbx4OHuwMSz9mX4V4qtoOrrpNPQpQtY8NxUvlnTJA+FvE?=
 =?us-ascii?Q?Ghr2ImV2l26ArnUah8tPQnefKzTdCQk1d68PM7oTiq8Bmq9xeUV/UivE+V/h?=
 =?us-ascii?Q?1+HZbIKy9y95XstWtCRajEt7Bo0lEJYkLEf0QPq5wGCGZ2GW0s10whUBIHJ7?=
 =?us-ascii?Q?VSyukWx2m1OgyDbFSEugu31FihJTgyaPobze1WVD6wkfv3m/XsVBI91nrzx2?=
 =?us-ascii?Q?bfpioogIFlHSW40OX5XXu0x2YFcuwf7FQfYoiTcSM+bW5oVaSwWv2XccK2ut?=
 =?us-ascii?Q?GU3FUvlFkOLTA07Mgw9KloIVfpiDV7qSFwf78cSVhZ3eLww2DnwyVUtysCP5?=
 =?us-ascii?Q?jiNAXQebO+sYfqO04h1AdFcDSJfpysnaaamyQHHYIHLx1wJwKNy9q1xbjIof?=
 =?us-ascii?Q?wGZ2HB3r/bRZ99gnKz81gMFmBTOWBTkUeOHATena/er8ml3StNfN+lt8cz7a?=
 =?us-ascii?Q?D1u25SfLOz6VJO+TSH1beZHaR928QwfJ9YcS6uyeleQsBfXd7ztGJ86RTluz?=
 =?us-ascii?Q?3SzAxI6LktZbCsvzvh7TDZzYwgKR0pkPUG7UoiOj4BRjyjKF2eUv6uRxT0jA?=
 =?us-ascii?Q?1Pgcap7qu/Hdqizdu5rEykgxmvUx44tgUdYaoXUe6aUHbDYa4ABlE5YYNO+t?=
 =?us-ascii?Q?MY1ZPs2lckD+vBLn/J1jI7KIhQulvTikJ8N/cY6gCaDpVO9pwgWAkA0yLaCP?=
 =?us-ascii?Q?M19SEJ0vua+EFPyHE+Ypj3UNifJO5vHzF6MXUdttI1vo6e4R4fcbdnjAZPt8?=
 =?us-ascii?Q?572r1+DjIQmPxmmiy06p1kA7WEauyUyAOAzmjS7gSfQ/Ke3fCoBc67Lldp5u?=
 =?us-ascii?Q?8fsDJGi8Y7QNL3TLLFoeo2Fi5YI+eI//figjMWxamfJzz6VwU3MS+vYMjulo?=
 =?us-ascii?Q?kTvWJRJfEX1RY4o7mf62jWDvRXlguqQ5d8NjIn2DVVqHjouuBEQA2FGsP5d7?=
 =?us-ascii?Q?2E1vTaAamPYVfTH7/KiC8hoVIFaKoLCeQvdDAw9MKvkzHd3i2EaV0Gv7RH/Q?=
 =?us-ascii?Q?jluHukvIt0v7b4fV8BAkZtXi2bpBhzB977TlRBkGzXEHU9W4wEjEIoNskTmn?=
 =?us-ascii?Q?dqZx23UpqAhV36bx6rU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b480986-214a-4b80-64b4-08dbe47170b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXZczvqD1VYSsSyLscCbw5V8+M/BnOdZE5EbbtxhapRX4xGqSINHthS75GiQ5FXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

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
index 7d2dd3ea47ab68..23dda64722ea17 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2480,19 +2480,20 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
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
 
@@ -2546,8 +2547,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	arm_smmu_detach_dev(master);
 
-	master->domain = smmu_domain;
-
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
 	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
@@ -2566,10 +2565,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2577,17 +2574,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

