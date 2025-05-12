Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928AAD5E
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029260; cv=fail; b=o1dm6clighpuZ0EeeHpNqXSiax6VjgpC3z4tqh8JD3TGBc6D2o3tpn1F+bSUryya2Hg4pVP55geMvMsyEBqa4GEoxfZaA9UwtXrtHQRFohejy3yTJczyvmdZ9pHB0NH23rDvsNoJPrXnMxLMh2Ed/HOJwFrgOkO/lwkyZ5Jyl0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029260; c=relaxed/simple;
	bh=XRiif0tVZgiN2ZkFDIFmseChftmVRXOMwjo8+zjwXVM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q4g6mnnyfKiB6xB7J7eKE4hNaRQZ23iGj4vFTVEedqH4Weu1q2UOvYSv5EfLR3/wX8kaWCEvcqomlnvLvozcz4uoS9R9l86ZGDSfoygIwOaHc22latTbimoxnbV/8NqEq5wd4hr9QMzKFsZnmIx0skHtcXf5UWivVzoCqqeNLdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HfJjYUG8; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HfJjYUG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ2AcI4Bt1114C/VoCbAtM7MnxHjo5I9Wt0rqnd/zlW0SPQYZJHWdZV+O3FHS83jWitKzw9Blm9Gc6tm7FTVo/TFCaRrCdAXo0mUbL3VATfKMj/FIv25VxQzeMxlkL+qq+lDDmnGY4YKa/yWZjU9+VU/BtYkEYt6SK/b8VjjL6Of2Wcpj7FLmmKbLP47QmLf/yS3m6yXjR4h5/nhO3VwFk4V9oL2jna2odhf4HIpH1DYr+bS5VyIBuxPIVrEolwRFBw/EAQRhPczKxwHjeTjdcOYtSQtJTXGx+aqoSJSaIl7kVrVD0EhfA1GBPLJaY/EW0wIbpWLBhGLyQOIYkIYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S25W7veI6uoiV4mhcw9auN7oHjd7KU1Zk2nzz4hMqVw=;
 b=Hnuu1Hvf4bIwO0/HTeIx1AeJAPPINHxVGHQ1lj7578sLkaQZR+l0LwxJfG5cYaxy+CsF5PCHAMIwEiNjDzOFL3Q3/Dh++ZP79Y5+ztIVEa+rs4nsYVzi8t71roShqqI7Udwy5QBW5UFoCigwG/7Jn/w7xpXeKi7iir6gFfw4is9/BE9FwnW0KaZf37Z8VSZ3ztpsSYoOyMsq/VxqHo0VJl3JKurIfyAzmT8jfJk/R3lZy7BxUBob/ANIXoST2fT9VP2JCSWlaVLIKRnN+falHvSXkxGhH+bpHfEwkFS1jG1J9vIjekkvcWrX4Bygz6MYBi/0+aHsIgaFRvMaMYHI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S25W7veI6uoiV4mhcw9auN7oHjd7KU1Zk2nzz4hMqVw=;
 b=HfJjYUG80SNEKk+3xF1FFBSn27PVKayaAuaSAEHuZHy+kenYqRbZezrEzymMgO7cpycfO5MSG0+AN20rDsOpOo7L/nSwMJducvEneP5zFpDCQdK3Ogo1heEPKKcwrijqKE7OHcYv2Dpj/u+b+w61LJ4jvOlEZwWNw7QLqWeU7RM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 12 May
 2025 05:54:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:54:15 +0000
