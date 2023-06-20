Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866111643F
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 14:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU0VC7NY+ulnZxTcMPx/7RlwvkErYj8hYbBMlV/ghNMc72WrGHeYTNBA9iEfOZDQT2Ez3uePX7V12ZWoG27by+Nf1Umrh9Zy2iUzhHhVmlHuyWGWItSpTzTmWQ+YG3I9aS3+bKTIAwWhhyfS++U6pnSIIT+26hViVS4DGIiBUMQoxhkJ+9GVD7SxgN4vYa9QESiwtIdqSIRKBPTFM82/si9Rd4iSK9ezFeui0MufCzv9t7dEGrWl0+72509QQxSzPXo45IAydeKlkdKG2cI10FYRFB6m+u43+ioSOBQUB3B49y9QwIrn4PHxmJObLBMKqwajHVPNit7FH7dkKsjAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaIN6het8g3uS1xNuKaqadS8Fqhz0miUgWc6OxUD5MQ=;
 b=bAc1AQwQsfZG2AJ2FyUTD1CcoPXzND6gu9+VLmJng6/p1bQExbffJ5DjueB6dsG8HkMjuel1ELFDr1v79ruDeYNYNTkjXgKBpQtGRWcObOtPy54v4Ne1LEhdk5xEWEkdjkBk9sun1rwn0jzYhdJPUFud/IrQp/IZRH85saVq2CGnlLWJ8AY6t6kcpTWgllZQHkwa6Fa/X16uyeyBN93flbqWWj6yo9fqSmUYXJ3bVD6FUYaTw68qvZLwxxZe53hOc429PeO5W80SO1voDKqSoeW84HdJkND2bPCvpC8JLahbRoHHSIXjRQPM97E1JQKJm3EdiZt4Xmjw0JOlvZjsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaIN6het8g3uS1xNuKaqadS8Fqhz0miUgWc6OxUD5MQ=;
 b=X2HzJPMGIaFsQHh7xR+s+Vx+V2U5jYn8z2xGkKcStAzcs2yFYgjzY+2Jge3WjCdHqCZOJtC2o8IUMC/35KVzs3UY/53ElyyUF+LVjxAHAo2R8613ZPa9hKJcZkq4zT/IORpG2mcfDTOU/TweqxjD6CuYQLC9Pum7OhqJiHw3bkNgM2dyK7RLPYPLjBrielNR3zKnSL/YijM4uQXF0IzTbOnOImr7t/HM+wVEP5JKAy3YS2WlHHpHJq4l7EW9cJ4n8v/uM3IAl8nMZtncx2C2QBUgWK0nHPIsTVQJihuw8G8pe/H7veBGGXx1K/90qm3+Ym9FxTN3yoSHUPhGzDFxOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:11:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 14:11:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc v2 0/2] iommufd syzkaller fixes
