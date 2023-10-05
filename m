Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C603FB1F
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sF8VdDrE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M03oBnnjwwVXnFk6EgI1tkA6+DGwnf5MVSmplrzCJNMDwCuSbC5mKf3Y7sclx4TFdyM4qxmVZ50VVRdxkpUO3Wp35ipay5U5FT+2A6VKBUP224kR+iWEBOq1SclxADBAl8QX8oZQU2jCKdbbF2RV/pQz37koGYYU6n0SQs1d/Y/s9fsA0GnaXkAxOtrC1gjQMK9z+i8ibg914pxxiYEBTMsVvVpy0fXfDbhpZup92Q/5XRsz0GNDwwGANgRZgJqXvxo3ffvbbp5Ha6rEbWtilQoa6rlcxH+QNb1D2OV93viJk6/o9w9FzwE/mAl2IFxPQBadhmKvjoJN+9sNj1R/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBaTAYy88SBMXdqFpzPrIzUmB54W6lL2e680QO64TOY=;
 b=O6HLhEY3MhjnwWFXtn9AcgYVRNyUUWbHj+AWWKVfOqTkBNgSmt5lJA9akdtgqfARN4OxfLD30GG5wGIbgUsgFPwg92ud/TOJBmaqtSc7NngOrK57M0LdHzWutZth57oqLhKRirLVkCYHmNg4cC8ywCEVJz74BXEV+UGyeg5DLDydK/O+uixUiHkVFZPqCzyW4vb3Z0k6L1yK6dIv4AAR4mk8OzbrEJNA0F+/kDtEd52oTGpazMMKOhpflYvR+QQ0Km7Wy2InDPxQWWUI2HGWjU3N7cz5baSzjvNOWVptAzrWB+MOrhPebxR+MH6d2qxIz+BxQSBb5/23xOzyB9/Kkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBaTAYy88SBMXdqFpzPrIzUmB54W6lL2e680QO64TOY=;
 b=sF8VdDrEkIlT3uZzimiMHm2D18rL40axcRYLjqLg0DzleSpaMSIbfWl/Di1jxQk57x43mD6DHKOqUt3MjUxzcncT5fjI5srp/BQd4maLdG/HChHVUsTdMFlNtTFUlLZJX81Xj9AHIm11CWHEVE3EDdehMbtMAyRHxgdAwWldiO/LU7c/5LkU++V42KKCe/TAVLaKe+aGijgq8THvl5JpbcrtwQfMmWkopWzijFeIzfdEVORa54eCCq3MLaj0fm/ZpmHYAgFM9hab6Ia522d73gNMGXLrPXT9VBlDH5sOW44LHtO/EAtTbHjrW0rmN2l3bSqxX1k3rVT4hBwaXIsGJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 5/7] iommu/arm-smmu: Convert to domain_alloc_paging()