Message-ID: <0f59569b-4f92-4d2b-8f7b-05345382eff7@amd.com>
Date: Mon, 12 May 2025 11:24:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Allow matching ACPI HID devices without
 matching UIDs
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 joro@8bytes.org, will@kernel.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Paul Blinzer <Paul.Blinzer@amd.com>, iommu@lists.linux.dev
References: <20250505144451.326555-1-superm1@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250505144451.326555-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: cb38393a-16d9-4946-b58e-08dd91196d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3Zvd0I2bGxXT2lmRkF0UzlQT0xpck1OQjN5NDFaanZTMFlSeU1LU0MyZFpm?=
 =?utf-8?B?NFFQUzRjbnlvRm54UE9HaE5xVWwyem1EUHNYVkFFckdONGJiVnF2Y3pzZTdZ?=
 =?utf-8?B?Y1hVdHdEYjBndGMweGYvbm5tNFZ3d2o4TDlXSldpcHU2SDRyQlpIdlV2eEE2?=
 =?utf-8?B?M3lWZzhFdXRPSGU1MUw4NHB5SGRIS2FMZVVWRnkzUXBiWVUzR25qTWFDbVJK?=
 =?utf-8?B?VWxITkcxWFEzdUhJSHhndnh4cXB2ckxuQUtjbU96TllyNlpBYmNRcWtoa25i?=
 =?utf-8?B?WGNSaUxkTCtCdHpQUzBBaERxRytsSzBBSkVzT2ZDUVhGTHNvbU9OOW92dmlB?=
 =?utf-8?B?QndNc0VSaWhuSkhlNHAxZS9RSktETmVBWkorblFkMS9wUUtneVVaaDJUMkdx?=
 =?utf-8?B?aW5tNkZFQ3hlVzRISm5FalAyYlUvQTQrVkVvRnByb00xQjFxU0kvbmdHc2JC?=
 =?utf-8?B?UDFweXJpeCt0SDRRdk9XeTFOTHpUbHB2eW1hbm45N2J2STR2YmNYcHpYTlRG?=
 =?utf-8?B?NnEyKzlMQzRaNFcrVk4vK3V2YWNxbHZYWllxUzVrVjVvOUZMbTkvcksyR3pC?=
 =?utf-8?B?YlBWUjREenFobzMrR1FxaHRLc3MyQ0tpYUR3b3I2cXY3Q0V1ZFo3d2hSdU1j?=
 =?utf-8?B?NGUyR0t2cEQ4WWYvZXE2aFgwbEx1VzQ4SDJ0U2dBQzZFYUZkbCt4MjhIUWVa?=
 =?utf-8?B?TkFVTzI0NTlxWlRscm1MTVkySTNrWG9kZjlhelRJVktQZTNnYkFQVlVqR3Fr?=
 =?utf-8?B?QVoveFJzTzhKZWtrczVVZDZheXh5emtQYVVJY1VxdTRXTnNIZ2hpb2g5VHVO?=
 =?utf-8?B?dGVvMGlMUFhOZkZNMFlFR1JPZ09XSDZmd1pFLy9KU1B6OTJVcjR3cjhSaVV2?=
 =?utf-8?B?Nmc4UHdiSFY2c1p0MVZUSnpMeTBRSzBxVXJWVHBPL1ZNS2FDSU5uMmQrQm5B?=
 =?utf-8?B?Q3FucTFDM084OGRjaFNZY2RDTWtQUDg3bWNIdk5yZ3pFcmJGOXpzcVIrdjZa?=
 =?utf-8?B?QXZ2WC9hdHRELzJnMUc5RmZvN0V0c0xKTklodkxRN1F1TkJxeGdEa0tyNTN2?=
 =?utf-8?B?Tk1vY1d1QU5YOU9KNnFUeDErZFFYQklvaXZ6VlR5a3FnNmYza1BtdGdWWGxC?=
 =?utf-8?B?YmtrcDcyOWtDU1E2dmxnNWlsaUZoMUtodm9Kc0JENDh0d0I4YmovcDhZN29I?=
 =?utf-8?B?K0RIdVhiVjFaVjRlSmZDN1R4K2Yxa1B2MW54MHVBemNWUFFETEpvRGQxWE1k?=
 =?utf-8?B?TSswMXVBTk1OS21lVFdIYWlRcjJpNlRZZ2dtWStydDM2RElRZkFvMUtxT3o0?=
 =?utf-8?B?TDJTK01hWlhheHVDS1JqVTR1aHc0RUF6am8wNWF1bW0xcVM1MUdaUGhXUHhG?=
 =?utf-8?B?WDBmd3dwbGYwSkRBcHlHUXVYMmhCNXNwSVVZOVFobytGdmRRYXo3QTZyNlE2?=
 =?utf-8?B?RmtjSTg4WUpKYnN3RWFrelplcHp5enF2d1V0bDhMTmxhL01IQ0d5UmxJdnU0?=
 =?utf-8?B?TFNBelZLRGxtYUhlMnBCY3hIbjdrbDc2cmFaTFlSU3lEcXg3ZEdPUlhNTWpR?=
 =?utf-8?B?a0c4S3pRTjZFMDhTcEJlY3d5NnQ3bk9VemJ3alAzSGhHeGFLMUpaVUtBSmI3?=
 =?utf-8?B?Zm9iOXRLbTdsb0JRV2RVS1ZHelE1ZG53MEthenlGRFlqWmpWL3AzRDMwWWYv?=
 =?utf-8?B?WFdCZWNaK1MrbXFMRXJJQWFBTmRsSm16eGxlS3FjanpEaXB4ZDl0OVA5N2Fl?=
 =?utf-8?B?ZW1rS2JoVXRCZ3lVM1p5dDl6V1UwTDR2U3NKK3VVZnpCZTJMVmJLN1M5dXZr?=
 =?utf-8?B?aWpSTHd1b0h1QWZkVmFuQU5SMUdGVWtNL3lZNUxLcGY4ZVhLUFRycWZ0Nzly?=
 =?utf-8?B?bUN6dkhyOTlxUFZMeEkrcWFMMjJDRmpOZ0pWcmhJdkJmOUpYL1BBOGU2L3Fu?=
 =?utf-8?Q?LLkwjBZzXHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUxZclp4MUp0K3pORVl4ZXlKWk9zNE5ORmRvd2ozbWpyZW1xUmpLMHRCZGM3?=
 =?utf-8?B?b0NCN1hGVjNFVG1RbzVVVTE5eDZGeWlnbTJvNGozY2JsbTk1eFNzdDc0dVRy?=
 =?utf-8?B?K2hWeWVpYXJTYjBxOFBJbUg3RzBsUFZuWngzdDRQMGJubW1xUUdKTC85cDlF?=
 =?utf-8?B?d21NbFJHZVdkMFFidG9LaEk3TC9TUW9ja3Q4R0o4RkIvQXBNcEdWazA5amlP?=
 =?utf-8?B?N0VXWWlqbEYyb3JMc3ZLeUVDQk9pVGowSTJqcGRaRWY3Z1RNWmp6OTg5SzVw?=
 =?utf-8?B?Z1JpeVJuczE2WUZLZ3ZtTm1EN2RPNmE3Z3pCQW14bDR3bTI3VVg2aE1mMWVi?=
 =?utf-8?B?V3hNU2haZ3A3ZUJnZnZ6cWNhSVA0NGJuUFRqMkVlUTRidzNnOHRxeTZBTkRU?=
 =?utf-8?B?aHlKQ1pZTUo1eXBZeDNpMlhYN3JweFBYTlUrYkVIUlV5a1FNaldJVXVmTUpR?=
 =?utf-8?B?clpFRFM0ZnZtanhFcnlOQlY1NUx3dk1ONmhFcUpZM09haUI3ekpKSkpWaktu?=
 =?utf-8?B?eTdEZ1NQZERLSUZxK0l1TEdvK3pqak02ZTYzUm9mak5uaHUvNURCaVhGbHBN?=
 =?utf-8?B?V3lTa0YxcERBVDBzUytsWlBBbXpNY3haVjFUbEY3dkl4ZjJrSnBlSzlCalBW?=
 =?utf-8?B?TmNESDZVMENrY0dhcUtBRHNXbXM3b1BhTTVIV2UyLzhPaHpSNVZKN0owRkRa?=
 =?utf-8?B?Nk1qblc3N25KU2JxQnF4Q3huWEFQSzlQcDRCanVBMUNuSlFoUFoyWGE3NWk4?=
 =?utf-8?B?eGNiNHJ5bzJQY2xKUGFKdGIxWGFVMkxxNmpHaitUaFVwNkJ3SlF0cVBqN2VQ?=
 =?utf-8?B?aFBhb0xVZEZNRmhCSUVVZURFZUNjNDRoU0hUZ3JGeXFuR2pCNDJCRXMyd2JY?=
 =?utf-8?B?N0RHOG5xbnFjTmtoNnhvSUYwOEs4Vkc2akdLQU9yZ0p4MzF0ZE9nVmdLWVQ1?=
 =?utf-8?B?QXZZTDY2cWVWcGlQMENuOCtYUVBuSlpsOVErdDFjamZLbXJVV0dsWm9aMjNC?=
 =?utf-8?B?dnZ4Q1VWQnhxYnJsd0x5RGcxMCtCNFVLVVhkYk9UUG1sN0UyK2pYMEdWWE1Q?=
 =?utf-8?B?eW9iL1YvQStDRGo3QURrWW9mRzNlRXNsY2R1SDhnZDZQdTdOeGVTUHNjMk1X?=
 =?utf-8?B?N3NoREFhMUUzWUdsNm9OUnNDZlFZMnVwUjZYWVhEVnlldC8zelhOVFU3R250?=
 =?utf-8?B?L2Y2L211ek8wZElsSXc5K2JmOWhFcC9YcFN3KzJSdmNIamY2NWgzdVpJYXE0?=
 =?utf-8?B?WFJVVnB0aXI4Z005b1d2SGNtemtSb25wMVg0WU90T1Q5TjIwN2lQblBGcjc2?=
 =?utf-8?B?SVZVSkZSaWV5TUtTUVZjK0tFL1F3RVhoVDlxL1hGeTFhSk5OY2phcTR2MkNt?=
 =?utf-8?B?UWR1WmlxRGl4YUxHQk5YTjYwQnhiczJQU3BtcmxXM0YrVmlrN2x6bnNrVDVo?=
 =?utf-8?B?WU13UFdqR1dxVC9rQmZHanRmOGgzQWFCYUYvZXBWaHpzUER1ZUMwOFQ2eEll?=
 =?utf-8?B?QS8raUdTOXVGdmVsTFhUYUlyWll6RXhMT01EbEFOWjlQbmtLMTRPSXd3dDl5?=
 =?utf-8?B?bFlMR1FwM1ZaMTVyNVd6WGR5alF6RDQ3aGJNVjVZTi9kK1VUNGVlQ0RJdGdS?=
 =?utf-8?B?aHIvMXVVL2VoNGVmTktxREtJa2QrYVJJeVBxSmJPcUJrVXNZVHA5SjFINUwy?=
 =?utf-8?B?VWZHTW44K0dobVdJR2V4QkVOT1QrOE04ZUVNVzdjM2JpdjNzekNaaDRxRFlo?=
 =?utf-8?B?eUN3cE5FTlFDanliSTFrUFJxR2JhVGpab0R6Z0FkdVpYUkZkNVhjUVBwWEtu?=
 =?utf-8?B?WlFuYWhMby9TSEV1TDN5cTJoODI3Mi95WjNONXpBVkhhbm5sMGR4UGVSUEJo?=
 =?utf-8?B?bDhoUzgyRDN0OUFHdDlLd1FhbUNFeTlyaUFqTU5GUkc1SjVxeWVpTTlpK2hR?=
 =?utf-8?B?djRPeEllN1ZxSDFiZ0JvSEllYTNKTE9JRnVaWkJRcTNOa1VEa2dlYnhoYkV4?=
 =?utf-8?B?OWV5eENLWHU3TnRnSVNkRGpzQndkNGhwS25VaDd6bGtIYnd4dFFFejVBUUt1?=
 =?utf-8?B?cHA0c1lXN0xRK0kvZWJDMS9rczNuYjRHMUxzcWhZdWVIbnoxNHVNS1dEaDM3?=
 =?utf-8?Q?zaLTKp89NG8Es5LKJPTMG4Ovk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb38393a-16d9-4946-b58e-08dd91196d3b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:54:15.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBJYjRXW7M2dD9S1nB02XaQVwhMoL1lrkTeSnWeOIgNHb0ys62teglRdO02l9TcjxNVJh4SnwagWaP8JuNvafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

