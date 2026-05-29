Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79252E7380
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029033; cv=fail; b=efxiJ6drOzVacu6hpadiaho06uIDjautBb54P1/YnWa+G9UEomT8vO8DxBlEDVHu7yn3vJ9+gIEJwUsfQ6OcKLKqt0xSbscmsjD0Bkmj5oj2Y/bieMBe58w87J5YorzyCcyz82fb3y7RTSSVREcTwDwWJ00Wbxws23W5LLdErjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029033; c=relaxed/simple;
	bh=hJMhtq+dbEX0dgXs5xbouiYQCiCTdzWEiqWhq7QFCQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXUkVZpnsLgbIZmHHTHPwVpDueyzIHcJvut30TLdgBVG158ZcLSjEyOQV7r8qJHZo8vWn9X+GuQ1XotTjcJZMwR3KzWHUJhPoPfRdtdKYTMK96dhepN4LvA6fi+qzX3qH6PIHzwCJAyHs9QpQ/8QZYSHb2lCjkKW6mhP41A4soY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQ1C5Iqi; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQ1C5Iqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3lBWgtWqBIcm5csH+i5ctzEdiRU3EISpe05hoxKHxE6nbJCPAyx2OhkvS9P5LGKkssDtwIr5V4eiwOJMa91REmYrn9TXg2/vLIRE4ibnof9ewXuwWdpEHsHS9N59QHCQhE4U5+N3d30GS2GlKJm1JiiU7OUhMCWluz3nuX+DrPmVsnt7ZExR7kDJVZiLK+vly2lHYATEx1+kDa0jZmujL9FYI8sf3++pJttKEerl0lymxxqlcD6aEXUxCeh9jTEaOssaobUZBSiaowVt7UkKP3zBXBzWFhG0utZ8cMlNrI0sldMsOJCT2e3NdVzG1HmCJYkpQUBHtfkBU/bHyyoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aZ1LTNPc3//R5LxLMhDiDaNBUhEJVsBoexAxRnq3fg=;
 b=sa2R5Ye/VNvYenvpuhx+3gO7L+mjv+ws4gcwc0gHaudQnxWQce975DhnfsCRoRtwE0rVM0cALDcktl1QiQuV8uGReBtE8stX7pfkyNCkZM3s2okgpGjzXiv7YG1IETZ8utF3BTQ7CloJBYT1ek7/FmrtvNAZHdYFP0Qzj7RCrM0Dvpx7t5TwCAZZ3FBHwq1pW49cgcYJ3/0VeNh1rVptrMkiPLfwf1zmNYd25ZknTSLa8SR+XibIixoogDC3XwkXFkrLdvHnwiedbb/+/PTUK4KeoF8nrLdfA9aI95Du5n7S+Md2N5X0bC/J7gMsD5gnZZ/h3tByJ3pb2DfYsYCBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aZ1LTNPc3//R5LxLMhDiDaNBUhEJVsBoexAxRnq3fg=;
 b=nQ1C5Iqig91cHmIsHztCCidLQcIVmFSDzD0s3+rBxkGZlfb9r/wPKoqH2Kclwx/RYAAst62rPKkoGvh03OpZOyiIGTFGKgUqTy5Xz5oKZ8mPedKtjpVgOtutPpDO8JUvtR1GN7Lunepl2blyt8/q2LI6tGuHofE8QhIMb5Wks1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Fri, 29 May 2026 04:30:25 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 04:30:25 +0000
Message-ID: <4a270b89-6512-4332-8f27-10b7daa90daa@amd.com>
Date: Fri, 29 May 2026 10:00:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] iommu/amd: Dynamically verify Southbridge IOAPIC
 via PCI config space
