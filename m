Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A541220
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDszIG2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn8/tQkVP3rlisbKql9VtiI7wVwWoco09Q0ak6xyGKM9ksYKovacRtWfaCPYqiQYFgu+Nt2d6b8/xwGrJBwtmKCfHo3mNQPDtrrtMusUglqUXTbiki/6skUE7JfK5V7SQxkR4sC0Vffbydf/b4380Br7sdBIMp9/jBAxC1OEwuzBU/FsCJKL31xf/Q/74FNhjeXNKnHWfI4Q+8oQ5U6TiRpllG3eDjjDtZPmiyNcdsl+AqGq1InsXZrtBHhIIzT9tklqxkVE0j2zGHykOnHHbgD79EiaR3dWO3uQrRxQK9fUEKOLSEAsLxervPOKfy4qImEO0+mqP9sUVOutHCaT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK+O94X0sxsuvzRU2Uq8yLUf85VxMXDoSKVV1tYZ++U=;
 b=RG1R9SIIgDYOrw+92OEd+FvK9kOP2w9GbJKHFGZB5VhyiQkvaCDgJSiuuCMVBkPOauSs4ZpkBFjkKMqbGYbslx8DCe4uCjQpiFD5wPHYnICMiRPWWB+NpyLwqIMC5ovJDfb9GkVxmsf2UpqodcvK5F/j9Hjs+9ypxnvclXWPmmazAT4HIANw/bv+ryGXl/nb19k7tPhRfh0GGOKmZDMXLTkhfHDLHP18KfSVQ4EmXXFaAeS4vQw6ViT0qEAqmBn/DOQjP2vWfpEhllOMr9UWoHsIOFoZk1gMrZnFMiw0wm+2FRrghMLwj3n7tAtlnIrO1ZuaDWjq3X9sGyyEhpXDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK+O94X0sxsuvzRU2Uq8yLUf85VxMXDoSKVV1tYZ++U=;
 b=VDszIG2nns0NLXF5GHWuSU6Sx4WWUHsdPezwluBKL54xAKOvbgpB5ey7goR5B6KhUp42buuylNTLqMgqxah9f7yDH565cgpWNdmuKczri/dTCu6gBhdQiUNYYKHbbqXqmcczBjEGCLXdzFt9+/3EoYwagyqXZdWbI4dfjYroAqwtgooUt3DrzLAcpEbBH2WYkuNDOQvx94zHaeDhRbEDNY6xPepx7zdnfdTUO5itQ6Ss5E4sEWYs9fIWu1bRsmIjMDHXy1EP64gKAyx0Jt6WyspZbQbZsVpiAM8jAlHYlDmCinsbej21JyR1NOjY4Qexd82bNHWSe39MpkdgOY/agQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:53:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:53:32 +0000
Date: Tue, 5 Dec 2023 19:53:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 19/27] iommu/arm-smmu-v3: Keep track of
 arm_smmu_master_domain for SVA
