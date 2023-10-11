Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D73D99E
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltghqg8y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNhbRparo8EJ+0P8Wu+Sdpe4kJUl3Ddl293H3iUplN1GTkFpwRDxe4EW6Nku8H25zpvvUjb+xI/CbmIpPwcN6ednsbGYCpQCkAs0krkGZeRENFICPflnrSYiuxM6r5YZcTRYkupIv3T0NlB9UtlN34CuwawRZQzm/9dH9bEX88zwkyqzAqAknUq22YqP49qskWl1Nl9IpOemDc6R7MiWxh4bAaZI1FlPfds32E4qhhYnvuQ80OLdPAaiYihCP0+vrBv3CzSo0ty5Y4IQDwATtbam6vb0PkpgahTpJivLpybsdPRc5+PCYagAC55pGXZr+2Z43ckxdWDs2/dUq2EZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkTNONyyv707aoAGmWhQifeg1PwnnIV1cZmLZ11dglY=;
 b=WbQ1oEcndeJMV0uSD7kuBCa6xkXRohD4JnXMQf7ySY5Z+52JTE9iAthpJPOmJUuhoWPqvqAXxD9zPdIn4E8W0P5808OLKjB5WofnK7fmZCauZrdDj/GNdTnYJY31WNx0tym5AQgZ/iCuQZ4gSGzdA8NUXHqG8/183kHh49l9MVqGyI1HZzjZiLI4oe8WWH9URgejrPjT/5vwEK9k0a3Q5i7A+yWR3VUYy+9WRwsGvKYRsix81fag4cA5IfdoqRRwUeqcFwBqAN1Dk3JgghPVywGKzOiyijdITsI//o5AiODKaJdMF9UPc2LafIiKYBuKsNxsOuBMRSzX8ovEgzztJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkTNONyyv707aoAGmWhQifeg1PwnnIV1cZmLZ11dglY=;
 b=ltghqg8yaxTxgynOWfHm9H3D6pNBm9dQEd4mwhNJqibBpc26meEipxNAGYzVw49w4D7oHD1hr4TYREgxJQBOOupwV0aM11GVBsE3xw8Z9AkxZ/oHDr0j2JanB4tSn+9PhgNgxvYwxaJLFRMZGbgZjkoO3EN9B+jJ32QxGI/pd5incNh5Bmcxrbd5LYtnLErVZ1pVqN/JPgKv6lnbnaYUY42Yo+CSDRWKhyASAuqjJBnAXvJnP9P7fmjoZuXb4x1w8NFfCsUCgwgkWMYOv1ggPtth+n2JATOztiXDhHG93//XxKTyMoZ/2FcB187DSJWVufSWsNCqHAMB6RMP1T4y4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:06 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 02/27] iommu/arm-smmu-v3: Do not allow a SVA domain to be set on the wrong PASID
