Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0A37C930
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675784; cv=fail; b=LbKcrbkMaXOg4x39POMONPeT4alsi3o3AHBF1813wYmx8EBI7Q7A+2E/R34qoU1J663LrRJFjQYviQZ64BKkSVFNWDqwerMfB6cGoUYnUnOJPgtfUDvfwNQKnmU8TIIouruHpp+svucrZymQa7zZO1/OJnTuxUGFKHBY0+5bQoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675784; c=relaxed/simple;
	bh=UkimrU2+Trz1S/e8GIhGTuCpMKgwwlY6j2g3cec9HpU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=P/u6JtKrNT2P1AD4WQxOPUJX2Thzq0L5lojFUGh4UfnRQXdIyJpAYMSNAq6P8nJ1xZJe9js4q5OPqgTvIjcpzhXO9zh9GgZQ0mnbCaSG7Odw/YNuy1ZM++G3sbASeBF17IsTGl0YwZbXmjXDvopmeY24c8+/mMZj//IlLy+uQlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJ5RwqzY; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJ5RwqzY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Up71b9wBEX5DtxdLXRxLG7nr9RzZZprvIv7LX3ZkdFsXeII0FSpUZKi5NfNbUJ3ljNpzXCDFg90GRxcNbtVx8VfP5lq8n/aFCXLMD+EZDw+0AA1/OoSk5ncJdeOWmZ9DSZx2TapfYEZlKVxmc21fwuFLUKe0sAZcxDRymP/UBQEK2M/bPZ5ZWt7Ts85cvfea8dfVjNM+i1/2rG6AGfmdjlUN129VO3R5bcS1b3R13gzIZ6IUWBklhTv0bEHr2Vw2iRJuzY0zr01t4w9yUNBGmTWQ6J3cvW/joGrF+bsM+Tq6ZPKzd3wYS1wwcOWgaSuuUe9akvrv5a/ekn++92Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9tXZnX3v3CKjFY08bacqLTkbB6Kv0TLJDLmzDIDqBw=;
 b=l9B8tuO3lDPOVHpAM8IvGEVOIbN8IWHCkN3etyVKSjuDpOSXCIDcwdPs1MKW06buBbxZu97REznIkW//oei19Gd4m5aHhOxaYW6MfS8Pk2ZrgioMl2fxbpEC3JnSOby/y25CNocZCmWeDQftNiEQbXn9UcIGCbeb5jmeu8+0M8m5HJP0hbWQFCxfYcb4Jjydq4H6j2EgnQ8NlM/Y4DA0KXs/p7Zty1Tj6s4ZA3rWAKLHWD68y02Pe2qmYiDkjYywKG23bT5/IXN5hV0BP2usGnZuorB7Yt2pORjbBXN3O8n+h24iutTJR7uiTNucIgITiG4ZxkrOXtcDtojnnYvYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9tXZnX3v3CKjFY08bacqLTkbB6Kv0TLJDLmzDIDqBw=;
 b=GJ5RwqzYDSmkVLsfm0qE5VsxAaL+T1k9Rc/QmlZgjUTBRTrbWeNXmO2ML03+gPpsIcm04wNYvrCJ8yonxSHbU70Z/YOlIOiug6izUFz3VGX6OdV82saSIKxgcaJgvkLRE2eG1ImL4FKcjjUSlYXru2LoY0lFMSsoMuhhkFhW+So32j6b3/YnyRbN9edEgimUVpYXydmSHS+bvDEow90oai/WftJZyfb2fjQ/ppCCCJo7WPDG3cAPERZVYj7yDXyH7rii56vYvppDePnOLzXsfKCuQ8iCk4DNdjSPx+1CRyf/fSH0Fd/runTQnyD6feCEtXhaa6gLdl9so9v70cg1TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:36:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:36:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 05/12] iommu/arm-smmu-v3: Cache and restore MSI
 config
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260728210928.1050849-6-praan@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-6-praan@google.com>
Date: Tue, 25 Aug 2026 13:36:11 -0300
Message-Id: <178767577112.3356902.7778967514008843854.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ef1545-26d9-4a9b-af10-08df02c6fbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4fy8h/rtHEukjUg/HponldoqDhC+o25IxNMA3tJku7CG/7cKVCxRaKeZWKklbEUKFu3IVR6txs1o4VFpvF3sc09oJLxHUVcYVxqVTD4X/0HACKvUKYk0UqBCttvBZzRxvMCNmJtz6XL534BIaPSj2Fc2sUbAIObPrDwOuOH3T3D6WCJFYOmZgzXXuHOf+hI5bRX4g5MqgjWwSumFyou6KESbiER/SqRIzJXHqCZWikLA1juGHr2jr8GaDQDfIzUHndQEfhIWTfR6HS0iWq6K8r9hJ4qTA14MajhtE07zHgh8aqWDITtvTjxZvrKmOqb4spiCENru+x3t8rlvGQZgdqITP4qj8vaMqEBZ6KswPMfKzNWuUOKsplGz8rJ5NTUTl3+Z43yf9P2PaIiDYOIRgsuTmOeyh5Ge73r0LpGndpLywc7IFz7PD8c4ssTC2qLukz/Epk7qdaF5wb+aZEFbSeabMPmIruEPga6fFViipf38jry/3yUSpdDlx8BM6m+Wn/ftYl/KO5pPIyppCv5tSj0JGv+Umrp9LRWbQ/VhGCuMqL/8oi+K8cxngQOwJuovQDRBpQeZPytyY02nrCjHKjWNWxNyMP+pfG8WTl+Px/ut7cranRqe1UVPBkULCi0vOb50coLqsVWbN0Z3sAGGobCOmFrPLliPvMbshPAdUQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlVmcWRmNGtpc3BWRXZUZ011ZVlMSjMzcE1mK1pWKzJlSnJQM2k0d0JvZ2xm?=
 =?utf-8?B?QUlEbXR1WHM5MW42ODArenh6alprK2pmU0pleUpNNU84ZWtqbFFiVjduK3p1?=
 =?utf-8?B?SFdwbXc4ZGhwRVN6aEhXSzdLdHI5czZYNHRKQW1ZeVFybmFyYkR6REs4Uklu?=
 =?utf-8?B?RnBzUGRxNExqVFVkODRjVWVNemorVkN1b2NGeXhZd1VGRUZqcXYzTU5ZUnZs?=
 =?utf-8?B?Mnp5WDJ0SDY0OERvaElkU3QrQndJYkZGTld0ZjdZZHlCdHA3QUthSklLYTNL?=
 =?utf-8?B?QlhOZkx6VjRnWHM2OEIyM1lYZ0N3SytvRUFuQUt2ZGd0YkRVeWpKV01zcERs?=
 =?utf-8?B?QkxQU3NXRURiU3JDVTBQVloyN0ptcXY0ZWlzOTFld1VSR3ZrazdTT3NvZUE3?=
 =?utf-8?B?OG9Oa0l5dHJrSlRPaiszTGJ3STBxZndTNjBKK05tS3d2ejZlTUVSV20yU2hr?=
 =?utf-8?B?SXozQXhRaDI4YUxpcjIveUowSnpubGFzWk1iaU5rL1NoaEtmd1dOL0dtcmVs?=
 =?utf-8?B?dytJSnRWb2tWT1k3Ti82cVJ2bldWNHVvNEFDdzFHS3BEam8reUlsWFpaNXRT?=
 =?utf-8?B?VHNyMWJpSSsyUzFDZlhOM0lraE0rUW56bkF1OHRQNFhMSWhYOFJ1bjcwbHZN?=
 =?utf-8?B?dG5ST3BTNktqOWlkdkc0cjh4YmtHeis5UmJlejVCL1FJeFpjLy9Jc28rdStx?=
 =?utf-8?B?bXQvc1ArUlNCUnoxdzdmZHZ2d0duNGZSeXEza1pSTDhQRWhOeTE3ZHNHNkFw?=
 =?utf-8?B?MGxSTnpDamR6K2dZbG9iK2RzOWRWVi9zWmQxVUYyd2wycXRLbENzNmQwNnVX?=
 =?utf-8?B?RG5IVlNWUUhDZVFVMlZlc0VjVCtIRGNBRkRIRVA1K0lYKytXLyt4QTBPc1Ay?=
 =?utf-8?B?VmJpVmtKZUJOS0tEbXozcHJSeGxaWFNuSFQxbDZoRmorQUpYZmRCcS83MjhC?=
 =?utf-8?B?YTRHamdsMlh1RHJBTzhkVEpYcENhSTVkc2RIRHdYT2lSWXBieHQ3aFlGU2tR?=
 =?utf-8?B?dmxsdzBsbnorbXc5QWFKdDdHSVlUM3MyRmdOVk42ZnVudEtBS0xHYVczL0xZ?=
 =?utf-8?B?TGw4ZDBpR1Z5a3hOdVl3cm42Ryt1WHNjMnc5MW1HcThQaG5mUG51TDdBWU9S?=
 =?utf-8?B?WTlwTS9Weml1T0htKzBSMGY1c2FCUnViclRQU2Y3amw5SFFtaG5KZ0JFa0JR?=
 =?utf-8?B?cVhBWi9GR3B3S1FOengyRzQwbVoxL1l4ZDh5VlFaZ01BZDZNbnVjcDBTWmFj?=
 =?utf-8?B?eVovNDl6TmkyZFpsaHNndXd3Sk9kcXcrak1EbGZzc3F2WWpjMFRId0d1TnNI?=
 =?utf-8?B?YWRncS9paUliU3dFWXRoWko5Mk42UVVnRW5hMnRRSFdYZkZtMnZpaEphWEdu?=
 =?utf-8?B?RFJSdTNlSkJ4VDErV0tLeU5JZTJiWitQZFZINWxPdUNtaUxZcGdndXJlOFUr?=
 =?utf-8?B?enlkdEx6dVlQdGFYdE1Samh4VzBUbHMzWlQ3Q282UjZRZWlPazgwVEthbHow?=
 =?utf-8?B?WmNma290eVhKSHFzdWdlVjdEdVEyUFNUUW5WcTFPVms0anJzYitaRmpDUXlB?=
 =?utf-8?B?YkRLZENjWnpTY2d5dGlEKytFTjQ0UE9kZk1Ha2pUbmdPdTlURjczNURyMlhz?=
 =?utf-8?B?V3lmTjc2eFpURGoyYVNRbjNSUlFDMWJORTdJL21GV2VEVndxWVZxSkNSbGxn?=
 =?utf-8?B?RlZlQ0lWMFIvMEdiMWZTcXJrdGVwUTdoUERYTTFyallKM2pveXZTaDFQeDhw?=
 =?utf-8?B?WDNOV3V2NlhCZTJjQnBTQ2ZjQ25XSG9VbHNUcElGZ0JSM1E2ODk1alAwM0di?=
 =?utf-8?B?LytwVHVKQmpIdUNoQ2p0RGVkcm5XOTFJWVBvNS9qRFBzVERJeTRMZVIvaHFJ?=
 =?utf-8?B?WjhJajZGOWZNVEtkR1RtMXNFRjRrK0Y5dzdCVmVMdU02L0QrUm5UN3ovY2sz?=
 =?utf-8?B?anp2Ni9ZTXBHT2pyN2RxQ0FjY2RyRUF4TXFPbEZtOHRFS1NuRXUvVmJpUnNS?=
 =?utf-8?B?S0dNOEZqQUVEdkdtSlJoVUVXYVdDeUtkUEFOYk1zUEVrS3l6UUJLQUZBeFBU?=
 =?utf-8?B?MHVnUGkvNUJFQU1JSkN4a2RVTEJ4cW1xSTJUbkpxczdRamZZQ05mVGVpSmNt?=
 =?utf-8?B?R1Vhck5OcEpMcDJlbElHVEFoM2k1U296YVBQMlQ1S3B6TmtBZ25kN0dXRXNL?=
 =?utf-8?B?RVgyQUpxVG9YL1pvdFhnUmdiSDNpU1JhZGkyTW1PbUdyNmxRTDhzRjI2OU1h?=
 =?utf-8?B?NG82bnZabHdEcFY3RUFHZGphbERtWCtkeVZSTDNyT1JRV1VzUC91WUVmVWdQ?=
 =?utf-8?Q?qgjR6SGI4zPBaUqI7O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef1545-26d9-4a9b-af10-08df02c6fbb3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:36:16.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y44vrxlI3lOGYCUVsmPHjpHaHlIO5YIhe0mG8e8m66CZns1PKxMRLe7k33uqU1tX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

