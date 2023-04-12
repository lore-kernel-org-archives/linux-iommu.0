Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB15696;
	Wed, 12 Apr 2023 13:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEDg8TAPIOuzTKuJQmzcRgehsArNdKW3/zk1MYThjskQMWJvyoN+6NulhgK5PjoslAgKOnSV+AT2Yn5/141lrJaWFMydhw+nJbpebjItSQXNAubYV2biBt3c6foXfx5sY+lhAuiHG9RMhFURTTUN1kfMvzoODLlPHXaABBls7f6g7XBAQcp0oIGUMn+7n70RaNj8CWv0WnDCBU5n6ptfTAtmFofY3B25LF27fVW7tVMEFFum67x7/n9jcDA5A03jSKBL+SkkxVvoGEjU+3S1jyd5WNqvzFMXchpQuVFNf0pgrZ9gpbD/FFxfQOvW+qOzxaLiBQw6OLaKp+vNzUhj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joYz0cwDnqrQFfQ9CVJWoZQMhiwTfTLHbpO0hnKQYhU=;
 b=k/HxJ/mxlxpNZr/0jEnEM0+M7kNrZSAFEqHc1axPiE7fhwREznEx+gFgpBPYvcJ+NtfBZ5dEijj/kL3BG3wDEKir1kKCYFvkkuRVQ3Xyebsl9IGmPPBCyIdw4UsYPWtu3D1TYOynsfI+bmG8h45jdvlljoU4EhCLOHmZ/MLB00WFBSLtKf6BAmAqF3gO3GBP99kzlGVmRQRZYpynV7vwscSHwZs/CFngGTgnFmA92VdV2g3xqUnqqBjN/QyP0VY/MNifBTeUvFT3FCzqddbuji0pmtVtYwUnOmNshxb3eqojYNx4aeER1uruVmgz6BO/IdZGAkb90H4DrTEupJKefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joYz0cwDnqrQFfQ9CVJWoZQMhiwTfTLHbpO0hnKQYhU=;
 b=Q7QS0O5/jK5KXArgjAHkUp3kv808vGMYGxmvqC5pDlgscxNCrzdeqC2SotMoKWWf1AJ0kgHcZb+6Yyqgg23bbJ9U+GmH641JbUlGZOVepnzs3eUpS/QTTrYNsHQAG1AJBIM7qDN1P6s8Uik5E3uIZ9qGLvPZKJd2NnyD1e0xr8Vdu0HIuS5GkLGtq3B7pLue2Kih+YFo0YqXsi0ahdhQgC+D+yBQwyT+sifplqcd2KZbUwSeBfgf+HsknQS1w/MQ36icAWyvUCyUymM3PGdzsLGlJkDDfTEnYmx7Cypc0SkcitnppiyokpmkSdH47cwakdJxGNt2GzKY1u/I03K1eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:51:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:59 +0000
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
Subject: [PATCH v4 11/17] iommu: Remove the assignment of group->domain during default domain alloc
Date: Wed, 12 Apr 2023 10:51:41 -0300
Message-Id: <11-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0065.namprd19.prod.outlook.com
 (2603:10b6:208:19b::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b56b58f-8610-467a-250f-08db3b5d1058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pFCAyQVQdQIdUf09sDUWLejW1YYnenggLBmL7TA1jInypYr8x0dA3yQjhSiUYzxreUj/zPvhWD24eX1Dg/ktaGcBFW9JPrQNWcCQZ8PfPKUJJGbIcJLO0LG+6M8prt9GxYNmVQJlkfwacSJMg0kKfwfWnk6D7xbA2RkeRbq5eeDaUSwNoxMP3M0h9zL5B+VCrmZVcf8UgUl54GN/BxrI+jIn8uviK5IWO4uo+GZGOUlskROmbyBf9oMPv/M08fTZFGIT63SBYdG5qmqslVhJaMzAVyiQ7I41iXx0FK20Lbmhs8Aw4JRRjkMyWc1qv+ez9Uvwa+uSSJJS+/7qJHhKfGOiHS2J5C0x+ZDavUYIlMkproztpRm4d6olFBoSey/hkL1/UTYqmcMW4y5Uw4rc1Tscdm99dx2HHTUyjj8BmHMXDQ8w5vf+8kXgaL50xWuBtCH7TLuTr2RCP4DfrRw5+Iyd9Od6eWeQ35o9NRN0bdm6Gl5wuX4DtL0mZFzYRiSMMdWBX9sXHBp9HXTH8Pq8TfxM0Y5dKccBdUNj+8islMvld27cjTla7vPF8oe1ev7D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(5660300002)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QN6ainulvN8O9ONqD72I2BTTR25RSrCnZ27uUD7r+SMbxFpITaWFW4nO7k5o?=
 =?us-ascii?Q?/Q85lGIoKdwoLg3kx6HttiWT5SCBR19JWxYjMQimpNzSAR2tzM/gbRas0+Ta?=
 =?us-ascii?Q?kx1eNXmnEsbzEERjD8OALRTE5DLFPUcWX3MZX5mEfOLLvKDyUdNZCdpaGZ4S?=
 =?us-ascii?Q?sbQhFQP35NnRIuknm9BdgV/CNqhMvXjwFV8pI18rM+LiYR9Wqo4GzcrLb+WL?=
 =?us-ascii?Q?JEjyTiaxUFBTJdz3UR5wIbbtHgbAcNGDVFTfTT7aDk/Hvsid7RGqHvcFXv/j?=
 =?us-ascii?Q?u8+NY6jvy+t36wOKN6KzZG+6NwjWCNR59cysaLcGMf1nGEIma3SngxRgLZ/B?=
 =?us-ascii?Q?qhnuH3pzHP8YK9GnewqBnjvtiNFdzBtyraIAw+Ob+bXhAT7FKJX6E60zR5Ey?=
 =?us-ascii?Q?2c+wYxSKQg0RD7sprw7kRTbQ8wtuoPb1x+vkOvXjNgF0557Cq27fucHHPuQ3?=
 =?us-ascii?Q?BzyMSZyHefRxLEvNQ6EISbdJOuCkwSV+zLGsi3aZoe0+RF+Cr25ZxMuHFYX5?=
 =?us-ascii?Q?0hxO4V525M3D/K1TdrkqfqVuzwvLU24mD0tvo46twbt7S5kdUdkrqBPz256I?=
 =?us-ascii?Q?CwUlouxT47m1jXINCQAgIjdP/0egreijURO3S2XDqqeWhpeej695AA+Me44p?=
 =?us-ascii?Q?5qmPVIJU7rRVSWZ+VgwmKxUbSPFOupKWjRZ2M7cczTMO4MFv8Un9bn58fR2z?=
 =?us-ascii?Q?KYSJljkyw2UueBixRW3iW3yMjHQZXqUbU4AJeua8rUU+pZgiyBInMU4rcNTq?=
 =?us-ascii?Q?pfNRkJ7KsP/rpJKRkwxDijhsE+IwXJ4HBor7zV2AJ6zkx5PXGYu+eNYEokDB?=
 =?us-ascii?Q?7+r0mJCNPFFksNC0qpDRw1utESs55/H0UN3KFXp+yrlrw5QS/0BnljzgAApO?=
 =?us-ascii?Q?WHbGfwJCTHYj4M3d+7/0t3RUMpy8DIY3KTfQe23wU0AkzInKyTP+aW/Ui+ux?=
 =?us-ascii?Q?VZI2oaKbLXTARIXcJdSbiFEohK2GlpT5ha28CYGhM5BwKdL7pV6wNdRTJXTZ?=
 =?us-ascii?Q?O4Q+WtKAVcWATYbBJPjqcFqG/Wh8O8ha0Ek93trw1YssSLewiakA5MJXBpaL?=
 =?us-ascii?Q?Eexsv0RaNFnFhCWZspbrjQJYuYz1RSH2d0+Mxeea3BncjqFvOTG8QyHY8Y8Z?=
 =?us-ascii?Q?bJVlPDjiI3HcHAQDZiITriDoS4sKfFz3iXT4OCHrxXCQMMnIfStCKnaqgK/c?=
 =?us-ascii?Q?y8XOvMQlDwxsHguUTlNpDfHMeRy3tFXLaJ0EoDTARwN3Oi/VV1/pElG/6ylX?=
 =?us-ascii?Q?W4Pi1No2t1nHIRdZjzZi0hfctv/dUCKQtnkP6YJfyHz4OH1utDl3XHbrATd0?=
 =?us-ascii?Q?GuyMiywyPVly/aFvl+41Umrz9gXdtSo3zQPtT+keZwEH5KpnLR4RF+DKhlED?=
 =?us-ascii?Q?KkjLEFC9lAoorZeqtwz5KWIrcPjDpIwlXhpVJAJwaqpOa+Qbx3fXqHn8Enbh?=
 =?us-ascii?Q?cDBHcOfSeNLyuQzqtzRqLxqLF9S3sx4p2IgjP2sLGqGxFtc/k1tVFeXJnhxo?=
 =?us-ascii?Q?9J78DoKQetAA7x82mW19eIF9ybmhFTRXrqZ6WjRCmuPOZDL3fD/pTK5clOSm?=
 =?us-ascii?Q?r6tffCibpZ2QRVRtYmD6JDn+YHiWLpSiUSw5upaS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b56b58f-8610-467a-250f-08db3b5d1058
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:50.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVr5r+0lvRWNExtmr9gRSMwcOC33ozN4iRK335yaHJVrYauIWeyMEQl16fDb11ZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

group->domain should only be set once all the device's drivers have
had their ops->attach_dev() called. iommu_group_alloc_default_domain()
doesn't do this, so it shouldn't set the value.

The previous patches organized things so that each caller of
iommu_group_alloc_default_domain() follows up with calling
__iommu_group_set_domain_internal() that does set the group->domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f0dcc7a559b55a..57697cc877de2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -430,7 +430,6 @@ int iommu_probe_device(struct device *dev)
 		 * checked.
 		 */
 		iommu_alloc_default_domain(group, dev);
-		group->domain = NULL;
 		if (group->default_domain) {
 			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain(group,
@@ -1688,8 +1687,6 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 		return -ENOMEM;
 
 	group->default_domain = dom;
-	if (!group->domain)
-		group->domain = dom;
 	return 0;
 }
 
@@ -1893,7 +1890,6 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		group->domain = NULL;
 		ret = __iommu_group_set_domain(group, group->default_domain);
 
 		mutex_unlock(&group->mutex);
-- 
2.40.0

