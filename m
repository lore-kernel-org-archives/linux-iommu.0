Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBA2ECD1D
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407807; cv=fail; b=m9vv0ZMkwU4GoYvq00cpinrV2oIpf+IqoUe5Mbd3fPnYJFCeQcb1ZHyX0OP8+NfWSl/Kgx0Kk1vXwLJeXv8NcCxlMC98iTIcUnTjb8/t1gsercjEPvgsEfedSQoX1tmjaqzrFx3jxb15hEWio/rI0JV0gXGKR7NZxokCk/y0VTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407807; c=relaxed/simple;
	bh=ih6Ve+hkhTIO6JWo29v42vT/blH7V6Tv+EEU7uS7WdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V1spc09b55Tv4ZSvmMPLHzA6hoIec5L2vIWi16FiWCD5ywwTDxW0hRgsmkcIyxhJ6V5fWh+7Hbg586+KGxf+2TOcDfc8xYaFhlGZVqyoWpGDN0CR4ati/v6n7sO/hKMMJHNyxK0O2Jeb0RcNQ3Dh3ODNK8hdNAqSTZbmkDXqXi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v3peb0bJ; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v3peb0bJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgWCZL1fMDE+MCk8XkH+6Amp3yQvXdktPa2QtmRNMRWD0zM3EsmT5QGTMxOHcsDH9BYnbTq4JGZ0DZ+W4QDcIY9FiQiG5PP1N1iEnem8MiKNiODOSCobQH/+jNjHibD4TnUmpWEKZL3lN9Xag0kV+dhgcL2blHjc+iyOgN0D2rXxSQv/YfLx8m/zV6b6VvNRYE67gXrx0iend+I2VcY4bnvDNVrIWc5h4ev4gKgRoTSjX+IuF1nEaHgWyyjHixGx18UUKTiWzLTgK585SBY9nExy+ySv5a+NPbEUjNDh0/es2x+XrURq57T7DRUxkk3f4vNFS9Y/x+ckQJsJRvCvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftbOm3jK3R9ZJzITRi7GVJRi6YO+EzfFo92mLYIhMe0=;
 b=onlgW7O7LN+MvHVnM4nq6QD2Szip4FURvhJ27WfATeDVhFO3zGE0WBldsh3d41k0JgGQBuX8hBcpVVrWOJB9+blb00uROzxkmXHAmiA6z7nRp91bPgEhn/vymHzf58AAa50N77cL3Da/yrZo1Ynv5AbAIeZWWzzskvJgV/lX0KIxlxDk78cc4UBrWtENqBb3g+L9tXyJcjxspybD7ySq8soEb5qdvOw59UyDz0PSI8m5RvZ8kaBjIhVqBiaW/Y8IDotfXxfNKXtMiQjUEk6bpgFo3PHHYQFVBQ1V8BERGqnqPaPOgxA8EfCtuoLniPEo1xNj1vJBbUDG6Z5CYr6vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftbOm3jK3R9ZJzITRi7GVJRi6YO+EzfFo92mLYIhMe0=;
 b=v3peb0bJSxYuh1CY9agL1v3kor0S+IjAgxwiFVU+maEWP+Z+JZqPajLxvAvIJT8AgaXXw1l2ZFVlAZbPH79MG4ZMX69o2hr3jvcRt6rw4bAJoTe3AU4DZy8Vb5RiGLA2S8mAjuXm73yblnbNBig7lOXwXRANAySnIHc1G2HvQkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 14:10:01 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 14:10:01 +0000