Date: Thu,  5 Oct 2023 15:28:16 -0300
Message-ID: <5-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: a58d958d-2d60-4612-cccf-08dbc5d0da27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QDpcuioknH+mCvfd/sEjS+hUwtUI8lcoGlCNVfIHKSXqvmBxKWLExWf32zkW61YbM/kM1zxt7MsnLFrTEc8EkaFRjRFeevoHMLdSseKXdGKQMCWDECRsA/xnMQoXGDYuqQNgRsUBhlmo8xJzGCqbEim79zXEwxDLJH/0JPAlbzD4Rjh+V10fSBqJU/L6TzglBKKOTfSxrAJrUJEdb7uhzYF2BoK7Ox2/gKTxNke8yzSwK8O6MSQqpyVXXxBvfQVtwAwJyChuhp+DqZ2LF/7K1NUvZqIAJj9kDXHOWCjA2vge3fAx0y1sEHDIAT5lDFh7wNrrtG5CPa1lhcpFQ+hbb/Caudc7Es+bOc9v1rmqu1Apabwcm/QaNrT0JDXylYpQd8jTkLUKvzGbIY5sW2ytL87dbDM+MDFcirLzk4enzZ0S8ebWOo4w1leQwYTHbJQaR16Jo8d/qV6LYSTbNQ4JUYG461i3el23tQ39NfOpD8sRKK13VrQT8U8h5tnbQr3Xv/8dNIYbHlpPtzhLCBCIbX1vlUX7f77Taa5pxkGgQLwMDUKrsEBW2T9KFJMmb4qCRF99ODu3qHhmGSRAzvaMov7187qZuIqG06l7BQTFkcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhOSL1GGWT9plX61spuCa555LcUa4PEy8G1axmYCsOmGzxy2UWEUhsG5m+vR?=
 =?us-ascii?Q?XgJohFlRO/dfpQZKjdFkqozmUi1qahrZDgvsdd2V4yO2mgZLhwEdc0GupQV8?=
 =?us-ascii?Q?iUggJJbki+eUYLf3oV1uRgS6L2Kc5KROsOGCajGUFVU7dzrAMKJleL/MnlNE?=
 =?us-ascii?Q?+sJ1vp0RFBBwo7fodYP51JoL5aNkSty6jx52skvtOfyX5nbLyIzjYsyBc3AP?=
 =?us-ascii?Q?hrAAn9acm7v3wt7eZGGDPr7ytAkjXfpSVljbq0suoGljwF7+3au7mB0eG9zk?=
 =?us-ascii?Q?Trw1M6toKZgGTUS7nmkkzHeb/DmbVblJFii2P1JrcxnZM7BQG2PbM3BTC+GJ?=
 =?us-ascii?Q?YKRWfDVKhbgANREEK/nkf4pvI3t6bU3gM8kUdBHxrJeWzS9mYXQr0nE+Wchc?=
 =?us-ascii?Q?FY5sJkOIslfqcqfq86/YnknmFYbx7DP7R9jG2Du6QUWpPNkiSsq0TnxxJuwn?=
 =?us-ascii?Q?7zlgLICes97WGlV690OAyyFapNwhjE6TETfIA7MSxny66Qg2SMy17W7BT/gb?=
 =?us-ascii?Q?rldJtbqDkmoAhTUytkiXI+WZO3EAiAQ9b46D9uRbF0YBAyzNVPbeAzh7IpUz?=
 =?us-ascii?Q?8rVqpqOtFUsAzKwAUN8iBiW3Gb5u+OfGMTNMKywWiNpfxpUwuuYhBkWjofAv?=
 =?us-ascii?Q?86maTn+1MTB/OvcwHy75ld6V2ujzGbqoXKSSpndyDNAmp93p6kV/huHvWJ08?=
 =?us-ascii?Q?MwC0zJeJSZ4shUFi306c+eCEpcSg6zttPIdc44Tat115vI9r4XoqR3NJlYoo?=
 =?us-ascii?Q?VlDkkCAFYRIW4E1eHrZRP1gm1XtPplHRaDd491WKZidbSi78hAcl+J1w12z3?=
 =?us-ascii?Q?UPfryMxrL5IGwSUb5d/d3qe0ikJ/tg2ZSD9uesLlPu0qm/J/qRahvcx44lNj?=
 =?us-ascii?Q?yhDiUyWVlcu1dBiTuFfGvaH1Y3KbnMQ5yE6j+AIywVCy+PvG+/6Sp1jTuelO?=
 =?us-ascii?Q?RpfXrHKna5OaND1wZg6hFecl+ktjz+8r2UO+dan896GYeOvDbEXumte+do/v?=
 =?us-ascii?Q?l+48uFAIW9T6ug3ONfz1dcwO2TQt1SS1FgV0P/mDNP4WJl69L5VizhPlJoXB?=
 =?us-ascii?Q?NLq7zieDanFNRKznyp+Cn0zWAKxSUjNGiWG7iOqmfnygJxqubzog8H0xRipU?=
 =?us-ascii?Q?xJ9ygp/ybBBKRs7l0gk+t2ZkGbh16fvCYxa+8gq6sYFIqHrjyqthJse0Sjay?=
 =?us-ascii?Q?RQy/uDZKnl567I1u3H5rAgkj4X8m+3IbK7aym3sKLs4lLYcsV4xDzkYVS75D?=
 =?us-ascii?Q?hJG8aOwaPV1xuVCvuuOZnj+Sy9dMt+7YY0UHHiupllMaD7P4cucJ10Nno/pO?=
 =?us-ascii?Q?ZhgQlwFmStJ8UnAl7h53lwM3rluRBaokKntPUn5D/ddQzKHMpkn2HFQmF5DS?=
 =?us-ascii?Q?aPTtqtXby+yNOPfrdOtfUxoYd/lbiGRKcv7lf2kAxLl1oinVL9nVFCqNtg3C?=
 =?us-ascii?Q?CO8zonLaNG4Mi7BP2bcoYB/cgDrWkr7MgnHa9B21L42WPVDgngu/haKNCyHF?=
 =?us-ascii?Q?EjzMPYeHM2318vYo50V0oZVvfoek3BGamKzEv9gR3newyWW1YkvpU8oRaYPR?=
 =?us-ascii?Q?AdQGIgr6AIn4rN2zE1Y6QJSweiz31XTqKKMmZPVk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58d958d-2d60-4612-cccf-08dbc5d0da27
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:20.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cT8spiG8HUoKxSzSMhkapYqDNvliO11w9FMQ6fIIkh5X1lJzDhOuP7u68wAUxjk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Now that the BLOCKED and IDENTITY behaviors are managed with their own
domains change to the domain_alloc_paging() op.

The check for using_legacy_binding is now redundant,
arm_smmu_def_domain_type() always returns IOMMU_DOMAIN_IDENTITY for this
mode, so the core code will never attempt to create a DMA domain in the
first place.

Since commit a4fdd9762272 ("iommu: Use flush queue capability") the core
code only passes in IDENTITY/BLOCKED/UNMANAGED/DMA domain types. It will
not pass in IDENTITY or BLOCKED if the global statics exist, so the test
for DMA is also redundant now too.

Call arm_smmu_init_domain_context() early if a dev is available.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index bf5f541be2399f..4d69bb63ba1a3e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -842,14 +842,11 @@ static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
 	arm_smmu_rpm_put(smmu);
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 {
+	struct arm_smmu_master_cfg *cfg = NULL;
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED) {
-		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
-			return NULL;
-	}
 	/*
 	 * Allocate the domain and initialise some of its data structures.
 	 * We can't really do anything meaningful until we've added a
@@ -862,6 +859,18 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
 
+	if (dev)
+		cfg = dev_iommu_priv_get(dev);
+	if (cfg) {
+		int ret;
+
+		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
+		if (ret) {
+			kfree(smmu_domain);
+			return NULL;
+		}
+	}
+
 	return &smmu_domain->domain;
 }
 
@@ -1602,7 +1611,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc_paging	= arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
-- 
2.42.0

