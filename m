Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91956322A;
	Wed,  5 Apr 2023 23:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtU4vDFwv0wXswdFFK1OwvNBL8DFfSzMsckOdgUcJ6QLfArUfBogO3VaJSwJdYGpzdK0a7piN0Krk16srQCp+DbBBW3ig/RSgWk7NRRVG4UtVwrnLxBvgeSdthVuZKgXjSXn0hlyelwarYe70FqRkZHBdp4p6YEFeWnjfWTXI0D+yrJR/Bh6jeyeWAZiSdtehz3IaNKuWzag2gGmNbO+lrQdriMLk0LeC3qAJtY7oFnbHkk3CXcxKRDwY8aQErN3sFLPLyGS895AlZ/ogEv63gO05RgP1XVJo1AqJ6VWGND/Mfexvv6H7VVoer49irgPkAhmTbcZi+VnhNjlYC8lDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz1oLW2xkkKPnMm4uIMg6v2yOwEQL/mfVGUkZsjRYpg=;
 b=CJt5MOC5lmXRn+AOo5UAEUgfVVu4XK88NcS026x1mSjdrFsdcozTC5gNbSPjzvj4S4Lmii+hT/X1Hv5gUrzESYVTehz+2yoxFFCLlsAZtg0RGvOF/AELV2WhUaK9mVYdk/EifoMmqJECdroRlwpLr6L35SReX0CMsTagTjwuNCns9w3F2rEYkxaONI+FFM5DaBZarOGpes+nrSkXx1L1pb8tNFUBtoK7q/OELqMw+G0b7Xs/p7NtZcSr19zMbkfvpVwxNGRnZIFUqRYbZjrk2bXBEdr3CJ7mdi82U9w03hLNqHQoH0uye0xiJSFBfIYmef8Ic6ki4vGlerIuvDwE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz1oLW2xkkKPnMm4uIMg6v2yOwEQL/mfVGUkZsjRYpg=;
 b=aBrMQRqSg80IMEWv47V+MoK2Espcpii58G3r75vtgCHkeATDKHGaDNcgJXDIsm0ENf4vUTA/2UQS2ZKY3cV8hry4lyN/4Yh8WJkQ3g0uAeNb0HJisVPtCnlG6R5pO1oeohhT9QwoDc1Ay+Vt0c+d9JyKJrkQRcn0kA+LfiV2D0u7OCBGiq7xmr2gKm9X9n+pSJdiTfSMTQk/Y30Yrjf11ge1FAl3ajJO/tCpdUgpIQpfqYJITxuQfkodK9/TsXQxelDSvpnI9qSUPdwLQeUj7V9AsOaToUFzWL5Y2fVqAS1/KScraWN33hbeqYOdP4+Yv885dKIFK0bjqHDiWYEAlA==
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
Subject: [PATCH v3 10/17] iommu: Do iommu_group_create_direct_mappings() before attach
Date: Wed,  5 Apr 2023 20:38:31 -0300
Message-Id: <10-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:208:23c::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e9115b-bc84-4816-71a4-08db362ee336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azTbtMsu/MHoHXdwhE1Hf4U8n1dWzAbMcZskybV9Jw9hOjetQ/0K/zi0IlccovUSBkzxe6hynjg/gG9LEt3+/hrQ3J5AYzyCQC7hqJXaKvdM78+Z/1dC5gZVAXyYqw96x0TlO9CVwDPS8dk8nhP9JcLxJmetv6UShDcpqbTcBHaUOUmPYrnz1spOroEGHE+SJY/ZjIsrzjRg183J82/otRlNouAxxqUhj3SioofTHTt8YC4o1yiz55+qLiJYlghlbPVZ9VefhSoW+1hKSWpXXb38f3fHhUUdjgtPWexze9AZhCtoF147iZKOfk6LnGuMpc9ScosPpnZSpk6QAM3Eb3i2Hw2+IeZbCKoso1CclKsmqbQCUKPR6L03T3fTZoGDMMmvW+a+rMgIyjEAGms+wZ2B4YhbykiHwrcJoJm6brM9amyxg1Bl7O73hY4T5ruepSTIvj6/sqIo/XCXcpsMpERqrNNUXGvmSwxz2Cbsj+FPjElGZ6DTmH4ipHdT6GHp3vf42O2r7Tyyd1vuA4tI7AUq5Lk3CWP0Gsuf80yhJo7+plhdLfeKuyROBU+lROPq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5QANBrvdYlz8tFyAnCQT14f63X/O2DfpnMTOQ76Rp/y+r2DsHrxML4Ofkeg?=
 =?us-ascii?Q?i1Yx2+8Tvgy/ORBrT5DxfHmcuB0VrDG7vgmXlxyOz3N3sKI8xS0IDZQUq6xk?=
 =?us-ascii?Q?fmRyeBAqae9kAwAfRsanmQHObcyZWEF5+F3fwEc5z1QcKSc6PjTPm6L2i5pl?=
 =?us-ascii?Q?I6mgUZt3Fjte0Ofl5zwlR7+UOX0Y7k1eZXrEv0sOPcGnqtBlr7v/97hAODmV?=
 =?us-ascii?Q?vj2z3sOoU9siEN3OaMuH89Rgb3BCtPI+kdmeqn3duuwG+Cuzw3ZuHbsRJ9kC?=
 =?us-ascii?Q?UP5Sgegvt3umOVpTl2iSUczMw+w3QyLiU/KIN+fp8bAbohZtRbFvLIbq48KD?=
 =?us-ascii?Q?oEtQUvO/s/AhXhGkJQ76Av40N+I4stoOnLXxwc8G705w/xGsPp92JxLO5b3L?=
 =?us-ascii?Q?kjMDVTPeVukehnnGH+oxNNEjiNVmrZnEAARLOp/NCw6NlkWlFUuMwvgL94fk?=
 =?us-ascii?Q?F8ioYaI2X2AMk21VEwQCxPJ7+/nEjltRoHsIN5ADHhxEXhdi2KbiM28mxPMX?=
 =?us-ascii?Q?nhUPDcbiL/JJSa3rr/d0jbX1muLKkkRK00WoosP55BN+7DYNX/I70HURCwZH?=
 =?us-ascii?Q?8wMm6mRoYNEZ/9wVCXwnePPhKdEOmo0UDQPmtjEg1RCIcAkpUIp38bsgBc5L?=
 =?us-ascii?Q?NJGut1HyjBqVCbJHoGIT+icqJ90y0zEVgHAs/DGcVYEPFZ3P6vZKBWXw58qP?=
 =?us-ascii?Q?7MC1OWBadhncp3cF1N3yMrwbrrKr9MetFiXX1Bv6w323U+m/Pt6thGO5qqvm?=
 =?us-ascii?Q?11WVgbLhjgAjQ6pHhCpfM3HC9JzIJo63C8vAA6V87me+RPtdhVLjvFeZ6Q/h?=
 =?us-ascii?Q?rtuo3DJJVGL2szf2OqtyxuXOWwruuzGxCEhX6NTcpq5SVBPmdwFYmQZUd+w4?=
 =?us-ascii?Q?asytxQ91/MiP4yQA0TnWVnFwwhsXMbsS+3ilrqCShYQqa5rohRsh7nq+/vRO?=
 =?us-ascii?Q?T83cc4B1tJgbfvQ6VGPofyYu/1A+l672dE//MQ3Kx1g5V4v5n8JXv3YvQm8g?=
 =?us-ascii?Q?D37iPmNndK2gA2rKhhpV8Hl0PgkOS4c5O7sBm/IMJQvOs0ZTc68Vl3FswiRH?=
 =?us-ascii?Q?FbOkVlBeve/eFcvZ+4b6LrRTSo6jn30/ievV9aLZ6/GkhY8nYX3WE6aVskiI?=
 =?us-ascii?Q?LfRBJDKGTEua3Gj0+cmZRHmHMbBHHMth5xCBayvtAdens1FxSWZzgzTDI7EL?=
 =?us-ascii?Q?HexI2y9oyfRgxAip8w9C2SOGxJLWQcPXaY8opseWjUkqGZppAoZQhMw+A2Th?=
 =?us-ascii?Q?1nUtzZpVeowKeSfCwG5jJzhUR4ktk1N0sk0IESReX7l1VAtIRaiQHbASSHjo?=
 =?us-ascii?Q?sTXrKsJLPgDHzDRUT/86WVCv3IK1rfq25Zo7X1b3FjydgetVByYNc6Hpde8r?=
 =?us-ascii?Q?Ggrq4fNmW949o/dGxv4zRpJgg5UdcrX6MikqpCBb5JAPR87Hj8ULoGJF6WWA?=
 =?us-ascii?Q?WXt5RFbqv6VvJXlAwbxEMgXm+9uoLsShPEqVZuIHEPdXms17Ljw0x6kYljw3?=
 =?us-ascii?Q?DY1pcrkiUDzmi9ctKKGHxVEpxOQ5N18t3EEXpZi+Y3/vyF3Iy0i0BxJ3ri1H?=
 =?us-ascii?Q?Q/CzsjpmCwJWxuE7VwmBeqizFuRXI7BFIMDIjt8U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e9115b-bc84-4816-71a4-08db362ee336
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:41.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKXn2dCp7RvkwzqG9MyJv4VMyhWusj/O4fMN4aB/SBKURV1XZaStxXpo71GkqPh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

The iommu_probe_device() path calls iommu_create_device_direct_mappings()
after attaching the device.

IOMMU_RESV_DIRECT maps need to be continually in place, so if a hotplugged
device has new ranges the should have been mapped into the default domain
before it is attached.

Move the iommu_create_device_direct_mappings() call up.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5bbd667f727605..ca209fb3ddd1c9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -435,6 +435,7 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 
 	if (group->domain) {
+		iommu_create_device_direct_mappings(group, dev);
 		ret = iommu_group_do_dma_first_attach(group, dev);
 	} else if (!group->default_domain) {
 		/*
@@ -445,10 +446,12 @@ int iommu_probe_device(struct device *dev)
 		 */
 		iommu_alloc_default_domain(group, dev);
 		group->domain = NULL;
-		if (group->default_domain)
+		if (group->default_domain) {
+			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain_internal(
 				group, group->default_domain,
 				IOMMU_SET_DOMAIN_WITH_DEFERRED);
+		}
 
 		/*
 		 * We assume that the iommu driver starts up the device in
@@ -459,8 +462,6 @@ int iommu_probe_device(struct device *dev)
 	if (ret)
 		goto err_unlock;
 
-	iommu_create_device_direct_mappings(group, dev);
-
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
-- 
2.40.0

