Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE34E4315
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329494; cv=fail; b=Czxmskd/iO7b3QX/TRqZVzJmAAcPk+ZK8GzHFGjEzFvmNFEFglFE4Eg0X0GAyPEdYBcz+M8znjHRjO1XXOQlKtTOoXAkW4WoEmm1WlW6WJllRDngQk7OslJNoh+GjnpkAWkE8uXH9zipNMOCLbQkdl5g2dBjXijZiyJ7tN04KKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329494; c=relaxed/simple;
	bh=5ZGHQKGUpscKoKM3n34s7kEACCjsntp+Ty1I4FBgKfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzHSsHuB89NnkRITKRoobkbz5sTAC+AR6jCge07hSO8uXGygI2R7BMsNU9IRgadas72r4zoXU+6xkfUrxHh6EpI6uJ53zYehS0kAt9IGtoWd+BFoEF18+iwTMxqqH1Y5UNc/n9YudKwBCBjBqy2n985M9RUo9UOj5e1USDJ6ET8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2x5BEoq; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2x5BEoq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UATWXz63gnfe4FQINwIK9gVH4++TsDqI6jtjm07Hnraq0B9sGZSRvPbxAWJ+e8i0Kjt0wwElNQNESEveOySb7PRHqE5rFPW4kh78Yr3Kceh0uq9ZKyxwz5Oq4/1JsFLtjjmOBSQDJwgDUvudOreDyYt/zbFlPd8rD4FOXAtWRJTaa1BUmvEA02hY+PlcBsaz5kMrimYAaiiHDEQP5SJEHEXVFDWV2HxTAdKVutAgCITubRAB9oKGBoD2IsDm/hy2kYspUIzRVofYcwYFbEQs7o8dkp+9nDU27Snm9+dhc9GqO9VoS1tfz3C/e0/n6dWTVXsnHufDosyZ02zvu+BtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EJKj3f1XYoEf5COtb7I7LvsI8iTutjXI+ACRTobhCo=;
 b=LJjhbS7uGRJBOZIgpJIqAQIABCbV1GwdmUaorr6IEcvwxBLPZ/nYG2koYhDH01RWSN8+5qtxIG610OZpjTwfCuYkvjL+RFvuWF8O5pgtCrsm4l7C6sSD/BBYjZEJGUu9V/CvHVecCbVHDRTZJSZwwX2lOyGyOTXI+D4z+kEVRrGuUwOP7dU5F7XomKpTZsMUphgC4McSyixaGxiuJcUZe/a0j8mbH0DMPY5vScBU+3Uxct/mso4a5/+IERp4abEf1zqvLqEb9dVZPbvxVvU5aGeEi9oJEN/l35rXXNoRcc1J1XSAgdO9moW5UzGLY03+n5azC7yyEuOBQW4CBqQUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EJKj3f1XYoEf5COtb7I7LvsI8iTutjXI+ACRTobhCo=;
 b=F2x5BEoq5EpU3kezsEUR03yQnOeGzKRG4JH1JvCVamxDAMouoZnW4MoCWKP6UMlAGo0rfNeuIG528KH84DKmkqiYUd4+gmxYbVCLaCGdLjOI8+PgVFosswYYUngBIz8xqmScFnagGXiiAcU6c+hbQ9nsIGBZgB3NbM4TmS218WiDhrXMBHFAIDzEqrgywRt3v0j4jGnCJSpgIuvrVRocXHo63DYpV4/r2nf0Ug8KH8hVkmQrKPF4r/2H4vkZuOwsACzBuyonqpSVfVYsSfuVfDA0Ri7w1em4JP0ccdfBkHFsk+37QE+bGvCatcOBV/1JPUSzkExSWO/HxhG9Aly/dg==
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 23:31:23 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::68) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Tue, 6
 Oct 2026 23:31:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 23:31:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 16:31:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 16:31:06 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 16:31:04 -0700
