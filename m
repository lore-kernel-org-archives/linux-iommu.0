Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBF2253B2
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213535; cv=fail; b=AvqkjuKp3PaEJJv9VJpO5iI4CjzLnj9bmkRPLXVtXKDNdZjT+RRZdICkeFJLODEtXWEhCqwrwzBRK1DIXWHkTr5weKCnrlFcjI1mcbqXuGFaZRh+LGA+hS+fuQeCqNGT6GJW9w5DzmdX4S14KTnXgRLTzmWqxZK13wKuACLd5T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213535; c=relaxed/simple;
	bh=0eMYaOy64Bjikm9GaiPegssB43wMX4CDFtokxiEBJhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2QxyuNqax93DX6LhlhQFrHAh7hTK+YzGimdwbxoruRFmBybDQR45rtBIaT7LC82/721I6dEvd8wsjSbvltpHPBhoQHe2p9UmPBhFvu5PYa6mfdd5b5cLxNFFKtfm9vLPrWXBoh7j+OOehXmS+uBJNMYVE08HtRrhK3ADhd3ReM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WCiZ30X+; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WCiZ30X+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmDJUS7bAwZL1Zl9AMuxv6ne1yJA7qUc4y+SEGuaam1nzlpBcBUNUkKdMj+NNt+Erig/H5DwHs9T4Ol2xlAZbdviuFcBWi7H/KN/loWuk9XBpRr6F0BJCflyKRVTowi1wmgJV0OC2YxxbuPyMz7x6+4tTBw8E7RTR0kIuCJkYJlhH05X0t9t0Lfa9aLoMJf2TbaXnm7H/fGC2c794ZLeYkodbRBnKNvRCCIJvmjfyyfsvqa0fuFjAGR66DSjwKbHJcTUZPTvCill9hQvDGUHE9c+eZmqS8zJqpgduZYM+g0ZSg7onbQBIJOXeGkNUCGclxnhtQXaBxSH8js4FQV/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sdb72eQn0J+jbdI5ZDjLNScTNr+l2cLlT9yeLgIc6BE=;
 b=sHg9KaeuCRs9ELMg7ROKXN7uwpRTFRUWcORidV6Gd65Xcv8tHW9XN59DbGPDlLVuPkH4zncURGhIJHGtcNbW+vDpBUSTtfrWAZsaWgSRI5svqmu7YnvhJFccsrR3DpjT4+vWsznYDRVV4MnW1CnXLxfR67hs2DjN7ivLM+yB5562fcx3+dklyCr/ndj3M/bTjUAZkhKExWzkcQJAAxFHGntYV3GwXCAEqXqOFNP7zAWRa5vP91iUfARMskxqW4mT/RKstFoN7f3BxuRcOmIUrN13LsXn5OYPjnaLswhqseZ2i0G/yhYC8ziP3GYiHBaf4Wt/odbDnkC/tnxUO9vtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdb72eQn0J+jbdI5ZDjLNScTNr+l2cLlT9yeLgIc6BE=;
 b=WCiZ30X+4ZDj1BIrekH3fGmAaZpjtm34PUP40krbX4gmch4H7fHUn0pyBDKvSMh3M5I4hPVzZ8K+cTnaZ6fG3WdbEQlRi5u1AYdmMuXabi6cIIeQ8Xti/HUHcaCSFwGimdUkSh8hplJ+mWjX1v6H3s3Mn+iUuTMsL4nyncUUavI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 09:05:28 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 09:05:28 +0000
