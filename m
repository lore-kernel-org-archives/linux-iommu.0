Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3133845A9
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272494; cv=fail; b=Jd+q5Ty+ofggmRoNyF6+c3B7BZTWIX2xKdU7B4JL2BJwshzrIA311y9I1GVkbe3MjUp2fksLXUVZAlKhu9e9+HDo8ZjYA5r0UJpRyH4bKRTP1ijZ2ZLPwnqt7Xq9mXiughwh8sdV87WmJZ/d9PkeC3UBF7n+PKlXUIowWkznLWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272494; c=relaxed/simple;
	bh=xV/ub6H9Ep+DlcV0DmnIL884qW5EYn/8EkPyAx1mAyM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/uwyzqCmcqKZbPv0NIRT+4pQlte1MflYwcqO0vJMRIatEOE4PxE2zrSzTKjS/melHKswRqtRbrG6VizvVYKe7jtcoi+LaTGheaeQbqE4bdto6PW3OI/oJjLXRcWRxldi8nq7BwPg2sDYyD962KMwdCeGrPB7Dom6g0EBJKdPrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SN3yFOJV; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SN3yFOJV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9KtL6uIA5bu7saJoTG/c+BfsALKtA1Y9hQMMQcVQI2RsNYNxBkFJdYeTYU1xor7/U5WPYiZqeQ5xSb2y/ZnDs1T2i+idO/JIJ1rQj0shBtEMgUpB1A1at7VI2AWmBbpnjd+t2uL6N7s3JLSBLk8mClq7M72S/J406KC9nPZs9S83S7Q/HDpMvvIbjKjVtxTCOnGRHFCMl3SCBj+Kj0+I0EDAIlArTdv9onvbZdPpmIqAlIJbLxuEoQh/D4ZxVP4oA7VCYLPWoNidYXmd1C2PgdbUQsw6+s4sU43DkYJwUT9YWoc8CdCbwaAQWi3MSqGpb/Z+kzl8+t3GkHp80BLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRql1bTIBGudgYRR3QQnb9xOmDNINWLJGyJxA4sH8QA=;
 b=e2jCv83KO3IfKEKSVmp1EU43iZRQzo+gZbHceNIX7rx3zNmns84qfK6Xi0JV/KL62VaA0cN3o2kmAUzpp+yur1shM8Quk9ZD7rB5czP9sUm5hDlYAJnU6T6WAfKun3fXF/mkgWZGr92O8U0IND9z9/036VMeBHovpN0GVyvnENzAbFqG7uu7rH62e5ZNpytosyEEc/XKjgh3F1zcEcXFEJvQiEakmmgYYQhgUVWPXEBM+QsyG6N3xNH6oPhFwW2zPpKMm0fLUW9ZSXMJg9GeVZjFUZvesm3n5VcKZqws21+NIP5DZ+GbsMVf+Zg0TH/0rp5XrIRlOp5dWmSZZfaGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRql1bTIBGudgYRR3QQnb9xOmDNINWLJGyJxA4sH8QA=;
 b=SN3yFOJVyUCz/FogLgnY4mSxV3p7F5fDW/vrzoOW0EC6IEfepdXTVwADOggjhuLhihnY/jJLiZEBOZrMS85zZuYB7dPDujXaAGeqNc3ywgJ80DjYw3mT/RHPGmMbaEOUy2IL0T0Nq3k3MvLYrKA3vIMbScs9FYpmReZVjWJtgXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:21:29 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 14:21:28 +0000
