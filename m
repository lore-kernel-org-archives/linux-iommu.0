Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59D1DFE1;
	Wed,  9 Jul 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078379; cv=fail; b=OhS3zywr22CF9TIZvDvK6aJ9FhLGVC502nlvh8mGuyr6rX4hUM3Xkqd3hhI8vpHJc9Qn+z5s0m3ZNjQLS8WvPbnIQGxQf7KLUiJrFFrdwjwA8pkhzVHIGg5KxHEhgvfsB6DVxboiSPRP6MNNaAzRRvTezPgDlWx7Zb25iAIGLs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078379; c=relaxed/simple;
	bh=1QvwCWfN1cnvLrTIcBOW2c7swClqZ9lSCvikLvZSlxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JuLUNjb0RpE5U2PdoCibh/9dJnv1yJTeNq90vImH9qh0brPK5GO9jOGJJsNg2dXHSjLmauZ2XefuDOvoQwtxuD6A32awtk+xQ5n/z3f+tNJcv8GQdYKdkHeQLwjKy/Ob72LisqX4oFcrSTep6bR1QjbVoqRJTwQOwE+w4HF9ELc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hvzpzE1T; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hvzpzE1T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZLYHWwVzLsnM0paTOmHh/K7uz/JnB2R/aRBWmzL9nikAC5Y4rqTza3t4B2DnX33rd/fhLEV6em9JoguzYZl+Mljc6i79+AVNuDNJqWErELj16B7iu1WTeMUwh/8UV66WqSYevparM6jeTZYStnv6BmUJrk/hqfXyB6ugX33h/mALjklQJv1N8Q7Vf0UDFLFchqAqO0V88U3V/sRLTKdXYN9YtHWIBeL1fKSHJ/CHbG/0oNmq4R6K2DtFKNz4XV/mwlmUsJ5fFV2oAO/L7sFcmBdx5f1MmHzgVKZafS/tcZn+WEGKph/8+CV+Ge/zY+sb8i9nKze/CVDMD7fCf5KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqk9IBgAF9AVy/e8EWUO4sSLs94/6i2kpX+BU6DHxEE=;
 b=xxCCL4PToI1rT9qElVIYdEQd5CX1jWCd1w6b7zQO3NvprIQ0d6uF/9RUdx3Y3oDC4KBczCKtZX3ySwG30rfXUGk/m67vMeMZPhFFduEb3xmKEPmUS52wqMbCbhsMSNjXXCQAJQys9+BHqNLdqWg/iP5AkJ7DRjGJmaBS9diyWUP6PRysdWfQW5+i4QeF9zv+wnnJDRAv4LDeTq+b4iKCLKbaRJqkWwUxwCDYu94FhPSzopbkmkfYm85AHWwxUIAB/u5kyC6tKUPH59iH22o/ThaRsuq/ruar+SvWe0AfRBjPaQ7LMMvQeAT9+S6yt0B9gSuBAoBLDYlIviJ/w7KWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqk9IBgAF9AVy/e8EWUO4sSLs94/6i2kpX+BU6DHxEE=;
 b=hvzpzE1T0bVSSLWsyqPMfPYlJr36X1yE0UkdA5tHvrEgmIg0/U9XaV48qHy77n9CTBbbdTnfcXA+udwscEGQjTbqMANNQ5lqH0HRDvQ6lHSjv95mDMvI0oZ1KeDs0ps+c5BMstCpr7DrLSIn2A3E0xmcvIDEQay+Pzzm5xg0oDhPW/tEhPGFvue8RZL+wVVS4DnB6VdK+Jm5to4I+1MQq1NefPp1PCXmgO4Yc8TYqco9OeoCFqaODdBBmIi0XX8nEVlFCwXI+t0pV437JIZhz5gUheeR4YuK3c4nPdWnIVszEG9MOERvyobXCLqBqdMMqwKoOFq47DR2di++lun7Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 16:26:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:26:11 +0000
Date: Wed, 9 Jul 2025 13:26:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: next-20250702 WARNING iommu io-pgtable-arm.c at
 arm_lpae_map_pages qcom_iommu_map
