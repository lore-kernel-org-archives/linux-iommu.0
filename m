Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF23D1AA6
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648890; cv=fail; b=F1G7DsmVNODgKTKTAPqt42DaoK+xIil3QIk7MUCSEnqs9TR/LBLjZrvm59wswpDd2/llJE36zlDc1i2gWwz5amAejfQ2BJ/ZqxlCq0tu5Z1WJuC9/lwYDZE6bgC6wPvwJUlBlStHHjcD5b2q6FfpN9LlMDlaIeLGPwB8IVOSzKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648890; c=relaxed/simple;
	bh=SWzHzGaHcmW35/JkR2ixDBjdY3T9akWiyeyWa/5c2Vw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAO2ita4fKr4cNrJw/mrkSf7a1riNa2Sl1h1YXojUm073BjNxaPO19XwQkoc4BpWpPyv7nDRnYqipG5ffe7SC9QIPgox6aIzixpcgqceyWgPosqrXLACzj1IFLXG0ojKSLbo+WsmuTSThJYz7LuOzkyxpyVSQTNz45wKcYDuwu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4r6oHRA4; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4r6oHRA4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydYE2V/UKjpKpCL33jntlITd4YBi2XcpZM9cyX5sTL1x4fEcjiNQD70djDNkXTb8/u+fA9CWlm8Om+cdEFklJjyp0T/MrEM/wm/YtlS1lyNXafD2s07ZoEoKAI/cqMYb8EUlzypC4j7Kr8lyHYn6UHE+WJNpA1/GQVwItMDxkFiF/Y4bxkMn/vNHttzzxCoYA/137Gmk2pL1z9CF9VY8wBAa6BM+HUt9BMdtyRk7bUyzuk0E37b70CiGLcRUbC77dwRhFH/WPzQRyb82KvHHhSs40Qd7w6oLdav5DxpzxlyB02v9qXPOLnSL4qrhY4VtiJvasG11xm623cggRH002g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyDHHHSf0UtBV6p6KYKN1Hua6o4UtYORS8OTSeUHXl8=;
 b=tapKOXFBi++VDTnTQPiH6Wcy4y/lR9NXHYA0k+cGuJqMyz8FnJxJcE4qfQvdh1faZbquPd8XXejTivmYZXw1+WdcYnpuluJwQ+oUT3B2eHxGc72WXsKBB/KpgrD20CpfSqCXdmt5zojaLt1N3lP+oeei+EXaTf8TpgHfRHMXzn93J2iNaGsDHnQwW8DMG3VRfWSZQYlLH+RzLNM9NcZJv6ToX3vfZrBtRxsMP12RdZvStWql5rN/PFDE+9Fkj/bFrPuIy1HboVo41dfbM9cjlQ0onzybOUbhUF6ZIk0/jUHFGgEZK4eJ/dbCmxZ7l8NIaHrERGpKZ2hA6Um2btefMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyDHHHSf0UtBV6p6KYKN1Hua6o4UtYORS8OTSeUHXl8=;
 b=4r6oHRA4FBs56PkkHOkFv9WDOJBfLU0+HMgV0U6bGIHMb/En1EutAxm7Zv4M8NSQY/+3Hcw2b41HlgA9W8GoVFrqbJ6dRU/pbU22YpHdn9HhP9uUhyVDkFw9Rv5lHktTj7+xsAhaOA/oGWbifYOH6w+t3AdnJRdX2birlzY04gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 08:41:26 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 08:41:26 +0000
Message-ID: <ef7b06e0-481e-4ef2-adfd-5fc2c59696d6@amd.com>
Date: Fri, 5 Jun 2026 15:41:17 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 00/26] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260601133031.GA403363@nvidia.com>
 <592389f0-3068-4b7d-9999-5fd188dfb293@amd.com>
