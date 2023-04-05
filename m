Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362B322A;
	Wed,  5 Apr 2023 23:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBQuok85wnxWVdE47m6Imdzz1+4MsBr0S5MPQfhGjI40C04Rq07Ct709IwRD9LpD9VJoUtq0y4bFGOpZQc+0v0rd7EuzXycgizcxa9Z5hzw6HnNjRi5X4ywcnZx0KRiYuNb2ZV5e5GBLlYl3Q4TgnRXOZvxe5+UlrGwZMW0EgqeI3g/zd7MVEPNQdtBVcbNJasp3YSdNkBQ5ZA0jecdPOchKztY8vddMrcpcIEzC5jOltqPbYtnbz4XO0EbOOJtQDOX1IeHum+u9auKh423Oitem+LIYzVNHXP3FiP+KHKbtT8+cB1TxkX6dUiG1EpkvxkyZ8DNsGfu0m96wcc5xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpqhqExfhp8jWBoelqutyaC4DEq1BOUlI7Vxm5GilB0=;
 b=Cx0M4pYtwCig+HoTqLQ5+jusjq9/am3XG3gKLHwd5kwJKjAlRuz1x7YwXYX2kLuAq4p5YwTiq109ZITFzbD+GtYUMAQq9KB/NeY2IVupPYeSQIXkmIH3VIDRcikwCqT0ph0Jp3YAxGHfXm/9sWzjFiV2DaeecnyhQMpgBm65nHkAyrC7c74hm2djOXgzXASTZ7aQs1bK3IwLtvIFXNqiWapskcxVhdxHNCdMgS6JndcgsC1DoV+Ctgud+N9qluLgR68ROR7UKkmWBSsgS8ek+HJBnz+OzzXVS6mya65OSE0L6GqNWu2ZQb5S8wkzHlCj8tDMc0ebAgXWhBb07rMh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpqhqExfhp8jWBoelqutyaC4DEq1BOUlI7Vxm5GilB0=;
 b=hZJ6n9SM7D9MqHUdGVuSJRq+NS4icxFpIxpvapcymocNxkNKvfCS3dzK1agWZJimsFlUefoqB3yltZEJDujY7h/rkFvKLmHZlQrOu8WI9Oo28rZ0FqrHTm59GCl09k7JZzVmMftwq33+KS3+YWHBtwDZiXhgV9iwKEiKQcodZ7Rm2HnQuUkfH1oKMJDFrCdm1LamBFtwjhIFt7v4nTIap/l2oDDAJjIECm8XLCW4XFNwh7l33oDxeqIiyZZq9Yf8Ilw5RFZyNZ+7cABssvLAiDr9jDwbnjBT627D9OVJYw78VKrmlq4PDFvA1qV7h3ed+O3nCGuMMWhqdKahaiEHxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:39 +0000
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
Subject: [PATCH v3 08/17] iommu: Make iommu_group_do_dma_first_attach() work with owned groups
Date: Wed,  5 Apr 2023 20:38:29 -0300
Message-Id: <8-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7e4509-3488-4cad-edf9-08db362ee204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KdefJkq5952Mq4v03GYtzcDe/Mw8WuLvcUpfY1kVNkHEMMQAoAh3/1Qm6OnMm4XZzcvz2W1b7szmp4euix3r8+4Mrx+15nDoH9q6fROsP/RH9F+rPR1mx79niTMWOYkWij5A6MDZAT4BJfypjrV4kcdSQIuvVjWcAiNVg2bFN02Nt9dWScoo+D3iwqT9B0rfezPkRwXyG64e6BB5NpzDyOz52J1JnfTYNNzYvBz+EgXnstB/F6D7mGh02uH2I3y4BurCrjxw4JPvvVK9ZYirFpu8UMr9gncLUkDV4ZjIOqZScFUyxrguITWAMUFe5NObXioSPrnVtGNaFRNC0O6mSX1A8VKYIPKCvT1NoG8L9Nt092RfxBTRiRFbqN/TrmoFDugvc5ki4QvXjG5kMXJDWxR7k0WiQKyD7dHk9Ss/ac4/Eoj4n9aNm8xM5ahkXROublymVwt9+COKRtobJSMPkS/ynQLa5MTiqC2i9B+l7IcoLAWiSf+aiFi6dfNUnM0jxGw3hjGmCuxhQDo/ZZUjVrD4jMCTFU8PeFXy2kP/tsMC3B7j9DjbyixGuy50sy99ExPQ3u6gqkQiy8lDpsTX5oZMQvfMt+LqV8blGqRkHiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMAY5di028fXu1pg6tuR+dGxRKIuXs28HMzv06pBWE7ZjRKvuySRj9yCmb19?=
 =?us-ascii?Q?pHudSBVWNvNlHOEkZV++D6KM0oR9zKBRBYm2B6YAmPGPUz8U/RY1aPxsT7ll?=
 =?us-ascii?Q?4mibp8PiYiyVZtsUvgxUYl9boJQuA/VIKEQstSw25AVfhky0ch/y+3iIr6Yw?=
 =?us-ascii?Q?vHFvPnJuzCwOCMfOygQUM/Ko3cKZNmHJHlEpPo4UEr0quhe0EutNa4H0KZon?=
 =?us-ascii?Q?VqudrAW1ZEgkvzVSXNG3ufdS+GzMSgVR3CvjeZwSJPkG7y2DeZNPdAdK9/QF?=
 =?us-ascii?Q?aTWiDnrUSKuFnv0HEiY/RrBBPnSd1OLvakOTzqyiKubmMbejFajrFGfKEzRE?=
 =?us-ascii?Q?A+cA4oAlxTlfovvmxOWyKLz98OD+NUIb2LchIdgYQ8GvXvU3PU06h3IQNO0Q?=
 =?us-ascii?Q?l5qPSTl7DeUKoNaXWb1bWdSlezoR++Jz3IOiajNza+mMP81gZOLitpp7bjW4?=
 =?us-ascii?Q?EEbgYi5V0SGeWfwMi4h+c1iD9doHRtC4bUwzZAVxLakCHZgl7coL4wkX1ube?=
 =?us-ascii?Q?3A/9AuSpHvGZo9BhbayL09pdQjvFxvk7Byv18rLqC3RQgt0dBMlj12Wz+3e0?=
 =?us-ascii?Q?WJu1trAVTZRC0MV2eOsg26cbQHPJMpU04IGyxTgpzgx4wjSRmWU9Wlw8zoeN?=
 =?us-ascii?Q?hWHVuQ45CkWysigyLJnhx9PO1URjJH/olbGy/auIXfJWBE/Dw0jbcjPK6GAE?=
 =?us-ascii?Q?oxJNUWAr17WmSGHD9F4dAgi09KR7yE9aYe/4qdVQHfwaqYAbi+/Tq6Z2GRUZ?=
 =?us-ascii?Q?c1sL+H7xJkVaPd5JWLlcpPSIW/cVr2ILLLUxwpTQjNYVd11Sk6fOP+7mqmtK?=
 =?us-ascii?Q?/aTHu1WVp6i+4CwVOgTa4pjn23WpJ04fRNL7ERQAD37tfba3JmcsNvscJPj1?=
 =?us-ascii?Q?b/Q0eBlnWpfuurNpifiM2bZo4H/HCx7vX90GewOgQcdsnrzCpMtXxBwtEgLA?=
 =?us-ascii?Q?b9n4Elmpv0KWYeAL0EsXG/uuuo84TnrwuoUaHHZBHH4hp3sPl62WM6143BfM?=
 =?us-ascii?Q?wMk2Bj2b8m3HOGDbrjpc5zqvfhbeTHtEflvjM7hwuzIOcpLlqLzsejInYhVQ?=
 =?us-ascii?Q?A1Cz45fimc58CuKBwkZShlSUY2ooqb9UVfqROkXIwKmbckpPboHrSyJL4t1Q?=
 =?us-ascii?Q?ox1gkMs8phs+VwZ7xed0z5nTF/CbRKqElgmaMKxjXGmiq1eOlm/iEcgAprQH?=
 =?us-ascii?Q?IVp7WlH41I7dULjBA4jZETl25EZZCAh6Da0qZRhgmdYbBXkrDdzACePrGZ9J?=
 =?us-ascii?Q?dQ+Vj36cWkUrvkari8m01uw38kPQ5o2soTveipc9HH2ngUdtwCGPw/LTtnCG?=
 =?us-ascii?Q?8MKaPuM8ZXmQwMlK1jZyGlno/4Z/d/DHX0xzxjhdwpydu02p7xXFhGRi+uYF?=
 =?us-ascii?Q?PzJ3PHbOO2W++VYIlW+kNa2OVbIpMIhBMXvdAMj5/pmGYLCb0mzFJYYQPVXr?=
 =?us-ascii?Q?zbt4XHeSLHDxWzBvXRIi9caxzqC/xn1YnGPuxq34Pd68Li7UEPxy3Ll0IkDI?=
 =?us-ascii?Q?tDeDGAhjtWtgaLybsof5F6vnFgT4u3r/qrSbsYdSNIGT3YAqhwxbfc6f/A97?=
 =?us-ascii?Q?KDw4VfwWcmUkAGot3lv+itc7TIXS7jo7lyPtrMDC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7e4509-3488-4cad-edf9-08db362ee204
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M/vX9KRJeWTTZs7peLdUoBQQ1+XT/snEBoUBdBOZBBfe4BlgcujVgZkih4x0RVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

If the group is already owned then defered attach should not be done and
the device should be directly connected to the correct domain.

Owned means that some driver is already bound to devices in the group and
is operating the group possibly without DMA API support. In this case
there would be no way to correct the mismatched domain.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

