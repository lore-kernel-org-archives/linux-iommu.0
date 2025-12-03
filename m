Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C932DC79D
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758697; cv=fail; b=Ywhq3fFOWeYg1QSjreO2FSuWwgoiXzuo65ddoHwr/nlVuX7EGbNN7x2eKNpBj68ccMosWXbF/B8gE9r32LOwpqIZGQQQHgep7pZFgtusoP3uSGml+qPpCsqqxoRYzPG2zU/kCO7uoaKgRm7T7FWcUWjlUntKKW2XLhaYvhBL3pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758697; c=relaxed/simple;
	bh=Q+g5OIvRYKh8zTTV0hyfr3TP05Z3qMXZWQROxlMcb+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HIANFZGDWPSJiFYXrIJnm3XI8PaNZyahOq1KZtPfbvMr652QMBstCKCP6RnhBc5Ej7hy68UF4jxS2rTc2cHy8yAjTLVeqW69DCV1OznN1V7RabtPfv4LgYEHzuyi4cW+cFiqjAv/skrOiMs78wmW3uli9KBSZKkeA463BGHA6uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8avcH/3; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8avcH/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIvCqNubYYDY0aZjMUI5rzz5P4kMk/ZjBoBv7ozescqiHBZjFucTjCoULFLwCaClZiCSJOHGA4qhPeysnjSAcSipOeQDpINkcKxhbGs1LxdkWFhE3jTXMmmpe66oOXMHI8Njg7Sq0P877zZnbQO0fmQgnBhhYGBSVr8KtsrX9myOiV8JCJuC/1Ab9VX/A/Wk7yEwBs6Ow7UD4pEqfB2TnSgZpz5AA4Ro7LfJF+5uhg4Wey5SdV3Lz97b4dvInuM7roLTKtYqbIQVtfUx20ccu1xGU1qQ76Hos8iY0ywP/6Hbv6mPhoMdoXfXl6fqTjVa+UmvH4jpFdybFSbyWHoQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT3DO2Exp0GQZmbwCgTxZwzFCDI6C1nPOfFF1Es5J/g=;
 b=PctvXfoIURCIY4QBJ/8x+ms2fchUHVpduqu5cu9WEYpY+L18PrMYqSPhQAV4a27GlkPDp/WIAkc5+JPag7xdMhzn7jt7zNrlxCgKnpJ3XpwhyRqmNwKJyP4Kuv4LsN4wQv9VLh908so8xVDWiFn4rTh2+/fszAkszxOOlS9zlT85foZBW/da6DdSvJtiGVkUeI1KRaAksWBoUNLijD9gzzlwXGsckK7xzoTISS0ORnR61dwaCtV6xpdYr7vexc4tcOf5TZ4iCJalB8S1Sh3FwA5KL8oJv4ikOZCLpyznEjr8wN4ZCZIEiNo42sPygi8UrtDxD4FQLsOoih5UCcmJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT3DO2Exp0GQZmbwCgTxZwzFCDI6C1nPOfFF1Es5J/g=;
 b=i8avcH/3LSVWhWVQpwy5fiQLD+phsS2NJNcznEYijGbZIFZnYWptmicAn1Ux6ybCFfFvJdFWBln0s8fNpy49aW5IRrbSEqVBVVitBRorgKU+iTtjFs3JSqheK6a0M43ilqTCYF4bp7BKsvkQOCGTHS3jAwMr89MoO9v6mrqhO0SyHYSa69gx9Xv7JirNpwaJUYonf+zAQBi0HJBZb1iGOzngb957HNIQPTNsZjTQI6ZZkWfP6twtI9FtKpxwOJ0F9d0lmSl2oPHsWdlBVq8HwjYStdljMOG0FyBMtkCti7HR7weRRG5cSVbXqQmNWud3TLX9OI9GIKWnxTschqYg1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 10:44:50 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:44:49 +0000