Message-ID: <20231205235331.GA2805372@nvidia.com>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <19-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a00d82a-42b0-49a2-6e53-08dbf5ed636b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6EBqUcVFPqg8qm0NE/nmtoc4zYA1k7wRDUymmNHu7N4D7146TH6F9Qq/Agqz7YNMVBA2WwW56pbriXxmfN3RTdX6H5Ch+YhE3ZI44IbnhZkntsEUkIOf8l0UvNf/ozdaWOcrbVwEz8qi7ErRt15PeslCWKo4iUdyhLQZ8Y0sx2l/wtrqeL+Le2d5jBwqhdnMYcmWMIThCKkVIsCIqLUeAGy/xdQydER+2OiEAeCIyn0BrOzppI2MhU0+ka72tt6VBROtziZRYezvmSSrLOQb9JxnwkNXpHANFEd2Bu8LH5KF9KTOoX3z7Gy0yXsCHpSjTFgOQ0xUJVt4mhjrsFCEQ4NLxxDqjzLU51ifnN0S7lRt2rzIuwltsW5jx3LLNdt3wKl93fRvEGngX2/qPbR4YSWiPrpSJvCQK0XIer3j3Zh+3GIWrwCV9WAYmzC7gGTr+ulJioISWZbQ3lVVNbrBMcT9x+qTAK56IZiex6itMv6tdfWWZoPEBzGQ1kC/B4kl/phAjtO1IzlphONuNe5Y8EqN4VNhcghxrk0hb4ef7936bXWzCL6WEPKuwu9N+sQ1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(5660300002)(36756003)(33656002)(86362001)(41300700001)(6506007)(478600001)(6486002)(6512007)(38100700002)(83380400001)(26005)(107886003)(2616005)(1076003)(8676002)(4326008)(8936002)(66946007)(66476007)(66556008)(54906003)(110136005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z+4rJDgWisunO0u0akDPTl01dszASnjBAI5bXOnkEVuFRPg2UoGNpxkEF1Ro?=
 =?us-ascii?Q?xaabgtsZ5gQKWlFN4sio65wOONZiTndb5liPS8o6aDHHJE/oRemPmRFMht3W?=
 =?us-ascii?Q?T9SbSSQCiJUSGC8oWjIygAWcDyojTNZNVdFKEWcwZEnmQLE6sLJpQ4HiPuax?=
 =?us-ascii?Q?HiihRjmGvga07+6OwZd2RZaxUDXoK7rhePSIwH5JSgaVCxsquoYZoSC4k0Gn?=
 =?us-ascii?Q?q42lMVfbSFTrhS3mIEc/MEqdGb/VXHdO7Z57Du/Kx3FuuUa7dwJc2Sev2/Dq?=
 =?us-ascii?Q?bj6cTAyM0es0B+/rLQiDGAbdCF5SDPIy64kbDNgcBqvDQ2J9/Vcmpiar82vk?=
 =?us-ascii?Q?b01Hm2+MAghFZ29n/36bXwhWSpa0AFHSnunibMn9VtQObnikzhVVtlv2j00Y?=
 =?us-ascii?Q?zuPZ4vOpaxIOAmeXC6eKl+Rcj8zJUyEVNfrZrU/q4nEBX2U1jjjag1eZIO4m?=
 =?us-ascii?Q?fIPsExXN9hI9thMHfWvlDyR0EvZ4sFp6U1wfsXg2f6dt6PVHBtZ3SRqSpvdC?=
 =?us-ascii?Q?oWnflGW2LiSt2hAr5OVD7wcgudbawHIqFatbBG77fZs4MQ/lElxAj9R1vZ6h?=
 =?us-ascii?Q?/kMhbZpxopNtxdMXg9ucCm6bgQRYTXny1Wmb00/oj6/ZryF+KRN63Wx2gTq8?=
 =?us-ascii?Q?cu8dGQ6oSZ/hO1ZFk86akmu4oIJpOsEqWIDneDdUD7u5ceo3lLj4UcJjnVNO?=
 =?us-ascii?Q?+nJRsksvijeTEvgiz3EU64aPC5bbVsDl0bIGxIHYzTMhiGb6d744vONB/5NK?=
 =?us-ascii?Q?KQcrlNKFZrHAo5fXPy85GmQmuMTQ2uxDuWyKNGmeCSd3GjC2RmPE1bDI8q63?=
 =?us-ascii?Q?z+ix3X+JX1KZ8bQcICF4HJpd1lZ+N6r0nD+Kasesf9fCXhX455b4dvCkmiTY?=
 =?us-ascii?Q?eb87AtyBp0uK10TpXza7IWOHcutzLv9qO4pBN85j1F2rjkZOftSuFDt996/X?=
 =?us-ascii?Q?P581XJ77wZvek6zWmQkZl+aeK8iLctRqX/WsmEsriuEk9ugmrEWcSOPK8Z2B?=
 =?us-ascii?Q?2uXY03QAb+89dKBIkB7zv/F5HBWxA2TMZzxpBizAUnMy+UYIpfnow8Vdg9UG?=
 =?us-ascii?Q?TY0AZNPCn6h/V82JkEpmTdSnJc8IOrZqc98LwRmHHVeBTmZkyDROy3KqbiXO?=
 =?us-ascii?Q?meeX3fAutNZMx5chtnW2NxSZOIWSaaEGqK4t9GCf+wl96QlfUiGb+Fr73UKl?=
 =?us-ascii?Q?gy1kaBQ3xK7FRq2lJ4TQfw2Gevq7dnAmc9WG+62bN4HOl/ghVhcO/CpSw5S6?=
 =?us-ascii?Q?p6PajtZfoU2Hx+tXsdKo78GQ7VYYis2TlIu/8RpBM1s1qwt4K/4jAehz86W6?=
 =?us-ascii?Q?dGjUl8c/1hGOGt25rR8DcU0Ve5C45w6/AyWOiC0uPkSGbxywB719iPg2k2Kx?=
 =?us-ascii?Q?/Tg8emygfi205mMK/1+okQztpJaCf0UznejHKK4LFfkP6y2dNSeHtzg7PXX5?=
 =?us-ascii?Q?/jp1HTqRXCg2dIwjP58lPkdF+eV1g//83z96DcQL0lDzLX1ddfygWF+zAcDB?=
 =?us-ascii?Q?DCNqeIe7+EuN7sESn0zpHUX1iCSqJ/Be2HjuPH+QBbGqe/KnLzOJD5hCimz0?=
 =?us-ascii?Q?ymjs8Vm4J0UPePKCIruzReoSGxA+uCX8S6arjtoc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a00d82a-42b0-49a2-6e53-08dbf5ed636b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 23:53:32.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4POjOQzWRus9syUv1R5EIRTkASD2LGKJCRUD2HBXm4kCi8yomQEpl2wLOwBFlqWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

On Wed, Nov 01, 2023 at 08:36:37PM -0300, Jason Gunthorpe wrote:
> Currently the smmu_domain->devices list is unused for SVA domains.
> Fill it in with the SSID and master of every arm_smmu_set_pasid()
> using the same logic as the RID attach.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 326c82fad90b8a..23bcdf1630c23e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2712,6 +2712,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  	struct arm_smmu_domain *sid_smmu_domain =
>  		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
>  	struct arm_smmu_cd *cdptr;
> +	struct attach_state state;
> +	int ret;
>  
>  	if (!sid_smmu_domain || sid_smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
>  		return -ENODEV;
> @@ -2719,14 +2721,30 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  	cdptr = arm_smmu_get_cd_ptr(master, pasid);
>  	if (!cdptr)
>  		return -ENOMEM;
> +
> +	mutex_lock(&arm_smmu_asid_lock);
> +	ret = arm_smmu_attach_prepare(master, smmu_domain, pasid, &state);
> +	if (ret)
> +		goto out_unlock;
> +
>  	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
> +
> +	arm_smmu_attach_commit(master, pasid, &state);
> +
> +out_unlock:
> +	mutex_unlock(&arm_smmu_asid_lock);
>  	return 0;
>  }

This should be 'return ret'

Jason
