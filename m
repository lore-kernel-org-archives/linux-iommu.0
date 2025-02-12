Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73082271824
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365177; cv=fail; b=gp2ngUozG91gpCdQEptFMTE77cNhyxKU25IpVOc5pmESG+GTd0IzQqGGl5MqXrEpmJt/xGbdLuR1iW+Fv+y53d9XCK5nmKeIUoiQC/OXm/wEOnSkLWWbFHf4vFxyoKqEAkCB4X6ymOFAka4iGG0pi7OI7Vsm2YyosjKSYqgdNWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365177; c=relaxed/simple;
	bh=Kn2JX3tVTCNwaVPIgmUgs6Rnowbp4J7GC8UyDypcysI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMay0L2ZVUfvR+M/JpkEWTcFmYksezFxQycVUCSwP2dX+vxr+kLQpzRogLpY2kHkW8asB95VGwY0EtvQjHtQMgXFL28sLAxKzx76gNGoxZ8U5UlhONBfGeuqMZXnpLWOgDctu1cdWoQDroMVig+iHA03DPmecGfGa/DD4kkwu80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nd1p09F0; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nd1p09F0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxP31wBrVDQNBjxmtTxUlEWJ6jo8eUQoJWZ2JlaJ63KLUYqwCIW+lAfepzhDo6wrZT2xbcps+4oW6usXcwy1BZhNSwcggwRfdrXh+uQU/bCih8cRGVd2ibOVjai6puCDJSaEV/cC8ux8LkQiUj54Fi9R/99OfFVO3Etz55t4vq21izbpKGUh5cFRnBe62ehbNrZkrT7bYPJgyjRKZOb+jk3jmeg1JM980VrA7FvRd27AHK5eKHbha0W5WnGR/MDXcxiAWz54WjKnlb8WuLzhZbvcHOrxFtHh5ZBloOjUfAO5HZ9E95nY0y0zvkwGnVtuDskrZeBwyNku15zZkoGj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn2JX3tVTCNwaVPIgmUgs6Rnowbp4J7GC8UyDypcysI=;
 b=ar5yMDNkIke783zxUCaEzCmu8nuWeSTYYUigtFrectLDcVbFE5hU5mhaz1NiiLK1eTT6DMC9nYXX1I+NRRuf6vFT6FNunHZ/sZWPAmmUxtA8wtQeEg8adtY6tqXK0SM7G3sFiOKsgT1KiyzYH8UltY6+h5t2U4YVA31TLSFXsv/AZ+FydBFdK1WoYdj3riwPF/9hPJVHAsrAA94YSAeLJoYCLfuSEDCWhRZmUGL9FAtL4jXJlcndsALtKKOeZftsOh/z78SXSMsLkj6qCA7PrwkfsZlVJndlry3VRaTD9u+iB0mM36c3Ijr4Kw/rofQ30S41shwFGUebDRTzxPZNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn2JX3tVTCNwaVPIgmUgs6Rnowbp4J7GC8UyDypcysI=;
 b=Nd1p09F0iCX3jXZirhEk/hCQXOm+9y/V+tiF4vEbgupBapk9FrTCSb5/Q4EHRhoGSFAoy9BDuHVmps/MMaYM/X5rmkEfi238/Ee8uVXaAQK6fPG0kNJV0JC2yB6sR6Qx8igbLRAsJ/trZnSh6+ZbI/4eu04EnN9QSg7taRkgdA+ph3vDrg16l/0Akz1ohOXY9C/LqxQTmMCs199RjKotDe+IpRhFvMZw3MU6cNGe5tzKBMoY02RNObcowGKlSsXsvAcB5/oew5hGS8iP5ltYUHMGRcmqAwV6q7b2kOsc6cmg+7rXfXJneyjqdFZJhgOAnEcgkWVVAXcxpbCXCdylsw==
