Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69FD51E;
	Wed,  5 Apr 2023 23:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnxDHDUghig2ynoe3x5ecxjOQR/4+TQEbXv6L39tbWKaloRwuRuIUdwvM2qXaKIkFLp1h3WEDxmj08RqRQzC/a68lKnEoYWxSujKd5+ASVQMWGBtWpk68Z/6qKojeo4uPRlqUvQoxBCSsAd396Ct1k0/kyk6UDflr6c7R0tWezdEZ4WKJPDqHA0aYwioqNqlHxkR7VoWt50Obq8fcGZDaFUsh+6HCEyt3mcY/6p5v0/sHE9KErkPZv8ocMstZ53yHYPTsrjbhOdSAMdrZmZ8XpZy1x7kZ/HtdYQlqkE4gRFFEiwBhXJ4ViNocXmhCO90lQKRM3NDuueNnn+orX8CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=051gHZCzsAPLxJvzfVAJ+0Ix4Kqa79S3LsCxWX4IF94=;
 b=V0liIqnOhzwBjjsDhrVmt3bd3cQPTkk7KS03ViIdr1l/MaAb6Mg93RMiQpozae3oKyJaosoWaPXhsNwtbOGISrwheCaoFaJCWXvhLN94SfugQ/vtK+6ciZqGB8xZvM+/olbAxs9oX2yGpf2FFG7DvIkBsk1JI7xa+Xaqw8hys6lDRSRuRi62PMOyhmF10uRX6t/5Gnm0OCmekGu46/9zkQEFWbrPp+56kUfakOiuoQu37KiKmowi66FINZuaqOvigGeHxcuzvI8Ou6eji/ZYTN9u8GVJd52svzq5tJ+legYJtjMAnuEd/8/zUnx4mYEWf7qUqYMuP7IiZUXS1waRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=051gHZCzsAPLxJvzfVAJ+0Ix4Kqa79S3LsCxWX4IF94=;
 b=NdZM9TsLluc05FNtnNQH1G5MOwCOGAacDeLmmW5RUo2+fbUBkUGg86BBU/bHi/2sYTb5GNhg4YK7phPZCMSaqWC7UKuWzv59Ra6Tr3ipm5K14U10429EXkhZPCsEWbW9NOvIMv6FxqTU7CQAgNDHE3+tyOEUC/2vDlYZtKDRWz6D4PkCGk0ImPPSlTqH24jWijSLuugbYtsl1IXfNRjeFV1hVfXmdBO8GOjUJybShKgi9mMlm9DtskI3ZAVl6GiyeqKn1Ip5JOUrvZQ8KbeqtZUQYPICBcFutpodgz5SByS0Nn3RWMnIgCNLRjHrb39LPSO4S/OjNakowDYWP3Xo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:45 +0000
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
Subject: [PATCH v3 06/17] iommu: Replace __iommu_group_dma_first_attach() with set_domain
Date: Wed,  5 Apr 2023 20:38:27 -0300
Message-Id: <6-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 4242f445-c073-418b-56b4-08db362ee2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hJaD/tSJwZu5evQM7W8Fu+LzfPMm8QrVrZ4fGGNrHgZiRalt8B0ju/AVVYChZwyYvZx5WHFvy06u46u91x1R2XlUmbZzC7NZyF0RTZd8RQ79UN5pyOXRc6yYAE2fMF4HHHbpD3nQD8bjgi3iIWeAswIWVVx/9T+vnijwYQ6gsTy4BpuaXVz6mJo3vgc0nYdlnEpEPwyqiwQ4GAEVOiIzZMZyjThVwcq1w5SPLs+4uTRGsQUt/wguC3PwACvPufD7Ki6go6K2vpituu8yeFs1FB4g/MZpgZmjh2axFSRz930sODBlGBt1F4y5oD8PpXmUZKxO+EP7AsBfNEdJz8XPDPQlynTiBK7I7JT1wT/BE+wlxyG7JUs5rfg4CpP02dMfXHSDz7G7OfFx4vyqbiorMnuQ06E7ur74KkKn01nwXiMGtOoOD/VMGtX2TdsV7Xisk5Apbxu4IfePB/lrUPlUAOMsc4GKTl3HPf1ItSFW1PgyMdlZCdzKzqhADLqRwBkqLJDgNkCkfsuft0RFb4PebEELNB6BmSQpHSZjSqFrHBcOA0EwM6FuxPUU6YqIWh/DECLWGoy87HVpH8014hJUYfH+tJuOWbMCdin5Ntw2rvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uMPbnWfMw+7A9fWpq2gVct7jaPWZ0s+7jyrMwisOGXAvxdTE1ss1zccestqS?=
 =?us-ascii?Q?Y84KvBoszhDISnPT0YX92A1kGDXj2d6frhnWBejBUUqPGe14Idr0LK9gUxpm?=
 =?us-ascii?Q?SVfaDfLmjnWULBQTxoMzX+a6Co4K7o/kGo3xMr9Nc5EYJQmdYgCrFhBHeDFe?=
 =?us-ascii?Q?2UpdhbApX2gqlzzRKer/YC0uH27nmJU4X89Agg+6VYAeIrjkMSqVdZ4+OToL?=
 =?us-ascii?Q?HgMYx+KnqlGjKYTNlwWDDIUj/MO45ocnROJhu6yoxmlqsUeBHLG3bcY+znlk?=
 =?us-ascii?Q?TvNhn8erzVVf14lsmVT5qo29YuTgvFksrLsjQLDwHM9pLp935u1eCyp1peyC?=
 =?us-ascii?Q?kS8kvQuPVCZbdq24EJFDkQ06I9vRnmYyVJ9Vz2qZ1SJYri7krwYggW8lBGn0?=
 =?us-ascii?Q?uDnAqIwJyKLIFcWaUK6QTwHQgCmyKGA/egPt65WpiSNuAhlmOgAbMfuFDsnp?=
 =?us-ascii?Q?lp+f1QCbQlM5VOT6wpZGB2HgukHWMIRmkAH76BMHYUV3u8IG7POgHU9955MR?=
 =?us-ascii?Q?MsAUl8kyaGlPNwLOJunAdyfNsaei8+4mXBVKFkl5LUOYDTVQihX+7p2i+XSG?=
 =?us-ascii?Q?2EQ4W5E/di79VTY/VoASh/DwCOvCI5ja6bi7gOB/L9zRqgYYJ8xyGatYcvdx?=
 =?us-ascii?Q?+kKh/RLTFqo3UnaX8GuDJYYxQC5o6ZC/SbvEKOMD9//+ur3NfTiQ3VJONNPe?=
 =?us-ascii?Q?sXOvlgmTyAMi1EbfLYwQTKDWq/tm7psicqKitQ4UHs8LohpcUpBesuszSDpy?=
 =?us-ascii?Q?UtaaHwL6FbpazNlFHiQL6w8KEQuWuVnaSYrjhbdrKfdXtnLYQRnN1XLeoAo/?=
 =?us-ascii?Q?WozJLLfb28i6KB2CdAUKsPUEXkzbhwo2u8MxQnpZSVef5e0WXeke/fNI2CFJ?=
 =?us-ascii?Q?w7U2bH6e9QlRVSf5E4BbZqpbkOhaI8ktZ2tKEbCxMku8pESHwPprtK/25WKf?=
 =?us-ascii?Q?ZtT5ngr8yGnD4+2IQLxYVluPv4codTcahONaEomRlF0/h2BcBs+pafbAyo5Y?=
 =?us-ascii?Q?CP2nU4D+1/bstgQocQrCwfqfg3T8ujpNGFmuw0X0toNtx59tZsveR+6J1u/d?=
 =?us-ascii?Q?aXXXb4n0jvhTLs7eMblr085Dlhoe8qX+oNPpbj37R8jInPBXuVs0QKYsBEm8?=
 =?us-ascii?Q?9+i80FhmWZmTCT06vkarmdlfbfpg7JNueWjEyHTU2wMRk8DzVkZwGEeXFNlE?=
 =?us-ascii?Q?oESjIPpoG1T3lgV9m3oVgPsJXL7yzaIgZhtTo1YlwJg5ZNjZIzF/QPDdnprw?=
 =?us-ascii?Q?cVq0mBDflmzQhaY+jTY7pqquBVAyXHVwxYqPkd8A5Tsi4G4hZBzy8fQjU//i?=
 =?us-ascii?Q?J0ZAW1SQHNthtNgx9wPK2aD2BmaXaiyitH6ySDDup22IKweid9mSeUUuvqEw?=
 =?us-ascii?Q?tkWmw7JQn1V89WwbMRX2Am4GOMpzQFHK+PMN4mthBlRk8AovNushr2I5S0u0?=
 =?us-ascii?Q?YbLuS4YWMuG32+ew4YrXcud18QsCdV+XOhQxqjUJuPW42s9F1/sIrr+G9+FO?=
 =?us-ascii?Q?Ay7FS+iLZuGdrwgXD7jtp1MscTtW/1AHOip12FhwaBLx0yONYW7ZQPYU/t1Q?=
 =?us-ascii?Q?rI9DxtJLngdrmMtpEMBMDj+UAvBx69OGd0xX22md?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4242f445-c073-418b-56b4-08db362ee2b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:40.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2egqH4Yx9tnT/NQNqUSpNvnQScVfl2bgu2gd+T8eRgs9nJmUnnb490nxWpIb1p82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

Prepare for removing the group->domain set from
iommu_group_alloc_default_domain() by calling
__iommu_group_set_domain_internal() to set the group->domain.

Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the attach_deferred
logic.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd75d7405a3051..af3af752c255e4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -102,6 +102,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
+	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
@@ -1855,12 +1856,6 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 
 }
 
-static int __iommu_group_dma_first_attach(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_first_attach);
-}
-
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -1923,7 +1918,10 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_first_attach(group);
+		group->domain = NULL;
+		ret = __iommu_group_set_domain_internal(
+			group, group->default_domain,
+			IOMMU_SET_DOMAIN_WITH_DEFERRED);
 
 		mutex_unlock(&group->mutex);
 
@@ -2218,6 +2216,12 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
+	if ((flags & IOMMU_SET_DOMAIN_WITH_DEFERRED) &&
+	    iommu_is_attach_deferred(dev)) {
+		dev->iommu->attach_deferred = 1;
+		return 0;
+	}
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
-- 
2.40.0

