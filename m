Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736ED530
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWFtMcurQ7h0jVHBkPP5ioRmmvUr+n2cQFTzK4VXo5ijfL/FipH+/Pm4N8GBHIMH2zZtAMwV19Lg8bxAwi5Szj0jlaSnLmQiCPhkFLCOg0abdms6RFkAAftLLPHQNAOh6smxsqnJLOMpVvHndivjPEjIJhvqVEOQxqxbPDOBhaOiJrhIvLeRfygcejkRmmLNOh8YBzgynnnA59YC3Xh8cAqTf9Mv48zpZ3yQkH9QVjs4pb7qPPKxWK+hKhQ2rXvlVRGeVVpNB1OtbXnYR4TFziG9TIrhWMUmqjX7JNScMrpwA+gTUAsG01qE6uvYhoJmWPFjpR9OHzN04gy9nXfTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9Ve3x34E/cKmZfW1kBSRPo/u4GW9QuHI1CPGMD2KlQ=;
 b=b83QzgF1CRnye0IJ4+vlS0hiSDZAUTH/jUbh0IsmZyiWMV7Ibn1n9xQ3J/CgNkkQo+uZ1ARFGUj63cGnZGDBDf4etvyZFdnPyBBjACOTMjlNduv2faVZc4YRR2ANNs2qFcRxmN4g0+9kVZCVf6bVG0tEhphn8IVNgvcQMMRNhmei+RuDsAR+qUTmiv/6ozCUBuQWihdqPvTY0TR88SDOhxwoUZvnBSFAHaNf7tj8WSOIxBwTbFUdgOJSx+DNWCCRmWhn/UhZ+jXnIca4SY0rIQL5BQ2IxMJcoj5zZeFt9JjQjFIXSgjrFYnzHdHFzTUo0x05zYZC8WgNyIcClzi8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9Ve3x34E/cKmZfW1kBSRPo/u4GW9QuHI1CPGMD2KlQ=;
 b=L1mnIzMJl0XbK3h7+JbhnljSQfkzPWmN72h1NSSW1an9oxj1zYISbBxafAjQWAxZRPgAUtvTikMrmU4gnVa+V1RqLp4maK7kQ/IH0WQRyYtvuoLTbXfAb5JEop0p3tsjCeTLymkFE9sjI+WifqULiwEfz2ZhNo/D8Mm8aBpUKYCXbEur6w6lKFHvz0VAk004taVOeerphwsxIcms/1omRAaemGftiJdSt54Pdssy27uMep+eOs/D92AKpo6uU927k1Bq18LbFKf943sSyO/HHEzvhRhe8HH7kb2Jh9ADlvEYzO0xdyeDjpmsWmQ8DbH4itXWRKxRgBaxWmGZzpus3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 7/9] iommu: Remove the assignment of group->domain during default domain alloc
