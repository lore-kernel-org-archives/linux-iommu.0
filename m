Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11448124E;
	Fri, 25 Sep 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340337; cv=fail; b=cS7lPD9GYjAcPwGTIPIx1+avIPZ+2hQv1iKyA/GZdckEbZP8bugbfR+rHXg+CpYtRYR9m89Whc3VezbKqlClvaNJHSYRKRDqgOw0dxnFft9xmF9hPJtYQj/CghH1KoV1iMpGXNj60Or5umQactBsMzaC7cHPKeb0uw7Vove3txM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340337; c=relaxed/simple;
	bh=XWtguhLjmHNZnG3lDVIX13+FzzlXHcQuhUnYAbjpx/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWx1ETO1i97AtXcIw2Q0qKJzZrCCD9P6A2fTAZEB+ks+Kz6iEbQqlHhvI7NXXUqFJ7WWxyJPLJuKMHkUj+/qhBGzdNavhhJhJtKq1mNLiBbitgbk7UDo+6iEcARxZhvHb6xEwF7bUb8h1pnsoDWwN0ZO/K4DoEvzAZWN8R0nOyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iN6I5z6Q; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iN6I5z6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBEZkHKg4Coer+eG/ycNpMDs0f5O7jZWOfkTTa7smHsZ8TfXX8xZ2JoBZQ3AKK91uFt0uxH+aHs0mCyOVHeYdltfA6x6sujpNU7ChfsCHdvR5+pzYId9qOweTW/4tHy3pYqnN2P7y/M16TjIDUz1AiZ3zkBQ3UMUi2otMWIVgmSiCs6X3vN6xmvrYLUdq2jaR+eeaGj2uE7BRheDJJiLXvo0lJwckhPFo8Vav59XEzyrJsB17bqi7S1f6/qfYkh08ukSnuFfMjujnm+PmM8W57SCuM1D31bjxNwZtxwUshKplw6fVVRwGpmcVTnAl928nr+BUnxyOfoeeKZ54TvVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWtguhLjmHNZnG3lDVIX13+FzzlXHcQuhUnYAbjpx/I=;
 b=Ot+zPr2w0bfxRvTQC/uygilJyqlZBaV6vnT8LFOws+Su6pLHk+LFEOASkdaMMq9EREqdYvTG2ubdONtmUnreT8/O27HKarJNtyedth8Ako/XuX5EcjNvbD2cgc+nc3tmgItfVg5pacesxhD4gKuBACv7mhU4s4pHAB4SVzGPdtD6/Se97uogXlSSISeRltzzWHaPoJID8c3JZyQXL9B2UJBAzPmkuYi0BgtkFeYk1M54Ic1dT/0wYBr9t2oS+xhQx2qwAPYFBUYG4wh0JeiKy1s/sLl5UgqB2E2xi0K41xK9M+cWT98NVuGlcnM52NAuWeS43XScN/pbGk6JVfY/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWtguhLjmHNZnG3lDVIX13+FzzlXHcQuhUnYAbjpx/I=;
 b=iN6I5z6QOCIDi/gk8sPDVGv0FCF03gz+z4kKBs5CMNk/GiSN19ji993GuFbKHgAh1jVFtj+dBD7dB/MgLP0P7qVXiQxui1R2vIewlBAOpp2C7IVQDQIpML/OqkIkhXIcsHTlrBgjqKzh1eO/AsryVJd4PTRpoeXSRTdxX/pO2sNGWZtJnJSyBU/n4zQwXyUbYWZebmTKNrIo344T/DDI6HDsUicgenrGOQAHiRcTqJpl7dBbcAfe2eRWxqnrMLldgq6hjZ/0uuRfsVNdKVV0ZcUVJ7rBv+uqTzjy3saNNRZGwebNH1+vUylgol4jyM1K+pD0etGeoVPm7z+iGM2Cxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by MN2PR12MB4173.namprd12.prod.outlook.com
 (2603:10b6:208:1d8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:45:30 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:45:30 +0000
Date: Fri, 25 Sep 2026 09:45:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Message-ID: <20260925124529.GJ9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260924190935.GA112301@nvidia.com>
 <yq5a8q4pkeu5.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a8q4pkeu5.fsf@kernel.org>
X-ClientProxiedBy: BN0PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:408:ec::23) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: ea919c55-88db-4924-e83b-08df1b02e1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZeCBDTLu2cSNHmCF6wVNpj9K343zoUaBcDB1AsNr6w2qbH5EqBYIz7SjdthBBTw5Ze1dq4BccwsafsijRBo+yFxaLIOFOEFKvh0qGn1sntXcIBzKmwI+ZRAH+3TgNt8Iq/sx+ZgY/z50o/Lf0rSlB/gdMlYpFDNf34QUkdQdx6ild0nPhxYqLSBybd/rIpL8OJfntnRWWeAYany+MI9bhTNUr+tuHn+VEbaf4Fl0jSSB7JXA4QOmvQof7dwNFiyCCkZkKTPsTh6PB1ft/Pfwk7HG0xL1aUJ8GXwkFeMNWaJA2ACUiXm/Uvy8t3KEg/ckSgBS97BuzsGegbj0G65+SscK9zoGeWsvG2OTP/gD3jo27ezKdii4HBIMQgcF7bqU0W9kMve5K1+7COyOoObMlvJuzhv1sX61cfYfv3Cs3Dw6djAmX7/Tqym/IGowaf5iTlKGLawFM4CzXeT21DLecYFCqhGIZbHUKkcixrtIYTSFczyoTrqV7sdTMG9eNEhUwxfMRgJOEAxz0zQX5ACvfFZzmzwKzLw62bSsVwK5gTfAs2SI4lFkRMCO581HvfilumhEOUvd5gskanHQLWYUhuSJLqKgPbcZzMjAJonw3viAlx39VGXXMziHJums4/irDkFYsPLS9cSyHdpCjikuNKb7F+E+sylQ7uh5/s5u0qU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQ4ckIKjaAGySYxzUoq0V+qeVFMtBYW16C5WXQiSkT3RZfNqoM4b9QcCmw3a?=
 =?us-ascii?Q?B6nI3KCJFMdeXcRsMZtVjxhBiN/9PcG+YfyaUeVDJyfGy8jSxNjqET0OqqiU?=
 =?us-ascii?Q?LOH3cOI+YGvUi/mgdePNdB4I3iTZiKBwjaOdBjmv7S+Z3QZrbh7B43aB7EuD?=
 =?us-ascii?Q?xJ93KvZfnuHdb35+t2WiSvvX8I21OcZ/ZpsD3k7LK5UZicdVlEjL9dEETMGu?=
 =?us-ascii?Q?wxqFPmpnZ5x99BvBfGbbbCnUHgVaGLdBKgaQjSQ81nMcyXXyTG6ZySi6cdG2?=
 =?us-ascii?Q?EPFTgEwFQVbk5oBxc1Fg4YEvTdhzeELN3fSN0dD+jCOnB2dM0WT5CskIw/y+?=
 =?us-ascii?Q?EsNSKDpkUCJ5hucb/uHBlGi+Eh0b8Gry+hgn9pqQXpYyvuSeJw2OkdG2hyfG?=
 =?us-ascii?Q?93ImoLykHYBLfqYg6EebOYyeHDZ7dGIEhrlCnYwm1uebOHI9O8XF6Ebktl1W?=
 =?us-ascii?Q?FioQRbQx1f481KtF8c6m6ba51EsgFIbqeFzAgNY95ppSWnNRxwTdudxTWwbe?=
 =?us-ascii?Q?5X+rhX/8vASNEWyU7fur8AuMgUT9IFNPlL8XXae+g7BbaTAgvV+jW4Sum0eu?=
 =?us-ascii?Q?oXRxm4ep3GC5sXwvK5wKmDXZQVADhBENeLUb4Qa+9LiiBtMMyKBT98jbz6P4?=
 =?us-ascii?Q?JZkO7lFMOTTc46E20qUI6Cxdofl+Sqhpsm+O5l/axKT+haIUZ7t4O7OUYD6+?=
 =?us-ascii?Q?ble/tkjOh5Iod2C7UaC/PZ1EwdAU7JpleTugRopirEn/ls0xH+KbP4RkkdFw?=
 =?us-ascii?Q?fh9dgpr+CBU2LAzFDVWXBn6hljURL8CZfQEnXhS5arB9b8OME5UFu0muuyRS?=
 =?us-ascii?Q?HdKje2xPWLliNfXbZZ4YWb2f9G/AU/t0z+lz/R9McGQFg8+bAZhIxtlWRg2L?=
 =?us-ascii?Q?mfrAw7xDut+diShRP1nShDJOD7+faiVZ2ZZNqS/36BiR01hL+ceNXL2GUtGM?=
 =?us-ascii?Q?GKS6ylQJvjsgirURPDh2GunpHEe43xZW+gvo22jc00cwWPCVhcYi/wUQyT03?=
 =?us-ascii?Q?7WcC5qcev7cyV+DGsAhB5AWccZ5Bd6gxzSpTA32X4+RjaiRP84G27qFA76E1?=
 =?us-ascii?Q?jtFTThyzmiXlNYxKA4p9KUAuBAH0go9UfvNPUp9P6i2qa2BAGYrg0ap0V7Yw?=
 =?us-ascii?Q?fmk7/eWCw2ePUpYlKG73YNtdq1bUjjfEK5PzWInxBkEdmHWEcab5sYbNZa+A?=
 =?us-ascii?Q?8ApUhB3eHbLkGGhllhfhR8leedPl6rzkCj5dl4Mg1yEMBLOTjhHBfdEPE9CG?=
 =?us-ascii?Q?DxiKinbEuZQgkqspESKP7y+YN7EFI/eQJ18+V83LKYQo0bU6orGGSuEUkbC2?=
 =?us-ascii?Q?MeMvsqRkp5iQUo0QOBiLEPBd2A6Ru3OFRrmeSPQ+Ws+3rZYTNw6prAezu24H?=
 =?us-ascii?Q?Iwt0tU3fCDMiGM2nDcTAaFCCCcKBZk8YFH0I3fWqs03nQ+pX59Fm3YvCJPMi?=
 =?us-ascii?Q?RronYbkoNM7zn1+31RTzkatI4RQGgjlz6Ou9iZ6iNJWWfKvKsn54xUX/09jL?=
 =?us-ascii?Q?vi+8Mv2Ha/LwjhVi1FzDLzhu+ApFMoEjMqgmrSIDaNwDbCkdn72Gsnz/pFL5?=
 =?us-ascii?Q?lI/JzjZsD/5k+YodLQYsL3QLDYmi6cM/7KOHzFT0eG0OFceUxkSzTzG5Bv4X?=
 =?us-ascii?Q?EyPmIYJUDj/VmQElzNK1smJo7TE0ah0729HvvJGDHbmSqv/BdUAzKdHqYoE6?=
 =?us-ascii?Q?Qo0CsJ+OvLkvVAUkve/0jOKoAvJ54SxBCzIbr72wmIxr5cSe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea919c55-88db-4924-e83b-08df1b02e1c3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:45:30.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsQNG500Dej0M6r0q1ytdEL6RPn19R3b9wiPS7hQ4TjQZp4o9+A6XZw4jzz2e2tU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

On Fri, Sep 25, 2026 at 12:16:58PM +0530, Aneesh Kumar K.V wrote:

> I should be able to split these changes into an independent series on top
> of upstream. I did not include a base-commit because the series is
> currently based on other CCA patches, solely to enable testing of the
> complete stack.

One of the things I do is have a repo that is just full of other
peoples repos as remotes, and I fetch it from time to time. So I added
arm's cca repo now.

But this means I would have your base-commit so if you send it I can
use it.

Jason
