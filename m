Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3F4C10DC;
	Mon, 28 Sep 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612271; cv=fail; b=ViEd26I8E5tMbPLoMlyES/YxF+Ezbr6VWdDt6ud3auQizneFQ+Yx9AwaJrSlAyFtjx2YB1NCSw5H2yXSNbntsVrXmEXxN9QAQBrDNa2p9w9QhXvk0IviSgS90YhTB5MQQ+ovBKxYdWZ8e9C9cNN6iNUkmqYXQD/OOTc2hBtTiuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612271; c=relaxed/simple;
	bh=FxeLb1dS7CDNl6FQurFCppbGX7KzQrxrxMp6Dkr+kEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cz4IglKAwRus8G0WG8lhrOCCUInvnv5W11boXMcmn6e7xvHNUDNHgd40+1x974lj8NQQbuSxUMrgcjXAMEvoMMpsWc86JAw0HYnNvqeYO9czMrji15F3SZWf9WQzvyeC3x9G9whkIj4Yw18vgTUd2UCV6SlB0X07Flqczwjn1mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j2pYBWID; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j2pYBWID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crhqsKFBjxozEuDQc0slTBbtZOH1xxGT4+e4NCoDks0s/a/+/Oic8QUy/4caDa+dEB7VeMlVMT6Ql8LCs3s93oAprWAQZ86RgQl/mMCGjVvpGdSPgEMl7LrR8VYOV/jxLGXA4KlrEIBOaUjIHxlvNKG7GdPomdNBfhD5euop5v0Q6aRFRsG+fnruL6cidAN7dsFTskaX0UFSmVXkSVWYhstx6Lipr/vZWAn0ckOTdQYh3570yk/LGUI1sWmFwAqCBpPGE25oi9DOr+vOUtlbnw0uMZ9tRuly+GaX/6lfbfthZaSSWh4jVaUENvegqOYl/gCT3w5gITZAaJJ5fouX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVzXA+33gRkmmSOQtWmltsgox3eEKR7MXnlfrgoz0Xc=;
 b=QwxMi5A38ixQ0STRvl9r/c6lF3VwDaA0iDU/x7g+XlSijVYcxDZhqiZuW1/pyHA9ru45ITL32L5tHPXf9K39embbh9b0LJhc2k4lO+r0G2vgwl6kju+UGQnLHkisvs9WZaWSRLnspkW7lHxDLS7g27/k5Ja5LvjkCtFcZAC4UZigVtRtMXcP+Lb0x3RzjSyCA7I89HlKQ9Ir3jZ2izoGYe/NPzp3FignWSJkJ1LhLfGEcVhM0wacDff8tT1qhZdJdTeSrKiRztoNCJJbx6JSKYnFsHL8mhpxOCLzJGgKN7RPOMq2zL7Vzt5eJnUrkCMtCJpQEsZSdaZ6sHbEGymbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVzXA+33gRkmmSOQtWmltsgox3eEKR7MXnlfrgoz0Xc=;
 b=j2pYBWIDK+AsGPqD3mU0jGvL31MNIc9KStlbJyKYoCFJ9dn83NdKf1lnDQcvkNa4RE4ND6CBJA3UJPQj6VNRHOQdQOgJ0G/VK3pEYqSfiTilZShTWm7ggsezzUo+64fJ764D5Q3jMoimNyZOWwejqR74g8BeCM1uDBXx4dBdc5Joe6FcesV3zCIMfCtfjQeIM7EaDardAafYLfLsLpjMRveIWJtP9FMAIRucAs1ME9OpPDvBiYEJeksKaHNpNSyvHez+wrrpbRZyJ3gJscguVgrpRGsmBNa8pUmASuJe95SojKeOHowyK0UUpWVg6zUzCWzEsEnc5irDkRPbgZN62g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4298.namprd12.prod.outlook.com
 (2603:10b6:5:21e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 16:17:40 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:17:40 +0000
Date: Mon, 28 Sep 2026 13:17:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260928161738.GB1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org>
 <20260925122305.GG9354@nvidia.com>
 <yq5a5wzpr7b9.fsf@kernel.org>
 <20260928121147.GP9354@nvidia.com>
 <yq5azex1peqt.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azex1peqt.fsf@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: b2482210-042b-4bb0-7e89-08df1d7c04a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|11063799006|56012099006|4143699003|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	yUWn4S0FQBK2oEgBIUkiDOXLgycU6vCd3MrSjXIEKda47+gS8CrTX7VpqM43MIW00tt4KCgqFj5WF2j8VBwDG4KukHp9YmP+53/KgYZAr1Xg9jPI0Za9VHOr8SiJ0+7MfNWCdAka/vA2EEbWPNJ4R5ITTP1ENoHkT2UVbHMAyKRLvia1LiCJaq8APWKLhpZIiinJEO0d6ZY/2ypZO7nQ2VS9xtR/qzXLvnRqpJKheVvMUftB2O+wnYQ6qizbP6wZoMf0glA1BKZ2K0q0VPsXf1atD/bUxvZemLPZH/E7gTeirOxmBc1SiMfr5gLp7bRpgh4Mv6ABskVJhLL23yRT72Zy0KcKaE2qGVjWWLTtURcy6hOHqxMIAbsQ0tWcsQkcokVeWP15GNUxnCsOjHJ26KoI3RaBAB7SUVJOoaULUJ2viw1BRg+1Een68X75pepxIcUDQ/hKgrO0nsoMOf55HHyzHxhETMBnfZ0UjbHhYQIFPCC+nOAj/ndzsIA4n6y94o6kSwCDmPFB+6jadMqhVJfQFBvY63gKM1ns7d+iiIVPCsjppRkkiIQnMGvFaduR11oWtISOO0TR6b8Mjj+jJx295Cm6TbnF3k8mdovr7smSJqFmOMmYak74dEhrkMbU7m1MwOoTZi/64y+2FYuIJjTMFP02lEsfM6DEfD+mEdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t3/5mccj1PsqdpTErTzxEi8Zm1sQPX59zGNlSu2XcE9OxZmC2i/9myOVbaot?=
 =?us-ascii?Q?3Xu64imz3I0eEhH0jMInRXgxaJyerepTaScG3dKIqePHMLGeVwKT5Ozj7qUJ?=
 =?us-ascii?Q?ETzl98Y+PS5Xfn705YEclwMk8zLsYmsZIzh5CzGI791XExichY2mLBVEwb6B?=
 =?us-ascii?Q?41RS0Mkncm4aPnNrKYuUrGbXY1xuj7Q/AD8RKRNtHMsXw0c/wM39K+CCr64N?=
 =?us-ascii?Q?1yCu4L2f4f5C5+sWCSEkBYo4AB9JRLMz1R1WYSBcw35UKJElqAW0fo5nCBum?=
 =?us-ascii?Q?ESqrMwdBG1p2ZNxepuMAUIDcpe0gDyusQgwe1VdhblrRoKRSDUYwB8O3Ccyp?=
 =?us-ascii?Q?YjgsvMwrHXR/E1GL/1k303EieOOusxc55ohULHWGIpQq2vmBUPcgpU0bgoia?=
 =?us-ascii?Q?EX26dPdlYMFizOqhWouO/ouTxjY0Xzn6Y/1+VcfeMnZip224yiXv9vp0LEla?=
 =?us-ascii?Q?PhM04WbjDOoMTSAUJpZZpRmrP5aCoXZb85PGSggHwU6a67ozygOoOVMbxqJr?=
 =?us-ascii?Q?y2XUTWowE0p4DFc4tgcvapJlzXr/K3oEIoN1lde//k9mb+BZUXnDk2GL6Q6Y?=
 =?us-ascii?Q?3yK0zi4Wz/d82do09iabEPBTu4/ntsT6F/mrOOJQvE2Sbb85HFJ4t0EVlGEB?=
 =?us-ascii?Q?D4X1GNRQuTIhxIt8cLHj2pTLGzGf8YoHpGDxMoubuLJYXvt5fdBjrEhKzxZr?=
 =?us-ascii?Q?pHC93dLqefQODl5KJLivp6vIwqEIWAEyanpevAFa6b5rPf+3G2zaZkSSZIdf?=
 =?us-ascii?Q?aYs4TzfmdPiuEzPHmlih1wpWjvd06Btfbrtyj3uopg/zUl013uNGPVTd9PxV?=
 =?us-ascii?Q?3RJTlh/EPlCz1AQRQyXUFqN9ZPi+ESgrl0sUSEwI6mOcZeaRPJKYjpM5Y8P0?=
 =?us-ascii?Q?S5QfEeILXQCjNhN/7hV77DSgCFVkmB5ZqhuuGsaHjE+rbwuB07V4HukTxzIT?=
 =?us-ascii?Q?MjMcOZZf5bpzDP6xOBen0uECcwpdBhfZO9W3I1L0OBZ/ZHnXuhFf2Eb5m2iL?=
 =?us-ascii?Q?3MdFW6Kvqb65B0QzVApxuj5malNDzva6nkNagcAKWULZZG5wEXB3+OcLlr7U?=
 =?us-ascii?Q?rS7o1lDPxqO6PVuEJylZmRfVtWogFqmCyJKeXaSGqg2IrsaoJaIIHPhEZqSn?=
 =?us-ascii?Q?TbZn6lji9fAn/doGKMPPDGokhcVYKHGKiojQheIvtCV9zcLh6lEC9YUzCFSX?=
 =?us-ascii?Q?xeuVBElf1SIKdZ/Wp9YALoCqsOAMqtM/mfhKsmVBCjoYJbntsWjj+Mwk7hIZ?=
 =?us-ascii?Q?sTsvi6xqLIgs6jAG3gdHZlFMUGV+8PZRdno/l+U7du4Kk09LUcKxRj7+fMQx?=
 =?us-ascii?Q?S3cikBQ/JoEhgpZBoKliMJRHoLobjePJ5ASKBM6MXyD1si21gINbbudrTvlq?=
 =?us-ascii?Q?olWO+gVUAolYgBsJIBeet6ROHPHaPXrVyhk9RPEHq59Bb74A7ggxJNlKWEV5?=
 =?us-ascii?Q?jTDTzyDszdXK/mySE5GCKfSnwNBetsNeqGiR4N+Neqc+TRmETQ3c2RoBlXpv?=
 =?us-ascii?Q?Juu9Mp+eCs28n9l5Yb6k4OM8BwrMrHvvzWTyXcB6JKc84O8ic/5RwcwTwdfW?=
 =?us-ascii?Q?toyDdiUfWPEkhvyEj6kCaOwtWFennJ7+WYFH3e7BoZmKDByEJKDCbPXE5wt5?=
 =?us-ascii?Q?F2hvGnVSTfbrjGBe5JIWaGR8jYMj0hyrhG/vdqAlDSVJk5QL7HP2CHZYv+v5?=
 =?us-ascii?Q?fUrBqouZcRIqS/pB3m4m0j7OQWah5izbTdhHe8xRgUMrxVID?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2482210-042b-4bb0-7e89-08df1d7c04a3
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:17:40.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlQQ316kleRXhLUHN2IiL9AlYik5IMXwTIIBNfw/clfpwI2YzsrsUZz94G3pRBn+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

On Mon, Sep 28, 2026 at 09:09:06PM +0530, Aneesh Kumar K.V wrote:

> Does that mean the SMMU driver will return viommu_ops before
> iommu_ops->viommu_init() is called? If so, should viommu_init() be moved
> into viommu_ops?

That's probably the cleanest arrangement, yeah. Then the TSM ops are
just the same 'get_viommu_ops' call under TSM and it is easy to put in
a flag 'must have null hwpt' that goes at the right point.

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c620..269f67346ac760 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3214,8 +3214,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.page_response = amd_iommu_page_response,
-	.get_viommu_size = amd_iommufd_get_viommu_size,
-	.viommu_init = amd_iommufd_viommu_init,
+	.get_viommu_ops = amd_iommufd_get_viommu_ops,
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f20..e86890a59865db 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -32,11 +32,19 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
 	return hwinfo;
 }
 