Message-ID: <01af5c22-bc02-48d3-bcb3-4e998cefcdb7@amd.com>
Date: Wed, 14 May 2025 14:35:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/amd: Allow matching ACPI HID devices without
 matching UIDs
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 joro@8bytes.org, will@kernel.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Paul Blinzer <Paul.Blinzer@amd.com>, iommu@lists.linux.dev
References: <20250512173129.1274275-1-superm1@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250512173129.1274275-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8aa194-50fb-4ee7-bb31-08dd92c67864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0Q5RGhTbXZwYkFYS1RRdnYvdVR4azRTWEJmRmhlZEh5M3FIdC9lTWNCakpV?=
 =?utf-8?B?MGR2eUtkakdoeU1QWTI3S3NjNm9NRmpQek5naFAvYWRRc2Rvamh3V0RVODRx?=
 =?utf-8?B?UERSZ3IzYmlMRGpZWVM4ZEtpZ05mdmNJUVV2bithUEhDREUxRDUveFI3UUs2?=
 =?utf-8?B?QU1mdjF3NTVreTJrd3NrSmhOeTRXOEdpU0EvZHpSMFBoTWhhWWkrYUI4Wkpr?=
 =?utf-8?B?SDNvVEZzMTI2NVNNbzlOUWVyOGxycE9zZlJoYnFTaG9lQUVycnd2dGVzM1ox?=
 =?utf-8?B?QnJqZjJjS1pTbGhYcG5QMC9vWmcyUWZIMTdEY205ekdTZnk2aDJkaUJrM1gz?=
 =?utf-8?B?K204Q3J2aHk1NzFYVVJrMDNlZUxWSTcrQXhxdCtjU1MvY2UzVy9VbkZmV3pm?=
 =?utf-8?B?dXUwNGdpSTcvRHVHM09IajFSYlhFRDBtV3JnRmVGeWtRMkRDRG1mcEpmamZ1?=
 =?utf-8?B?bTljZC9QcW9NYzN2dXRJUzNtblRnMUxYTHlnK2RrUU1tcGZVTElkZGk1S2Ix?=
 =?utf-8?B?VlFDWEJVLzRadURPNXJVcExKanY3RmFuV3ZybVczZnFTK1gzUlhWNkN6Y0VP?=
 =?utf-8?B?Zkd4UFpHdnRTakxRdEhIZURSeFM3R0QrSldJeHhrdG16OTUwSEVPOWg1dXh3?=
 =?utf-8?B?Slhnc05YakRGOWpwUXpETEhrN0doOStLRm8wQmIwR3ZDaHF0c3FDdThLYjVx?=
 =?utf-8?B?dUhSTHN2MjJmU2RrbGJNeE1WZUVxVXVpSTJydkdSNUEySlplNXdBbGlrNnBY?=
 =?utf-8?B?eUZtVURPZXRQRDVaRzNCQ2QzVGdyVUJ5R0JtVEZ2YTVWeTBpK1NJekpzajJq?=
 =?utf-8?B?eHlacmI3WVBZdk1nSWx0aGV2RXoxL2hCM1M4VkdpcmluZUgxM3B4N2YxbmZW?=
 =?utf-8?B?MGl5U1lDaTNzREJWVTVPbE5mZUNWNGVULzhweS9YNERieG1XOUVZWjZ2dTAr?=
 =?utf-8?B?eHNnWUVJc0Z0TTl5MnlhLytKa0dYUm9qVElyNlFyUHhqNUpHdzVQQU1YRS9J?=
 =?utf-8?B?NE51QUEwaFlhM3p0d2I5TTQ5UE16UldqcnphSjRHcW1xT1NLM3BZK29TV2g5?=
 =?utf-8?B?SENJcVhvbUpyUU5wTGwzNmFDTU5PMlg4NU1iUUErOExJdW91M0lSd2Q3eXA4?=
 =?utf-8?B?S0xsbEEwNzY5aHlFK1AzSTE2ajVWenZLRUcwTEhvTGNJMDgvNi9VZzVhbVNX?=
 =?utf-8?B?WFg3NGEyUlVVQy9xZzU4UllIT0FjNnlLWEdSNGlJemhNQ1ZlOVN1V2hod0Jz?=
 =?utf-8?B?NjM0dWF5UmkweWZNVVVDUkFzQTRjRUp6SDcvaUVQbEJiWk9FNlQxbDFQMmhO?=
 =?utf-8?B?Z0ZMc3ZqcUJRT1MrVHFIUnJiN1JTQWkwTnhqdmsvb2xrdHlSSGpRQkdUajE3?=
 =?utf-8?B?WEpjeEFVR3o3VWd5eUNyZ2ZCT3RjL1ppZDFKSmNrbmw1ekhGMWhlSUdtSWNh?=
 =?utf-8?B?SmcrYVZqalZLZWw0bS9qWTllMWlZRmhTQXUreGl4SUdBQUFmL0pPT2NzUCtv?=
 =?utf-8?B?Q0JvbjU5anFERWhneTJyb3lScVd5eTFVRHJRcE5qM1FtOCt2MDZyMmJvM0dK?=
 =?utf-8?B?Qlk5TkI2Z2tabnhVUnlJbnpSU3h4eUxxUnp5dGJNejZZQXhwcElLT2NkbW8x?=
 =?utf-8?B?Tys0UHpqdkhqeHpOMWlNTTJsNFlUNlVSalNZS3M4ZkRwRDA1ZkZXbFBVUzV0?=
 =?utf-8?B?UkZtTWRGVG84d0E0cDZ4Q2RDcnJXWG0xcUFvY0hib1FFY2ZDWUNMbzNBSW4v?=
 =?utf-8?B?R3VUUW9vT2tzdHo3ZHloSThPU2lNTTVlMFlEdktjNXZpTjV0ZzhtS285VSt3?=
 =?utf-8?B?TmRWN1dGQUhIWXVKemZhV1B6cHBCWVE2N3JvREVpZlFHR3J5QzBmTXJJdXI3?=
 =?utf-8?B?K2ExTkV3YldNaTI0Mkx0SXRTQWFZQmJZL25hZ0hxQi9lUWM0OFpPc2dSWmhs?=
 =?utf-8?Q?UO8ewOA8BKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0N4NENQaXJiVjQreUxUNzU1RHpFc2pRSVdPdysxaDVheUd1QWxRMUk4dkd6?=
 =?utf-8?B?d2wreGI1eTZOQTEvVmkrbmJ3UXg5YjU2cnlSZm52R05uNGRDZ1VzcmtnSk5z?=
 =?utf-8?B?cDZTZG9rQklSdTNHemVTbVlQYzBvakVnVWNjaEI0b3p6QU0xSHprUlB2NEdN?=
 =?utf-8?B?dnhWbnRtQ2ZiMmdtV3NGVHg1akE5OHloVmdKVFAxRmdjOEsvazdienpZRkhQ?=
 =?utf-8?B?ZUlwMkI5QkgweERZcWxqRUZING93VjFMM2ZxZkFMTlNMd0JJY3VKRXZVZzV0?=
 =?utf-8?B?VVRoTDlodjFQdTFFMzhkQ05wMzM0VDZBUVBZZXdxZDZPL2sveGF4Q3RQc2tF?=
 =?utf-8?B?QTJrM0JCd1ZVNmNnM3RIc3pnZXY1ZlByQVZMSTNVSmZEVHdWNk02NG5pY0FT?=
 =?utf-8?B?RUtuT1RKVUVMWDVocm9QMmJTcjJCandQbjJMQVJkVWZDM0N3N2NobmswWUpN?=
 =?utf-8?B?Tmx1ZE9zblR1TG9zT05RZmdTVnJubUdPcFgyVUp0aHZsWkJrbnZhUlFybDU0?=
 =?utf-8?B?MVFiMVVSTHVpV3N4NlRFQkVuY3lZV1ZlYW9nazZaM0xFb3M1eEZkVFN1L1NL?=
 =?utf-8?B?SjNzdERpR1NIcEM0OW80NmFSNGViRmNVZzlzTFVEM3ArK1U5ZnpPRzdVeFJT?=
 =?utf-8?B?WXUvWmU4ajVVWjdLQnRkYjhEaTViSGxZRElWZ3FJclFLRHd2d3RscVY3VGFR?=
 =?utf-8?B?cTZDMDRQUkEySVBYei9tL2wzRWhQc3hrNmFLa3FsU0JKWFBMUCswalR2Q2x4?=
 =?utf-8?B?OFZ1eXhNMSs1dStoRko2TWVXOUNUbWVzMkF6bEo1TWJRT3NnTG5JVi9Md3V0?=
 =?utf-8?B?SzlpNU56SmpVcEFxUW0vTDJoWUNMTnFxQ3VBZXU1bG5CcVJzSVhXWFFJdmxH?=
 =?utf-8?B?eFdsT25QNXIxVzVmNE5HYkltd2IydllmT2Q1ZzF3QlpSNS9aNUwxNEdNaUtY?=
 =?utf-8?B?eFlqNzRiY3Y1VU9Oc29WeVdPRjNBTUZDVmxuNUk5VGxIMzQ0MmpyLzNCenFw?=
 =?utf-8?B?LytvcWhNS0I5Q1VJbUR5aloyaUdUUlRKNUpBMFZxTVBNZTlnaHJqU2NuaElO?=
 =?utf-8?B?RzZNRmQzMDZuSHhtaTFsU1BnWUtmVThyZlpWTXRlRVczNENUU1dQdFRIMHdq?=
 =?utf-8?B?UVpmRkVvU1Q5aEFiaUNVS095aU94SGNSeHFYRmFjZk5KMVdlZTB5RGpuZmkw?=
 =?utf-8?B?YTZXejVhNzM4RmRTYVptUE84KzRqWXI1U2ZQZGpJd3FsYVRJVnlsOHhXNGxV?=
 =?utf-8?B?R1huaUxsWkZITURJc051V0YwMVNhM0RrUkdkMkJpUHpXdWhJQUF2Ni80aTVm?=
 =?utf-8?B?bHY3Q295N0x6UWQ4Slh1YkkrYkhEZ2RmeTQ5c0swTnlRVERQK21WeVA3d1hn?=
 =?utf-8?B?K1dLM3dkWThmUmJvZ3J6TDZHUUJvRU1EMUowV2N2dVdDMHk2S3duQU1Wd3hy?=
 =?utf-8?B?ZGFnK1NSdHJJUnNZQWw0cDZQMGxDVittS1NENUQ0ck9tcm9KRTBqRExsUlVo?=
 =?utf-8?B?N1E3b0VCcEdodFEwOU1VcjFrS0x1OVdUZGI2c29GMHBtZ0h4a0NHWUVGQ01P?=
 =?utf-8?B?MFNiQVJBM2xuaE5jajlxa3FzRFBlbWZzbDg1MjZOUlN4Y2lXSmhiMkpaZGN2?=
 =?utf-8?B?WUQzRmY1dm9oRElSTExrcHhTbjR4UWdxL1p0MmFWRGdCRENLZTVuMXFsanVL?=
 =?utf-8?B?UFYyYlgxN3p3SGZlOW9oSFBYWmZ6QkRRTHZsK2x6a1BZRU43TGtzTnpMaW9l?=
 =?utf-8?B?RXVhenhHeGg1NkNGQldmemxySWxZbnlhMXdSVkszd1NXNU00WXNDL0lueVhU?=
 =?utf-8?B?UU5wa1huRzhYVSthVXY2ZWNMNktiYUE0YXJoQXdocDVNMVFGbW9WUU1ndzBq?=
 =?utf-8?B?YVJKU0RISkhoZTVGSmMzblhMbDNJLy9CVGl6OHJaWXVGWU9EZFd2UWRJVTV4?=
 =?utf-8?B?TEsyd2lJaXFEd3ZOYWQ1ajlMWVlMOVBVbU9RS29RWWdzK2g0NUsxWUxpVm5o?=
 =?utf-8?B?WTNSeXNGVUQyK2Y5MUNyVDYzRERZOUpDMkVqU1JYa0drZGN4Tzh6NktiYWYy?=
 =?utf-8?B?WXFBVkxlZXE5MmtsWTUzc2YvZnlnM3dGVjgzYUttNzJQS1JEaGovZmJuRDc1?=
 =?utf-8?Q?TpeQwWSSaMKIVQDoZGmPvA5qa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8aa194-50fb-4ee7-bb31-08dd92c67864
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:05:28.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMffctomQ/8GFZTDavJii02vODpd6p/BuhKPVu97qQUVvO03xk65Deu2ckDM6z4HIsN0QXJSHlkFJ+7T4d9x7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690



