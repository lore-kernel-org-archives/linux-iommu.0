Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429BE4EA;
	Wed, 29 Mar 2023 23:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9bW8dRLg5pVhiKCinxNDgdM06DGYvxagv/jPcCOAUQ1tFKDy27iRYXq0NNedQ+0y0+casABMpqUsMdUFNpyxBWHqAdwUNSZ+WocuM4a+fOt9UOLKA8J553brUrCbJpR3mxAtA+Xz6PL9nTNuzZBKLV3IqZ2gssDMn3g0x5XokkLhJaHyCESxtCASstZM71XxIkepu3DiyxGm5Laz5Qnt0bJ0+mdAABr4Bv0dHroYkdPPm7QFbKk7WgtJ6iWc9u9ifHeF7sGRoUJWohnncFxxGJCIV3vVQwLmCfCB6UEnkreUR1BmpfdAAckN7OTwU7IiwiGGrcDO9x4Z+EfzQpPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qexQH8u5sUaQDUNKdhgno5b20JrV6heQ3YnvfZ10lHY=;
 b=bO4BMpggKiULflHT2mOoUDeqORye0YZt0zwDU/Y9X9tpV51xjMy2595EdObpLqAQMcrUCVw3CAcPvPitdG15ch6R2kaePWdbMXFBpGXkHiuGf7SRoA1ZV0Ns7ghQSr76XyBUINFo3oXH9F0PoVkxRTc3+gwxIPDn71+H0gZFpJyKgtZe6AKYPzNIxZbFc47xHc7f3mdZxYDn0yXznXzdCU/yHnDpzJBqPLDuRv7umtIktLK3ZM/D+ExEMJa9s7vLYxck79UL4lLdmwd79mjRTQloFx/owTa31eS3tjWU9IqHnozNxc2uK3NfTraBIiMDsMGO0nE0LWC1SwYvvyu2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qexQH8u5sUaQDUNKdhgno5b20JrV6heQ3YnvfZ10lHY=;
 b=HihqfVAq3jw0g3hbheLjrPwcQ19BfMGyS+xuxToMVQStTK/BG69J6C7epXcZlIkhFdgNNX84okQE4co2RU5lKPlafJM2cHYoQ3crQUEeLgXOgF7UQ9Qbd//NUpZYtGntxM8hq7i4PA1dsG1aSJCOpeonahGTb98zTqMi05JKUXcfQ4GTXQ7cARIMpAt06eQngzOi48pSLObn/+ahPr8xJsmc4Ze9O1xb3k6GsJStn8l8iiXOYX30CxlRj+lqVBq3hlA4jSrARdZVHSbUhpmxoIHkWBQp2TC0gWuFVu/Z/X2x0+oGbnljndrKImWIv8jV09+Mx2kgx24rWbg3Kfulmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:43 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 08/14] iommu: Make iommu_group_do_dma_first_attach() work with owned groups