Date: Tue, 6 Oct 2026 16:31:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <asWEtTcNJSbrY579@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-3-skhawaja@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 609bddb1-15e0-4c48-b5bf-08df2401eed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|1800799024|36860700016|376014|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+eh8IMJcBr+/BPQhW6MhcInbVoAi99Z6iIZxhd0lOhqi889hNKducq4rUk6dLwXG8M8B2VSDmKC4vS9cSe42pTRNLlBsJkSZ0dChwQ3GlvDSEgmLsOcdLWGunEdiiARcM0dC9xlisLHInWQwoi8ZeLOJQceIBn9Yq0U8i0apFHl7ZirSzoz5E/2bK2ctKjZucyaS3eSdpEDuo9Gv2HaxDHO8+xrrvjTRmo5Z7UOS9FEuGNGx1dAZQ9HYlwy7R3CbBSwY3BvIrd5+KpgvWVhvfwDKiD0FRnp4U8B5psZm6enFtR9McOvAyx175O/6Efmg17+ONO3mAeZj3pwgOnlcVB+VjMqvc1hC5nZz1Fv4NBby4FXS/Ty9pKYv0WqubutX9bkefO+iJYtu17ryc2o3l3sToSFOzpRRX1lGZtB5g4pDHAN0YCIeD65+sNUbsznbDcoT2Kl0MI5HBvfe/EGsF2rfJOER/WeRrD6vs8cL7HTzB7mb8YUalja9bdKEsVJ2q5rKgyb04y/9Fw1MZXn3wFUhoq1FZA6lRTPdJ5poD7CBRQSpklzForEm22LQnUyQY0V59CG0eYnAdVTFKH0w4RJw0DGMaTYgwU5MsPFt57ROMHstnmAUKiEsCLwqucL3XQdecVdMXLG+ukNf1HSEh6DApQ9c5BO6eRXeEtiF8l4MtDJtpCflvfZZvYIAc3bAsWRc1qtkejWmVoOkpQSUdQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2+S7cii6HruVkITiOAqYbDKO9pl2rBeagAFzd7dWR6+TjbLZrLtWCgnhINNAoJOmxGh4LFN3legxiNfQ+xLNk3JNsd7fj8UJNFS/XyRdNaiSQ+yowoBIfroUU+M5RlgZq/bcrXLJzIe0x7Fmp0HzJhXTtH8I3l8QqdmF/kYQQp98YPcAHWgI1o/wYLRmQQsMEMnusmIUwU3q+n5zyw96nhbg4kMe2knOhDsxXE9cSct4AamfumywQskufLMxw2/zLh7gP+ryFvqRErG2HuDtJEVmkHN762ODblUCqnccfqziL+pMKtOyRtWQk6/o9VRjCmanV8+M60Q7VbrvFZVkHZ3eYdhMp910rGm5zBQ+KTvglu73gkFpxGzF4W9yuccAQ3wCzy+8bpjZlW7mpgRaIHMvkaOoa71Hb/p4Uif3orVwezid7VYLkwihIW+3r+cA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:31:22.8908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609bddb1-15e0-4c48-b5bf-08df2401eed2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

On Mon, Sep 21, 2026 at 12:48:18AM +0000, Samiullah Khawaja wrote:
> +struct iommu_flb_obj {
> +	struct mutex lock;
> +	struct iommu_flb_ser *ser;
> +
> +	struct iommu_hw_array_ser *curr_iommu_array;
> +	struct iommu_domain_array_ser *curr_domain_array;
> +	struct iommu_device_array_ser *curr_device_array;
> +};

IIUIC, there should be one pair of obj + ser in the entire system:
  - old kernel has one outgoing obj + ser
  - new kernel has one incoming obj + ser
right?

If so, things in iommu_flb_obj (except ser) are all transient, and
there is no need to preserve them across the two kernels.