Message-ID: <20250709162609.GD1599700@nvidia.com>
References: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
 <20250709002521.GB1599700@nvidia.com>
 <CA+G9fYtOZLYe7yN7EdaEHLyJgVypgKFO2R6POoiEZv7PcLw+3A@mail.gmail.com>
Content-Type: multipart/mixed; boundary="CCLIOv/yUOGPkaVl"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtOZLYe7yN7EdaEHLyJgVypgKFO2R6POoiEZv7PcLw+3A@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 267afe2d-024b-4e45-ceb5-08ddbf0550ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBKRQdx/KsRGtg0tXKXRNrTrCmTmvA+Q0/aPTqPoeWvE4ANbUM7G7lkf+50a?=
 =?us-ascii?Q?b/JQqjgK+qwn1kQPd60siwWyRNrfP07jDWF0jfuVizYozgoWopuP9O7PP1Af?=
 =?us-ascii?Q?e8Dha0wE/JefQwJk7KLJosghl4upUJMEF4ka2ytCqC/cNjfbJ0MmTpQSi8hP?=
 =?us-ascii?Q?aiiG0zDfIPVT1xycRp1K+Hv5efbbwzH21MtWHAsxGSR36l8ipgVg42MX0eh2?=
 =?us-ascii?Q?Mj8UUaVV1ZYLlCw+ETk8ASj7bFeByU9pSH3JI7VYjZB0bFI8LOqSQA8E78LF?=
 =?us-ascii?Q?y+dNQSbjOEyx6xgXKKUXyKU0S79P1Wqs46I5Fi8+FiMKsIU2DDKqROSpYT7j?=
 =?us-ascii?Q?SetEHrjunMihZ30YIOEBKqEkLxql4q/nnquAJIoJAzuKr4KdbSNzNUsoC3xc?=
 =?us-ascii?Q?MXr57TATebTLGyppih62+do0FBWbpShD7A+11nUs/Hit6qGS+fzg+wzbKMp7?=
 =?us-ascii?Q?Nhmejq7xvdsczEBK14sZEl4aSflfSLxf2Y2Cep631j6j1zojSviWzQkSpR82?=
 =?us-ascii?Q?e8qyPcsN51lX5B0LsnB0KoKDJu+KDfiGc9IK01+stYXGTXFKCTE7RKoPMQYD?=
 =?us-ascii?Q?f3Y5QS/xaJRkHmn80SdVAZevSkY5OKV1tjsigX9QQo1pRAe0TwW1W1IDFFhY?=
 =?us-ascii?Q?1TkTCYZNLutF8p/N9fftX85babFtKpIm6z/CrOFm/7mKRmczg5H3DrQd4ILm?=
 =?us-ascii?Q?wln6Wxq/tMyr/VHVzFajyPBv3FWk2s4Frtj5/hjVufgAd/1orKP851VkIUv0?=
 =?us-ascii?Q?Ux2rdCn2Vs2xb2qONsCdCl7+uyA4SaLaNm/LaCnoBiazMC92uTC/+flUZKXD?=
 =?us-ascii?Q?aFUnLdQAPafEZ/sN6VUpyXLW/LE/Go/vMAV8WcKWDAgVrWRX+InafvRUI39D?=
 =?us-ascii?Q?gMG9oJ563cv9ng+6r5nQePcUpuhMwIVzz4Yl7O0JCFk+lFx+p+ZIA84ieAoH?=
 =?us-ascii?Q?J8+EolXte9aLMj4mVSEp31cmv7Y4VUU98g3VsPP5OvLRCvmznfU8+ZPWIbqd?=
 =?us-ascii?Q?WuGDhTppg+nHgxNPJCuEqLN1jL2N689je9TWPHwd83B/bPfLajTVg36xn111?=
 =?us-ascii?Q?k7Y99Bp2ExyLHqiqetVeoVHiHfw+ZkCSJdPHsD8wf0KXMrpbKeZi4TFPsYLL?=
 =?us-ascii?Q?imflkuTpOBqz23KNwq7Jf4BrVz4apDQTuAW4fYvrbgP71ue9ojQ9JRWaHWbC?=
 =?us-ascii?Q?nD3oABRhKcZ4JFP4ztpBIWSewn2v1XpAcmEXZH5zfpnsmbNH3acGrM8BuD3c?=
 =?us-ascii?Q?raff6Qvud6/ZL5+MwXl516+p18O6O8JfcmpZioPCgpyLKgeRKfpH2KnHeANn?=
 =?us-ascii?Q?gYUtdGNMmo1aAjTUBbRr8V9drdQnxu4GXSQXdfmWGv3VnGzXwoTr6nzxvNAH?=
 =?us-ascii?Q?UcVjeyJ5AmK1liXnHrR6su5r6PrkhqCTnVR4gsyi9+kV0BnA5P96V2m0x7U6?=
 =?us-ascii?Q?1VgZOVotz/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vapP44O+5AvXY6N+HT2W4cejSuJVXPUygHfGg8E13pk54NgdDO4x7nAM4Na?=
 =?us-ascii?Q?TOZAhdkiSAF3mYbh96OZmKVwry5xS0i5/UuGkZ+AdzvrQJeau9wS+9EynN/W?=
 =?us-ascii?Q?Y17armIC07VBtHLLmDQkZpKKT8ZO6tAhlMnvpnlC0cuh8GxlJd8iTDr+LoKg?=
 =?us-ascii?Q?PQSts9NTQis/o8e2IOe47TH1LxsPgtrQvPJDMn39qgy9GlEUxXYeuaWS2uZb?=
 =?us-ascii?Q?l0qjPtZnWPOs5X8G7L8NkMyBcuZkO5prCoITY3f9gE9xojkiVBNRghjW1rzq?=
 =?us-ascii?Q?DgnBqhGLUUVk9VZVgr75jLXDzyPCCldYxOakMFjtpa0G6SRyDSZ7EK2KNE0Q?=
 =?us-ascii?Q?mSDfeamCS6F11aT43jai7bJDGLpEQ+aLPc9ZaQrDypn/NtC9LLrGlyi09XbR?=
 =?us-ascii?Q?6Dfxv7ydWUqVoFHXN08Mo5s3x4jl3LylgAoQizZKGtAYWXNcXrIR7wSJ16wR?=
 =?us-ascii?Q?9AmOh5vbjylXlrGikT5ddc8U7s8eJNkwPIAkbiqka7Ni+mLL2WvmMMYMtzQn?=
 =?us-ascii?Q?BN4G+ojPlk9UGMz0EfYXo1I7JNXpBS9yKBh2VxV0wW/yKylIyXL3QHGcQQ5D?=
 =?us-ascii?Q?2upvZUM0NyXVEdZCGGcFOusFKhxnjjCmjRc6jVwrU+u53OvUb1jOzVoC//1g?=
 =?us-ascii?Q?Nr2EFR6oc7uALUZOWF1Oi22qMEb99xkogMqx762qbusaJqoek5zh0bB0Z+sF?=
 =?us-ascii?Q?xhOZUtE16JR1cjPa2y45oiSqtexBmrU/gi1paNSAppRg0QfjeEs/scDzTj5/?=
 =?us-ascii?Q?JqxckhRDn+FcCxXvtlyRlx9tfMztKr/QFvOpF6b/onL/JRb1BEEQ9Ouynln2?=
 =?us-ascii?Q?0avLkzVZZtMvrgEuDvLBEMA9YOubKCSRHmDaf625Len7FLwYm7/FRi7hlYKl?=
 =?us-ascii?Q?uM/Wplxhdmyh4SJqI5G54BgnIk2dIM788iraklnD7PVPfoqFh6fl3reimudd?=
 =?us-ascii?Q?ogDq1Kez0oVCUML9SyoS+wqNfVjoMaGjZMNyxI230wptL5cy+NzQyfemFVTg?=
 =?us-ascii?Q?fqvbR454YiCQdxLUKFYue2lWPdK2OkOzsodaCIGm/zUFlfVyZFE5/q0E5el0?=
 =?us-ascii?Q?v+t1hJgA/Au4PWGIx/LiBqcfET1pJkWmD/8vmflVW0aRbPSOa4bKB3aKoMkP?=
 =?us-ascii?Q?2ldDQ2hfT1GhMRlW3T41RE3nJ7QbPnbhIOHiknEDwesKgCmzP7yqE/DptTv7?=
 =?us-ascii?Q?SlU64MPDIXBfCAecvzuXkf1BI9nd5wn7G09BBq5ORXq1V6LP3rHDFa/dk2V/?=
 =?us-ascii?Q?SBzbyftZQBdPZd+muixgo6+hkjp3hQq3k6fNyctZ2VK9hxNBJlRGisjGjBVZ?=
 =?us-ascii?Q?cHlwWj4FHXuetqXyNcwYJGm9KCZYzClqynFUHi+RZMc82D9WEbMGs97wXr6F?=
 =?us-ascii?Q?vV4wnBTcDi0Fw89jyy8O+gF+WSNYKvjse0Ufh/di03Xgf0YNbG++0fFz5V69?=
 =?us-ascii?Q?UJmPNqD5c/0Snx3HAbhNdo8827CR3K9KTIimLpLkKH2GmkBeJoIo8tSr+Bn4?=
 =?us-ascii?Q?nxQ+01TPvofQeSr7nyfv86qsxdCK1TKh9zICuwTbNSOk5oWak8MsWWD+5Ucd?=
 =?us-ascii?Q?m25YbssrBxgFnb607pZnCFT8K5JSNjLaBMO6LMgj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267afe2d-024b-4e45-ceb5-08ddbf0550ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:26:11.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixFuQiFnq/6tL3Igl+7mmNPXm3QPHNvr0QFndOMCkF0gbFuoYJkepO0Gva0sU0dQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

