Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD31C69E
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvmLlphK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl8Db7i8g9n6xNEuuPeZWZUlVYgYdMqNg61C7givzWM/Sa/fYF17Ntg6mlg5duNzboB7G3bn3yZnED5Khw2nydO/xhzDSB2xUxhAwCTKejOQFsZzg3YC8Ic4WHfzGwOOnAPBQPT1fiTaPf1fTZpWhd0nx8r//xKZ9O33tmgIcK5DUJB4ngzlPUtV8YbbCuYVlep62yv9kdY1tjOZ12qvT4+m1oudIr3K8xBP5YizaJF4tgrxpw6Hcy93lLhwqx4EdJDjTV3Jj5C/Fq7dtDq68aD/2EH73/IHs/fa3+Z3brfiYQMXR5U23rlq9YvoYEE83TFo/YGA1o3fPuph4OGqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru3TDIkTKVGKaglyCTAFEoUuuVkfNmVrCBZubkA2HV4=;
 b=IuXUHtV4G7rqJxDGEGdwrBnvRJMN7ln80CoW4XOdjVbMKd5NEk298NPWNECaBMSGwakiOUQImSFZO2WrSGva96PElog/bnkQ0PmANGipv0eFaQshRwdRArYgvHQQzmO9CgnSWuBlQ+FbTbxQQ2aNyJIDbK3ebakB6XD1c1rgC7QC5XTOvVlgmFZ8NpPaL71XDQniM2NSmz9KoTPqWNDdYKa6prWJbkp5acwHNQ9SfO4lzwGgU5oTYCsdpuvbOrCR/oWEvBpYO6LNp9gTdOmHyWM6q/BvbUyCaZrRG5utJ9Hu/utl5EBJFPBoifcmj5qBvyshSyNhNrttxD32pg/ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru3TDIkTKVGKaglyCTAFEoUuuVkfNmVrCBZubkA2HV4=;
 b=IvmLlphK00QAK9wcpm/bc7cAcjKvEES3QqT6krAnKwKhr6mXdokQjOON9SH4kf8NJbuJzlIgONeBkGkd6eicRTTzpKw2dW9aDrk1L9HZjuj3NvwK5Z15wwU5ljyoTFyQnkviVQMJQljUih79CoHvmycLZ6lGGz0NFb0lEIgGSR0pynMxnd16n5Iq0QTp7BRxKL9eQE4XKTXvoUDYLPtM4kyr81F2wbzjMDW5+VkDwEOGw2JUtHNVE3l/Wn4SEjg8fRuDlt3TniJifgu5p1bQ2T0SLLwLjySUwtOD2XRaxg0A9jkq4iGiF2+902lJCCHZe4b/fXbcjZmLnFUqC27Isw==
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
Subject: [PATCH v2 03/27] iommu/arm-smmu-v3: Do not ATC invalidate the entire domain
Date: Wed,  1 Nov 2023 20:36:21 -0300
Message-ID: <3-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: adf60763-feeb-4169-01f6-08dbdb336a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X3rmN4cp/1G/HKgY+AYTUAzzNFZaGKTcUAgRXcRKT1oQQG+cQKU2Kc+p2F8vnefbjnXCFXGikVHoA4jjY8jmH5TB3lqudqCvHG7HqR8UXqJN55MOC0IbjR/YqGfaLlbBCY2mGkFXAntkRS7gvW/eA+/Ga8vDjTQKHJOJMDcPEWz+QVoW83X8TKwwBdd1FXF24pRRALz2biSmjPX79tzKCKVihvrPin+Oyyx5uNNPalaj2eidzRAx34m/v6I9A7tEgJaprTgdzJcFy3OrPhwUgTx1TgQHKtPUKAW89HnfokdZGyUGbFEzeqTZPQH3p5RU3MmkrIu/M9TP1OHe71F+VlrjgkCyu+ErFVETooYpX4WSrSZ4H5g2vR7xJLo7Cwc9fJykM6DAySMJHloMN/xy+CRfWn3Q0hU4Zb/ggQYqsMasVnyt+krAh5hPMeNoNS+MAEOloNGgpQN1bIuqxxHLMjXgdh7FvVEm97rTp7QgnOtjPTnsCaZiQ861AX/4iMSfK3BAnQP1/BB9X9UUeb8mEdTz2LQhyz6Dk1ijFDFEwV1UU22SjeG3NrzHmBm7ACZb6wXAtNXN0be664nnMohKWbsM1zoJOCaY8X17G54r1Ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RR+RkkB13ecSQymDTi+sk7OzlzlGsBAJ2fWsjT4kSEUWmFPuThDH6Gk5hr4j?=
 =?us-ascii?Q?nGpUgnZbqtgdbfscpdkMGv1gT0O0Vzi67dqldAWbRYevcb5pLP8mtI838q5k?=
 =?us-ascii?Q?ymxaj4CA4qB8FvkGhxX7Yjf2eOsFfNMmAUDesveLvygUCs+YVH8vtNhQVvsX?=
 =?us-ascii?Q?c+ISq6k/2QANk2RCRdDlOwa+k/X7UHaD09hQDNn85xmEFT6C3jamHRyeg5m2?=
 =?us-ascii?Q?EwQ8rwV6nCGN88RDfDrVMZJXcEapIHciJdj1l0ZSxC3UJhhytZfhzTR5XeFk?=
 =?us-ascii?Q?NIz7wUucf/TxQNBXCqujrAu6yNE782svayao0EjcbdrmxN3OZIjedMirwdI/?=
 =?us-ascii?Q?6vw8PZfkSZzboyeQm9jUNK6tqG5LT+ICQ0tYafO8Kh4av/jxKkFZVjj37I6S?=
 =?us-ascii?Q?+JQgcLd2pYzrtfcngxUFfz4HghgjF2pdM/ftcsq9vbZCN5Xvnh5lxDs/TIg5?=
 =?us-ascii?Q?fCIrpc6utatEQlCpfOIf6i6UTOxxTUaaMtlUMe2igTT8F7BcTjNTObk5pKz+?=
 =?us-ascii?Q?bcP37bD0b8p4quSh2izAAWKwIOEMQnYvrVYr6PG+jJnWHhMSh2kqIQJ4WrWW?=
 =?us-ascii?Q?DthR5EQxryyeFyx1Gp8HNRbu+EusEKbr5OA4xotcgn80N6kRGgWLQb285r0x?=
 =?us-ascii?Q?6009tUgAcY6Pwxg1xUA4rx5WKf3AKbaZMt0B8ix1lMW9rJkaHcNv1xwhHDxA?=
 =?us-ascii?Q?MfjtRbJYlWreV+1nefMjFrEa1ak0LtKgaLvIwKf5RCVoVd0JV6Nj80l7aQIM?=
 =?us-ascii?Q?I6+TWO9UcKH1oLjMVKEoV5mSb05NBZoY4f0d19JEn2xi9fNsj6EVAzOs9tFw?=
 =?us-ascii?Q?V1eg193Qx88A/AsQILoU9VS9uYHXTcR5AmykDi0zk5z5eBjMXlx6zvE6/0Z0?=
 =?us-ascii?Q?lMNerJXIpId+SmiDzsYK5H28/wJgJPZbH+iqbiRegcrlOGX3wmZ/d0UBtkh5?=
 =?us-ascii?Q?mtqLuqrpyCqVCYDXy/caYptpX0WaoYReY7CCSOOIUA45RPJEtllh6dFUBF6h?=
 =?us-ascii?Q?7alhbfeu8X24EjewDrSf/Z7s6GBscMoR7WeG8v798WrYhxtOeDgmDHtXY6Z9?=
 =?us-ascii?Q?8QvasmNKLd2EoUMSsvKfM6EuxBCJ7rxUqGdAYHoCTU1Vh/I1wL+cN9ZtYW00?=
 =?us-ascii?Q?K8Iy2z054NmulVUTxQtUp4WQaMmrKx4djxDjbVPl9CMLLrBw31VrmkR7e9EF?=
 =?us-ascii?Q?LTe0H6Z5/BO/2t45uikACwDwN2h9heaxEsSc3w39O7068gzHvKHhAAwPuude?=
 =?us-ascii?Q?KGn/I8mdrkXgfxfOQmlxA5qrt28FewZS3TGHhoigN9iH1JeDBGLAlTq+xwNW?=
 =?us-ascii?Q?TVQF+rJS3nhjfVgbNS2IARM9q/I4jPAzzYhVcQGfdEXn6baSPNeJ2e63BV15?=
 =?us-ascii?Q?znvOfhFR14GZPbltylEZfM7/qMcw7L7t+cl0wiTTX9w1LGeJLeb6h3FBkDHK?=
 =?us-ascii?Q?EAE5kBddE907EN5ctuzO3VGYEi0jzj3jfz9G3hpKYfRcTgKYqs79ajIuWaLz?=
 =?us-ascii?Q?LyLrwMmmwN8yAqdUj1MbrhPzfEeqjpK0yHBVqsufLTdX2Je3M1lJrEzHIZKA?=
 =?us-ascii?Q?lNhDwN45AKsKoX82IHlJKjcLcbx4ENX0TljQtxG/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf60763-feeb-4169-01f6-08dbdb336a51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0DQ/7vEr5S2sZ+nJC+DmcQQjeffeEIomtN81VaYGKhODYzx3MUjNxt6YxF79zm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

At this point we know which master we are going to change the PCI config
on, this is the only device we need to invalidate. Switch
arm_smmu_atc_inv_domain() for arm_smmu_atc_inv_master().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 43f5531795f0b0..9a0eaae586f2e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2416,7 +2416,10 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master,
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
+	/*
+	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
+	 */
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.42.0