-size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
+static size_t amd_iommufd_get_viommu_size(struct device *dev,
+					  enum iommu_viommu_type viommu_type)
 {
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
+const struct iommufd_viommu_ops *
+amd_iommufd_get_viommu_ops(struct device *dev,
+			   enum iommu_viommu_type viommu_type)
+{
+	return &amd_viommu_ops;
+}
+
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
@@ -73,5 +81,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
  * struct iommufd_viommu_ops - vIOMMU specific operations
  */
 static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.get_viommu_size = amd_iommufd_get_viommu_size,
+	.viommu_init = amd_iommufd_viommu_init,
 	.destroy = amd_iommufd_viommu_destroy,
 };
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
index 62e9e1bebfbe59..6729f8f37506b7 100644
--- a/drivers/iommu/amd/iommufd.h
+++ b/drivers/iommu/amd/iommufd.h
@@ -8,13 +8,12 @@
 
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_type *type);
-size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type);
-int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
-			    const struct iommu_user_data *user_data);
+const struct iommufd_viommu_ops *
+amd_iommufd_get_viommu_ops(struct device *dev,
+			   enum iommu_viommu_type viommu_type);
 #else
 #define amd_iommufd_hw_info NULL
-#define amd_iommufd_viommu_init NULL
-#define amd_iommufd_get_viommu_size NULL
+#define amd_iommufd_get_viommu_ops NULL
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_IOMMUFD_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d801e..b848219f91c984 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -532,20 +532,28 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	return ret;
 }
 