Date: Tue, 20 Jun 2023 11:11:22 -0300
Message-Id: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:610:e5::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f10712-cef4-4070-e94c-08db71983bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZtV5fnpTfSkvd8fn8nMTk+JfhPFPycDe42n1DV3PfnYg3WkdI5KMrZcd9ByvUWG0dXOngbVUXOWYVUhf91GX5xJ/LvvTsp7ETDoUj/OqpdoXwhd7eAss04ZVo0U1aMndgCjApbwez37mz6Xf7LY1ZYKdhNXXNkhEvx2ssklOnHqzg4c1LLdpNsChl+cXQ1WnNO+Sa3xgm0VbnaKRH9L7eEf/LX3RnwvdC2IBsNduPbbLM6YSeRE0GyZekNZgWqfK6l0mcHA9EGeywFtaJp4YPI5jkIkmKMQhhdQnsUD1T1yZegj373W5o1ZIKoa5x0DybgZmexjtZ5IvY7odqLbdQV2+F6sjgxYStU8s2O08FkBa/k6ltanFlrucs1mqTqofQJmCaz1a/vKaBd/08nc6LfpOA2HjYU+MautbRIUBW2BytdsAk6pm0n8IW0hyZbbgEoN25wAK5FgaHfhk7o2p/q1OcKOdbIsb66g1E1rFYYvxwf0Khp+bzfvs30QmB+PKW1YBXVfY8tmURRtWi07MEghCRqX+W/HkfHMqwPxjCcZc94jwJgw9Gn11p184zEongy2SRdojarez8GrczDu1rjxFYvDhlWVXVnbaod/2Mf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(83380400001)(6486002)(966005)(6666004)(41300700001)(478600001)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(38100700002)(4326008)(6916009)(54906003)(8676002)(6506007)(2616005)(6512007)(26005)(86362001)(186003)(36756003)(2906002)(4744005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmgyWJ1uH/eRsyi8ZXsRu/HorcBKYHiioCHC+Jc4I/Pg4cNu3TuIT/GXNK8S?=
 =?us-ascii?Q?ET9LHa1r6M41yhx6oLwPN3FNc07ZQmQ3xvW3HWdesICp0zavVHHKljNErSeT?=
 =?us-ascii?Q?wEYMfIuGycyG8siy8dKms33uMaYO+3goPf5pF+ZLVaBu112jWKPNyxUCRVXd?=
 =?us-ascii?Q?xTPmHpzGq1MQKo2FwBdbWFFXJpQ3f9qiGGRaletqs11smto6EHoCzJjOKE1/?=
 =?us-ascii?Q?2DRG2eyQzqJuLxxuAHgD5/ho4XCuCWVnPtD78VfTuPh8MjnU/iU7IomNPrZv?=
 =?us-ascii?Q?KotC8TTaIqcfxSVLR70Y52RGv7qgfxHvHVGcPSC3WdTxt6mFLbLCva9ksqs8?=
 =?us-ascii?Q?UwQyi1OqljbtbemtnoC6kad7gO/JlLQRg/QwxHmcw4jd/LoLtPUuTsa/UEq2?=
 =?us-ascii?Q?h5ueMSj6hiVjOEZcy2l8E9euUdrGMxlFdNOKAyNVwuQR8oeUpDtLyPfYXdzX?=
 =?us-ascii?Q?/LXU801daQEJB/PmU0zfB6UrNcAkvUvv+xt5LcBZbhkW6lwlfRkDmjS8gX4F?=
 =?us-ascii?Q?vE8MfYkwiuopTb+QOtcCYDtvOBLeAzriv7PpDcZYdWwAdyQk3ORvmUh7dk65?=
 =?us-ascii?Q?qAZAM+bgKnkz444uedG0+xqWhA0Mtzw2laPZa+qr0RYgP6wxGWme/b2C9qTp?=
 =?us-ascii?Q?dkYB9CRHrZ2BsMl0d9OdSqmoIeJx4YwvYDj3Ng8pXujxx6PF/p5aNwuBOGy4?=
 =?us-ascii?Q?eygPXtVRIvINWGJiRCPKw895VbJ6wJmnCxyEhQgJ9XP0ux0OR67Vpb0EVM3g?=
 =?us-ascii?Q?y5wSS4gKUoIaQNqxQHdR0cknswYDCWD2l58umNuP1yiau7jy2jKa7Q4wWGHd?=
 =?us-ascii?Q?vnQZDP2uFJGg+Oh4Kbd0nk7pEQok8deo2k4of5sfdiwSz7x/7C/j3OpZFxmH?=
 =?us-ascii?Q?Jyhw5ItP863HiN6RW5ViNI77e8w+qcDx+kWT4nT5sslcW6AiryX0oso+Pw+x?=
 =?us-ascii?Q?+K8z+1gcG/C6VVw1kXNMYse0RLEAr1PDBKR/0yuyfELhfYh7gFMcleKO7Qfz?=
 =?us-ascii?Q?o0Sx3YF4n4uxNV8D03sQsazkcFv4lf+dw5YA8a8nejUkVnwEln/NxPAMDpsk?=
 =?us-ascii?Q?J9r4QBpTfTBQdMF0//BGsKyCo7FTIy0esUfS4lKoWktRI2yfhLOQMac4lsRK?=
 =?us-ascii?Q?luV0Lfom9xDdwKZtG0yUaOitGT6jpQOW2hiLLKTnFTZlk1fidYITSzLsSmHM?=
 =?us-ascii?Q?29mLO5N5Bjgpjz3DWj3V2E4l0bQ33nrQVx4mZfzNupasR5aywvpvtkOSPPms?=
 =?us-ascii?Q?cg5MgZik5vC3pKwEP5VkAY0WAnUy/vuByTxcrgx1ZG2Cuw9kCYhbPXK2AvoS?=
 =?us-ascii?Q?ymRGrxEw55KV+csgKbbG8R6Efi0RKkICFpKRFCqhNqddTpN5XsxH+rwGDiC7?=
 =?us-ascii?Q?Dw8I1oIiPkm5dOlpLh89TEYYHjZJd3Uu21c0o34w3sjoZMnVbUaXLqthdXaG?=
 =?us-ascii?Q?YGyV3r5S6aveqBxQ9eLHzNdiRsJaFCQ5y/Jw40ydA7ht5mqjHvXgih/EPjRp?=
 =?us-ascii?Q?05gFok8JQmwkVNMjvEAITqQkGq14Se6H/W239NlCJjAXXAT4Zr3+ud70DObw?=
 =?us-ascii?Q?9AWgWLpaVzFCacfZDsLS06UNgGglRXpTtAUJM6m8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f10712-cef4-4070-e94c-08db71983bfb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:11:25.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPvuhjsttJ8leSJQQwgxwr/BBxO+FmLcZApJ+t6UQViXSKIWL7a35LMCvz4SMaAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

Two syzkaller fixes, both the same botched locking of the area pointer
during the unmap of IOVA being used by an access.

v2:
 - Zero tries if the IOVA progresses
v1: https://lore.kernel.org/r/0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com

Jason Gunthorpe (2):
  iommufd: Do not access the area pointer after unlocking
  iommufd: Call iopt_area_contig_done() under the lock

 drivers/iommu/iommufd/device.c       |  2 +-
 drivers/iommu/iommufd/io_pagetable.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.40.1

