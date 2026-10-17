Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FD3D3492
	for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792237233; cv=fail; b=tBEF7ok7mV88pBWxCTeVOlF+M5JFLcnYfEm+8AHpBsXRyP43+L0F4BMq0EF9idrZbpkE2LUysLgX+jfOErZR3K8Wy1cgzU7KV2D2udEgDaTKVaLqI0NY+GX6qlroHOY77HBRAlVaGmBtwCeBnF61gaa9iZl0G+WUWrc9FMrjEwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792237233; c=relaxed/simple;
	bh=rNkl/cwsFV0KZsYFk5EUTQpm1Sh80iTgT8Lz9pbwlds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5tl/wYBmctsVHKnvtSZes2fzeyVcifoAa2gqKTfpKgEcY/M4MNQxmF7bPnVwp1e8OZxoZlP1IkXhYtr9Dj3TJKkksuCN2TCzzqBFMLcLBEBP2Ok1rtito0Vr+bByGB09pMp6lK+hPWfhOK4W+MJf6okKeKC5wKlV1fBh1QVOY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sm9cAx7S; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sm9cAx7S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehXjVZLVydIENP10GfqYZhnP3fDRSlYNpiUHhYKPyH21nO9a2xSjUKrWAFtnHC5yWUTO2HWPV7s8r1fFExfxDqfxjzZync6g/6a8Gk5KshHGl4lOVTVrXLBdFGNlVMoXOPFY5iqDWuLNmYT32aePrVuzvr+aNeBuXv6ndQHValm/Pa9mVh5Wnkal7VVGpTYWdvMI7hH0DanpWvJKcG3W9OViz9bxLEH+b02hl0lmmtAFmOTDELSRgQUGbjzK6VZ26WtZCywU7nkumVE4dFOuhmJNO3CQAJx42ELJp0d1PA3IvCaZt4ppOGN2ji8mVW0MVK/WPG97F+0YpnZc5jeWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNkl/cwsFV0KZsYFk5EUTQpm1Sh80iTgT8Lz9pbwlds=;
 b=qGMqt7nPJMiqSLpZXQuqF3aUXRmQ1dM4kMZnF1kX0YY0xEF15lHHq9L/vCBs4l3qQa39oIAgH2RaKRzDGoeY5Ji+kSFqBf1sVmYbJtC7VSx/hbDtWzcuvEGLl094zuL6U9M9o6zfRr8HthsMdrgrsDeWjucAtniopXgcxXZxm8cXat9q68+IgUAjOYUHHxi2s3JRHpLqTKQcAwafr66k0jr1Jgdd6x1uNx8vCTbjn8aPoSWDw/pxVCrebbzZZK1arKTIiHT9kMnIjAIZH1XFxQITe1pTXrZXhOCzqU6jpdpp65H9ArR7LAj2HC2gyEXE9ojah8PaYEDHC02qysaMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNkl/cwsFV0KZsYFk5EUTQpm1Sh80iTgT8Lz9pbwlds=;
 b=sm9cAx7SEXCL9jLdk7tlAItAyslkJH/GIeu2wOWyw+NDJvvNjAwciY6LuLWPfEdLQZb+LHPbnnL3fGG7SGV/SJttsZIWE/dzs6Y19MMDpwVQx37Dklo8ht4eRBZ6EONnxk7Du3fuUti5wilEGXC+A+JWfOgFzG1QJyefzYnJrdEuFlCse2fdr7n2KsOn1KoTi2mazmKSuLEIpVh9/HFAxaR18NTkEic9SIEXTbxwiEyzFnmm2qos0X+opfzvIecNtmPMr6Oo4EHrYyiKPv6Cq02GlLdB7Ks3Zw4qBKpp4v+UgDZSstVBpJmlVR82NRfl7xvRtMWr4vSz3sMjxOdyWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MW6PR12MB8914.namprd12.prod.outlook.com
 (2603:10b6:303:244::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 11:40:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 11:40:26 +0000
Date: Sat, 17 Oct 2026 08:40:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
	kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 00/11] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