+static size_t arm_vsmmu_get_size(struct device *dev,
+				 enum iommu_viommu_type viommu_type)
+{
+	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
+}
+
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
+	.get_viommu_size = arm_vsmmu_get_size,
+	.viommu_init = arm_vsmmu_init,
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
 	.vdevice_init = arm_vsmmu_vdevice_init,
 };
 
-size_t arm_smmu_get_viommu_size(struct device *dev,
-				enum iommu_viommu_type viommu_type)
+const struct iommufd_viommu_ops *
+arm_smmu_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = master->smmu;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
-		return 0;
+		return NULL;
 
 	/*
 	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of the exact HW
@@ -553,7 +561,7 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	 * any change to remove this.
 	 */
 	if (WARN_ON(smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
-		return 0;
+		return NULL;
 
 	/*
 	 * Must support some way to prevent the VM from bypassing the cache
@@ -565,14 +573,14 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	 */
 	if (!arm_smmu_master_canwbs(master) &&
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
-		return 0;
+		return NULL;
 
 	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
-		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
+		return &arm_vsmmu_ops;
 
-	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_size)
-		return 0;
-	return smmu->impl_ops->get_viommu_size(viommu_type);
+	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_ops)
+		return NULL;
+	return smmu->impl_ops->get_viommu_ops(viommu_type);
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d6..eaf7fb1f40453f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4389,8 +4389,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
-	.get_viommu_size	= arm_smmu_get_viommu_size,
-	.viommu_init		= arm_vsmmu_init,
+	.get_viommu_ops		= arm_smmu_get_viommu_ops,
 	.user_pasid_table	= 1,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
@@ -5489,8 +5488,8 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
 
 	ops = new_smmu->impl_ops;
 	if (ops) {
-		/* get_viommu_size and vsmmu_init ops must be paired */
-		if (WARN_ON(!ops->get_viommu_size != !ops->vsmmu_init)) {
+		/* get_viommu_ops and vsmmu_init ops must be paired */
+		if (WARN_ON(!ops->get_viommu_ops != !ops->vsmmu_init)) {
 			ret = -EINVAL;
 			goto err_remove;
 		}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979cef..6675f4232be075 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -886,7 +886,8 @@ struct arm_smmu_impl_ops {
 	 */
 	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
 			 enum iommu_hw_info_type *type);
-	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
+	const struct iommufd_viommu_ops *(*get_viommu_ops)(
+		enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
 };
@@ -1260,8 +1261,8 @@ struct arm_vsmmu {
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
 void *arm_smmu_hw_info(struct device *dev, u32 *length,
 		       enum iommu_hw_info_type *type);
-size_t arm_smmu_get_viommu_size(struct device *dev,
-				enum iommu_viommu_type viommu_type);
+const struct iommufd_viommu_ops *
+arm_smmu_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type);
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
 		   struct iommu_domain *parent_domain,
 		   const struct iommu_user_data *user_data);
@@ -1276,9 +1277,9 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array);
 #else
-#define arm_smmu_get_viommu_size NULL
-#define arm_smmu_hw_info NULL
+#define arm_smmu_get_viommu_ops NULL
 #define arm_vsmmu_init NULL
+#define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc_domain_nested NULL
 #define arm_vsmmu_cache_invalidate NULL
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431ec..bcb5f3efdb190d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -892,11 +892,14 @@ static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
 	return info;
 }
 
