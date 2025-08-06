Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69445038
	for <iommu@lists.linux.dev>; Wed,  6 Aug 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489061; cv=fail; b=ozIhRNBaHbANiFhfv3r1a/BEonlnFnTEPISeOfeOJgBvSIhJ6NH3CdtOWnFPuRXvP72uoSQN617gJvoa2VgwYwYNUCKb6/Nm9Rhg0Hevf68AuU3Exq4d2cukjdUg4IlFF+/uL9KSVuw/DpgyywvEdUTzjaxtwrcHTZStandF1sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489061; c=relaxed/simple;
	bh=PUzQ34eDgb0mdv+Bhf97Mlf4aMpp4WS7sYJQ+9sQXH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NuT7QuGV+/5E0ORu8F7JDCqHpxJWqGHDcmq+Cwactx7Y8HwzxansoSjoIgk7zEeCnHsAI1GONPNC/VC25/BIMAgszzDZ9UeZwcwecWg+kR0BClJq/zJ2W6jFUPJlBBdRtNQOxKa+5BbgWHcR66pvU1qm2PWMT1/AwBKYiIkOHII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dpSidHeN; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dpSidHeN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWgNXq8bwOvNC/IP7bx3rfHXRaHkbd8Yq09dAVXSk7fJ7O8dH01POtiRwOdABfFNbs5DBIv7hVd2NZljJYA080nHesR1sUKKQaEfs9Zozw6HSSrgXET+tVW0rqjgxtaO9vTvVRT98JGySlxOf6VovzT30xiWhC3KVR1t4WIKcpEMAVngZDycub5P1bN/VRmH90MXOEILG5UJTpgltrkLiFUNmzFIVz8RHHhGPkIb3MEjfYN2GfPuL1GTWN2IrFgOir+BuXWBhzOukpqPqVNCpSpME8hlycJXy6M9wNZb4AsyZBBFqark4PY2oS7tzCrtHwYviTzMV56DfZL320xXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OovILAbN5FC5FUOyScKz/1dnTLdTLsQ3PeZzdJumPPU=;
 b=Oc0ETKurBkF99ornb3lq7JekxVowUSmwaFsC5Fl3UPkkMWnVaPyzCZlvF3UUdg6wYTpUzksJJxWg75cFwR92pjEfPmq6oPwoTv46MoDY/xlUespo78Wb6UNmx2WEkB+xlpDtCB0p4CgHLd8UaBV4ITgwX0nqyRKrzavpmsf+tCJld9i/ejPtBv4asNYbaNMl/g9eiafYUyFCjaIXw4G9l02mWNxAmbvihZ8Gqcnv+LvplDJA+72Nlg6Umg4Hde5ySQKMAn7bvDTyn4Vg8GwS4wsiT0lwpLR7yRG5UZ5VjYr/LXOiG0U+SXblK+6qTv3rtrnFV3XZx2+8//ijMxi55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OovILAbN5FC5FUOyScKz/1dnTLdTLsQ3PeZzdJumPPU=;
 b=dpSidHeNNoJZLC+N/0R7oGrWOZdEeCtjZnWkzm4HLEkEQL9euYo8XIXNPgz7XXOV6A0Qw+qIyExaYo/fF0Nbz/LfCAMw6qeMY4pT4iUs4kFtjGeIlQnM94innWjVm8y4gPtC8pNDfWIIueNVX0/WnplcUTJ8AxtDGn817JElDIPHg1/FNReHTCwqG1bfqKxLgO38tRpRTEeLTYS0rOdHK0DiTKyni1XKqrv3QgMoWPEAAJmrehqsv2DbudX0IXuSPGdEH9wxz7G1k8zZ2o1AIM33r2aHDNIoGjb6n2mOk5OBZqukGycprIB+qLDr+Hva4494DCjWvhjSTcQz0mrwVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 14:04:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 14:04:13 +0000
Date: Wed, 6 Aug 2025 11:04:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters
 decrement