Content-Language: en-US
In-Reply-To: <592389f0-3068-4b7d-9999-5fd188dfb293@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::14) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfc3deb-c07d-414b-cb13-08dec2de3afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EemzsFt/9KSHXgq7hP2nBGBdvtjMatV0A7O5Tz19SuTPT8a7wiHSu1Kf7P3+d03QVz6ooFQdmN8ZKs7O6ih8eeEZQ8G86HvtWWQVjNboQbz7vGzR5BRe/nimJWzl9o0/nHCNvqzGHiUK4HRoBSdP1TZysrsKOa2JH0jKDRCEhR/EBXKrmRfz5wZ/5EpXNTiUBXr9eRyFNHE77PfT426qtN0xOvU3Iw/PCrSXn8eLU6rFRdRupA9MvIWsMMjyx6CoKZci1cXgLNDz/2dU9Nm1jg+GvydZCQVJyWjb/fD2xcJjpUXWZDteAC4h2ZSVeOzOwidwCemysVSYC23wUVBUe/JvunFyXaFVzkYlL/dOzoTtc/dxWiN6FrIT6w5cXISWlhtG+Eq4GrYxAdzsfSD/qDp3hn4J1KUVa2kmh4axuQspSy+rz8XxVbKg6v4XUuEE7U32PEQJoUekEzWrS+ABiVr3WXwd/E26HEiJLn0f+h5dav06izZTy7zhjr7yr0HOv+HOy73CAJ/sM5Rx63OLHLFyV3t1G3Z3a1iXVkqfUx27GylABlsKYZb1ZRGBuSAbyW0Iskpk/bCme1/qwjI5jqGs4PBxl2icKjlD4NkAyc2XPep2v5XdD0C0jSmIQ7I3trprpp5vkN8HPMHlKUI34tDquwKFEc5nb66bm/PPO7eVbU2TPZ2UNaQLxo5sxJVmtEBPFBuS9VvK1MMUPdy0aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFidEJ5dTZFVDJLQmhsUlBYSVNyVWlDZFlZN0QwQzc4Ykx1SDIwMm0rVUVB?=
 =?utf-8?B?cUp4Zy9MaGl5WFhGajIxQWtBUE9UNzV1TE1GdG9FaTVmWnRsNVJGdkhFSUtL?=
 =?utf-8?B?alRZb3R2S2g2UUhnSU02d1JCbDlFR0prWTVjcE5OWG40bzRDanZkNzVqS0Rp?=
 =?utf-8?B?UG9FcG9zeVFFZHdJd1E3eXRKdUpIVkMwZUZGZU03MGlkc0xjY1poK0VkT3k1?=
 =?utf-8?B?QXBYc2NJWGl4S09xcHRaT2h4SGF5MVhSRmhidmVJcUN3cEhhVW1CQVE3UlU3?=
 =?utf-8?B?eDVYWHhESW1PY1dvelhBZEVXcjN4MTNWOFVoV0FHUDMzeHRFYVlVYW8yUy9w?=
 =?utf-8?B?WDNMbUVSWE15ZDhIZTRVNDN5TGpxc1ZZUHF4M2Q3WjRWM2ZEUkxJY0JVdUxn?=
 =?utf-8?B?b1lwbnQzeC9Pdy9mUCtOZ2JRM3llaWZ5MHpGWUs2RUY1RDBnS0hSeHJGdmJv?=
 =?utf-8?B?ankwUmM0djFjTytLZWhyejhrcUhDVWU3ZzcrR1c3ZjlHYkNYa1A3S2xyU1k3?=
 =?utf-8?B?NVNSaGlSa3hRS1ptQW9QSjVZNEZRN3ZOT0VBUHljRFYxeHVqVEpza1VES2tl?=
 =?utf-8?B?RE1RWERFckhFK2ZGRTlGbHpiaTFaVUVYMFl3bndrRklIbnNIa1RXOWhsWnhl?=
 =?utf-8?B?aTJzMXNoYldLOHZORUJGa050Mmgvam5SMS9hVG5TTW1yVkxIWDlBL1EvellR?=
 =?utf-8?B?cmdGTGVoMXA0dzBPZW5aQStrR242KzFyT0FBdVplR3B6eHFJMlJMazhCVTJa?=
 =?utf-8?B?S1J6Y1JmSHYrbkM1eitVb29CcEFWYXozdjAyRk5YK3V2aC9mRmhxVkM2YkdZ?=
 =?utf-8?B?azgrZDRQUmlZQS90Yng0YjREdHQyUlQzZXdpTmllTW16NXB3NmtwdGZEclJR?=
 =?utf-8?B?UzlOcVFaNElFSlJYMHJ6aWd6TlZPR0VrK0UzOVI0dDVXczcrTk5abXFRaW1v?=
 =?utf-8?B?UDVPTWl3U3QvejF2S1VmcG9HTEU3WlNhbUNMc1czak5rVDZtbGxPZHVtbnNx?=
 =?utf-8?B?enFsU29wQVgwdU5ydXdOMUhzSVBiSm02ZmZkdnVMa1k4a2xlVXlrd1JEY215?=
 =?utf-8?B?VVBzUlJOcTh5S2JGNStsWmhPZmZYVHYzNTFGb295M2pIbm9NTWFSQi9Tbk9h?=
 =?utf-8?B?SmNZWFRmSlo2SURCQnRXUUM5dFBDeXpCMFBrLzFlbWNZNE8vYkp4L2t6OXhH?=
 =?utf-8?B?ZFlnRngzazVjSEplK09ZdXRtRllNN2c5UTkxSTZvRDBFWWFiQUtxN1hUbklX?=
 =?utf-8?B?QXJYNWhpaGoxSkNxYjh3NmJOaHJnSlJwWHFZTzd6R3VUc0dSY1oyV3U0bm5z?=
 =?utf-8?B?U0ZXUXJuQ2tJd0ZLV1RzWUsvM1MyMzRyM255dDh5SGlHYTladzVqYlhIbWdJ?=
 =?utf-8?B?T3RxQjJVUGFNdU1uSjdDN1VtR0lpa0hoK003WGJ4K29ZL0RHQm9UQVVRK3py?=
 =?utf-8?B?L0JUbDhBK2dZSllVamUxVElKWnJXbEd5VXlKSU9mcjdVM09BTnFuR0lMMDFD?=
 =?utf-8?B?Y3RreFpxbkIrWWh0K005S3llYU5hYU1LWExHaE9US09XNmwweUFLU2RLTWFZ?=
 =?utf-8?B?UzF5ZGVBQnlkcXI2YUZJeDcvcUhXTUlHalZETE5JbEQ2R2lvcVVSQ0xlRXEz?=
 =?utf-8?B?TW9acUs4Q00xN21UU2w1MGZUWWIxckx4VlVVU1NIa2dpelM4Tzk2Y1lWalRi?=
 =?utf-8?B?aHhNeFE3Titka3Z0NTFOdkZjcG9YYTR3Ti80OE9hK0lkU3Y1YmVCQ1kwOVZJ?=
 =?utf-8?B?SXFSaTNMNlhEUWN2czA4NW0vUDQ4VFBCNW1ReVh4eTlkei93VWg3Y3pjR24z?=
 =?utf-8?B?ekhWdWVNdmtOOW5mWjZOejFQblNvQW0yZFFLY1QyMzFGbzQ1Mk1BSW1VNTRa?=
 =?utf-8?B?RmNSZWhZSXZ2SlNIKzJFK2ZUZmJDSU9DNjNOU3hqZGxrcmlMWGtrN0trcVZj?=
 =?utf-8?B?OGhCMlJNd3VBUjdsMFJNYUg5SUlhTy9KZ3FPTVh6SzZ0SmdxdnhLNVBhMVpY?=
 =?utf-8?B?RHdEclV5N1NBOGJOZHkxcHpxZmJuYndXTUtFOEMyMTQwZDFjVjJBYTFKc1lF?=
 =?utf-8?B?UkcwNDBaOVV0eTlRK3BuNHpGa1JteGtNZDR3NVZ5eEl1WXZPa29scm9rY0Yy?=
 =?utf-8?B?WVBqZ3NiZWRCWmd3RlFuZnp6LzBDdFNFWEo2TmhWa0xzOE5aMDJYOFBqbGlq?=
 =?utf-8?B?cjZ1c0M1bk9GQXJmdFFPd3Fzd2RrN3FDb3ZieEU0WHdZR2RIRndZNFJad1Bv?=
 =?utf-8?B?NWNCZC9PbFY3aVYvbTlBc2RhbGZBcHQzSnh5VE5PZjd6NkcvY2RmRE5SSXJL?=
 =?utf-8?Q?l/EDF5qCEh/XGUCaNR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfc3deb-c07d-414b-cb13-08dec2de3afd
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:41:26.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRaN7el8LaSHS+XpO1frta0fGoRSIXeaQVZ5gNU3MBZmOyxkBBWdLO07m79ddIxjtw8ERvWiB8M/DzhlFnIPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395



On 6/3/2026 1:41 PM, Suthikulpanit, Suravee wrote:
> 
> 
> On 6/1/2026 8:30 PM, Jason Gunthorpe wrote:
>>> [2] Linux git tree:https://github.com/AMDESE/linux-iommu/tree/ 
>>> linux-7.1.0-rc4-amd- viommu_upstream_v2
>> Build test all the kconfig combinations, I noticed problems.
>>
>> Jason
> 
> I have build tested w/:
> - CONFIG_IOMMUFD (m/n)
> - CONFIG_IOMMUFD (m) + CONFIG_AMD_IOMMU_IOMMUFD (y/n)
> 
> And they all have passed. Could you elaborate on "all the kconfig 
> combinations"?
> 
> Thanks,
> Suravee

I found the issue. Please ignore this.

Suravee
