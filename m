Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B044C14FB;
	Thu, 24 Sep 2026 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278931; cv=fail; b=ns/Iy3Qxdsp/VsY+9YqL5nI3IhSToOjKOvyw6f9Ne9IG7tNPLMDTSiy/P/ffMXV0PEMSNatkrivMNW/kipId++xQobMcdWZ2o5T9WopFZn/3m05B91FW2Cn+ScKSUVImsPH/y0qOGt/L+triuOUw0GScFJXcLRriG8DLqOg1qd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278931; c=relaxed/simple;
	bh=gPs2zcymHBDwW+WjEK7+zp2nzD0cZ6wqO4cXHyEox+M=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=k+pQiIDzg+VqrRasl36kkkjS/v0Iz/PTrXBncTHFvrUAgtfUx+cPsohqVDd1ULEUB6Ah3BeaYpzPOIXpqEDvd6owIWzX3Tfb1ngfB6q/1KIYk1J9VOwqXKvjW6uT22l5msmVj/dkZWhLrIzlbAMDmaziWCNOXSqzeTsR3p951zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WDLi+Cfh; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WDLi+Cfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+eZC1yIIxRW0Te67/T/DsjR/G1iDBz0dNh+pr7jdg/siL9UMSzJFE0QqwqvrlSS+8lSN3+tL69rgXDPQBtisfQ2UhIeNgMqb8leXfCQ9lM11mx+UJ8aFgvyKhQz0p0sKmLr7msmZjiDom8IxoKimtyKhUkggyl/nt2TPaPRsMdSWtXIog0VXBS/9Wi+L0xvVH/tZVpBaKEGeU3b6t4Xj03+msMTrqjBrfTEGI+UjmsphMnSEUlXW8xT5GZXlI71BYEDgBSldroJLBwiHkZFIMVY8Q8yKr+t3M0RISCe2WKEmjmt8Ak7BVjvCmOsxIwlDBNx7fiZsu5Kg/VYxla1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPLmUzvkbyaI/wqMTt0oPyV7G9cEafoYR7309cUBA3A=;
 b=ScQwUADOgQ61Ys6JXiTgQab38l8W5emVC9OwWJ3e1/DydcOG/2W2CzOSKJc1hQLaCF2EDSf0J0UBSwRaT1hXE6eSvf6sjJYSk3qDgYBSGPqGCWbf8A/RfjLWViEZ/mhS7i2is4Uos210X2E+bRktZpHCYPlVAej/rRswp2Z60rPqCz27Edy43RKvYQAOIriRZX3ciyabqUHFYL7BKw7ywd9lVaqRkp5wCleeUoIyKgtxV6YZ91la3XFEanUmDtgK4zeud7rCagQMeEfljPPOc+KcLnYqCa4MqSBM4pV1FUB+005lOVCPIoGXgYbP/OA+GVfXTq19Gr7NunVOKdvgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPLmUzvkbyaI/wqMTt0oPyV7G9cEafoYR7309cUBA3A=;
 b=WDLi+CfhLNg5ccA0UOPwWsiWsrOhFyn3n2MYmenrxbzvKfPlPIhi8dK+Dpp2PspYbmxYTNOrOxIA/TijfoZbg9QbXCjKzbnzo74az2dnl5dJjAma55m3w8Zmk/vBo6Ez2N0sEGv4MZBGtbzWS7e/QYwO9e6CfuZpIRbN8TjWoeEGae0c5QgaRfQA0P1qknf5pID4TIU+XjJqbadWvcDL9629l4VD3+FrHKqMn1Bj03KpQGAJjBQIAl86wuQBKVpE9tIXT5YWdJYr41RWdSIjIZLqRQ8E9B2NhL9hVBtottZv+QfncN+gnYkVKTcOglQY/x+QzAv1I/UFgkXDlgkKUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8854.namprd12.prod.outlook.com
 (2603:10b6:930:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:41:58 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:41:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request
 ioctl
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, 
 Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260917140159.1163281-10-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
Date: Thu, 24 Sep 2026 16:41:54 -0300
Message-Id: <179027891417.104879.282447770434616733.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: PH0PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:e::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 30df708c-03ff-4261-a561-08df1a73e4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	pFa1zVwzGhWpi5k0EFGrP2Tbn5J1+lv6RFP1BqQxurE29YxqHCIlEpW7nmN9bMRu+/0L17VyVWX+glPubqufXgEP6JNGF5NNWfE3HTanAx1FL5e5orCCjFfSfRW04kQlqEY+rFqDwMTiEu4ZIvAwzbSH4drltoUnMGFMvp9BZKBFnpFGE8bcm9ZNipCeGqWNJ8vcm/RrEz8T3wE0TkrXViXEa4Lbx72N4THAWxSwMh54d+WPQB4C9yTZh0+yO5HEY4eWdfFlGWwQAvB8u08sVoTGft0/uEAWBtOi1oQsBLFk4VUnwlBWQ+X5ZKi/gQEErriIfBIPyXpbzsU60ryOScBTfOvUIdpZR+UrGxg9c7Sy+qPNoSxUMFUZ4ruCMuYaNTINBa8iqFyNnFYiZpIiHM2xmUeb8CSJRifGpHnQaE0+jIcIJUXA9VvFzpFqpQyM2lAgonZl7mWk0Z7XoUAFSuQewydF5ME9ooO/+M2Z233J5F09LhAgeaD7GvV36lK1OuWWyhsdNqtQoDYf9ZPRmsmcbkxVVPy/T4+26sOo0ZDwWQYzVVmee50Nn0d9Oa3eE4p/IqZxnAjYyq76n1xDoHL0g6IPoloJhe8+3S7nxXL1GNtvw73WL93wOwxh4fe9uBmaKMCrF1zm7Sd26dq0BowqxBD88Qc4AysNxTa1SMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGxOSVF6WGg5VXYzK2NmelZKUE9Vb2lpUjJrU2txT0pEUXp4RFF6UGpLTWVG?=
 =?utf-8?B?Z1p6Y2htMEVEZ0ZvMHlvMlhpK1VDQWR6KzBkUFg2aGVodHVURjFreHdES2RU?=
 =?utf-8?B?SmpSbW1RcEJMd0ZGVmtHcjFrNVE5d3JJNlhHVzdSZThkeThaa255OXByMDQv?=
 =?utf-8?B?TXJ2LzlrVnZ0M1ptcVVvM3Yva3RJaXpuRHRrWGs3VXg2MzdTTTFGMGpJSWFT?=
 =?utf-8?B?WXh1OFRHeCtlNWYrZk9BZnZnVnM1c0tRSkJNOHF0bnk3UWNadlVFa1pZUllX?=
 =?utf-8?B?YmdoZFZVak5HS04yRk9hVFUvUUI1NnhHUTBpZ1ZzQUVhNWIvVVhKKzA5UlN0?=
 =?utf-8?B?N2w3QmptRFZwMzVJVmpGZEVpVTJGR1llTElRakRHbGFLZnZHVDhCZDRpSmdX?=
 =?utf-8?B?Y0RIcTZqb0RYRzB4TUZtVnhyOXlrYXR5Z1A5S3FCZTFaNUdKR2JVQVdhdTBw?=
 =?utf-8?B?TUNaeFoyazZTaitFMnRjbFBnRitCSGVCVDV1SDJjZjYzN3lSSnZiWjdsUldh?=
 =?utf-8?B?UnVJemN0anlaZ1dKd3FleDZDbzF6Wmg0eGN6aFhaRG54dXN4d1NMTEV6OHoz?=
 =?utf-8?B?S0tMRnY1aXJ1VDMzZ0hQaTdKajJNeTlxWnJDa2lQZlZSZUdmZlpwMGFnUkt2?=
 =?utf-8?B?Ry9LNE93SUt6RFd0S0g4TyszenkyNVpaUkhSb0tycjk4WEhhazBtTzBwZG5C?=
 =?utf-8?B?bmV1WDhxN09GbmVSY210ZVlBczdNaVJ1aHUrNHlCSFNGMWNoeDRBVm4zMzNm?=
 =?utf-8?B?UUQ0a3BwOFVadkdhc29qVG82blo1RDRGazNKbUVPU2RRMUNiSTlmVVpmbHcy?=
 =?utf-8?B?eVkrRkczeDJEQVJwVnRFS2J2c1ByZ21WVHJTTjlZUVoyQk5ybnJEb0ZNMG40?=
 =?utf-8?B?ZDM2RS9Jd3lVOFo5REFxelNMdWdjQU5MbzBBMXZDVEtCSlViRXRocDZtdWNl?=
 =?utf-8?B?NVJVY0JkaFVtOU5CR3V3K0c1ZndKak5jYjZKb3VZZnhiRnFaUUdxQ09sZTNh?=
 =?utf-8?B?TFcxQWpqRTFGeUc3cmRSSVU3UmY2ZTlIRThXT29QMHhkTlhsY1V6MHRJd0hj?=
 =?utf-8?B?dUk4UVA4QWNydm02VnhWeWNFUHUya0xXaDBOemVwZzRlL3h6b0JDRUh3TWpv?=
 =?utf-8?B?b2FZWFRNUi8xdFdRNnAxeElwcCsxSHd1MjdZenh3cnJiOTg2TjFBYnpHZ0Zl?=
 =?utf-8?B?T1p5amVScE5GRk03aGlUQmJQb3d6RHV1S0Vuc2FNUFhJQllHSzdlZmVBT3No?=
 =?utf-8?B?SHlJN0Y2RXFuc2VZYXhxY1pNaWx2eTlTY2xzdWdNNkVCM05jdGg4TGUxKzl5?=
 =?utf-8?B?TkdUZkZSOHh1VEN6S3ZRNGd0d0pacU1DRkxpTWdqQVRiendCeWZ4RDJLeHhO?=
 =?utf-8?B?NzFXVW9YYzhzb255M2Q3TFZxTm9Ma0dmcWEwa1lSOW9EcjlINkRtc05qL1po?=
 =?utf-8?B?RkZSUFpPVTFTVG5OZVdIU04rNCtoWC9ramdzMSthZGJreDdVc0hmNjZ3UktD?=
 =?utf-8?B?aGF4SzhGZVd5bHM2aHNzVE5KWm5rVWFQVzFDeFhnZE1CSWRiL3ZURHNyR3pC?=
 =?utf-8?B?SXdxeU8wLzhIajNDTzlUdEJuZUNaZ3NYd213L2lISGUxU3lWd0tvSGRncStT?=
 =?utf-8?B?NGpPSVI1cHJtdTVTcWRod1d2TnFaYWFTYm51TGt1Y1ZtY1JmRmUwcnBSeXNm?=
 =?utf-8?B?NDNiMDk2eFJXTldNTXEybGtkNG1YRGpPZnd4VU0xY1dWZ01mc2NMMTVPMUh5?=
 =?utf-8?B?bVgvb1RvQkVPRndSck9qQ3JpQ1cvcmcxTFRKdE1aMUpZT0lHcE1yWElqb3Ax?=
 =?utf-8?B?Q0hwalN6YjYyQXI3Wk1sUjFERWI0b1N5UVczbEZnNHI4T2NyRm1VMlJZV1dT?=
 =?utf-8?B?K3F4UFVRWnhFNXJqdVJLSHJnYlBnSHJwOVBuM0dKNms1bXptb1RDMkdmTEF3?=
 =?utf-8?B?bGZLaDl5VzBXcG1nbytRbXlGL0ZXdWRsdlVDbWxRUDRCVndxc2VsRFdMZFFT?=
 =?utf-8?B?aG5RdFQ5cFV0bDFEaEFINjZUeW9aNktDQTFmVmdVSDl5akpidWlSMFh0Z1ll?=
 =?utf-8?B?bU1hSEZCZ3BHcDVURkdROFVQOFMzL2tlNUl6b2FYYWN5L2JRaGRLOEw3Ui9E?=
 =?utf-8?B?aXg0YTlNaWQ4bUtLdHhFYUN5Z1Z0aGZ1VTVZZ1hYMWVPd25zM20vRTFLbmh5?=
 =?utf-8?B?WkNNbEVVb1VSRkV0TEF4djQrcXhlSy9JR0VXanBwOVk1Vmd5dEw2cjA5ZWlm?=
 =?utf-8?B?S2dOdEZEZHU1V0VxVENTZGxwc08zMjFzWHlmU0k1SVFSaFFvMXJkbm5MUFFl?=
 =?utf-8?Q?jVCwhmiqcfyfBYqlBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df708c-03ff-4261-a561-08df1a73e4f6
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:41:57.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHBSmPYzWsMQ54QoqZPYmRVkZC+kqPQs5ziM53BXKYte5BKBqlt0O/I067ZBujD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

> [ ... 95 lines skipped ... ]
> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
> +{
> +	switch (tvm_arch) {
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Generally speaking we should not do things like this, the viommu
object should declare what it supports if we want to have validation
on the iommufd side.

> [ ... 140 lines skipped ... ]
> +#ifdef CONFIG_TSM
> +/**
> + * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
> + * @op: operation for the guest-initiated request
> + * @tvm_arch: guest TVM architecture
> + * @req: request data buffer filled by guest
> + * @req_len: the size of @req filled by guest
> + * @resp: response data buffer filled by host
> + * @resp_len: the size of @resp buffer filled by guest
> + */
> +struct tsm_guest_req_info {
> +	enum iommu_vdevice_tsm_guest_req_op op;
> +	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
> +	sockptr_t req;
> +	size_t req_len;
> +	sockptr_t resp;
> +	size_t resp_len;
> +};

Why is this struct in tsm land?

I'm not seeing why the iommufd interface should be locked to tsm, as I
said other viommus need this kind of command channel too. Can't we
have a general one?

Why would it ever not be tied to userspace pointers? I don't want
an in kernel user ever using this kind of struct?

> [ ... 34 lines skipped ... ]
> +/**
> + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
> + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
> + * @TSM_REQ_SET_TDI_STATE: Set TDI state
> + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA

That seems wrong.. The hypervisor should not have control over T=1
DMA.

> + * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
> + * @TSM_REQ_READ_OBJECT: Read a TSM object
> + * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
> + * @TSM_REQ_OBJECT_INFO: Read TSM object information
> + */

These operations will need alot more commentary. Use kdocs inside the
enum below to make that easier.

> [ ... 10 lines skipped ... ]
> +/**
> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
> + * @size: sizeof(struct iommu_vdevice_tsm_req)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @op: One of enum iommu_vdevice_tsm_guest_req_op
> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
> + * @req_len: Size in bytes of the input payload at @req_uptr
> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> + * @req_uptr: Userspace pointer to the guest-provided request payload
> + * @resp_uptr: Userspace pointer to the guest response buffer
> + * @tsm_code: TSM-specific result code returned by the TSM implementation
> + *
> + * Forward a TSM request to the TSM bound vDevice. This is intended for
> + * guest TSM/TDISP message transport where the host kernel only marshals
> + * bytes between userspace and the TSM implementation.
> + *
> + * The request operation is guest initiated. The TSM backend validates
> + * @tvm_arch against its bound TVM architecture assumptions.
> + *
> + * The request payload is read from @req_uptr/@req_len. If a response is
> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
> + * response bytes returned by the TSM path.
> + *
> + * The ioctl is only suitable for commands and results that the host kernel
> + * has no use, the host is only facilitating guest to TSM communication.
> + */
> +struct iommu_vdevice_tsm_req {
> +	__u32 size;
> +	__u32 vdevice_id;
> +	__u32 op;
> +	__u32 tvm_arch;
> +	__u32 req_len;
> +	__u32 resp_len;
> +	__aligned_u64 req_uptr;
> +	__aligned_u64 resp_uptr;
> +	__aligned_u64 tsm_code;

out_tsm_code

-- 
Jason
