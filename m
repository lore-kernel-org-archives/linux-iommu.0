Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D4D51E;
	Wed,  5 Apr 2023 23:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3fd0gpUE/OWr6XqMcI6Fqfiz2cUPxaa81FvwFKvoHGBZcRbJTG6xstw/gc6IpA6ERv2Ifr5tR87BSFa9EX00jW6ZFO/A3hBB+wbg/x4JEewjUOnjfbJJbdlq+S42vQejVkfkma5HdV1lCaOlUxKYewxmH6ra9+xUaF/ZO6QBMNfJmDXrAez55rTEz8mCs5juH9VC3u3cX/Tv5CF5laISUKLh1S5cEuOkqXLd+EmawVd5PKN+ilBm1rIGO0vVEXP6Ia1TdmA4qOHIhQZDKXtxk67T0FcCFpK0DoW2lAMoFwRvPc1naIrX9YtIr5roJ0SRPJGDbaUDad0fcgw8N7ceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw4SJSClmZv2wKDWVyrMeH8FhA/mhWnXCeEA2T3NnEQ=;
 b=EiXXtdkb+XjI9OmZbKAy/+8WHE0s2APDBxQd8JJQLn/IV+NrQdlX+PRPpQPIlnKg0Z/+w/e8oWimdr0ocLkdfDbaIfSIDF4br5jr85KKA/64TBPOHNLJVgMp2f3m6xFRs5ZgAhAk0wY4pmWej9+8DzN6NkPmKKXA1ByEAQ8ou0u88UqY1MGzSy0rmgNn9FwMCB+CpFTvBPDGl2eytg7xMwaLL7ucluWvrQnnkna0PDjzjxw0tgsVHh718yc+irI5xy02D1rw9uIeikLhmfBYRoPeMS7KvApgdEDHqWReya/nMVMHoMgwWt350aR2BC8foEw9Z8Op7d2jw0c1NCTNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw4SJSClmZv2wKDWVyrMeH8FhA/mhWnXCeEA2T3NnEQ=;
 b=b1nWryogeyQQkndIoH4aCoHJAIllI0/v8iOv9cB5bb5kvtGQeRBwxq+4kPedSK2FJatm9SS2WEVBxNQiwa6GGvw7pD/5NCujMn+jmoMAicxr5boAYB8PEQ2YCVzHytRRfSHZKPJhJ7+b3wBPZ9aLOQIRispdPrt7zpJQxF7Syk6D16d7ig4GMXjQLf186SLxkjoxk8Qg2ICkrd76+v/SCgb8giUFBL4XYwtYFi+BvFWuHzndImlTdY8FJRR+vBq1fuv+IaPcNpk0MfiIJkUZEeIfVXXgBhwEsk/Nm5/rlp2gwcgwN5/hVOo7zV8cqdlDc7IlnMtu+quM2RxwScHncw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:42 +0000
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
Subject: [PATCH v3 11/17] iommu: Remove the assignment of group->domain during default domain alloc
Date: Wed,  5 Apr 2023 20:38:32 -0300
Message-Id: <11-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:208:32f::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 831c248d-5c0e-4d2f-358d-08db362ee251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	At5xik0n71JEHkEzZWV4fdYIaV5lu33N5qmCVRY4jtt4moJWJa5xXuqMWkxWKEL9waKd16Nh7yr0RgKICjJGEoNDl+bJqfDNeYHMTusj/FaHOFqltwtq3ON+ktLKP/twxKaurzhu2itinyxkLkAvxHIw2/gvDnCY7m4j5Gsl+s6Ob60Zihf36K16ow0TcETGbMlq/CveWmimd4+TLgBWQqgX7QOjqGpRMUADEFhPCbhJFb5HKQyPgpePxZJMcYZOYVXHa3wMf+WDUxbBFk3N+iJ27oWx0IHUtXMisxN97R3vQOMrvRq6zeQps3DqICU7k1+dJR26GE/MAbJNqdaRdoKQwJ4kEFcCK2FkDjJI8qsctU10ETZ5T7ZjY/R2TIzahiB/JmkbNC3OMRSbc1h+TS5ckJjqhsEGRVjQJHvaZXGTuCieRNzorffOMrf8xnUMedcvtssMXqb/VHCKjJPUuVejeJy6orDuAYw82sh8NgDnfqImmwClbxZx86QJxuZSI4LfwYlm+9Kakli5EBYFo9fPbfHVaPRMlc8euAjizEUs4oWeuNF2iR042W/riRFc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYAdmujqJ6WHb0rX5V8Drvfs6eaewCozXDod43ASf0dGbuiHMXUUsWCURQnS?=
 =?us-ascii?Q?IXL0ieKkNDzmcUunEwVBa+5E/eLBeo7sxWy3s7GE0+4Syr9DOh5cL/7Xpa/3?=
 =?us-ascii?Q?OrOu/JP1z6zGzYzPdpnJ+Ly+RsatT8AUbUQigVar3pWJ4Gj6+oMvOcghi6+4?=
 =?us-ascii?Q?RJYIXUBRDNXBTisdHdoG+E+gVZ/rAhra6N6MuCA6jyyuD/zf6fLTjTt5VFaD?=
 =?us-ascii?Q?7CZl9aq2XdiaGGe/tgJv3XDK9HSuk3GyjLyYShtHkbX4iqfNVSi+QcV2qWIp?=
 =?us-ascii?Q?2vvN7+RO82B0zv9LD+wNjcVGJuZet5qJy4+CsMabKba/lA30fjrIboq7ilki?=
 =?us-ascii?Q?KDjxaUXbpq4I3gnTd7cD5PhyiRuVN9pXyj7uguuWVLQYUq3FYExQEWqCue8m?=
 =?us-ascii?Q?0V0ELKB4tl+7fi2r6WFUVZTeMz9nAGV0v0t7WsKMQ+eJUS8+RV/tZupRrm8D?=
 =?us-ascii?Q?G1q44oXRB0xrGFknImQtqYWibVJ2wfLbYPbIhMEglwITO8DE0skDmVXKJ2Bi?=
 =?us-ascii?Q?lDfRJSIT1KEHapEIzdZMLYWnAypWsQzd1ix8q5i9HVx0QKFhRaMaoB36JSl5?=
 =?us-ascii?Q?+6nSF6NjUn8GQsdE1XS0LY9mLOpW2IjVpN3rmwcZZUjsBlZdKBzXP4ChgkDL?=
 =?us-ascii?Q?n7J1ru5UbQYN5F1T4iXxX/KPFjnP0rFiE2AUHMkchw0dzicXX1jRIkZeRGyH?=
 =?us-ascii?Q?bODN1CBRlR4dQf9GCkbGuekiBPo+yNhaIDN6IZKBSEzo/GQkmL581mnYtQkb?=
 =?us-ascii?Q?KowxVqor7f11ovR1rj170ME89TnYJf2rz7cXT+6SuVNYJtpe+cwQyYbTiVUG?=
 =?us-ascii?Q?UUr5vP5i3UUm0wgIBxbdXyc22vsH32qbho0rvuRvqN2KEO+FPQqLqragV1Xj?=
 =?us-ascii?Q?WF2gC8hYOTqTJQCIhpqteFXlLbgzCI3sqn2E1eMwVtjipj4k9w/u1bR/2Mz3?=
 =?us-ascii?Q?WCKSCmIbIUiTPYGfw6rx16/C1L/jY1rjGL0LuVNIN+DYR4HbQ4PlON3dO8pe?=
 =?us-ascii?Q?5LdpU9oRkWlrPb8JTmvbG6zDX8za6/gRJ57qImcm0YkpIm1Dgcbc9SDdos68?=
 =?us-ascii?Q?OfELRHLnojWXd/WYXYwF1i39GYSgRYcfPLLmzc1pYyjY6yUzv7aYGeWV7pzj?=
 =?us-ascii?Q?ooI8cYH3/5x6rwtDr+3NIoehpd6Pcc06wcy7IOL5NKFwAhN7sNvxzhSBhftp?=
 =?us-ascii?Q?o0YijIv9WB9pgWOYbWsNIp8z2wKqzhLlsfwRxghV6q2iOXlBmB/52UOcROki?=
 =?us-ascii?Q?7GKT+b3eh3pNeup/rbk9sYxHIoRNXzLi50T5a2+aqB1UD6ibaz/vV3pgva1d?=
 =?us-ascii?Q?NrlDNYVoJ7cFXoEQEedo0LEIKtljcfZ26qbtBCmiKCXnl0OcAh5MPrYjABOT?=
 =?us-ascii?Q?+i+lCrstg8xjbnbs+RcWEojZ0Tz46j5co/5xqGkxcGSkw/t0cIxBO3CMlMED?=
 =?us-ascii?Q?9xANraT4wk2nMN3mrLuTQnuiE48UOwrWIEr4CkoOEgQShxpWZ4d4Aktfxcnr?=
 =?us-ascii?Q?xVc6+jWu8RJW9cv7nB7bJB/nc+L+SAqcNfLP1nTR4A3NVh0N2Y8HJTogkMAn?=
 =?us-ascii?Q?WrhDI5litGpQz3emTWlKEBDwbSE5QMtRp+mIenmW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831c248d-5c0e-4d2f-358d-08db362ee251
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xu2mcfxyHXgqOXQhkI4j2mQZ2zAezNt1d8B6W5zJTNGi/vQEDlZWetmRD9H7uqrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

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
index ca209fb3ddd1c9..efa6f193dc9da0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -445,7 +445,6 @@ int iommu_probe_device(struct device *dev)
 		 * checked.
 		 */
 		iommu_alloc_default_domain(group, dev);
-		group->domain = NULL;
 		if (group->default_domain) {
 			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain_internal(
@@ -1716,8 +1715,6 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 		return -ENOMEM;
 
 	group->default_domain = dom;
-	if (!group->domain)
-		group->domain = dom;
 	return 0;
 }
 
@@ -1921,7 +1918,6 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		group->domain = NULL;
 		ret = __iommu_group_set_domain_internal(
 			group, group->default_domain,
 			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-- 
2.40.0