Message-ID: <516f57b2-cdf1-435c-8de4-978ac8b03f62@nvidia.com>
Date: Wed, 3 Dec 2025 10:44:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] arm64: dts: nvidia: Add nodes for CMDQV
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251201163219.3237266-1-amhetre@nvidia.com>
 <20251201163219.3237266-4-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251201163219.3237266-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7e5211-969a-49df-8a58-08de3258fbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1BUYXFpNXloS0hlNTVUQ0ZoSjNzRFNIcFpMUHg5cTZSOUtNVGlORkJrc3dM?=
 =?utf-8?B?eFBUd2d2cUxtY1FqNHFVSUwzUGk1bERUUE5JeXBwMFh6NXFhODZxV0pJYlRu?=
 =?utf-8?B?QW5mWllySVlaTzAxZHozQi9nRGt2WkNmaS9UT0d6M3haU0ZuTWt2Q3hUTDVU?=
 =?utf-8?B?dXBsdHQzY3Zsam1Ob2JZUHRHV09ycFZjR2ZqZmdZeWw1ZzBWNm9wRzVCWUM0?=
 =?utf-8?B?VGFoSzJSOEtlSzc3aUNVUXMrUHFZL2gyVkpZak81SnpnbTJmbFlMMjNKV0xt?=
 =?utf-8?B?N25IeGRwQ2I1Ty84bXA4UHl0YzltN2ZadDJkT2M4eThaUU9tZm95M2lwZ2RY?=
 =?utf-8?B?SzNkQ09NM0tHYkhRY3hUOVJRT0liajAzQWNVSVJ4SXdMalRtb0JvQjRrMTI5?=
 =?utf-8?B?Q3ZqczNkamU5VXJXN2pMRDdWOHhxbXl2dHgrdmJQbjg3OXAySktlNjg2Z3Ay?=
 =?utf-8?B?dENnYWtTSmpUMkY4cU5rRjFJYi9KNVpkZFVzOTNValViRlIzSGc3MDA2ZUF3?=
 =?utf-8?B?aEpCUkJ4MTVwNnJsMXh3emg4Z1VOL3lpalNOanRGL2JhK0lrV01TdzM1Q05n?=
 =?utf-8?B?SUdralUwbTlxcVJkSUNrV3ovN2JGZnhVZnFRaGJQMW4wV1NtRWJHa0F2SU1l?=
 =?utf-8?B?WkF6cCtNanIzTFhsam5NVDJtVTFyU0xhNndVbWpIeDJRNTMwQ01zMzVTRm1X?=
 =?utf-8?B?QkoybEJKYkQwb2J0bmZNZEl4SmsrcEhpOG5KcGhoc2NsVWhpYk5XczFqNmZZ?=
 =?utf-8?B?aS83K3kzWEZpZDFFSkpFM3dlV2kyd1U3dS9WZS93SEY0N2U4R1NxeWtHWWl1?=
 =?utf-8?B?M0NLZi82YW1SUExkZlNSdEpobVNuamtrTms3UGJXajk3ZitWU3VmRW1oRG1P?=
 =?utf-8?B?QkcvZFFIMFdZRmU3eUU3MjZsbW5ZTWtpWENCWkxQSnlabGNyUzI5Rzg4YW9l?=
 =?utf-8?B?Q3kyY0w0bk11NUhzY2NVVHpmT3BUL05wNnBXVUt5dlJCQ3l2SnBzUllZNXVi?=
 =?utf-8?B?K01DRiswelFLUDBkMmZ2NHJXL2lIeldiVkFXcFVrRjJZeFk1SUt6eEoyWS9h?=
 =?utf-8?B?anRHMGdPNG44L1FFZUZwWEh5bjdLTnc2ZzBkSFpzSnIwd3FOQnZiazJwRTN1?=
 =?utf-8?B?UndxZjJWRmh0UHoxZGo2SzZmOVhsczhBeWVwSkRNYXhFNHZWeG5paU1qMTNO?=
 =?utf-8?B?T0k4bHprZHBVSmJIdXpSTjI1Y3JHZkVnRnpCSGZSUjcwdjJXTU1vZ0pKRTlL?=
 =?utf-8?B?SVJVRGdacW9ES1RCZFhRVytSaUJ6OEFUSTdIUDNTRXpPaEcyaWs3ZlRYOE4v?=
 =?utf-8?B?NWxsd1YwVndnSTlQQUJ2WDJHYjJWbE9FRXFvcHVydFJPSWJpb3lNVEU5dlhx?=
 =?utf-8?B?MWdvTHo1ejV0dTYxNDEybFFnYXloei9GQm13OG02WmNiRmViRlJmVERzc3pi?=
 =?utf-8?B?MS9DUTVDOFAvaTBHMW92WGwvUjloL1dnVjVaM255M21obFpBSk5Jdk00SFor?=
 =?utf-8?B?NTVzM3dmbWVYeDBpL2p0aGNWOENZckZFWHljbkk1elRQbnd0SDR3MzdMWmF6?=
 =?utf-8?B?VVpHL3lzaVN2b3M4T3o5MUpwQU5acDRIdVhYN2I2ek1UNUlEbndWQXA4ckM5?=
 =?utf-8?B?bkdZUVNrUmNTUDNiMnVJeFZhM05OMXRSc0RtY25oSnNITFJSbGpYeGFyeFNv?=
 =?utf-8?B?ckVFSkpZQXZ5MnRmaUVkS3dFUFhZR1RMdTlVOXo3ejBqck4wdGtSWWYzd1Q1?=
 =?utf-8?B?RHJha0V1T2MvNWNUa2wzRkQ3cnVhY1VsYjVGZlhsWmNqQ2hud0xYTlRTSUg0?=
 =?utf-8?B?aU9jQW1aYkE1dFRUN3NTNnYyV0dFNFhxQ1V3US9uTEpaZUFpTlo1Sjk1UG9P?=
 =?utf-8?B?eDliS1o0Y0pBb1VLMUhqdStVRm11T05OQW1ReE0ya0FIWVVLVllJN3dVWVpH?=
 =?utf-8?Q?qJt8+u1VZ2K5YlNgSv7McnvsNWne/WGn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1RmOWkwdGpCd3lEVytoUityOFkyZ0ZNdVVYYjZyeVpQYXVhWjVJZkYyd1BL?=
 =?utf-8?B?c2dBNURVYzlWZFE3ZFhTYk1kTW5qRDNKK3dTM3NPcG54OWd2V0xCUlRzQS95?=
 =?utf-8?B?ZUw4aTRSY2FrdmlUV3JWSE8xYWtDVVZwSEFxcTRmZ1IvR0dBUDdLRWhaMUtw?=
 =?utf-8?B?WkZaMkJ5cDBtZVdPUVRSUWFua0U0a0NwU041V3RzZ1FFVEZFR2MvMnpqRWhG?=
 =?utf-8?B?R0twTGJuUVRXQld6akNJYmRUZnVqN04xbUd6V2pmcGJsYmdHUEozNnNJNWl0?=
 =?utf-8?B?YjNuUzF6VlRuUlkyZWdyNjZtQTcwVjBnSytKR2dVZjN3ZlY0eHNQRzFFUHM0?=
 =?utf-8?B?dVJRNGE0L2k4RVpzaW9MckhCUGFFVERGUlprQmwxYXFFRGNVMDhyK2Q3Tkps?=
 =?utf-8?B?NEEyUlVYMnZUdm5rZUc5T0Z5alAya1N0b1ZNZHJYdnZjNDBMenppSW9sb0ZH?=
 =?utf-8?B?NEt5VGxlYnI2VSt3dVBzenlxalllU1p4LzJYVHh5K3lrRit6SitBVTRlMms0?=
 =?utf-8?B?SUM4blRrYm5yVnFYSnpOcXdlaml2WHRKSndubmhPbmR1U1FHUDhDZ3piRlkz?=
 =?utf-8?B?Uk03UFF0bHZVZm4wd0xNUWJsU0IxVWtEY2NwTklUNzZmWEhWTnFld3h6WkIw?=
 =?utf-8?B?SWJNM2ZqUUtaSDlKdHlMNFJYRGR5Q3FSTWVpdDFURU9JM0dad3EwMTdXWFRT?=
 =?utf-8?B?RExacHZ3Q2JRbDM4K2lzSDlneTgzQ05SMmR0V1IxVTgybkx3bDMxQjUyeDFY?=
 =?utf-8?B?VFh4YlI0bCtadUJkMGFKcitGZWhzTUV1SHJyUVl4RkorMGc5RjZrN1hKRlA3?=
 =?utf-8?B?TUlSeFZST1VadXdmckRwWDczRUk5dHExNVlnOHl2SzB2K1NUeFZQcmg0MUln?=
 =?utf-8?B?UURUV1U0Sm1wZmZ0SmVrQnBMYitPbVh2VnNTMHhPYXlRMVQrdWFHUUhMMjR0?=
 =?utf-8?B?aWtWZTVxQ25QeW9ZQ2oxZ1ExTGtpN3FQOTBiMEhtczRBSS9KamVOOXp1bzha?=
 =?utf-8?B?SjQ4ZFEvUndwMWI4RnBmbTVMWUJqN2l1cFNHakdiV0tXZXJjYUc1ODQyaVM1?=
 =?utf-8?B?cGorNFlTVFBxOTd0WTZoL2FYVGlFUGxWdThpZ3lmZUdNaExaQlErRjFhZXRm?=
 =?utf-8?B?NW0rTzcyRlJCbm1LUm9pbVFWUVhpaS9QNWJoOGk4bDUremdOcEZtT01UM1Jo?=
 =?utf-8?B?WHRQRjgvOEFvRFdQTklIMWhva0JXOUFZUEg3L011VlJWRWMxYjhBL2hDZWp0?=
 =?utf-8?B?d3FSdnJMMXdMNzlsdEJrc1FGaXh4djlHM2oxV0F5M2RBNVZBUVkxS3hVSDZn?=
 =?utf-8?B?eWdWbnc0SGZVMk03MU13dWtCTlN0WGY5UHd2cHhWNlhOOWdReWZJTjFIRTFW?=
 =?utf-8?B?SHVveWRzd3NvdXRkMzNyZDZWTVRtZEM1dUYvUUVxNmltWmVRVnJkZ3JicjdI?=
 =?utf-8?B?OXlMZm5vanVNYkYwM2VTbWxTMTBsUkljeTRhdWlaUEVwSkNuSDhHVVp6OTB3?=
 =?utf-8?B?cVR6d2I4TmEvYldIVVEyT2xnSVc1Mnl4djRFeE5udUx5RmZTRkJ5TUZrc1hU?=
 =?utf-8?B?cysrM2ZoaXg2RkF1WFRyZlk5YlJCUEt2SG9nTnhydFdxUTVkZWRSRURGcGE1?=
 =?utf-8?B?SkxQc3JOdE9WQWJMbWtuY3FDU1BtSEkxbXdOcHplU0YyaTlybUtWcURmY2Q1?=
 =?utf-8?B?R2R3Y1l6UlpoYXhsQ1dKS3h0QVlDY1RqRzVqNnZKM0ViVEtIcmgyLzlzeHFK?=
 =?utf-8?B?dnV0ZUg5WDh6ZndheW9jazhTZUtvb2hidHYyRUhwbHhsY2lTMUE4aWRMN3lx?=
 =?utf-8?B?TGEzZDdNdzRrN0k2WmFOckRXMTlHQ1FqRmxpQWFZcEpENVRYaHZOR05OZDJZ?=
 =?utf-8?B?MkpybmR6OFYyWk14RnJ1UjhZVThPRjZaL0gwbzJ4V1dhNU5qUXpQOEk2RVpx?=
 =?utf-8?B?bCtKbUExVFZYYzljN1NxaWNtV1RGSHhKTXNyUVhnRTdNeHB2bGxjZzlZTUxH?=
 =?utf-8?B?UWlSZG5pSmxGbWd2N1NOckhicmJxSU1VUDNCV2xLVjBDQ0xoUHVkMW5NaWZk?=
 =?utf-8?B?dUJuTmorTGpJdHlQa1Jid083NUJjMEJlcVdpUFk3ajJUQXMvZ3FmSDA5OFhN?=
 =?utf-8?B?bm9hTG9QOTVJSmF3WlNZTXdMMFdQZVVZRDVybHVJNUpKeXRsWU9PSm9hTW5F?=
 =?utf-8?Q?ufuqDPd/NLSwV1uXF4uV6SSNaZlJRw7Qf3cwJRBlI+wt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7e5211-969a-49df-8a58-08de3258fbc8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:44:49.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEwmvaHLU7pUBo71uWy1zxSPn5eAZhRdeOG0kZ88/db5x8QGTM/GBVSjDQgyJ2Xu0yVJSE6azuA2DccTBLd+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797