On 5/12/2025 11:00 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A BIOS upgrade has changed the IVRS DTE UID for a device that no
> longer matches the UID in the SSDT. In this case there is only
> one ACPI device on the system with that _HID but the _UID mismatch.
> 
> IVRS:
> ```
>               Subtable Type : F0 [Device Entry: ACPI HID Named Device]
>                   Device ID : 0060
> Data Setting (decoded below) : 40
>                  INITPass : 0
>                  EIntPass : 0
>                  NMIPass : 0
>                  Reserved : 0
>                  System MGMT : 0
>                  LINT0 Pass : 1
>                  LINT1 Pass : 0
>                    ACPI HID : "MSFT0201"
>                    ACPI CID : 0000000000000000
>                  UID Format : 02
>                  UID Length : 09
>                         UID : "\_SB.MHSP"
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
> To handle this case; while enumerating ACPI devices in
> get_acpihid_device_id() count the number of matching ACPI devices with
> a matching _HID. If there is exactly one _HID match then accept it even
> if the UID doesn't match. Other operating systems allow this, but the
> current IVRS spec leaves some ambiguity whether to allow or disallow it.
> This should be clarified in future revisions of the spec. Output
> 'Firmware Bug' for this case to encourage it to be solved in the BIOS.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Count HID matches as well (cover # HID w/o UID > 2)
>  * Drop level of indentation with early bail on error
>  * Show number of matches in error message
>  * Adjust commit message
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Vasant Hegde <Vasant.Hegde@amd.com>
> Cc: Paul Blinzer <Paul.Blinzer@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