Hi Mario,

On 5/5/2025 8:14 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A BIOS upgrade has changed the IVRS DTE UID for a device that no
> longer matches the UID in the SSDT. In this case there is only
> one ACPI device on the system with that _HID but the _UID mismatch.
> 
> IVRS:
> ```
> [1E4h 0484 001h]               Subtable Type : F0 [Device Entry: ACPI HID Named Device]
> [1E5h 0485 002h]                   Device ID : 0060
> [1E7h 0487 001h] Data Setting (decoded below) : 40
>                                     INITPass : 0
>                                     EIntPass : 0
>                                      NMIPass : 0
>                                     Reserved : 0
>                                  System MGMT : 0
>                                   LINT0 Pass : 1
>                                   LINT1 Pass : 0
> [1E8h 0488 008h]                    ACPI HID : "MSFT0201"
> [1F0h 0496 008h]                    ACPI CID : 0000000000000000
> [1F8h 0504 001h]                  UID Format : 02
> [1F9h 0505 001h]                  UID Length : 09
> [1FAh 0506 009h]                         UID : "\_SB.MHSP"
> ```
> 
> SSDT:
> ```
> Device (MHSP)
> {
>     Name (_ADR, Zero)  // _ADR: Address
>     Name (_HID, "MSFT0201")  // _HID: Hardware ID
>     Name (_UID, One)  // _UID: Unique ID
> ```
> 
> To handle this case; while enumerating ACPI devices in get_acpihid_device_id()
> count the number of matching ACPI devices with a matching _HID. If there is
> exactly one _HID match then accept it even if the UID doesn't match. Other
> operating systems allow this, but the current IVRS spec doesn't explicitly
> allow or disallow it. Output 'Firmware Bug' for this case to encourage it to
> be solved in the BIOS.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Use FW_BUG
>  * Update commit message
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Vasant Hegde <Vasant.Hegde@amd.com>
> Cc: Paul Blinzer <Paul.Blinzer@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b19e8c0f48fa2..06f747d2f964c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -109,7 +109,8 @@ static inline int get_acpihid_device_id(struct device *dev,
>  					struct acpihid_map_entry **entry)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	struct acpihid_map_entry *p;
> +	struct acpihid_map_entry *p, *p1;
> +	bool fw_bug;

Initialize these variables?

>  
>  	if (!adev)
>  		return -ENODEV;
> @@ -117,11 +118,26 @@ static inline int get_acpihid_device_id(struct device *dev,
>  	list_for_each_entry(p, &acpihid_map, list) {
>  		if (acpi_dev_hid_uid_match(adev, p->hid,
>  					   p->uid[0] ? p->uid : NULL)) {
> -			if (entry)
> -				*entry = p;
> -			return p->devid;
> +			p1 = p;
> +			fw_bug = false;
> +			break;
> +		}
> +
> +		/* In ase there is no UID match, but exactly one HID match */
> +		if (acpi_dev_hid_match(adev, p->hid)) {
> +			p1 = p;
> +			fw_bug = true;

I am not sure why you dropped counter from v1. I think we still need HID match
counter so that function returns -ENODEV if HID match counter > 1?

-Vasant

>  		}
>  	}
> +
> +	if (p1) {
> +		if (fw_bug)
> +			dev_err_once(dev, FW_BUG "No matching UID in ACPI tables, but found matching HID.\n");
> +		if (entry)
> +			*entry = p1;
> +		return p1->devid;
> +	}
> +
>  	return -EINVAL;
>  }
>  

