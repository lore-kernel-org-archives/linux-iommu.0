Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12241DB15F
	for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609950; cv=fail; b=IF3K0qiE4bCa9HWhZj2voxIrb/3lFGSu4Hf5LrPM3R1HVXawQyNz6YNgBsTe+XNU6G4tVmlS7oJ85s+RzTsEfPeQDTjX4qk/SC0YEvsDsVIwTAgMvqjmHkmulGM/StLBi9MXS/FDLnVX5HYUHuZMLKQwbJnnBx45SBkwxTbEFZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609950; c=relaxed/simple;
	bh=F9ceNsT5572DAJE8YwULGSJfSPr2fffwwXZwfsUSGeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sHWKT1ER27LWQWUJSMndflaisgZCTWxBGPBxyGf1sdCVyFSrquenAm3/ywkXKnFyVM7SFC4C11nNSe8kGQCxXmx2j6xwqX3dagxoFKZV1QVmQyU8GzUBFKUGbJiyZkqHSPpIMvR22GlqCiIhhGMy1fiHUBix1PgR/Lp2by4TtkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1f12s7a2; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1f12s7a2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYvROgxPFbFKAjWvIQcPPJ+4pVZVuot+5CgwabcURxayQ+2Is8Kq65kbR/Q8OauWMyYQouI4tkBYj9NEp41SpNZVZy36C4nax3DG8/yY61NV68gQ8th1E5Ib0oYWIWBmf6UBWIm7EHBwgSlkq9gmcjQ6Y5cAOHA3X8PHz1cwlkqwhswk4+YkiVx5Q9EX3KsvrHcDqZY3mMSpxVLeZmUlAp3b75bJh1XlWASKWaPkDKGlASBnx9WIsOm+xQ4zBz2jtPh0TQnGzW9WMsVSlEvc5v1i/J4Q2B2ancgmCTrPqE7lsnQE0Eo+N7L7vG7BBzIOGmKmUUHG+Zc2rqTeLH9WjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WwoWedi7r1PQtEgfh2WP+CxO8DT4wM5d579Ei74jJM=;
 b=JLn225oRQgK+RbCHq3QuIoSmzlNkMhONlsN983uGpr956aE69bThrtASsPY/LjGXJe8ZNhbhLTyjhv8xo1VMrsUqSutrLiL0ozQpEN7076PhRfsdun0Q/74DQkq7mxKLpFYBS6Tvo8jSBLlNguXMJeK5hKLFC6ivqIZi/T2TihSBCMUM1KzCUxSlNAngC3ggveIwqMrvDKAJiW8/bkMT4uK9Nbhvxn/Q/0Oxdi/7AbS6VduLsJ7+dvgGzaG0Hrhx371i1jacYltBNCuCbPqDj95aUn6iCVSTxX0q7dSQJCIku33/7qS+ZkpG109L36rkTXanK9ZfH2X9nXvmqzOoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WwoWedi7r1PQtEgfh2WP+CxO8DT4wM5d579Ei74jJM=;
 b=1f12s7a2RlsU6doVRT9gjbe7V2ighDM3/vQHv6hg9N1HHrZKuRJsE8uL7hJ/2eQg3dLNLVOfOhDrDrdtCvoeIMn5aY7hOVfzXEk7NtOoU7nCL4RiDXjq5n0aIoHgiiM5Ld5rmsLwadOTl86i8JOXwy/AADiIHKI85ReVY+tRPI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 16:59:05 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:59:05 +0000