-static size_t tegra241_cmdqv_get_vintf_size(enum iommu_viommu_type viommu_type)
+static const struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops;
+
+static const struct iommufd_viommu_ops *
+tegra241_cmdqv_get_viommu_ops(enum iommu_viommu_type viommu_type)
 {
 	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
-		return 0;
-	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
+		return NULL;
+	return &tegra241_cmdqv_viommu_ops;
 }
 
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
@@ -907,7 +910,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_remove = tegra241_cmdqv_remove,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
-	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
+	.get_viommu_ops = tegra241_cmdqv_get_viommu_ops,
 	.vsmmu_init = tegra241_cmdqv_init_vintf_user,
 };
 
@@ -1289,7 +1292,15 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	return 0;
 }
 
-static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
+static size_t tegra241_cmdqv_get_vintf_size(struct device *dev,
+					    enum iommu_viommu_type viommu_type)
+{
+	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
+}
+
+static const struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
+	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
+	.viommu_init = arm_vsmmu_init,
 	.destroy = tegra241_cmdqv_destroy_vintf_user,
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	/* Non-accelerated commands will be still handled by the kernel */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 25387969ab7536..3c997de987247b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -767,7 +767,15 @@ static int mock_hw_queue_init_phys(struct iommufd_hw_queue *hw_queue, u32 index,
 	return rc;
 }
 