To: Wei Wang <wei.w.wang@hotmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 thomas.lendacky@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393703E1D856C2B8C5C6A42DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <SI2PR01MB4393703E1D856C2B8C5C6A42DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::15) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c35e42-2ed9-4e40-58bf-08debd3b0119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|921020|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	/7L8z2ViwsdjAHkIq8RX8peTauXOzmNhgHush7XR0Z4FTLQMXI+4OUmw2597WY1+VCajIaaWNO8JGStlhrTySZV1cTxiFwoMjwGa06cIC9SQbZgMnx5oTcQjuA+OVTbSMkox59kcaqbB/U7ZOP7RsDQ1IahckhOuFqNrI+h8drH0PYld7jhtmKq9ard8wBRVR2IPl2BqkUPW94lzMZUl0ghfx0b4mT3tFv3l8t760FYWviJGvXDHKFP1NWbtxdr63UMH0g96/1n0gfpoEqtxz9QHbRQCkY2uqMZ4NqR4/1AdovSdqKu5b1bgBpQ/LG/t5jXRK7YfjxAnX5l8i+qsss6fo2W4iONAgRkmrw8Ig9xiOIRyLjcGzY52sHs7kChqjMGJWMxE6QC4faaGC7mPBZLnynQC0OpMuR/NxObs/GTPQ8E6yJb7o4trWJzvg30p9WR/XqZdJtd6Hxt8FDgbETuBvuPd6WkVEUAMGvJV2RDOvvKQGelwQqcdrpICZbVZQ0sw/+ct7AVCIVngG7X7aLFF8sYZcx2KQ+M6O1cdV8jxGhFTbaRbn2VWbDnh/+oEWlOrfR8HsvnSQSF0B1QQsMp2TAUSSTcLruRbeKqqhkVoXs/OCzhRTdI3zES3V4b01kaOG3LKQbCHZvESjw0OsWOHePKtdjHUX1Z97tJiCIJbLdzq4fJrELk/b0hUg3eXZx3kRHwVSBrpKi/npYRAcP4YCJUIZk3dva5mc2SY1cQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NrUDNaTlRCVEJDNmRhZWNnVU1GQzRSOHpXL29wUnRJbDcwSW4veHIvbVVM?=
 =?utf-8?B?SGVTTkIzcUhYVXd2YU4vSlFjK29IbUg1VTNWQ2gvN3ZzcW95Z2o5emRNZ2VK?=
 =?utf-8?B?b3NmcllRYnVQNHYvaGZDTXFRVEZCTkd2MENjWEg1NnMyQ2RFTFBYOW1DZ0RJ?=
 =?utf-8?B?YUdUcFUyM0h1ZUZYQXM4N0gxMWczMHh1dnlFQjBJWnRoeVdDS0F6RG43QTFO?=
 =?utf-8?B?allkVlNQNWhlN2ZEL1BBanVHUkl2NTlNYlRrUC9NaVlPNUFmemJkVDJVU1N1?=
 =?utf-8?B?MDNGanZZZEdlSTNxRlpiSUt5U3k5TzZWQkdYRjFQa2cwN3FwZXFKR1dKZGtw?=
 =?utf-8?B?ZGhZalpvbWRJV2tSSHo2bHljQmJ0UzF4NVBOODd4R1pKY1ZmZ2t6SDE1bS91?=
 =?utf-8?B?TVFXTUhpQWM4SWI0dTBKS3RnTTU4RmhGSjZFVUdGdXdscElPREVBWkpSczY0?=
 =?utf-8?B?VW1YeW8wbnMrUHBDRE9aV1JHc1ZGMS9NVTlHaTFuMkR0Zk9xVklRZE5HYUZR?=
 =?utf-8?B?YkMzK1FuejNFUk95NkxhRlpEcHhFSUZWOTIvcWpQMGNYZWErZktnamtKbDZT?=
 =?utf-8?B?R3N2SnNtWkx4TE5wS0UxRkpyT0swMVgwUHMzQVBnam1xMGNWRTN1QUJNWXd4?=
 =?utf-8?B?ZkZxdDlPbWVNdS9TaFJrOE9SYk1qaUtQcXJTTHZST1o1dUtxT2JSUXVxMHlQ?=
 =?utf-8?B?YnVUS0d3dXJnTnNTQ2svaTVjMDJCL3I5WnFqQ2tDS293SFppS0JmMHR0YzN2?=
 =?utf-8?B?YVFERnhSUW9WNC9teU9tM1BQeTJaTVd2NmVkRWJHL1d4clF4LzIrY3NKWnRW?=
 =?utf-8?B?ejVNVVYvWlZnNUVQZXVxdzNhUS9DdmY0Z1lleG1TM0p6dVE1V1NtZGx2aVhL?=
 =?utf-8?B?RWtIRkNURTk4Q2J0ZnVmUGEyY0tuOCtSZUhlZEFPdy9xTnJOWWczQlZDdkNU?=
 =?utf-8?B?QzlIL2FWUHRnYW9XcFhwT1duYTVTeUdvd2JlZGhyS29Sb01NSWNyMllWVDBa?=
 =?utf-8?B?ditBNW1UODFvalJSdTJvYVl2cjhkMTloajhsOXFjVVRFOFZxclQxR1dZK09E?=
 =?utf-8?B?S3RCWlVDZWlPMTF3cEJyUXlJMFQ5T0dUd25STVJGcnVINXVVMEtvck1PUkRa?=
 =?utf-8?B?UE5PTC84RU11RFNOM1JNTHBqVE5aeTVsWi9EUHRHK3pnUkRHa2RObFVSa2Iw?=
 =?utf-8?B?TEFEM2RlL1VHVUx2bTNtRldpZnNyWGI3NWwwK2NiVWN3amdGcjhoeUFkM0tK?=
 =?utf-8?B?aHBNRFNUVHdiMVMvVStIbWNpV3V2YWZaNWpFS1p5NURXTDZyYWhqTTErQXhw?=
 =?utf-8?B?OGZVNklwSTVEaUxHcEQrR3Vjb1pEZWowYWIyYkdDNmM2Yy9VY1pYUXVQSkRI?=
 =?utf-8?B?V1dLY3Z4S0VzSUp4V3NrTEt0TU5TRkU1Q3BCU0VJUFhDMy8rT1hndGg5VTZB?=
 =?utf-8?B?L3lsL1ZZc2tONzM4NmovN01FNS9GRzYyb25ON3JqSFg0VWdWNGV1cnBnZGxO?=
 =?utf-8?B?dUFIUWFKQVZQNTY3bDVtYWE4WitWdWVMOGVwVi9yMFVvMFJldGUyU0VKN240?=
 =?utf-8?B?Ym1Ebk41cUpmS2g1bXNXTWhyNFQzYzUwT05UM29LbUdiSFdUL1lBbUxESzhN?=
 =?utf-8?B?Q1RSTnA5VnFRSXlLNVhaeDJtcS9jRG5aRTdvUy9QYkNlY0FyK3B5dVdZYnlI?=
 =?utf-8?B?YmJwMkRpTDg5QnpBd0E0MWRsbDJxYUFGMXdMRHduQmlvcUpxK1IrWGNKN1Av?=
 =?utf-8?B?MHZ3WU1ZcVBoOW1wTnJNTllJcHJIK2pIV1M2eXhuRmRodklheUdJSDVudStT?=
 =?utf-8?B?RzNiL0ZxSFRLMm5nbmZvbnpoK0RmSGFOMHlwZEdvZjgxd0NLQm1pOFp1V3ht?=
 =?utf-8?B?dmhVakdOd0JnZ3BzRk5LamJlM21jdFg4amlvT0Y0b0tOeGRxUGlNcjBCdDVo?=
 =?utf-8?B?VlRDMUNyNzV4SXNOL21PQ3U0dEIyalY5UitCNFM4L3hxK3gwSjhpWTlxMnNm?=
 =?utf-8?B?RG5oY215bzlZMTh1TG1MZ2t6elgrSXR3NGRFTDAvZk9sT3ByaTE4RHlOUVB0?=
 =?utf-8?B?NzJpbnlwTUZDL0F6ZFlWMGp1MjdER2ZkSElJSmdiSjJhSTdTRDh1czRGaUhh?=
 =?utf-8?B?RDJveUdMbnZQVDBUSm1ZWis4d2NhT0hETzFna2d6aXJCMHhrVDlnY2ZMK1Nk?=
 =?utf-8?B?emJQcEp4QWhyK0tOSkNPeTR6NG5uS09qM1lmU1NuRTFOU3h6aWoyVE5aQU5s?=
 =?utf-8?B?MDJ4aVF4RHl0S3c4ck43eFJHT2xVUnlxSjBaeUtjY0RQNG9SUXN4bmdOVThX?=
 =?utf-8?B?MmxVMkdCYzNNYjhPaWNsWGszSVZwRzF3bXY4YVZUWCtWbGZJZWhaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c35e42-2ed9-4e40-58bf-08debd3b0119
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 04:30:25.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2Cc+2/zM+mJ5IzLFSxhR6ecIVLqwpHbwwP7tJoYERlQLmLKAAb6vCexQXxZ/ThUjJ1f/IKl9Vq/ODVZyy5wNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771



On 4/6/2026 9:10 PM, Wei Wang wrote:
> check_ioapic_information() verifies whether the BIOS has provided a valid
> device ID for the Southbridge (SB) IOAPIC in the IVRS table. Currently,
> if the SB IOAPIC entry in the IVRS table does not match a historically
> hardcoded device ID (00:14.0), interrupt remapping is forcibly disabled.
> 
> This hardcoded expectation does not scale to newer architectures. For
> example, recent Hygon Gen 4 servers use 00:0b.0 for the SB IOAPIC,
> causing the validation to fail and interrupt remapping to be permanently
> disabled on these systems.
> 
> Because the SB IOAPIC is embedded within the FCH (Fusion Controller Hub)
> and shares its device ID, we can inspect the PCI class code of the given
> device ID to confirm it is an actual FCH device, which is typically
> exposed as an SMBus controller function. The PCI class code at a given BDF
> is a stable, specification-defined property. Using it to identify an FCH
> function avoids maintaining per-vendor/per-generation hardcoded device IDs
> that must be updated for new platforms, while producing the same safe
> fallback (IR disabled) if the check ever fails.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant



