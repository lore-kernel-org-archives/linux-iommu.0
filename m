Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C9225CC
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TvxTesno"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz8FiNz+I6iKG2m63Se/KHGj95sa3M4H6uT+1HBQbEA0nVa4PUF4/CwLjNZdMjg5oK/GSULWCn8TQDVOGS9cEo3TXlpYWYgFDtm5bKg8l7Ss1p1YwW7oTuQLiqLvfomx1PsCfYe1fWv3kqHWa6sEaR3GOlXqnmqPzocZD5Rp50M4aoYa3oIrFP6F79g4aDBk0NmFMQ3Tuhjmm5RvczgARwNq15Spdj9TRfvTsx+xiZyqxOOh+0JRNa0uXLjdpjMoqbWP74XWe/0QeQQNN45YENJrNfd1rQt+Pr+eHiqZe7r2sXndTq3CQrBApVyur+qYD3RHFDlev2MCwlKoVCxecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU1VnFcORe3Garadx4FemnCc/4o+ni1i3OYVQDm5PI4=;
 b=Mj0eVt9k1XA6lvKxS7t+Z0qB/jOtn7R1hyAbj2XxZ486hGWTqjlLCk0h5VeoA0FXwfmvh0D4dHsCJbc0DS9NIIP0vo2F6XwslWtmSwboWdWraowN4OG/InJ+g1qYEUU2+oj0ZeZxM4NN45ELLIe5hh4MsfGozvESTbWxsm0tR/IwoF+/TOOfBHcE9HGjiBdpvqTxA2iaNTw6SGuouT4dcinwBzVsrFZVjIbDtOWOSdqT6qUo+3i+AqcnFeLYJb1SOtou1EALVIbqZalTvKhYowEZ1NHq9hDO2OsWXwD8Rz8OdRxPG0RuhIdyr1jcd5hXHaYyouWFhhLzEYiVTmZ3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU1VnFcORe3Garadx4FemnCc/4o+ni1i3OYVQDm5PI4=;
 b=TvxTesnoy9kxhA47sj5g9z+0nGRDjCrm8vgcGas7klAUqE6ajlC/flP+Rjq8qxWUfiHvNLScZIaUs3A9O/7oE8PlheZB+/cNzESe7ijY2OOnn9T0gUZak3zyMW+h1WxkCT2d72tPZtrLucvnz9+bZrB9gwfhOSZsh4dQMbNLexZeYWMbYdCRBnFeLVV1HV5olNlwKvOKwpf9aSoSXCI4BwqbNaylatmx52wXbOsPJg7VMlRe+mchFl99toAx6/X+mbkkMMQfTk+JGLAIL5lVm3Gv9p7N1rTsJTuzMbY1yiD4mBJxZGTytWq+A6qyAAZlB18iBJCXCNN2ApBgkKMOlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:38 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 02/19] iommu/arm-smmu-v3: Master cannot be NULL in arm_smmu_write_strtab_ent()