-static struct iommufd_viommu_ops mock_viommu_ops = {
+static size_t mock_get_viommu_size(struct device *dev,
+				   enum iommu_viommu_type viommu_type);
+static int mock_viommu_init(struct iommufd_viommu *viommu,
+			    struct iommu_domain *parent_domain,
+			    const struct iommu_user_data *user_data);
+
+static const struct iommufd_viommu_ops mock_viommu_ops = {
+	.get_viommu_size = mock_get_viommu_size,
+	.viommu_init = mock_viommu_init,
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
@@ -783,6 +791,14 @@ static size_t mock_get_viommu_size(struct device *dev,
 	return VIOMMU_STRUCT_SIZE(struct mock_viommu, core);
 }
 
+static const struct iommufd_viommu_ops *
+mock_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type)
+{
+	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
+		return NULL;
+	return &mock_viommu_ops;
+}
+
 static int mock_viommu_init(struct iommufd_viommu *viommu,
 			    struct iommu_domain *parent_domain,
 			    const struct iommu_user_data *user_data)
@@ -854,8 +870,7 @@ static const struct iommu_ops mock_ops = {
 	.probe_device = mock_probe_device,
 	.page_response = mock_domain_page_response,
 	.user_pasid_table = true,
-	.get_viommu_size = mock_get_viommu_size,
-	.viommu_init = mock_viommu_init,
+	.get_viommu_ops = mock_get_viommu_ops,
 };
 
 static void mock_domain_free_nested(struct iommu_domain *domain)
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f7951057a1e564..25eef8aef3e84e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -26,7 +26,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
 	struct iommu_device *iommu_dev;
-	const struct iommu_ops *ops;
+	const struct iommufd_viommu_ops *ops;
 	size_t viommu_size;
 	int rc;
 
@@ -42,8 +42,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		rc = -EOPNOTSUPP;
 		goto out_put_idev;
 	}
