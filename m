Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158D15749E
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946331; cv=fail; b=IZn0UDnxiLiNKNu9pNZF3eH7th+XeO64c0zwtK7ashoQRpxfB2atpbm8gJB8+XZxgjpBd/sZ/Hs9I4lzwzn3mRFS9fXOYr2Op9t6JUscsViBCItsuQAX5kqZbz9fp3RdQ2o4xHAjGVSvEzTJ1KlsT1SfKHyQ+YQgKiF/2eK9gCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946331; c=relaxed/simple;
	bh=vhf9x4bmMJW/Ga7Cvq6bInofdhYRNuP4s1JLxoVgHYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmDW9SGN5mcOb71vVqPntA0Ghfjcr0c7hMfpGv9o+X/phwgI+WCHJlH1+yT2GclGvldxG8CStqbTn95Fi4SnwTymLCkxD8HW73Ewrco1qVKyiCcf2RKFXm8Ed3sPiDrViQvFjQl+olIJymhGRVO54n4I/4IrRJXrvHzEqSuyh98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRODnLNC; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRODnLNC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoHnGFDYYIo8sP9X5mM1aH4Gg0QY0RpKep4LGsZzQIhtHs13HiZJ0DvVvAgk0yvwAh2IQPAAKPsmn6Y9faVSi3Pcld7iEGUqfkKXuZZwrxKkwHnySukZKiTEqzUCbWKhcoY1zERVb2ndMhFzvbFl6bd2XtbFDb5IsSxCHazxThaP7djf23D+BwpRjxTl7uqrZcjKskbWW9Udbu3J9SUEW+U2TU4kz9NR99X9MmKAms91/NvjGzYDKZXzRGnYcsi24GddrHJSB8SeUFZ3VEH4bxXZsPDWKRsh7HKtMH7QCYfg6rcQrfjAXixqFZPYyuNwI4kmjIildM72GBpzR+nnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvIXGMEresFX2oxFL6PbU14BRTjLUXPkYwdhYOhbsCQ=;
 b=cUH+o00eixb5jwnmj1VtYbKkXWOODn3cIXUt/G9I3897fZ7VqhrfVvRqXnwzhIb5BRJEZ/r6XcRClIMXRYnFq06N3X9c4araFFl1H/7M9doRry3IeCuo+t5/+tplIy43Q0tra9dcl01uqggTIxCAodlm6CTpAkX9NPy3gvVCcwzrn9bLxxw5owTTo3ow6m8vS8QHj1yQ/afHWZ2kKE/ysyT4wi02Vpilm0oa8vq4XKfLxwpuHU6NBEZL6LPZ68cvzn1qGSscWokj/psd+kVt54vNqdNikN3AytWrhyJgNzyHChzljh1sBVoNzWyAaJg5aORGqQ1LwlxSKwWAaE5wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvIXGMEresFX2oxFL6PbU14BRTjLUXPkYwdhYOhbsCQ=;
 b=xRODnLNCeZXLHZ4EGVS94/nW/fevO5YsfXCS86zu7Dqx7Q2wQXtsB+X6Svj1N+thTCWYlK2pM0PZKvKUMQNCrwTFOLwbXYgELYBXurGC3TEjhmOiwqSsyUlvKeVV99mqjLJdqNxA/dpckiQx/1MPWOPLNk8dORMCads/+W5xPjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Wed, 24 Apr 2024 08:12:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:12:05 +0000
Message-ID: <c255ccb1-68ac-485b-807e-a4c38786f116@amd.com>
Date: Wed, 24 Apr 2024 13:41:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Enhance def_domain_type to handle untrusted
 device
To: Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, alexander.deucher@amd.com,
 baolu.lu@linux.intel.com, Eric Wagner <ewagner12@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, stable@kernel.org