It also feels redundant to have this iommu_flb_obj structure. Why
not link liveupdate_flb_op_args directly to the ser? Then, things
in iommu_flb_obj could be global?

> +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_flb_obj *obj;
> +	struct iommu_flb_ser *ser;
> +	void *mem;
> +
> +	/* obj exists only in the current kernel to track preserved state */
> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> +	if (!obj)
> +		return -ENOMEM;
> +
> +	mutex_init(&obj->lock);
> +
> +	/* mem is allocated via KHO and will survive the kexec */
> +	mem = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(mem))
> +		goto err_free_obj;
> +
> +	ser = mem;
> +	obj->ser = ser;
> +	ser->version = IOMMU_LUO_FLB_VERSION;

As version is per ser, ...

> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_flb_obj *obj;
> +	struct iommu_flb_ser *ser;
> +
> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> +	if (!obj) {
> +		/*
> +		 * If retrieve fails, the finish path won't be called as
> +		 * can_finish() will fail, preventing the restore.
> +		 */
> +		return -ENOMEM;
> +	}
> +
> +	/* Data must be present and valid from the previous kernel */
> +	BUG_ON(!kho_restore_folio(argp->data));
> +
> +	mutex_init(&obj->lock);
> +	ser = phys_to_virt(argp->data);
> +	obj->ser = ser;
> +
> +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
> +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
> +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);

... should we validate ser->version before restoring arrays?

> +/**
> + * enum iommu_type_ser - Type of the IOMMU being preserved
> + * @IOMMU_INVALID: Invalid type of IOMMU
> + *
> + * IOMMU type is stored in the IOMMU HW state to differentiate between various
> + * IOMMU HWs.
> + */
> +enum iommu_type_ser {
> +	IOMMU_INVALID,
> +};

Nit: IOMMU_* sounds too generic. Given it's ser-specific, maybe
IOMMU_SER_TYPE_*?

> +/**
> + * struct iommu_domain_ser - Serialized state of an IOMMU domain
> + * @hdr: Common object header
> + * @top_table_phys: Physical address of the top-level page table
> + * @top_level: Level of the top-level page table
> + * @vasz: Virtual Address Size

Since it comes directly from iommupt, why not just reuse:
    @max_vasz_lg2: Maximum number of bits the VA can contain
?

> +/**
> + * struct iommu_dev_map_ser - Serialized mapping between device, domain,
> + *				    and IOMMU instance.
> + * @attachment_id: ID of the attachment between device and domain.
> + * @domain_phys: Physical address of the domain
> + * @iommu_phys: Physical address of the IOMMU
> + */
> +struct iommu_dev_map_ser {
> +	u64 attachment_id;
> +	u64 domain_phys;
> +	u64 iommu_phys;
> +} __packed;

Hmm, why iommu<->domain?

An attachment (software) is between device and domain.

A device is always behind an IOMMU IOMMU HW (fixed; hardware).

Should iommu_phys be moved under iommu_device_ser directly?

> +/**
> + * struct iommu_device_ser - Serialized state of a device
> + * @hdr: Common object header
> + * @devid: Device ID
> + * @pci_domain_nr: PCI domain number
> + * @dma_owner_token: Token to identify the DMA owner of this device
> + * @domain_iommu_ser: Domain and IOMMU mapping
> + */
> +struct iommu_device_ser {
> +	struct iommu_hdr_ser hdr;
> +	u32 devid;
> +	u32 pci_domain_nr;
> +	u64 dma_owner_token;
> +	struct iommu_dev_map_ser domain_iommu_ser;

I guess this single attachment_id needs to be fixed in phase 2 for
PASID?

> +} __packed;
> +
> +/**
> + * struct iommu_hw_ser - Serialized state of an IOMMU instance
> + * @hdr: Common object header
> + * @token: Unique token for the IOMMU

Could be clearer:
@token: Unique token to identify the IOMMU instance

Nicolin