Date: Wed, 29 Mar 2023 20:40:32 -0300
Message-Id: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: c16509a8-782d-49d2-f643-08db30af00e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8BzOGkNbqsY0QTjbw9PBrKQ7dtlK1jM/yEOEBXiVTsP0KH+ZJnHu7BUzI2ukTR1kVO4Ri5504Dda2j1AV6zhVjxbNqpELwWpMKtt3ShDgOTQ0O0ysDe43CqGDWZnqL99GuPmq2HwqATzhyGXRbKQFjrWalSjT3AB70GtIatqTZomAqjlVjWnDih9qEEpOvHmkkpcnxORH0Dw0OBBHIjKnlfiMHbRGzqeVMJeqwii6KymMUZvPds7wRAYEp1TwzCSFwqE4TyOoAzel4bJgiitocfyg+X2a3HR92MvnqtV6yghawCc2HRi9KEQmoBnuZvWJYiS0nkd5kO/NhfdVJcwmbYDwgckhRNWJlVCbF6vDgIlIlAOY+y6ifI6v1nraRw8YU4mo/AliBB9c96xBgQmdjGLILdJU4h2m892SomCYUC38xpfMdLrAkdEIx9tnxGxYh47FSqA4YWg6QMykGuXxoRDUwcf7kVK91juj/42hX9oMXtkxg7eT3uHP4ROEbXQd8tnpxYz/K+/LtLJsMcFgn63t4niL3Q31uW5r5RCSl6SfWSVxb0DHMBxp5TYq+hbBkZyQnBKKg3c+NiPk0WE0T7tkq2EsokTbACP4R9KJ3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/5Udgakm0qwoGn1L1CVCEnTETOyEZ25K6AQOAWAERmrnBYCjwiA7p+/5/ix?=
 =?us-ascii?Q?rCS8YAbrUP1aLFsHan/nidbSt3N/1UdQTAaatIxhiK5DIgVlacT112s6R8dM?=
 =?us-ascii?Q?gbNAqYI2tas+l584bT0j5Ftd4tQ+4Nyf7RPRYnMOE5IQ1TZJUSLzCJaOQMMJ?=
 =?us-ascii?Q?BQbGQcFozK149BxDIFvZePEIztm+5UYkbVM7hkeaVlNqeAVwFRDeZ4LuHEpj?=
 =?us-ascii?Q?ZhcHEqra7GtRepdX4Fo2A6Pwo/D12+N+3iNj6fpo/+NnWsZQj/hDXSybKx5B?=
 =?us-ascii?Q?e7Ex8Gjb3p4zGLd4VEn+IOnzUd9FxxNDlMbinmj3x2YecLzEo7USGEezYyhg?=
 =?us-ascii?Q?58r02HuCEQlUKLaUoVCeB+n/NLZjM65dpMCw28OTkBs7pNiz21utELrBlJAr?=
 =?us-ascii?Q?KCwXuvhKuk7nudBA3lReNziW6RoWFor60TXZEY6CersBmuIfQgGQfWoKPyPo?=
 =?us-ascii?Q?29vwbYFa+LsON5p1BXM+lSSP85PI6ffVxTG5U6YlNv1j5rLTJVsboPfdrT5+?=
 =?us-ascii?Q?Dw9VdPDD9xfXbMqlw0urkb4ObVcnGwhIdwPO0MacqBGVAuUMEpsNlADmPicg?=
 =?us-ascii?Q?B2Os6WGBBPjhXytLGHjyhTeruUN+G5g5AsA+gaSv5hIf/RblmW84qZpzwAq2?=
 =?us-ascii?Q?wPMin+UWJkSpuEryTU9rB9p/k/sIIEL1LcdV1IYavknV+COiqcqf9lwrbhyR?=
 =?us-ascii?Q?2tQJz7UjyrTMFkeFQ+QRkol9ygRWk6zxKfCYN2to5iFDSltlKjoN6fvAYgEg?=
 =?us-ascii?Q?P5XzP+4jPJALlhFzewH30bDbHBgOAGI/C/gwuD63gaquN6nJdRtkGwrszcHw?=
 =?us-ascii?Q?ybqSTxKHG5oguCusMAgd52TBOpAj6xlA9XZnrgd+2oFzSAn6DQoh5JMY3iAL?=
 =?us-ascii?Q?V/LlgyOWrZYjTx4eLBK7JTHPenfqZHzREeSteI8gD6mFqFzNSoHuFzYJ/d/e?=
 =?us-ascii?Q?mcw6Mil0SRhaganzlAYfW6+jb0/0u58KWEzhfI6nCXq5NJ3uhg3zHxx2qpwl?=
 =?us-ascii?Q?T6H/yYSLW4zelfHOQBHwRZnyKG0p+d3+ZNhi9LQe5AhG/cZV7HJW+wD0pwYX?=
 =?us-ascii?Q?waMWP6o2MpRBrXoKI7A4pnCOCvFeE7qerRxu5FIkk+olFj3No2UoqZIt2asZ?=
 =?us-ascii?Q?xFUPLTNV7ri8dzAHUJbu8FVsH0dawWgXJ+eFt9kkS/g5xpreMkLogngApL6W?=
 =?us-ascii?Q?9iesHhAJIvMq1i4V3P/Rm5HxHVx8K9kTinIedBTbRPPr8Uvi9Ha8CwzQ/l3Q?=
 =?us-ascii?Q?G6BvAM+OcLcOmv4aF/n9fPZRQnzHT8+MXVERD9pRf3DE62UexVgh6nULk160?=
 =?us-ascii?Q?YpkrNHihEeFqNiuR6Wh6uGvnazsaz8APCJsN2Rf3SYMu7rb4QwBJtL+9Cdzd?=
 =?us-ascii?Q?HQhOeXhZFJ2N7xPCI7/nSE/ezLYK+XXY0yeb/YWtvuScN604TJCcyn9z6Ow+?=
 =?us-ascii?Q?Mtib6FzeTZn0YBJYtaQagreU6DMOYqo/xsJ+LWsJ/GHpvXnTZ37H2XAP4oRH?=
 =?us-ascii?Q?ocgYTsFZ6yKmHOYuLMFxqNZgd8Mwm2dlvw/d0rs1boeIP/WdcdxZQ5WKbDlr?=
 =?us-ascii?Q?48oqVnkTAYSSiEMJnzRlRsMuH/XsdZ5BQObJFDGD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16509a8-782d-49d2-f643-08db30af00e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkyzVRRmCR/mb1YAmMircxFqZ2BGDXYN76xRSWSZgIBp8qbd3dKYD83qxXarTRQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

If the group is already owned then defered attach should not be done and
the device should be directly connected to the correct domain.

Owned means that some driver is already bound to devices in the group and
is operating the group possibly without DMA API support. In this case
there would be no way to correct the mismatched domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c68cf551d05dc4..6fe8bc78db2016 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -411,8 +411,9 @@ static bool iommu_is_attach_deferred(struct device *dev)
 
 static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
 {
-	return __iommu_device_set_domain(group, dev, group->domain,
-					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
+	return __iommu_device_set_domain(
+		group, dev, group->domain,
+		group->owner ? 0 : IOMMU_SET_DOMAIN_WITH_DEFERRED);
 }
 
 int iommu_probe_device(struct device *dev)
-- 
2.40.0