References: <20240423111725.5813-1-vasant.hegde@amd.com>
 <6552a5bb-0481-4a0c-a587-84275ab3a179@arm.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <6552a5bb-0481-4a0c-a587-84275ab3a179@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF0000017E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4e) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afa48ac-0bc0-4a0b-0e43-08dc64363a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUZTWFpBWk81dDNvM21uWWl3Ty9mSXAwTTM2WFpWcEVLblNSRGZvMlpIRnZJ?=
 =?utf-8?B?TVhiTldKWHowbWNnOWRsNEJvSGFGZThYYVhOSGo0QnpBY1pPeDIxSVBDQU9T?=
 =?utf-8?B?by9yaEZDa29TTm5sMDFxMW0wdmFZamZOZDJnVjZ6bDNuVmJ1bk9ZWnlXNFA3?=
 =?utf-8?B?RE1FdDIrVlJMZHN2U0Z3aXJGcE9lN01WZmE2MkZaVmg0M3ZTL291YmNFb2k3?=
 =?utf-8?B?WnY5SEtQVE5oM3RaTTBOOFcvZE9xQlJTZVlxZURtME5oOWtzMEEzRFpGb1dp?=
 =?utf-8?B?Nyt1eWV3anVLSVRUeFhDeUVRRXh2Ry9FSTZFejFOTW40WGNZRGhLdjVNaFd0?=
 =?utf-8?B?a0RZZFpIcVo2SWhiWjdoZzJheS8rYTR4ZDI4YmtDRStmQjRJcjF0SzI4V3Na?=
 =?utf-8?B?Q2EwMmxDcW05ODdiRjRJb29uT2FoaEJFUlhMUmkvL0w0b1lKYTlHaStPMzcx?=
 =?utf-8?B?L0JXamVLd0tOcnkxbXc2YnJaZ2ZOZkRteDJEZVFQeUp4eGd6TTB6cExuQ0hS?=
 =?utf-8?B?b1JrZ0ovalB3cVpLYk9KWWV4dHJVUmdnWG00QmpxeThMRHdMS2sweHZtZHVV?=
 =?utf-8?B?eWtXbjd1NmZyMzVYOVFqZng1RjhhakdxbmJkUHJSS0YzS0VRcGw5bjZtTGJI?=
 =?utf-8?B?Wks0dzM4Z1o5VjdhVis4UytQbk5VZDE1bWhrRXE2OHFEbWlvVDN4TzNFVlQ3?=
 =?utf-8?B?dWZESDlZc2pHakZnQ1FLYVpFMnhEcUtFOS85RjhTaWZKZEdkNzNCOXhxZjRC?=
 =?utf-8?B?MWF3dkUzS0VDeXFxV3ltZGRMck1VZ3NSdXRoUWtmVzZzM0xMQXRwZ3dHcTg4?=
 =?utf-8?B?cFNYNkl1c3poTzZJdnBoNkdaZUt4R1hPVmtqWFR3dFZCYm9FTTl3WENaeXZr?=
 =?utf-8?B?RlBFdk5qYXVuM1BpSTNnNEVYb3ZFRW5IMy8xbkdvemNUdkNBbEJwSnIxSWlz?=
 =?utf-8?B?YXMzWG04YVU5OXFtRVJDNCtYaW04Q29KWWNPL3k3N2tMR3ZFOVp0S2RGT1Bz?=
 =?utf-8?B?dEIwdS9FcFUrYjVZV21IQUVYcW5DcVU1MVlHYWFWTDl1Z213YTJGSUhRUVZk?=
 =?utf-8?B?cys1L25pSzRZQnl1MCthWUlkQzlBdDNLSHJiZE1vUU1IdzQ0S3ZmNU44Y2I1?=
 =?utf-8?B?Y3IyYThkN1A4dElobzdLMEtKQXJSak1HdW5OTjRFRWk5L3RyamE4cXBGcHRa?=
 =?utf-8?B?TjZ0cExUUjVubmh6K29uc1ZEVzN1bTRlS2VUelAzaEJUNEVDbHArTmp1NGtp?=
 =?utf-8?B?SnNCeUUvRmJSWUN3d25lMnJTb1RiNEU4UDBOMUFCYTRReU5BQTFiVjg2c29w?=
 =?utf-8?B?NWEzcy9pdDJGODFGaWYyRHY5UDRoSDI0dDZLekFOMVNOUDNBOFJlZ0NpOE5E?=
 =?utf-8?B?UXIyZ2xITHR4cEFjNWQ5WEpybmNSdDFkeFQzTEZTQVdPYlhMTGJRamp1WmJo?=
 =?utf-8?B?TnRIOEpTWXpRc2ZyZXUrYUwrbTZsSUp6MkNWTVpFYmFkTk5WUzNKbHg0Q2h0?=
 =?utf-8?B?TTZweFFmMFdCSHFPRjBIelNPQStVWWdUaHM2cmZBbnNKaWNJR1JXNk0xTW5D?=
 =?utf-8?B?ZDFPdzNxOWN0Lzc2MjJqOHVmS0JFejhwUXovQkhCdHVkdUxYZnJHd0lJMTlO?=
 =?utf-8?Q?kZOS09u/la2yAPAcatNAsoWiwx5S938DbBmvdYJ0+xFo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHJ4RXJMRVY3aXNZVnZWMzZlWEVuRE1QS0M0SmY0RHlFdjl0YTBjR2hncXRK?=
 =?utf-8?B?V3V0NGJOK1lPZTFLM01JNzB2SSswNjRIS0w3MDhYWUYyd0dWU211YmNPSzEr?=
 =?utf-8?B?L0FtWjg3YU9iNlQrWDc4bHNaK21TNFFrV2FrZWxxWWlHcTZxRWo0NVFoZlNs?=
 =?utf-8?B?cHN0YytwRklRWFREbmtrQkZ5RG1GSTM4VG9ocnZReitwSWE3aG9IaDJRNngz?=
 =?utf-8?B?bXdGaFhiMTFrci90dkZ0U2llbTRVZDJmOGxQKzZmSDNFSkJzaHkzMm9zekw4?=
 =?utf-8?B?Z0JRcmZuWmMwZW5qWGRYRkpHRStCcitiMnEzYmhzRXFuNzd3Q28vOWZobk5S?=
 =?utf-8?B?NnhQZ1VpSGdlV0dZMFVQWUZTQmFEWnhpQWVQYWhROERCeXRuSGhZTUhHcjZO?=
 =?utf-8?B?MlpIdkVSVXVHQ2l1Qy9XREdicWdSWHJ5QXN5WVIvUFZNWXMwR0d0VGFUdXNB?=
 =?utf-8?B?aDFSbk01WU9oKzBERnRENDBtYW9ET3c1WG1yWFFCTnloT2trNzZyRXFQdlZQ?=
 =?utf-8?B?djNhUDZMbmJVQytuSnE4RE41TXRFanBhdVJUeEdxVTlySDQrK2dIMHVqZW9S?=
 =?utf-8?B?RmVKN3dwMFRYWEx0ZGd2RXZxSU4xejVEVTl2MlNMWDZvQVJOZWNvbVhKNFl4?=
 =?utf-8?B?bEw5UjJnYk9UdTc0alVEUGVrVklNWEV2ZGhJUzltS1dsQnpLZlJqTzMvRkF1?=
 =?utf-8?B?OWVEM09QcFNWeFNzdnp1NHgwNXZnNFdCdUFScXdLWGo5bUJRU3duWE1GTzBz?=
 =?utf-8?B?N2FnekZJcFZoczdta21ITlc2L0kxRDArVjlxWUZobUtHZTNkUHJ2ZTh5Z0o3?=
 =?utf-8?B?TnU0WjR0NEZORkF4S3BmWldyRVFpK0gxRVUzMzdIRVE0QVcrWUFKM2IxcTJI?=
 =?utf-8?B?NnNFeXN4SG05TWtDMGgwclZmR2VZNTRKUklJOTRldTBEbTEwTVk0dWpQd2RQ?=
 =?utf-8?B?eGlZRjRVMnVWM3R0cWRDaXMrUHN5eUJENDBHZVNVYnNJTC9GMmI1dXcybGM0?=
 =?utf-8?B?aGZZaElGOXJQOHZNNjM0YStMSGNCUWU1dzh0TUpCRGpWcUxuZHRFMDBtTCtP?=
 =?utf-8?B?d1hZYzFtd2VaNmxHS1cwVm5RRDdVY29UaS9IMjJjVlhUbkNEUDZpcW14MlBy?=
 =?utf-8?B?WUlxMGFHVDBmZldOd0lyc213Q0VReW9ScnVmeHpFVUJ6cHIvdWRyZG9PaHo4?=
 =?utf-8?B?M0tHbnZZMTI1aHFsMHpMU3ZySEp5azFuL0pEK2VhaEZVV0xuWTJzbU53c2Yy?=
 =?utf-8?B?SW1IYjlTcUpxZXRpZ1FiMitkeTM3aVpMc2VtSStiUnNpbmgvazVIcGpxSmpT?=
 =?utf-8?B?b2p1ZmZmUzA5dEt6anErUzFobHRyUUhqalQvVnRYcmZ5dDhEcTRoaktMTVZq?=
 =?utf-8?B?NW1HbmtEMmhJQldZVDFpZHlySFdhUHFzREhIOFhOM0NkWEkyb3dDRDJ2SFMy?=
 =?utf-8?B?SWYrNnNpSnRMa3d0MlZia1gvVGtCa3R3aDVjNmJHWUVMaW1YTDZ1OFRVTkYr?=
 =?utf-8?B?QzRES3E3TzhNZ3JGOVJxcUZyZVpEdFF6d3MrNnZSZHRkOGNqNE45VnlUTFI2?=
 =?utf-8?B?N1BzNG1ycFFKbHozam1BeU00K20yS2FaL0FiYUtXQXVhc1JNc1NWSkVkSGQv?=
 =?utf-8?B?NU40cjR1SWdaNnNXNlNJbkc4SlE5M1p1MGE1VzlnQmRXb2VScXYzK1BCbW9S?=
 =?utf-8?B?MWY1aTF6cDB5YWwwMm14NmJCWXB5U05kMXF5dGFjenErVWU5Z3owZmZ5Uy9r?=
 =?utf-8?B?UDQwVkpNOUlaTjN0cDBzOWdmb25USEFRb1pCTWhDS1pxNHpnZ0doa0JCN1BF?=
 =?utf-8?B?YUdZWWhCZE1RM3AyMnFpNzNSaVk1Q1hNcHF0b2JYYkkxRVNrbXlLNm0zLzhE?=
 =?utf-8?B?K2c3bVFMemZNaGp1WXhNQ3RYSHQ3MXpLVlU3ZDZVczBXN3pxMzd6Z29Ra0Ji?=
 =?utf-8?B?YWxMeWRObllqWmt2Zng5Qmp4S3EwZXdjanZRODZiMk1iUGpuMDg3ZFZlcy95?=
 =?utf-8?B?ZDY0Nmxibm0zMzFLWnBIUzUrUlVSUjhRclErdDlEU2JMYTlqLzIvMXVxRDdz?=
 =?utf-8?B?VWNHam8yVlNEampvMEg1UTg5aCtBckdDbElQYTJTVTZZK0ZaU3h0ZlRTb0RV?=
 =?utf-8?Q?iwaj+9cXzG9u8mYD6Ji7EiEE6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afa48ac-0bc0-4a0b-0e43-08dc64363a96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:12:05.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzl5WXHV0m/wcZMgxoHP+xJQp0ot5BbLf18nfK5at+CCNBYfaHX2+pmZhAhKz6MvAGMvpFzjXGi8z+ylbmAPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

