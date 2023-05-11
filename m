Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA9645;
	Thu, 11 May 2023 04:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHJIrguak4LdE8gFPJnKFOi23sMFFDai6hILN4JJKhrlFiGhIJxs2MO7g5e8jXvHV4tQwL1iuZbBjoPF1+K2+WPe4t3zKWfUt4CxGx9dsiYEX16V/JhT+V1pNjIDWKMd/L+XVa2/MzLF2U7TmUgZQcOU0XO1TqC2ithQVEc+5UnFnqgC/+1NkenS+ct9e7J6Qan4DWvOEuExtDjVoddKLjwJ1URDhrRVNphRaNZvn93eoxwWWwzez4UgoqPAbJhMWoq1T5xE0AZrUullN1DsQ754JNQj+WCxcOCgdN5bKgz2sbczVF8ne5UDS4WZa1JfRbo9yJ6Syf+0ZGGX4gfpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvQ1zJOwx9jinPR7Tzm/oFbqNYsF0WqQGrn9NsOSdrg=;
 b=HHW07FnrkGYSSIfcfAyIW+EQSmhi3+47xype0lOIApDSV30m9oe3X0S+jiadZuHQlD7mRDT8uHabJX4DHJdC8nAMMmFj4LQYeFya/hMWJpvWvViBq8v9CrpawCVV9iymnV0bGVmUpy53z9KALyF/Q3yfaYcMaDMuPqwPF4r9Fz1G+a0RNQSb5LuDVB1L9ZUP8Yqduk2YMR7N6ATlEjQyXpVtv3To7940XH7TLes9gCHTC6ega2ZhhGoX1O5GX9b6KndGFtmhcSjeGI7NEQRX4Yw0973g6xhhCTx4CEwWfVAtYc2X6dbQollDC2ffkc+5wgEKs0N115Mduvi9j5lGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvQ1zJOwx9jinPR7Tzm/oFbqNYsF0WqQGrn9NsOSdrg=;
 b=Jr1Dfpo+EC/a8yrJqgcqXDiEBRyssIaVbjklBdf1ZalLPDgdRdwlFnW1W5pBbM3xftVyg2/3RcMNU4/xHxsBIA1As4BgBNcccd8oHHzRAQDLbEMmJ5Y5UdtZLSWJkuy8Eg/7EonOjR7GPAgilFjl/oi9yrMZt1qFG+taA9ckxmCYERoswK0Ur9jUPT8c8sejtpZMDAz5I+WYucXpF/iheK+Go2b60aWZsUWJktaBnxS+iYOXu1ggvxvpqUPnQAvncbOAmFMcWioszBmsxTGHr9RrJH0kg+euKQXUfQaR1gOFnhS2H1n2Fjgam0IIkPNgIaf95zrbBrhmqa/1mpzSGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:26 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 08/17] iommu: Replace iommu_group_do_dma_first_attach with __iommu_device_set_domain