Message-ID: <a9725264-8d8a-4970-a519-4ca415ce21ee@amd.com>
Date: Thu, 11 Sep 2025 22:28:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Add support for hw_info for iommu
 capability query
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com
References: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0092.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 785105ee-3b1b-45ab-dbff-08ddf154840d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZYamplcmFpSW9XQkh0b09XN2FRTDVaMks3ZXRhTXhUYktnaVhSOWZGczM0?=
 =?utf-8?B?OWlDVG5qYzR0L1ltUWZUMk53RXRQcUgwL0NmVHNzTTdFVk15TmF3NW9uMFA3?=
 =?utf-8?B?Z3RCeXFnU3ZuczVYekhjbFBvajlDdE1rc0lPK0lreDlxeGpDeG5PVTNCRHhj?=
 =?utf-8?B?ZjJ1Rm9oemhrQzQxMk1CYUJJUXVNZ3had043cE9sSm0vLzIvbVNwNlhsWm5a?=
 =?utf-8?B?YWxrQ0VWMzdPUC9NR1NwSGpHWWZ2eHMyVmd6cjB5dG8yNHJ4Y3hhZHN1RHJL?=
 =?utf-8?B?bVZDWmRGRDVQOU1FY0VEampUOTBJaVlFY0dlRXBPNHNwV254TWF0SytEcW93?=
 =?utf-8?B?bU0wSGN1cjFveWRIVHpnZGtsZjcva0U1eXlYSmlVdlNTQnNaUWY5S0ZCaGVV?=
 =?utf-8?B?blpxUlhxWGxEWFVhQ2taWWFPNXViOEp3ajhEYTRNVG52eng5M2xlNjhTVnZx?=
 =?utf-8?B?RzFucDhTdTduMnh5VUtvejArTG1Kb3VvS1Y2VDEvUUl0NEdtSFJ5OVVndnFK?=
 =?utf-8?B?eml3L1pDNVVPTzlTVDNmNEZodlg0Z3krdTBiK2JrNzhHV3A4a0U5UHM4RkN2?=
 =?utf-8?B?N2Z1QlE0Q2VUUmlWZnpwdmhUNTQyTzl3RFZHaExqbldYNnM5OERjbWxnb1pN?=
 =?utf-8?B?SEQ0UkRtV0h4Y0ExYVJ3RXFIRVRWRUJ2T1dEQXpLMncyZlVDL1JoQ0dtQ3ZG?=
 =?utf-8?B?dHZ6TUhVa0wzd2hZSFVFQkxzUG9DRFBQRHNncVBXRitHWkxPR29IUEJMU0JR?=
 =?utf-8?B?RFBHZmhpZWwzSEtMWDlIREU3NE5rVFRiTVZ3RDdLbE1VdVN6SFlRR3RCUFZk?=
 =?utf-8?B?QUducWxxUkNRendjemJqUVVCVjg1emtNUEVxLzV1UUlJN0VpYi9vckN5eWVl?=
 =?utf-8?B?S0MwU0Y3OEg4clBjd1RkdHVSOHg2VEt6aTlpR0JuNndabGtMMVd3bnl0Nkpq?=
 =?utf-8?B?S0pLeDRFc2dnMnE2NThIZ3NpTzB2OCtCWVNhMTIyeHZrYnIzVlA0ZDBnL2pF?=
 =?utf-8?B?WXhNeUFyaVF5QkNYOUUySUEzRmNYOXRnYVJ1cDljb0lqcTJaZEk0ZUNUSGk5?=
 =?utf-8?B?SnBpbTBvRFJKaS9TWGJIVG92a0ExQU5vY0RYS0l0OHhZYTVRa0pRK1lMSHRZ?=
 =?utf-8?B?Z0dUYy95dHBvVm1JNHBBcFlIOVhOTjhiZ25HZ241WjhYdTZOSStRdzZTckdW?=
 =?utf-8?B?R29Jb3R6N3g4KzY3ZTAwRGwva0xEV2k0d2ZMczQ1SnNMTTBKbnFoallTQUwv?=
 =?utf-8?B?OW1lRWt2THFMZXU4dzlQd2wwSW1zLzViU0Q0VEE4T2JQUkIxTUhLd1JNcTNE?=
 =?utf-8?B?VDdaVnBMUmpmaXg1cmhYTWROMk4ya08wbG1kOHhQRkZYSWdvY0piV3FGUGdj?=
 =?utf-8?B?UFJvT1I4MmhBK09ZYy85UXB0N2JNcVh6Z05McVExaXNnb0FqZzFwY1gvTzBl?=
 =?utf-8?B?R1ExaEx6SWhudGErcGVJUDVpUCtDcWhJQVIvN1FDVFpDRDR4cEwrejdpVDJZ?=
 =?utf-8?B?Nk1Ea1JXZ0RIekRkRTlPQnB0REpMSGdBVWRpWDNsdzArN3JvbGhXL3c5VFZ6?=
 =?utf-8?B?TE5IV3d5TXlxd0xJbXQzdlhvUUM4UUhaYkQrVUlXdFlHdVcwcjY4Rjg2MWJt?=
 =?utf-8?B?RGMvZ0pPZjUzbTRGaHd2WkIvUWtzYU05eFdXNFdGamJSUzJmTGxxU0dHVWVG?=
 =?utf-8?B?dVNVRUJFVGc4bzNEWXVTcXZWTEVVdW9FaldaWnA0RG5tOHdZbDVhRk9ZRFdp?=
 =?utf-8?B?cEdIdTJScmU0NmJUQXpEdXN0cm1oSUdXbXFpY1lEbTNMaVBaeHdnelZEZzg0?=
 =?utf-8?B?UFJ6OGNRczkzUTBwb01WdW9RY09SeDBHbklwZUZqTm1Fa21yRjg5anJjOFE3?=
 =?utf-8?B?YnJTRm5UcVlqS2hheGUrZGZkb0lQVWVnaXBwSlZXa2NkWXBwZE9leFIydVFO?=
 =?utf-8?Q?/BElGAyL5WM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC85ODY1dTdpczFrZ1p6V0J3YkZGYk5vQWx1eE4vQ0lrYWNWRUVhZVRodGNu?=
 =?utf-8?B?NjFOdXE3ZUZTMlVhQUMzQm5HaG1SRnJhUW9vZUxTNzM1R3N6dDZRTExlQ2Rm?=
 =?utf-8?B?N3JlUFFEeEpJb2kzMFgzaFpIZEhMMkU2bk0vajgvY0wwQ0FGRTVqc2g0elRX?=
 =?utf-8?B?dGo5OVYycTNqWFJQZEZIV1pkYVNFeTRoVmxKcWhuYk5ZcGFVd0F2dEJENmdT?=
 =?utf-8?B?bE5PQ0RKWnhhZEhlRjdVNUZGTkZRUTZ2SVh6R0F4SmtsUCtMQUdSbENRbjZr?=
 =?utf-8?B?M1V6WHltUjRweE1HVTRCdzk5OE1oN1pPRXRqS3VOdlBkK1d2WGE4NkR0Q3BX?=
 =?utf-8?B?YW1OelU4OExzM2VYU0VWL3ZTMUZ1USs2bjk0WWtLZXR6d2JSK2M4NGZiNUVR?=
 =?utf-8?B?M0RGbmVHSFlXRVM1M3B5M04xOU1SNHhUMWpxUFNNSnk5ZEFUclZ4Z2FUcGNL?=
 =?utf-8?B?MnB5OHZ3MW5QVWh3RlE4KzgybnZOSGJuY2xxVTRHVHZwa24wMzFSbUhLOHVX?=
 =?utf-8?B?YVlXaVB2RlFoVm9ibm1nUStYOUg0RGxXOXk2c09ybDlia3gzZ2l6aS9WeUNz?=
 =?utf-8?B?K2pWWEY1SFhIV1BqYWJFUEJUQnlOWGJ6L1lBUEwxNFVCVjZJME5WQXNBVlM1?=
 =?utf-8?B?RXVsTWxKMlUzeEM1TDJRVGw0TWlPYy9mcDVKNE9objRVVXNUZElDaEQ5bTN2?=
 =?utf-8?B?YXBrYzRsUE93VWZIdE4wYWZPemd5cFJwR1pGLzZOQjlwOXFuN2NLdlQ2OTJJ?=
 =?utf-8?B?MVZYbFRLbnVhRlNPZEhhNVY1aXQ0MFIvUTF6SEt0aUhuNGpTOVNaWEhNbzJz?=
 =?utf-8?B?MHUxQjlRditHaU9WelBxZ2hlM1ZUVlVkdVQzMmFobnBtK1h4TDVOMzBnQW5P?=
 =?utf-8?B?Vm82Y1lZZzZpMHVsVUoxWEhzelE5NVYvVXVIbllncmhLeGNqUm9hWUc0ODlV?=
 =?utf-8?B?OFZ5dnFQeXB3MDNkZDljcWtkanVpNzRYUmN5a0tWeTdxdmlpdkFFODhhYXRG?=
 =?utf-8?B?a2hvU29vamJCRjJCRUJ3MkZ2MGw0b0JJYzYxVmVNSUt1elJKQkRTU1ZnV2Uv?=
 =?utf-8?B?YzFmVmNtbVF1Q3F6ZDNtaWx3a1FCZEhEWFJTSEkzeDJiSStRZkEvcEVycjh6?=
 =?utf-8?B?bWxZYUJjdUZNM3hYVENBRW1seHoyTG1hMWVVbys0K3pWNklLS2JOVVBoVXpX?=
 =?utf-8?B?Z2lIVXNlYW44eURVRS9QamtYOUJ0dHdDWXZnOURKNDZIdFJ5N0VyUTNmZjFE?=
 =?utf-8?B?T2xEbHlHTngrZWJvQld0dkI4UmdTbDY2dE9DNjFHb3NPVVQyS3RyRXltU21o?=
 =?utf-8?B?ZWp5bjVia0VPRkJ1cmx2cWwybXZMRHV4a2p1R3pyMEVhbktjWHYxWDFMUHp3?=
 =?utf-8?B?UVdtRTB6TGhqN1VJN2x5YzlxWHA4RmlKekZhSjg0NVJ6WXBiQlVYUG1yT1Y3?=
 =?utf-8?B?QUczMklwQ1ZkSStabk03VkNUTGJnWlphQ3Y4cEJKRjREK2s3Q0svYVBvLytS?=
 =?utf-8?B?QThPME1tVms1QkFHbTdLVkpGYkIwV25YQWM2NjhNdzlkZEx5aHlZb29LU3E1?=
 =?utf-8?B?d1BTZU1CQ2FGaVpVUmVSR0JnaXdGMFUvNGlrM2w5ZXp0elV6YlhJdGFFcGVz?=
 =?utf-8?B?c2J6a2tTdWlBQW5TOU45U0lHcjVEQjBiUnc4MW03eC9ZQTIrakMyNHhtUmZR?=
 =?utf-8?B?amtueXNaS21ZNTRWbXRLenFIYXd6M0NoWEVVRVB1cWlKcVdoTFVUcXovVjZj?=
 =?utf-8?B?WnRLSjJsRUtqYUpaTU5CMTZkZnNmZDhVekFDd2pUczhaaTFVT2JKeGwxQXZs?=
 =?utf-8?B?ZnJKUVBRL29GRlJ6NVJ3UUM2Qy9YLzhsQ0hUMThhZHlPc0VEa2Q5bWtTQ3l5?=
 =?utf-8?B?YW90TDNPV0NhVjV5bHVYNXZQMmRERllEU0cwbHgyVTRNaHNVWEYvYVM1bUxM?=
 =?utf-8?B?WENYaGFVb0NYUFQyTExIQzBDd0p3MUcvQWJ5Q00yeW05enRMOXBBeVoyR3dY?=
 =?utf-8?B?bE5iR1VFK25MdStqK2dYTkthVGFTay80azRsOURFT0VSQUE5N3FYM3lzbnpX?=
 =?utf-8?B?WFBqQ0JMekhOM2N6SXZHTGJFWmMwRzZtMEtLOWhCcUh1WWwxbU9KaE91dFl2?=
 =?utf-8?Q?AimxZkCcJ4qDGpIF691X7kE5D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785105ee-3b1b-45ab-dbff-08ddf154840d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:59:05.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAFB5aQqpe3tqnZptroNockdidu1Bmaa5eQqaEA3ErU8nT7UTc1thzS3PZH8N375WMU/fOEe9dgExGQTDbYJdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501