--CCLIOv/yUOGPkaVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2025 at 04:14:26PM +0530, Naresh Kamboju wrote:
> I have tested this patch on top of Linux next-20250702 tag,
> and found kernel warning,

Oh, yeah, I guess that hacky fix is not going to work.

Then this is probably good enough (against linux-next):

--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -335,7 +335,7 @@ static struct iommu_domain *qcom_iommu_domain_alloc_paging(struct device *dev)
 
        mutex_init(&qcom_domain->init_mutex);
        spin_lock_init(&qcom_domain->pgtbl_lock);
-       qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
+       qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_2M;
 
        return &qcom_domain->domain;
 }

I believe the original text was a copy and pasto from an ARMv7s driver
(ie the 32 bit ARM page table) which uses that unique combination of
sizes. It is not a sane bitmap for HW with 64 bit page table support,
there is never a 1M option for instance.

So this removes 64k page support, which maybe didn't even work?

I also prepared a proper rework that puts the pgtable allocation into
the qcom_iommu_domain_alloc_paging(). I've attached it, but it is
involved enough it probably breaks something else. However if you
want to test it maybe we can progress it too.

Thanks,
Jason

--CCLIOv/yUOGPkaVl
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-qcom-Allocate-the-iopgtbl-inside-qcom_iommu_do.patch"