Date: Mon, 13 Nov 2023 13:53:09 -0400
Message-ID: <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0325.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5ad9b9-e308-43a6-d6dc-08dbe4717103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ivxwOD84DLek5ku5U66Gjc0RT4A6F+/fYbq/5tJVz2H4T5Mx69e5N2x3zqiOeterVMWE/cmLohnCqUWnCzlPPRzfsrYLcMAfE+Pc4ZEhG3bZ6ABI4QIOe37BD61kx65O/JSx0z66JzTJgzBAtBMybUw5Vy3TUV22vGZrHaHBdYYkA8Kt8zLNFxOeakCrXgpF3qUFVcSP7HePCBtlA6LWBgF/hRpUgCW14eZ+GxjSQtFM0/505yv98CwbJfszGhFqS/l3hKC8CMHKIFvmD9cH3f+4o1aPCMXEeuGpG600RrS+MEqlYPlCkHcpBfM6qIJxk2ZiJuxkYfH+Y+7lU7844j3buVuZT2AXpHXOp7A7FUmnlQmaF5m6rHrtfz3EF54WeqP9Wr7oQjfLBywymtjIObaj4k0UdxhUtc3eGHxIXfLue004mItw+m6nwtkabXpd2oT7crk+DlfsrfllXAZX/5zWOYXFN/xgQWF9rAPvANCGyNd/pwxqpU1+BU4wnwO/gw0E6S54CVMpba2myJJnLQHg8eA5q9+2khMBpqgQ5dK5EnO0meDW/w9i+wG5z7f49vdwFG5PSUdROLaQLAUFJGHet8ud3udK+6zhYln0Sd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJraKFXLBxM+OXs2A7vybJKnzSM3MDng4q/PRBWM1DuweS1P05Va1fholsYH?=
 =?us-ascii?Q?pfrvnBMIhp/Iy6dIxOyewunx70kPnrz2ntBkiG4fcfwuxnfsEvnjBccgeJHb?=
 =?us-ascii?Q?j9cHMQPcb2aJ9FI/3QvCG12Vf4j97L+bIbYxB705aVkcCryj6iBHa/JwlMs4?=
 =?us-ascii?Q?r+jJHdj8Blt+01Fc6T6wqUyHV1B45Ri69rPiOcCo9CEO1uSYb8Ui5dGwoDBn?=
 =?us-ascii?Q?CATV10sCuN7A1iVKUx44nSREva6lt4Zc0avDJ3cvG2gCxYEHyZcu6ql7ScZA?=
 =?us-ascii?Q?T9IW7fP0kEu2acyQETuM6Ne8InJdioJ6wYumrogRSj528HLTsLFo6A2pUE7d?=
 =?us-ascii?Q?jFB5VdpDJD6KdsehYJ30b82GvcFfO1xkvFtri7wK/XXZrc+BUEWd7UYqZznG?=
 =?us-ascii?Q?bMdfIXCZRpkPGke3JlgKcHym4QxBk/XuUWfX+K2497yo2JMlPBFYDYuaNjMh?=
 =?us-ascii?Q?8pqctU5uCa53RnAsObIOOQLzFcyeEBcxny5e+2zWVvk0hjDjJFC8SwWslarE?=
 =?us-ascii?Q?mv1Zi3UcDgJCkUdztk1osUiwz8Akmjhk/U+FtvXLQPaKxvZ/B+5+N7YFh0sV?=
 =?us-ascii?Q?mxRpQSfrdSOUsET71+pda2R7n27+ji5p5KXXegemySN/OLSCYWc/kB+O58Iv?=
 =?us-ascii?Q?w5WcYNwPt4x1D0y+D3BnZ1gobz4tg40be+5gmi6kEwt6Su8VI/zdoYrDcLrA?=
 =?us-ascii?Q?7sfkQCYzVH8FQSYdk9WtVozksd7QuQbE6Wf8F7jiUHG0ITIet++pDST7raT0?=
 =?us-ascii?Q?Hpa+GY9/KWq6WOUM9f+/YLolRVj1mQOEs9D/wVjnSxVdgoJPozUJATH6ZMvt?=
 =?us-ascii?Q?DBU6jsNJlHpcHyLVdj14vGdiymHMzG5cuAjfVKE6sH8woBTXw3i7H0lwGkux?=
 =?us-ascii?Q?0G+t6OlWOJMZQWeodnMt7kk0m1CYmTqVg+NJWkPqL8w77L67KIbpcySgODMh?=
 =?us-ascii?Q?Wq0F0SCFOM7dHiW+ihuSfFArJ5X16TtrlOTLX3Tdk4hIfyrJToFgISpD5tWf?=
 =?us-ascii?Q?CQ7dwwi93oZk7wbmFjVgUItj+bYBOXSZyZBmmbx9yrmWz5FaZYva7yw25hJY?=
 =?us-ascii?Q?UiUMU2ZKUOaiG0qleylmrkp31+ICYLwsr3HUoBDyTcRUlxjGRHW4L8LZArbq?=
 =?us-ascii?Q?VhjqhAV/lDdeXx92R2ehIk82yy94TmlihCve973mEOwdRadH24cRWHTWRXax?=
 =?us-ascii?Q?EmTC9bWOuobZWhssB94tnB/MC5ymWLW4eDmHP5EdaDxSfe2iRar9SI8+4uRv?=
 =?us-ascii?Q?7xPFBu7rk3WxqVv8u5QZxlZiPCJDgcy5IRXMDd8elfYvZVzcdCVh1r7DKCO9?=
 =?us-ascii?Q?xH/RbS91QMASZDUPjM7ZiSAx8JEeTYyqugIygbccX27P24XlMZEejtWeAmQD?=
 =?us-ascii?Q?yP9bIl16/oEkGNbJkBozJwxZ5jw8tnJU/nPdX4phtrYNo2/ZH6hOsmdOkqzc?=
 =?us-ascii?Q?hiVf02XNQKI3JlhD/9ZemM7/lyqbYS5zLIhFuBd1Hce0/7TLTOXbrxJVOEyd?=
 =?us-ascii?Q?ZWIPwa4qsc7NIjLraulRuALSA14AaxNRe6SX7oot8+fl7kseVyZZB/Pfp65h?=
 =?us-ascii?Q?L4xTO2lhIpWYJlZZgmA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5ad9b9-e308-43a6-d6dc-08dbe4717103
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:28.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygfHOl/pJgC6OaMWMJDri5v1hWzQLmqJ5AntJNeom685PaNLyLVp06ibi3O0xGQQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

The only caller is arm_smmu_install_ste_for_dev() which never has a NULL
master. Remove the confusing if.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 519749d15fbda0..9117e769a965e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1269,10 +1269,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 */
 	u64 val = le64_to_cpu(dst->data[0]);
 	bool ste_live = false;
-	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
-	struct arm_smmu_domain *smmu_domain = NULL;
+	struct arm_smmu_domain *smmu_domain = master->domain;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1280,11 +1280,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		},
 	};
 
-	if (master) {
-		smmu_domain = master->domain;
-		smmu = master->smmu;
-	}
-
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-- 
2.42.0