Date: Tue, 21 Mar 2023 16:53:19 -0300
Message-Id: <7-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DFA.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:d) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: afeb0d09-f8f7-4c8c-19fc-08db2a45ee00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UBoAeypx8l/lMqJ2tKpFbdz+JPRFqW8XS1PT/IdMs4n01f9/O+cNZSSf/UUoPaEd0t3KO/b88zWjzZYjQ9zVXCnYQQIR+8tw+CUvpghqFWH517IRxRCdZ43MsjItmJbQ1+UbmVJYrfllYyhA6gD8oMZostjuhwxJz+lrVfCzDnfO8FrBAe3w+26UTNFvLVuorhLrtfIXa7gyeHkZkkLHUy4grRG3zFFaYetowFx+HK3s8nlGOxbH5A66akrXbxR4n343eJ2GULBxOJ1C4bxIfq4DUZr/Nz/eOXHC+Tr13pD1jNSLccHaHqK798m7kzPuw6ETyGoI6vz+Z+8FQI1GcHpiIYkRei41Bb46OqPczuU4bu+MEMs8/QJtuRf2BT6a152cIP33RKGGFhWTpp/3P7N5XB5O8I6Rj+BdGrKAp99IzsduwaYIpIrYdVpV5QUMQEi9dRu6noFeulu1RTsPwrdJb17tull/WW6tXAHdPRRo2mA5BHdqe1gY+TfHcb7LNVGTh0oxvF4epGHKdcuz+oawU2y+5ShbfCfLIRR8UBtJ4+XL7yjjoXM36gWdEuOg92oLaBJwKRmgYXvNKveARfBuk//LdK0LuuN2WYXfwO7EQWCjneEdzDEwiRN3dehI+8wXK/P5jsNevlJBkNsBBEh8QbEdb9vpXRFK/yNkoVZhhfPSzcJGVt8GhwK+njqC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RQKwfHMucRmNFXiX2l8Wu8av5lNBkbiHpNjY5X1Pyxvc0bwkpdAfUFzgRQTb?=
 =?us-ascii?Q?rfY08VDKkr7FkGsIC9zMCu3QSTW3U8sRhw6OwvEbV5Y62ncnCzBMGjPdE9e4?=
 =?us-ascii?Q?uJm5+5ToxQLVA9eeSDpucRV9Si/1vQyFThIb0bps5vEwlP4gm3H/2MU1w5mG?=
 =?us-ascii?Q?293IS/WtEoYaKPy3ayyPDPCxSXjUxIMcR9zrzRm394yFOh86adND0R94z1YG?=
 =?us-ascii?Q?dxum0rtWddTyq3m+GlqJGEwbNN5E9Rwh/GN3U+836J6atXRX/nnNnLRRdWek?=
 =?us-ascii?Q?THPiHyr1Ih1NKRRu1HjbfU4R9vxFWLGZSvTR+ywYI3LLWkKy4h7iwto/mR14?=
 =?us-ascii?Q?Zq6h5D5snypJDc7h0zUWP3n5cA97bpQy1o+8XnmRsg8ITNTPd78pyDRdL/lX?=
 =?us-ascii?Q?53owmLQxFpAWePlmOYwAakOfizUa81SHvrRL/gpHD/3/oM81pGgBfsZEstGt?=
 =?us-ascii?Q?FE3k6xNUcpL2S4zzquYxUzOfobGDZWspfPVmKO6TuDttxZDAd6nI70unaMCN?=
 =?us-ascii?Q?FlVmxUnYyA9mJAF/ENvr2HYWTxNUfdEKBd6R2EOD1cNtb9+t9GjMEFz4VmGo?=
 =?us-ascii?Q?BycpKPkhbjypBaHaPypoULheMjvOBwoVQFkgln0PsU2sJBWol1ulLt4mKk9G?=
 =?us-ascii?Q?gr1QrMP4UK4AE6dLP3tOaUIBGG8Nc2qZ1BYhhqlfQMg0ZzCwEuya312KdyEn?=
 =?us-ascii?Q?WLZr9wQS5YnWv8chmOu4nurXz7/W0mm1S15NLDzHPXs2Jt/UvWAg9E4tUd6d?=
 =?us-ascii?Q?ACgnfYMnl8KtIjsBJ4X15mW3TPl2EsIPLZ4Mp2vVmJPMbX5lQwOmO+WFGBhY?=
 =?us-ascii?Q?K0wqTEfU9MmUZwfuGsxCcgrK/aBbSVsueZyyE/UpYXOdmPLHqsk0TZeDqqhg?=
 =?us-ascii?Q?KW8vn9O02UYTHwno1LzAAWVU21hiEZN9ZOWSL0cVOyKuY10DVBx1xU5B1bKr?=
 =?us-ascii?Q?X5iJwE2PiJfqVBWN4l1WIaCTXo7kDfCuqzGVh5QOEFn1rXmiSrHKWXgZf2gS?=
 =?us-ascii?Q?q8abqlaB9t+r8WtNuLO397UGi3gVLEIIfXur6DG/XnU54VMi6fZW39oQyH+w?=
 =?us-ascii?Q?RHj9WLmUOVB2OdAzEW5e0NXlNFu5PUPcePV+TRVAhKl4eaC0v2bYfyyeGDW7?=
 =?us-ascii?Q?xhoZ+EO2G1bT1+X3Ig07gNo3E/8x72mXLdtGJso9HpCMx4Dpwc3Nfo6w2kqW?=
 =?us-ascii?Q?FvcvtlN5axgrEOSBTay1KAtwGvriy+jMt3PvdkYyyCz8sw8Ta85CXiMuVGgO?=
 =?us-ascii?Q?ZwVQ6/kSkCoL1DkwguyH32h6ndZ1npkn2Qj+cm52zNt0JGDFtOksroHy7T5V?=
 =?us-ascii?Q?IrPrIYQm0Ggv/PoAnMNskLMXXWTcY1ieDNitKVmYrXbFzTY5o7if+6BF3rS+?=
 =?us-ascii?Q?Riz9bV0SybWCtWgq94XgeyeFNhufkhz6Q8U9sBppfmrYCgagLTU0oOFXsZ4X?=
 =?us-ascii?Q?Rd6Lo/THqXj5mpyRW27WtWJPCLfDg+ZLNFU0H7v3gIibAobuiPBOB6NLX0bk?=
 =?us-ascii?Q?ni3cneKutzkNOJ9VK4+3f9U/ufor0tkhuo8e8ulN/eTXDL3NnILRRIL4IQnP?=
 =?us-ascii?Q?/AHW7UOL0B6Jni0e+M8RSL7bKwEZnOivx+hd98O0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afeb0d09-f8f7-4c8c-19fc-08db2a45ee00
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJFcMzTzY/U8HU9UWpXGllz959jPT1Zws4ZWCu8eEo/aPeQLVFKAOtjH322g+A8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

group->domain should only be set once all the device's drivers have
had their ops->attach_dev() called. iommu_group_alloc_default_domain()
doesn't do this, so it shouldn't set the value.

The previous patches organized things so that each caller of
iommu_group_alloc_default_domain() follows up with calling
__iommu_group_set_domain_internal() that does set the group->domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d58570f361bb92..9973d1eac18cc9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -441,7 +441,6 @@ int iommu_probe_device(struct device *dev)
 		 * checked.
 		 */
 		iommu_alloc_default_domain(group, dev);
-		group->domain = NULL;
 		if (group->default_domain)
 			ret = __iommu_group_set_domain_internal(
 				group, group->default_domain,
@@ -1674,8 +1673,6 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 		return -ENOMEM;
 
 	group->default_domain = dom;
-	if (!group->domain)
-		group->domain = dom;
 	return 0;
 }
 
@@ -1879,7 +1876,6 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		group->domain = NULL;
 		ret = __iommu_group_set_domain_internal(
 			group, group->default_domain,
 			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-- 
2.40.0