From a86762cd05296949a8fc20bcb7558aa57b137cd2 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Wed, 9 Jul 2025 13:24:40 -0300
Subject: [PATCH] iommu/qcom: Allocate the iopgtbl inside
 qcom_iommu_domain_alloc_paging()

Structure the driver the way the current driver API expects.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 159 ++++++++++--------------
 1 file changed, 65 insertions(+), 94 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 5891ad5de0d5e2..f65c8b50903319 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -66,7 +66,6 @@ struct qcom_iommu_ctx {
 struct qcom_iommu_domain {
 	struct io_pgtable_ops	*pgtbl_ops;
 	spinlock_t		 pgtbl_lock;
-	struct mutex		 init_mutex; /* Protects iommu pointer */
 	struct iommu_domain	 domain;
 	struct qcom_iommu_dev	*iommu;
 	struct iommu_fwspec	*fwspec;
@@ -213,42 +212,16 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int qcom_iommu_init_domain(struct iommu_domain *domain,
-				  struct qcom_iommu_dev *qcom_iommu,
-				  struct device *dev)
+static int qcom_iommu_attach_domain(struct qcom_iommu_domain *qcom_domain,
+				    struct device *dev)
 {
-	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct io_pgtable_ops *pgtbl_ops;
-	struct io_pgtable_cfg pgtbl_cfg;
+	struct qcom_iommu_dev *qcom_iommu = qcom_domain->iommu;
+	struct iommu_fwspec *fwspec = qcom_domain->fwspec;
+	struct io_pgtable_cfg *pgtbl_cfg =
+		&io_pgtable_ops_to_pgtable(qcom_domain->pgtbl_ops)->cfg;
 	int i, ret = 0;
 	u32 reg;
 
-	mutex_lock(&qcom_domain->init_mutex);
-	if (qcom_domain->iommu)
-		goto out_unlock;
-
-	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= domain->pgsize_bitmap,
-		.ias		= 32,
-		.oas		= 40,
-		.tlb		= &qcom_flush_ops,
-		.iommu_dev	= qcom_iommu->dev,
-	};
-
-	qcom_domain->iommu = qcom_iommu;
-	qcom_domain->fwspec = fwspec;
-
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
-	if (!pgtbl_ops) {
-		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
-		ret = -ENOMEM;
-		goto out_clear_iommu;
-	}
-
-	domain->geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
-	domain->geometry.force_aperture = true;
-
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 
@@ -256,14 +229,14 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
 			if (ret) {
 				dev_err(qcom_iommu->dev, "secure init failed: %d\n", ret);
-				goto out_clear_iommu;
+				return ret;
 			}
 			ctx->secure_init = true;
 		}
 
 		/* Secured QSMMU-500/QSMMU-v2 contexts cannot be programmed */
 		if (ctx->secured_ctx) {
-			ctx->domain = domain;
+			ctx->domain = &qcom_domain->domain;
 			continue;
 		}
 
@@ -276,21 +249,21 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
+				pgtbl_cfg->arm_lpae_s1_cfg.ttbr |
 				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
 
 		/* TCR */
 		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
-				arm_smmu_lpae_tcr2(&pgtbl_cfg));
+				arm_smmu_lpae_tcr2(pgtbl_cfg));
 		iommu_writel(ctx, ARM_SMMU_CB_TCR,
-			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
+			     arm_smmu_lpae_tcr(pgtbl_cfg) | ARM_SMMU_TCR_EAE);
 
 		/* MAIRs (stage-1 only) */
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.mair);
+				pgtbl_cfg->arm_lpae_s1_cfg.mair);
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1,
-				pgtbl_cfg.arm_lpae_s1_cfg.mair >> 32);
+				pgtbl_cfg->arm_lpae_s1_cfg.mair >> 32);
 
 		/* SCTLR */
 		reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE |
@@ -303,58 +276,74 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
 
-		ctx->domain = domain;
+		ctx->domain = &qcom_domain->domain;
 	}
-
-	mutex_unlock(&qcom_domain->init_mutex);
-
-	/* Publish page table ops for map/unmap */
-	qcom_domain->pgtbl_ops = pgtbl_ops;
-
 	return 0;
-
-out_clear_iommu:
-	qcom_domain->iommu = NULL;
-out_unlock:
-	mutex_unlock(&qcom_domain->init_mutex);
-	return ret;
 }
 
 static struct iommu_domain *qcom_iommu_domain_alloc_paging(struct device *dev)
 {
+	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	struct qcom_iommu_domain *qcom_domain;
+	struct io_pgtable_ops *pgtbl_ops;
+	struct io_pgtable_cfg pgtbl_cfg;
+	int ret;
 
-	/*
-	 * Allocate the domain and initialise some of its data structures.
-	 * We can't really do anything meaningful until we've added a
-	 * master.
-	 */
 	qcom_domain = kzalloc(sizeof(*qcom_domain), GFP_KERNEL);
 	if (!qcom_domain)
 		return NULL;
 
-	mutex_init(&qcom_domain->init_mutex);
 	spin_lock_init(&qcom_domain->pgtbl_lock);
-	qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
+
+	pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_2M,
+		.ias		= 32,
+		.oas		= 40,
+		.tlb		= &qcom_flush_ops,
+		.iommu_dev	= qcom_iommu->dev,
+	};
+
+	qcom_domain->iommu = qcom_iommu;
+
+	/*
+	 * This driver doesn't keep track of devices attached to a domain,
+	 * so each domain is single device. The single fwspec is used
+	 * to push the invalidations.
+	 */
+	qcom_domain->fwspec = dev_iommu_fwspec_get(dev);
+
+	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
+	if (!pgtbl_ops) {
+		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	qcom_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	qcom_domain->domain.geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
+	qcom_domain->domain.geometry.force_aperture = true;
+	qcom_domain->pgtbl_ops = pgtbl_ops;
 
 	return &qcom_domain->domain;
+
+err_free:
+	kfree(qcom_domain);
+	return ERR_PTR(ret);
 }
 
 static void qcom_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 