Message-ID: <20250806140412.GT184255@nvidia.com>
References: <20250801030127.2006979-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801030127.2006979-1-nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0f6f36-ed06-49c0-6f25-08ddd4f21fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KUfVubCNzWfqTI5gifxOjQHjkY3mQTH2bVJ29ckH0Twi83YQ1Nz29ij8sTSB?=
 =?us-ascii?Q?HK5+zU790sRbSyLFV7goAOH9sNA3+6OZzvOQhkupv8gka7yxuG3TTYCiGEW0?=
 =?us-ascii?Q?SyNkoRWsa12IXEbxBbth4kILFJP2wCtd6NbpvFO3d7ZCguZAmktfC4nRP6qG?=
 =?us-ascii?Q?2oSb9/KYVt5hk6CqZhfp3ndugxWa1CV3HI8to8A+RKaoywBtXT4pQgJeAhjt?=
 =?us-ascii?Q?gfEfuSZjrB1Arvc4+FAas10+oJlg0xwZpyns8GYXOscP5wrEa2+IiCQmQDDr?=
 =?us-ascii?Q?/sXJXOSP1NP94IWLSqxipTHGVftFOzz4Jr3EyoayCvryzDVm64yqFS55TLzn?=
 =?us-ascii?Q?CeWkc/YI09xlt/scnIRxagrJ9benVnLYyWwnZa1HAs61/TcHe59ZYH/l8OV5?=
 =?us-ascii?Q?HzRjWnhdm7VKnrvyEzrolJid6bgg9PRUwv4HAYeh8TcxV1G/SR2mDnnigj2R?=
 =?us-ascii?Q?5K9XxbrHKRVLOitZSIe9FT2jj1Y2ZxVZWjCsd/SS/UjhwWjJ9PC4OAQxW8PB?=
 =?us-ascii?Q?cSMlAdLZecJy+ZEZQFHt9WFqYJhxPFTAS0xRP+M81j0H8OVwfsz0sAW75w9a?=
 =?us-ascii?Q?DnE0b1mfh7C7rvd+X+yD85IyYbCFIgWjpyJxScO7rsET3ao0fEGBMBX5QYxZ?=
 =?us-ascii?Q?+CStvvNVyq2elPUvDXlvZQ2CMLd8t6vCZbbpHo3zuO4qRZZVFOXW+JUCqwXB?=
 =?us-ascii?Q?M/VKwp1eHqXrxt3kDD74+u4PE+bxUUzSbCK/gRDcShVVEqnbhpJH1vxoJ3Fx?=
 =?us-ascii?Q?i6qfmIwZg2hEEXgTiEecHgnKjctuVZLGILI+DP6ep4D/S/iIKiQJjeRjU4AE?=
 =?us-ascii?Q?GidI2MNV7E9DaQsojtA/TGCsc8f5WXxpZUi6b/+HDmxdz0G+lcqu2sB/j+Lb?=
 =?us-ascii?Q?n0v6Kei2TGIm4rDnEBDOcwf+vy8WyXuTwo5DajSh9n8mcz+3Zs3CveJqdqM2?=
 =?us-ascii?Q?7YFUd0dCXHic4b2An4ictN9tHDH57slw9veJS+cafQOyE29DoJXlWyGK6EYU?=
 =?us-ascii?Q?reKp5LD2bvwemI+6Kdj5KeDrBpDwplXEFbtssz4qT9VbrlA4+EHzW52O9iMt?=
 =?us-ascii?Q?GnGYRKkcw8HkEtjvPQqH9OGSRfSAXsiyXFgx2xoWuw0W2Lgi7oxW7A4oxOgu?=
 =?us-ascii?Q?d7UsalNq907gezIJEiMmxinrOQjc0hXg5uE3ytLVC1z04IKQSugq1PvXQ1ld?=
 =?us-ascii?Q?FDLNZEKEG/P1CtJZc5kBDVxgmiAy6AI/W4JdSDRJ5Ie1d82t/InarHKmp/OG?=
 =?us-ascii?Q?WEke8ZM6k5SyyQ2aUQ8XGbAFUlcyw6wyaBfqX3RIsDSpWtnW/N8SeHHnHUFD?=
 =?us-ascii?Q?CbXBWzQm1NdJABUWpPQLWkw6TN0iM4OcapJw4HEdBSUPD845cqzX7LbaHI+m?=
 =?us-ascii?Q?FlfM4abtj5jdAtj+2AOb/xiaTU85h181fTyL+kxKTwf8Ej3zAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0veNci+NtnRsUP9+7vx0vFuzfescAdc+ZR3QcXZIaOqvcxZrMY5tlrUWYvUY?=
 =?us-ascii?Q?0ewujuBQuZAES15SYXq+S6sT1qVKp8lkBlWzCX+IsmoEOTJliTe6CaghsDdg?=
 =?us-ascii?Q?ZU7ZFphTFCUHvuTEyjSn8OKCdn2ViT/I4UyOIVMSu/lbmcvWn4SJSmnEB4W+?=
 =?us-ascii?Q?SNxVE+DF1cZwbiBiFD2g2VenTsWGXUKKYPYy150IhmVpCa93kLkYRP5sU8nY?=
 =?us-ascii?Q?gpuQHT7HJzS0YWpKHMR6xXoXN6ogCWc7CrBoxeNvrpJa+XvZ4+15FLPiMNe/?=
 =?us-ascii?Q?3Nf4FDf0xX9V2ZzJwVmyVbti6vqK90Rlm7nX4M1HCAmiZyfCqPcu59TBS43s?=
 =?us-ascii?Q?+DHsTRQlHbVtGIDRrdxETeNI01YRUZDLEmWF4n+Q0Mweb+GjIyUX/9mAq2n/?=
 =?us-ascii?Q?sgqdDiafjdebNducp3m5zbeDbjW5ifj7W7MJrlxYO3KP0rISkC43cuRSA2sY?=
 =?us-ascii?Q?TFWR9v/VIe8fgNnOpNEoMeFu5lffm2fgGyN7Tb/rZS16SBNuPLAcuykquYJT?=
 =?us-ascii?Q?dgSHbuOKfN8nQh9MVfWdUQ+YtsZBWnh8IA2gCBODmXGNx1tA7C1OaxsJL6ZN?=
 =?us-ascii?Q?gVnMO4TZ6u7d4//JbWL+oa+/hlhs7oJ4H5sAeoITdtXLvteVfDPHZDtPAHlq?=
 =?us-ascii?Q?aVuHhEJtOGbAOGm1VtH7BxoryxctzSfHz7nOdkJ+sPmlkYxBgx+2BRdrTSDe?=
 =?us-ascii?Q?SAEE/mPuk4ISJokcV8nuLZ+81nQfTIz7YUgXNBc75RqQXeSZh/QBZfX9oIho?=
 =?us-ascii?Q?Baw+CER96myO8Zruy7DQXlT96SxKNZXq/NPCEhVAyeyT2kXf9W/qUKAxSiow?=
 =?us-ascii?Q?GZks+mM+8mnclIJ9eho6CitcRVTrPdEaoRYX1dSq7dAJrnlpovpDuXzUSeAF?=
 =?us-ascii?Q?j4M1MK0tSnyLoHWajioRPA0U/R3NJD95MZ0jwa4e/Mvyy/gomBIS66QCVPbq?=
 =?us-ascii?Q?GcnSGzbTnVJfsRKkPdv7IvYbIjVecRmn3N2iHWqbki0ADX1ufzqiAM2w98Kn?=
 =?us-ascii?Q?C7WF4vDkUM5+EGEKQaap0FS2oTbMD/IWYVw2YpNSHT6w8Ns5FiQntpgKBt81?=
 =?us-ascii?Q?fCyyzvNDadug9RR05y6Z6yzEv0lb0QedEGfJNG2WhCwWd+4j8lz+BTmnzYo9?=
 =?us-ascii?Q?4zFqAlqCwJ8LCm9oCDDRkbKi+qtd+/5ubb/Pepm/eQa7gji12vKfBaMOxDsk?=
 =?us-ascii?Q?UPLvAGWZWzrIRYLSEwLoJ0l2Un/kzmYORvM+BXSYwek/K6RfztOOCQ972ZPD?=
 =?us-ascii?Q?z7AtnwYBspmhS7oYt7qPjuZnXIPZJb2+8GwqX2qXcunurenuzgzZzVlWQ/wa?=
 =?us-ascii?Q?Arfa/BrP8GtAmGMebA/tUwJz+rufkQw5uvxKYo8J+Ht8OvbU8VIiJDmcXe/3?=
 =?us-ascii?Q?LvkoueKBxYGho+A/sYbJWtph+veI1YzZgnw/PBOd7ICexP+A/aWK91Yrz/dA?=
 =?us-ascii?Q?8JwwPTlIfNnA0pxO2lUaM7QNHDVWQ2QxIq5HL3OVFEZ7X2RHisVnMizHiYAb?=
 =?us-ascii?Q?G+shdqnTJursWVllQY2HWrlD64IS9k9GFYhQpkUSqQKPdahueaTMNQ3nqVnS?=
 =?us-ascii?Q?OBWmaecMfRE4aBAqIzE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0f6f36-ed06-49c0-6f25-08ddd4f21fb3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:04:13.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKUvtZOn0/Z7l9IHb/XCZ2N0dzoUKFA0GT9r5Utnn+Rj6o8LUUAEyMQi8HUYxqLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351

On Thu, Jul 31, 2025 at 08:01:27PM -0700, Nicolin Chen wrote:
> The arm_smmu_attach_commit() updates master->ats_enabled before calling
> arm_smmu_remove_master_domain() that is supposed to clean up everything
> in the old domain, including the old domain's nr_ats_masters. So, it is
> supposed to use the old ats_enabled state of the device, not an updated
> state.
> 
> This isn't a problem if switching between two domains where:
>  - old ats_enabled = false; new ats_enabled = false
>  - old ats_enabled = true;  new ats_enabled = true
> but can fail cases where:
>  - old ats_enabled = false; new ats_enabled = true
>    (old domain should keep the counter but incorrectly decreased it)
>  - old ats_enabled = true;  new ats_enabled = false
>    (old domain needed to decrease the counter but incorrectly missed it)
> 
> Update master->ats_enabled after arm_smmu_remove_master_domain() to fix
> this.
> 
> Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
