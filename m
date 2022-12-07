Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66508C10
	for <iommu@lists.linux.dev>; Wed,  7 Dec 2022 20:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms8xn3OHBmfRZE71EkJ4+fJASfiIeZrErM9qKOW+1XGHp8UvBlHMnNKx0WEvaDJL8grDOJ0zb3BxXiWacnsoDjRoE9hpEBKmpIRCmlqIzUWUf3cRA+qfp36WGyNohUyCIzyQH4xsLeMTaEghTyHt7T1cy7zp+K2n2IpdaZ04swPkPqIVW4jKr/T37bv+y/D87um+jMfWIzfBwFfVBeqjGC59l/FMVMRrwI9zkaF9WPGpfw+PYYelZMUrhUzLr4WsWzTL5LW85TwUloNQev0LgpNkc8rdEMWcvFWc4zUB0Q7ZUdsCUTnyYZvfhcbbu+u6UC6isYWw05PfhRj1iM1xWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PadFiamk34MzmIno4tLjE+CZ/iBr/MLjDfpeqd8sVo=;
 b=WiOiawn7+p7DWby7R8f5WnwAchpRWefKiqi3v1TkuD6QPDtzcxDn3pGQzXgHDmvpwqdywf284dK/4e16yYhzposNmdhtpAt6MFOAUaZ8Zffs9WqWqDaDZrHpMiWy+rlt6s3sSNEIsbvd0xniF0JZvuOx4ldfffGuJ9e2wZ2r7HoBASldnnT8I+0E1cVspclqqqWlbt9daQ9BtSCIhL1kYSR/ovJJNt03MUq9KRTxW8M7dWk7zp6WwFw3TjybmSO2CQyVWCC/97Ho5J/49rApxQrI1WpU8Fah6mjlab1uHrAmXZMjl64wsufnF9/OCMoyayua9zMchvLzJJptfZItpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PadFiamk34MzmIno4tLjE+CZ/iBr/MLjDfpeqd8sVo=;
 b=JHr+LwPs4dyDj9poSuiVK3uFUa0GPR1b0tZmIfALh8Ats4sJSapl8ZsGbYCDqY5GuLnxx3s9VZSFrg6olSp2+bWYwzqh+u5kF/EBLNrwgGbCw6M130WSPxzYDd/7+g3OOr2f+Uj6ABCjs2jbcWbramhGYzCCZtxfvWy+mGK2vVKx0ZzTUWf9gXlSCQ8gK6egW1C6n8iqots1E27yyQBO/HDvBCTPcYVg0Fs73uu1A9/H+nj72DyaX9CcclbohrQ00y/xPYhedab9i1pioOSRh/D2flVqeeeRvjJ7+qni+PtySjQiUE9/mOpTlkbUCDJIgyJuS3DajYn8hy2BHfkLNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 20:44:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:44:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 1/3] iommufd: Fix comment typos
