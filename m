Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482634CC611;
	Thu, 24 Sep 2026 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278933; cv=fail; b=p/+7QkXVTeUGAd1JR8Rufh1LFKqfHmY3H0VGm4Mb2JwFQUipXrPUF9dq1vVIYuq5+YM3fpxlB/Uq2ArWpelHD0/DSlou+MdWWCNj0uIQgQ4VI3PvpNn0LcGBkRbDLiLH2kMGm8qkrC6L/heZr9KOBWdoQV5nNzkYJd1WLVkhZOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278933; c=relaxed/simple;
	bh=naofvP0tBlds+v66Nv8paG1cl5ddMuUR+Xm73Y22CTA=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=OGD3TzWnxUEKMUNgKf2exjklXWdIUpaqH2lNd3pAgF8ziPKh66YcyvX/yuNiyqe0KIKGyRyv4zNBcJgdVhEp09AghCAJYJFlJTwUA9SBW69+eqIZMjNrA/oCZ69qB8Ofd23trHK6gbG6UIuKG9wm6hLKnfg1O3yLcMJQ8IW4x7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UyXJ9u6t; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UyXJ9u6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNsYx5hv62y0+/sDjWBbaPl3HZ96sJInJRum0qby6eTQkbwpzWX1sUZ9Dy9NW3uDYl4tFeke8Nt/V2uz5OYsMzT96ni2juQGW+X8kO2NRLSrXrtVj79QBteZVccq9eAIPCy4pzSBg4jewjfR/IjSVq8LQBLOX4tbmElcht0EuUqGocuTyJ8qKuPxcj1A3Hpso1YwOcMsjxFNZl4VKCj6TZUoQKXPDfweqqT9xOs1lpslX7OoOwGdZbtogUlH1zdKKkJpVos3VKB0Uki9CCPz5C6EwmbYBQ/ZUXnQFpyEG6749vAwqxfQhlCcyGsT72JrjqF39QFc7M1dEjeoFHempA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdMU1tuBK3yB0MlSxP3E4Ty42n6VVEtMYMhZc/guyCY=;
 b=XPRPh3R0x8hRmODm8th974Q3tKLHuc62axkJt3Q5sq4jC8gVC39FiLXDSvQPjtbv10p3nGWcdN/4bSlN9CXioIkFDJkIgIKDGtOGG8r41lKMXK55NGgdJDDo7sTqWh234BfvcdPM3K6PK9YoJ+Eig0S4mYGOVXIY5iRI4639uELK7dnwyYPgOaafoayv3FgB3KEyFsw6q690aEMNcxlsVo/fYUAqJag7a32cXeDzPrJa7xMajYQW0jUWpX2CkQU/5EMuM7hBxWQjgLaI5WaQ6+8cbiDhQJJ3baxRGzY+vtdPShNF/avr88qoAf7MF7dQAGG/VZWpz1Kf8P0eL6FF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdMU1tuBK3yB0MlSxP3E4Ty42n6VVEtMYMhZc/guyCY=;
 b=UyXJ9u6tgo27zj192Sz+8pe9J002r3ypypaAd5Va+tjRUWzHmrDg0HWOPpQx9mudzFoEyS1G1sdgjm7LZ0rXuIBHMZ0E8B/RxLZBmaexEfnwKEC+LOW6Ue7lUS2veN2a7P/AHvoHOuqpxTfhU0ZIqi3limu9pQmBUGmhUxk+A/mFx3pnws0tLoJ5IvQVh0SNBKzqqdslx3hmEbSYoE62k0VOQJiHWJMa7Za09O8I2dagshPJR7Z83iBBJPU0Ue2PNNWfq5yk81TSBb89n3YaD+m6xyJ+PsFaFIkS34cs1zZion17KFedhIyttdPT8NU0tsUnQzQyZMAlRFPjt5QmKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8854.namprd12.prod.outlook.com
 (2603:10b6:930:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:41:59 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:41:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v6 06/11] iommu: Add a helper to query vIOMMU
 hardware parameters
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
In-Reply-To: <20260917140159.1163281-7-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-7-aneesh.kumar@kernel.org>
Date: Thu, 24 Sep 2026 16:41:54 -0300
Message-Id: <179027891417.104879.9762824167936334166.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: a27c3a22-135e-4579-9692-08df1a73e4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	P/JT8x76rkZZ5gIt7PYvzYXbbeo7FGmojrqWdzHKw9x4mEyBD74dLC9TJfWajJpg+ymiN1dORXz8TZB4QoGXgPgPerPzYZ0cwhwgwxqXr48VhDLJ4TjZ93GDMqgo9D1/tR2UQKBnXVPeHVtf9zscKdr+RnTUjS15W9oIzXZj5SUR1aIVL7WbHjTE1RXiU7PtMRoCB4/6rqSNm2DfHSWlvb+MCjq6JdZVK3OR9N+enDLzwDH7BiJ19Cmctyiks0FLY6fR/lPePylanie02EuunzS2R7juxqADvuKzLX/VXAIDtBlmoTaoQPXlCUShvnyWD1CyKko9GE0VNHcTGoQmCj/60JiVzBZO1lXnZ4JDrGNw2Kt4sUa+Jsp1+TrnUJxIF8bFnQQWnGg8sn38dZlhE120Hcb+mAp+cLhi/ilcwAEapWxRKHBD6I/AouirW8hK5uGUlkRWOSppZiVyS4FxFjXAi9F4F4Vc5EFvIM+H2hyBM2WQf2ouiG3D6dBg/YF5ZC/ojvBh0TBVVDUNar0ZdzWUPzSM/tGniVlT0IRSlkoxbyY2AOj2fHGXyLJo4cubtQDwTFNPjEm3N2gRx8o7ozWzeGNGlnN6z4mBd4BXJuImJSAgXClTYvsSJ0H0pC/s6z/wD+boi2wAG0TzYiENO2+TW8zB4VSl9JD1PSDptK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnV4ZS9OVnBlVUlhSDZxcmgyTSs4aGhpWW9ISXF1SDZMVE5EeHVVaEJzbS9u?=
 =?utf-8?B?cmc4c3JwZktaR2JYdGtBc2libXhFcElzTXRYejV4TUd1ZW9xbjR5KzdxYStH?=
 =?utf-8?B?cWJBUlNhYWxFUDl2UmdBK3JXaTNUeGpWY1c0bmcvVG5jZGJYZ3JkRE5WK3Qx?=
 =?utf-8?B?TmV3U25nQ0xBbWdpbVBzRUVBbmNLcHFMMFFyQm9lYVhqSG5LL0o2c2JMWVAx?=
 =?utf-8?B?emQweE9nZWM2MWlEbUlYWlRwYllONnZqQzJjeU9Yc3VSNXZiMkFnei9GUzlU?=
 =?utf-8?B?TkQ2UzhLMDJuanI3UDNKU3hlTk9ucFdzTjZha0ZIclFPQXVBVjI3ODlycnll?=
 =?utf-8?B?d1dpZEltMFoyaDFjVmpqUHJOV2hTdjhSN29TUXlnVlZZUURnNHhxS0dIVEVU?=
 =?utf-8?B?NzhYV3ZTc1RVY3I3elN5N3hEakR2dTZUczBzdTUzeEV4VUpWV2NnV2pVYUR3?=
 =?utf-8?B?UVpUS0JGV3JhZjVMamlYakhmaTVRc0ZhOG1sTzArY0h3M2ZpWGJDa2VvWjZS?=
 =?utf-8?B?U0JoOWhSQlhkQ1lHVHdTbGpCU2tVOTQ2UlJvSStxWnUwR1ZJNEJudVNHNkww?=
 =?utf-8?B?VGJZN0hrRkk0aXFmaUQreXdSOFA5dmcvek5GV0NJK0Rnd3pZUGNyd3ZYcm56?=
 =?utf-8?B?ZUc0UVBLbUt4U3NvZnZQS3RQcFBDWnlkUzNXRXhieFB1NmcrZlRNMXg5cnpn?=
 =?utf-8?B?WjhNRkRkelV3ODhKVWxrazdqRVdYMU50VDRhQi9WMUZRYVhHNXd2WFhORmQ4?=
 =?utf-8?B?YThBdWtYb0RCTVBwRXAybFpsSkQ0UGZSaWthWHVSS0FFeERrT2FDTnZLUHFo?=
 =?utf-8?B?TmEydFFaYjFXVHBVT2JneDJSa2kvRytla2xvY0pFdjBjVDlzczdETkdHQ3dP?=
 =?utf-8?B?OTAwRWFhRjZIV01vdUExbXFVbnJUcjB3Rkd5TW9pREZ4bUF5QjZKM2NQMnR1?=
 =?utf-8?B?OXBXaTUrOTdPS0l3bUpvUU1ldUFaSmtLQVNtWGxoM0dqRVJoa09jQTJJWHlo?=
 =?utf-8?B?M0MweHZ2MkRMZ3BwRnAzamRNaCs0L1YwZVcwOW9WZDQ0UlYvVWFxMFlCUjRu?=
 =?utf-8?B?ejZJZWJ1OE4yQ2dTR0NSWnFoYkNxV1pBcnpkeGdvUUcyK2c3Z3FGMEx1TUNP?=
 =?utf-8?B?OUZKY1VoVVRPMWUrc3ZXdTkwdWpwTjBmTjRRRmVXTjcwQllpeGtEQytRODZZ?=
 =?utf-8?B?Ulkvd21YeG1HbWw0MmlyOGxWL1h6djMxWG5VV0J4TmgxWlZyekJmamZYVXpk?=
 =?utf-8?B?bGI3NWNVcWxNN2s1TUpNK1dZVVJnbDdwQjNQd0Q0aC9TWjNlR1RXZjBWRk1X?=
 =?utf-8?B?UWhFWlhmdU1LaUMyZFlYY0dSaFhjK3NtUWwrNjJ6WDhSWjFlOXpWS1lzVlJo?=
 =?utf-8?B?dWNjeW1lYThjbkVpL0wrNzZLeDVTMjdiVkVYMnZ2dkhVdEtvbDFPUjM0bitt?=
 =?utf-8?B?WFlTeVlDZUpEdW5SazNyVHRhUUdVVVBacGlDcTR6aTVPYUhTbHFvUXUvV0NE?=
 =?utf-8?B?TnhUQTR4V082bDRxck4vMmg5cGZTZ3pVWC9OWGxaK0twYjh0NXNvWXBoeGFz?=
 =?utf-8?B?b1NabFp2L3FWdEtRY2YxV0Yrbm5KMW1LYnhXVThhVllBUXJpNVByRjFOTnJz?=
 =?utf-8?B?NXNaY3FYRmhQYTJuVHl1RXZGNWljZTB5RVU1aXIzd3lvSlFxbjh0QWFmZDQ2?=
 =?utf-8?B?dGd6L1MzWFIzMmEwcFRwZkRpSmZzbnhLOHRERGtKblpHaDhFSi9uYUkyQVNs?=
 =?utf-8?B?ZFYrZEcvaDZjUzNTQmhzMlJ3Ry9QeEZHSEo5QzBEVHlCVFl0SWlLUklsS0M2?=
 =?utf-8?B?VjdSSVNwL0VsbnBERXMxVldmajA1djNha0M3cDZMRkxTYnhKYzNYS3h2TXBI?=
 =?utf-8?B?elJDNjA1SnF0Q2oxalcrUVFCZUZybElabSt6QjZodmFMdlhVQUQ0U2lIUlRj?=
 =?utf-8?B?emM4Q2VrUnlKdzF0ek9IbHNKd2VGWUpGby9MWGlzd3FvYWZ4VUFycS8xSVEz?=
 =?utf-8?B?V2VjdWlJbThyYWdJTk1FUUdJWE1ob0xzaVFPZE5qUDVORklsQTZxVmFaVU9q?=
 =?utf-8?B?RU05UCt5WWkvR0pUMTJUK0tydktYRElZcHRGa3ZTS3UxemVmN2ovb0FiRWh2?=
 =?utf-8?B?bjcvT2VaT01teHdlaTkrMmgzTmVEWWdzR2tBOE9hNnhwTy9YTUlNWVY2Z2hL?=
 =?utf-8?B?Q255OGhYZ0N4emRpd1pRUENIbmVTWUdMRWM2bmREZG85NXo5NVVnb3lBL1U2?=
 =?utf-8?B?WFdrMlp6cXZnRTNIMm4zTmtDNlpFalFvR0lVQnljdWhZT204UDRiWjIzNlJ2?=
 =?utf-8?Q?hjWqf6mKvK3kP8NDUy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27c3a22-135e-4579-9692-08df1a73e4fc
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:41:57.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0rsiydxMZNKENZPkF7RSU29kyGbVYBLH+QwoPn6yVjD87tzzooxXU0ThXXTmmeh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

> [ ... 18 lines skipped ... ]
> +int iommu_viommu_get_params(struct device *dev,
> +		enum iommu_viommu_type type, void *params, size_t params_size)
> +{

I imagined this would be a direct function call from TSM to iommu
driver? Is there a reason to do it this way? I think a TSM -> iommu
module dependency is OK

-- 
Jason