Message-ID: <dd1d8d3b-030f-45bd-aaa7-e8760268b2dd@amd.com>
Date: Sat, 22 Aug 2026 19:39:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix PCI device reference leak in PPR handling
To: Ruoyu Wang <ruoyuw560@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Wei Huang <wei.huang2@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260814133938.1385879-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814133938.1385879-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::17) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7c9896-023d-47f2-7cc7-08df00570e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GtW+IcIH3t/pOKF2fv+SwOIOO9YBAry9D1tf+GkBr1VBWphzk64J3xVd9OOfWTgJ0bHEQrYJqxVm8J4dNpKB2a8AMqYHubuvdmYXbpqFnbO36gu4iT2RfX1jGBK0MdADFZ/5mBtjmgoI8nFa9Un1KV27qjjuNlPPSATI8baSlJtBmO9dD99/gtFePHlWFYUkmBO8JLox3YkRiAMwKgP8nMo8Dji0xFZMXhQm1btYvIUwxOub4rhAAhfXAqk/i53bgNnXCOWnTOcx8U1APKo5WvwaIPwH7o6AUhF61xfDEtQ8YF2AeLKiL/JOCqlTf8WD+yfCnNZtt7ym7ftcYdY3a59AI8f15ui5ZLZbFJijPOphDVvRD+l8BkhWFjVcRGlk1NPvb0O3EYk31EJdrSf1Tca273f91+aVrBu9SiR9FM+HbLQKZUf69KnadvOqqNv83V6vUhdUhtrSaIGn1LmDIYwCv6gM0Enm/CXOtnQaypFv4uLkUaWr6hNRDUfAItLF9vGgyWrSm0OxKt5choKA4HZYOi/8ru8x1um+Po+XHZ3TSiDAgNZit8VrdkY59T6FLqjTi7T6uf0n4FpDZ+3ZZVVciHJ9k9R+9LL+u6k9cWsKG9RgRC8xIuZBKoYpdOw40ceVrSrX0K2YSyDXlFUvzQLLHtoX2L1+Zb42tqaqNy4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFCcmFOUWZodzlQQVI0RDZpWHJUTDlRb2RTK0NpVU5PSmNtc21ybVhoY2dz?=
 =?utf-8?B?L25MWkFKSVd2Nkp3UDVESVJLdWNmazlhVkI1WVp4YVF4L3gzaTFvNXo1dHVW?=
 =?utf-8?B?dk1hUVdjOVE4OWg0bC84WXJQMkd3TUZVMkx0V1llUWltVEd4S2xjNm94NzZR?=
 =?utf-8?B?Y3BCMEdlZ3dOYjRCTE5MMCthcU5yQnNpRGRnTTRyRUlDY1gzSWdCeXlNVm9T?=
 =?utf-8?B?OXNWWEc3NmdJTmZ2RUR6NDh0WXAvOUdIbGJMekpWOVdIS2hFbnRwZlFCcUNQ?=
 =?utf-8?B?MXEvanU4d3NRQlh3bzM2azBsQThySFJacUlkeXJJUSt3cmQyTmZubVh3bjhD?=
 =?utf-8?B?anFMQmZTUEtuR3N3and5dDR4WVYwUGRWc21HazBWT3IyZGFjT09Ma2Nnemp4?=
 =?utf-8?B?OEJPSk5HOTBkOFN3NDI1dm9NWDQ1QjBJbFRtQlBFdXk3K0NubjR1TGk0STRj?=
 =?utf-8?B?Wkl4TllabHdZYnIrSGtuU2UrSGt3anlyRXRYWEZCQlhiWEs4a1o4Qk1zbW5O?=
 =?utf-8?B?Rmd6UVdsd3QzNDBwY2xIaUFhSEYyU2dxL04wWTFZUUlIVThEVHBoL2dPcG5s?=
 =?utf-8?B?cm5oaDA0MTE2N0tXSE9BMkQrUWIxcUt4VXFDWWxrNTVkTi9lN0ZLTkdDZk9m?=
 =?utf-8?B?L3FOeTdWdC9kYlgxbklJdUlDWHZwU000N0x0Rk1ZZll1S3pKeVhZSHRBbElm?=
 =?utf-8?B?UDVkL2hqdm9YMTd2TzhhdWQvTVRjZWVRalJkcUdsUSsxZzJFUTZKY1pwNGQv?=
 =?utf-8?B?YzJYbjhFdzFTVU9ZaWoyZlFOR01NWDczSStGVGc2VnpEb1AvSUpVZFZpbWN1?=
 =?utf-8?B?RWlMREJjZXo3c0c5a2RCWTJZSG4wWmlLN3JzMTJRaVQ4d2ZncnBLUWRyZUFN?=
 =?utf-8?B?eWVEaFlFVEl5aElZNVVqRHJaZEVsOVdkak9qN3NROXYwS0JaSkkyRStRL2hj?=
 =?utf-8?B?RHN5UGZ1TnIxMU1kT2JrQ3dhRklLbWJjY2E4d3l1cTZtNks4dWhKOVQza0p1?=
 =?utf-8?B?ZUovakl2MHh6THJnQU4vdzJYckRwNVk4YkxWb2s2RjFET1JKSTNremNEbkkz?=
 =?utf-8?B?b1FxelJoOVpRYVQxMGoxR0xmL3JUeVo4Vk5ObHNmSHE1akZlMFFZSW0xR2x2?=
 =?utf-8?B?MmV3U1dWSnRaRG5RU05rSlQ0NlgrNGMzNXNVZVNzbUoxWXEzeDhMV1FnL0xV?=
 =?utf-8?B?OC9oTEdobjdLTGZSV2Rlc2xOZ3djNFRiZ2JyZDQ4VHVzRTdqVGppM1piTFpU?=
 =?utf-8?B?N0REb0k0VjJEcjJnaUk4OXJncncvT0dRQzlMSWJ3cm5ZUVNNZVFCRjN6Nmlk?=
 =?utf-8?B?cks1YVc4dkNCZzJHZFRNUi9pUm5lZDE2eDh3dWRQdm5ndjIvN2hZVUVDRk1k?=
 =?utf-8?B?OWN1ek5KU1phWVRNcHRoR2JpZ3RnaDVYcytQWUs4dnBiZUNWblE3MFFmQ2k4?=
 =?utf-8?B?VnRkUklxNDArdmFBbDlwWXNkb0lMWnMvWncvQ1RiWHcwZ1RYeEhScUVyZkZ6?=
 =?utf-8?B?VHc4U0VkbXJ6b3czaUV6SEgvaUZYeXZxR3hBcHoxL1VpQUJQR2pPUGJrUkxM?=
 =?utf-8?B?WUZPdkJzSWhMQm1WRjFXNFFTZ3lPYkNOcHY3S2IrbjViZ0hhTmxvcVcrZERN?=
 =?utf-8?B?TDlLd0kveTRJbTlYUkpRNFBtVUVNYUc4Y2N3MVBrNDhabWpIakkwMnNlRXl3?=
 =?utf-8?B?bU1UYml4L09sZEdKdE9JeS9aaXhMS2VXR2pCRWdwTVVRUmJzWG54MUxMeWlV?=
 =?utf-8?B?Sk02Rkl1WTRBK001MFZFRDhNeUthQVE2aUl3ZGp0bEI4VGNqcUNyOWc1aGlp?=
 =?utf-8?B?VWludGMrZGg2eWZDZFNOdHBDVWNYZVNoSlN2QWQ4dDUzS2tDSmFaMFY1Sk42?=
 =?utf-8?B?UitSRVY3ZDNSVDdBMTdlQys5Nng2T3VsWHhCZGUyYUZoSEZHTm96cW5jc0tU?=
 =?utf-8?B?a0hrSFEvNy9jTzFZUCtZQXdsSVpjWFE3bUdGZVQvOU8wZVNKTFNsQUlIR1Fz?=
 =?utf-8?B?b28vV2xJM1FPS1BRdkZHOXF2T1BYOTFhcmNCTUVqdHRraklLN3NkYUttVDRX?=
 =?utf-8?B?K1owTjBxaVJQOUt0aUUvUXBhL2FSZ21PaXY3NFV6UFljbXN2VUE4VHplRy9m?=
 =?utf-8?B?WXJXeVVXcjIzOC9jZ0s0RTlKV0xIVll6OVNUdUhNazF3a29xWU9oanQrbHJu?=
 =?utf-8?B?c2ZvTzVoVnVaclVIektXRkNQT2cyQ2ZnWGZwVG5aQndtY1JTUnZpelJRSzhG?=
 =?utf-8?B?dzh6Ry9VQWRLYkFEYUhURzNlT1pjZ1RobzZ1Qmw4S0xlM1M1Y1FQS3A2RSty?=
 =?utf-8?B?UjkyZGhHYlVJOG50QTl0aTVNWkNzUmZ0aGV1d3pzWXlXZXJMWDZZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c9896-023d-47f2-7cc7-08df00570e54
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 14:10:01.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gz+PsnyM7H5Wx4egOtOLY9ca5DYOIfsZSWrUHLAW/7Jk8kM7M9tugkaDGsVBAVrsBZUqysYdnEbo2/SdaVVmZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262



On 8/14/2026 7:09 PM, Ruoyu Wang wrote:
> [You don't often get email from ruoyuw560@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> pci_get_domain_bus_and_slot() takes a reference on the returned PCI
> device. iommu_call_iopf_notifier() fails to release it after either
> reporting a valid PPR fault or completing a rejected request. Each
> handled request therefore leaks a reference and can prevent the PCI
> device from being released.
> 
> Call pci_dev_put() after the final use of the lookup reference on both
> paths.

This was recently fixed by commit af3b69b16383.

-Vasant