On 01/12/2025 16:32, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> instance is paired with its corresponding CMDQV instance via the
> nvidia,cmdqv property.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
>   2 files changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> index 06795c82427a..7e2c3e66c2ab 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> @@ -23,8 +23,16 @@ iommu@5000000 {
>   			status = "okay";
>   		};
>   
> +		cmdqv@5200000 {
> +			status = "okay";
> +		};
> +
>   		iommu@6000000 {
>   			status = "okay";
>   		};
> +
> +		cmdqv@6200000 {
> +			status = "okay";
> +		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index f137565da804..5124715caeb3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3361,7 +3361,7 @@ bus@8100000000 {
>   			 <0x02 0x00000000 0xd0 0x00000000 0x08 0x80000000>; /* ECAM, prefetchable memory, I/O */
>   
>   		smmu1: iommu@5000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x5000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
> @@ -3370,10 +3370,19 @@ smmu1: iommu@5000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv1>;
> +		};
> +
> +		cmdqv1: cmdqv@5200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			status = "disabled";
> +
> +			reg = <0x00 0x5200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;

Like for other devices, the typical ordering is ...

  compatible = "nvidia,tegra264-cmdqv";
  reg = <0x00 0x5200000 0x0 0x830000>;
  interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
  status = "disabled";

So let's follow the same approach here.

Jon

-- 
nvpublic