Date: Wed, 11 Oct 2023 20:25:38 -0300
Message-ID: <2-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f33945-2bb2-401e-be51-08dbcab17025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YU+N8thMLL4YI7Yc+pR+aPz0MH39ZyFa9uXfAdO9hPcQ7c1frfrUrwOr00IKpiIn4BJdpJ59asxGOcCmi/qQZFP9pFaCyouD8B3UFyslIKsF+VUmLoYlN1S+dqD15Q/JFFBD5tsAkJHXbcF4r+bT5Etuswq1TRBsiTBFBeFKBcE4f3OT6AYiy7mgPrQDwy81U780s2rVJt3dtO5J93ANPF5HbUXCJUtgCfOvjcCcneAqvhQ8JS7l99Dvl+OhuouqdzabSsjjg4WHcfXeP0I/LMbQDXMoo16g8s8wO+V/uIKx13TsQmdX1sTB0WLFPocSKLeOI2mkliSZZNmMiSysogvcrQL887Dupt1iOy9Thek4lm6Qr0WjNrhk3RZADJQRVv0MiAdyns+ZjyVfCAWOztzGEmw0ukXlBtNB//7VhJFSYbZaAHpoV12viq8dDgT4vLnSW/ylS5J5lBVC1XKb4aNqA34daBI2HbhYjwXjJSjtPO1s/YcTLg5r/Sfjs7JfIHujLCV1uQ6bpwPmq9rEkX5Jzpw8S6+Z7VVkTTyzCwk0qJvu6EX6SWwUyw1hMFmocuaEdwOtpN+sftoO5GgNQAYksKNIloh6O1GadMzb2is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(4744005)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?em+mBMj5RnWdXYQzb4BF6Lmdi478rzsYw/8YzTXVLAkWLjiLeNfhiPcXd8ro?=
 =?us-ascii?Q?S2je3YmtbAtosiTllQNkGKW7vbPIOg3YSHA62GcEr0PaFlt2qKc0PoI68VaQ?=
 =?us-ascii?Q?TK64W1upKqEYAmy4zmUAZZZ06glnR6OZVYhjiuY+yBd83WFiWCYcATV1aNq1?=
 =?us-ascii?Q?pZKTSHvZUrmZOY/SMbNYkmyCyJdJ8KdVcf/7PBYFO+F06akXgqWoQRQeJCq9?=
 =?us-ascii?Q?9CoFXvHvGAFOhKwafXJOACjnUAN9d2L9vBThjVoUhVwUH16Xqy06a9RaLSfo?=
 =?us-ascii?Q?LRn31yTtAf4rCwk4qZQo4tHXj1QpPZH83/hBjcVW1dcTYVuqDq4ZLQHDxxbd?=
 =?us-ascii?Q?NPu28YIBrRAaDPUxHL2kor6V/fuf8Fb+rT/boXRQ8t/+lGrf2tTwCXktHoGF?=
 =?us-ascii?Q?JxVHF8llKaKgGAEBZq086J7OUcTsSxBcCGaRebchQXZ6u06SlthWHDrJMG44?=
 =?us-ascii?Q?yjNwbKhH33uUJLDJkAN7H7Mi0bDkTkh8Jqne6tmb87RJdUSbFKPu84S8RHhR?=
 =?us-ascii?Q?YPy8bEjk9tavy8/bMkcvTJHOO7NJQoSBPEOV99dBHS0WbRcgII9sU0e3k82a?=
 =?us-ascii?Q?vYvpeVX/Sd2YFV88F5Ynq+Dqni6Hqf4l+OaZdsliPcm+TerHF+gxOw7aT7vH?=
 =?us-ascii?Q?d8ZiRtRc3A37QJFZsUH/z85/75zPUFWWbqpxYdomDT3uF1qLavb55nSmhB0N?=
 =?us-ascii?Q?YLxmfrpWdUECSw4HWuYgiy3Ps1rdwuwVVSSoZp3PmuNBdZr87FY+BlsKn+LZ?=
 =?us-ascii?Q?qg+EmwWJiYtDAu2SF4vDQTHYZlL0ZbrHJH/3v5Csugmbcy5lJ+3mMhocF/HA?=
 =?us-ascii?Q?+FC9nJZJWwNnp44tbvYQe7FJbYwidTjaPn00K6ukOv/G923nw/XYHUfH0QOf?=
 =?us-ascii?Q?1x88NKyYcvZZnhdIuQvl9NW6BZpfgjxw1qOIPZSEKsOwQt7xSLE8AHcA+34c?=
 =?us-ascii?Q?JUtyX7U0gWO8iD7HJoSGu8T9uqalRUh8hTdZqF3Eh54Wj+J1ITKkCMoKrQ8R?=
 =?us-ascii?Q?XMFHLmQYxOq0bk8Soh+YkpMGuL6vi1SEWHiZb2tDoh1tIYQaYwcyagkB6nT9?=
 =?us-ascii?Q?enM9KCOt7x9C3UhrXTvlijvWuA1SMR9x5BDH/VWyAiR0OIsbmHUZyEslof+x?=
 =?us-ascii?Q?i9yU//+/tSLwpS0hIxFRz+wRCDFwgjXYqwtZBdlhzMx4cmMMHJEGc1deNJyq?=
 =?us-ascii?Q?COJcCZm/wTOHFs+gXyZVUCl1BhdTLyrLx7Qtc9O+0ATfrrQUo1szzJEkEXwi?=
 =?us-ascii?Q?tPST7CcpdMst7L8K+AiKxdiw5TsUmTbxpfwJh6V29m7MXHWPh7aSsBFJ0uPG?=
 =?us-ascii?Q?chFddlj4Es8w/WAw8p9Z7t50er9CxN/GN7nB/2A64eggseEq/O1EEcKXDh37?=
 =?us-ascii?Q?slZJ+B+72sxz+UeHGU7XPWuijMrQd3MF2TjEGx2fIn/bbeBJvhMplz9BoKzm?=
 =?us-ascii?Q?364W5pjpyCY6f+A48E19X5wd4UUMgHznkSN+J/UF5nnrghRjOOR8kV/71B7k?=
 =?us-ascii?Q?Iioma6sbzuukNh430LDlj4AOOwcm7sH2sXeIAyocoPs9NWVE1JohnZpzmYDe?=
 =?us-ascii?Q?avb05K79NHW+gKY9B/BKViQ/U5xkEP2f9Lpbpo21?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f33945-2bb2-401e-be51-08dbcab17025
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8A6uzTF1SRWJH3tOp86Zg+kiJs3miX60Txj0Flfy3ENjZtusRhHE9RF9vHcddCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

The SVA code is wired to assume that the SVA is programmed onto the
mm->pasid. The current core code always does this, so it is fine.

Add a check for clarity.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 6b1896b18d54c7..b2763faa17c8dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -599,6 +599,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct iommu_sva *handle;
 	struct mm_struct *mm = domain->mm;
 
+	if (mm->pasid != id)
+		return -EINVAL;
+
 	mutex_lock(&sva_lock);
 	handle = __arm_smmu_sva_bind(dev, mm);
 	if (IS_ERR(handle))
-- 
2.42.0