Received: from IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 12:59:32 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 12:59:31 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 12:59:31 +0000
Date: Wed, 12 Feb 2025 08:59:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	kevin.tian@intel.com, eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Message-ID: <20250212125930.GQ3754072@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
X-ClientProxiedBy: BN9P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::10) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	MW6PR12MB8663:EE_|IA0PR12MB9047:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df67d5e-9ac0-46e9-1ed9-08dd4b651771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zmbrBxa3vBs47Xk4RFnykH8RKPkkx1l6xVjj+Xh3wXUDnM10kcNUw34cm2bl?=
 =?us-ascii?Q?2JkcMP5mRhCiS6/Xat03ig6zoYN50AgGP2WygG4Hgx2s4ekyd7RZUO2DVz21?=
 =?us-ascii?Q?xt6nleSA3x158kN165iYrlJVGgs6Vv8EeVGzuHz1ngpxvI3RXRuy+tVzVKjg?=
 =?us-ascii?Q?1DBerlC9nNZEGAVkpl9pSv5oBdHsN2Exd96q4l8Gydc3aPgudaqSpWxbR8P9?=
 =?us-ascii?Q?oGf+fxfSwGuualmfo4P2tSqYHflxO+MaatsKIv3aBiqi8nGUubFZ3JxTKgE+?=
 =?us-ascii?Q?JH0sqszG9DCzZrsYCbYk24gJCSNTWZA2mND083E4zd5HL7IhR0BqxFpJr/rr?=
 =?us-ascii?Q?/W6M9qddNh1UXIvU2AiURjNHJLQHzEFlOfE13bCoaI1BkszofHYaiajngwZL?=
 =?us-ascii?Q?jWbrq2zwBLa8xuGDVt+CG8dzN+rzpmC3W9ScicVR6NyFTO3LTHbWGUDr43SC?=
 =?us-ascii?Q?foz+CzQ/pIvtbKtvekZwa3BcQFokATKWwjhX8YqviKZz3yedFOH9oPgdKHDJ?=
 =?us-ascii?Q?s6dxANsMubnknekuYbfpKOTtOswc7GkE22T1Sc/kwqYAtavvPXrQhyXzuL55?=
 =?us-ascii?Q?D5THrxZAHyxCmlFC5kiFpwUPbogFhB5dymit4veu/kODEHJWJn9lb8Yhg6ft?=
 =?us-ascii?Q?MOYaKanSiVHDvtFs+veabMNu+fSreGnFxEjJJDeX96RDmAVyFti+Qd5VGEKR?=
 =?us-ascii?Q?6buRkOgnE5zNq/QcHC1SQjh9Id4pS98j+HqCXQ4fBMOuRXPlqHCXOIiKp77p?=
 =?us-ascii?Q?LDzte2pSRFTbRwtQ0MAhRGesAMCVcgtCOseNXd3/1a9AV3NzpTZDC5Vvkrlh?=
 =?us-ascii?Q?i+CvUv8/tcFFnRXgcTP1BrEZx60He+vP2Z5BYEz9ZDpziOypYxKO9/1BXuRy?=
 =?us-ascii?Q?CaWBNTbhr7QUA+2lVrXkC7xq/bCwZxa5j+gVD0/D1hZIIvsfNsH0mrNerBOm?=
 =?us-ascii?Q?iAn00VicMXi0TPq31GsDO7qE1hPZVN+oh3LaKL+ftLeXwmF5dUIheNDbTmRZ?=
 =?us-ascii?Q?N3NHgbHT0huN+DdBjhGh0P6coMVrsZLGo4l9n8fS4LKYuzxEEvgzBsXSMqpu?=
 =?us-ascii?Q?qsdD/HsK5pbWeHG+GySP11xiePZVyXpCRV4AAGSkqTNspfX7E+PuogqXl3LC?=
 =?us-ascii?Q?MzFRaJvR0quHk6g1vZC2yVcP2dQnAFL2W0iV12E2dax7tp6IDeMEkxG+yr3Z?=
 =?us-ascii?Q?1zFdmt6CccVxkAUgz+iYCsdzBg3Uf960dmwzp9FRsER/PMqrjDgBb8C0eNnL?=
 =?us-ascii?Q?zipWmTM9ey2dIJSUegxG8XmKRFEroXjTJxeZVuriSWpnSbG7Er67blzKMbGo?=
 =?us-ascii?Q?ipnR8kZCq/escryaWyZkMs45pKIu180ikPMyCenAJmcI5dolyfTfyeNexfFI?=
 =?us-ascii?Q?DWBSi0ICGlV1TdBhzy1SCwraWeUM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB9047.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pX9IY7XHzL/CBpn3+xdPzheVPTpYMlpC5mdc+Xol4rjoaQkqC0W9Q6W6ZvuP?=
 =?us-ascii?Q?W9m7nnx3PgP8SMYNThV6H8f5z4zSfMYHk7BhwVn/qeWj4txujZnsmpTJ5rwa?=
 =?us-ascii?Q?MJZaxj9hYU63CwlEmOFRqKyTZ0/1wsXNPy5DO+APESk36kTJkWqxcroVlAnG?=
 =?us-ascii?Q?Dz5cr6y0lfYlpgLKo4huFwWguVIR9rPP7e5Fj6PIsd45PJYm1qFUY/oO5UVH?=
 =?us-ascii?Q?UGNIFly6IyGTvhuPPgEj45MzYh1Si5EXHUYaJ/+nyaPfCH6bDLNTwHglDo7y?=
 =?us-ascii?Q?1fCvkj6MsKIS4maBUC6sllrglsTgEHf7WO18+K+xD4db55G+nqdX2zkjh5m1?=
 =?us-ascii?Q?zClqcZJbPEPxuLejMKYSqhYx0alYjC4UOeGgPTBSDmr5iO6J/zmCmYDRwMgO?=
 =?us-ascii?Q?59d8Y/2dmoZM4nfKQYtaonT/j/ylOJLKMfzl0HygBoFwEix15u3NO/n3LRV0?=
 =?us-ascii?Q?NilS5DGPqpmB8iCsUgsU63nksB/IfJPx+1D2TIRvJvX6S7TOlfBT9mMPRajP?=
 =?us-ascii?Q?NYbP61FL9uIkGY5bPO6okrWmLWHsk5KtdIzMKMQrTqd1214JD0I0n3SGPZIp?=
 =?us-ascii?Q?wb7BskuWVYxAmUBz/+I8zE+KpCl9aFTlmNGwBngFNBQl6hniIw31btpFdFYs?=
 =?us-ascii?Q?fk39IVviyjfiulF4zWZlDTa9caIwuxtw7g+ijpKdjEfhXIpCE4+jw3vXqiXy?=
 =?us-ascii?Q?UoKjETudq9aF6KaQtjfuWuZWmRdX0jUy+8Kck2JfO/cYvWE1S/94qcA2vNbW?=
 =?us-ascii?Q?C76inRdHn7/hSKasZLl/EjhQHckT/KzunWw3s+qdTMS+Eccb7+5P1l5z/EMU?=
 =?us-ascii?Q?bLZ4TlukgP8qP+x9sxnKqy1noOdHDS8byDRQkiOqZzw09mi+uzvOhmm+/Tsh?=
 =?us-ascii?Q?C47UYDBtdeHpshISgPvpBwDKHbMCqeLdO6xP1NPvffYVkXQ6e5JMnGkgj/Gg?=
 =?us-ascii?Q?h5K8FCRf75v/S7Fd1ZRMm9ZdNtQauGTqoP8t/Os/0/NFMpfVnzQfPzIxfysZ?=
 =?us-ascii?Q?B2ryBi957fgRoghlcy9ITbPedCMh/w3mVG0my8X1nkw3gUatIQezVQTNsd6h?=
 =?us-ascii?Q?VHws+DPGRTdSPPYOzcBzxHR4Kgvw5EGURXi269mh0JTqD3TbFCLG4ypoCH6p?=
 =?us-ascii?Q?sZ+bF33Xa+daBgU1mvbt3tRVg3Df9Yp0g1TPxgqMVcittN80E6VZWxg10NX9?=
 =?us-ascii?Q?xZLd4Qt/6u/QpU4bdeU+FxARTxYL/A6YDCzwCNxmYBqPnDS3ssKF9IQivQaP?=
 =?us-ascii?Q?ovLYOxQbkJxdGWGWB+6c7uWzv18rinF4vGhjQpx3k9vwG+7mZLWb//TMXks0?=
 =?us-ascii?Q?zpHZ/Ec1MpTJt1pnBGF5MM/U+hUnWN8XMZ+bbSecDPIJeTaost+85OV9MmiH?=
 =?us-ascii?Q?KG6t3lhPwg+BTHeF8oIz4cNE+17gs6+zOd1sruNeNcEkXCGUG1+qVPFHeXA/?=
 =?us-ascii?Q?4Po+81MEB7M+LGkMJcV3/koBxODNSD4hkZpj2MMa37zCb7xHcrQAzHLOOwfx?=
 =?us-ascii?Q?6JS0j9msL6mIZK0L9YsJKvFSayupALD2Ed2OaGyfCHZI+PyxRtPmd5Qa9LUO?=
 =?us-ascii?Q?eh0XJAUUet8j1Xm1sBDHbNxL0GbjAvK/FwZN+Zo6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df67d5e-9ac0-46e9-1ed9-08dd4b651771
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 12:59:31.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VN+EMXZBtoUP9vneY4Ee0EF7KmtFB3qwZcSDfGr/1ytD9fYL94NHUYxcgyDovMB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

On Wed, Feb 12, 2025 at 03:47:57PM +0800, Yi Liu wrote:
> Let's consult with other vendors. We need this enforcement because we lack
> a straightforward method to distinguish between PRIs in stage-1 and stage-2
> under nested translation. If other vendors share this requirement, it would
> be appropriate to implement this enforcement in IOMMUFD. Otherwise, we may
> check it in intel iommu driver.

I do expect HW to be able to distinguish S1/S2 faults for the purpose
of PRI, otherwise you cannot use non-present pages in the S2 at all,
which is something that is very desirable.

Eg AMD as a GN bit in the PAGE_SERVICE_REQUEST

ARM has a S2 bit in their F_TRANSLATION/etc

IMHO not being able to do this is an Intel limitation (that you should
get your HW team to fix)

However, right now there is no driver or core implementation for any
of this, so setting up a S2 with fault should be blocked in the core
code.

Jason