Date: Wed,  7 Dec 2022 16:44:41 -0400
Message-Id: <1-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: c56cb14a-b2f8-4645-12d4-08dad893e01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h00dcTSE2NAsb6dkJbuseOP8BFNFRwFwfYnKqbG+msjNDBOGnCJfqH4BaVv+/npIePuVC3dsKd8F5wA6/nYGyXE8SU56UlC3qy0eJenKex9IlzpQ2cUQG7r6Ph1qWqaWS5kjoQIaLUo8knAJIppJ+EVFnO7wsDof3xM6Q/tzflXFxrCEZOlcMq7VC13mSY1A5XtGuqX/gDqRn/PJ8l1uq+fyWIqt4mFsFdU309dIb8CCC3ZzGtO4vBLAAr+gnPZtKMdHwQhe+vGODNSz4BAFEUpJTgMqwqoKkVIux+q3pb5/fztYlSpPC/QfnNdav9kMI8x8LeX8C8c8sgQsvpCWdOs9Ev4S0WVxqjm9zBcgmMLgcHfDuZj5SlHGSL7v/l8yhFh3guPNY1ICHzALDTjUBEq5PpS3uAwkuW3DgciJE2IXK1RffMOSEvi9jchN55N/N0q7DBibOoI6+FXVOpB7pQvozvnOV9uX4/OAX+jT8B162NRloyBYBUEdoUymUGyTwQ69W3QkBy3q3ZQ895mYpcQwnuCxJ3vD1NVi8KgKu15EIw2/sPqpVgt+UEdQ2dw4sD0t40EnNdI4bn2WAuW0RvdSE7BLWpORLT4e8kBRdUlcn1BiL0hSewlm8mjGoelR+kD4zWZrtv9SFx8vBq/42IvnSuKlYhngx/XiV39sjMAbeBmjur3hczz2oiVTDuk1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(36756003)(54906003)(2906002)(86362001)(8936002)(5660300002)(4326008)(38100700002)(83380400001)(478600001)(316002)(66946007)(6486002)(6916009)(66556008)(2616005)(8676002)(41300700001)(6506007)(6666004)(186003)(6512007)(66476007)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vlYurxpYzp6rTB9vE80tAwUoQij6+Mu7lw1Gb2Xg4YOJMRqu0/c7oHzWGOBG?=
 =?us-ascii?Q?Pg0cFJAnSsSlo8YJeNgILFPDCHG3Qx4YRklAIFjwszHU1FfYerLnTF/c+jIz?=
 =?us-ascii?Q?pLM5FT5QZ3ix5cpNbM5HU5GJykSyUiBZs1CF2ih19YPEN3JxzH6GgluFR5Z2?=
 =?us-ascii?Q?KJwMET2c44CyGerl2Gcg6i+Lf7XJ6MV6dAyZSSm91rVPmS7+9ho0qCZyFxad?=
 =?us-ascii?Q?TZ73LATjFfhbIcVtJJvpvWjP4Zb0EwEwXHyI8EDTsEArD4vSt2iXyRYUdV5k?=
 =?us-ascii?Q?wXdl5wwox1AFsTZ2VmDF1btNkw2MICqpiudF8edxSxobn37zouFooOWVDTfQ?=
 =?us-ascii?Q?U7qV+tQRXzhhyyyga8JsqXqJSFRqRVFl3qxc3FA4b59m0ogb3UQKJQIn02N5?=
 =?us-ascii?Q?vKwtbaZ6uRC96/AXiZajLpZ/shnh4Dtm3Rf9Ajcw8aahmb2YGxAXOgfG+Uep?=
 =?us-ascii?Q?Uu1D1lE/Qah1vrjruT/tzy1DZn5+0aHfvhUmSR6rYwL++0GJyBgBdNxBrpLr?=
 =?us-ascii?Q?dec9K9S6J6YAodF8duysBu9y2TuIPol75mcrjBwjULZiOyorAzvg0Djl7Zh2?=
 =?us-ascii?Q?rJ0tb40y8gpapp+mufd+3jTl6uxyDO4F+nhyIqgCuJblYvbYuIzE9baC7w6Z?=
 =?us-ascii?Q?AiB1C07NJzir4J0Um5Sv10AGBINPvsfjVyjRxEm6nLfPu6AE0Twql3uOZYkM?=
 =?us-ascii?Q?ajftEo6/xMFsk+GuM48cozLbpSrHzjuiyTNz35EacbkgQG/ehLr6GU67yRN1?=
 =?us-ascii?Q?9jspBOACyd1NMjMjwJHLU1ftAOvRpEf2sOmj1qfxvJtyXs62LjX8mUWXA4w6?=
 =?us-ascii?Q?q2tUAsKLwCxITQUGsa8xxG/CxMjUYVmsbKdrRFi4CDNe5nHVH1Q21uujPmZ1?=
 =?us-ascii?Q?ucRjj42yuGzIZ8pt2X+j2NpIQtEQayeA8/F9uw0R5oOY1A9E1joGLTuXbI5M?=
 =?us-ascii?Q?6Ot5OPPwWAeNiNTUqD2FYjxPJPP4sHWbaXARhqb5hqe0kxAe60+JYBvvogLI?=
 =?us-ascii?Q?U0sg4kO1T8NpBw78iWMQRlInsGEC2BiI2ZQ9YBegqOcJamJOxA2UL42L0ETH?=
 =?us-ascii?Q?dzD4XEGiTHzDq8SS24oWBCrekcTQlnBp7SbylVLn8td0kG3C+proKmS+jVUc?=
 =?us-ascii?Q?5DfwGFAsVLbbXpBuOfaEmw4UChHJdaiZ7gFEdyU+/dt7jBmI8Cp9kHJTpaq4?=
 =?us-ascii?Q?0t3/TdGKNd8UVdklNeKNjxsss0bwn+7tpeYjswG/sY4/OkPfMFp9D/Pg/BEY?=
 =?us-ascii?Q?7jQqotCZMX/xT1Q5bEAqKbQ7Ik0Sktj22NvZM+5Va/7wImKHbYhia7okqvFs?=
 =?us-ascii?Q?n1f5ie9jYcZbVVDxw4h3f6f60yeGzTktMifurYn9QCo1G7H2YOuunhSE9zl7?=
 =?us-ascii?Q?e8xVANV4lCzJKdpYkxoakIIKaragrT61RnvbcMrMnX+Bw7scYTqsx7sPsq7L?=
 =?us-ascii?Q?HOhg8Lewqxz8688zIjVlj2A2LcftG490Dh98wsTLkv5zXB5pU3rbgPy5cNk4?=
 =?us-ascii?Q?+EHSzdkRgpxuW+7f4DKnHyVCEUb1V8wO1l3RlAwhj15557NIkEWjiR2RkVZa?=
 =?us-ascii?Q?m+2CM1Q5yxKJd4grFPE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56cb14a-b2f8-4645-12d4-08dad893e01e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:44:46.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQPIoNZKjVYJXdu7QXodKAyOWMF/CqKZwoIBW53CRUujy6SU8jTlDLgcteaea7X+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483

Repair some typos in comments that were noticed late in the review
cycle.

Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h | 2 +-
 drivers/iommu/iommufd/pages.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 83e7c175f2a277..0ec3509b7e3392 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -33,7 +33,7 @@ struct iommu_domain;
  *
  * The io_pagetable::iova_rwsem protects node
  * The iopt_pages::mutex protects pages_node
- * iopt and immu_prot are immutable
+ * iopt and iommu_prot are immutable
  * The pages::mutex protects num_accesses
  */
 struct iopt_area {
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 429fa3b0a239cd..fccdba782cb699 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -342,7 +342,7 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 		kfree(batch->pfns);
 }
 
-/* true if the pfn could be added, false otherwise */
+/* true if the pfn was added, false otherwise */
 static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
 {
 	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
@@ -418,7 +418,7 @@ static struct page **raw_pages_from_domain(struct iommu_domain *domain,
 	return out_pages;
 }
 
-/* Continues reading a domain until we reach a discontiguity in the pfns. */
+/* Continues reading a domain until we reach a discontinuity in the pfns. */
 static void batch_from_domain_continue(struct pfn_batch *batch,
 				       struct iommu_domain *domain,
 				       struct iopt_area *area,
-- 
2.38.1