Message-ID: <bd1ecb5c-156d-4f07-8e72-f99c7f932ac1@amd.com>
Date: Tue, 1 Sep 2026 21:21:17 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 02/24] iommu/amd: Introduce vIOMMU-specific events and
 event
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
 <edbd2471-58c4-4166-8692-d4d03a7486e5@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <edbd2471-58c4-4166-8692-d4d03a7486e5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: fd73aa9e-d3e6-41cc-6da2-08df08345039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4FeicWaQZc/X0mPvP7rnps2uN/GFWoledfigQcZcylA/E4XpwQf87G5nl9ISYf4EdxyYkKIj0fx1GcSeTDt5Yyspkweqr75eFLm9XPMjAj4WXToOqZ4Vi5jN/7nUqT4ktWcopMr42kawlSq7rrjSXUfG7wCrFqtVh14vGBQf+XpMRI4iSqKsYPJ3IAF3+rTwlJUG9Hi/1ufaKxtIvohFtYQJVU1RjoGj7bgW5/PHKPV2uoZ2zaCRJLv9o6MtSKv3EF0dzXRMnjqfqEy5piOWjR5TJ90Uy8gg0jKwFLIoGzfuPS7QIbkR55KnsJvYl2PiC6k0v5opSFlhg7FDy7GLW90wSSzuS4qDQY//4vj6MoSFtljmPacbJOibllbq/pZuQKWV9vq3xkF85dqZ0ZsJqtMBJMep91p3yPmtJjsnT2fdnuUjlRqu751TBIbeLb6Oz9VTKzlahQnAEu75zSxzDBl/xx2XhgP0yeb9bf/9s++hLwrNS5RYUPy2TViI7q4i42BZjUng2vBVVsqncNV9vYBipKATSUY3d+nclmDcnHYxvhe5foeZYFCe2itgrNPgz90XtfoHoJXwXZpxmi+NFPiyZqTHGeefeDTQVjgYRB6ttDzuV0ULwaVtjeyB9J0g7ytz+GJ+vemnayB7fYBA9KvlJ2XkI4smqr9HeIDjQHs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXMyblRuSDFCbXkzb1J1dGZsU2VuNy9oZVFmclJzaU96QlBPVjJ5Z3JwWEFw?=
 =?utf-8?B?Z0FHaWNoL0Q3RXZ6UlAwM0JkMGN0UXFNdHUvRTJlM1pYSDg0Z3p5QWJqZW8w?=
 =?utf-8?B?aFY4LzZUcDViUFRWVjI4VkR5TVdhL01IcGVWcEd0WjVvT3Ywa0U4NzRUU1Jo?=
 =?utf-8?B?OXBEVE9lZXA2ak5aY1g3RVduZTZ2WXJvWFd4SmpyamhYYitGUXBmZExDK0hx?=
 =?utf-8?B?MkdobXZwMnM0QmRvZTlMczRBVjNlOUhKbUNIRHlXZk02NlMxekU3MXJXWFlY?=
 =?utf-8?B?MDkxcHN5cUVyWG9DVWpaR3ZpcUZ2cXpxZStvVTFWMHUyL2RxaU1rTGtUWC9P?=
 =?utf-8?B?a3BQVmRrSHRZN3lkTFEySm9MUGJ6OWdpZlFrbUMraGhHTVlFa29iRms5QldE?=
 =?utf-8?B?TG02QmJNTktpMDZTM0lCbTY4VTcyZHZCSDROeU5hdSswOVgxOGlxbDJwZGxt?=
 =?utf-8?B?cWUwZjk0THB5cG1sYk5sdCtPcjlwSEJxTDAvSmRuVk1RcnorRmhjeVZvc001?=
 =?utf-8?B?dUU2QUlycGdBNDdWb3MzMTVoRHAyaEkrSThRTmNDWXJKY3ZUQ2tRdUNlZHNN?=
 =?utf-8?B?c2w0ZVRDOWhmTE90N3AzTGpjeXlOUHo1Zkc3dERlOXo0enNhRFJ3eERVRE9W?=
 =?utf-8?B?Q1ppT1lVRGdCMnpzNWRtTlJ5OFhvNHRqaWtQSytXeGkyV29rTi9WWGpLSXUx?=
 =?utf-8?B?TFg0NDA1Zm9UOFZXaWJ0Uzd3ZDRMYXBKakcvMmNxVzhHdmRhMHQzR2FnVjh4?=
 =?utf-8?B?bW9IcHpJdEZ3UjFFVC9jaXBORVZEMW00UElHQmFPZkNSTDE1QjBkYlpWU2FC?=
 =?utf-8?B?RXhuSGtQSmVZVHVmcG82cmVzTEQzbGczYytWaFVWU29hNmtmN0Q0aUljb2ph?=
 =?utf-8?B?WW9zOGxzekE2Z09wSlgxMklWOW8vejZ4K01XZXh1WU9Bc0h1WVR6YU5kcXA3?=
 =?utf-8?B?QzN1WG02SGIya3crVVg5QjNubHkwZzExL0hRMytSR1lNd3lPNzRBVkVLNWRM?=
 =?utf-8?B?cUdpREV1bTBsZkJOcnB2RVNyaUtnV1JVMUpMVjlIcDF1TVhPbkUrakdtYzY1?=
 =?utf-8?B?M3F5aWU5YUtVaFRMcFU5elQ0d1dpZ1FwVWhhYS9OdXpZUExqQ2hkbWlzRFBv?=
 =?utf-8?B?SU8rNjI1UFR4STREbkkyUisrRGNwS3Npd09JS3ljWG1vTzhVNVhPK2JrRHFy?=
 =?utf-8?B?M2Y2YStRWll3RGt4bVV2djFKbmphV3EvVUhxOUR5bHA3NndBUEEvTzVoTHFs?=
 =?utf-8?B?YmdRM1BIdzdZMnRaaWMvVXBPVjNjQk04dXNYWVJZS3pocDBNRnZyajN0RWh3?=
 =?utf-8?B?cmExRStDYVFTaEYrazhzSk05TmZINnAxWWExTVBldlJQemNYTitMdWhHSlJN?=
 =?utf-8?B?VE54V0EvYnQ5cFV5bzFSeFFmRGhkSk5hdUVScFV4U3lBVG51bEIxcy9XWkFC?=
 =?utf-8?B?V2ovUWtFQ0dkWCtGTDVrdkJERnh6Vjd0TExIZVBmaXk0OWt4UEczS2g3eGpD?=
 =?utf-8?B?TzJEOHF2NnpTSkhFdW1YODF6NEswNHMvREY1WDZsZHpCZmVMTmdJSlhObnZs?=
 =?utf-8?B?S3dtYmJpWnVuODgyekcxMFN5bVVyQ3dzZEluT3QwekZRU2RHZFJtNVVOb0lw?=
 =?utf-8?B?M0o5eTJWSDd6N3k4eFRDQmVSRTlXNjVqUGc3VEVEK2hWVTFrSHRPU293TXhE?=
 =?utf-8?B?V3Rmdno1ZFdHM29YaWxmclgvL21JN0taUUpKc2NiTHRtalJLY2dHZk1ydkhw?=
 =?utf-8?B?aEZsMHFudzNoZFNnVGZjbWgzNnVLK3c4T2dZMUkwaVg0TUk2Mzl2RUlKSXR4?=
 =?utf-8?B?V1FpdyswNWZUd1RyLy9FSmN5TzlvK1FuV3lyR0ljcGpleHQrS0w3WXNwc2RL?=
 =?utf-8?B?dDF0b25CdTNqM3NJdWt0Z2FYMHQ0U2dmb0M3YnpSM1VFTHp4eUUybnNDQ3o3?=
 =?utf-8?B?bm1CMnphazU0MFppa252eFVEMUc0b3hEZ1lkbk1KTmExbGlHRE5kUk13UVRD?=
 =?utf-8?B?VlFROEFTRWx3dTJ0TVRqVEpOS2lOcUVIY21HWUxjcmJZS1VFbktXRDczV24w?=
 =?utf-8?B?K1kzY0ZuSkdHUnFIcCtaNGIwZm1wV3UxcGkwMG1OUlp0QTlTUmU0ZlNFQ2NE?=
 =?utf-8?B?T3VoTWM0VDdZK2FkZWJtejlGNHRFeUxWb1J4Y2UwbjUvdllyeEpUUWhVSUsx?=
 =?utf-8?B?N1Vna0gzSUl4TkhDSXRzMnpzV0w4SkE0MlFoVElxMTRETExoYUx2Q3AzNU5I?=
 =?utf-8?B?ZWowazB5UVNmODhwWkZKR2lvZW5GcVdWanE1Q2dZQ0xlNTM2aXhhUHFGSFJ6?=
 =?utf-8?Q?3S534GsNQ26+GPqqlu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd73aa9e-d3e6-41cc-6da2-08df08345039
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:21:28.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLWIXF0lEOLYlGvODBIjlfjVcqRF6a9a+ppD00CDbNJgFm5B9gWDrxjCB3UejfyfHSLpKgngVFNqWZM392ZagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286



On 8/19/2026 3:17 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/7/27 21:28, Suravee Suthikulpanit 写道:
>> .....
> 
> Additionally, per Section 2.5.12, a GUEST_EVENT_FAULT occupies two log
> entries (paired event entry). The current iommu_poll_events() advances
> by a single entry per iteration, so the second (paired) entry will be
> misinterpreted as an unknown event type on the next iteration. The
> handler should consume/skip the second entry.

For GUEST_EVENT_FAULT, which consumes 2 entries, my expectation is the 
driver reports 2 events in dmesg, which are interpreted together.

1. GUEST_EVENT_FAULT: handled by the case EVENT_TYPE_GUEST_EVENT_FAULT.
2. The injected event: handled by the corresponding type. (not the 
unknown type)

However, I can modify this by letting the GUEST_EVENT_FAULT event 
handler consume two Event log entries and report raw value for the 
injected guest event (i.e. the second entry).

I'll send this out in v5.

Thanks,
Suravee