-	ops = iommu_dev->ops;
-	if (!ops->get_viommu_size || !ops->viommu_init) {
+	if (!iommu_dev->ops->get_viommu_ops) {
+		rc = -EOPNOTSUPP;
+		goto out_put_idev;
+	}
+	ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
+	if (!ops || WARN_ON_ONCE(!ops->get_viommu_size || !ops->viommu_init)) {
 		rc = -EOPNOTSUPP;
 		goto out_put_idev;
 	}
@@ -100,8 +104,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_put_hwpt;
 
-	/* It is a driver bug that viommu->ops isn't filled */
-	if (WARN_ON_ONCE(!viommu->ops)) {
+	/* It is a driver bug if init selects a different ops table */
+	if (WARN_ON_ONCE(viommu->ops != ops)) {
 		rc = -EOPNOTSUPP;
 		goto out_put_hwpt;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 05f7cee1375eed..b37b09f934c1dd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -46,6 +46,7 @@ struct iommu_dma_msi_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
+struct iommufd_viommu_ops;
 struct msi_desc;
 struct msi_msg;
 
@@ -669,16 +670,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
  * @default_domain_ops: the default ops for domains
- * @get_viommu_size: Get the size of a driver-level vIOMMU structure for a given
- *                   @dev corresponding to @viommu_type. Driver should return 0
- *                   if vIOMMU isn't supported accordingly. It is required for
- *                   driver to use the VIOMMU_STRUCT_SIZE macro to sanitize the
- *                   driver-level vIOMMU structure related to the core one
- * @viommu_init: Init the driver-level struct of an iommufd_viommu on a physical
- *               IOMMU instance @viommu->iommu_dev, as the set of virtualization
- *               resources shared/passed to user space IOMMU instance. Associate
- *               it with a nesting @parent_domain. It is required for driver to
- *               set @viommu->ops pointing to its own viommu_ops
+ * @get_viommu_ops: Return the vIOMMU operations supported by @dev for
+ *                  @viommu_type, or NULL if the type is unsupported
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
  *                   translation.
@@ -729,11 +722,8 @@ struct iommu_ops {
 
 	int (*def_domain_type)(struct device *dev);
 
-	size_t (*get_viommu_size)(struct device *dev,
-				  enum iommu_viommu_type viommu_type);
-	int (*viommu_init)(struct iommufd_viommu *viommu,
-			   struct iommu_domain *parent_domain,
-			   const struct iommu_user_data *user_data);
+	const struct iommufd_viommu_ops *(*get_viommu_ops)(
+		struct device *dev, enum iommu_viommu_type viommu_type);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3087f5b2def848..a13fa3d447467a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -142,6 +142,16 @@ struct iommufd_hw_queue {
 
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
+ * @get_viommu_size: Get the size of a driver-level vIOMMU structure for a given
+ *                   @dev corresponding to @viommu_type. Driver should return 0
+ *                   if vIOMMU isn't supported accordingly. It is required for
+ *                   driver to use the VIOMMU_STRUCT_SIZE macro to sanitize the
+ *                   driver-level vIOMMU structure related to the core one
+ * @viommu_init: Init the driver-level struct of an iommufd_viommu on a physical
+ *               IOMMU instance @viommu->iommu_dev, as the set of virtualization
+ *               resources shared/passed to user space IOMMU instance. Associate
+ *               it with a nesting @parent_domain. It is required for driver to
+ *               set @viommu->ops pointing to its own viommu_ops
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
  *           of the vIOMMU will be free-ed by iommufd core after calling this op
  * @alloc_domain_nested: Allocate a IOMMU_DOMAIN_NESTED on a vIOMMU that holds a
@@ -184,6 +194,11 @@ struct iommufd_hw_queue {
  *                      does, it should set it to the @hw_queue->destroy pointer
  */
 struct iommufd_viommu_ops {
+	size_t (*get_viommu_size)(struct device *dev,
+				  enum iommu_viommu_type viommu_type);
+	int (*viommu_init)(struct iommufd_viommu *viommu,
+			   struct iommu_domain *parent_domain,
+			   const struct iommu_user_data *user_data);
 	void (*destroy)(struct iommufd_viommu *viommu);
 	struct iommu_domain *(*alloc_domain_nested)(
 		struct iommufd_viommu *viommu, u32 flags,