Message-ID: <20261017114025.GL13920@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <27f2e050-10c0-4a77-8d59-00a95a162912@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f2e050-10c0-4a77-8d59-00a95a162912@linux.alibaba.com>
X-ClientProxiedBy: YT4PR01CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::10) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6f9fdf-a3aa-4b6d-dc6d-08df2c43701c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vMgX5T7kEhKxztKbwl3y1isAeqbz6eTTPoDkQ84nTjldbeJrN9dvb24CXz81U6x8C7lXL6YFWSIQue28oB+Hamf+xLXu76SmIZkNxxHpCFVbUbX8unU30Kj0SZ3McLdJAwPtLFAIMsmX49hWAjw/W69XcgRmAEEypTHEVcrbm0cHV2fLVLC002cvBIIwzT063gQBe+JsB6Tl3nAV1zHGcXecWCJ29lFoiFRoQ7mWQvvbX411QXNQdll7BhSZ2veDkAFvW+JR+ObSchtYjqFLVxKGBEpTg6EI/8hpJ/250kt0J8plAZ7Cr7B14scOAYy34Tpsg0c9amCSMM80y4uhk8ucWMV3djjF16fuDSWtsu2UtTx6nOfKQj7iqsAMBdPFMsDHJgwPliE+KLHz5WuRc8CDc/SvZcdXy10xSEawEuNSvU7FU/5JDOqnAzMNFMAMcpkJXIvLrR+y+UCiiMq9927KfTThlhRBk9pefHZX/U/pWimOs/r3MCWZTtTtiP5Z7r9rLzYal8CA+l2rmILzinxQIGH2lJJv1a08nCWzM1payHko+2x8B7q8XV91BnbvRVAobroJbRT51LWCQsatA4raJuoaAVNtLys4vfGXEcCSWg6MnhgVv2Uk2ttRF36Ze2seuKv6U7SXiLfzgXbJJajRnJj/YR9/nIiJScPF4RI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jazau589mUeO2nNC9SbH69bQc2blX0rlk3Jz4VL+F+cmtfUUbmrcAhhLQlIs?=
 =?us-ascii?Q?42IRSOsJG/jK0qEQvz1mEvzCQSGUahHH/vfCoHcFkcqWzA3qwwow4CY8dbEW?=
 =?us-ascii?Q?KwhnD3tnvvqcMxVnyJ/NpO33SnIHB06UyjUwTxtt38OHRs8FcE+EfGeaN8ms?=
 =?us-ascii?Q?XTlB0SjX17LQImMhI7FoDWqFokPuZSWbXKfysW56gqh7Z87OfGOTUHqOaqyV?=
 =?us-ascii?Q?XeOxeE7DavmYL85jVugCvxZ0clZXtBW7Ru9TKBzn/CO7Ii/cjdd8fMGjfbM8?=
 =?us-ascii?Q?bs6o8FJHydtH7e9FFZNtEpYtXK/G56v92T+KK4hl9TEFiZkzVYBE5mM/BwxT?=
 =?us-ascii?Q?a9yifjfyhz7/zMHf4qJTqVyf+PxdQnbacfucWrqQBKbWsiYmihj8siXlKNZo?=
 =?us-ascii?Q?Ho5Rj45K7my+0KdogU9eArvNFT39t0wbc+938eIMb1cf958c4MVBxd7XC0d4?=
 =?us-ascii?Q?u/T2lLdrm+rK6FTWUc6yNYwf7OOA9yOF+eOWoRkj1m2O6Qg4kgb/rV2tGDdI?=
 =?us-ascii?Q?9SBvLOLSSqRrq3a8/0iaB2wVk+2XJaKVx3ttlEIpv4OFOMJ/986ojEaMkGHY?=
 =?us-ascii?Q?PXRKwYg6611g2YwefVgMQORH0n79mR0O70IrSgP0EBIwdIPIq/IpUmw6Vl7W?=
 =?us-ascii?Q?Lt7cTaPg/OKrU7g/t5tsXlrhPu6sW246OaSJcwLBwRMtuFILQm7e+r3ru8l1?=
 =?us-ascii?Q?tTBUuT4+47aA5Of5lNTIjhHkPRgcCTZu4X8fwz3ztTcWw/w9nQc3wAJgpEG+?=
 =?us-ascii?Q?mKo3fMFGFpJFpwJQxPrh8zwKELCRulE+YZ8XZ/jAwv78NR3QRRHIbrvJBrz8?=
 =?us-ascii?Q?DjjH7ibfvbA/2ANU4KEYwPdFmUIFSQ7ZXtMGDXWCb0zLyDPkoN9AEb+CPDy2?=
 =?us-ascii?Q?QtHmgRnECa1QWmaTU3yPuqoYRJCiPlmdghn6BEeO1Se8Y5hphvKBg/8FiMMW?=
 =?us-ascii?Q?XL5NOUqxXy5s0uENUcLQw68vx3c4Qv57Z9+eXGiAXQVNFHnPTphtqu5X1y7e?=
 =?us-ascii?Q?PW3fMlwSW6Lt2Eyju+BaXMU6wTxp8FW/n0LPVJc4ufzAb9fyfGiXRj+IBcE1?=
 =?us-ascii?Q?DE5aOWhsDCY4BgJnqFslrum6Lb/QvpcFQqP804H3ED/4Tm4sIBtKB0jcqPe6?=
 =?us-ascii?Q?k6+SBLR/O2Cz+SnC9yJEpSYd+nlIDFB00zXCEZSHZiVPgVzBJOMJFTwqC32L?=
 =?us-ascii?Q?jrGlUEoXhGtNQ1IWGsGU3Klg2dyCBIo2yiE+XUW+lC0wNBrT9P2Kh6lBuM9T?=
 =?us-ascii?Q?kmx7R17iNgkIFOjH7pC5uAx6u1AEFyWMbcfLQEJvAOdBdpmLCv3m+/AcpUqY?=
 =?us-ascii?Q?r0qAHP4SpU1Fp4i/51K91cJsmOvn8lJPW5zipzCPH7PqKRNW/zfc2Yd63ajA?=
 =?us-ascii?Q?uU9E87FZFD7roQxLyMvdhqUjcQqaJ4c3T35HgDNjf36UIaBX7QnOmcWhHj5D?=
 =?us-ascii?Q?6hDPMXxi8UYFW6rbMrSnQanSnGaDKWf/pkFFX86KK+h/AW9zwR2BKtgagSpV?=
 =?us-ascii?Q?K0I1bhR2DdUMOy3beOrRx18/gDcfW+9ie9eBjVIOanfi/zqE7PlZhTxXicrm?=
 =?us-ascii?Q?0clx5UtRQLdfVH4UbpzOcxCyhlZx6u/b914ENdsHkrPI18XDkZyj9gIJWztO?=
 =?us-ascii?Q?RzqbyNm+yprNTMEukjH6ZdzQLMEn7Iek2v3CfzEWzFD0quSKfei2awpWnFBL?=
 =?us-ascii?Q?2NrF3dka3YziaWNgMWL1Svu/58cBBCjHsoVaeX7l4DcGosKX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6f9fdf-a3aa-4b6d-dc6d-08df2c43701c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 11:40:26.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sddnaeRRz31Ay4rfuV65PL4hXS41uvXd7T6XXrvZm32mON7rLsDvic/RQJwUy2r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914

On Sat, Oct 17, 2026 at 04:19:20PM +0800, Shuai Xue wrote:

> We tested this series (v11, backported onto our 6.6-based kernel) on two
> arm64 server platforms that differ in how PCIe errors are reported: one
> with firmware-first reporting (GHES/CPER), the other with OS-first AER
> plus DPC. The test triggers a kdump crash (echo c > /proc/sysrq-trigger)
> on an otherwise idle machine and compares the capture kernel's dmesg
> between the unpatched baseline and the kernel carrying this series.

Thanks, this is a nice description of the challenges server type
systems face!

Jason
