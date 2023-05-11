Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC31E51F;
	Thu, 11 May 2023 04:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EucLftwyMmjkeriAYXTkycjznokdrUFjQUx7Lg5H7fYhHDgaFvfXRLJ6+z51PpSC7Nhz2b001wV6ib0DYwUnWxJyfGV1yQURf2E3dxJUEhKQPeBU1Ph3MevMs5ChJXwQPCi2sB0rEhPu4Jd2TgQ/U4JUKrgxj/oRod35i6Rw8BvemLdwpYMaPGwPDyZTQANp1x5IHvUOyDm9j9GLmxPmQ0DZxahv4vi+vw2zBwHhp+hPR+DxRP72Y7A2vN9cFhJNVa42xvs9t3fRHuAiG4jJ+Eekxx5+KrdXYu9LhDhWzuXdFxfQbUJPyBtUM501QTMrUnYpPAeYITboAt5lxmELIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBZE8yYvJL9ATmRlH/p9gxf7L3X9rXerAwfWJsdJQOc=;
 b=jpivrbwwo52WNF9VzVb2oJFKDrc3zuCLC2UWU3JfSuNsWBp/gMUP1jjwBVJWKXJDe2YqAqrw2Eecy4mY1qsKSnKzE+icAztwwyisH5W5kCwUBznyp8OI+0ylsnvxIGd9NjPOwpSKjCVNy+b0TlN8d13zJniJqEZ0ZWdkd69FO2vDtTlMOy7h0sjzi29xSDMRPnYaG1yLDrA4zb0s12svmtHc8hooHIIQvSHC+lP/OHis6kTa/exHPdvlYMde2BAbOZco95gUJwCyy0/PnEYh2wqytG4tO5/yuYagwl+MQvJfVVlTCIgvLKWA+I7qDN7gd8XcZQLHGY/olmFGLfU+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBZE8yYvJL9ATmRlH/p9gxf7L3X9rXerAwfWJsdJQOc=;
 b=trBXywP27QI1vYWGpX09Sn6KOOBcseIfHqxqZmI10tZH9b6jRTEPU4fEhsLJCHMtP0b3/qCzuXt6RAH8k7v1ZNNYd8kgTIUp3NLepJ/q2o27G2B3tmdbe88A1S2Dz8glZfNSZyswZF6YikzPzBVQYQIkg/YQKYyUscUn0czPFXdRPa1LnXkltjnASkzB65K6HENP5CGkjPq+OHubNqrspEetGC4O7K3sIvdMTtD185d+P0+ej4oE0Xa/RkWNScI5gzCYTeO0t5FL92oCMSB87PRnDenzsg1q7SHHZXK8lA37M+hpg4xDK1rDKcHJhd69PyXKubIrPaElk0BIZ4ljdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:22 +0000
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
Subject: [PATCH v5 10/17] iommu: Do iommu_group_create_direct_mappings() before attach
Date: Thu, 11 May 2023 01:42:08 -0300
Message-Id: <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5315d031-0c1c-4826-eb0a-08db51da19e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1C0utXa/6di++/llBaWqWoSOf86Cf8bwDAdBnm6er/naxIJXY9z3A3ixH8ZXDlfUZMYMEVFxL5FqLNSMCn9wVAO9MqyOFVmjssgeVdUbj9VCYuOCuanuN/0N7/OCFFOATsatcYq/1O+301kh2uEDCNdEJbFxXVoHkk8r4Zb9+BVaDwPbsT5gVuuuIQERBcxT5kCOWhyeP624TzWtfE3CZeMAHT9VJ4gsmbjAaaDooF6KJWXg+X4UBBUUkXSU3zY4gFWLLFKuAGKvSzPhCSFSKGPkNJqvrFOqs5ska8aDFzjdkQlok7jt4wwp3BZQzvCM0jAXuEy57DFSyfnLLUv1yiYJJudHKQeQeQY0CPUWgzRKJRdBHErQXo7OXAp4j9w+p1jJ6XhGYE4FFEtdxh3YsDoGOFsFQPWRF5NiRyfW6SQTOzEIRzdnkv58Y45KTHqJ7geo3MdFvCldkRmD2dbzYPZn4Ny4QTOlQeg+CVJ7e7cMQvhnoE/EB7ceKr3tdPOqzc0+7fvA107XEc21hQhbCx+fw4s+VPNLmYovtBihoqBLRk7DhG9p26c/9tozkco0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1i2vCzYrEMowv9CgGx4iVs/RUjZ2cfgiXePC3BCpUDMIRO6Qc/l68TMthyMA?=
 =?us-ascii?Q?TT3shE9yl1BgA9k9PDGkVODMIzL/Idq058+CRhlIYyCBSM7v4qD2Uz1tdvt/?=
 =?us-ascii?Q?ZFXwS+TmXIpOvsVp7qDf+/FxvJHawNemYSivwBD4h8MjuUeqaLyJvwsXciIa?=
 =?us-ascii?Q?KIUdiam0OHwlXCpok2IEBjhU+ax3Gp0UHG9lR3mbSq13uBns/4sTjtvkCfYh?=
 =?us-ascii?Q?Zfr3mRBrTKp9KYBYk7bbrHiNEw02lG+m29+Dk2XwFAJWPABzaaX8xHjLVIrV?=
 =?us-ascii?Q?AFHpDjLYLKWu05DO6TBGfg8AGw2O7MG0qDeQytcSbwzVqZgrAl0l/wjk7yg7?=
 =?us-ascii?Q?KS8ajGRWrbCzj2+7a3AD3FmP/Ovz4SHdSiBJi3i2IVdKhqiUrNmQGF/BF0dm?=
 =?us-ascii?Q?6a48tRypY5d2flRYis2duZU8bekP+orfC6rDm+ylWD+mNyFmYwivi+T/GKS8?=
 =?us-ascii?Q?zBoIQVinM6zAVSVdAEJLlsubI2wmnSYPsiMzS+ckySIwzMd8eSFeb0Zlv1JS?=
 =?us-ascii?Q?lLaXNwTt1jdwPNe0u5NPp/Zp7LD4FDTp4b6dGlv/h+RWZWAnsLapmGQwHszG?=
 =?us-ascii?Q?P/pj0x1jPHcQB8hUKHdWWTjT15zdolRzUl2ms0x2Ofsa+1ZPFdWJclgPas3t?=
 =?us-ascii?Q?7wvee61mRHcU9g9XPPUsgtMnUYtFf5AWhoXYfG3yQ65h5oCBT1PgsgDQ5cBI?=
 =?us-ascii?Q?IWCYwB4YI/o2hy2OsmJn+rYyCJWAYFPuPJj8Bo8LTFPhP+rh6pzL8eOkwUHi?=
 =?us-ascii?Q?eCc6gCv4gRPll+G8aFu5x6bkoPWDQfthB1Awgpe76n9GEWidaGCA7LZY210Z?=
 =?us-ascii?Q?UZJyRwSgXvBbz0suBXk57NJaj7YrAD1zsvpg0mP4V0lT3rI/5ZZC2hmmgBsS?=
 =?us-ascii?Q?61GUpWLiSdESNUZOkUmGAb2iXMOBJh7f55CidK3TANGXzYKx/Z/0661p7iqc?=
 =?us-ascii?Q?a7JPqjNeZYFxAWWVo2NuBir2XmwalIyoArzLbP+zkVuZoREj7ipsha8IAqiX?=
 =?us-ascii?Q?zBnkzzyOxZMkIT4jYpjSwBMSSPkpsDmzRRgfQ+xA0oB8z3V1FDYL+XqIbKW0?=
 =?us-ascii?Q?wUznWV8uFzrcdnX+v0d6bI8+gs/eFzMICcrJomBec3U5Mu5yAA05q4kDnuyJ?=
 =?us-ascii?Q?BPn7/PXitjimtkWUZm/7L/VQekl/b1flyUG5Fq/6rx6nX/IBxmDJfkSkk1Sp?=
 =?us-ascii?Q?WNZJ7SWei2PmsQQYbgGeXKfKVkoTTgl3EYuRsURacvQUSKSxKgL2PBsz3TdP?=
 =?us-ascii?Q?4D3fS19Hd6S+jeF0E8STlHSPzwPAM3OHJBOtHOHv7N83mzAtxP4k1v2VPthQ?=
 =?us-ascii?Q?t4GwjIiAVeWCtenR5mB0iybK263L7tc2UCPSPwUfrSjNHo54de3utzljxKhr?=
 =?us-ascii?Q?mQMsBBRKIXlsVL7E9RL/cf+rxmd0tH/Y57Uc+1GuK1kUzMetVCbF16Fy4OyM?=
 =?us-ascii?Q?f7cFOd+8AD+YIHgR9YaC+dA/uWm1h6M62oMsBFXQ6zN5ulRR7YYpKB+ir5tv?=
 =?us-ascii?Q?F9u0YgBMjI/2BoUHkLq/2ZZL5bmr3rG32nKnJvfiyw3UVyteHT5Hd/VBDera?=
 =?us-ascii?Q?PVEx2EkrxFQx02ref3TSmdm5sGOAqTJWgeykWAGV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5315d031-0c1c-4826-eb0a-08db51da19e0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISJBdnjWXd+jx2HnMkkoqq1xozpwUx6sbgxKgnijAcdm1+TZ6f4pvNzO7loIb3DH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

The iommu_probe_device() path calls iommu_create_device_direct_mappings()
after attaching the device.

IOMMU_RESV_DIRECT maps need to be continually in place, so if a hotplugged
device has new ranges the should have been mapped into the default domain
before it is attached.

Move the iommu_create_device_direct_mappings() call up.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 71ac5f7fe6bd09..690025e26413f1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -423,6 +423,8 @@ int iommu_probe_device(struct device *dev)
 
 	mutex_lock(&group->mutex);
 
+	iommu_create_device_direct_mappings(group, dev);
+
 	if (group->domain) {
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 	} else if (!group->default_domain) {
@@ -434,9 +436,11 @@ int iommu_probe_device(struct device *dev)
 		 */
 		iommu_alloc_default_domain(group, dev);
 		group->domain = NULL;
-		if (group->default_domain)
+		if (group->default_domain) {
+			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain(group,
 						       group->default_domain);
+		}
 
 		/*
 		 * We assume that the iommu driver starts up the device in
@@ -447,8 +451,6 @@ int iommu_probe_device(struct device *dev)
 	if (ret)
 		goto err_unlock;
 
-	iommu_create_device_direct_mappings(group, dev);
-
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
-- 
2.40.1