-	if (qcom_domain->iommu) {
-		/*
-		 * NOTE: unmap can be called after client device is powered
-		 * off, for example, with GPUs or anything involving dma-buf.
-		 * So we cannot rely on the device_link.  Make sure the IOMMU
-		 * is on to avoid unclocked accesses in the TLB inv path:
-		 */
-		pm_runtime_get_sync(qcom_domain->iommu->dev);
-		free_io_pgtable_ops(qcom_domain->pgtbl_ops);
-		pm_runtime_put_sync(qcom_domain->iommu->dev);
-	}
+	/*
+	 * NOTE: unmap can be called after client device is powered
+	 * off, for example, with GPUs or anything involving dma-buf.
+	 * So we cannot rely on the device_link.  Make sure the IOMMU
+	 * is on to avoid unclocked accesses in the TLB inv path:
+	 */
+	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	free_io_pgtable_ops(qcom_domain->pgtbl_ops);
+	pm_runtime_put_sync(qcom_domain->iommu->dev);
 
 	kfree(qcom_domain);
 }
@@ -365,47 +354,29 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
-	if (!qcom_iommu) {
-		dev_err(dev, "cannot attach to IOMMU, is it on the same bus?\n");
-		return -ENXIO;
-	}
+	if (qcom_domain->iommu != qcom_iommu ||
+	    qcom_domain->fwspec != dev_iommu_fwspec_get(dev))
+		return -EINVAL;
 
 	/* Ensure that the domain is finalized */
 	pm_runtime_get_sync(qcom_iommu->dev);
-	ret = qcom_iommu_init_domain(domain, qcom_iommu, dev);
+	ret = qcom_iommu_attach_domain(qcom_domain, dev);
 	pm_runtime_put_sync(qcom_iommu->dev);
 	if (ret < 0)
 		return ret;
-
-	/*
-	 * Sanity check the domain. We don't support domains across
-	 * different IOMMUs.
-	 */
-	if (qcom_domain->iommu != qcom_iommu)
-		return -EINVAL;
-
 	return 0;
 }
 
 static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
 				      struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct qcom_iommu_domain *qcom_domain;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	unsigned int i;
 
-	if (domain == identity_domain || !domain)
-		return 0;
-
-	qcom_domain = to_qcom_iommu_domain(domain);
-	if (WARN_ON(!qcom_domain->iommu))
-		return -EINVAL;
-
 	pm_runtime_get_sync(qcom_iommu->dev);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+		struct qcom_iommu_ctx *ctx = qcom_iommu->ctxs[fwspec->ids[i]];
 
 		/* Disable the context bank: */
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
-- 
2.43.0


--CCLIOv/yUOGPkaVl--