On 9/5/2025 1:01 AM, Suravee Suthikulpanit wrote:
> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
> specify features supported by each IOMMU hardware instance.
> The IOMMU driver checks each feature-specific bits before enabling
> each feature at run time.
> 
> For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
> amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---

.../...

> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> new file mode 100644
> index 000000000000..72eaaa923d04
> --- /dev/null
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/iommu.h>
> +
> +#include "iommufd.h"
> +#include "amd_iommu.h"
> +#include "amd_iommu_types.h"
> +
> +void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
> +{
> +	struct iommu_hw_info_amd *hwinfo;
> +
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_AMD)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	hwinfo = kzalloc(sizeof(*hwinfo), GFP_KERNEL);
> +	if (!hwinfo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*length = sizeof(*hwinfo);
> +	*type = IOMMU_HW_INFO_TYPE_AMD;
> +
> +	hwinfo->efr = amd_iommu_efr;
> +	hwinfo->efr2 = amd_iommu_efr2;
> +
> +	return hwinfo;
> +}
> diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
> new file mode 100644
> index 000000000000..8b726482778b
> --- /dev/null
> +++ b/drivers/iommu/amd/iommufd.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef AMD_IOMMUFD_H
> +#define AMD_IOMMUFD_H
> +
> +#if IS_ENABLED(CONFIG_IOMMUFD)

It should be `CONFIG_AMD_IOMMU_IOMMUFD`

Otherwise patch looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