Date: Thu, 11 May 2023 01:42:06 -0300
Message-Id: <8-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: b17d1603-f621-4796-f122-08db51da1b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0WQLWsj4bFBCAG/ZAKDrnZEetuI66TcH5NNOvavQKVnq7VZNaPdJzLxMLJOAacWKQrLZF3qyGynf3UbL9EbpTJ/fPLv2ezgx30G6auSJMToQYFvlNu2VD30sQrOfiiHyJ/OWhuzljRAVE56dkWJFuQTnIM4lyKDPZaeYc7dfI+hvV7GVpP3416yyy81nk0+GlqCgJVgV9WNc5mvYbz/AigqDfOqWPVAGnOUilaqkyEzub+DjXLcR+mZCVjoTYi9MEp3CdI2NM6e3vrMsMx7ED3vCjYGXIaomFqofYwQPqtlRW/Rul7D/PFAwY6PigCW/b2mXoVSZc8ERI2nLrSilVGseEYVtenyoGOwTzo9c0BX5ywVhCJ/SYW3Q8br34iaMHF3m8YKhe6isXOvqAScz+SFVFp54EmtuVns0OUcPN5x6QzHVI4npZwc8eKgZDkIgR5Lc9uwNDGYuPy12G6seY0DHpYW9EI851Eqb4/Gbsk9OCoifCzjzCU0DyHOYjS/Bu5aS3D+We+z8EQN1O4fNKpi9CfZ/tCrai/HiNfYJed4yGKW9Vp7QM05T/SWCEPte8eE3q+k8K65pQZiJV1oAyuRfm0aCmsb5HUkKDWm7bQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mDnzZQzThfAUWAc1vqBm4ZrDUUQ3xtIZi1NHkci40H6j86DeJKnM5Oh5GOr?=
 =?us-ascii?Q?r4xQ/gqp3AXEdUsE1gMLquR8ZsjbtfheVOSnFx+vNJEFbNx1PnXXWCneOAZp?=
 =?us-ascii?Q?8a1DEX988QrY57r31SxxchSyGDl8FdUlTx5NNOav3B1NzGuBE33ZSrwGVaBx?=
 =?us-ascii?Q?W5VkMPbU5Z8rCdHJrT3ijTKkdn2y4nRg2vR8Fg4hXyr/xbVrK8HQyOOUsRCY?=
 =?us-ascii?Q?J9QaCx6tJCD3CaCOdTiOCYnTKXNge2DUYqCGC0kqoZX01ZA07Mi6HXbOWZ3N?=
 =?us-ascii?Q?JwL4P60NTNU9Do8YQldHgSekgtBbimPXi+FUawLMU+AdUt1jAjvJCd3bDxyn?=
 =?us-ascii?Q?YFeO1vAKJI0fBVPt4qyVxXb0abzSzOUx6v5uLjGPukxDSUyB6j4PO3VLWaTQ?=
 =?us-ascii?Q?7mGIxCfm29+HH0PtZn9fM1sJaXUsVbgtpuQk90qYgxPByyoVZ9c/c53jfbz5?=
 =?us-ascii?Q?1QeDHKTZGXXsBncDgLBPpKdTHN6/SVJAuUT5G1SU9cgVTJi2BYINwvl5EWsX?=
 =?us-ascii?Q?4v7kyMy8ngLyBEUVwAI+ZFIY/aeNFKYuvSQky+dcO061S3HFPdVo96KOSMMT?=
 =?us-ascii?Q?Cv17Sd9/zx5uldIGYCoGsOeMeWFuRLgKKzzpxVl3QvQL4KmZMOjFuAAXJXFT?=
 =?us-ascii?Q?OK2i/JvXbnHNa4QT6cTR1Q0uB4JuXqI7k+5WWdd0G30P3614CdRAkhrwRW+I?=
 =?us-ascii?Q?tT0Zyct4Eudx1ZMGH+pQpQ5fFKARbeQ3YDbdP4xUy34XEeACsJCZ3qW0ZlzV?=
 =?us-ascii?Q?TflQP/mGQydGSXxFinL0KR++ygX8UqyjA1gozZMFknST5SwJU4rvehrtKXoX?=
 =?us-ascii?Q?JAaZ76NzcQkGJgv5WpkpjI0usyyu9BxlJsBkOUTtRZssMv1nKVyHIRGHhvgy?=
 =?us-ascii?Q?unGG4in9p11YN+3xBwVpO3yu9ktCNedFaV+96BJ5o+dh8pY6AkSU3f0FSZjU?=
 =?us-ascii?Q?noUkymapVw8BGF1+yKLw5seT6/BB4c6lOZTD1NbkIgx1+Mab1Zv4+Bpvedfv?=
 =?us-ascii?Q?7urxkzOOcfkTcO42gszw1uMoKBCrhziZuuAP7mVj6Aqig4Ud3IGtnVCOtGpz?=
 =?us-ascii?Q?s51yHIKuIvb42c/F8T65mSjafAxnFoh+Kd+63VNAG0qQUYSgzAChN6yzXdwk?=
 =?us-ascii?Q?yJnIg+RpFwuwTrIPYHffJmzqMUxhFfcPblbU3XhvMobiytp9k3Q8mF9Glzuc?=
 =?us-ascii?Q?xfjENORIRe6PDNZXHRpf+p5C3X+ycGGhoIcyfHDCrM2V6oFdlZws6gyY5wM+?=
 =?us-ascii?Q?KYbGVGpY9D4ZpLI6V9kQIh9VekMnOGCtI75Pn2C4erV9iLOJirqEg2A9J+Kq?=
 =?us-ascii?Q?VG6I40CH1P/YDmoFKsyaAW61Yy8bPALUEJFWrgOGZFij7dOldasuLqXVKY8y?=
 =?us-ascii?Q?ReBzARPuu+r/KAVxstsofFxnIBtZbq6G6FP8UytVZnpHrHU+LCcTIbVShlqW?=
 =?us-ascii?Q?G/4NNwcUfSWCJmxzhx5pqhOL8kMCChlLRTmAziKU+f2nSys6nuYCHOGi9M05?=
 =?us-ascii?Q?2H1D/GnOoAOmK8kM4gZ+y/0x2FWdiZ3m6OGkfJC3PL447b4HQVlsoDP0guf+?=
 =?us-ascii?Q?4t15XlbYH6EeFr6ZrtwK3bp8S5wUk9EHhVLgiYYg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17d1603-f621-4796-f122-08db51da1b3c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:20.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: negi/xg7CHpV5POIw44C2reHvxqFv3aQWrSZ9JJ24rQpKTBpPnMziHR+p+5yh4a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

Since __iommu_device_set_domain() now knows how to handle deferred attach
we can just call it directly from the only call site.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5ca23efd2e048c..8b9325565b3b48 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -106,6 +106,10 @@ enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
 };
 
+static int __iommu_device_set_domain(struct iommu_group *group,
+				     struct device *dev,
+				     struct iommu_domain *new_domain,
+				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
 					     unsigned int flags);
@@ -401,17 +405,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	lockdep_assert_held(&dev->iommu_group->mutex);
-
-	if (dev->iommu->attach_deferred)
-		return 0;
-	return __iommu_attach_device(domain, dev);
-}
-
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
@@ -442,7 +435,7 @@ int iommu_probe_device(struct device *dev)
 	 * attach the default domain.
 	 */
 	if (group->default_domain && !group->owner) {
-		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
+		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
-- 
2.40.1