> [ ... 37 lines skipped ... ]
> +static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
> +				unsigned int irq, const char *name)
> +{
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!irq)
> +		return;
> +
> +	desc = irq_get_msi_desc(irq);
> +	if (!desc) {
> +		dev_err(smmu->dev, "Failed to resume msi: %s", name);
> +		return;
> +	}
> +
> +	get_cached_msi_msg(irq, &msg);
> +	arm_smmu_write_msi_msg(desc, &msg);
> +}

I'd really rather the irq core do this than open coding it like this,
it should be fairly common for any driver doing power management and
platform_device_msi stuff?

So maybe:

        platform_device_msi_rewrite(dev, irq, arm_smmu_write_msi_msg);

?

> +
> +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> +{


> +	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> +		return;
> +
> +	if (!dev_get_msi_domain(smmu->dev))
> +		return;

 [Severity: Medium]
 Will this correctly detect if we have fallen back to wired irqs?

 When setting up MSIs, if the allocation fails, the driver gracefully falls
 back to wired irqs without clearing the MSI feature flag:

 arm_smmu_setup_msis() {
     ...
     ret = platform_device_msi_init_and_alloc_irqs(...)
     if (ret) {
         dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
         return;
     }
     ...
 }

 Does this mean the resume checks here will still pass during a fallback,
 causing irq_get_msi_desc() to return NULL and trigger a spurious dev_err()
 for each irq on every resume?

Seems believable..

-- 
Jason