Hi Robin,


On 4/23/2024 4:56 PM, Robin Murphy wrote:
> On 23/04/2024 12:17 pm, Vasant Hegde wrote:
>> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
>> untrusted device. This always took precedence over driver's
>> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
>> iommu_get_default_domain_type() to respect def_domain_type()") changed
>> the behaviour. Current code calls def_domain_type() but if it doesn't
>> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
>> results in IOMMU group (and potentially IOMMU itself) in undetermined
>> state.
>>
>> This patch adds untrusted check in AMD IOMMU driver code. So that it
>> allows eGPUs behind Thunderbolt work again.
> 
> Sorry, but I firmly disagree with this approach - regardless of what the AMD
> driver is currently doing and how appropriate it may or may not be, we should
> not be duplicating core code policy in drivers, and we certainly shouldn't be
> doing so to bodge around a breakage in how the core code implements said policy.


Ack. I still think fixing in core layer (what your patch does) is the right fix.


@Joerg,
  This is alternative to Robin's original patch [1]. If everyone agrees with
that fix then we don't need this patch.

[1]
https://lore.kernel.org/linux-iommu/fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com/


-Vasant


> 
> Thanks,
> Robin.
> 
>> Fine tuning amd_iommu_def_domain_type() will be done later.
>>
>> Reported-by: Eric Wagner <ewagner12@gmail.com>
>> Link:
>> https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3182
>> Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to
>> respect def_domain_type()")
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: stable@kernel.org # v6.7+
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>> Changes in v2:
>>    - Added dev_is_pci() check - Thanks Lu Baolu
>>
>> -Vasant
>>
>>   drivers/iommu/amd/iommu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index e692217fcb28..fb727f5b0b82 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device *dev)
>>       if (!dev_data)
>>           return 0;
>>   +    /* Always use DMA domain for untrusted device */
>> +    if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>> +        return IOMMU_DOMAIN_DMA;
>> +
>>       /*
>>        * Do not identity map IOMMUv2 capable devices when:
>>        *  - memory encryption is active, because some of those devices
